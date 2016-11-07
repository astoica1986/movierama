require 'spec_helper'
require 'support/with_user'
include ActiveJob::TestHelper

RSpec.describe VoteNotification, type: :mailer do
  describe 'vote_notify' do
    let(:vote) {:like}
    
    let(:user) do
      User.create(
          uid:  'null|12345',
          name: 'Bob',
          email: 'stoica.adrian86@gmail+test'
      )
    end
    
    let(:movie) do
      Movie.create(
          title:        'Empire strikes back',
          description:  'Who\'s scruffy-looking?',
          date:         '1980-05-21',
          user:         user
      )
    end
    
    it "creates job when used with deliver_later" do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.vote_notify(user.name, user.email, movie.title, vote.to_s).deliver_later}
          .to have_enqueued_job.on_queue('mailers')
    end
    
    it "sends email when the job is performed" do
      expect {
        perform_enqueued_jobs do
          described_class.vote_notify(user.name, user.email, movie.title, vote.to_s).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
    let(:mail) { described_class.vote_notify(user.name, user.email, movie.title, vote.to_s).deliver }
    it 'renders the subject' do
      expect(mail.subject).to eq("Wonderful news #{user.name}")
    end
    
    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
    
    it 'renders the sender email' do
      expect(mail.from).to eq(['stoica.adrian86@gmail.com'])
    end
    
    it 'assigns user name' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'assigns movie title' do
      expect(mail.body.encoded).to match(movie.title)
    end

    it 'assigns vote status' do
      expect(mail.body.encoded).to match("liked")
    end
  end
end