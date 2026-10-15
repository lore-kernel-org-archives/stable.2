Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4A50B8A1;
	Thu, 15 Oct 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065279; cv=none; b=qlOiGr3ZWMtwDT1BNSgwCEi7kry/7R4xQYO9tWYljOP7IQl9Vwd8GMzRCL27P+qLdyyuxeZckiKVUdR0XOlJWXl4sgtrjhcqkk/2ydm702Lc6iZ82yHl9HDrrpSyGSRSVi24nHG0REs8ZZJp/689S9X0YYT6CYQjq8yFZFvEpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065279; c=relaxed/simple;
	bh=xYOp1G1jxzxOUfjE0zV3ZGoO+SvXwIrIA3wjJIwpViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTWyXFHOZdsL0g9YyQ65VmimDhboAlSNY/wdeuhfF9brRunA3EINCrsfy24s7D9ke11SHxhVC4wEeOZ7Wt9rtQrkn9lSCS4VcYcTMm6GE9lbUIR2bn51EtZyrhMTZxrj0HhGfetmZfcaspvEvSN+7KjrpVwaGxvZ2zS2SLC5IRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8nkOOa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8nkOOa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF81F000C4;
	Thu, 15 Oct 2026 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065277;
	bh=P2y0MpldF4+kwQvIj2Qel3DB2HC+sKuBQKtA4I9yV7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F8nkOOa1SYIJxkN5Kv6B84mABuizZOrfSDsAmY5A1h3moNGBnSj1mXrSBl8Tp9Cfp
	 HxfGZjgY5RDozrqhZE5Ft3bsmFvjxGMR9nlWe26uIfDI5tJF1ZWxLdOEkZziXX4W3Y
	 Vcr6frg6PBiG1KOL8+WLVvSV2bI3hnyKf/1MXgwTXfqz6Cz96ZGovV6O92MyXH9Mcf
	 nso7RhOmaXSSosumsuOd+CDg2r5MAiRfhTv7dkxMouTRW8rpO9KH/wyOrSzA4cwwvA
	 zxsRKLKw2CpfmxJaoWqKWOpRsabPtEF21hy2GV0ShG/V3opahtvZn+FOiND3pdO2OZ
	 tVL4q5I2p1/gQ==
Date: Thu, 15 Oct 2026 12:54:33 +0100
From: Lee Jones <lee@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jan-Simon Moeller <jansimon.moeller@gmx.de>,
	Pavel Machek <pavel@kernel.org>,
	Joseph Strauss <jstrauss@mailbox.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: blinkm: Clean up sysfs group on LED
 registration failure
Message-ID: <179198508016.839288.4695468891309561458@kernel.org>
References: <20260926000344.29899-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926000344.29899-1-mhun512@gmail.com>
X-AI-Review-Draft: <20260926000344.29899-1-mhun512@gmail.com>

On Fri, 25 Sep 2026, Myeonghun Pak wrote:

> blinkm_probe() creates the BlinkM sysfs group before registering the LED
> class devices. If multicolor sub-LED allocation fails, probe returns
> without removing the group. If multicolor LED registration fails, the
> helper removes the group but returns success, leaving the device bound
> without an LED class device.
>
> Keep LED class device rollback in the registration helpers, but remove
> the BlinkM sysfs group in blinkm_probe() when either registration mode
> fails. Propagate the multicolor registration error so probe can perform
> this cleanup and report the failure.
>
> Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Move sysfs group cleanup to blinkm_probe() for both LED registration modes.
> - Propagate multicolor LED registration errors to blinkm_probe().
>
>  drivers/leds/leds-blinkm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -671,7 +671,6 @@ failblue:
>  failgreen:
>  	led_classdev_unregister(&leds[RED]->cdev.led_cdev);
>  failred:
> -	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
>
>  	return err;
>  }
> @@ -714,9 +713,8 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
>  	if (err < 0) {
>  		dev_err(&client->dev, "couldn't register LED %s\n",
>  				mc_led->cdev.led_cdev.name);
> -		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
>  	}
> -	return 0;
> +	return err;
>  }
>
>  static int blinkm_probe(struct i2c_client *client)
> @@ -749,13 +747,12 @@ static int blinkm_probe(struct i2c_client *client)
>  	}
>
> -	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
> +	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR))
>  		err = register_separate_colors(client, data);
> -		if (err < 0)
> -			return err;
> -	} else {
> +	else
>  		err = register_multicolor(client, data);

Please add a newline after the 'if-else' block.

> -		if (err < 0)
> -			return err;
> +	if (err < 0) {
> +		sysfs_remove_group(&client->dev.kobj, &blinkm_group);

How about using 'devm_device_add_group() to automate clean-up?

> +		return err;
>  	}
>
>  	blinkm_init_hw(client);

-- 
Lee Jones
