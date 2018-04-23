desc "Run"
task :run do
  sh "rackup -p 9292 -o 0.0.0.0"
end

task default: :run

DC_NAME = "estemporary" # docker container name

desc "Build docker"
task :docker_build do
  sh "docker build -t #{DC_NAME} ."
end

desc "Run docker locally"
task :docker_run do
  sh "docker run -p 3000:80 #{DC_NAME}"
end

desc "Run docker locally (port 80)"
task :docker_run_80 do
  sh "docker run -p 80:80 #{DC_NAME}"
end
