RESTSERVER=1.2.3.4

 # for Cloud Driver Info
 curl -X POST http://$RESTSERVER:8000/spider/driver -H 'Content-Type: application/json' -d '{"DriverName":"aws-driver01","ProviderName":"AWS", "DriverLibFileName":"aws-driver-v1.0.so"}'

  # for Cloud Credential Info
  curl -X POST http://$RESTSERVER:8000/spider/credential -H 'Content-Type: application/json' -d '{"CredentialName":"aws-credential01","ProviderName":"AWS", "KeyValueInfoList": [{"Key":"ClientId", "Value":"XXXXXXXX"}, {"Key":"ClientSecret", "Value":"XXXXXXXX"}]}'

   # Cloud Region Info for Shooter
   curl -X POST http://$RESTSERVER:8000/spider/region -H 'Content-Type: application/json' -d '{"RegionName":"aws-ohio","ProviderName":"AWS", "KeyValueInfoList": [{"Key":"Region", "Value":"us-east-2"}, {"Key":"Zone", "Value":"us-east-2a"}]}'

    # Cloud Connection Config Info for Shooter
    curl -X POST http://$RESTSERVER:8000/spider/connectionconfig -H 'Content-Type: application/json' -d '{"ConfigName":"aws-ohio-config","ProviderName":"AWS", "DriverName":"aws-driver01", "CredentialName":"aws-credential01", "RegionName":"aws-ohio"}'
