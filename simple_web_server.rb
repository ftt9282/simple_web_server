require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.recv(1000)
  method, path = request.match(/^(\w+) \/(.*) .+/).captures
  if File.exists?(path)
  	response = File.read(path)
    if method == "GET" 
      client.puts "HTTP/1.0 200 OK"
      client.puts response
    elsif method == "POST"
      client.puts "HTTP/1.0 200 OK"
      hash_client = request.match(/(\{.+\})/).captures
      params = JSON.parse(hash_client[0])
      user_info = "<li>Name: #{params['viking']['username']}</li> <li>Email: #{params['viking']['email']}</li>"
	  client.puts response.gsub("<%= yield %>", user_info)
    else
      client.puts "HTTP/1.0 404 Not Found"
    end
  end
  client.close
}