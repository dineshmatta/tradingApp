Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'] || "pk_test_ab6B6jGRLFgmdcpUC1Ak4072",
  :secret_key      => ENV['SECRET_KEY'] || "sk_test_gkYcak38BdvnVsIJ2MR697Dk"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]