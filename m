Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE575407CCF
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187116; cv=none; b=fWBp+ld2Dm9AV4FJqbobaBZJEOmGZC7ruukhyAAtbKbOAyMQQMzp3V8KbZitAdeqSpfYlhKjJYQSUXMUxz+7OwNQTic107GRYF4f7A++3livH+6ayOlZ7U1OirN+fO1yM6TiNpDYyj2Ml/lSdTJDltu8pDXgb4hBRMVPgVJNE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187116; c=relaxed/simple;
	bh=9CbWY5bVY3WPiB2hF0opJQ3dHD20rbFUitVIN5OFEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ges7lddgDLJXpEk9tBytjkxARBOkUQ0n3NGhHyt+VX1fICR2rqEztbDQPHfL9hiB99hiO/D3dp/2QIOlGU+x5ArfoWPMVs4zhxYutz/NOEjDvv2JTMEKK1q6SyDcgkStw67PfACV+z+aG2TGWhO5/9XitDcn01gyf1cp6ronhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=nmYKUGVX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="nmYKUGVX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9df4732cso82546676d6.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781187113; x=1781791913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dniOIRcqBtEvdCN2h2so0q8LhV25xoLRKWKiAUTeFA=;
        b=nmYKUGVX6Som6rOt+ZpvWLstw1H4nj8n5JgK/5mc3KNZojNE9yr2bJpEKbWVuzzzfG
         ab3FHj+Jt0Z/nUvHejbXBZR//egOuOyaB/DsLujY3sMyR3TrJmrWW18bxhQY4WEZu0Al
         fowhEjqJqU5SqMNOMqmmQ6ZYWMq51/vMC7kA8b9BcaYnQPKJsSeQgPVGB9RAAl7MyfcZ
         hr3ns+rjL2tRC26I/dDtk6LOg6vhKl/PGd7XWrpAqp+ePIUMAO3CVtSanZ8sGSbLpbZ+
         oOmHL67og6AY5GTAZCF3AbvI3aGmi/Z/cnTdmIWdYOcJ4bbl/egG+uuRwAWZsih67f0h
         en5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187113; x=1781791913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dniOIRcqBtEvdCN2h2so0q8LhV25xoLRKWKiAUTeFA=;
        b=SkR858P9ZqTua2FDeAI+lOzuU8OZktnMbDd13C9Yz83JnxshwJn527nic6mDAn8JhK
         uOtYQndm/J6zPoKPNxdOjbpytZAa4EV+/5kxH4brnuhQPu38SmZSLEf2A69RToECq/ki
         5ylX1MlRseVRWWslnOfhNAQjxCuGePzmxYFoWl6nzMaVUR13zIuMVSj99xMiB/i2Wkv2
         5mDGC+US0wFwFQr1wcMjC/JsUy1A+RoanuG0do2viN5NEKbaRmrWUSTC40pimlBkHGxv
         3Tdx1547K4jt9+0gwXA3CdNrMwrXGgM3poDbZ61vXpYyVDbkjeFiNeux+bFiNarJXKwu
         aD4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9+1OTMict5UBVw5idrfmlYHJ1WfEBMNKp+yLRp4JrvHYMzbcMzc4UATMzNHtd/LL8B3OM5gts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LvIQSRBbMGW1101k/vvo0mCCsWg/ZUuHAQYu0K8QaAQ9XTtv
	QhOIyOvB9Jc4xhgPZSfjt0cGcAHAqNis4385Cbxd79QOp949qMpqI7ZslO4N92yy7g==
X-Gm-Gg: Acq92OFaSWtWJ2HG4K7UJ8i3JOasXWmhIHL1pn3ngB3xqrn7kTzMlSNvJWoVMOhzD5W
	BlNePPjsebiL1/J4a3Zhe7bvIAuVS9taqEfXXdeigfJvo3fW/265nSLjo/4t4lHQv6QSaEM/XB7
	6NjkDlEzQeKB002WQGsfemEuAE/ut0vMxikodC39uv71pCwvBGKUGqwxttz6vvG1PdwjnSb3eUW
	l58qK6nJrFXNJB2vOKkqJBsabASxzkNKO4S0705bLDGPf2hCkIBJBV6ikHMVEs/+DMy37SPCdDv
	rmCjZQ5iz4TXF12t1FVVnVk5TxQHuV7QzrkDf/xfMmkS5vCXp+cjwa8FVL0DgHnH4j0J0Wdx49b
	GFu2AH0JjLBWjk9nrPtCtE38HXhiN3ymJSBGDKyT9m7s0WRFYynR6EHK14iqfVFSpNQ+BOPHdSr
	MQYHzjnWrYbqgwJFyT+XLojncEn+2xz8aRifg/25CfFoDIEPHsVtDAScjZqhACjHM=
X-Received: by 2002:a05:6214:311e:b0:8cc:f3bb:e15c with SMTP id 6a1803df08f44-8d1db5ed518mr43456926d6.41.1781187112314;
        Thu, 11 Jun 2026 07:11:52 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1eb2b40acsm18450906d6.45.2026.06.11.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:51 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:11:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
	khtsai@google.com, thorsten.blum@linux.dev, kees@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: hub: fix refcount leak in usb_new_device()
Message-ID: <e7077523-3558-48e9-9fd8-4e2f266437e5@rowland.harvard.edu>
References: <20260611130223.80884-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611130223.80884-1-vulab@iscas.ac.cn>

On Thu, Jun 11, 2026 at 09:02:23PM +0800, WenTao Liang wrote:
> If usb_new_device() fails after pm_runtime_get_noresume() has
> been called, it does not release the corresponding reference.
> In the successful path, the reference is properly dropped via
> pm_runtime_put_sync_autosuspend().  However, when an error
> occurs during enumeration (e.g. usb_enumerate_device() failure)
> or device registration (e.g. device_add() failure), the function
> jumps to the "fail" label.  That error cleanup path only disables
> runtime PM and marks the device as suspended, never putting the
> usage count back.  This results in a permanent imbalance of
> power.usage_count, preventing future runtime PM state transitions
> and proper device cleanup.
> 
> Fix the leak by adding a pm_runtime_put_noidle() call before
> pm_runtime_disable() in the fail error path, which releases the
> reference without queuing any suspend work and appropriately
> matches the pm_runtime_get
> 
> Cc: stable@vger.kernel.org
> Fixes: 9bbdf1e0afe7 ("USB: convert to the runtime PM framework")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 24960ba9caa9..05f1a4267aec 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2731,6 +2731,7 @@ int usb_new_device(struct usb_device *udev)
>  	device_del(&udev->dev);
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
> +	pm_runtime_put_noidle(&udev->dev);
>  	pm_runtime_disable(&udev->dev);
>  	pm_runtime_set_suspended(&udev->dev);
>  	return err;
> -- 
> 2.50.1 (Apple Git-155)
> 
