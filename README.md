Readme
================

Project Dependencies:
---------------------

As a prerequisite to setting up/running the project, you'll need to make sure you have installed and properly configured it's dependencies. Here they are and how to install/configure them:

1. Ruby v2.2.0 - The easiest way to install and managed multiple Ruby versions is to use a tool like [rvm](https://rvm.io). Once you've installed `rvm`, installing a new version of Ruby is as simple as `$ rvm install 2.2.0`.
2. RubyGems v2.4.x - If you don't have this version you can download the latest version [here](https://rubygems.org/pages/download).
3. Bunlder Gem - After verifying you have a proper version of RubyGems you can install the Bundler gem by simply running this command `$ gem install bundler`.

Steps to get up and running:
---------------------------

1. Clone the project: `$ git clone git@github.com:Appalope/merchcat-aws.git`
2. Change directories into the `merchcat-aws` directory: `$ cd ~/your/directory/path/merchatcat-aws`
3. Run bundler to install all project dependencies (gems): `$ bundle install`
4. Install Figaro to handle environement variables: `$ figaro install`
5. After installing Figaro, you'll now have a new file at `config/application.yml`. This new file (`application.yml`) will be used to store local environment variables and should **never** be commited to source control. When running the `$ figaro install` command from the previous step, this should have added the `applicaiton.yml` to the .gitignore if it didn't already exist.
6. Add the environment variable described in the following section titled "Environment Variables" to you `application.yml`.
7. Run the app on the default port (3000): `$ rails s` (You can also run on a specific port by appending `-p` followed by the desired port number. Ex `$ rails s -p 3001`)
8. Open a browser and access `http://localhost:3000`

Environment Variables:
----------------------

Make sure you follow the steps in the section above to install Figaro for handling of environment variables.

Example `config/application.yml`:

```yml
  SESSION_SECRET: 'HDisiueh8998dhHUSIs8wuK' (You can change the hash to anything you want)
  GMAIL_ACCOUNT: someaccount@gmail.com
  GMAIL_PASSWORD: YoUrGmAiLPa$$w0rd
  CONTACT_EMAIL: where.to.send.contact.form.submissions@somedomain.com
  STRIPE_PUBKEY: 'pk_test_X2F0L0VPhuiAVThvHyHw64Kk'

```
