Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186075;
	b=4D/F32uG9OTL7Nka2CBH8n9sjwIG3bQoEyOujuAX0EevqQzsxnK1pDh45D0vpHn8l9mg
	 wzuBFl6c5zbV2QU+neW55QCWWQG07La3vUZ9RHNWesb6tsDLTCxdd6En76AJTC+IwyQeZ
	 PLV8PPYuSnkm9aRdsqAndUoQVkg812ja317CTqnKp8BwA0K8FDQMsjKOh7oLksFt5eL+s
	 Z9bXZMfpLL8aUqmNH9Ze/OQwRDnm5KABv99P1H9X+GbweIWKuxUqTWvJ2CXCutP6+E5xb
	 qa0rzxB3yE3yru3RbxJ0A+r/6qMqPIpE/qatNKK7AA0aWhNBQq55hqcSrLEaPqlbyCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y7LIFhPnZZ8YCdb/HuuAHppslYgfSxYyeNpo0KOxO+s=;
	b=2pAlWh8KV5D8wVD5Qrrtz8jcxN91ffEoHAtzqPuJlJKSBstRlgurV3vjP0RLJxB0STf9
	 Id1Uu0zlJYGruideVjaGl9WZ4q9B9ekwI2F9hPRX4o0JXcm50PsWrfelgQgyjCWlXnE4I
	 S26UmHsNY5O8uVZY+hDG90HLmT4SiH71pcQfdzKt7zMSCpWrti9t+eqokMY4irCujo4vV
	 8Ua5JRdYFi6cr/Wd09t8DZg16goSwXz1PFx/DdYjpcd1Gboh9J86QPoKwRuck9IvRJjJY
	 mv9jS9g1gO7JeOKqM+/Phu6spc3UQ4kHCelsaN9LAJUPXIMSXa2Xp01bxc+Fe2tEzyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dz9auSpZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84130606A320;
	Fri, 20 Nov 2026 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dz9auSpZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFBC1F000C6;
	Fri, 20 Nov 2026 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795186074;
	bh=Y7LIFhPnZZ8YCdb/HuuAHppslYgfSxYyeNpo0KOxO+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dz9auSpZ86t3zX5U/lMNEhN5PtdfuVQtswv0PMVjEsE1ABGdWE/DPdSfRL2b91KFH
	 XtFBWWv8B17wznkQCtC9j0SRDHQ/kVUMcIMP8qiiRJWsBOgTPeYmVR9B9XRIEs6TMf
	 RXZg5jaLMWaTnD7b3J1mtd/cumPVze1erItGNRWg=
Date: Fri, 20 Nov 2026 15:47:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: musb: fix use-after-free in musb_remove()
Message-ID: <2026112044-screen-punch-ca38@gregkh>
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

Does not apply to usb-linus
