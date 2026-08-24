Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD0411FB8;
	Mon, 24 Aug 2026 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572912; cv=none; b=aLIWjdfmUe8O53Q7ahUMq6TnAnOAn8TbhH7cvR7Y7PVcCin2ABJvafPDs3KsdNdx4vgSMAMdBycKyix4K1FK4MsmYuZF41qAQCMPpldoH9WK1gHDVqV1eHAcXo2loxVl6A3i/QxjyH2cGAk8jIN8EYB8bMEJRxoWoeu98Irn00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572912; c=relaxed/simple;
	bh=bd+SvbArwpaqiMOHk197Gbuk0I37mXJH8PMk5UrlrEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozSwiOvOje67NUxkma8ay50yJTYzJlIMCW3ubuULhZSI5+9Yx3MZVFGAIyeAvaJVgJMULMc3GZ82NvuBtGpYG3TC45kH4M1XWeWRCvlAOEsAVtBv0w93dB2IM9RbNQe36DV2Jr6myekoLoTGgNi7QRBYRfqAmdO0gatSSMgbg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiHrhdDs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiHrhdDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787572911; x=1819108911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bd+SvbArwpaqiMOHk197Gbuk0I37mXJH8PMk5UrlrEU=;
  b=eiHrhdDsSgsQ8ED7QXnaZfnjUVUmz/sm2Hsyb8Z/2uxNkmExhE6/st9f
   y6tOqUjGY/DCyukGwZNn5eqPlR7MbHulWYgAnKX5vHb9rt36MhFHiZkK0
   9p+03uSaogHHz1bIlon74ht9WOux0Y2gO94XjPUcJnhrImKYOwI3pEp/w
   s/U/GVVNab1qvTHfyNxMR2sqSQm2bayeTnTjvYVXmQML3Z+LE1tfsSN5B
   tVEzrC5mq3BvHGIJBkSbPrrYz9/4K3Dm9XTLsK1KfthLx29AyIc/VhmGp
   BWMwoedDUyb1Np4xGk+pho3WPD/0+XHsJwqbjetNwJK0T2LM84iMk6HkC
   A==;
X-CSE-ConnectionGUID: k7bnqMLfRlCFIeQM2sJY8w==
X-CSE-MsgGUID: Q+vwgjsVRZ+LapyeaOLRHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="99546382"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="99546382"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 05:01:50 -0700
X-CSE-ConnectionGUID: B4++PNuNQE+mtSwQGlK9Mg==
X-CSE-MsgGUID: rKyuEJ76SYOQD0lYMYzDSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="266461788"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 24 Aug 2026 05:01:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 98B2899; Mon, 24 Aug 2026 14:01:46 +0200 (CEST)
Date: Mon, 24 Aug 2026 14:01:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
Message-ID: <aowyqsM1zuT77q3d@black.igk.intel.com>
References: <20260822072556.490594-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822072556.490594-1-marex@nabladev.com>

On Sat, Aug 22, 2026 at 09:24:58AM +0200, Marek Vasut wrote:
> Some devices use combo PHYs (i.e. USB3 + DisplayPort), which also
> handle the lane muxing. These PHYs are referenced twice from
> the USB-C connector (USB super-speed lines and SBU/AUX lines)
> resulting in the mux being configured twice. Avoid this by
> dropping duplicates.
> 
> This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
> duplicated mux switches"), with fix derived from usb: typec: mux:
> Fix typec_switch_match() .
> 
> Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> - Extensive test by Jens https://lore.kernel.org/all/8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz/
> ---
>  drivers/usb/typec/mux.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 2bc7e8edb3cbd..afa6fc1813978 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -277,7 +277,9 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
>  static void *typec_mux_match(const struct fwnode_handle *fwnode,
>  			     const char *id, void *data)
>  {
> +	struct typec_mux_dev **mux_devs = data;
>  	struct device *dev;
> +	int i;
>  
>  	/*
>  	 * Device graph (OF graph) does not give any means to identify the
> @@ -292,8 +294,18 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
>  
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				mux_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
>  
> -	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
> +	/* Skip duplicates */
> +	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
> +		if (to_typec_mux_dev(dev) == mux_devs[i]) {
> +			put_device(dev);
> +			return NULL;
> +		}
> +
> +
> +	return to_typec_mux_dev(dev);
>  }
>  
>  /**
> @@ -318,7 +330,8 @@ struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
>  		return ERR_PTR(-ENOMEM);
>  
>  	count = fwnode_connection_find_matches(fwnode, "mode-switch",
> -					       NULL, typec_mux_match,
> +					       (void **)mux_devs,
> +					       typec_mux_match,
>  					       (void **)mux_devs,
>  					       ARRAY_SIZE(mux_devs));
>  	if (count <= 0) {
> -- 
> 2.53.0

-- 
heikki
