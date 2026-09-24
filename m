Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84B4AA402;
	Thu, 24 Sep 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270996; cv=none; b=f6vUVTpqUbxQpSfHAiAGEIdpn2hxlkCfhq1wbqwCnhR6mk+oUv/eclzTA/9nknBKJBQOWB5VQfVA6zoOgURcq3pAjdVrI7MIV6JqInlmJnJFM5SJBop1FSxmYEIbDvVHTZgnEmbk44HGMqZ467yY/xAXPcMwazCchiN8quZJVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270996; c=relaxed/simple;
	bh=ti7W10/PMgF3rzwzjA+tM3Mit/c6YQHhH3CQul23C9g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvFK44yyBmju04PnrA59+YdqRkjDUmBxzak01LKnNoKICDa+4rf7YClf+K5rS8HvWW+KZo6sHTQdZyTfb/ko0VAFFCHsd2wf9//PSzUCWnC+QJh9rVrPXxeQ+jWNdGQyfxziYxv3zE0liC9BG0HIIj5oPzKKhq2BEBTpErHG+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMGzmzXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMGzmzXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136C41F00A14;
	Thu, 24 Sep 2026 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270991;
	bh=AWuJrElzdRJtzg/vX5ScZLxe4h+n9U+xf8t1nAlCZMg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gMGzmzXoLmhIeKSmlKQOMJitwLIDOTiQ4qPXyuYhth9qiLWkbDIhbwQ7EUUeYwgIt
	 iTLOgiN4vk8m2aOvauF3ioaL8x2frx42ObpX5ct/NWHsUizBBMq3YimmbflOAPb8IJ
	 gcFRsBA87733MHmblVJbd/hIm9ubVK5fjHN4+/YKosvRjLi33CPDEj9hD4sDStir6c
	 w4eYLZAgRoUP/wmrk3VxwNH+oZuJSETDSXZpoUYi5Q9ujlZCT7pY7KTmC9gZMaBZyl
	 1fFmvqfzSq6Vp+NYPrUdXGhbb5q8KVFVU8Cxt6zM/flwCJMOtR4ObgXPcB8Z+CWxki
	 nV0i4imar+o9w==
Subject:
 Re: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the PM core
From: netdev-bot+sashiko@kernel.org
To: zhangyunfei1@kylinos.cn
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 leitao@debian.org, weirongguang@kylinos.cn, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 17:29:50 +0000
Message-ID: <179027099059.2160803.11768054293846758522@kernel.org>
In-Reply-To: <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
References: <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The newly added early return `err = ngbe_reset_hw(wx); if (err)
  return err;` in ngbe_resume()…

--

net: ngbe: propagate resume errors to the PM core

ngbe_resume() used a u32 err and always returned 0, so resume failures
were never reported.  The patch changes err to int, propagates the
wx_init_interrupt_scheme()/ngbe_open() error, and adds a new early
return when ngbe_reset_hw() fails.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610c..e8cabcc84a414 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)
>  {
>  	struct net_device *netdev;
>  	struct wx *wx;
> -	u32 err;
> +	int err;
>  
>  	wx = pci_get_drvdata(pdev);
>  	netdev = wx->netdev;
> @@ -968,7 +968,9 @@ static int ngbe_resume(struct pci_dev *pdev)
>  	pci_set_master(pdev);
>  	device_wakeup_disable(&pdev->dev);
>  
> -	ngbe_reset_hw(wx);
> +	err = ngbe_reset_hw(wx);
> +	if (err)
> +		return err;

[Severity: High]
Can this new bail-out leave the driver state claiming resources it no
longer owns?

The suspend side calls ngbe_close() directly rather than dev_close():

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_dev_shutdown() {
	...
	if (netif_running(netdev))
		ngbe_close(netdev);
	wx_clear_interrupt_scheme(wx);
	...
}

So __LINK_STATE_START is never cleared and netif_running(netdev) stays
true, while wx_clear_interrupt_scheme() zeroes wx->num_tx_queues /
num_rx_queues / num_q_vectors, NULLs wx->tx_ring[]/rx_ring[] in
wx_free_q_vector(), and calls pci_free_irq_vectors() so
pdev->msix_enabled and msi_enabled become false.

Returning here skips wx_init_interrupt_scheme(), so none of that is
rebuilt.  ngbe_close()'s only idempotency guard is WX_STATE_RES_FREED,
and that bit is set only by ngbe_down_suspend() (the PCIe error
recovery path), not by ngbe_dev_shutdown():

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_close() {
	if (test_bit(WX_STATE_RES_FREED, wx->state))
		goto out;

	wx_ptp_stop(wx);
	ngbe_down(wx);
	wx_free_irq(wx);
	...
}

Does that mean the next ndo_stop - "ip link set <dev> down", a second
ngbe_dev_shutdown() (netif_running() is still true), or
unregister_netdev() from ngbe_remove() on rmmod - re-runs the full
teardown on already-freed state and hits the unbalanced free_irq()
here?

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_irq() {
	...
	if (!(pdev->msix_enabled)) {
		if (!wx->misc_irq_domain)
			free_irq(pdev->irq, wx);
		return;
	}
	...
}

With msix_enabled false and wx->misc_irq_domain never set on ngbe (only
txgbe sets it), free_irq(pdev->irq, wx) is issued for an IRQ that has no
registered action, which gives the "Trying to free already-free IRQ"
WARN, or a panic with panic_on_warn.

Separately, ngbe_set_ringparam() is gated on netif_running() only, not
netif_device_present():

drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:ngbe_set_ringparam() {
	...
	if (!netif_running(wx->netdev)) {
	...
}

After the failed resume it takes the "running" branch and drives
ngbe_down()/ngbe_up() with zero q_vectors and no IRQ vectors, and
ngbe_up_complete() clears WX_STATE_DOWN and restarts the tx queues of a
detached netdev whose tx_ring[] entries are NULL and whose
wx->num_tx_queues is 0, which wx_xmit_frame() then uses in
r_idx % wx->num_tx_queues.

Would it be better to leave a consistent representation before
returning, for example mirroring ngbe_down_suspend() by setting
WX_STATE_RES_FREED, or keeping the interrupt scheme initialised, or
marking the interface down, so the second close is a no-op?

ngbe_reset_hw() can fail through wx_stop_adapter() ->
wx_disable_pcie_master() returning -ETIMEDOUT, or through the
read_poll_timeout() on 0x10028, so this is reachable on a hardware or
timing fault and the follow-up ifdown/rmmod is an ordinary operation
once the NIC looks dead.

The same double-teardown hazard already exists on the pre-existing
wx_init_interrupt_scheme()/ngbe_open() failure paths below, but this
patch adds a new route into it.  The only follow-up patch found, "net:
ngbe: clear DRV_LOAD bit when ngbe_open() fails", touches ngbe_open()
only and leaves ngbe_resume() unchanged.

>  	rtnl_lock();
>  	err = wx_init_interrupt_scheme(wx);
>  	if (!err && netif_running(netdev))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922100836.1147718-1-zhangyunfei1%40kylinos.cn
