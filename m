Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB4463B7C;
	Mon, 21 Sep 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982337; cv=none; b=EybYZh3YLe6JDnSsJKmF9DWbB6jng1L9FfHXFOEBddPfMAhwyaDnoUFD9i2j1qKgvBvWXV2K8VAEjzsDK+TsTIfbLCoYh67Vul5grJjWPdSNZg/FmDlo7o+0QMHaWK0Er6dq/YXcy2U2V7oSco4sMzv9+kyqhx6tQZLrsKXntZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982337; c=relaxed/simple;
	bh=u7bVl4hRiMTQsC3MKL8oRiGtWTLxJrLTyj0LgSzUTuY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UppawaCA5cFuygLDLotz98wrAJjxmlQLfU0815a6FLEmb1YHWAI5Vw5xWDytgckDAgTeXBwFiPr9wqFPWeOkstt6sSNlffVzA+wujZua/SyHiD+HUwuZwuThNcEFY+FFU59waMQF4xWp3kQa+rFwpap9/V5f2j9Ht1dMcC5RaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3haOI5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3haOI5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69171F00893;
	Mon, 21 Sep 2026 09:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982335;
	bh=XR2pN0h64X5a4n7ui1Qu+CJKcG5qEc6S/wW/aVVeHDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h3haOI5fqPy++4hueGsG2UNf+CFultvgD5E2Z2JbdNOah26aL8RbHBDi08XcPT5uZ
	 QBqtFeams38RMwMvV2sNukbYnb63RAqkIzefShAfbUajT44cafwNY1XE1Kgajzvpwc
	 mxIRj178VVu4v1owdjalx52b9/rzj8mgFjghgmOmk9sEhSjpTEgCIY4IUy7D7rcuzp
	 15Ui3fuxNH1mPsb18X1qK+FsQBk0B2Q4dpOlTcf1KEJfnxzPIg7NUiv+Z+EAvuf43r
	 vbN+Bx5tGz+WNfWOjTm6A8HO1BYG28Xz63AxhHrzqwq7zdhDZgRpDBtWKhtb4ruF8e
	 RbNAQVkgx01mw==
Subject:
 Re: [PATCH net 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
From: netdev-bot+sashiko@kernel.org
To: zhangyunfei1@kylinos.cn
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 leitao@debian.org, weirongguang@kylinos.cn, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 09:18:54 +0000
Message-ID: <178998233448.2160803.12090332415521537974@kernel.org>
In-Reply-To: <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
References: <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] For all ngbe_open() failures that occur after wx_configure()
  (i.e. ngbe_request_irq(), phylink_connect_phy(),…

Pre-existing issues:
- [High] ngbe_open()'s error unwind
  (drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:522-531) frees the…
- [High] ngbe_setup_tc()
  (drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:630-647) discards the…
- [Low] The new wx_control_hw(wx, false) at
  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:530 performs an unlocked…

--

net: ngbe: clear DRV_LOAD bit when ngbe_open() fails

The patch makes every error path of ngbe_open() fall through a new
err_control_hw label that calls wx_control_hw(wx, false), so the
WX_CFG_PORT_CTL_DRV_LOAD handshake bit is rolled back when the open
fails instead of being left asserted until the next successful ifup.

A few questions about the resulting error unwind below.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 6d8289e2532d0..88f00b72a5123 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -494,7 +494,7 @@ static int ngbe_open(struct net_device *netdev)
>  
>  	err = wx_setup_resources(wx);
>  	if (err)
> -		return err;
> +		goto err_control_hw;
>  
>  	wx_configure(wx);
>  
> @@ -526,6 +526,8 @@ static int ngbe_open(struct net_device *netdev)
>  err_free_resources:
>  	wx_free_isb_resources(wx);
>  	wx_free_resources(wx);
> +err_control_hw:
> +	wx_control_hw(wx, false);
>  	return err;
>  }

[Severity: Medium]

For the failures that happen after wx_configure() has run
(ngbe_request_irq(), phylink_connect_phy(),
netif_set_real_num_tx_queues(), netif_set_real_num_rx_queues()), does
this unwind free DMA memory that the hardware is still programmed to
use?

wx_configure() arms the datapath before any of those calls can fail:

  wx_configure()
    wx_configure_tx()   /* enables Tx queues, TDM, MAC transmitter */
    wx_configure_rx()
      wx_configure_rx_ring()
        wr32(wx, WX_PX_RR_BAL(reg_idx), rdba & DMA_BIT_MASK(32));
        wr32(wx, WX_PX_RR_BAH(reg_idx), upper_32_bits(rdba));
        wr32m(wx, WX_PX_RR_CFG(reg_idx), WX_PX_RR_CFG_RR_EN, WX_PX_RR_CFG_RR_EN);
        wx_enable_rx_queue(wx, ring);
        wx_alloc_rx_buffers(ring, wx_desc_unused(ring));
      wx_enable_rx(wx);
    wx_configure_isb()
      wr32(wx, WX_PX_ISB_ADDR_L, wx->isb_dma & DMA_BIT_MASK(32));

