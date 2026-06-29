Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F21A6822;
	Mon, 29 Jun 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725322; cv=none; b=Fuvw8k00jPAFJD7J/X2RT76YWfhD1XjwsOYSmbrkcK7SCihfEyRX9ORHyKYFDcXQh4OMNV4fBZxG2bUKFcE2ek+0MK3rVDE3ojVg7uzQKRfXbWyR1waqmLXXGGJzm92FQJMVnfm2Jb8sgVjcLMKIPSsrNVkU8UGSKH/7C4nAaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725322; c=relaxed/simple;
	bh=K4jU7F6muLVLr/hezJMUij9Sn0zB6OjemcazGDqW+/4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ze+WD8vm8FNc9CrTajkt3e5Ocy7Jjb1igLHppbXUw1cNsFGhM5Sl8QDYRblifmdaPIxGB0Ft/005D22bTacUtDFE7lhnlnThNlgWr+WruPBOEnIq5tGhWrWL+eCrPZloMxoVjtgLgtvzrqoSGzvGuVq9zKjM0N+3QO+UQbue+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXF6XuGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXF6XuGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB11F000E9;
	Mon, 29 Jun 2026 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782725321;
	bh=EOgfBcGwHQnas0NoGW1tw3GieJSXGVhk2AHTPYXXB/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oXF6XuGFTXZDDz4vsG5ePhJVeU5ohvFsXbkWcZi4RgRktX3W2MXZLBsZBVuAyFBCS
	 g7J7Cf6vdhlQ6g2Nif/gnO+ABKFRk+83HYtHOSq4D8rCNrmbtaF1Mnk7K7KO7cfEaa
	 c7ocjTrQ4xiG9BU+EYdXVmp4EiyFpC92rF3NClIXXogH4rI/nO6oPb4B2LwTDDFyM/
	 YB80sJTkdSh60bVcmmOzthxEgnehwcAQhhAL5BAyDLnFxpiOljAT0t6f97aE8a5fme
	 GIZsC/EzjwZ/U+Fonw83AYk7h5UudJvaoBmZUiWFqV/Zdn6BZE1wVsBdyQHjXDJrAl
	 041rMjB4/HgEA==
Date: Mon, 29 Jun 2026 11:28:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: Fix sysfs group leak on
 failure
In-Reply-To: <20260623021950.1736413-1-haoxiang_li2024@163.com>
Message-ID: <spo507np-44rr-o950-7s7n-r47nno9p0782@xreary.bet>
References: <20260623021950.1736413-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jun 2026, Haoxiang Li wrote:

> hid_sensor_custom_add_attributes() creates one sysfs group for each
> custom sensor field. If sysfs_create_group() fails after some groups
> have already been created, the function currently breaks out of the
> loop and returns the error directly.
> 
> Fix this by adding a local unwind path when sysfs_create_group() fails.
> The unwind path removes all sysfs groups that were successfully created
> before the failure and frees sensor_inst->fields.
> 
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/hid/hid-sensor-custom.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index afffea894021..cd676516e6b0 100644
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

I believe Sashiko is right here abou the UAF. Could you please fix that 
and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

