Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5A3DC871;
	Tue, 29 Sep 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698834; cv=none; b=G4rxAIOarKPtiECkENsdP/GT9mmy505zGo+45ytsoTc7rHLFkyCVUWB/OEe2dG6W4x00Mio7GtxEohsqbS8XJwvXboddMe4Cwa3Rle6nkth6u0tChU8O3SyGxtZ0dbW8SoZ2BLSAZiPLPYc5VVmQYTjzlMPF82EWuA77R8oPuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698834; c=relaxed/simple;
	bh=O2NjalWefRbmMemw6DAf/zj6tTtcp1mid8rM323fVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmhM59qdvRaZasYu+fBmCsNanf4dGGsK0Km6Ix9D/Yuji/2JlnPq7zFj5amKexMOV1UItRz6wmaCt5EPt/gBOkXpesgShDFptzen84bxWnDO5F/AcAItmjIcQFum5EDYpFeRLWkWcLehH6nswV/pAqwAtsL/ThwfE7XYrmz0dRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=kM8XKP3o; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="kM8XKP3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1790698825; bh=O2NjalWefRbmMemw6DAf/zj6tTtcp1mid8rM323fVUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM8XKP3oVKpzgbYs35EZGejOuV+EXUZujNOidVao0iIwVe6xD+mvE4T3OgBCp5SoA
	 tiYTsCLAqQgwoysfQDPcjSEE0S2Q5ccZGzbyTTGaaPPZ1Xudhs9BUeiHXA/ouFM6tt
	 T+mzb6nwTc3v1/5jCMlSFQpQImbpE+f/LONjTsE2UJtm0ilYmSTetFZcfR3/RlMYFg
	 kXtA9Ml2WniPnP4SGlzLdN1lvKBVkSBw56nLy5RbngLibcnddEaCFwCb+js0Wsjp8H
	 6cj+qgCWoTpFAwaOv49EuxASInBEywWM2QoIiPMUBHzrwgt18MjKnCHWNCJxeth13P
	 xjE9UMrzDCAAQ==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 1C21A40B86; Tue, 29 Sep 2026 17:20:25 +0100 (BST)
Date: Tue, 29 Sep 2026 17:20:25 +0100
From: Sean Young <sean@mess.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] media: rc: Fix simulated TX timer lifecycle
Message-ID: <arvlSbG0Z0FGxq3l@extorris.mess.org>
References: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn>

On Tue, Sep 29, 2026 at 10:31:05PM +0800, Runyu Xiao wrote:
> The ENE driver only initializes tx_sim_timer when TX simulation is
> enabled for hardware without native TX support.  However, ene_remove()
> passes the timer to timer_delete_sync() unconditionally, and
> ene_tx_sample() uses the global txsim parameter when deciding whether to
> arm it.  Thus a normal device, or a device with native TX support and
> txsim enabled, can operate on an uninitialized timer.
> 
> Track whether simulation was actually enabled for each device and use
> that state for timer arming and teardown.  Since the simulation callback
> rearms the timer, shut it down permanently before freeing the device.

I think this patch is correct, but I am not sure txsim is really needed
in the source code. Maybe it's better to just remove txsim module parameter
and all the related code.


Sean

> Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/media/rc/ene_ir.c | 6 ++++--
>  drivers/media/rc/ene_ir.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
> index 6f7dccc96..9d0279667 100644
> --- a/drivers/media/rc/ene_ir.c
> +++ b/drivers/media/rc/ene_ir.c
> @@ -652,7 +652,7 @@ static void ene_tx_sample(struct ene_device *dev)
>  	dev->tx_reg = !dev->tx_reg;
>  exit:
>  	/* simulate TX done interrupt */
> -	if (txsim)
> +	if (dev->tx_sim_enabled)
>  		mod_timer(&dev->tx_sim_timer, jiffies + HZ / 500);
>  }
>  
> @@ -1032,6 +1032,7 @@ static int ene_probe(struct pnp_dev *pnp_dev, const struct pnp_device_id *id)
>  
>  	if (!dev->hw_learning_and_tx_capable && txsim) {
>  		dev->hw_learning_and_tx_capable = true;
> +		dev->tx_sim_enabled = true;
>  		timer_setup(&dev->tx_sim_timer, ene_tx_irqsim, 0);
>  		pr_warn("Simulation of TX activated\n");
>  	}
> @@ -1103,7 +1104,8 @@ static void ene_remove(struct pnp_dev *pnp_dev)
>  	unsigned long flags;
>  
>  	rc_unregister_device(dev->rdev);
> -	timer_delete_sync(&dev->tx_sim_timer);
> +	if (dev->tx_sim_enabled)
> +		timer_shutdown_sync(&dev->tx_sim_timer);
>  	spin_lock_irqsave(&dev->hw_lock, flags);
>  	ene_rx_disable(dev);
>  	ene_rx_restore_hw_buffer(dev);
> diff --git a/drivers/media/rc/ene_ir.h b/drivers/media/rc/ene_ir.h
> index c1c44e86e..f44cbc034 100644
> --- a/drivers/media/rc/ene_ir.h
> +++ b/drivers/media/rc/ene_ir.h
> @@ -218,6 +218,7 @@ struct ene_device {
>  	int tx_done;				/* done transmitting */
>  						/* one more sample pending*/
>  	struct completion tx_complete;		/* TX completion */
> +	bool tx_sim_enabled;			/* simulated TX is enabled */
>  	struct timer_list tx_sim_timer;
>  
>  	/* TX settings */
> -- 
> 2.34.1
