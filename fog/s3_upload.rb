## Setup the Connection
connection = Fog::Storage.new({
  provider:              'AWS',
  aws_access_key_id:     'xxxxxxxxxx',
  aws_secret_access_key: 'xxxxxxxxxxxxxxxxxxxxxxxx',
  region:                 'us-west-2'
})

## Setup the Directory
directory = connection.directories.find{ |d| d.key == 'antiques-production' }

## get some files
files = Dir["public/uploads/**/*"]

## move dem files
files[0..20].each do |file|
  file_name = file.gsub('public/', '')
  if file.split('.').size > 1
    aws_image = directory.files.create( key: file_name,
                                        body: open(file),
                                        public: true)
  end
end

