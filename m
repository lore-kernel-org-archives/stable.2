Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455496;
	b=JhiXJlf/QHfkN33oecP+Vi624FOhU+P54El1r1vUj2za4RJr0vzp5hE2I0I5pPMrYvds
	 CK7pUhbIhAGwmd2MwAOGa9dl0pcUqVPsKjw+iAQzzAcwDyjqMnEFn+82a4RkPLq2yqfLy
	 uSbav0x3OFkHqOKzhoTuEBG1d16eEbkPrFL0TXHR8eU40s+HIAT5rfOSXtoSHkr3rqR7v
	 FY0UBDo/jyIfM1rYUUFJJ/Lf5d7hf80FFbe1Kqbwr4YoHk8EB8VTu685gPzqEy/RW9w2V
	 awAU5VuMy9C5vdDOi4CuVDG0OV4EViPyVFTyifAWGnU6ELxA1wR06rfqU3bxM8WUIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455496;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JMtg/5BzrnWmSfkadWck1kiwgdAiB3MwE19IVxdhlzY=;
	b=r+k6gdjpo+OOzUvh5qaIU1KAg/Be1HfSvGymrdfPwrH/JGQL1+A9e1SJ+rMwNr4hGZrc
	 QqS6pmks8+zT6YeDy1hsbkwMU7CHhAS8tzu4BbR/9ScM8mk/ACIzNCl9SBWIiGdnQZnwP
	 CYcaMo9eaKpeQ6kGNSexmIKUc6pCxiF3xhM5lYG7qOGrsRuHkpvUc9Po+nMc76biuI95m
	 vRuT6WyiHCaCKr2qH9o4bfaPi2fBY43OtpvLfooPFVjUUTRRAN8rvjJhBKEjrZX91O/4Y
	 v1rTn5uYKq0U2EWtyeoCPvLSiXt58089AWBXoqmoU4JXGiIINv1j1riO4RLCCoU4ASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1xf+jBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BA606A332;
	Thu, 12 Nov 2026 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1xf+jBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F03C1F00A06;
	Thu, 12 Nov 2026 03:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455495;
	bh=JMtg/5BzrnWmSfkadWck1kiwgdAiB3MwE19IVxdhlzY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R1xf+jBpT6+qx4M5YZwQ5iMctz2SPAz/x1GGkLdzkqg8m/hbZ/n1l33TPFO3B6LsG
	 hZeDROBrtGijKZw/pOQNsGV0tS4uTSqzaDZKj+RWPq5dQEmQFileM0wXq9CVbZUZr1
	 wyHfgJMIpz/kgZ7l456DkTnBFg79C0+3Xh1HmbgyROkAP2R9azYdjWfWkTHYXRX+Bc
	 0jA7AT4ymlqP0olh78+sMr8eROHfcN9e0+YynErE4C500nWZmWFt9QlAJj+G6TmSUG
	 93jR1OkrXd0MwRy1e6WoE17/1KAR7qji95AThJUlFAOGXc4Av8B0ECaLRa/O7dcSPy
	 /ZXs128d7ymvw==
Subject: Re: [PATCH net] net: adin1110: flush rx_mode_work on stop to avoid
 use-after-free
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: alexandru.tachici@analog.com, lennart@lfdomain.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 03:51:34 +0000
Message-ID: <179445549481.2199510.1559204633982684170@kernel.org>
In-Reply-To: <20261109124953.1604903-1-hj351016@gmail.com>
References: <20261109124953.1604903-1-hj351016@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new flush is skipped when the SPI register write fails.
- [High] rx_mode_work can be queued again after the new flush.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  adin1110_net_stop() masks the wrong RX-ready interrupt for each port.
- [Low] This problem wasn't introduced by this patch, but
  port_priv->flags is written in adin1110_set_rx_mode() under…

--

net: adin1110: flush rx_mode_work on stop to avoid use-after-free

This adds a flush_work() of rx_mode_work to adin1110_net_stop(), next to
the existing tx_work flush. The goal is to stop a pending rx-mode update
from running against port_priv after devres frees the netdev on unbind.

> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 53fac3dc8be62..788cf4d1ffd33 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -956,6 +956,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
>  
>  	netif_stop_queue(port_priv->netdev);
>  	flush_work(&port_priv->tx_work);
> +	flush_work(&port_priv->rx_mode_work);

[Severity: High]
Does every stop reach this flush? Earlier in adin1110_net_stop() there is
an early return if the IMASK1 SPI read-modify-write fails:

drivers/net/ethernet/adi/adin1110.c:adin1110_net_stop() {
    ...
	mutex_lock(&priv->lock);
	ret = adin1110_set_bits(priv, ADIN1110_IMASK1, mask, mask);
	mutex_unlock(&priv->lock);
	if (ret < 0)
		return ret;
    ...
}

The core ignores the ndo_stop return value and keeps tearing down:

net/core/dev.c:__dev_close_many() {
    ...
		if (ops->ndo_stop)
			ops->ndo_stop(dev);

		netif_rx_mode_cancel_retry(dev);
		netif_set_up(dev, false);
    ...
}

