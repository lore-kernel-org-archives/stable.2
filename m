Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3C357D09;
	Wed,  9 Sep 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944588; cv=none; b=bZ3KKvI8mrBmu45xz5YbHqlGmhM8jSYalbOp/KBF6kx17YkYq5OchD335kR9olzaSbj9rOfSZKikTSQ6DV2EEMyNmyMMfSWiDVoz1GyhP8xLBLCo6mBe9G/hFlzfuCduUsLU30h6GnpZtgzdVPh1daFzSW7LRCRZJShMWYkOATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944588; c=relaxed/simple;
	bh=w1N1zPkQ9mGPXQZD3zwD2xR1mRDu14CBGKK8vaPJxRo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vlys+kHcD5nSdt9RydewXSRVQF2AfuaGXogztr1fAj3ToIysoLJ52gCq9IQmQgUhxJ4PAaxaMn4pCBlLZbax5iODDUjlBIgBNMRF+6PVVmLCsp7RbZFxCcfQ6kn9Xf+jiGikUaZSnV+nKl0elg3L02+SdRYd2XTNO9Ec4A3KpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxvJre/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxvJre/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C759D1F00A3A;
	Wed,  9 Sep 2026 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944586;
	bh=AdhICVDd3XeO9TrCmQEOzxpFVAahhrpfNkZGct+poOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UxvJre/dJstmYmqqKLLe7aEntPNoqZpVbxvA2jWRZNV/Pf9rWqZFoYom3wLXDJWi0
	 m2uTDCL8PRCRWxjVBL58zKwL/mAlhx0f2Gket4Al7sD0a0JvAo537fGpfgbHTtKjD8
	 dtARbgWiywnd78DybldGxX0kn62Hx0ornJ6RuzM3shxFcgxNXheDnS9dg0Z0RB/1Af
	 DBr18u3iG8icamiIWeiyuQ2uVqqQlMBajWV1eB8LGWQiPVNa3VUBjJyUU0oua1IlKB
	 Ss8wjqHa3vz5L2iuY7h074Mh7+ypcvmyZ3oYYg7pp6VDgnIiQavmMwtkBHc3PlDVGP
	 YAaEi1upTid3Q==
Subject: Re: [PATCH net v5] net: wwan: qcom_bam_dmux: fix TX DMA channel
 use-after-free
From: netdev-bot+sashiko@kernel.org
To: getshell@seu.edu.cn
Cc: stephan@gerhold.net, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 09:03:05 +0000
Message-ID: <178894458529.219967.3874306151542640489@kernel.org>
In-Reply-To: <20260903180057.1437-1-getshell@seu.edu.cn>
References: <20260903180057.1437-1-getshell@seu.edu.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0

