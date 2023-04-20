# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'aa@aa.cc'
  layout 'mailer'
end
