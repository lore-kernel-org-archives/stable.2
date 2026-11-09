Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266482;
	b=NapY5EUi9s/TKobS8xYKO33s+BUYO4QT2rI7EZo/cpdO16et2cgxbhZZ+fa+3e7LFpiG
	 d4zK5DLp33uxQ7VBrYYGe9CZUYxo6AAc4E+BFTiThGXcMU80ZsiAZ9trG0oejOvDFEamT
	 zau3aBQhb4+OYWV2zLE+r3ArnwcLh0eRLFmaK3RR2xQIQk0gCwbOCYTggl/uYeo91mlC+
	 6u7DTiIHYgek5LF/qaD13BYd+goZiQkC3eqzxaG34FLCNwHcD6bJMw0/HRP3SioPgfXHB
	 acQa7ZwmyaA+jV4/u+MOyTDQL8yWP87Wo8LRK28slsSSN7F38y3yCpIssXz7YGaoZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266482;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hb+r5PTM78MTObPjvxt0/B2UrpR5paDj5OZz51x+52c=;
	b=GUL8pHkB8MBZiE6+Kc4XggBcOcYcxLbzAoxYlOFtGZhFqO33JtffLYUoqA2G7SXyFQPg
	 qFYJCYL7iYPGnj6dWqK15wXsmhT9z5mCWJ0jjkaueazZPk56vZqfMSHdGrUXKe6soIOpT
	 s7O5Vmg/cEImoeB63zwCQEhdS6hw1KAmSF6chp2upKwVrxjUbhyBCuVdpc294sYa2zPX9
	 BgV9IrfovndktKDLXCrTq89zJ3zaVRq4smwv5vR0RbX6xRxGamMMmrMZDAAVDBvKYU8L2
	 TXjpkFpz2U97U69ExZoClXxsgS5VBFZwZRsYA+ItV2mbU0BGZYtUKYXMb3atgjQ8xEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EVk/rwEK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAB606A31C;
	Mon,  9 Nov 2026 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVk/rwEK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6331F0089F;
	Mon,  9 Nov 2026 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266481;
	bh=hb+r5PTM78MTObPjvxt0/B2UrpR5paDj5OZz51x+52c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EVk/rwEK4BSaFClHAktR+NVTn1+E6s+eRzOV6GFJ9jw/M5t7MGOgQurJT1s6HYTXh
	 qa7ZigjYTK3vxq50izCJ7gaDzBH7JRQlCEqDEutrwv6zkh1eOdpIjru52/OZD48Q/d
	 aL1YEk2sFM1NGRURUzJaa/usRbwGzuke1oiYwjZQkNnymgb3V5DYLwfP92XCr0ZvDd
	 r23meNBcNJ0+zqRa4JAEqfIPyWi+dUnC6Vae79ySA0MHDjVGCaMf4L/BS8omYnH4yE
	 dL9EHBYxOkINRS1PKC4akKdKgD7KADpcoQn48TUBRsDACusXHdwLxhfn82yaMZ4nKr
	 XmHp0Bp6RFKfw==
Subject: Re: [PATCH net v4] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
From: netdev-bot+sashiko@kernel.org
To: bcochrane@google.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 joe@dama.to, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 09 Nov 2026 23:21:20 +0000
Message-ID: <179426648001.994134.4996838291599710549@kernel.org>
In-Reply-To: <20261108222942.1233295-1-bcochrane@google.com>
References: <20261108222942.1233295-1-bcochrane@google.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a bnxt_in_sp_task() guard to
  bnxt_lock_sp()/bnxt_rtnl_lock_sp().
- [Medium] bnxt_en: transient BNXT_STATE_IN_FW_RESET exposed in
  bnxt_fw_reset() unlock window
- [Low] The commit message understates what the bnxt_in_sp_task() guard
  fixes, and the Fixes: tag scope does not match it.

--

bnxt_en: Take RTNL before netif_close() when aborting FW reset

This patch takes RTNL before netif_close() in two places: the firmware
reset abort paths of bnxt_fw_reset_task(), and the
bnxt_get_registered_vfs() error path of bnxt_fw_reset(). It also adds a
current_work() == &bp->sp_task check around the BNXT_STATE_IN_SP_TASK
updates in bnxt_[rtnl_]lock_sp() and bnxt_[rtnl_]unlock_sp(), so callers
running in devlink context leave the bit alone.

