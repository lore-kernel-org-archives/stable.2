Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766303;
	b=Msis5BuOzT7ERiEANafKm1ZRh+KUw1kC+oVjUWsIdNQi4TaT46nClY54Ixmdptjse128
	 osZwsaBST/V/2QoQ6kl1zVOoIpIGc9mtuVcEKlmoMLsytTgjXnVyeJIpDBJYfqTyzsuJd
	 WTlbWAts+4THp682CFnpSO4VCkG55LK4VKKuD62mPcZ3nzZFZxp779uStpAqVkdOp+S2f
	 fqVqDL8Tz6lQB/0DaEtsRK08yfF4MzKAcINh3Yg3UfILeHqupmFcvPenF+f197kbzyEXF
	 RHQOT65Qg7pdT28djdLbRQGDDaS/EIkFDY7UZhMsALj21fg01wyMB3yK7HozxscTIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766303;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3kIbbvq4oEUfY3dgfSEIA3/ZBP5pOxOu66/z5h7qT8U=;
	b=1I0NaXJeyMUQ3z+Z5vZKuEF/qJyW0/LCJUP7HN7sZLFZ6o1JPLCwL7PhKG4sWunBH3WX
	 w6QRYF5uK/qgjtJmaec5+8Km3FAyze30q0Y14kPXj1GhuHGLvEuQ3TpcZkSt2oLPxjajY
	 k/FRkAOwZPfNO0FjQRvUl3PFV0kAlgegYydKAnybZnTGy3YyXuqM5bx+4a6anKi20OCCE
	 v7C7oBubIg8gUOoQS/lr2PFISNxN+yeQEeyCbBwoCjjwCyEJ0PBuC4RTrk5vkkaA4Rs6W
	 WGn+qZ6HVL9ucj68nxdoCe+WYPq9oY0WsUhdHlGM+huIbR4I1qSl7jsWF5DDwLVuvcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CobDbpFr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B25606A31B;
	Wed,  4 Nov 2026 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CobDbpFr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0A51F000C1;
	Wed,  4 Nov 2026 04:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766302;
	bh=3kIbbvq4oEUfY3dgfSEIA3/ZBP5pOxOu66/z5h7qT8U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CobDbpFrG0Wr7ZWibQnGGC147+/RWqzOkTpry+iJvxWPztwg39c97q9iyGT9E63Tm
	 dE3kmceg8/otMmg0ZCEZWzAKBXaJT7Q6FHK8qCK3fGKAXdWlGzRJGf5ngHGHD8MCwy
	 Sek02imjwGOPZsHAuTH51+lVFaDmRnPRgnGRuZPiKGFYe17XdAlMNQ00PtK6hc8IvG
	 JBJDyv14BSvZdnLLmEtORl+5tiN8TjpqHVYaxLwm5MgALzY/oF12RdWMYJd0ZnY9Mz
	 TF4iOum2sPfICSFjXRSnl5q4Uz/JIl/YqlxK+xaczQN9COdauMHWFdI77rSqMYwrfN
	 d7rxWsK4prNsg==
Subject: Re: [PATCH net v2] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
From: netdev-bot+sashiko@kernel.org
To: bcochrane@google.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 joe@dama.to, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 04:25:00 +0000
Message-ID: <179376630095.488856.6614017924619723779@kernel.org>
In-Reply-To: <20261103042210.2984373-1-bcochrane@google.com>
References: <20261103042210.2984373-1-bcochrane@google.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] New deadlock in bnxt_fw_reset().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same Fixes
  commit (004b5008016a) left another netif_close()-without-RTNL site…
- [High] This problem wasn't introduced by this patch, but the same
  netif_close()-without-RTNL bug is still reachable through the TPH…
- [Medium] This problem wasn't introduced by this patch, but the
  bnxt_get_registered_vfs() failure path in bnxt_fw_reset() leaves the…

--

bnxt_en: Take RTNL before netif_close() when aborting FW reset

