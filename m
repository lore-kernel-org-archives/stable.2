Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B43B05BC;
	Tue,  6 Oct 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297087; cv=none; b=AGCZmgNquh5X90X68gn6bPLSQNygTqoLhKMjxJEAcuUb5SXn+ckbpHqS1xZJbkodlUW8E8GSZ63FsoGKq4kvpm43eoyOs/PG7w1A0Z1Moj8mFbipFnTdvmvMHytE52AO4flHlNlOLly1WmS/tNnm2CtGgRgMmKJL7KHu9c308P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297087; c=relaxed/simple;
	bh=WfJ7kz05EDIBDaBQd0N7Ncg/gPRB1u08o28EOUXOxAI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PrHCar2ynE8rW/m3H1JiwOf+Mz4u0ZRW9FkZPMoZ+iPPt6J9XWxex3D6Oye05rw7trpZk+3+DJNlMDG1KzLyiRv8aIX7+ffLrVhKLe05sztOaLJqS+nBOpXv+/K/uFzMZ4EzyDWYWjFKgx0aKuZ3wuB1LbxBF3ONOpRv4gw1nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2bMvvRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2bMvvRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C25E1F0089B;
	Tue,  6 Oct 2026 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297085;
	bh=yMsEyngPMPyZXzcMfBrh10xq7UCPt/b6y7zWUlNjCU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m2bMvvRcakyFBBgEE578cwJq44y+StCczll43nUnAaFMrl78coFiEKFzJp5SnMUYF
	 Rrna/YExWnuv5jp32tMxnoFzbOnOJMat0xK3oHm7lQlRVzk/Vhk4L5wGQoA9db2mAY
	 RdrD0S//fCRSTFfv1eIlkmf9qrLbdieh5bQp2Jh0OG3wyydyNGjxMegu69BlCH0H+L
	 wBkmxx9ZdLwzwqZlGa5j2EzdXQNKVq6qXaJo6phwzuQI6PtrY8P82PzdM87iWM290x
	 newn2QBk+Oa+6MmpQ3UWX/hVkoTpc4B+KaXUoQVIToKYFpEc49uoVLbeSdZmFfj5s/
	 4mxT6q13qSLmQ==
Subject: Re: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
From: netdev-bot+sashiko@kernel.org
To: r.zhambakiev@prosoftsystems.ru
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mgr@kernel.org, shaojijie@huawei.com,
 aleksandr.loktionov@intel.com, benato.denis96@gmail.com,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Date: Tue, 06 Oct 2026 14:31:24 +0000
Message-ID: <179129708468.434549.1549616598649604184@kernel.org>
In-Reply-To: <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
References: <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch makes fealnx_remove_one() free both DMA rings, unmap
  np->mem and free the netdev right after unregister_netdev().
- [Medium] The patch's safety argument is that dev_close() stops the
  Tx/Rx engines before fealnx_remove_one() frees the descriptor rings.

--

net: fealnx: fix teardown order in remove

This commit moves unregister_netdev() ahead of the dma_free_coherent()
calls in fealnx_remove_one(). The goal is for dev_close() to stop the
Tx/Rx engines, delete the timers and free the IRQ before the DMA rings
are freed.

> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index bdc38aac58509..68194c9ef3326 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -682,11 +682,11 @@ static void fealnx_remove_one(struct pci_dev *pdev)
>  	if (dev) {
>  		struct netdev_private *np = netdev_priv(dev);
>  
> +		unregister_netdev(dev);

[Severity: High]

Does netdev_close() in drivers/net/ethernet/fealnx.c really guarantee
what the commit message relies on? It runs this sequence without taking
np->lock:

drivers/net/ethernet/fealnx.c:netdev_close() {
    ...
	iowrite32(0x0000, ioaddr + IMR);
    ...
	stop_nic_rxtx(ioaddr, 0);

	timer_delete_sync(&np->timer);
	timer_delete_sync(&np->reset_timer);

	free_irq(np->pci_dev->irq, dev);
    ...
}

intr_handler() is registered with IRQF_SHARED. It can already be running
on another CPU while holding np->lock. Its loop checks the software
np->imrvalue, so the IMR=0 write above does not stop it.

Suppose the handler reaches the too-much-work path after
timer_delete_sync(&np->reset_timer) has returned:

intr_handler() {
    ...
		if (--boguscnt < 0) {
			...
			if (!np->reset_timer_armed) {
				np->reset_timer_armed = 1;
				np->reset_timer.expires = RUN_AT(HZ/2);
				add_timer(&np->reset_timer);
    ...
}

free_irq() waits for the handler to finish, but it does not cancel the
timer the handler armed. Can reset_timer still be pending when
unregister_netdev() returns?

If it can, fealnx_remove_one() then frees the rings, unmaps np->mem and
calls free_netdev(). That frees the timer_list embedded in np while it
is still queued.

When reset_timer() later fires, it takes np->lock in freed memory and
calls enable_rxtx(). enable_rxtx() touches rx_ring through
reset_rx_descriptors(). It then writes the freed tx_ring_dma and
rx_ring_dma into TXLBA/RXLBA through the unmapped np->mem.

Three other paths write np->crvalue, with RXEN/TXEN still set, back to
TCRRCR after close's stop_nic_rxtx():

- the RBU branch in intr_handler()
- the rx error branch in netdev_rx()
- the media change branch in netdev_timer(), which can run before
  timer_delete_sync(&np->timer)

The handler also restores IMR on exit:

	iowrite32(np->imrvalue, ioaddr + IMR);

Could any of these turn the engines and interrupts back on before the
rings are freed? Remove does no BCR soft reset and does not clear bus
mastering before dma_free_coherent(), so a re-enabled chip could DMA
into the freed ring pages.

Later patches in the series leave netdev_close() unchanged. They add
pci_disable_device() only after the rings are freed.

Would netdev_close() need to clear the enable bits under np->lock, and
sync the IRQ before a final timer_shutdown_sync()? Would the chip also
need a reset before the rings are freed?

>  		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
>  				  np->tx_ring_dma);
>  		dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
>  				  np->rx_ring_dma);

[Severity: Medium]

Are the engines guaranteed to have stopped before these rings are freed?
The only hardware quiesce step in netdev_close() is stop_nic_rxtx(), and
it does not report failure:

drivers/net/ethernet/fealnx.c:stop_nic_rxtx() {
	int delay = 0x1000;
	iowrite32(crvalue & ~(CR_W_RXEN+CR_W_TXEN), ioaddr + TCRRCR);
	while (--delay) {
		if ( (ioread32(ioaddr + TCRRCR) & (CR_R_RXSTOP+CR_R_TXSTOP))
					    == (CR_R_RXSTOP+CR_R_TXSTOP) )
			break;
	}
}

The poll has no delay between reads. To netdev_close(), running out of
the budget looks the same as a successful stop.

A Tx frame might still be in collision backoff on a 10 Mb/s half-duplex
link, or the chip might be wedged, for example after tx_timeout. In
either case, could the chip still write descriptor status into tx_ring
or rx_ring after dma_free_coherent()?

The driver already has reset_and_disable_rxtx(), which does the stop,
IMR=0 and a BCR soft reset. Neither close nor remove uses it, and bus
mastering is not cleared before the rings are freed.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002140954.261779-1-r.zhambakiev%40prosoftsystems.ru