- [High] The new design (live level re-read via
  irq_get_irqchip_state(IRQCHIP_STATE_LINE_LEVEL) as the only state…
- [Medium] bam_dmux_runtime_suspend() turns a possibly stale
  BAM_DMUX_PC_VOTE_DOWN_PENDING into an irreversible power-down…

Pre-existing issues:
- [High] bam_dmux_remove() cancels register_netdev_work and unregisters
  all netdevs while the RX DMA producer and the pc IRQ are still live;…
- [High] bam_dmux_rx_callback() can run concurrently with
  bam_dmux_power_off() and dereference a released/NULL RX channel.

--

net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free

This adds a power_lock mutex to serialize the modem power-control state,
re-reads the pc line level at each decision point instead of toggling a
cached bool, defers a pc=false transition while the host vote is active and
TX is allocated, and keeps both state IRQs masked with IRQF_NO_AUTOEN until
probe has committed the initial state.

Link: https://lore.kernel.org/netdev/20260822085308.1089-1-getshell@seu.edu.cn/

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d64371..429d34a3cfa07 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c

[ ... ]

> @@ -655,6 +683,8 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
>  
>  static void bam_dmux_power_off(struct bam_dmux *dmux)
>  {
> +	lockdep_assert_held(&dmux->power_lock);
> +
>  	if (dmux->tx) {
>  		dmaengine_terminate_sync(dmux->tx);
>  		dma_release_channel(dmux->tx);

[Severity: High]
This isn't a bug introduced by this patch, but now that power_lock
serializes the power-control paths, is the RX completion callback still
left outside that serialization?

bam_dmux_rx_callback() ends with an unconditional refill:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_rx_callback() {
	...
out:
	if (bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
		dma_async_issue_pending(dmux->rx);
}

while bam_dmux_power_off() does:

	if (dmux->rx) {
		dmaengine_terminate_sync(dmux->rx);
		dma_release_channel(dmux->rx);
		dmux->rx = NULL;
	}

Can the refill see dmux->rx == NULL and oops? dmaengine_prep_config_single()
dereferences chan with no NULL check:

include/linux/dmaengine.h:
	if (chan->device->device_prep_config_sg)

Qualcomm BAM registers device_terminate_all but no device_synchronize:

drivers/dma/qcom/bam_dma.c:
	bdev->common.device_terminate_all = bam_dma_terminate_all;

so dmaengine_terminate_sync() -> dmaengine_synchronize() cannot wait for a
callback that vchan_complete() has already spliced off and started. Should
the RX callback also take power_lock, or check a shutdown flag, before
requeueing?

> @@ -670,10 +700,24 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
>  	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
>  }
>  
> -static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
> +static void bam_dmux_complete_pc_down(struct bam_dmux *dmux)
>  {
> -	struct bam_dmux *dmux = data;
> -	bool new_state = !dmux->pc_state;
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	bam_dmux_power_off(dmux);
> +	bam_dmux_pc_ack(dmux);
> +	WRITE_ONCE(dmux->pc_state, false);
> +}
> +
> +static bool bam_dmux_handle_pc(struct bam_dmux *dmux, bool new_state)
> +{
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	if (new_state == dmux->pc_state) {
> +		if (new_state && dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING)
> +			dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;
> +		return false;
> +	}
>  
>  	dev_dbg(dmux->dev, "pc: %u\n", new_state);
>  

[ ... ]

> @@ -706,9 +795,47 @@ static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
>  static int bam_dmux_runtime_suspend(struct device *dev)
>  {
>  	struct bam_dmux *dmux = dev_get_drvdata(dev);
> +	bool wake = false;
>  
>  	dev_dbg(dev, "runtime suspend\n");
> -	bam_dmux_pc_vote(dmux, false);
> +
> +	scoped_guard(mutex, &dmux->power_lock) {
> +		bam_dmux_pc_vote_locked(dmux, false);
> +		if (dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING) {
> +			dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
> +			bam_dmux_complete_pc_down(dmux);
> +			wake = true;
> +		} else if (!dmux->pc_state) {
> +			bam_dmux_power_off(dmux);
> +		}
> +	}

[Severity: Medium]
Is it safe for this to act on the cached BAM_DMUX_PC_VOTE_DOWN_PENDING
without re-sampling the pc line?

Every other new decision point in the patch calls
irq_get_irqchip_state(IRQCHIP_STATE_LINE_LEVEL) first, but this one
converts the cached flag straight into bam_dmux_complete_pc_down(), which
releases both channels, frees the RX skbs and toggles pc-ack:

	bam_dmux_power_off(dmux);
	bam_dmux_pc_ack(dmux);
	WRITE_ONCE(dmux->pc_state, false);

DOWN_PENDING is only cancelled from bam_dmux_handle_pc() when a later
invocation observes new_state == dmux->pc_state == true:

	if (new_state == dmux->pc_state) {
		if (new_state && dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING)
			dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;

So if the modem re-raises pc and the rising-edge handler is still blocked on
mutex_lock(&dmux->power_lock) when the autosuspend timer fires:

bam_dmux_runtime_suspend()
   scoped_guard(mutex, &dmux->power_lock)
      bam_dmux_complete_pc_down()   /* pc line is high again */

does the driver then acknowledge a pc=false transition the modem has already
revoked, and tear down RX while the peer believes the link is up? The commit
message describes this as the case to avoid:

    "acknowledging a new pc=false transition while the host vote remains
    active lets the modem power down the DMA engine underneath the driver"

Would reading the line level here before calling
bam_dmux_complete_pc_down() close that window?

[ ... ]

> @@ -817,31 +939,40 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_enable(dev);
>  
> -	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
> -					IRQF_ONESHOT, NULL, dmux);
> +	ret = devm_request_threaded_irq(dev, dmux->pc_ack_irq, NULL,
> +					bam_dmux_pc_ack_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					NULL, dmux);
>  	if (ret)
>  		goto err_disable_pm;
>  
>  	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
> -					IRQF_ONESHOT, NULL, dmux);
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, dmux);
>  	if (ret)
> -		goto err_disable_pm;
> +		goto err_power_off;
>  
> +	mutex_lock(&dmux->power_lock);
>  	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> -				    &dmux->pc_state);
> -	if (ret)
> -		goto err_disable_pm;
> +				    &pc_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		goto err_power_off;
> +	}
>  
>  	/* Check if remote finished initialization before us */
> -	if (dmux->pc_state) {
> -		if (bam_dmux_power_on(dmux))
> -			bam_dmux_pc_ack(dmux);
> -		else
> -			bam_dmux_power_off(dmux);
> -	}
> +	bam_dmux_handle_pc(dmux, pc_state);
> +	mutex_unlock(&dmux->power_lock);
> +
> +	/* Start handling state changes after the initial state is processed. */
> +	enable_irq(dmux->pc_ack_irq);
> +	enable_irq(dmux->pc_irq);

[Severity: High]
Can a pc transition be lost in the window created here between the level
snapshot and enable_irq(dmux->pc_irq)?

The in-tree DTs for qcom,bam-dmux (msm8916.dtsi, msm8939.dtsi) parent these
interrupts on SMSM:

	interrupt-parent = <&hexagon_smsm>;
	interrupts = <1 IRQ_TYPE_EDGE_BOTH>, <11 IRQ_TYPE_EDGE_BOTH>;

and smsm_intr() advances the cached level for all bits but only dispatches
the enabled ones:

drivers/soc/qcom/smsm.c:smsm_intr() {
	val = readl(entry->remote_state);
	changed = val ^ xchg(&entry->last_value, val);

	for_each_set_bit(i, entry->irq_enabled, 32) {
	...
}

and on unmask the cache is re-synced to the live line rather than replaying
the missed edge:

drivers/soc/qcom/smsm.c:smsm_unmask_irq() {
	/* Make sure our last cached state is up-to-date */
	if (readl(entry->remote_state) & BIT(irq))
		set_bit(irq, &entry->last_value);
	else
		clear_bit(irq, &entry->last_value);
}

The smp2p provider does the same thing in qcom_smp2p_notify_in().

So if the modem raises pc after irq_get_irqchip_state() but before
enable_irq(), is that edge simply consumed?  bam_dmux_power_on() would never
run, no pc-ack would be toggled, and the following falling edge would land in
bam_dmux_handle_pc() with new_state == dmux->pc_state == false:

	if (new_state == dmux->pc_state) {
		...
		return false;
	}

after which every bam_dmux_runtime_resume() would time out in

	wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
			   BAM_DMUX_REMOTE_TIMEOUT)

because the modem has no reason to produce another rising edge. Given that
probe already has a "Check if remote finished initialization before us" path,
a pc rising edge concurrent with probe looks like expected timing. Is there a
recovery path for that case, or does relying on a re-read of the line level
while the child IRQ is masked need a different approach?

>  
>  	return 0;
>  
> +err_power_off:
> +	mutex_lock(&dmux->power_lock);
> +	bam_dmux_power_off(dmux);
> +	mutex_unlock(&dmux->power_lock);
>  err_disable_pm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_dont_use_autosuspend(dev);
> @@ -872,12 +1003,16 @@ static void bam_dmux_remove(struct platform_device *pdev)
>  	pm_runtime_set_suspended(dev);
>  
>  	/* Try to wait for remote side to drop power vote */
> -	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
> +	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
> +				BAM_DMUX_REMOTE_TIMEOUT))
>  		dev_err(dev, "Timed out waiting for remote side to suspend\n");
>  
>  	/* Make sure everything is cleaned up before we return */
> +	disable_irq(dmux->pc_ack_irq);
>  	disable_irq(dmux->pc_irq);
> +	mutex_lock(&dmux->power_lock);
>  	bam_dmux_power_off(dmux);
> +	mutex_unlock(&dmux->power_lock);
>  	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
>  }

[Severity: High]
This is a pre-existing ordering issue rather than something the patch
introduces, but since the remove path is being touched here: can
register_netdev_work be re-queued after its only cancellation?

bam_dmux_remove() runs cancel_work_sync(&dmux->register_netdev_work) and
unregister_netdevice_many() at the top, while the RX channel is still armed
and the pc IRQ is still enabled. Only afterwards does it reach
disable_irq()/bam_dmux_power_off().

A remote OPEN command arriving in that window does:

bam_dmux_rx_callback()
  bam_dmux_cmd_open()
     /* Cannot sleep here, schedule work to register the netdev */
     schedule_work(&dmux->register_netdev_work);

and there is no second cancel_work_sync() after the IRQs are disabled and the
DMA is terminated. bam_dmux_register_netdev_work() would then dereference the
devm-allocated dmux and publish a fresh netdev holding it:

	bndev = netdev_priv(netdev);
	bndev->dmux = dmux;
	...
	ret = register_netdev(netdev);

Once remove() returns, devm frees dmux, so any xmit on that interface would
touch freed memory. Would moving the cancel_work_sync() after
disable_irq()/bam_dmux_power_off(), or adding a second one there, be
appropriate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903180057.1437-1-getshell%40seu.edu.cn