This patch takes RTNL before the netdev instance lock on the FW reset
abort paths in bnxt_fw_reset_task(). It does the same on the
bnxt_get_registered_vfs() failure path in bnxt_fw_reset(), so that
netif_close() runs with RTNL held. The goal is to fix the ASSERT_RTNL()
warnings introduced by commit 004b5008016a ("eth: bnxt: remove most
dependencies on RTNL").

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 33c4cacc8ffe3..1ea1e8266eabf 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14860,9 +14860,16 @@ void bnxt_fw_reset(struct bnxt *bp)
>  		if (n < 0) {
>  			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
>  				   n);
> +			/* netif_close() requires RTNL, which must be taken
> +			 * before the netdev instance lock.
> +			 */
> +			netdev_unlock(bp->dev);
> +			rtnl_lock();
> +			netdev_lock(bp->dev);

[Severity: High]
Can a concurrent devlink health recover hang the sp_task here while it
holds RTNL?

bnxt_sp_task() is not the only caller of bnxt_fw_reset(). When
devlink_health_report() returns -ECANCELED,
bnxt_devlink_health_fw_report() calls __bnxt_fw_recover() from the sp_task
without the devlink lock.

At that point the reporter is already in the error state. A userspace
"devlink health recover" can then reach bnxt_fw_reset() through
bnxt_fw_recover() at the same time.

Before this patch the instance lock was held all the way through
netif_close(). The new unlock/relock window seems to allow this ordering:

CPU1 (bnxt_sp_task)
bnxt_devlink_health_fw_report()
  __bnxt_fw_recover()
    bnxt_fw_reset()
      bnxt_lock_sp()          /* clears IN_SP_TASK */
      set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
      bnxt_get_registered_vfs() returns < 0
      netdev_unlock(bp->dev);

CPU2 (devlink health recover)
devlink_health_reporter_recover()
  bnxt_fw_recover()
    __bnxt_fw_recover()
      bnxt_fw_reset()
        bnxt_lock_sp()        /* now gets the instance lock */
        IN_FW_RESET is set, nothing to do
        bnxt_unlock_sp()
          set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
          netdev_unlock(bp->dev);

CPU1
      rtnl_lock();
      netdev_lock(bp->dev);
      netif_close(bp->dev)
        bnxt_close()->bnxt_close_nic()->__bnxt_close_nic()
          while (bnxt_drv_busy(bp))
              msleep(20);

bnxt_drv_busy() tests BNXT_STATE_IN_SP_TASK. Normally only the sp_task
clears that bit, and the sp_task is the thread stuck in this loop.

Would this spin forever with rtnl_mutex and the instance lock held?

CPU2 can wait on netdev_lock for the whole time the func_qcfg HWRM call is
timing out, so the window may be wide.

The commit message says:

    BNXT_STATE_IN_FW_RESET stays set across the lock switch, so a
    concurrent close marks the reset aborted as it does today and a
    concurrent recovery request backs off.

The back-off path goes through bnxt_unlock_sp(). Isn't that the code that
sets the bit causing the hang?

It is older behavior that bnxt_unlock_sp() and bnxt_rtnl_unlock_sp() set
IN_SP_TASK no matter who the caller is. The comment in bnxt_lock_sp()
assumes the caller is always bnxt_sp_task(). The new window is what makes
the problem reachable.

>  			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
>  			netif_close(bp->dev);
> -			goto fw_reset_exit;
> +			bnxt_rtnl_unlock_sp(bp);
> +			return;

[Severity: Medium]
This is a pre-existing issue, but this path returns without calling
bnxt_ulp_start(). Nothing undoes the bnxt_ulp_stop() at the top of
bnxt_fw_reset(). Does this leave the RoCE/aux driver suspended after the
abort?

The old goto fw_reset_exit had the same problem. Neither bnxt_close() nor
a later bnxt_open() resumes the ULP.

bnxt_hwrm_if_change() only queues BNXT_RESTART_ULP_SP_EVENT when
BNXT_STATE_FW_RESET_DET is set. That won't happen if the func_qcfg failure
was transient.

The matching abort for the POLL_VF state in bnxt_fw_reset_task() reaches
ulp_start with rc == 0, so it does restart the ULP:

ulp_start:
	if (!rc)
		bnxt_ulp_start(bp);

Since this path is being rewritten anyway, could the ULP be restarted here
too?

>  		} else if (n > 0) {
>  			u16 vf_tmo_dsecs = n * 10;
>  

[ ... ]

> @@ -15682,9 +15688,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  		netdev_err(bp->dev, "fw_health_status 0x%x\n", sts);
>  	}
>  fw_reset_abort:
> +	rtnl_lock();
>  	netdev_lock(bp->dev);
>  	bnxt_fw_reset_abort(bp, rc);
>  	netdev_unlock(bp->dev);
> +	rtnl_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but commit 004b5008016a seems
to have left one more netif_close() call without RTNL that this patch does
not cover. bnxt_vf_reps_destroy() holds only the instance lock:

drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c:bnxt_vf_reps_destroy() {
    ...
	netdev_lock(bp->dev);
	if (netif_running(bp->dev)) {
		bnxt_close_nic(bp, false, false);
		closed = true;
	}
    ...
		bp->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
		bnxt_open_nic(bp, false, false);
    ...
}

bnxt_open_nic() calls netif_close() on any failure. That includes the
immediate -EIO when BNXT_STATE_ABORT_ERR is set:

	if (rc) {
		netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
		netif_close(bp->dev);
	}

There are two callers, and both hold only the devlink instance lock:

- bnxt_dl_eswitch_mode_set() for DEVLINK_ESWITCH_MODE_LEGACY
- __bnxt_sriov_disable()

Wouldn't this hit the same ASSERT_RTNL() in __dev_close_many()? Wouldn't
it also run the NETDEV_GOING_DOWN/NETDEV_DOWN notifiers without RTNL?

If this patch is backported to stable on its own, this site from the same
Fixes commit would still be there.

[Severity: High]
This is also a pre-existing issue, but the same netif_close() without RTNL
looks reachable through the TPH queue restart path. bnxt_tph_update()
runs from bnxt_sp_task() under bnxt_lock_sp(), which takes only the
instance lock:

bnxt_sp_task()
  bnxt_tph_update()
    bnxt_lock_sp()
    netdev_rx_queue_restart()
      netdev_rx_queue_reconfig()   /* only asserts the instance lock */
        bnxt_queue_start()

bnxt_queue_start() closes the device on its error path. This happens if
any of these fail: bnxt_hwrm_rx_ring_alloc(),
bnxt_hwrm_cp_ring_alloc_p5(), bnxt_hwrm_rx_agg_ring_alloc() or
bnxt_tx_queue_start().

err_reset:
	netdev_err(bp->dev, "Unexpected HWRM error during queue start rc: %d\n",
		   rc);
	napi_enable_locked(&bnapi->napi);
	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
	netif_close(dev);

Can this trigger the same ASSERT_RTNL() warnings when the HWRM calls fail
on unhealthy firmware?

>  ulp_start:
>  	if (!rc)
>  		bnxt_ulp_start(bp);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103042210.2984373-1-bcochrane%40google.com
