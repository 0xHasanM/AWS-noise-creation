#!/bin/bash

# Shuffle lines in the file
shuffled_lines=$(shuf aws_keys.csv)

# List of AWS regions
regions=("us-east-1" "us-west-2" "eu-west-1" "ap-southeast-1" "ap-northeast-1")

# List of AWS services and their respective actions
services=("s3" "ec2" "lambda" "dynamodb" "rds" "sns" "sqs" "cloudwatch" "elasticache")

# Loop through shuffled lines
while read -r line; do
    # Extract AWS Access Key ID and AWS Secret Access Key
    access_key=$(echo "$line" | cut -d ',' -f 1)
    secret_key=$(echo "$line" | cut -d ',' -f 2)

    # Set environment variables
    export AWS_ACCESS_KEY_ID="$access_key"
    export AWS_SECRET_ACCESS_KEY="$secret_key"

    # Generate random activity
    for i in {1..5}; do
        random_region="${regions[$RANDOM % ${#regions[@]}]}"
        random_service="${services[$RANDOM % ${#services[@]}]}"
        
        case $random_service in
            "s3")
                aws "$random_service" ls --region "$random_region"
                ;;
            "ec2")
                aws "$random_service" describe-instances --region "$random_region"
                ;;
            "lambda")
                aws "$random_service" list-functions --region "$random_region"
                ;;
            "dynamodb")
                aws "$random_service" list-tables --region "$random_region"
                ;;
            "rds")
                aws "$random_service" describe-db-instances --region "$random_region"
                ;;
            "sns")
                aws "$random_service" list-topics --region "$random_region"
                ;;
            "sqs")
                aws "$random_service" list-queues --region "$random_region"
                ;;
            "cloudwatch")
                aws "$random_service" list-metrics --region "$random_region"
                ;;
            "elasticache")
                aws "$random_service" describe-cache-clusters --region "$random_region"
                ;;
            *)
                echo "Unknown service: $random_service"
                ;;
        esac
    done

    # Clear environment variables
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
done <<< "$shuffled_lines"
