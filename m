Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501023;
	b=33f94/MwjcE7/o059DwRyddo8TXBiQmjE9rYWXPWEhnWZ8AdCjfzhKijJ5lockiC35uY
	 0QuzxFwv7ilxw2aeNhjMVtqI2c55ror3BNAVCD9vT3rZzyX5XW+Ak6OmFzCXY3hWgvgTi
	 wj+v+cUFOZbOgEVdmZNoMAljYlvznmIQXsldsWqcRTlqVz7u1JqsUQUOMcJkoZOhOjkDn
	 i4yFxCPfEHde0g5keZaP7PRkqnOkkUGamRtpi4VobDnq3zU2GoVcaSTmmv8NdYRzomMK8
	 hf0OUm484a2jDDS4RKLQ1thZVpbA/uXTgSbm5CK9cR1u6EaISqmX8hEADMdyHyZc7Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501023;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kj3jY71KNu7EonmjA6hia9bcgwhknY40spNJGqFG/Dk=;
	b=rtxXPjlldIOGIJ5g/NAKYKWeU80UOdNE7rRfxsAlC24S9kU4N+R6JYxRdT/zAIRzn9HF
	 KeUMH5gnp9SvokrckhnZQHmpgfhVRDlqH+1xSOIYvP/Z7G2rf8KqatVKDMnwJzGMyie5l
	 EgGMbwm1I1sdDbZg09P01rwObKAcQd6H9u0G4lQQoSv8XYIUqWx6qV4tF6X9ybppKa80/
	 yYl610mBvYQUtHa3IZRIcwZay4lRo7WPqiu1urTCrnmta5uN0rMze4cyQI/Gy+RECKmxx
	 L1hTbwcjCCtcAf4E01UVxC7GYIj2qWnGFnjkqyLHkIBryIs1PzqB2/9dFMJxNHB5vRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hI414lJ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6B606A323;
	Thu, 12 Nov 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hI414lJ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85351F000C4;
	Thu, 12 Nov 2026 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501023;
	bh=kj3jY71KNu7EonmjA6hia9bcgwhknY40spNJGqFG/Dk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hI414lJ5ZvaBmJMUDAvcxHQPBmcysI+sMi7p4MjcAAG4WOnlpABfwnIdj2KqfC7f2
	 PYPRnC46QtRmRjSRER5ZkUcKNSF1LCWNMkzx4LjTVRivaMXVDs30PLwXZhjk28Z8qQ
	 TiFO8gw3/kL+/WPPkE5Ms4DCXSbWtjNHeVSIdhgDurDdlKk/NazdvWqgc+0IzrlkIN
	 ilWjZKuBE8u/oK/MU3pzwY8OpvyCKT+zwSPzkJoE+i1b2NMvA2koRNjCquxgXZJURv
	 iLPQByQoMQ3sJmjuz/dLpL1rM6epLmmOOJRFwzkUl05huk3O8k5hW1PzF3uEwD9H0s
	 slcZyy7rOiMnQ==
Subject: Re: [PATCH net] net: 8139too: cancel the thread work after
 unregister_netdev()
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Date: Thu, 12 Nov 2026 16:30:22 +0000
Message-ID: <179450102226.2199510.1336538624039413031@kernel.org>
In-Reply-To: <20261110042903.55991-1-mhun512@gmail.com>
References: <20261110042903.55991-1-mhun512@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch, the case the commit says it fixes (the thread
  work still live when __rtl8139_cleanup_dev() calls free_netdev()) can…

--

net: 8139too: cancel the thread work after unregister_netdev()

This patch moves cancel_delayed_work_sync(&tp->thread) in
rtl8139_remove_one() so it runs after unregister_netdev(). Before the move,
rtl8139_open() or the TX watchdog could queue the work again after the
cancel and before the netdev is freed.

> diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
> index 8241bcf766644..efcf46fd9842f 100644
> --- a/drivers/net/ethernet/realtek/8139too.c
> +++ b/drivers/net/ethernet/realtek/8139too.c
> @@ -1103,10 +1103,10 @@ static void rtl8139_remove_one(struct pci_dev *pdev)
>  
>  	assert (dev != NULL);
>  
> -	cancel_delayed_work_sync(&tp->thread);
> -
>  	unregister_netdev (dev);
>  
> +	cancel_delayed_work_sync(&tp->thread);
> +

[Severity: High]
Can a running instance of tp->thread still be live when
__rtl8139_cleanup_dev() calls free_netdev()?

The commit message says rtl8139_tx_timeout() reinitializes the work, and
that code is still present:

drivers/net/ethernet/realtek/8139too.c:rtl8139_tx_timeout() {
    ...
	tp->watchdog_fired = 1;
	if (!tp->have_thread) {
		INIT_DELAYED_WORK(&tp->thread, rtl8139_thread);
		schedule_delayed_work(&tp->thread, next_tick);
	}
}

On every HAS_LNK_CHNG chip except CH_8139_K, have_thread stays 0,
because rtl8139_start_thread() returns early:

	else if (tp->drv_flags & HAS_LNK_CHNG)
		return;

So this INIT path runs on most RTL8139 boards.

dev_watchdog() does not refresh trans_start, and only the work itself
wakes the stopped queue, via rtl8139_tx_timeout_task(). While the queue
stays stopped, ndo_tx_timeout fires again every TX_TIMEOUT (6*HZ).

Here is one possible sequence:

dev_watchdog()->rtl8139_tx_timeout()
  INIT_DELAYED_WORK() + schedule_delayed_work()   /* instance A */

rtl8139_thread() (instance A)
  rtnl_lock();                                    /* blocks */

dev_watchdog()->rtl8139_tx_timeout()
  INIT_DELAYED_WORK()   /* work->data reset to WORK_STRUCT_NO_POOL */
  schedule_delayed_work()                         /* instance B */

rtl8139_remove_one()
  unregister_netdev()
  cancel_delayed_work_sync()
    __cancel_work_sync()->start_flush_work()
      pool = get_work_pool(work);  /* NULL, or B's pool */
  __rtl8139_cleanup_dev()
    free_netdev(dev);

rtl8139_thread() (instance A)
  /* gets RTNL */
  if (!netif_running(dev))         /* dev and tp already freed */

cancel_delayed_work_sync() finds running instances only through the pool
stored in work->data. Once the INIT has orphaned instance A, the cancel
does not wait for it. Wouldn't that leave the use-after-free this patch
is meant to close?

The same re-init looks like it can also corrupt state while the device
is running. next_tick is a file-scope static. rtl8139_thread_iter() sets
it to HZ * 60 whenever any have_thread=1 device (RTL8129 or 8139K) is in
the system. A have_thread=0 device that then hits a TX timeout would call
INIT_DELAYED_WORK() on a timer that is still armed. timer_setup() clears
the timer linkage while the old timer wheel bucket still points to it.

Likewise, if the work is queued but not yet running, INIT_LIST_HEAD() is
applied to an entry that is still linked on pool->worklist.

Would it be better to also drop the INIT_DELAYED_WORK() from
rtl8139_tx_timeout() and keep only schedule_delayed_work()? Probe already
initializes tp->thread. The INIT line was added by 83cbb4d25771, the
commit named in the Fixes: tag.

>  	__rtl8139_cleanup_dev (dev);
>  	pci_disable_device (pdev);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110042903.55991-1-mhun512%40gmail.com
