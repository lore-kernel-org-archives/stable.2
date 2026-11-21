Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303118;
	b=XwjvjydpX52YrFvuiyLZGnORsQLKW5MRNC6+qfoqE+HLEpy0mcHdLDwDOZt+bsUiHlos
	 MHep/qcFgGEyx20Ed0X0ejuV//vRK3oC+p+a5luxdrUVvvxzr70nRFdV68OsemvFg4y1u
	 8t4q4FKjB6/hEgTJ3Bxo5PO7q+fv54Lm+YVwX0fBWQSMIMWHiSQjOhS9FIUXBajpdkDZh
	 br1Dz3iLBgxGd+NVib/hVVX8FZsa/OWi+ovvvRyWRmmb/dtWbyyNYrqx7nId5eA4Bq+BY
	 bOXf5xguWH36rWOafyMkWvOz2XLMr1j1vbwQTKuVSgmlFVc814SSSCtNSbF09pXVWTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303118;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b4KBBoR+uL9MaPy4jrx7J64irJ65nrCVt6sPTidn7hg=;
	b=DS8mnyhNIJYVVMmT8FQ+qG6dwT2pP7ocolQLhOLiKi0+YYxmxoY7VYX7LbHurpzDCfs3
	 xz9WxI6Re6wcWseEl6TGo9DrCR/o8vd0ppErntgSmz16+bNvZUlrbTLMQYZRoDezg1+DB
	 atE9H1XPebw11ZHaxxoCtkL4fGvRU+0ruKd0KD0axK7imfRo4Q/U9cviQlC54hUVrbcdv
	 XwFbWPTNW/JfPlkXBqiKfIYxP3mGy+nId+R3gHTwQDq/rPH/xIl9WGq53efn3YYP8yoZl
	 cbPOcKgeT5H2HHOO/iOTf0Jyl/FzqK269SXiHeAOHVi1SttXfPnOftHiaQbVXt/75Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiA12YsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C63606A320;
	Sat, 21 Nov 2026 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiA12YsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71561F000C0;
	Sat, 21 Nov 2026 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303118;
	bh=b4KBBoR+uL9MaPy4jrx7J64irJ65nrCVt6sPTidn7hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CiA12YsI5p0iDT457SnR+mIafVsM4aZrKlLqc7Pu3RTmWje3NjViV8Gy1CnLH8UPd
	 uETGOOnp8g0YrTvlGj/g6zK77P7EbQkEp0btTeGgL7wgKdVE0vhHCuGG/B6vYi68uV
	 PO7E5L0aVArQNIQJzjziFTMoRHFLY2lVbSnNF8c0lK5q/gtlxmBe3+vHZlBS/mUjIE
	 Tvc1btb879SPorb/nMiF/WsZayL95x3an6/BqyGfYNcYU/Lmg6L2vQHvQteNJQuNUN
	 MWBxDmp429O4Pf9IH581n0y/lQ7VJzHZxbJOBW1bHDo2p8pakuWf0WmpyvdEm1BYa2
	 17ax0xQZYPwAw==
Subject: Re: [PATCH net v4 1/2] net: atl1c: wait for in-flight RX polls before
 the link-down ring reset
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 21 Nov 2026 23:18:37 +0000
Message-ID: <179530311729.3135.17859147482038356358@kernel.org>
In-Reply-To: <20261117225521.19689-2-federico@rimpianto.com>
References: <20261117225521.19689-2-federico@rimpianto.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch does not close the RX race it claims to fix.
- [Medium] atl1c_rx_poll_sync() waits with no time limit for
  NAPI_STATE_SCHED to clear and gives up only when __AT_DOWN is set.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same link-
  down reset still frees TX buffers while TX NAPI and transmit can run.

--

net: atl1c: wait for in-flight RX polls before the link-down ring reset

This patch adds atl1c_rx_poll_sync(). In the link-down path of
atl1c_check_link_status() it is called after netif_carrier_off() and
before the MAC and DMA rings are reset. It waits for NAPI_STATE_SCHED to
clear on every RX NAPI, and stops waiting once __AT_DOWN is set.

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index eddd8406867f7..e9baee8fa7e5e 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -248,6 +248,26 @@ void atl1c_reinit_locked(struct atl1c_adapter *adapter)
>  	clear_bit(__AT_RESETTING, &adapter->flags);
>  }
>  
> +/* atl1c_clean_rx() looks at the carrier only when it is entered.  Once the
> + * carrier is off, wait for the polls that are already past that test, so
> + * that the link-down path can reset the RX rings.  A poll that starts later
> + * sees the carrier off and leaves the rings alone.
> + *
> + * A disabled NAPI keeps NAPI_STATE_SCHED set, which is why this is not
> + * napi_synchronize(): stop waiting when the interface is down.  atl1c_up()
> + * gets here before napi_enable(), and atl1c_down() quiesces NAPI itself.
> + */
> +static void atl1c_rx_poll_sync(struct atl1c_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < adapter->rx_queue_count; ++i)
> +		while (test_bit(NAPI_STATE_SCHED,
> +				&adapter->rrd_ring[i].napi.state) &&
> +		       !test_bit(__AT_DOWN, &adapter->flags))
> +			usleep_range(1000, 2000);