> Because bnxt_fw_reset() and bnxt_fw_exception() can also be entered
> from devlink process context via bnxt_fw_recover(), guard the
> BNXT_STATE_IN_SP_TASK bit manipulation in bnxt_[rtnl_]lock_sp() and
> bnxt_[rtnl_]unlock_sp() with current_work() == &bp->sp_task. Otherwise
> a concurrent devlink health recover backing off during the unlock
> window would set BNXT_STATE_IN_SP_TASK with no sp_task running to clear
> it, causing the subsequent __bnxt_close_nic() busy-wait to hang.

[Severity: Low]
Does this paragraph describe everything the guard fixes? Before this
patch, every devlink health recover went through:

bnxt_fw_recover()->__bnxt_fw_recover()->bnxt_fw_reset()->bnxt_unlock_sp()

bnxt_unlock_sp() did an unconditional set_bit(BNXT_STATE_IN_SP_TASK),
and no sp_task was left to clear it. No unlock window was needed for
this.

If the reset was then aborted, the following chain would spin forever
in the bnxt_drv_busy() loop:

bnxt_fw_reset_abort()->netif_close()->bnxt_close()->__bnxt_close_nic()

Before 004b5008016a, bnxt_rtnl_lock_sp() and bnxt_rtnl_unlock_sp()
already did the same unconditional clear_bit()/set_bit(). So this hang
looks older than the commit named in the Fixes: tag.

Could this part be described separately, or split out with its own
Fixes: tag so that older stable trees get it too?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 33c4cacc8ffe3..7a2b96f564647 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14575,35 +14575,44 @@ static void bnxt_timer(struct timer_list *t)
>  	mod_timer(&bp->timer, jiffies + bp->current_interval);
>  }
>  
> +static bool bnxt_in_sp_task(struct bnxt *bp)
> +{
> +	return current_work() == &bp->sp_task;
> +}
> +
>  static void bnxt_lock_sp(struct bnxt *bp)
>  {
> -	/* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TASK
> -	 * set.  If the device is being closed, bnxt_close() may be holding
> +	/* If we are called from bnxt_sp_task, BNXT_STATE_IN_SP_TASK is set.
> +	 * If the device is being closed, bnxt_close() may be holding
>  	 * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to clear.
>  	 * So we must clear BNXT_STATE_IN_SP_TASK before holding netdev
>  	 * instance lock.
>  	 */
> -	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
> +	if (bnxt_in_sp_task(bp))
> +		clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
>  	netdev_lock(bp->dev);
>  }

[Severity: High]
Can this guard cause a deadlock between devl_lock and the
BNXT_STATE_IN_SP_TASK busy-wait in __bnxt_close_nic()?

Before this patch, a devlink-initiated recover always cleared
BNXT_STATE_IN_SP_TASK in bnxt_lock_sp(), so it never waited on a running
sp_task. With the guard, a caller in devlink process context leaves the
bit set and does wait for a concurrent sp_task. The same applies to
bnxt_rtnl_lock_sp().

Thread A runs devlink health recover. The HEALTH_REPORTER_RECOVER doit
already holds devl_lock:

devlink_health_reporter_recover()
  bnxt_fw_recover()
    __bnxt_fw_recover()
      bnxt_fw_reset() or bnxt_fw_exception()
        bnxt_lock_sp()        <- BNXT_STATE_IN_SP_TASK left alone
        ...
        __bnxt_close_nic()
            clear_bit(BNXT_STATE_OPEN, &bp->state);
            smp_mb__after_atomic();
            while (bnxt_drv_busy(bp))
                msleep(20);

Thread A reaches __bnxt_close_nic() through bnxt_force_fw_reset() or
bnxt_fw_reset() -> bnxt_fw_reset_close(). It can also get there through
the new n < 0 path in bnxt_fw_reset():
bnxt_rtnl_lock_sp() -> netif_close() -> bnxt_close().

Thread B is bnxt_sp_task on the same bp. It set BNXT_STATE_IN_SP_TASK
and passed the BNXT_STATE_OPEN check before thread A cleared
BNXT_STATE_OPEN:

