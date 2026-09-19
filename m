Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A63845A9;
	Sat, 19 Sep 2026 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782726; cv=none; b=O/VTxrNaSR+MnIqL3NuJPJVZeoSXTshCaG1feuU0u+Le84BS/cA9IRontV533EYHNiHXNDs/BL+5hFLjk8MBfJmIBWZOGu3KQqPMGhLCcdCdU3rKHkyOISIf5kNG/okWSuL3ES9+NkCaq54R0J4Y506URwBRD8VlHUzsAzRM70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782726; c=relaxed/simple;
	bh=BKDwmxZyG427fBX4Zj5kcGuFrymo+EnbVXlqDujJGy0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9E5jxN2cuFK1woT+DW5p3Vb3BG1SMwTN+4xQoA3NQTqoNrdb/BvM7IJYdUVBA8wUSL074lyLzKp7bs+OzS00ZSpwjENEVj6DNH9obAC5jQTeJ2G+CBcjDAEXRu8mjk29K1b6RApjDYIUBPujil8xKTy/H3RNDPVB0ctlovth1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D37jtAzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D37jtAzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146141F000FF;
	Sat, 19 Sep 2026 01:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789782722;
	bh=56W3DOkX0vqueaZcbxVw3WduROW9mjeTn3uyRN4ew+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D37jtAzNWEgNibrm/aXz3DtCbASKtwXIrKhwMLWivQocf5Xqs6fCOHS+mrF3jhnz3
	 BlL2sdYKh3KyoNwNWtHXlrKS/njMabrM3iowDGjEmGiKZUHPN+w2LAtBWzm+YOt6uA
	 3qmbVwDhWiCGCtQz7XVmQ1/20y3DKDwmhoCyMDxth4ysN4R4kbvFQldBLkw4+qRhNc
	 vyns81M2QdCaLcDbZuxlmBawApWviCB6sJOrjlN7YrADoDm6NCGDRNnfP+0Nn8iYC3
	 xsMyH26sCZPUuNdzlKWKcUFAO0V5wYSQCfRW/pT4m/42mAxlUnn9AWj8fnQARB/COk
	 KQptSHP2bcSPA==
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before
 registering netdevs
From: netdev-bot+sashiko@kernel.org
To: sandeeph@loljews.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 19 Sep 2026 01:52:01 +0000
Message-ID: <178978272167.22033.8490745955078913632@kernel.org>
In-Reply-To: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
References: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 3 (1) · Medium: 1 · Low: 2

- [High] New use-after-free window on mtk_probe()'s error path:
  eth->dummy_dev now carries eth->tx_napi/eth->rx_napi *before* the…
- [High] New leak of a registered notifier into freed memory when
  alloc_netdev_dummy() fails.
- [High] Frame engine can be left armed while probe tears down clocks and
  power.
- [Medium] Commit message and new in-code comment do not match the
  implementation.
