Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502676;
	b=3CVwlL/wxYEh4ZyOiJQ+0cfQ8BOuIwBmyxMTSo7KwCrKL7gxCEEXf1wkytJi+n/2d+Ul
	 3gL7jtEne1I3m0WYbG+7wLMwbtgNpzblz1waiWjaNtS8MXG2ZKGqfszsdqRYaK6PTFvRK
	 GJSYcKgf1RMYD04tZy9CymeKZwmhskSCCyGhB6fyWQMF7m1vASGV+Q4IutBz7qbDcsYsO
	 cDwMM5KDFGDYIT/p9s4OSKAOk3Ke9/59K2wWXP+SuU/Ytp4EuhOjZzRun5GS3OTir0hFN
	 4Ea4dCKOCxDxxhI/KDcx5UZ0ytj8CXMHybCKXuiZ4nXiq+3jsm3uAK9gqa2f/mIeZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502676;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jNQDMG2sl09lgKQ+aRRNvtDCGd3RJ+Yd4E9SNdx9FoA=;
	b=tszqaIlfIJA+NNkTUT+Nwm0siYYV8QYj99PvvTY3F5IYoBo7iUv585Z0WCIfZ1dr6jfJ
	 VnkcM76pqxGGcL2dcgP5ygqzMqUB4pbpRqBcv9ODiPEb1qZIkk+fpVzZTiVbq0IuZm9Wd
	 eAekFbyp/LIsPorcT33UkdYo/8Z07cZP3wqNIlhEG0AX7qbrxFDsQqxTcWglYFHW3s+9p
	 bHCA9nstml1p3dw7jzf+X0UKX00MPdWN4yPEdmpKlJdpp9jRGGI6WdRZEuwwwvAN/M7hJ
	 ocOAXrbznTw1dYj7ezmUUS4Gsh4fizB2cZ1x183GN8LHDV0o6b35Q0vXLrEKq8SKthA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PDsfoxqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BC606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PDsfoxqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9D91F000C6;
	Tue, 24 Nov 2026 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795502675;
	bh=jNQDMG2sl09lgKQ+aRRNvtDCGd3RJ+Yd4E9SNdx9FoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PDsfoxqyJz8nHu1epgSF9wRGIewazZMe9zjHASwwfuzxYqZlawBGFivFsbbNVLSsK
	 QZ/zYxdUCooXq4HTpqBrs8wsUhQRkjJ54y81YAWJjl/M43Q5QQSDGg9BrTVwukZJjn
	 r+vvcQEXAgQh0/i0CK5n7wE4IHTdXO/u0ScUN7ws=
Date: Tue, 24 Nov 2026 07:44:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuming Hu <huyuming@kylinos.cn>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] USB: dwc2: shut down the wakeup timer before removing
 the HCD
Message-ID: <2026112425-removed-donated-b348@gregkh>
References: <20261124024046.2614379-1-huyuming@kylinos.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124024046.2614379-1-huyuming@kylinos.cn>

On Tue, Nov 24, 2026 at 10:40:46AM +0800, Yuming Hu wrote:
> The wakeup timer is armed from hardirq context (WKUPINT, 71 ms) and its
> callback dwc2_wakeup_detected() ends up calling
> usb_hcd_resume_root_hub(hsotg->priv) when the port is suspended.
> 
> dwc2_hcd_remove() invokes usb_remove_hcd() and clears hsotg->priv before
> it reaches dwc2_hcd_release(), where fd772af9512c ("USB: dwc2: shut down
> wakeup timer before freeing HCD state") performs the
> timer_shutdown_sync().  If the timer expires inside that window, or its
> callback is in flight while hsotg->priv is being cleared,
> dwc2_hcd_rem_wakeup() passes the NULL hcd to
> usb_hcd_resume_root_hub(), which dereferences it without a NULL check
> and oopses in softirq context.
> 
> Shut the timer down before usb_remove_hcd(), so that an in-flight
> callback always observes a valid hsotg->priv and any later rearm attempt
> is ignored by the timer core.  The timer_shutdown_sync() call in
> dwc2_hcd_release() is idempotent and keeps covering the probe error
> path.
> 
> Fixes: 7359d482eb4d ("staging: HCD files for the DWC2 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuming Hu <huyuming@kylinos.cn>
> ---
>  drivers/usb/dwc2/hcd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 2e1927dfa..0d6549832 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -5377,6 +5377,14 @@ void dwc2_hcd_remove(struct dwc2_hsotg *hsotg)
>  	if (!IS_ERR_OR_NULL(hsotg->uphy))
>  		otg_set_host(hsotg->uphy->otg, NULL);
>  
> +	/*
> +	 * Shut down the wakeup timer before the HCD is removed: its callback
> +	 * reaches usb_hcd_resume_root_hub(hsotg->priv), which must never see
> +	 * hsotg->priv == NULL.  The call in dwc2_hcd_release() is idempotent
> +	 * and still covers the probe error path.
> +	 */
> +	timer_shutdown_sync(&hsotg->wkp_timer);
> +
>  	usb_remove_hcd(hcd);
>  	hsotg->priv = NULL;
>  
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
