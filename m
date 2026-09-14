Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421247ACDC;
	Mon, 14 Sep 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395449; cv=none; b=pYfduXaPuKpSvFuVuJd/hEwZK/lfCU/+q4+ab0hakwjLU45Du89wrIzcaEbSCCFdyurgA2yihuhXl6pWHGCO+xutTz+FuL+mG5NVP8ZWfoXDIuGfZAvy/iDn43XxgYRuMtIVhVZfZmdFxDau0YlUgJUYh7fm5n0iz3ux8ZTnNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395449; c=relaxed/simple;
	bh=gUo/IdWaPu9nQusKu1+E8rmx9Fxho7Ts4vI0ss/2V1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOvLWEU77nafYGpSqukde6Ao5Lb1gzKx4et+u8kjZB3cqRv6fhNI0d87AMfQI0gQwa/WjNf3DORsCNwS1/PMo7uI/ImGpICr9/A6Wf/nwYuJGMBft8K8laY932Mx2O85y3JfYi3soTf2vbzSTuIlJmxmjznkX19XPZHzf7+eCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gizC4To7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gizC4To7"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5BCD1512;
	Mon, 14 Sep 2026 16:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789395344;
	bh=gUo/IdWaPu9nQusKu1+E8rmx9Fxho7Ts4vI0ss/2V1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gizC4To7RSNTRkB9DJvVFkw4/o91eJ94+S+KSgM3cUefrJAl7fSrXm3EgMnOwgXLJ
	 tdKqiJxJn5AD7J97wSjDYap73rnxyaQu5BJRXm/UrEa/XXGIp1PzqlIrX2h2c+OEKt
	 w1UYXSZUPBFsqrib7ILDwza1Llx2HIoNTO2vINzc=
Date: Mon, 14 Sep 2026 17:17:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: flash: sgm3140: fix child node reference leak
Message-ID: <20260914141722.GD2522202@killaraus.ideasonboard.com>
References: <20260914135723.1741327-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914135723.1741327-1-lgs201920130244@gmail.com>

On Mon, Sep 14, 2026 at 09:57:23PM +0800, Guangshuo Li wrote:
> sgm3140_probe() obtains a reference to the LED child node with
> device_get_next_child_node(). The probe error path correctly drops this
> reference with fwnode_handle_put(), but the successful probe path
> returns without releasing it.
> 
> v4l2_flash_init() takes its own reference to the supplied fwnode and
> v4l2_flash_release() drops that reference during device removal.

How about devm_led_classdev_flash_register_ext() ?

> Therefore, the reference acquired by sgm3140_probe() is only needed
> during probe and can be released once initialization has completed.
> 
> Drop the child node reference before returning successfully from probe.
> 
> This issue was found by manual code inspection.

I wonder what prompted you to manual inspect that code.

> Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/leds/flash/leds-sgm3140.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> index dc6840357370..51e31fdb78e5 100644
> --- a/drivers/leds/flash/leds-sgm3140.c
> +++ b/drivers/leds/flash/leds-sgm3140.c
> @@ -273,7 +273,9 @@ static int sgm3140_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	return ret;
> +	fwnode_handle_put(child_node);
> +
> +	return 0;
>  
>  err:
>  	fwnode_handle_put(child_node);

-- 
Regards,

Laurent Pinchart
