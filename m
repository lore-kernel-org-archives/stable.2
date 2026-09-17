Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76D3D0927;
	Thu, 17 Sep 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665143; cv=none; b=dwE11kKhYIaxeFgLu5X2/7GNgaQy9fXuNbPN+Mx0Uki6ZxOovsDrcZ1bO8pTJ9ulmU7SYUjsFq0VYP/8JZzxIFVmeYVRyt6Vk4yPmvHwp4yZy1ghungxPSbqXdPvVOi4eesllf4DtLGa4u0cFBJusCiqyjdf488/pZhtuyEsWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665143; c=relaxed/simple;
	bh=j7dTLukPSxP8xyqMMxwbI5yqmWYOvJmF32Gzz6iG+58=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kF+fbxeuN4QC0QgZHp3ftvN19D9t68BWjbsqrmq/jDwPwpHnTBjNUx3KZyGvY8X18rV/gyan5z5pFTSJfcB/1fxqyAp27IMUhAaMjO/eYz2+5+6DNoTy+lY7IVwkS+Vh1aMkz1SrdRYdMyqo8nv3c+yggjAfWmGKU8vjftwiLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSSGZKJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSSGZKJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7501F000FF;
	Thu, 17 Sep 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665141;
	bh=fniPcj8dhly2IjcdzAeZ7tDhgMSq36SfLh6HCLrSIR4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WSSGZKJ7w4bWzJ5V/S3LwPCMEr63Q3So2HhtHDis7AHNPNPSs+Kmx+SnlWpLGz5nT
	 LaEMwKcuTEpIBupCMmJiR2khjOBmg2RF6x463ZqGBFVOyp/7ZLikZZzKiE9KeX17F1
	 cFNm/GQ4bYJVve9IIKYyv73yMc3qj8hl6rXOHNbECibQhEG6LcJhMnRM1JgMMRpmg1
	 obsDkep5GJqgwAwjMNwZOp7cj/qgyDZPmKfgq1F/G11y9YukZd5IRmEzCyQDm8RnKQ
	 HBUTsP7Yf8olPT8EX6EP98CdwiDrmCztsfijzqCVBwcenKkmFUM84OI5CI85SIlcSS
	 I14WvbZ9QMNyw==
Subject: Re: [PATCH] net: lantiq: fix netdev leak on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, john@phrozen.org, ralph.hempel@lantiq.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 17:12:20 +0000
Message-ID: <178966514017.22033.13065360500867909863@kernel.org>
In-Reply-To: <20260916020930.2606675-1-lgs201920130244@gmail.com>
References: <20260916020930.2606675-1-lgs201920130244@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

- [High] ltq_etop_remove() (drivers/net/ethernet/lantiq_etop.c:710-714)
  tears resources down in inverted order: netif_tx_stop_all_queues();…

Pre-existing issues:
- [High] ltq_etop_init() is registered as .ndo_init
  (drivers/net/ethernet/lantiq_etop.c:667), so it runs from inside…
