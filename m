Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758A4EDCB9;
	Wed, 14 Oct 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972638; cv=none; b=aOj4tiCV9/6AY1hQ7Rhsi+NoFYIaBHKJWbizdmrTsxCMZK4c5HKSNKxZeLq+Yo0sHWby1Mdw+0w1YNIjA3l5DyArkCY5oAxt59fI4caPvfIWYwrh6mwX/ml3Uo4VAhg10bXVIDYRLCbn3p2Q37KOtMCiFH3MoTVZwySbX4YzgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972638; c=relaxed/simple;
	bh=yuGWrqvzNmN3yhigttSdJ0b/S9YKdnQt/hArXMWhVKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6mAXEbNCuok7kP/myCK9CbCgdyuuAek453rd2Vc/ryAiLMm+8euVycLn6DKXugG9zNEfREzTBOf+JDZm637XImes/yiVnDPXdHGI7zYb5+BH+9RZM0p4MBY3fvK8U8kuL0OmLJWiumWrs83u7v4FeBA2rh4BjYOTOsUjVyKviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ2TZCZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ2TZCZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005B01F000FF;
	Wed, 14 Oct 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791972629;
	bh=ktsMdkR+NlEi7tmxfG6KqIwZFdoUQsHLRPY8vg2h60Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQ2TZCZhVe94KLLtnzQ3yR3ogHvFzoxgQoc3R1jER79UgA78VXRr8iDg3KdFK2ODP
	 YyS7jdT9/qbWHEHVD1tZ0sznhtXz0CLfu/G2ciKfdx2B86Rt8LLvukWQdSWM2alydl
	 17pZ2hpDxVrw6eJwdF+f2XcE7JE0OtxM/4eHtYNPCKG4lvUpVvi4AIBrjGyKN5aj2z
	 hOYmRjD3vg6CojY4avQVdA569Pd+vN61WS/tEq8+7080n1V95JqaEPQ5ewUUGtc5cH
	 ajYXuidjwKPwswshX59bvhBz0Wu8cAFzVvQbWg7EgmAS+4JmNAco4fSfzkm6n5bh//
	 lk5YJkqCAE56Q==
Date: Wed, 14 Oct 2026 03:10:27 -0700
From: "Peter Chen (Qualcomm)" <peter.chen@kernel.org>
To: liuc63 <liuc63@xiaopeng.com>
Cc: rogerq@kernel.org, pawell@cadence.com, gregkh@linuxfoundation.org,
	stable@vger.kernel.org, liuwb@xiaopeng.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: validate endpoint index from setup packet
Message-ID: <as9VE0CJtUBxgds9@hu-petche-lv.qualcomm.com>
References: <20261012110107.2458022-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012110107.2458022-1-liuc63@xiaopeng.com>

On 26-10-12 19:01:07, liuc63 wrote:
> From: Liu Chao <liuc63@xiaopeng.com>
> 
> cdns3_ep_addr_to_index() computes (ep_addr & 0x7F) + 16 for IN
> endpoints.  wIndex is supplied by the USB host, so ep_addr & 0x7F can
> be up to 127, giving an index up to 143.  The eps[] array has only
> CDNS3_ENDPOINTS_MAX_COUNT (32) entries.
> 
> Both cdns3_req_ep0_get_status() (GET_STATUS) and
> cdns3_ep0_feature_handle_endpoint() (SET/CLEAR_FEATURE) pass the
> unvalidated index straight into priv_dev->eps[index] and then
> dereference the result.
> 
> Besides the out-of-bounds index, eps[index] may also be NULL for
> endpoints that are not enabled, as cdns3_init_eps() only populates
> entries for endpoints enabled in USB_CAP3.
> 
> Add a bounds check against CDNS3_ENDPOINTS_MAX_COUNT together with a
> NULL check in both functions, matching the fix already applied to
> aspeed_udc in commit ee0d382feb44 ("usb: gadget: aspeed_udc: validate
> endpoint index for ast udc").
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
> Changes in v2:
>  - Also check priv_dev->eps[index] for NULL, as endpoints not enabled
>    in USB_CAP3 are left NULL by cdns3_init_eps() (Peter Chen)
>  - Correct the reference: the same-class fix ee0d382feb44 is for
>    aspeed_udc, not renesas_usb3; cite it with the commit title and
>    drop the CVE mention (Peter Chen)
>  - Fix the function name cdns3_ep0_handle_status() ->
>    cdns3_req_ep0_get_status() in the commit message
> 
> v1: https://lore.kernel.org/linux-usb/20260917103145.3047850-1-liuc63@xiaopeng.com/
> ---
>  drivers/usb/cdns3/cdns3-ep0.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
> index e29989d57..d26fa89b6 100644
> --- a/drivers/usb/cdns3/cdns3-ep0.c
> +++ b/drivers/usb/cdns3/cdns3-ep0.c
> @@ -251,6 +251,9 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>  	case USB_RECIP_ENDPOINT:
>  		index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
> +		if (index >= CDNS3_ENDPOINTS_MAX_COUNT ||
> +		    !priv_dev->eps[index])
> +			return -EINVAL;

Oh, I have seen sashiko AI comments. You may use USB_ENDPOINT_NUMBER_MASK to get
a valid EP number, then get 'index' according to its direction (IN or OUT), at last,
judge if priv_dev->eps[index] is NULL.

Peter

>  		priv_ep = priv_dev->eps[index];
>  
>  		/* check if endpoint is stalled or stall is pending */
> @@ -368,6 +371,8 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
>  		return 0;
>  
>  	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
> +	if (index >= CDNS3_ENDPOINTS_MAX_COUNT || !priv_dev->eps[index])
> +		return -EINVAL;
>  	priv_ep = priv_dev->eps[index];
>  
>  	cdns3_select_ep(priv_dev, le16_to_cpu(ctrl->wIndex));
> -- 
> 2.50.1
> 

-- 

Thanks,
Peter Chen