On unbind, the devm_register_netdev() action closes and unregisters the
netdev. The devm_alloc_etherdev() action then frees it, along with the
embedded port_priv. Nothing else in the driver cancels rx_mode_work.

Suppose adin1110_set_bits() returns an spi_sync error here. Could an
rx_mode_work that was queued while the port was up still be pending when
the netdev is freed? adin1110_rx_mode_work() would then do container_of()
on freed memory.

The commit message says:

    so both deferred works are drained before the device can be torn
    down.

That doesn't seem to hold on this error path.

Would it be more robust to drain or cancel the works unconditionally?
For example, ndo_stop could carry on past the register write error, or
cancel_work_sync()/disable_work_sync() could be called from a teardown
point that always runs.

[Severity: High]
Can rx_mode_work be queued again after this flush? IFF_UP is still set
while ndo_stop runs, because __dev_close_many() calls
netif_set_up(dev, false) only after ndo_stop returns.

__dev_set_rx_mode() checks only IFF_UP and netif_device_present().
adin1110 has no ndo_set_rx_mode_async, so the legacy path calls
adin1110_set_rx_mode() directly. That function queues the work
unconditionally:

drivers/net/ethernet/adi/adin1110.c:adin1110_set_rx_mode() {
    ...
	port_priv->flags = dev->flags;
	schedule_work(&port_priv->rx_mode_work);
    ...
}

The IPv6 multicast join path doesn't take RTNL, so it can run at the same
time as dev_close():

setsockopt(IPV6_ADD_MEMBERSHIP)
  __ipv6_sock_mc_join()
    __ipv6_dev_mc_inc()
      igmp6_group_added()
        dev_mc_add()
          __dev_set_rx_mode()
            adin1110_set_rx_mode()
              schedule_work(&port_priv->rx_mode_work)

A possible timeline:

CPU0                                    CPU1
adin1110_net_stop()
  flush_work(&rx_mode_work)
                                        dev_mc_add()
                                          sees IFF_UP still set
                                          schedule_work(&rx_mode_work)
netif_set_up(dev, false)

After this point the driver never flushes or cancels the work again. It
has no remove callback and no devm cancel action around
devm_register_netdev() or devm_alloc_etherdev().

Could the re-queued work then run on the freed port_priv once devres
frees the netdev?

Would cancel_work_sync() or disable_work_sync(), called from a devm action
that runs after unregister, close this window? Moving to the core async
rx-mode mechanism is another option.

>  	phy_stop(port_priv->phydev);
>  
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but is the RX-ready mask in
adin1110_net_stop() inverted for the port?

drivers/net/ethernet/adi/adin1110.c:adin1110_net_stop() {
    ...
	mask = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
    ...
}

The rest of the driver maps port 0 to ADIN1110_RX_RDY (BIT 4) and port 1
to ADIN2111_P2_RX_RDY (BIT 17):

drivers/net/ethernet/adi/adin1110.c:adin1110_port_rx_ready() {
    ...
	if (!port_priv->nr)
		return !!(status & ADIN1110_RX_RDY);
	else
		return !!(status & ADIN2111_P2_RX_RDY);
}

adin1110_net_open() also enables ADIN1110_RX_RDY_IRQ on every chip. It
adds ADIN2111_RX_RDY_IRQ only on ADIN2111:

	val = ADIN1110_TX_RDY_IRQ | ADIN1110_RX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
	if (priv->cfg->id == ADIN2111_MAC)
		val |= ADIN2111_RX_RDY_IRQ;

On ADIN2111, would bringing port 0 down mask the RX-ready interrupt of
port 1, which is still up? Port 1 RX would then be serviced only when
some other unmasked source happens to fire.

On a single-port ADIN1110, this sets the non-existent port 2 bit and
leaves the port's own RX-ready IRQ enabled. The IRQ is IRQF_TRIGGER_LOW,
and adin1110_irq() skips reading frames for a port that isn't oper-up.

If RX_RDY stays asserted while the FIFO is non-empty, could that cause
repeated interrupts while the port is down?

[Severity: Low]
This is a pre-existing issue, but adin1110_set_rx_mode() writes
port_priv->flags under priv->state_lock. adin1110_setup_rx_mode() (via
adin1110_rx_mode_work()) reads it under priv->lock only:

drivers/net/ethernet/adi/adin1110.c:adin1110_setup_rx_mode() {
	ret = adin1110_set_promisc_mode(port_priv,
					!!(port_priv->flags & IFF_PROMISC));
    ...
	ret = adin1110_multicast_filter(port_priv, ADIN_MAC_MULTICAST_ADDR_SLOT,
					!!(port_priv->flags & IFF_ALLMULTI));
    ...
	ret = adin1110_broadcasts_filter(port_priv,
					 ADIN_MAC_BROADCAST_ADDR_SLOT,
					 !!(port_priv->flags & IFF_BROADCAST));
    ...
}

The two sides share no lock, so this is a data race that KCSAN could
report.

Could a concurrent set_rx_mode change flags between the three reads?
One run of the work would then program the filters from a mix of old and
new values.

The writer always calls schedule_work() afterwards, so the next run
should reprogram the hardware from the latest flags. The field is an
aligned u32, so torn reads aren't a concern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109124953.1604903-1-hj351016%40gmail.com
