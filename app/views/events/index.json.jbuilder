json.events @events do |event|
  json.id event.id
  json.title event.title
  json.description event.description
  json.location event.description
  json.start_time event.start_time
  json.end_time event.end_time
end
