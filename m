Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2C33939D;
	Sat, 26 Sep 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438853; cv=none; b=sueCBKf76Mg9W20eOYBDGGuIQ8M5HV5qphRo3HgHaXc9YQcNw81zuaeDCQWuzItVP//OPbyC8+oJEatepHdWzhPGgUMTGPDGhv/8fi3oK6v6o8v84sR5SKHll+TofSDPWCJJAuVBHV0QBcI3guKBJ0wWWUHFYJGw3nq/gp2hrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438853; c=relaxed/simple;
	bh=fCpIFvl7ZwW62OkGDGD5v7fCnPe8M1AHuK9cojsuvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icq/VWbA0B+hYZoZ5/D2DojmmReNBW6O9pzkqVb2Bep87vZDCIvqU0+evi+af8F3OMej0Zv/d5USvn1SCq9zMexbzy7b+ZiyF1xVE8k0h7MIMdxh/5pemTumNX1Nti8sqRC97bbPYB0rzSOOXaHKjESN6cghwnIXHC/KReakv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFM0+3nP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFM0+3nP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4BC1F000FF;
	Sat, 26 Sep 2026 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790438851;
	bh=S3t1A76c1I5xQVch012q5qgP4+OVf6tO0xlKOOAI77w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFM0+3nPjyvLLSsq1pYbwrqr9aZJlto2ZLx5z5YrjcGV2f6LTyzFfelMkrQLc7Ifl
	 wIW7aADV+1bXCFmEttZ9g4yxWdFLx1w3nGa+//Oh8CF0jFcin7XZZkoBMp+FIfKiLL
	 eq2inBeFocWFvhI/duaBacdS1AxnSYT0IuJBK2dDZ+QiI6yy7FUxYhD1FUoREPsaGQ
	 x+j/RTCMsDohY65XNvotJGd5BRZLlZxYRnTmsLuj3fvBqIJ+Wyu7bZKnCnCvZ/czHK
	 FwnLg0etpPbEr58IZ/xcgNn5KsLWiJ0/YQC8KhF/VgQoGGjW1szoZzBFsQjL+QRu18
	 7Iso6h8QOzEXQ==
Date: Sat, 26 Sep 2026 17:07:27 +0100
From: Simon Horman <horms@kernel.org>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: ethernet: mtk_eth_soc: allocate dummy netdev
Message-ID: <20260926160727.GW13925@horms.kernel.org>
References: <patch-e52c13380b0768fec63af04c80e4b487@loljews.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-e52c13380b0768fec63af04c80e4b487@loljews.com>

On Thu, Sep 24, 2026 at 11:51:37PM +0300, Sandeep Haemoon wrote:
> The RX rings and the shared NAPI are carried by an internal "dummy" netdev
> (eth->dummy_dev). mtk_probe() creates that dummy device, and adds the
> shared tx/rx NAPI to it, only after the MAC netdevs have been registered.
> That order has been there since the MT7623 support was added and leaves a
> window in which the netdevs are visible to the network core before the
> shared NAPI and the dummy device exist.
> 
> If anything brings the first netdev up during that window (e.g. netifd
> opening the WAN link the instant the interface is registered), the
> first-open path runs without them. On NETSYS v2 and later SoCs
> mtk_rx_alloc() -> __xdp_rxq_info_reg() then dereferences eth->dummy_dev ==
> NULL:
> 
>   WARNING: CPU: ... Missing net_device from driver
> 
> in net/core/xdp.c and mtk_open() fails with -ENODEV. On NETSYS v1 SoCs
> (MT7621/MT7622/MT7623/MT7629) there is no page pool, so the same open
> instead calls napi_enable() on a napi_struct that netif_napi_add() has not
> initialised yet and dereferences a NULL napi->dev.
> 
> Allocate the dummy netdev and add the shared tx/rx NAPI to it before the
> register_netdev() loop. Both the dummy-allocation failure and a
> register_netdev() failure now unwind through mtk_unreg_dev(), which
> unregisters the net_device notifiers and the netdevs registered so far,
> stopping a concurrently-opened netdev (ndo_stop) and its NAPI before the
> dummy carrier is freed.
> 
> A netdev that opened during the window can also have queued the
> frame-engine reset worker (via the tx watchdog or phylink), so the probe
> error path now cancels eth->pending_work before freeing the shared state,
> as mtk_cleanup() already does on remove.
> 
> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
> ---
> 
> Changes in v3:
>   - Changelog now also covers the NETSYS v1 SoCs (MT7621/MT7622/MT7623/
>     MT7629): there is no page pool, so the same early ndo_open reaches
>     napi_enable() on a NAPI that netif_napi_add() has not initialised yet
>     and dereferences a NULL napi->dev, not the __xdp_rxq_info_reg() WARN.
>   - Fixes: now points at 656e705243fd ("net-next: mediatek: add support for
>     MT7623 ethernet"), which introduced the register_netdev()-before-
>     init_dummy_netdev() ordering, rather than b209bd6d0bff, which only turned
>     the embedded dummy_dev into a late-allocated pointer.
>   - The probe error path now cancels eth->pending_work before freeing the
>     dummy carrier and the rest of the shared state: a netdev opened during the
>     window can have queued the frame-engine reset worker (tx watchdog or
>     phylink), which takes rtnl and drives the hardware.
>   - Rebased on current net (includes Lorenzo's unregister-net-devices fix).
> 
> The notifier-unregister gap on the pre-register error paths (devm_request_irq()/
> mtk_mdio_init()/mtk_ppe_init() failures) flagged in the same review is
> pre-existing and intentionally left for a separate change.

Reviewed-by: Simon Horman <horms@kernel.org>

