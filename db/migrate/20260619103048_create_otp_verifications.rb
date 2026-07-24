class CreateOtpVerifications < ActiveRecord::Migration[8.1]
  def change
    create_table :otp_verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone, null: false
      t.string :otp_digest, null: false

      t.datetime :expires_at
      t.datetime :verified_at

      t.integer :attempts, default: 0

      t.timestamps
    end

    add_index :otp_verifications, :phone
  end
end
