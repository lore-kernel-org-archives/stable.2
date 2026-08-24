Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0F353A7C
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583508; cv=none; b=IQIiRRrbZYHigRtw9Kosa/JU88ec92nkYzZbncllqU/wWxvJujm7Mvkk5YwB99cawDoVIDmuHnrra9sqTjzhmOIr5/Fgs1zGI5AMOZm/iZTwe3Nngl8VRvd6qlZk/NN1tukTiTV5O2RyhTYzexpk/PtxdZ/Zb2KQ/LH6ERbAm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583508; c=relaxed/simple;
	bh=aJFHMWnLiDOrDYltzVzqv+mKB+XDPIxzpoPJhS6/pEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByQAGuz1ai/u/4qVNw5qbFQXtXQuJHVDPbrIMtnf6s3muhqZ0bhBsK4xV5u6NnQlJyv1L6zRRa8OyrP1wd1xorVhEUJ3P9cQs6w/Jl2JCNEuxxB5BI8PmomawjNVGdpxxPuy58V7/k01mCVZQl9GXEOpYW/wo2348Cpt75y3vO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3E9Lrxb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3E9Lrxb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso7413815a12.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787583504; x=1788188304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mt+izB0tPjImzvLGpW/8ryECQ2jcmXahZC8IvMsPZMQ=;
        b=a3E9LrxbfBrJaFMq4v1d+EMutBm143W4COlsmVfrpZ/5KSJDbVzQFf2T0Z5yE7OKCh
         CuUdZZvOPUXk2t7l5M+v98VDFpwGxLumzewvWakPGakGgG1cf5HwLFSGKV+YWqCN+H6z
         5LYVEH2VkxClqx4G9BhIJuqmCrh04i0ZubRNRUR3GrrWg5KVmdRGSfbGnqSBUWA0tBZm
         lffUMcDil980/UB9lzG5wShePIapqwuzNefrlcbe9p9GDFQY5dZzzVJ+qv781Y2Owwyw
         d/ROy4ggNhu7ENXzz0yEY/2DEFfEzDAOgIDULgGGrbOCwavgbHP5BOElvzIHOA0uiiSD
         Infw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583504; x=1788188304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt+izB0tPjImzvLGpW/8ryECQ2jcmXahZC8IvMsPZMQ=;
        b=JI0TRw7Au6DJvtrXbRA/0Dg92mOrpQ91D1aHidD4XT16cWVoHDipCEQEC9IFrF12Jr
         8cQTFwbgAQ6qVTHm1bA5Gv/HM3fom4iHInHDd5643OODaLAply3K9DkfKdkJXCOvp04K
         vHFghdrh0zVIx5Ca+b3s27w4DP8OJ7W7GM2/7OV1FoFTGHrsI9jA3tyu9dg+xkpGTa74
         AVeF0+eXP2zf1LB1Ar9a5Pd+TUEsK1in58y+n3OaG/U0yE+p7ncGyL4ZX3p74i6A7DyT
         /zW0uKPIp8rj7JEvW0wFzm/MyysH4Z1+YHLic7HSWxXpBY1qY5Eilqh00YzerRpGvCYs
         URlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1+lyKN7SpheKuglMRIgpfb9MTfH2VYxqX9PzhR6ad5eb7jWyTOauBzIvDDQGf/Jl60F0AiDw=@vger.kernel.org
X-Gm-Message-State: AFuF++m3hTxcE44Ydxudu2Jw5QQS93sKv7rzT3F1oAsZTsBGkGBkNFzX
	i93Z9kK6PnmRltlTV69nXgsy8HIlddGTkatAr0odm1TeANpaD7uTrDssPIZjJWYzOvY=
X-Gm-Gg: AR+sD10c05oPi7dEIJ404hhj/M/IWqXs3O7OlIYvrKn6H6KYsuANho3U4dEVPD+I+uB
	Aus+7FhOa+fhM7FDPRYtJAfhxOXHsceQ2aiwTVzCUhurkFOejfTbJG6XTXMCIinUdNd9cV+quxY
	Ac8TQDK3NCD5jT/zj09NEsTwJhtNHAj/HGlAAkcNyVxsjJtKv4YCYjNrOUk8E+is3kLtBTWMgyU
	FrSPXVZFoz03jDrwMCZo27wBN1Xsp87+xWw6425F8EwFNm0TJvSQubZk2dgUphTKAABl/sRJrb3
	Y1KrJlP1FblXgURaZT4kCT/Hz3NYKkmZOQqhStQxooBno91jmH32YZVMEnWBQ5e9hFpobBkZJIo
	DXG/j0x9JqgEaWz5gfWslatqE3AbQCo4aYMfIl+O7AVMK7fZqUmNT67ZZbZm4vgS0RoKC79/OIl
	ZN6WQQNkesZ5iESGMldP4P7piY7uDG99AdG6PR1ER2SmblTBetJ2ybcqBoRCTmbt/WDuBmS3s=
