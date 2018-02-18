class CreatePushNotificationTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :push_notification_tokens do |t|
      t.string :token

      t.timestamps
    end
  end
end