bnxt_sp_task()
    if (test_and_clear_bit(BNXT_FW_EXCEPTION_SP_EVENT, &bp->sp_event)) {
        if (!is_bnxt_fw_ok(bp))
            bnxt_devlink_health_fw_report(bp);
    }

bnxt_devlink_health_fw_report()->devlink_health_report()
    if (reporter->auto_dump) {
        devl_lock(devlink);   <- blocks, thread A holds it

While the heartbeat is stale, bnxt_timer() -> bnxt_fw_health_check()
queues BNXT_FW_EXCEPTION_SP_EVENT on every tick.
BNXT_FW_RESET_NOTIFY_SP_EVENT can reach the same report call.

auto_dump defaults to true for bnxt because it provides .dump. If the fw
reporter has auto_recover=false, devlink_health_report() goes on to the
auto_dump devl_lock() and blocks there.

Thread A waits for thread B to clear BNXT_STATE_IN_SP_TASK, and thread B
waits for thread A to drop devl_lock. Wouldn't devl_lock and the netdev
instance lock then stay held forever? On the new
bnxt_get_registered_vfs() error path in bnxt_fw_reset(), RTNL would be
stuck as well.

The window looks fairly wide. bnxt_ulp_stop() and the netdev_lock()
acquisition both run between thread A taking devl_lock and thread A
clearing BNXT_STATE_OPEN.

[ ... ]

> @@ -14860,9 +14869,12 @@ void bnxt_fw_reset(struct bnxt *bp)
>  		if (n < 0) {
>  			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
>  				   n);
> +			netdev_unlock(bp->dev);
> +			bnxt_rtnl_lock_sp(bp);
>  			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
>  			netif_close(bp->dev);
> -			goto fw_reset_exit;
> +			bnxt_rtnl_unlock_sp(bp);
> +			return;
>  		} else if (n > 0) {
>  			u16 vf_tmo_dsecs = n * 10;
>  

[Severity: Medium]
Does dropping the instance lock here expose a stale
BNXT_STATE_IN_FW_RESET to other threads?

By this point bnxt_fw_reset() has already decided to abort. But
BNXT_STATE_IN_FW_RESET is still set, and no fw_reset_task has been
queued for this reset.

Between netdev_unlock(bp->dev) and the netdev_lock() inside
bnxt_rtnl_lock_sp(), any waiter on the instance lock can get in and act
on that bit. A waiter that already holds RTNL is guaranteed to win,
because bnxt_rtnl_lock_sp() has to take RTNL first.

Several users of the bit look affected.

bnxt_close_nic() called by an RTNL holder, for example an ethtool
reconfiguration or bnxt_close():

    if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
        netdev_warn(bp->dev, "FW reset in progress during close, ...");
        set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
    }

Normally the POLL_VF state of bnxt_fw_reset_task() consumes
BNXT_STATE_ABORT_ERR, but no fw_reset_task will run for this reset.
The bit is left set even though bnxt_fw_reset_close() never ran. A
reconfiguration path that closes and then reopens would then see
bnxt_open_nic() fail with -EIO.

bnxt_fw_exception() -> bnxt_force_fw_reset() from another context:

    if (!test_bit(BNXT_STATE_OPEN, &bp->state) ||
        test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
        return;

A fatal reset requested inside the window is silently skipped.

bnxt_io_error_detected():

    if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
        netdev_err(bp->dev, "Firmware reset already in progress\n");
        abort = true;
    }

This returns PCI_ERS_RESULT_DISCONNECT. A PCIe error is a plausible
reason for bnxt_hwrm_func_qcfg() to fail inside
bnxt_get_registered_vfs() in the first place, so this race does not
look far-fetched.

Clearing BNXT_STATE_IN_FW_RESET before netdev_unlock() would close
this window. However, it would also let a new reset start before
netif_close() runs.

Would it be acceptable to take RTNL up front in bnxt_fw_reset() when
bp->pf.active_vfs is non-zero, so the instance lock never has to be
dropped? VFs, and PFs without active VFs, never reach this path, so
the RTNL contention concern from v2 should not apply to them.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108222942.1233295-1-bcochrane%40google.com
