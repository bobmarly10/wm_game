Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
            Rails.application.secrets.omniauth_provider_key,
            Rails.application.secrets.omniauth_provider_secret,
            scope: "email,public_profile",
            image_size: 'square',
            secure_image_url: true,
            iframe: true,
            display: 'page',
            provider_ignores_state: true,
            info_fields: 'email,first_name,last_name,name,age_range,gender,locale,timezone,link'
end
OmniAuth.config.full_host = Rails.env.production? ? "https://apps.facebook.com/testcloud_wm_game" : "https://apps.facebook.com/testcloud_wm_game_t"