- [Low] mtk_probe(): the patch fixes a user-visible regression (first
  netdev cannot be brought up during the probe window because…
- [Low] Cosmetic artifact of the code motion: after removing the
  dummy_dev allocation block that used to sit after the…

Pre-existing issues:
- [High] mtk_probe(): if register_netdev() fails for the second or later
  MAC (mtk_eth_soc.c:5360-5363), control jumps to err_deinit_ppe and…

--

net: ethernet: mtk_eth_soc: allocate dummy netdev before registering netdevs

This moves the eth->dummy_dev allocation and the netif_napi_add() calls for
the shared tx/rx NAPI ahead of the register_netdev() loop in mtk_probe(), so
a concurrent ndo_open cannot observe eth->dummy_dev == NULL and fail in
__xdp_rxq_info_reg().  The err_unreg_netdev label and its mtk_unreg_dev()
call are removed, and the dummy netdev is freed from err_deinit_ppe instead.

A few questions about the reordering and the new unwind path below.

>     Allocate the dummy netdev and add the shared tx/rx NAPI to it before
>     registering the MAC netdevs, and free it from the probe error path instead
>     of the now-unneeded err_unreg_netdev cleanup.
>
>     Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>

[Severity: Low]
Should this carry a Fixes: tag?

The NULL window described in the changelog was created by commit
b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy net_device
dynamically"), which turned the embedded struct net_device dummy_dev into a
pointer allocated only after the register_netdev() loop.  Before that commit
the object was embedded, so mtk_create_page_pool() could never pass NULL to
__xdp_rxq_info_reg().

Without the tag, will stable tooling pick this up for the affected kernels?

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index fd7a49ae88d01..ae6a19bb3a418 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5337,6 +5337,22 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* we run 2 devices on the same DMA ring so we need a dummy device
> +	 * for NAPI to work. Allocate it before registering the netdevs so a
> +	 * concurrent ndo_open (e.g. netifd bringing the first netdev up) never
> +	 * observes eth->dummy_dev == NULL, which would make mtk_rx_alloc() ->
> +	 * __xdp_rxq_info_reg() warn ("Missing net_device from driver",
> +	 * net/core/xdp.c) and leave the interface down on boot.
> +	 */

[Severity: Medium]
Do the changelog and this comment match what the code does?

The changelog says the dummy netdev is freed "from the probe error path
instead of the now-unneeded err_unreg_netdev cleanup", but mtk_unreg_dev()
was the only netdev-unregistration step reachable from any mtk_probe() error
label, and the register_netdev() failure path still jumps into that unwind:

	err = register_netdev(eth->netdev[i]);
	if (err) {
		dev_err(eth->dev, "error bringing up device\n");
		goto err_deinit_ppe;

What remains on that path is mtk_free_dev(), which only frees:

	for (i = 0; i < MTK_MAX_DEVS; i++) {
		if (!eth->netdev[i])
			continue;
		free_netdev(eth->netdev[i]);
	}

Is the cleanup really "now-unneeded", or was it still required by that path?

The new comment also states that pre-allocating dummy_dev makes a concurrent
ndo_open safe.  Is that the whole story, given that the same concurrent open
is what leaves the shared NAPI enabled when the new error path frees its
carrier?

> +	eth->dummy_dev = alloc_netdev_dummy(0);
> +	if (!eth->dummy_dev) {
> +		err = -ENOMEM;
> +		dev_err(eth->dev, "failed to allocated dummy device\n");
> +		goto err_deinit_ppe;
> +	}

[Severity: High]
Can this allocation failure leave a registered notifier_block pointing at
freed memory?

On MTK_QDMA SoCs mtk_add_mac() registers a notifier embedded in the MAC
private area:

	mac->device_notifier.notifier_call = mtk_device_event;
	register_netdevice_notifier(&mac->device_notifier);

Previously an alloc_netdev_dummy() failure went to err_unreg_netdev ->
mtk_unreg_dev(), which does:

	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
		unregister_netdevice_notifier(&mac->device_notifier);
	unregister_netdev(eth->netdev[i]);

Now it goes to err_deinit_ppe and falls through to mtk_free_dev(), which
free_netdev()s the MAC netdevs without any unregister_netdevice_notifier()
call.  Does the notifier then stay on the global chain, so that the next
NETDEV_* event calls mtk_device_event() with container_of() on freed
netdev_priv() storage?

> +	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> +	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> +

[Severity: High]
Attaching the shared NAPI here means it is live before the netdevs become
openable.  Can the error path then free it underneath an enabled NAPI?

Per the changelog's own premise, netifd can open netdev[0] as soon as
register_netdev() returns, and with this patch that open now succeeds and
runs the first-open path in mtk_open():

	napi_enable(&eth->tx_napi);
	napi_enable(&eth->rx_napi);
	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
	mtk_rx_irq_enable(eth, soc->rx.irq_done_mask);

If register_netdev() for a later MAC fails, err_deinit_ppe frees the carrier:

	free_netdev(eth->dummy_dev)
	  netdev_napi_exit()
	    __netif_napi_del_locked()
	      /* Make sure NAPI is disabled (or was never enabled). */
	      WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));

