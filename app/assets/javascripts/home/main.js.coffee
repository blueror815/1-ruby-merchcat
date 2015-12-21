String.prototype.capitalizeFirstLetter = ->
  this.charAt(0).toUpperCase() + this.slice(1)

class MainJS

  @description = ''
  @title = ''
  @channel = null
  @pcode = null
  @email = ""
  @new_pass = ""

  constructor: ->
    #do nothing just yet

  bindSubmitModalAuthForm: =>
    authFormMessage = $("#alert-text")
    loginAlert = $("#login-alert")
    submitBtn = $("#modal_login_submit")
    spinnerButton = $("#modal-spinner-button")  
    submitBtn.click (e) =>
      console.log "Handled via JS"
      mainjs.stopEvent(e)
      email = $("#modal_email").val()
      pass = $("#modal_password").val()
      if null != email && email.length > 0 && null != pass && pass.length > 0
        submitBtn.hide()
        spinnerButton.show()
        mainjs.performLoginWithEmailPass(email, pass, (data) ->
          # Handle success
          window.location.href = 'dashboards/dashboard_2'
        , (data) ->
          # Handle error
          for k,v of data
            console.log k + " is " + v
          $('#myModal').modal('hide')
          authFormMessage.text("Sorry, an error has occurred. Please try again.")
          loginAlert.removeClass("alert-success").addClass("alert-error")
          loginAlert.slideDown().delay(4000).slideUp()
          submitBtn.show()
        )

      else
        authFormMessage.text("Please enter both email and password.")
        $('#myModal').modal('hide')
        loginAlert.removeClass("alert-success").addClass("alert-error")
        loginAlert.slideDown().delay(4000).slideUp()

      setTimeout( =>
        submitBtn.removeAttr("disabled").show()
        spinnerButton.hide();
      , 2000)

    false

  bindSubmitAuthForm: =>
    authFormMessage = $("#alert-text")
    loginAlert = $("#login-alert")
    submitBtn = $("#login_submit")
    spinnerButton = $("#spinner-button")

    submitBtn.click (e) =>
      console.log "Handled via JS"
      mainjs.stopEvent(e)
      email = $("#email").val()
      pass = $("#password").val()
      if null != email && email.length > 0 && null != pass && pass.length > 0
        submitBtn.hide()
        spinnerButton.show()
        mainjs.performLoginWithEmailPass(email, pass, (data) ->
          # Handle success
          window.location.href = 'dashboards/dashboard_2'
        , (data) ->
          # Handle error
          for k,v of data
            console.log k + " is " + v
          authFormMessage.text("Sorry, an error has occurred. Please try again.")
          loginAlert.removeClass("alert-success").addClass("alert-error")
          loginAlert.slideDown().delay(4000).slideUp()
          submitBtn.show()
        )

      else
        authFormMessage.text("Please enter both email and password.")
        loginAlert.removeClass("alert-success").addClass("alert-error")
        loginAlert.slideDown().delay(4000).slideUp()

      setTimeout( =>
        submitBtn.removeAttr("disabled").show()
        spinnerButton.hide();
      , 2000)

    false

  bindSubmitContactForm: =>
    authFormMessage = $("#auth_form_message")
    authFormMessageContainer = $("#auth_form_message_container")
    submitBtn = $("#contact_submit")
    submitBtn.click (e) =>
      console.log "Handled via JS"
      mainjs.stopEvent(e)
      name = $("#name").val()
      email = $("#email").val()
      message = $("#message").val()
      if null != name && name.length > 0 && null != email && email.length > 0 && null != message && message.length > 0
        authenticity_token = $("*[name='authenticity_token']").val()
        $.ajax
          type: "POST"
          url: "/send_email"
          dataType: 'json'
          async: true
          data: {contact: {name: name, email: email, message: message}, authenticity_token: authenticity_token}
          success: (data) ->
            submitBtn.removeAttr("disabled")
            authFormMessage.text("Success, your message has been sent.")
            authFormMessageContainer.css("background","#67C478")
            .css("text-align","center")
            .fadeIn(1000)
            .delay(2000)
            .fadeOut(1000)

          error: (data) ->
            authFormMessage.text("Sorry, an error has occurred. Please try again.")
            authFormMessageContainer.css("background","#CF2300")
            .css("text-align","center")
            .fadeIn(1000)
            .delay(2000)
            .fadeOut(1000)

        submitBtn.attr("disabled","disabled")
        authFormMessage.text("Sending mail...")
        authFormMessageContainer.css("background","#67C478")
        .css("text-align","center")
        .fadeIn(1000)
        .delay(4000)
      else
        authFormMessage.text("Please enter your name, email, and a message before submitting.")
        authFormMessageContainer.css("background","#CF2300")
        .css("text-align","center")
        .fadeIn(1000)
        .delay(4000)
        .fadeOut(1000)

      setTimeout( =>
        submitBtn.removeAttr("disabled")
      , 6000)

    false

  bindPromoForm: =>
    authFormMessage = $("#alert-text")
    loginAlert = $("#login-alert")
    submitBtn = $("#promo_submit")
    spinnerButton = $("#promo-spinner-button")
    freeTrialModal = $("#signUpModal")

    submitBtn.click (e) =>
      mainjs.stopEvent(e)
      promo = $("#promo_code").val().toUpperCase()
      if null != promo && promo.length > 0
        submitBtn.hide()
        spinnerButton.show()

        $.ajax
          type: "GET"
          url: merchapi.host() + "/pcodes/find?code=#{promo}"
          dataType: 'json'
          async: true
          success: (p_code) =>
            @pcode = p_code
            if @pcode and @pcode.duration
              if !@pcode.expired
                console.log $("#trial_duration_text")
                $("#trial_duration_text").text @pcode.duration
                freeTrialModal.modal('show')
              else
                authFormMessage.text("Sorry, the promo code you entered has expired.")
                loginAlert.removeClass("alert-success").addClass("alert-error")
                loginAlert.slideDown().delay(4000).slideUp()

            else
              authFormMessage.text("Sorry, the promo code you entered is not valid.")
              loginAlert.removeClass("alert-success").addClass("alert-error")
              loginAlert.slideDown().delay(4000).slideUp()

          error: (data) ->
            authFormMessage.text("Sorry, the promo code you entered is not valid.")
            loginAlert.removeClass("alert-success").addClass("alert-error")
            loginAlert.slideDown().delay(4000).slideUp()

      else
        authFormMessage.text("Please enter your promo code.")
        loginAlert.removeClass("alert-success").addClass("alert-error")
        loginAlert.slideDown().delay(4000).slideUp()

      setTimeout( =>
        submitBtn.removeAttr("disabled").show()
        spinnerButton.hide();
      , 2000)

    false

  bindSubmitTrialForm: =>
    authFormMessage = $("#alert-text")
    loginAlert = $("#login-alert")
    submitBtn = $("#modal_login_submit")
    spinnerButton = $("#modal-signup-spinner-button")
    submitBtn = $("#modal_signup_submit")
    signUpModal = $("#signUpModal")
    successModal = $("#signUpSuccessModal")
    submitBtn.click (e) =>
      mainjs.stopEvent(e)
      email = $("#signup_email").val()
      pass = $("#signup_password").val()
      conf_pass = $("#signup_confirm_password").val()

      if (null != email     && email.length     > 0) &&
         (null != pass      && pass.length      > 0) &&
         (null != conf_pass && conf_pass.length > 0)

        if pass == conf_pass
          submitBtn.hide()
          spinnerButton.show()

          data = {
            email: email,
            password: pass,
            password_confirmation: conf_pass,
            trial_began: (new Date()).toISOString()
          }

          data['pcode_id'] = @pcode.id if @pcode and @pcode.id

          $.ajax
            type: "POST"
            url: merchapi.host() + "/users"
            dataType: 'json'
            async: true
            data: data
            success: (data) =>

              errors = data.errors
              if errors and Object.keys(errors).length > 0
                errorMessage = ""
                for k,v of errors
                  errorMessage += "#{k.capitalizeFirstLetter()} #{v}. "

                errorMessage = "Sorry, an error has occurred. Please try again." unless errorMessage.length > 0

                signUpModal.modal('hide')
                authFormMessage.text(errorMessage)
                loginAlert.removeClass("alert-success").addClass("alert-error")
                loginAlert.slideDown().delay(4000).slideUp()
                submitBtn.removeAttr("disabled")
              else
                # Send confirmation email

                data = {
                  contact: {email: email}
                }

                data["pcode_duration"] = @pcode.duration if @pcode and @pcode.duration

                $.ajax
                  type: "POST"
                  url: "/send_confirmation"
                  dataType: 'json'
                  async: true
                  data: data
                  success: (data) ->
                    console.log "Confirmation email sent!"

                  error: (data) ->
                    console.log "Failed to send confirmation email!"
                    for k,v of data
                      console.log k + " is " + v

                # Log the user in and go to dashboard
                mainjs.performLoginWithEmailPass(email, pass, (d) ->
                  # Handle success
                  # window.location.href = 'dashboards/dashboard_2'
                  submitBtn.show()
                  spinnerButton.hide()
                  signUpModal.modal('hide')
                  successModal.modal('show')
                , (d) ->
                  # Handle error
                  for k,v of d
                    console.log k + " is " + v
                  signUpModal.modal('hide')
                  authFormMessage.text("Sorry, an error has occurred. Please try again.")
                  loginAlert.removeClass("alert-success").addClass("alert-error")
                  loginAlert.slideDown().delay(4000).slideUp()
                )

            error: (data) ->
              submitBtn.removeAttr("disabled")
              authFormMessage.text("Sorry, an error has occurred. Please try again.")
              loginAlert.removeClass("alert-success").addClass("alert-error")
              loginAlert.slideDown().delay(4000).slideUp()

          submitBtn.attr("disabled","disabled")
          authFormMessage.text("Logging in...")
          .css("text-align","center")
          .fadeIn(1000)
          .delay(4000)

        else # Password don't match
          signUpModal.modal('hide')
          authFormMessage.text("Your passwords don't match.")
          loginAlert.removeClass("alert-success").addClass("alert-error")
          loginAlert.slideDown().delay(4000).slideUp()  

      else # Missing a required field
        signUpModal.modal('hide')
        authFormMessage.text("Please enter a valid email address, password, and password confirmation.")
        loginAlert.removeClass("alert-success").addClass("alert-error")
        loginAlert.slideDown().delay(4000).slideUp()

      setTimeout( =>
        submitBtn.removeAttr("disabled").show()
        spinnerButton.hide();
      , 2000)

    false

  performLoginWithEmailPass: (email, pass, success, error) =>
    console.log "Performing login!"
    $.ajax
      type: "POST"
      url: merchapi.host() + "/auth/login"
      dataType: 'json'
      async: true
      data: {login: email, password: pass}
      success: (data) ->
        token = data.token

        if data.user.ua
          uber_admin = 1
        else
          uber_admin = 0

        if token != null && token.length > 0
          authenticity_token = $("*[name='authenticity_token']").val()
          $.ajax
            type: "POST"
            url: "/sessions"
            dataType: 'json'
            async: true
            data: {token: token, authenticity_token: authenticity_token, uber_admin: uber_admin}
            success: (data) ->
              success(data)
            error: (data) ->
              error(data)

      error: (data) ->
        error(data)

  bindForgetPassswordSubmitForm: =>
    errorMessage = $("#error-text")
    errorAlert = $("#forget-error-alert")
    submitBtn = $("#forget-password-btn")
    forget_password_email = $("#forget-password-email")
    error_message = $("#error_message")
    submitBtn.click (e) =>
      mainjs.stopEvent(e)
      email = forget_password_email.val()

      if email == ""
        console.log("error!")
        errorMessage.text("Please enter email address!")
        errorAlert.removeClass("alert-success").addClass("alert-error")
        errorAlert.slideDown().delay(4000).slideUp()
      else
        check_email = mainjs.checkEmailValidation(email)
        console.log(check_email)
        if check_email
          $("#forget-password-btn i").css("display","inherit")
          console.log("valid email")
          @email = email
          $.ajax
            type: "GET"
            url: merchapi.host() + "/users/resetpass?"
            headers:
              'Accept': 'application/json'
            async: true,
            data: {email: @email},
            success: (res) ->
              @new_pass = res["new_pass"]              
              $.ajax
                type: "POST",
                url: "home/send_email",
                dataType: 'json',
                async: true,
                data:
                  "email": email, "password": @new_pass
                success: (res) ->
                  $("#forget-password-btn i").css("display","none")
                  $("#forget-password-modal").modal('hide')

            error: (res) ->
              msg = res["error"]
              console.log(msg)
              if msg
                errorMessage.text("Email not found.")
                errorAlert.removeClass("alert-success").addClass("alert-error")
                errorAlert.slideDown().delay(4000).slideUp()
                $("#forget-password-btn i").css("display","none")

        else
          console.log("invalid email")
          errorMessage.text("Please enter valid email address!")
          errorAlert.removeClass("alert-success").addClass("alert-error")
          errorAlert.slideDown().delay(4000).slideUp()

  checkEmailValidation: (email) =>
    
    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
    
    if email.match emailPattern
      return true        
    else
      return false
        

  stopEvent: (e) ->
    e.preventDefault()
    e.stopPropagation()

@mainjs = new MainJS("")
@mainjs.bindPromoForm()
@mainjs.bindSubmitAuthForm()
@mainjs.bindSubmitModalAuthForm()
@mainjs.bindSubmitContactForm()
@mainjs.bindSubmitTrialForm()
@mainjs.bindForgetPassswordSubmitForm()
