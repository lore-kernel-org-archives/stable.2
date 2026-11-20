Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183870;
	b=4v2aRskHyMzdrnvip3uENPovfDoTD41IhTCf2MA42PlG0GS2k6PWiB7RKV46r5pxsUoH
	 h5qbFA0OHe6jvFywe2AcY7CG26S0bP6XOBVeWOZ2aqcghpGit/Fvqzci9KR8sfr21toq0
	 yr56zs47vfyvJ77tZ1F/UN6DpjiBJOpjAF+WJu2XVQm2WqxcmFYsrOfzSY7zDXwzLnQNw
	 FCZ/kxHy/5k3dzPyBaZK8j6/2m65V7F6T+5lpLnKiUmsgBjx8o/uRI8Ey5pqxlVRHurjU
	 8grG+s2PKqjek4DtqqO7KwyyxLeDhgK/Gi1OBOfVPRu25HjERAkMz0HWCKxsyjyenAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183870;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e8cyNCwwJpwrnbTKgthNYWMwAxuzTp/OOV+KIcoKBwM=;
	b=uUETJeDzpKwO6BJWzf/tsfRxuNwdIEV0VpSjOoq1JKBlP9dGUtfzjRQsI2wQODnG0WNz
	 3xdUi1i2ZQwHK8HAyf4WKyh6qOQXgFxVlyTU13YQdXIrwAMm21jQW6guZ1q0WEBhdKDfR
	 h9jhZajS3UiCt5k1EeNXUxy+UTIDrQW/F9uOfh0fqe8RFu3PZvCquSnFIz9bibs/7dxMJ
	 FrSyK4wuI1B/SuK5l5efFb90KaREvofBMGM5yaTAajFYQROuNbRZNKdhFNDJDsVL+Azzp
	 blpQTMG7xcLvAqWb4+bWTsFCYazIkOEkZmj9eXnqTTbjw60EcAaaeSzZvJk/2BZA8DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1ok77tlc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B14606A320;
	Fri, 20 Nov 2026 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1ok77tlc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E681F000C4;
	Fri, 20 Nov 2026 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183869;
	bh=e8cyNCwwJpwrnbTKgthNYWMwAxuzTp/OOV+KIcoKBwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1ok77tlcFxGtSiMAxu322+6eCvWvfM0FqxQutVD99AOhibWjIp/uQzGPpx3okVmeS
	 pBBEFM2ysnamRVUMVnP/NP1faQsm8MMq2pNfm8oX66Ob4fZPUQ4B3NcZQT5SPeFIvW
	 uJajDXW78BY7igFjaADD+FHKz+U6s4EdV98LMXOY=
Date: Fri, 20 Nov 2026 15:11:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: musb: fix use-after-free in musb_remove()
Message-ID: <2026112054-sweep-flap-b94d@gregkh>
References: <20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org>
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
In-Reply-To: <20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org>

On Sat, Nov 07, 2026 at 12:46:17PM +0100, Joshua Crofts wrote:
> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
> before usb_phy_shutdown() is called, causing a use-after-free bug.
> 
> Reorder the function so that usb_phy_shutdown() is called before
> musb_platform_exit(), the same way as musb_init_controller() does in the
> error path.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-d180c2b9-0006-4638-a22b-13df8c201235
> Fixes: 39cee200c23e ("usb: musb: core: call init and shutdown for the usb phy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/usb/musb/musb_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 73ac25f53698..8e52246de948 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2642,6 +2642,7 @@ static void musb_remove(struct platform_device *pdev)
>  	musb_disable_interrupts(musb);
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  	spin_unlock_irqrestore(&musb->lock, flags);
> +	usb_phy_shutdown(musb->xceiv);
>  	musb_platform_exit(musb);
>  
>  	pm_runtime_dont_use_autosuspend(musb->controller);
> @@ -2650,7 +2651,6 @@ static void musb_remove(struct platform_device *pdev)
>  	musb_phy_callback = NULL;
>  	if (musb->dma_controller)
>  		musb_dma_controller_destroy(musb->dma_controller);
> -	usb_phy_shutdown(musb->xceiv);
>  	musb_free(musb);
>  	device_init_wakeup(dev, 0);
>  }
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261107-usb-uaf-fix-bedcd9cd8f4b
> 
> Best regards,
> -- 
> Joshua Crofts
> 

Does not apply to the usb-linus branch, please rebase and resend.

thanks,

greg k-h