Does this trip that WARN_ON and leave eth->tx_napi.dev / eth->rx_napi.dev
pointing at freed memory while the devm-managed FE interrupts are still
installed and unmasked, so the next RX/TX interrupt schedules a poll on the
freed dummy netdev?

>  	for (i = 0; i < MTK_MAX_DEVS; i++) {
>  		if (!eth->netdev[i])
>  			continue;

[Severity: High]
This isn't a bug introduced by this patch, but the register loop's jump to
err_deinit_ppe was already there before the change, and this patch removes
the label that could have fixed it.

On a multi-MAC SoC, if register_netdev(eth->netdev[0]) succeeds and
register_netdev(eth->netdev[1]) fails, the unwind reaches mtk_free_dev(),
which calls free_netdev() on netdev[0] while it is still NETREG_REGISTERED:

	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);

mtk_cleanup() documents the expected ordering:

	mtk_unreg_dev(eth);
	mtk_free_dev(eth);

Since this patch deletes the only probe-side mtk_unreg_dev() call, could the
unregister step be kept between the register loop and the dummy_dev free
instead?

> @@ -5351,17 +5367,6 @@ static int mtk_probe(struct platform_device *pdev)
>  				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
>  	}
>  
> -	/* we run 2 devices on the same DMA ring so we need a dummy device
> -	 * for NAPI to work
> -	 */
> -	eth->dummy_dev = alloc_netdev_dummy(0);
> -	if (!eth->dummy_dev) {
> -		err = -ENOMEM;
> -		dev_err(eth->dev, "failed to allocated dummy device\n");
> -		goto err_unreg_netdev;
> -	}
> -	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> -	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
>  
>  	platform_set_drvdata(pdev, eth);

[Severity: Low]
This isn't a bug, but removing the block leaves two consecutive blank lines
between the closing brace of the register loop and platform_set_drvdata(),
which checkpatch.pl flags as "CHECK: Please don't use multiple blank lines".

>  	schedule_delayed_work(&eth->reset.monitor_work,
> @@ -5369,9 +5374,9 @@ static int mtk_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_unreg_netdev:
> -	mtk_unreg_dev(eth);
>  err_deinit_ppe:
> +	if (eth->dummy_dev)
> +		free_netdev(eth->dummy_dev);
>  	mtk_ppe_deinit(eth);
>  	mtk_mdio_cleanup(eth);
>  err_free_dev:

[Severity: High]
With no unregister step left on this path, can the frame engine stay armed
while probe gates its clocks and power?

Because the concurrent open now succeeds, mtk_open() -> mtk_start_dma() can
set MTK_TX_DMA_EN|MTK_RX_DMA_EN, program the rings, start the PPE and unmask
the TX/RX interrupts.  The only code that undoes that is mtk_stop():

	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
	napi_disable(&eth->tx_napi);
	napi_disable(&eth->rx_napi);
	...
	mtk_stop_dma(eth, eth->soc->reg_map->pdma.glo_cfg);
	mtk_dma_free(eth);

Nothing on this unwind triggers ndo_stop, and it continues into
mtk_ppe_deinit() (rhashtable_destroy with the PPE still started) and
mtk_hw_deinit():

	mtk_clk_disable(eth);

	pm_runtime_put_sync(eth->dev);
	pm_runtime_disable(eth->dev);

Does this drop the FE clocks and power domain with DMA still enabled and
interrupts still unmasked, and leak the descriptor rings and page-pool
buffers?  Since platform_set_drvdata() was never reached, mtk_remove()
cannot clean up afterwards either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/patch-12c1a57b1d914b28b89455f24de55ee4%40loljews.com
