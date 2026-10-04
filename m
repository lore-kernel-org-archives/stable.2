Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB23FBB7D;
	Sun,  4 Oct 2026 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109257; cv=none; b=a6tEnN9gJxW9NVWwnB9qpRHm9eARgIdAWsG9WTHO1AIjODgPQaodhSZxmx/tHSnDtcEz8SRBhdp67D0DqCuuuRnB5HwSGCTV00P50rpfOCzZonbpRur+DtIKVml/n5ROt5amoFA4eeRqREJ/verJrv2+9E/vBeiNLqJX4Hcy9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109257; c=relaxed/simple;
	bh=ZpyAmci2uPzjj6iq0pHDtBXcALLxv67kTDtzNTtpnD4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9o3far6Tfid2Zp1l5E/RDa8EYKjN5/pnplf2fJWWbpe0p1goGZa6Z+a2dVk4/MvNiMre7hWIL9zHfh62Ub0f5C7bbCFIx9kXUXLoZAhamW0ndJTznap0/5lCT0N3THuCmTd65tjMO1pikoLxVmVI6RcKPiqRX+wrwLGQ7RGSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdjq64/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdjq64/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025411F000FF;
	Sun,  4 Oct 2026 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109255;
	bh=Xap5NGdEiE3Uni5fnY7MzZEkILXRd7MvSDBpnB5Pia4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kdjq64/akqk3TS8jmz/2FjE/bMbtaHHm0g2NeSpPemaZhhKuRfPDPicGMEmYdCPib
	 6YtednBgQzQhkMPGngGNQR8voTLOoydCtcyUbi25IupVxKrxcHmuP897l2BbcP0Z1R
	 WgUQ78yaqrII8AXh0gvs3rSfpNuzyIjP8w7O7T0p66HLTRuc+Lqy1r49PYEOqi7Jn9
	 7adrPg7YOiS33n8hMi4N4Rz2EBm5yr6//oT+qgHCreDtSelfJ9lgTRJIpzqRbE6Kq+
	 dW3/GuH52/o1FG28Z1KBet6Oj4372CwWdCL6m8NKuON/PI9WT7SDP/0NP/u3wSo/9/
	 0RticYU3Aq5JQ==
Subject:
 Re: [PATCH net v3 1/2] net: ngbe: propagate resume errors to the PM core
From: netdev-bot+sashiko@kernel.org
To: zhangyunfei1@kylinos.cn
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, leitao@debian.org,
 sashiko-bot@kernel.org
Date: Sun, 04 Oct 2026 10:20:54 +0000
Message-ID: <179110925452.434549.18313305242619109981@kernel.org>
In-Reply-To: <20260930094748.1198085-2-zhangyunfei1@kylinos.cn>
References: <20260930094748.1198085-2-zhangyunfei1@kylinos.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is tagged `Cc: stable@vger.kernel.org` and `Fixes:
  6963e463256e` ("net: ngbe: add Wake on Lan support", July 2023).
- [Medium] The patch marks the post-suspend freed state with
  `WX_STATE_RES_FREED` only when `ngbe_resume()` fails.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the shared
  Wangxun VF resume path has the same defect this patch fixes for ngbe,…
- [High] This problem wasn't introduced by this patch, but the patch now
  relies on it.

--

net: ngbe: propagate resume errors to the PM core

This patch changes err in ngbe_resume() from u32 to int. It also passes
failures from ngbe_reset_hw(), wx_init_interrupt_scheme() and ngbe_open()
up to the PM core, instead of always returning 0. On every failing return
it sets WX_STATE_RES_FREED, so a later ngbe_close() skips the teardown of
state that was already freed at suspend.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917090050.1927999-1-zhangyunfei1%40kylinos.cn

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610c..8247f6c14be0f 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,13 +954,14 @@ static int ngbe_resume(struct pci_dev *pdev)

[ ... ]