[Severity: High]
Does the __AT_DOWN exit leave the RX race open? Both places that set
__AT_DOWN do it while the RX NAPI is still live.

atl1c_close() sets the bit before cancel_work_sync(). napi_disable() only
runs later, in atl1c_down():

atl1c_close() {
	...
	set_bit(__AT_DOWN, &adapter->flags);
	cancel_work_sync(&adapter->common_task);
	atl1c_down(adapter);
	...
}

cancel_work_sync() waits for the work item, and the work item is the
thread doing the ring reset. So at that point nothing has quiesced NAPI.

atl1c_down() is used by suspend, MTU change and ethtool. It sets the bit
before its napi_disable() loop:

atl1c_down() {
	...
	set_bit(__AT_DOWN, &adapter->flags);
	netif_carrier_off(netdev);
	for (i = 0; i < adapter->tx_queue_count; ++i)
		napi_disable(&adapter->tpd_ring[i].napi);
	for (i = 0; i < adapter->rx_queue_count; ++i)
		napi_disable(&adapter->rrd_ring[i].napi);
	...
}

In either case the work item leaves this loop and goes on to
atl1c_reset_mac(), atl1c_reset_dma_ring() and atl1c_configure(). If the
bit was set after atl1c_common_task() checked it on entry, the work item
does not wait at all.

Meanwhile, an atl1c_clean_rx() that has already passed this check can
still be walking the RRD ring on another CPU:

	if (!netif_carrier_ok(adapter->netdev))
		goto quit_polling;

Can atl1c_clean_rx_ring() unmap and free buffer_info->skb while that poll
unmaps the same buffer? The poll could then pass the freed skb to
napi_gro_receive(), or free it a second time.

The code comment says atl1c_down() quiesces NAPI itself, and the commit
message says the same:

    For the same reason the wait gives up when the interface is
    down: a disabled NAPI keeps NAPI_STATE_SCHED set, and atl1c_down() has
    quiesced NAPI on its own.

That does not seem to hold when the exit fires. On the close path
atl1c_down() has not run yet. On the down path napi_disable() has not
started or has not finished.

This loop also polls another context's state bit, and its exit condition
does not synchronise with the poll. Would a fix need real serialisation of
the work item against close and down, plus a wait that ends only when the
poll has finished?

[Severity: Medium]
Can this loop wait forever when the RX NAPI is in threaded busy-poll mode?

An administrator can set NETDEV_NAPI_THREADED_BUSY_POLL through
napi_set_threaded(), and the driver does not need to opt in. In that mode
napi_threaded_poll() keeps NAPI_STATE_IN_BUSY_POLL set, and
napi_complete_done() returns early without clearing SCHED:

net/core/dev.c:napi_complete_done() {
	...
	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
				 NAPIF_STATE_IN_BUSY_POLL)))
		return false;
	...
}

With the carrier off, atl1c_clean_rx() jumps straight to quit_polling and
calls napi_complete_done(), which does nothing. NAPI_STATE_SCHED therefore
stays set for as long as the interface is up, and __AT_DOWN stays clear.

The work item would then never get past atl1c_rx_poll_sync(), so the
atl1c_irq_enable() call in atl1c_common_task() is never reached:

	atl1c_irq_disable(adapter);
	atl1c_check_link_status(adapter);
	atl1c_irq_enable(adapter);

Device interrupts stay masked and later LINK_CHANGE and RESET events are
not handled. The carrier also stays off after the PHY link comes back,
until the interface is brought down. Before this patch the link-down path
had no such wait.

> +}
> +
>  static void atl1c_check_link_status(struct atl1c_adapter *adapter)
>  {
>  	struct atl1c_hw *hw = &adapter->hw;
> @@ -265,6 +285,7 @@ static void atl1c_check_link_status(struct atl1c_adapter *adapter)
>  	if (!link) {
>  		/* link down */
>  		netif_carrier_off(netdev);
> +		atl1c_rx_poll_sync(adapter);
>  		hw->hibernate = true;
>  		if (atl1c_reset_mac(hw) != 0)
>  			if (netif_msg_hw(adapter))

[Severity: High]
This is a pre-existing issue, not introduced by this patch, and the patch
notes list it as not addressed. The same link-down reset also tears down
the TX rings without quiescing TX:

atl1c_check_link_status()
  atl1c_reset_dma_ring()
    atl1c_clean_tx_ring()
      atl1c_clean_buffer() on every tpd_ring->buffer_info[] entry
      memset(tpd_ring->desc, ...)
      next_to_clean = 0, next_to_use = 0

atl1c_clean_tx() checks neither the carrier nor __AT_DOWN. It walks
next_to_clean up to the hardware consumer index and calls
atl1c_clean_buffer() on the same entries.

atl1c_xmit_frame() checks only __AT_DOWN, which the link-down path does
not set. netif_carrier_off() does not stop the TX queue right away; that
happens later through linkwatch.

Can both contexts unmap and free the same TX skb here?

Can atl1c_xmit_frame() keep queuing TPDs, or touch an skb that
atl1c_clean_tx_ring() has just freed, while the ring indices and BQL
state are being reset?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117225521.19689-1-federico%40rimpianto.com
