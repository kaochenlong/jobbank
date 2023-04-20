class ResumeMailer < ApplicationMailer
  def new_resume(user)
    @url  = 'http://example.com/login'
    @user = user
    mail(to: @user.email, subject: '你新增了一份履歷')
  end
end