>  	err = pci_enable_device_mem(pdev);
>  	if (err) {
> +		set_bit(WX_STATE_RES_FREED, wx->state);

[Severity: Medium]
This patch has Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
and Cc: stable, so it will be picked up for every stable tree from v6.6.y
on. Will it build in those trees?

WX_STATE_RES_FREED comes from commit e73e4d187a1f52 ("net: wangxun: add
pcie error handler"). So does the check in ngbe_close() that this fix
depends on:

    if (test_bit(WX_STATE_RES_FREED, wx->state))
        goto out;

e73e4d187a1f52 is a feature commit with no Fixes: or stable tag. The
commit message doesn't list it as a dependency.

In stable trees that have 6963e463256e but not e73e4d187a1f52,
WX_STATE_RES_FREED is undeclared. A backporter might drop the set_bit()
calls to get it to build. In that case ngbe_close() still has no
RES_FREED guard in those trees. The post-suspend "Trying to free
already-free IRQ" double teardown described in the commit message would
then still happen after a failed resume.

Should e73e4d187a1f52 be listed as a stable prerequisite?

>  		wx_err(wx, "Cannot enable PCI device from suspend\n");
>  		return err;
>  	}
> @@ -968,16 +969,23 @@ static int ngbe_resume(struct pci_dev *pdev)
>  	pci_set_master(pdev);
>  	device_wakeup_disable(&pdev->dev);
>  
> -	ngbe_reset_hw(wx);
> +	err = ngbe_reset_hw(wx);
> +	if (err) {
> +		set_bit(WX_STATE_RES_FREED, wx->state);
> +		wx_err(wx, "Hardware reset failed: %d\n", err);
> +		return err;
> +	}

[Severity: Medium]
The state being marked here is freed at suspend time, not in
ngbe_resume(). ngbe_suspend()->ngbe_dev_shutdown() does:

    rtnl_lock();
    netif_device_detach(netdev);

    if (netif_running(netdev))
        ngbe_close(netdev);
    wx_clear_interrupt_scheme(wx);
    rtnl_unlock();

It never sets WX_STATE_RES_FREED, and __LINK_STATE_START stays set.

Can something else close the netdev between suspend and the point where
ngbe_resume() either succeeds or reaches one of these set_bit() calls?
dev_close() doesn't check netif_device_present(). Take any RTNL holder,
such as netns teardown on the non-freezable netns_wq:

default_device_exit_net()
  dev_change_net_namespace()
    dev_close()
      ngbe_close()

It would see RES_FREED clear and run ngbe_down() and wx_free_irq()
again. MSI-X is already gone at that point, so wx_free_irq() takes this
path:

    if (!(pdev->msix_enabled)) {
        if (!wx->misc_irq_domain)
            free_irq(pdev->irq, wx);
        return;
    }

That gives the same "Trying to free already-free IRQ" warning the commit
message describes.

The locking is also inconsistent. This set_bit() and the one after the
pci_enable_device_mem() failure run without rtnl_lock. ngbe_close() tests
the bit under RTNL, and the third set_bit() below is also under RTNL.

Would it work to set WX_STATE_RES_FREED in ngbe_dev_shutdown() under
RTNL, right after ngbe_close() and wx_clear_interrupt_scheme()? That is
what ngbe_down_suspend() does. A successful resume clears the bit again
through ngbe_open()->ngbe_up_complete(), and the three set_bit() calls in
ngbe_resume() would no longer be needed.

>  	rtnl_lock();
>  	err = wx_init_interrupt_scheme(wx);
>  	if (!err && netif_running(netdev))
>  		err = ngbe_open(netdev);
>  	if (!err)
>  		netif_device_attach(netdev);
> +	else
> +		set_bit(WX_STATE_RES_FREED, wx->state);

[Severity: High]
This is a pre-existing issue, but this patch now depends on it. When
ngbe_open() fails here, does anything stop the RX DMA that ngbe_open()
has already turned on?

Before any step in ngbe_open() can fail, wx_configure() has already armed
RX:

wx_configure()
  wx_configure_rx()
    wx_configure_rx_ring()  <- programs WX_PX_RR_BAL/BAH, sets RR_EN,
                               calls wx_enable_rx_queue() and
                               wx_alloc_rx_buffers()
    wx_enable_rx()          <- sets WX_MAC_RX_CFG_RE and
                               WX_RDB_PB_CTL_RXEN

If ngbe_request_irq(), phylink_connect_phy() or
netif_set_real_num_{tx,rx}_queues() fails afterwards, the unwind is:

err_dis_phy:
	phylink_disconnect_phy(wx->phylink);
err_free_irq:
	wx_free_irq(wx);
err_free_resources:
	wx_free_isb_resources(wx);
	wx_free_resources(wx);
err_control_hw:
	wx_control_hw(wx, false);
	return err;

wx_free_rx_resources() calls dma_free_coherent() on the descriptor ring
and destroys the page pool. Nothing writes the registers that disable the
RX queues or the MAC receiver.

On this resume path bus mastering is still on, because ngbe_reset_hw()
called pci_set_master(). With the new set_bit(), a later ngbe_close()
jumps straight to wx_control_hw(false) and skips
ngbe_down()->ngbe_disable_device(). That is the only code that stops the
queues.

Even without the RES_FREED mark, ngbe_disable_device() would return early.
wx_init_interrupt_scheme() set WX_STATE_DOWN, and nothing cleared it.

If the link is up, for example kept up for Wake-on-LAN, can incoming
frames be DMA-written into the freed descriptor memory and freed pages?
A plain ndo_open failure reaches the same unwind.

The patch in this series "net: ngbe: clear DRV_LOAD bit when ngbe_open()
fails" adds wx_control_hw(wx, false) to this unwind. That covers the
stale WX_CFG_PORT_CTL_DRV_LOAD bit. It still doesn't disable the RX rings
or the MAC receiver, so the DMA part is still open at the end of the
series.

>  	rtnl_unlock();
>  
> -	return 0;
> +	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the shared Wangxun VF
resume path has the same problem, and there it can crash.
wxvf_resume() in drivers/net/ethernet/wangxun/libwx/wx_vf_common.c is
used by both ngbevf and txgbevf:

	pci_set_master(pdev);
	wx_init_interrupt_scheme(wx);
	netif_device_attach(wx->netdev);

	return 0;

If wx_init_interrupt_scheme() fails, the PM core is told resume succeeded
and the netdev is attached with no q_vectors. wxvf_suspend() has already
freed them: wx_free_q_vector() sets the wx->tx_ring[] and wx->rx_ring[]
entries to NULL, and wx_reset_interrupt_capability() sets wx->msix_entry
to NULL.

A later "ip link set up" then passes the netif_device_present() check and
runs wxvf_open(). Does that dereference NULL?

If MSI-X allocation failed, the queue counts are left non-zero, so
wx_setup_resources() walks NULL tx_ring[] entries.

If q_vector allocation failed, wx_request_msix_irqs_vf() runs:

	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
			  0, netdev->name, wx);

with msix_entry set to NULL.

The commit message limits the fix to ngbe. Should wxvf_resume() get the
same error handling?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094748.1198085-1-zhangyunfei1%40kylinos.cn
