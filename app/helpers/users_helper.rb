module UsersHelper
    # 生成Gravatar头像图片链接
    def gravatar_for(user, option = { size: 50 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = option[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: 'gravatar')
    end

    # 生成错误信息
    def error_message_for(user, key)
      if user.errors.full_messages_for(key).any?
        content_tag "div", class: "help-block" do
          user.errors.full_messages_for(key).join(",")
        end
      end
    end

    # 为有错误的html添加class
    def add_class_if_has_error(user, key)
      "has-error" if user.errors.full_messages_for(key).any?
    end
end
