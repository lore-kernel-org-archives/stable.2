Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8F481A92;
	Thu, 24 Sep 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267521; cv=none; b=XOC/Jlf/SesI7QLg/JKefeisE88j/cTqL7fYAlfI77vknfMyKvKqHDBcTTtn624WD2QRoPoHwcd5RKjICS8OA/if/1XtP253IeIot4kL8hh7VSgX1VAxZ/b2RLUB2Ob90eU05FO+E7ES3x+fpscQQ6dPhLBMzbuxkkS+1UOUDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267521; c=relaxed/simple;
	bh=4iGPW8CfpQpznMPGgG9wGWLUsSGj/61vl8v5Sqk29Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHOhCdlLXdWdtgFKxRYFZQZAJ9AWNEyHTzVRrjfT+xhqI4s/c1+Jrjyb4spDSjYyl4MZtaFdSaRGJg/oBuJWvAm9RZs0DaQGDeZFtp0KBYX1mBf6vYDpe3d65pRHvxgn+f/C1Z1n0hJcjOZSrKcNcU1+2d3gESr79qUj5cRAKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHlfAYj6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHlfAYj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA76A1F00899;
	Thu, 24 Sep 2026 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267519;
	bh=o3yFZNUu2+ISPNvWNezBeW96/f8ai0OsMTS/TOywRd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHlfAYj6G7OaeTGs9BAxyW9eAMCbePL0wc1LfxaI3+LXezHOWzbXYk0l/tz1srD5h
	 Ow8vKnaa1J+DkB18Zn6D9pivdbFF/H7UnCk+190hq4pLSo4HhkXlYfZ+69xHPsWVRA
	 87K/8ahQAjpG9AKNX/BR58U5F5foN0YEOEQNRSllw+jtqJ50OCxtCyi2+suGzqRbZC
	 1uTM0xM8VsHYtpS6MvUi2huGrYLeF4msGvV0PnofD5F7FhugLKbNBgAdSXnxOIGyLt
	 bjYSl/B9MdOjLFFEB/QOLPmlyH6PaDJoJxnptrBcfMk9j0T8iC2H8drbgxdUH+8Bxk
	 VIz58TTuse5xw==
From: Jakub Kicinski <kuba@kernel.org>
To: sandeeph@loljews.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: allocate dummy netdev before registering netdevs
Date: Thu, 24 Sep 2026 09:31:58 -0700
Message-ID: <20260924163158.95473-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <patch-33e50d280ef35a7fd2f2dc09deea463a@loljews.com>
References: <patch-33e50d280ef35a7fd2f2dc09deea463a@loljews.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: mtk_eth_soc: allocate dummy netdev before registering netdevs

This patch moves the allocation of eth->dummy_dev, and the netif_napi_add()
calls for the shared tx/rx NAPI, ahead of the register_netdev() loop in
mtk_probe(). A netdev opened as soon as it is registered therefore no
longer sees a NULL dummy_dev. The error unwind also now deletes the NAPIs
and frees the dummy device.

> If anything brings the first netdev up during that window (e.g. netifd
> opening the WAN link the instant the interface is registered), mtk_open()
> takes the first-open path and runs mtk_start_dma() -> mtk_dma_init() ->
> mtk_rx_alloc(), which calls __xdp_rxq_info_reg() with eth->dummy_dev ==
> NULL. That triggers
>
>   WARNING: CPU: ... Missing net_device from driver
>
> in net/core/xdp.c and returns -ENODEV, so mtk_open() fails and the
> interface stays down until it is manually brought up once probe finishes.

[Severity: Low]
Is this the full impact of the race? mtk_rx_alloc() only uses dummy_dev
through mtk_create_page_pool(). That call happens only when
mtk_page_pool_enabled() is true, which means
mtk_is_netsys_v2_or_greater().

On NETSYS v1 SoCs (MT7621/MT7622/MT7623/MT7629), mtk_start_dma() succeeds.
mtk_open() then does:

    napi_enable(&eth->tx_napi);
    napi_enable(&eth->rx_napi);

At that point netif_napi_add() has not yet initialised these NAPIs. eth
comes from devm_kzalloc(), so tx_napi.dev is NULL, and
napi_enable() -> netdev_lock(n->dev) dereferences a NULL pointer.

This patch fixes that case too. Could the commit message mention the oops
on v1 SoCs? Stable backporters will use the description to judge urgency.

> Fixes: b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically")

[Severity: Medium]
Is this the right commit for the Fixes: tag? The v2 notes say b209bd6d0bff
"introduced the NULL window", but the ordering this patch corrects looks
older.