- [Medium] In ltq_etop_remove() the PPE power domain is gated off by
  ltq_etop_hw_exit() (ltq_pmu_disable(PMU_PPE),…

--

net: lantiq: fix netdev leak on remove

The patch adds a free_netdev() call to ltq_etop_remove() so that the
net_device allocated by alloc_etherdev_mq() in ltq_etop_probe() is released
on driver removal, matching the free_netdev() already present on the probe
failure path.

> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 83ce3bfefa5c2..ecf2f3cbf4d9d 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -711,6 +711,7 @@ static void ltq_etop_remove(struct platform_device *pdev)
>  		ltq_etop_hw_exit(dev);
>  		ltq_etop_mdio_cleanup(dev);
>  		unregister_netdev(dev);
> +		free_netdev(dev);

[Severity: High]

Should the teardown order in ltq_etop_remove() be corrected before the
free_netdev() is added here?

netif_tx_stop_all_queues() does not clear IFF_UP and does not disable NAPI
(napi_enable() is in ltq_etop_open(), napi_disable() only in
ltq_etop_stop()), so the device is still up and NAPI is still enabled when
the PHY and the DMA rings are torn down.

First, does ltq_etop_mdio_cleanup() leave dev->phydev NULL for the later
close?

drivers/net/ethernet/lantiq_etop.c:ltq_etop_mdio_cleanup() {
	phy_disconnect(dev->phydev);
	mdiobus_unregister(priv->mii_bus);
	mdiobus_free(priv->mii_bus);
}

phy_disconnect() -> phy_detach() does:

drivers/net/phy/phy_device.c:phy_detach() {
	...
		phydev->attached_dev->phydev = NULL;
	...
}

unregister_netdev() then closes the still-up device:

net/core/dev.c:unregister_netdevice_many_notify() {
	...
		if (!(dev->flags & IFF_UP))
			continue;
	...
	netif_close_many(&close_head, true);
	...
}

which calls ndo_stop == ltq_etop_stop():

drivers/net/ethernet/lantiq_etop.c:ltq_etop_stop() {
	netif_tx_stop_all_queues(dev);
	phy_stop(dev->phydev);
	...
}

and phy_stop() dereferences its argument immediately:

drivers/net/phy/phy.c:phy_stop() {
	struct net_device *dev = phydev->attached_dev;
	...
}

Does removing the driver while the interface is up therefore oops in
phy_stop(NULL) under RTNL, and does that also mean the free_netdev() added
here is never reached in exactly the case the commit message is about?

Second, can a pending NAPI poll now touch freed memory? ltq_etop_hw_exit()
-> ltq_etop_free_channel() runs with NAPI still enabled:

drivers/net/ethernet/lantiq_etop.c:ltq_etop_free_channel() {
	ltq_dma_free(&ch->dma);
	if (ch->dma.irq)
		free_irq(ch->dma.irq, priv);
	...
}

ltq_dma_free() releases the descriptor ring:

arch/mips/lantiq/xway/dma.c:ltq_dma_free() {
	ltq_dma_close(ch);
	dma_free_coherent(ch->dev, LTQ_DESC_NUM * LTQ_DESC_SIZE,
		ch->desc_base, ch->phys);
	...
}

free_irq() waits for an in-flight hardirq but not for an already scheduled
poll, and both ltq_etop_poll_rx() and ltq_etop_poll_tx() dereference
&ch->dma.desc_base[ch->dma.desc], ch->skb[] and priv->lock. With the new
free_netdev() the private area holding priv->ch[].napi, priv->lock and
ch->skb[] is freed too, so does this turn the stale descriptor access into a
use-after-free of the netdev private data?

Would the sequence unregister_netdev() (which closes the device and runs
napi_disable() while the PHY and rings are still valid), then
ltq_etop_mdio_cleanup(), then ltq_etop_hw_exit(), then free_netdev() avoid
both of these?

[Severity: Medium]

This is a pre-existing ordering problem rather than something introduced
here, but it affects whether the new free_netdev() is reached: does
ltq_etop_hw_exit() gate the power domain that the subsequent MDIO and close
paths still need?

drivers/net/ethernet/lantiq_etop.c:ltq_etop_hw_exit() {
	ltq_pmu_disable(PMU_PPE);
	...
}

ltq_etop_hw_init() establishes the dependency by calling
ltq_pmu_enable(PMU_PPE) before touching LTQ_ETOP_CFG and
LQ_PPE32_ENET_MAC_CFG, and LTQ_ETOP_MDIO lives in the same block.

After the domain is gated, ltq_etop_mdio_cleanup() -> phy_disconnect() ->
phy_detach() -> phy_suspend() still issues a BMCR write, and
mdiobus_unregister() drives further PHY accesses, all through the
timeout-free accessors:

drivers/net/ethernet/lantiq_etop.c:ltq_etop_mdio_rd() {
	while (ltq_etop_r32(LTQ_ETOP_MDIO) & MDIO_REQUEST)
		;
	...
}

If MDIO_REQUEST never clears with the block powered down, does the unbind or
rmmod thread spin here forever and never reach the free_netdev() added by
this patch? Note that phy_detach()/phy_suspend() run even when the interface
was never brought up. Would moving ltq_etop_hw_exit() after
unregister_netdev() and after the MDIO cleanup, so the domain is gated last,
address this?

>  	}
>  }
>  

One more observation about a path that this patch does not touch, but which
interacts with the free_netdev() being added:

[Severity: High]

This isn't a bug introduced by this patch, but ltq_etop_init() is installed
as .ndo_init in ltq_eth_netdev_ops, so it runs from inside
register_netdevice() with RTNL held and dev->reg_state ==
NETREG_UNINITIALIZED, while its error label performs the core's unwind
itself:

drivers/net/ethernet/lantiq_etop.c:ltq_etop_init() {
	...
	err = ltq_etop_mdio_init(dev);
	if (err)
		goto err_netdev;
	return 0;

err_netdev:
	unregister_netdev(dev);
	free_netdev(dev);
err_hw:
	ltq_etop_hw_exit(dev);
	return err;
}

Does unregister_netdev() here re-acquire RTNL via rtnl_net_dev_lock() and
deadlock the probing thread?

If it did not, free_netdev() takes the kvfree(dev) path for an
UNINITIALIZED device, and control then falls through to err_hw, where
ltq_etop_hw_exit() dereferences netdev_priv(dev) and walks priv->ch[] on
the freed allocation.

Finally, register_netdevice() propagates the ndo_init error to
ltq_etop_probe():

net/core/dev.c:register_netdevice() {
	...
		ret = dev->netdev_ops->ndo_init(dev);
		if (ret) {
			if (ret > 0)
				ret = -EIO;
			goto err_free_name;
		}
	...
}

drivers/net/ethernet/lantiq_etop.c:ltq_etop_probe() {
	...
	err = register_netdev(dev);
	if (err)
		goto err_free;
	...
err_free:
	free_netdev(dev);
	...
}

so is the same net_device freed a second time? The driver sets neither
needs_free_netdev nor a priv_destructor, so neither free looks conditional.
The path appears reachable: ltq_etop_mdio_init() returns -ENXIO when
mdiobus_register() fails or when ltq_etop_mdio_probe() finds no PHY, and
-ENOMEM when mdiobus_alloc() fails. Should the unregister_netdev() and
free_netdev() calls in ltq_etop_init() simply be dropped and the cleanup
left to the core plus probe?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916020930.2606675-1-lgs201920130244%40gmail.com
