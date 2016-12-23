require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port
path = "/index.html"                 # The file we want 

# This is the HTTP request we send to fetch a file
choice = ''
until choice == "GET" || choice == "POST"
  print "GET or POST: "
  choice = gets.chomp
  if choice == "GET"
    request = "GET #{path} HTTP/1.0\r\n\r\n"
  elsif choice == "POST"
    user_info = Hash.new
    print "Enter your name: "
    username = gets.chomp
    print "Enter your email: "
    email = gets.chomp
    user_info = { :viking => { :username => username, :email => email } }
    request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{user_info.to_json.length}\r\n\r\n#{user_info.to_json}"
  else
    puts "That was not a valid choice"
  end
end

socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read             # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\n", 2) 
print body