At b209bd6d0bff^, mtk_probe() already ran the register_netdev() loop
before init_dummy_netdev() and netif_napi_add(). The same order is in
656e705243fd ("net-next: mediatek: add support for MT7623 ethernet").

b209bd6d0bff only turned the embedded dummy_dev into a pointer, which
changed the symptom. In older kernels, an open in the same window reaches
napi_enable() on a zeroed napi_struct and hits:

    BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));

With the current tag, would stable tooling skip LTS trees that lack
b209bd6d0bff (for example 6.6, 6.1, 5.15 and 5.10), even though they have
the same race?

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 2ea5dfe85539b..5e7d8b8be7687 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5341,6 +5341,22 @@ static int mtk_probe(struct platform_device *pdev)

[ ... ]

> +	eth->dummy_dev = alloc_netdev_dummy(0);
> +	if (!eth->dummy_dev) {
> +		err = -ENOMEM;
> +		dev_err(eth->dev, "failed to allocated dummy device\n");
> +		goto err_unreg_netdev;
> +	}
> +	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> +	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> +
>  	for (i = 0; i < MTK_MAX_DEVS; i++) {
>  		if (!eth->netdev[i])
>  			continue;

[ ... ]

> @@ -5376,6 +5380,11 @@ static int mtk_probe(struct platform_device *pdev)
>  err_unreg_netdev:
>  	mtk_unreg_dev(eth);
>  err_deinit_ppe:
> +	if (eth->dummy_dev) {
> +		netif_napi_del(&eth->tx_napi);
> +		netif_napi_del(&eth->rx_napi);
> +		free_netdev(eth->dummy_dev);
> +	}

[Severity: High]
A MAC netdev can now open fully while mtk_probe() is still in the
register_netdev() loop. Can this unwind then leave eth->pending_work queued
or running?

Suppose a later register_netdev() fails, for example with -EINTR from
rtnl_net_lock_killable(). The unwind runs
mtk_unreg_dev() -> unregister_netdev() -> mtk_stop(), and mtk_stop() only
cancels rx_dim.work and tx_dim.work.

While netdev0 was up, the TX watchdog could have queued the reset worker:

mtk_tx_timeout()
    schedule_work(&eth->pending_work);

mtk_pending_work() takes rtnl_lock. It then uses eth, eth->netdev[] and the
hardware through mtk_prepare_for_reset(), mtk_stop()/mtk_open() and
mtk_hw_init().

If the work was queued while unregister_netdev() held rtnl, it can run as
soon as rtnl is dropped. That can overlap the rest of the unwind (freeing
dummy_dev, mtk_free_dev(), mtk_hw_deinit()), or come after devres has
freed eth.

The remove path handles this in mtk_cleanup():

    cancel_work_sync(&eth->pending_work);
    cancel_delayed_work_sync(&eth->reset.monitor_work);

Should the probe error path also call cancel_work_sync(&eth->pending_work)
after mtk_unreg_dev()? The changelog says the unwind stops any
concurrently-opened netdev before its resources are freed, and this case
seems to contradict that.

>  	mtk_ppe_deinit(eth);
>  	mtk_mdio_cleanup(eth);
>  err_free_dev:

[Severity: High]
This isn't a bug introduced by this patch, but the other error paths that
jump to err_deinit_ppe and err_free_dev look like they can leave a freed
notifier_block on the global netdev chain.

On MTK_QDMA SoCs, mtk_add_mac() does:

    if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA)) {
        mac->device_notifier.notifier_call = mtk_device_event;
        register_netdevice_notifier(&mac->device_notifier);
    }

Here mac lives in the netdev private area. The notifier is only
unregistered by mtk_unreg_dev(), which is reached only through
err_unreg_netdev.

Two failure paths skip it:

- devm_request_irq() or mtk_mdio_init() fails and jumps to err_free_dev.
- mtk_ppe_init() or mtk_eth_offload_init() fails and jumps to
  err_deinit_ppe.

In both cases mtk_free_dev() -> free_netdev() kvfree()s the
NETREG_UNINITIALIZED netdev while its notifier is still registered.

Could the next netdev notifier walk then touch freed memory? The same
question applies to the next register_netdevice_notifier() call, for
example on re-probe after -EPROBE_DEFER from of_mdiobus_register().

Separately, if mtk_add_mac() fails for a second MAC, the goto err_deinit_hw
skips both mtk_unreg_dev() and mtk_free_dev(). Does that leak the first
MAC's netdev and leave its notifier registered, with mac->hw pointing at
the devm-freed eth?
-- 
pw-bot: cr