The error labels then release exactly that memory:

  wx_free_isb_resources()  /* dma_free_coherent() of the ISB buffer */
  wx_free_resources()
    wx_free_all_rx_resources()
      wx_free_rx_resources()
        wx_clean_rx_ring(rx_ring);
        dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
                          rx_ring->dma);
        page_pool_destroy(rx_ring->page_pool);

None of the quiesce steps that ngbe_disable_device() performs run here:

  for (i = 0; i < wx->num_rx_queues; i++)
          wx_disable_rx_queue(wx, wx->rx_ring[i]);
  wx_disable_rx(wx);
  ...
  wx_irq_disable(wx);
  for (i = 0; i < wx->num_tx_queues; i++)
          wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);

Can a descriptor or buffer writeback in that window land in freed
coherent memory or an unmapped IOVA?

Related to that, the commit message says the rollback is "matching
ngbe_close() and ngbe_dev_shutdown(), which already clear it".  Is the
ordering the same though?  ngbe_close() quiesces first and only then
releases the handshake:

  wx_ptp_stop(wx);
  ngbe_down(wx);
  wx_free_irq(wx);
  wx_free_isb_resources(wx);
  wx_free_resources(wx);
  phylink_disconnect_phy(wx->phylink);
out:
  wx_control_hw(wx, false);

Here the new wx_control_hw(wx, false) hands the port back to the
NCSI/OOB firmware while the Rx unit and RXEN are still enabled and the
rings have already been freed.  Would routing the error paths through
ngbe_down() (or at least the wx_disable_rx_queue()/wx_disable_rx()/
wx_irq_disable() sequence) before freeing resources and clearing
DRV_LOAD be closer to what ngbe_close() does?

[Severity: High]

This isn't a bug introduced by this patch, but while the unwind is
being reworked: should this path also set WX_STATE_RES_FREED?

ngbe_close() uses that bit as its only record of "resources already
released":

  if (test_bit(WX_STATE_RES_FREED, wx->state))
          goto out;

  wx_ptp_stop(wx);
  ngbe_down(wx);
  wx_free_irq(wx);
  wx_free_isb_resources(wx);
  wx_free_resources(wx);

ngbe_open() is also called on netdevs whose __LINK_STATE_START is
already set (ngbe_setup_tc(), ngbe_resume(), and wx_io_resume() in
libwx/wx_err.c), so a failed open leaves netif_running() true with the
IRQs, the ISB buffer and the rings freed while the bit is clear.

The next ndo_stop then repeats the teardown.  wx_free_irq() calls
free_irq() on vectors that were never requested, and
ngbe_down() -> wx_clean_all_rx_rings() -> wx_clean_rx_ring() reaches:

  /* Zero out the descriptor ring */
  memset(rx_ring->desc, 0, rx_ring->size);

with rx_ring->desc already NULL and rx_ring->size still non-zero, since
wx_free_rx_resources() clears desc but not size.  Can that oops?

[Severity: High]

This is a pre-existing issue too, but this patch makes the error return
of ngbe_open() more meaningful, so it seems worth asking: ngbe_setup_tc()
throws it away.

  wx_init_interrupt_scheme(wx);

  if (netif_running(dev))
          ngbe_open(dev);

  return 0;

wx_init_interrupt_scheme() can fail with -ENOMEM from
wx_set_interrupt_capability()/wx_alloc_q_vectors(), and every failure
exit of ngbe_open() now funnels through err_control_hw and returns a
negative errno.  Both are dropped and 0 is returned unconditionally, so
wx_set_channels() in libwx/wx_ethtool.c:

  return wx->setup_tc(dev, netdev_get_num_tc(dev));

reports success to user space while the interface stays administratively
running with rings and the ISB buffer freed, no IRQs requested, the PHY
disconnected, and now DRV_LOAD cleared with nothing re-asserting it
until a later successful ndo_open.  Should ngbe_setup_tc() propagate
these errors?

[Severity: Low]

This is a pre-existing pattern rather than something the patch
introduces, noted only for completeness: wx_control_hw() does an
unlocked read-modify-write of WX_CFG_PORT_CTL through wr32m():

  val = rd32(wx, reg);
  val = ((val & ~mask) | (field & mask));
  wr32(wx, reg, val);

__wx_enable_sriov() in libwx/wx_sriov.c updates the same register:

  wr32m(wx, WX_CFG_PORT_CTL,
        WX_CFG_PORT_CTL_NUM_VT_MASK,
        value);

and it runs from wx_pci_sriov_enable() under the PCI device_lock but
before wx_sriov_reinit() takes RTNL, so RTNL does not serialize the two.
The identical unlocked update already exists on every ifup via
wx_control_hw(wx, true), in ngbe_close() and in ngbe_dev_shutdown(), so
this line adds no new race class; serializing the WX_CFG_PORT_CTL
updates would be a separate libwx cleanup.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917090050.1927999-1-zhangyunfei1%40kylinos.cn
