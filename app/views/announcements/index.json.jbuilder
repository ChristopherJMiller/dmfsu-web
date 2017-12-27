json.announcements @announcements do |announcement|
  json.id announcement.id
  json.title announcement.title
  json.post announcement.post
  json.author Admin.find_by(id: announcement.admin_id).name
  json.created_at announcement.created_at
  json.updated_at announcement.updated_at
end