X-Received: by 2002:a17:907:724d:b0:c21:393e:6d10 with SMTP id a640c23a62f3a-c246d5eac42mr2571951366b.4.1787583503928;
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm1414002666b.43.2026.08.24.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
Date: Mon, 24 Aug 2026 16:58:11 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: wwan: qcom_bam_dmux: fix TX DMA channel
 use-after-free
Message-ID: <aoxcA2fWKjK3w1qb@linaro.org>
References: <20260822085214.1595-1-getshell@seu.edu.cn>
 <20260822085308.1089-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822085308.1089-1-getshell@seu.edu.cn>

On Sat, Aug 22, 2026 at 04:53:08PM +0800, Hongyan Xu wrote:
> The modem power-control interrupt can release dmux->tx while the command,
> netdev transmit, or deferred wakeup paths are preparing and submitting
> DMA descriptors. A runtime PM reference alone does not order those paths
> against the modem-driven interrupt.
> 
> The pc and pc-ack IRQ actions do not encode the modem protocol order. A
> pc=false edge raised before a new host power vote is acknowledged can
> therefore be handled after runtime resume observes the acknowledgment and
> starts using TX. On the other hand, acknowledging a new pc=false transition
> while the acknowledged host vote remains active lets the modem power down
> the DMA engine underneath the driver.
> 
> Serialize power-control state with a mutex and distinguish a requested host
> vote from an acknowledged one. Publish each vote acknowledgment and its
> completion under that lock. Before publishing the host-vote acknowledgment,
> sample the actual pc line and process any delayed transition. A valid
> pc=false transition is then handled before runtime resume returns, when no
> path can submit through TX. The channels are released before pc is
> acknowledged, and a queued BAM_DMUX_CMD_OPEN remains queued for the new TX
> channel.
> 
> If pc goes low after the host vote was acknowledged, refuse the pc
> acknowledgment and keep the DMA channels allocated. Remember the pending
> transition so runtime suspend can first release the channels and only then
> acknowledge pc=false. This preserves the protocol ordering without exposing
> a released TX channel or cancelling an OPEN command that already succeeded.
> 
> Use an enum for the host power-vote state, initialize the power mutex with
> devm_mutex_init(), and use scoped mutex guards in runtime PM paths. Let
> runtime suspend perform cleanup when runtime resume cannot acquire the TX
> channel. Keep both state IRQs disabled until the initial probe state is
> committed, and disable both before final remove cleanup.
> 
> This issue was found by the author's in-house static analysis tool.
> The patch was reviewed by the author.
> 
> Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> 
> ---
> Changes in v4:
> - Replace the power-vote booleans with an explicit enum state.
> - Remove the redundant RX-channel check and use devm_mutex_init().
> - Use scoped mutex guards and let runtime_suspend() clean up resume failures.
> - Keep both state IRQs disabled until probe initialization is complete.
> - Disable both state IRQs before final remove cleanup.
> 
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8..3756cdb 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> [...]
> @@ -670,10 +701,15 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
>  	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
>  }
>  
> -static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
> +static bool bam_dmux_handle_pc(struct bam_dmux *dmux, bool new_state)
>  {
> -	struct bam_dmux *dmux = data;
> -	bool new_state = !dmux->pc_state;
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	if (new_state == dmux->pc_state) {
> +		if (new_state && dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING)
> +			dmux->pc_vote = BAM_DMUX_PC_VOTE_ACKED;
> +		return false;
> +	}
>  
>  	dev_dbg(dmux->dev, "pc: %u\n", new_state);
>  
> @@ -682,13 +718,41 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
>  			bam_dmux_pc_ack(dmux);
>  		else
>  			bam_dmux_power_off(dmux);
> +	} else if (dmux->pc_vote == BAM_DMUX_PC_VOTE_ACKED) {
> +		/* The modem must keep the DMA engine on until pc is acked. */
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_DOWN_PENDING;
> +		dev_err_ratelimited(dmux->dev,
> +				    "refusing pc down while host vote is active\n");
> +		return false;

Sashiko notes here that the use after free is still present if

	dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING

and the modem sends a spurious PC interrupt. The if statement for
entering this branch should probably include
BAM_DMUX_PC_VOTE_DOWN_PENDING so we don't accidentally overwrite it.
That by itself won't work though since bam_dmux_runtime_suspend() reuses
this function to clear the VOTE_DOWN_PENDING state...

https://sashiko.dev/#/patchset/20260822085308.1089-1-getshell%40seu.edu.cn

>  	} else {
>  		bam_dmux_power_off(dmux);
>  		bam_dmux_pc_ack(dmux);
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
>  	}
>  
> -	dmux->pc_state = new_state;
> -	wake_up_all(&dmux->pc_wait);
> +	WRITE_ONCE(dmux->pc_state, new_state);
> +	return true;
> +}
> +
> +static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
> +{
> +	struct bam_dmux *dmux = data;
> +	bool new_state, wake;
> +	int ret;
> +
> +	mutex_lock(&dmux->power_lock);
> +	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> +				    &new_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	wake = bam_dmux_handle_pc(dmux, new_state);
> +	mutex_unlock(&dmux->power_lock);
> +	if (wake)
> +		wake_up_all(&dmux->pc_wait);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -696,9 +760,30 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
>  static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
>  {
>  	struct bam_dmux *dmux = data;
> +	bool new_state, wake = false;
> +	int ret;
>  
>  	dev_dbg(dmux->dev, "pc ack\n");
> +
> +	/* Process an earlier pc edge before publishing the host-vote ack. */
> +	synchronize_irq(dmux->pc_irq);
> +	mutex_lock(&dmux->power_lock);
> +	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> +				    &new_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	wake = bam_dmux_handle_pc(dmux, new_state);
> +	if (new_state && dmux->pc_state &&
> +	    dmux->pc_vote == BAM_DMUX_PC_VOTE_PENDING)
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_ACKED;

Sashiko notes here that "if the modem asserts the PC-ACK interrupt
before the PC line goes high, bam_dmux_pc_ack_irq() will see
dmux->pc_state as false. The vote will remain stuck in
BAM_DMUX_PC_VOTE_PENDING instead of transitioning to
BAM_DMUX_PC_VOTE_ACKED."

https://sashiko.dev/#/patchset/20260822085308.1089-1-getshell%40seu.edu.cn

I think Sashiko is right. The situation pointed out by Sashiko is even
the typical case, because normally the sequence is:

 1. Host requests pc vote=true (PC_VOTE_INACTIVE -> PC_VOTE_PENDING)
 2. Modem acks request
 3. Modem powers up hardware
 4. Modem indicates pc=true

Do we even need the BAM_DMUX_PC_VOTE_ACKED state? For bam_dmux_pc_irq()
I think the question at the end is if dmux->tx != NULL, or am I missing
something?

>  	complete_all(&dmux->pc_ack_completion);
> +	mutex_unlock(&dmux->power_lock);
> +	if (wake)
> +		wake_up_all(&dmux->pc_wait);
>  
>  	return IRQ_HANDLED;
>  }
> [...]
> @@ -724,50 +822,58 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>  					 BAM_DMUX_REMOTE_TIMEOUT))
>  		return -ETIMEDOUT;
>  
> +	synchronize_irq(dmux->pc_irq);
> +
>  	/* Vote for power state */
> -	bam_dmux_pc_vote(dmux, true);
> +	bam_dmux_pc_vote_protected(dmux, true);
>  
>  	/* Wait for ack */
>  	if (!wait_for_completion_timeout(&dmux->pc_ack_completion,
>  					 BAM_DMUX_REMOTE_TIMEOUT)) {
> -		bam_dmux_pc_vote(dmux, false);
> +		bam_dmux_runtime_suspend(dev);
>  		return -ETIMEDOUT;
>  	}
>  
> +	synchronize_irq(dmux->pc_irq);
> +
>  	/* Wait until we're up */
> -	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
> +	if (!wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
>  				BAM_DMUX_REMOTE_TIMEOUT)) {
> -		bam_dmux_pc_vote(dmux, false);
> +		bam_dmux_runtime_suspend(dev);
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* Ensure that we actually initialized successfully */
> -	if (!dmux->rx) {
> -		bam_dmux_pc_vote(dmux, false);
> -		return -ENXIO;
> +	{
> +		guard(mutex)(&dmux->power_lock);

There is scoped_guard() for this pattern.

> +
> +		/* Ensure that we actually initialized successfully */
> +		if (!dmux->rx) {
> +			ret = -ENXIO;
> +		} else if (!dmux->tx) {
> +			/* Request TX channel if necessary */
> +			dmux->tx = dma_request_chan(dev, "tx");
> +			if (IS_ERR(dmux->tx)) {
> +				dev_err(dev, "Failed to request TX DMA channel: %pe\n",
> +					dmux->tx);
> +				dmux->tx = NULL;
> +				ret = -ENXIO;
> +			}
> +		}
>  	}

Please keep the old structure (if (...) return). If we need to wrap each
of the failure cases with bam_dmux_runtime_suspend() we should perhaps
move the TX initialization into a separate function and then call it
here.

>  
> -	/* Request TX channel if necessary */
> -	if (dmux->tx)
> -		return 0;
> -
> -	dmux->tx = dma_request_chan(dev, "tx");
> -	if (IS_ERR(dmux->tx)) {
> -		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
> -		dmux->tx = NULL;
> +	if (ret)
>  		bam_dmux_runtime_suspend(dev);
> -		return -ENXIO;
> -	}
>  
> -	return 0;
> +	return ret;
>  }

Thanks,
Stephan
