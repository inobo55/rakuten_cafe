require 'aws-sdk'

class ApplicationController < ActionController::Base
  	# => Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

  	device_token = ''
	aws_access_key = 'your aws access key'
	aws_secret_key = 'your aws secret key'
	region = 'your aws region'
	application_arn = 'your application arn'

	AWS.config(
	  access_key_id: aws_access_key,
	  secret_access_key: aws_secret_key,
	  region: region
	)

	sns = AWS::SNS.new
	client = sns.client
	response = client.create_endpoint(
	  platform_application_arn: application_arn,
	  token: device_token
	)
	endpoint_arn = response[:endpoint_arn]
	client.publish(target_arn: endpoint_arn, message: 'hogehoge')

end
