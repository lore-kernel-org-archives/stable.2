Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201693A6B65;
	Thu,  8 Oct 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445417; cv=none; b=ll1B+HM+0EblQrAFNruCgOxm38e7mOEBof7l+zM3f1tN56kCJV0rxz2X6Pks0xOiyR7GHyaFaz6/plvwAW4R69DI7a3QrN6seWeTZa0wc8ILBW2GBdvJ1l9Vazg9Tzcq80BKYT6LDhm4DsHS6YCwBu3OagyCXXVb4sTnjYruxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445417; c=relaxed/simple;
	bh=tFlYv4JMhiBiXRe74NwyTdS2o6mK8dVXitbKSp5GvKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjwmR2ITeWp9E4WBP9tXrFe/qBCyqO3Wo5yZefj2U3ztzgHpqQ/sasmyz0BN5r2m/1UZgLD1dk7o9wnDj7vvxMXJ22C5dkLoIk7ON09IFm1vMud8XkdNtFuiangesV5RWl64YCC4hu96LGEtz+jRULUT1Lejjw+A6LNSILApeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf2Ntg7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf2Ntg7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566191F000FF;
	Thu,  8 Oct 2026 07:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791445415;
	bh=Bn6AUcOP5hbUdto3bj+euk/8pOIRLJfWEEHgHcjnjok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kf2Ntg7lArH7v9/K+Ebc6HkJL9k5fj/VBCLS4KkxVw/QCvI+QoFH2xXDEbCOW0dGx
	 vI8VGY8/nmOVtgneRbKnBWt9V2EXXozftiVUNlQqKQuTOKQo2bkkqW+Uwr8ebeBCtB
	 7KP3B9pc/VfhUVQ3nglFlXw7C312D+bziUoMv7GAViOR9AGgw9tqBpWyIKpNHmBJYv
	 KqqNe/9Y6YxGiCYCznhSXP0qfIwfE32spK4GkROSmp9OkbCE97ZuhvOWviev2bKFNP
	 BrMuXHMY6Wuas32cI1p6xoa2wtZi1Izw6EktcTq4YCar0AjMNq/75C58KnGD32UBrw
	 eQSTbE7/wcYrg==
Date: Thu, 8 Oct 2026 00:43:33 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: cdns3: validate endpoint index from setup packet
Message-ID: <asdJpUlHT_BuQWof@hu-petche-lv.qualcomm.com>
References: <20260917103145.3047850-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103145.3047850-1-liuc63@xiaopeng.com>

On 26-09-17 18:31:45, Liu Chao wrote:
> cdns3_ep_addr_to_index() computes (ep_addr & 0x7F) + 16 for IN
> endpoints.  wIndex is supplied by the USB host, so ep_addr & 0x7F can
> be up to 127, giving an index up to 143.  The eps[] array has only
> CDNS3_ENDPOINTS_MAX_COUNT (32) entries.
> 
> Both cdns3_ep0_handle_status() (GET_STATUS) and
> cdns3_ep0_feature_handle_endpoint() (SET/CLEAR_FEATURE) pass the
> unvalidated index straight into priv_dev->eps[index] and then
> dereference the result.
> 
> This is the same class of vulnerability that was fixed in renesas_usb3
> by commit ee0d382feb44 (CVE-2026-31615).

Commit ee0d382feb44 is for aspeed_udc, but not renesas_usb3.
Also, if citing commit, it is better using format: commit <sha> ("<title>"),
do you run chechpatch.pl before submitting?

Besides, where the user could find what is CVE-2026-31615?

> 
> Add a bounds check against CDNS3_ENDPOINTS_MAX_COUNT in both functions.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/usb/cdns3/cdns3-ep0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
> index e29989d57..76642eaaf 100644
> --- a/drivers/usb/cdns3/cdns3-ep0.c
> +++ b/drivers/usb/cdns3/cdns3-ep0.c
> @@ -251,6 +251,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>  	case USB_RECIP_ENDPOINT:
>  		index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
> +		if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
> +			return -EINVAL;

Good caught. And it also needs to add one more condition for !priv_dev->eps[index] since
it may be NULL if endpoints are not enabled at usb_caps, see cdns3_init_eps() for detail.

Peter

>  		priv_ep = priv_dev->eps[index];
>  
>  		/* check if endpoint is stalled or stall is pending */
> @@ -368,6 +370,8 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
>  		return 0;
>  
>  	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
> +	if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
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
