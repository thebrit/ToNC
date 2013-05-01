class Notifications < ActionMailer::Base
  

  def submission(sent_at = Time.now)
    subject    'Notifications#submission'
    recipients 'gary@burnindmtn.com'
    from       'gatkinson@newcastlecolorado.com'
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def finance_approved(sent_at = Time.now)
    subject    'Notifications#finance_approved'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def admin_approved(sent_at = Time.now)
    subject    'Notifications#admin_approved'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
