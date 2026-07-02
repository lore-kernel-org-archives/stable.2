Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2F353A69;
	Thu,  2 Jul 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018544; cv=none; b=jJVC2jnGVCiOKpeKBHUVIZ4etrr0+8ogIt2bS748iIs3rEMDFwlwipLKzJu5FujACkYvwuDYiURrR9URIUEzb/rBkItk/1bjwCs3KCkQ4uY7Wii3EYMeaMWSPPJf8FoKeSBw4+UkGnvCVaeIYr9x5CYj5MMzKh3XmwNpAh5cSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018544; c=relaxed/simple;
	bh=i3WCYDcAGVXuOIHLVTtF5UUWazZBuq4GcRLYZdDJctQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJjCDIobQPOHTNzQ8wZf6hGkO2uoMn9skucD0UrFz6VMKsSRqBMnEh2OgaFKFhKocJbMM+HXlZbITnv+h7J9JpJSSEB/ODd8qmQ8SQz1j746DXVox+2Zx789UZYxgz5PFP1RDFI671xiIokc7KM27l5w5Tlfc0R1NZygAe/6XgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH7xquYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH7xquYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78931F000E9;
	Thu,  2 Jul 2026 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783018543;
	bh=2WdsnKJ1Aw9ta/hrRGydNoYuDjuIZ97UFU5ekCpcEfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VH7xquYJ0AEP+gnuQck18J10dgEFRy6Mc37vMU/uD5POPW0Rqgj7KuEQ1r3s2xJNB
	 40H/LgkeCI88yQbhrFXhBoRmXZ4AFzFA4PEmN35BkQFyMMqGeHSybSZwbnO9sYM/YZ
	 YjznUWOqALJK39OYJiQSxrVUqOVKiJJRORg+hwgw+C0dncyaB3RXhFyQvpgUrb7bxa
	 1HQiWSPSTgtyXVXJHMNh1CPJh80zYNvPolmcXiMxv41WumhpDOvYJEzCRA2c/NgRLb
	 DsDTzcBPQ3rW8Re6IUUyZiNHLWyRYXy2ZdmWi2oiZ6gj+dsNHCfNEyD5atMazvU/1h
	 F5ZKvxZQBO1+A==
Date: Thu, 2 Jul 2026 19:55:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: sensor: custom: Fix field sysfs group
 cleanup on failure
Message-ID: <20260702195537.3a95355c@jic23-huawei>
In-Reply-To: <20260702094856.1105555-3-haoxiang_li2024@163.com>
References: <20260702094856.1105555-1-haoxiang_li2024@163.com>
	<20260702094856.1105555-3-haoxiang_li2024@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 17:48:56 +0800
Haoxiang Li <haoxiang_li2024@163.com> wrote:

> hid_sensor_custom_add_attributes() creates one sysfs group for each
> custom sensor field. If sysfs_create_group() fails after some groups
> have already been created, the function returns the error without
> removing the previously created groups. Add a local unwind path to
> remove the groups that were already created.
> 
> Create the field attributes before exposing enable_sensor, so the
> failure path can free sensor_inst->fields without leaving enable_sensor
> able to access power_state or report_state pointers into that array.
> 
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Ah. This has the reorder necessary to resolve the issue I called out
in previous patch (I think).  They can't be done independently.
Can you move the registration reorder to the previous patch then
only do the missing cleanup in this one?

> ---
>  drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index d7bdbae96b50..ea98088e5112 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -609,7 +609,7 @@ static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
>  					 &sensor_inst->fields[i].
>  					 hid_custom_attribute_group);
>  		if (ret)
> -			break;
> +			goto err_remove_groups;
>  
>  		/* For power or report field store indexes */
>  		if (sensor_inst->fields[i].attribute.attrib_id ==
> @@ -621,6 +621,13 @@ static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
>  	}
>  
>  	return ret;
> +
> +err_remove_groups:
> +	while (--i >= 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				   &sensor_inst->fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);
> +	return ret;
>  }
>  
>  static void hid_sensor_custom_remove_attributes(struct hid_sensor_custom *
> @@ -1005,26 +1012,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> -				 &enable_sensor_attr_group);
> +	ret = hid_sensor_custom_add_attributes(sensor_inst);

I think this brings things back into order wrt to remove.
This probably needs to be in the previous patch.

>  	if (ret)
>  		goto err_remove_callback;
>  
> -	ret = hid_sensor_custom_add_attributes(sensor_inst);
> +	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> +				 &enable_sensor_attr_group);
>  	if (ret)
> -		goto err_remove_group;
> +		goto err_remove_attributes;
>  
>  	ret = hid_sensor_custom_dev_if_add(sensor_inst);
>  	if (ret)
> -		goto err_remove_attributes;
> +		goto err_remove_group;
>  
>  	return 0;
>  
> -err_remove_attributes:
> -	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_group:
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
>  			   &enable_sensor_attr_group);
> +err_remove_attributes:
> +	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_callback:
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  

