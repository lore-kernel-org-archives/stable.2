Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA0492512;
	Mon, 21 Sep 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991669; cv=none; b=hqYEkaW18SdBwiZL6y+aXGgj3uIaDwWpaNp6goslJXGoqwtxXpnwbIjci/wse73ik2CqMGEsiuNzY8pJzGyNt9SFyzerV09DOQbxvoK1o1TiUR2YAbyKeEYD1uWjrtEXCsASoL5PW7WuUJ/+3oNN7D+ACnmovPRNU+cx2xSBT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991669; c=relaxed/simple;
	bh=2gOZ5ks0JgEkM3So4yHZeKzbB3Tyojvyr3oHIDrynKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBucwhEnN9EVU9RA1YX1rjN4cg6mvvhzh3FNkeOwA65EKIver4XTxw2t7A0qTXi7NTtvomCw/72221zJBaKWOetdQxIZT4vKuKcEgFr9nAk2rikRz25vzS2AT5IxWQoV44jWLDzWeVocWCkXATnZGYRJ4Wa/SEzwfGIz2cNRZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZBVc7Kst; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZBVc7Kst"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 832EC15BF;
	Mon, 21 Sep 2026 13:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789991559;
	bh=2gOZ5ks0JgEkM3So4yHZeKzbB3Tyojvyr3oHIDrynKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBVc7KstGISu9Nk2hETYE+t8quYAQWE0awm2alg7zJhaHScRPAUGtd1D7ZmaFh4w8
	 FIMzdBZj04VmJaG01ZyxosLER7h0RnJDkd4iiEVLjvppQtV4ZsoxgYuNBUvUGo98zw
	 QPO6hzlMEF/J0SSoscgBm8vltNAlTahp3/kpT6vg=
Date: Mon, 21 Sep 2026 14:54:23 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: flash: sgm3140: fix child node reference leak
Message-ID: <20260921115423.GD1466037@killaraus.ideasonboard.com>
References: <20260921092128.346375-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921092128.346375-1-lgs201920130244@gmail.com>

Why did you submit a v2 ignoring my latest comments on v1 ?

On Mon, Sep 21, 2026 at 05:21:28PM +0800, Guangshuo Li wrote:
> sgm3140_probe() obtains a reference to the LED child node with
> device_get_next_child_node(), but the reference is not released after a
> successful probe.
> 
> The child node is also passed to devm_led_classdev_flash_register_ext().
> The LED class device stores the fwnode without taking a reference of its
> own, so the reference obtained by sgm3140_probe() must remain valid until
> the LED class device is unregistered.
> 
> Manage the child node reference with a devm action registered before the
> LED class device. This ensures that the LED class device is unregistered
> before the child node reference is dropped, while also handling probe
> failure and device removal.
> 
> Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Keep the child node reference alive until the LED class device is
>     unregistered, as pointed out by Laurent Pinchart.
>   - Manage the reference with a devm action registered before the LED
>     class device registration.
> 
>  drivers/leds/flash/leds-sgm3140.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> index dc6840357370..973676b1dbb1 100644
> --- a/drivers/leds/flash/leds-sgm3140.c
> +++ b/drivers/leds/flash/leds-sgm3140.c
> @@ -182,6 +182,11 @@ static void sgm3140_init_v4l2_flash_config(struct sgm3140 *priv,
>  }
>  #endif
>  
> +static void sgm3140_fwnode_put(void *data)
> +{
> +	fwnode_handle_put(data);
> +}
> +
>  static int sgm3140_probe(struct platform_device *pdev)
>  {
>  	struct sgm3140 *priv;
> @@ -220,6 +225,10 @@ static int sgm3140_probe(struct platform_device *pdev)
>  			"No fwnode child node found for connected LED.\n");
>  		return -EINVAL;
>  	}
> +	ret = devm_add_action_or_reset(&pdev->dev, sgm3140_fwnode_put,
> +				       child_node);
> +	if (ret)
> +		return ret;
>  
>  	ret = fwnode_property_read_u32(child_node, "flash-max-timeout-us",
>  				       &priv->max_timeout);
> @@ -276,7 +285,6 @@ static int sgm3140_probe(struct platform_device *pdev)
>  	return ret;
>  
>  err:
> -	fwnode_handle_put(child_node);
>  	return ret;
>  }
>  

-- 
Regards,

Laurent Pinchart
