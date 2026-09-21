Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A6492E43;
	Mon, 21 Sep 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988540; cv=none; b=N0o2etbzxRDzSlSRzSSqIB21R7X4NYW1znVJ2EbODFh7+mV66I2lgh/YKAghz4XS26qVjscqjFPICTQP4JiGwhGn4wcoRYC8x+e+90c7rcY6Y91bh1O8vzAcmKqWzWBghXX+8OzXb377qiZkjqF4SFODvvkHy2LZPDyTd5Yt3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988540; c=relaxed/simple;
	bh=XZ9H5oF2ZKPd/nimVEwmfuImVXQTObPH21isO+3FSEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDdbTllbptxQcRhoUQcbWToEkpWl5sSoWzurbQX5yb2dlaiUToZRKOWs9PpjSSqZun06E/JPDcE+Jl9CzrNowoqgCl8BRYxpVbfi5CeV96UJ6FpVrV2zMlp7tSxL73Az0wz3plXXXixaEYDZbfWBVeINN7I8YEc+olfNdtWMu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emlBXqEk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emlBXqEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789988537; x=1821524537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XZ9H5oF2ZKPd/nimVEwmfuImVXQTObPH21isO+3FSEM=;
  b=emlBXqEkDdy+L2C3fVKG6SApPA8FBEI+UCCmIbXG9H/stsZK8ptezhGB
   h6vDhx/F0TSBrsBn2ndqUvR/R9G9dUaXgs9iW2WnJLc2zjiWrMoiaDSnj
   nys6NaDRFjL80w1LLixkuHHOJ9LUbFDkUd0kouE26l1DiNvY1V7GIPh+s
   xgJA+NNHOKdtA0Eku4fmi1QOsTlz+vk1QWtCwQh5nfS65S+s09NBKtMXN
   EB2S/WSJuuCAv6zODKAn8b8Irn/A3IQKdjj+dgcUgAj2dznAwGrj7cTTW
   gCLbuUkqvCltbltukbGub5m3FpRXvri0CF+2ABCtTG2q14K+NytzVfMOW
   g==;
X-CSE-ConnectionGUID: QuxSwJROQpe1ZKEWa6mNxw==
X-CSE-MsgGUID: 2dtKk5LQSvSHZD6eToweoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89628627"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89628627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:02:10 -0700
X-CSE-ConnectionGUID: txuY9P95Qe63yPKinbDNgA==
X-CSE-MsgGUID: qRnuKeidSHelc20+bjkZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="269121430"
Received: from amilburn-desk.amilburn-desk (HELO kekkonen.fi.intel.com) ([10.245.244.157])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:02:07 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8D25E120370;
	Mon, 21 Sep 2026 14:02:02 +0300 (EEST)
Date: Mon, 21 Sep 2026 14:02:02 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Luca Weiss <luca@lucaweiss.eu>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: flash: sgm3140: fix child node reference leak
Message-ID: <arEOqq-KSDssm35d@kekkonen.localdomain>
References: <20260921092128.346375-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921092128.346375-1-lgs201920130244@gmail.com>

Hi Guangshuo,

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

This doesn't look like a problem related to just this driver.

led_classdev_register_ext() creates a device and sets its fwnode without
taking a reference. Should we instead take a refenrece there and release it
at unregister time?

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

Sakari Ailus
