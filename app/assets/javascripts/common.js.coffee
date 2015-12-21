class CommonJS
  @user = null

  constructor: ->
    #do nothing just yet

  getUserData: =>
    user_name_label = $("#user_name")
    user_name_label.text 'Getting User Info...'
    api_token = mct    
    if @user
      commonjs.parseUserDataAndUpdateUI(@user)
    else if api_token
      $.ajax
        type: "GET"
        url: merchapi.host() + "/users/me?token=#{api_token}"
        headers:
          'Accept': 'application/json'
        async: true
        success: (user) ->
          @user = user
          commonjs.parseUserDataAndUpdateUI(user)
        error: (data) ->
          user_name_label.text 'Error Loading User Info'
    else
      user_name_label.text 'Error Loading User Info'

  parseUserDataAndUpdateUI: (user) =>
    api_token = mct
    user_name_label = $("#user_name")
    user_id = user.id
    artist_name = user.artist_name
    first_name = user.first_name
    last_name = user.last_name
    email = user.email
    user_status = user.status
    trial_user = user.trial_user
    expiration_date_temp = user.expires_on
    emailErrorMessage = $("#email-error-text")
    emailErrorAlert = $("#profile-email-error-alert")
    passwordErrorMessage = $("#password-error-text")
    passwordErrorAlert = $("#profile-password-error-alert")

    submitBtn = $("#profile-update-btn")

    unless artist_name
      if user.first_name and user.last_name
        artist_name = "#{user.first_name} #{user.last_name}"
      else
        artist_name = "Trial User"
    user_name_label.text artist_name

    $("#profile-artist-name").val(artist_name)
    $("#profile-first-name").val(first_name)
    $("#profile-last-name").val(last_name)
    $("#profile-email").val(email)

    if user_status == "expired"
      $("div.wrapper-content").html("<div><span><h3>Please upgrade your membership....</h3></span></div>")
      artist_name = "Expired User!"
      swal {
          title: "Upgrade membership",
          text: "Your membership has expired. Please upgrade to continue using Merch Cat",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: "#4dd888",
          confirmButtonText: "Ok",
          closeOnConfirm: true
      }, (confirmed) => 
        
        if confirmed
          $("#profile-modal-form").modal({
            backdrop: 'static',
            keyboard: false
          })
          $("#profile-modal-form").modal('show')
        
        else
        return
        
      $("button.upgrade-membership").css("display","block")
      $("button.cancel-membership").css("display", "none")
      $("#profile-status").text("Expired")

    else

      if expiration_date_temp
        d = expiration_date_temp.slice(0, 10).split('-');
        expiration_date = d[1] + '/' + d[2] + '/' + d[0]

      if trial_user == true
        console.log("trial user")
        $("#profile-status").text("Trial Member")
        $("#profile-expiration-date").text(expiration_date)
        $("button.upgrade-membership").css("display","block")
        $("button.cancel-membership").css("display", "none")
      else
        console.log("fully describer")
        $("#profile-status").text("Paid Subscription")
        date = user.stripe_active_until
        $("#profile-expiration-date").text(date)
        $("button.upgrade-membership").css("display","none")
        $("button.cancel-membership").css("display", "block")

    submitBtn.click (e) =>
      console.log("submit btn clicked!")
      e.preventDefault()

      profile_artist_name = $("#profile-artist-name").val()
      profile_first_name = $("#profile-first-name").val()
      profile_last_name = $("#profile-last-name").val()
      profile_email = $("#profile-email").val()
      profile_password = $("#profile-password").val()
      profile_confirm_password = $("#profile-confirm-password").val()

      if profile_email != ""  
        
        if commonjs.checkEmailValidation(profile_email)
          console.log("valid email")

          if profile_password
            if profile_password == profile_confirm_password 
              if profile_password.length < 6
                console.log("password length is less than 6!")
                passwordErrorMessage.text("Password is more than 6 charactors")
                passwordErrorAlert.removeClass("alert-success").addClass("alert-error")
                passwordErrorAlert.slideDown().delay(4000).slideUp()
                return

            else
              console.log("password does not match!")
              passwordErrorMessage.text("Password must match.")
              passwordErrorAlert.removeClass("alert-success").addClass("alert-error")
              passwordErrorAlert.slideDown().delay(4000).slideUp()
              return

          $.ajax
            type: "PUT"
            url: merchapi.host() + "/users/#{user_id}?token=#{api_token}"
            dataType: 'json'
            async: true
            data: {email: profile_email, first_name: profile_first_name, last_name:profile_last_name, artist_name: profile_artist_name, password: profile_password, password_confirmation: profile_confirm_password}
            success: (data) ->
              console.log(data)
              if data['id']
                swal({
                    title: "Success",
                    text: "Your profile has been updated.",
                    type: "success"
                });
                $("#profile-modal-form").modal('hide');

            error: (data) ->
              console.log("error_data" + data)
              swal({
                title: "Fail!",
                text: "Your profile can not be updated!"
            });

        else
          console.log("invalid email")
          emailErrorMessage.text("Please enter a valid email.")
          emailErrorAlert.removeClass("alert-success").addClass("alert-error")
          emailErrorAlert.slideDown().delay(4000).slideUp()

      else
        emailErrorMessage.text("Please enter email.")
        emailErrorAlert.removeClass("alert-success").addClass("alert-error")
        emailErrorAlert.slideDown().delay(4000).slideUp()
    
  checkEmailValidation: (email) =>
    
    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
    
    if email.match emailPattern
      return true        
    else
      return false
  
	stopEvent: (e) ->
		e.preventDefault()
		e.stopPropagation()

@commonjs = new CommonJS("")
@commonjs.getUserData()