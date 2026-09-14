Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB896470E81;
	Mon, 14 Sep 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395754; cv=none; b=s86JLgByQikNR1xrEYfWouJeDv9fwXA7EtsC//TzGB1GP4F768NjbC5MrWOSlpGac2iUzPll6ZJ0mPUAWvrMeVY1Oh0q0QjHF1LqwTvwgOFGLWcLvFs5pcxT4wWWCNpWieV8HbOh8btrB9qzEWaFQ5JF+KZTtNG9Tp/tc7oMHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395754; c=relaxed/simple;
	bh=7mLGBc44MXANdUCMmf+7tBVX6b0El+Z5XFLsIPge0rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U41B5c+qGfLhGXT2cDp+lWdrirbe1lQ/GGEBBMk3EZbJ1hfwuJK/x7sZKbx8gayUqGScmHi8DSb/kYflM8Eo1R490KBjTyoCgBOcIb8bLuZZSvWFj7Eyhe+tL8Baaq+kGCwTEiaQE07i0AMhClVSisXyxrEaLTBsgbzBVEYxOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vZyFBVOT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vZyFBVOT"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDBBF512;
	Mon, 14 Sep 2026 16:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789395650;
	bh=7mLGBc44MXANdUCMmf+7tBVX6b0El+Z5XFLsIPge0rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vZyFBVOT3FUD3tkVGGsBnE/9gKRIOCpsgp7rN8vd6XX2JM0UDtoKbkDSno2b0OS7R
	 DqKfS9JJFivg2wx7CAKgMO4pOUq6k5JeISeiESGI/DZIcQzOM+62UG9Tc+tI4TsK94
	 +kLrSAuUvEsd8c67LYQoa2w312FZcbCWTdlqH93M=
Date: Mon, 14 Sep 2026 17:22:28 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Abdel Alkuor <alkuor@gmail.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: ncp5623: release multi-led fwnode on remove
Message-ID: <20260914142228.GE2522202@killaraus.ideasonboard.com>
References: <20260914140742.1743052-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914140742.1743052-1-lgs201920130244@gmail.com>

On Mon, Sep 14, 2026 at 10:07:42PM +0800, Guangshuo Li wrote:
> ncp5623_probe() obtains a reference to the multi-led firmware node with
> device_get_named_child_node(). This reference must remain valid after
> probe because led_classdev_register_ext() associates the node with the
> LED class device using device_set_node(), which does not acquire an
> additional reference.
> 
> The probe error paths correctly release mc_node, while the successful
> path intentionally keeps the reference alive for the lifetime of the
> registered LED device. However, ncp5623_remove() unregisters the LED
> class device without subsequently dropping that reference, leaking the
> firmware node on driver unbind.
> 
> Save the firmware node pointer before unregistering the LED device and
> drop its reference afterwards, when the LED device can no longer use
> it.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 7b7e50f8f5e0 ("leds: Add NCP5623 multi-led driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/leds/rgb/leds-ncp5623.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
> index f2528f06507d..f96f15b7e9a1 100644
> --- a/drivers/leds/rgb/leds-ncp5623.c
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -227,6 +227,8 @@ static int ncp5623_probe(struct i2c_client *client)
>  static void ncp5623_remove(struct i2c_client *client)
>  {
>  	struct ncp5623 *ncp = i2c_get_clientdata(client);
> +	struct fwnode_handle *mc_node =
> +		dev_fwnode(ncp->mc_dev.led_cdev.dev);
>  
>  	mutex_lock(&ncp->lock);
>  	ncp->delay = 0;
> @@ -234,6 +236,7 @@ static void ncp5623_remove(struct i2c_client *client)
>  
>  	ncp5623_write(client, NCP5623_DIMMING_TIME_REG, 0);
>  	led_classdev_multicolor_unregister(&ncp->mc_dev);
> +	fwnode_handle_put(mc_node);

If the explanation in the commit message is true, it would indicate a
bad API defect with led_classdev_multicolor_register_ext() and
led_classdev_multicolor_unregister(). This patch would be a hack to work
around the problem at best, and isn't the right solution.

>  	mutex_destroy(&ncp->lock);
>  }
>  

-- 
Regards,

Laurent Pinchart
