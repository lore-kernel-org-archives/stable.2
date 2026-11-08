Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121168;
	b=19pNAsHJ7WyvS4Ky9vkGiFhYUet+6B2RdvfTJQTOYQxyeqVqgluCGG5s5mmh1mCA1PYa
	 CjQo5GbVFwpmWvVGr0WYZGU9LFJVKF0oYnQ5cEZPNjbdUqo/sIIamw5IXptCTKD4UO3ni
	 RBYaD2pvnJgmd8HGndDUqvIACV5itQW1kcFXb5GZ6PnTeo9pbjkHRm+t58cC37E/QrjPG
	 IOimKlQ+wDKLd4MkK2BWTfHiL/GfvweaCmO+dzDq1+BTRpqs4y6aXtcJmZGWjPfMcNECr
	 WSVV4/sf6iHMJ8+lmDErLUMPVKYRjURyrviJyUOinTGDgahFXxXQewnTDz4jydd2fnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121168;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TxIUb5bWZGmoAUzDYkV/qaWh4k4doHszwohpd1hGknw=;
	b=cTS4jGLl+1WqV+vBiC4DGZOvZqewDAX2xuGQBBVQT4U3ROxs3GymK/cXsQ080QzKPaOm
	 kAj3ADztdas7n3OuUq2vNhbaddOLvknsk1Po4pI9xxJu+gfAoNZ+ipgsh5P7arZFHfqu8
	 C3YDK6yA70QYf/yyBJZiSTwTxkFizQhyUKmskZEcglxs8WXNjlIXDGq8V0vGs5vp4C7Tm
	 SPfJLt+ABp5r9+rkC+rnoP6B8/9buG2DDaoUOaoqI3sW1f2d39/XinKWtyP496TWSQEso
	 lyBJbvYD77+mPLpsmNUw90WKjJTklFjLTokbp0xLqy8t5qavdOb4+i+hTdjez1tOV3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xpy7CNth;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D9606A31A;
	Sun,  8 Nov 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xpy7CNth
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F61F0089F;
	Sun,  8 Nov 2026 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794121167;
	bh=TxIUb5bWZGmoAUzDYkV/qaWh4k4doHszwohpd1hGknw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xpy7CNthMHn7JInJJ7zre/OqP5C8GcTpHaAlrXr7G+LZmitImXzREGNi8Acd3uiy/
	 98Mv1j0teruR8uzB/8vZJflMq1xUKNjP0vftBPeJ9sLaGTVPv1/p07cViCdHqE9Osn
	 Fhy6zhNjTAopyoC9ni7qR1s4H6Z9aC6u+mJQ7FW5ry7aPVh6h3csm8rGiKTvGK1gYU
	 ZcNxMLybVNYi7nWKBJq1uUJ2NJlJzMbjMDWgTgsga4g+UopjTdOaWr20Ir0l/ltiQ/
	 GHOxM5SQR40nA6apXUStl0Z5+FtpqrRJEJyTZiUbom1wghv6DfAYo8+V+TnLyh/3Wo
	 oglY2IQYn0t9g==
Subject: Re: [PATCH net 1/3] net: atl1: disable work before freeing the netdev
From: netdev-bot+sashiko@kernel.org
To: 0xbeac@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 06:59:26 +0000
Message-ID: <179412116691.994134.8959848817104495766@kernel.org>
In-Reply-To: <20261104063245.23402-2-0xbeac@gmail.com>
References: <20261104063245.23402-2-0xbeac@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message offers atl2_remove() as a correct sibling:
  "atl2_remove() cancels both works and deletes the timer before…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  atl1_reset_dev_task()…

--

net: atl1: disable work before freeing the netdev

This patch changes atl1_remove() to call disable_work_sync() on
reset_dev_task and link_chg_task before unregister_netdev(). After that,
it deletes the PHY config timer. The goal is to stop either work from
running after free_netdev().

> Disable both works synchronously before unregistering the interface,
> then delete the PHY configuration timer.  disable_work_sync() drains a
> queued or running instance and rejects a later queue_work(), which a
> plain cancel_work_sync() would not.  Deleting the timer after the works
> have stopped also prevents a running link work from rearming it.
> atl2_remove() cancels both works and deletes the timer before
> unregistering for the same reason.

[Severity: Medium]
Is atl2_remove() a correct precedent here? By the reasoning in this
message, it looks like atl2 still has the same use-after-free:

drivers/net/ethernet/atheros/atlx/atl2.c:atl2_remove() {
    ...
	set_bit(__ATL2_DOWN, &adapter->flags);

	timer_delete_sync(&adapter->watchdog_timer);
	timer_delete_sync(&adapter->phy_config_timer);
	cancel_work_sync(&adapter->reset_task);
	cancel_work_sync(&adapter->link_chg_task);

	unregister_netdev(netdev);
    ...
}

When the cancel_work_sync() calls run, the IRQ is still requested. It is
only freed by atl2_close(), from inside unregister_netdev(), and
dev_watchdog is still active as well. That leaves these paths able to
queue work again after the cancels:

  atl2_intr()
    schedule_work(&adapter->reset_task);      (link-down and DMA errors)
  atl2_intr() -> atl2_check_for_link()
    schedule_work(&adapter->link_chg_task);   (ISR_PHY or ISR_MANUAL)
  dev_watchdog -> atl2_tx_timeout()
    schedule_work(&adapter->reset_task);

None of these check __ATL2_DOWN. atl2_close() and atl2_down() never
cancel the works, so anything queued in that window can still be pending
at free_netdev().

The ordering is also the reverse of what the message says is needed.
atl2 deletes the timers before it cancels the works, and relies on
__ATL2_DOWN to block rearming. But atl2_reset_task() ->
atl2_reinit_locked() -> atl2_up() runs:

	clear_bit(__ATL2_DOWN, &adapter->flags);

atl2_up() also sets MASTER_CTRL_MANUAL_INT, which can raise a manual
interrupt that queues link_chg_task again.

No other patch in the series touches atl2.c. Should the message stop
describing atl2_remove() as equivalent, or should atl2_remove() get the
same conversion?

> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> index 2883e9462f6fd..2bd35c3cfc820 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> @@ -3132,6 +3132,18 @@ static void atl1_remove(struct pci_dev *pdev)
>  
>  	adapter = netdev_priv(netdev);
>  
> +	/*
> +	 * reset_dev_task is queued from the interrupt handler and from the
> +	 * tx watchdog; link_chg_task is queued from the interrupt handler
> +	 * when ISR_GPHY reports a link event.  Disable both before
> +	 * unregistering the interface so that neither a pending nor a late
> +	 * queue attempt can run after free_netdev().
> +	 */
> +	disable_work_sync(&adapter->reset_dev_task);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
atl1_reset_dev_task() race with atl1_close() and the ethtool
reconfiguration paths? It takes no lock and does not check
netif_running():

drivers/net/ethernet/atheros/atlx/atl1.c:atl1_reset_dev_task() {
    ...
	netif_device_detach(netdev);
	atl1_down(adapter);
	atl1_up(adapter);
	netif_device_attach(netdev);
}

atl1_close() (ndo_stop), atl1_change_mtu(), atl1_set_link_ksettings(),
atl1_set_ringparam() and atl1_nway_reset() all run atl1_down() and
atl1_up() under RTNL. Nothing serializes them against this work, and
atl1_close() does not cancel it:

drivers/net/ethernet/atheros/atlx/atl1.c:atl1_close() {
    ...
	atl1_down(adapter);
	atl1_free_ring_resources(adapter);
	return 0;
}

Here is one possible sequence:

  atlx_tx_timeout() or atl1_intr()
    queue reset_dev_task
  ip link set dev ethX down
    __dev_close_many()           (no netif_device_present() check)
      atl1_close()
        atl1_down()              napi_disable(), free_irq(), ring cleanup
        atl1_free_ring_resources()
  kworker: atl1_reset_dev_task()
    atl1_down()
      napi_disable()
        netdev_lock(n->dev);
        napi_disable_locked(n);  spins forever, SCHED never clears

When that happens, the kworker blocks while holding the netdev instance
lock. A later atl1_open() -> atl1_up() -> napi_enable() -> netdev_lock()
would then deadlock with RTNL held.

If the work instead runs at the same time as close or ethtool -G, both
CPUs end up in atl1_down(). That can call free_irq() twice and double
free skbs in atl1_clean_rx_ring() and atl1_clean_tx_ring(). It can also
let atl1_set_ringparam() or atl1_close() free the descriptor rings while
the worker's atl1_up() is refilling them in atl1_alloc_rx_buffers().

With this patch applied, this disable_work_sync() would also wait forever
on a worker stuck that way. Should the reset work take rtnl_lock() and
check netif_running(), as other drivers do in their reset tasks?

> +	disable_work_sync(&adapter->link_chg_task);
> +	timer_delete_sync(&adapter->phy_config_timer);
> +	adapter->phy_timer_pending = false;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104063245.23402-1-0xbeac%40gmail.com
