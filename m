Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411070;
	b=Lv3vKPNOYJW4M+ZSfZGJ41Ixb6rDrl7bII0XwN568p6LF1GBVae3yqEUalkFrdamCaCH
	 4UkpZyAp7WZ3GAcaCzrNINhaRO0XnZFMfYVa/ei4MXGMmoTlVbHTPKJtS7ZexNzUYG64q
	 p58Xa0WRFRXnmoir5V/GdcFLD0iJ/DK8Oo2AhFs7b6/x0+CLroINEThKPczTcE2M6cq+N
	 Dl+LWLBJa6j5oCb1sRlBov6UytdIMElWzJkB3wY+E0Xk0ZqU7T6kjf9NaMZa8qa2UGq2S
	 oPYWhuKPAyywcrQnUm42r0a/VRjWJvdDgBAxHFiJnrDo0c4Kgc4t/lFKH7SFcwZbCqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411070;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IMhTbm3P4pQBpn4x8bv/SjESH9+2ScPTvDd021i2bNg=;
	b=4Vh6NFQ4DNR6QIFm2rVPk/zBslrQHXeb9YyuQ7HlmdpL2YNNaIvHNpCY262Yt8NKTeZ9
	 dknHB/TnoCrdd6/hdKFgdoWvHLVkSh31tKegwGBLfH3eOS3LETR9B9sG2Pk9nv31ekYjI
	 Zv0gtKHRSmiQhjlcBAruVuvvssICAuinRDvz9TI28FwmHHB31d1EVnyKfEMm+g6Iw/TgD
	 aRxMaBAiE99lS2A11EKNVHzaT7C6wljtO0gaCYyJwFbr9OFKWmVDaPvA5n1ZlarMvGCmw
	 nQMTSJ7VRaJNAEs3xatYhL6wK+3SsUJ3IYvTxEc3dQe8fBlKu2+Fx6DtiRZbCwuqlmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMtyHkhT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B52606A32A;
	Mon, 23 Nov 2026 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMtyHkhT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B551F000C0;
	Mon, 23 Nov 2026 05:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411070;
	bh=IMhTbm3P4pQBpn4x8bv/SjESH9+2ScPTvDd021i2bNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fMtyHkhTeVLHcaEoeY8ndzMsYX09qfqHvS3b3kDhy1x7PWI8yEGyOqUNeqTfB+7S6
	 lu2oryNAcfmkKI6WVsFfq/9Yai6tpOB4rmqHAE4UrOomijvcT4ASPQawffYDhP73zz
	 ND1EpMpJBWHcLPlE0EAfWvw1x6VsVhN4+4Y7Bq3ji5ctpyf5Tq8BO77cUr035awrVf
	 7DHc0hL4hjLKBaYQuoFJoSASV6KT9p2G0UkM9gjLXanFsePRzn/gVUqQjQkptYbUl3
	 Z+zRR4SIT6SRsSur5uAxxc1Tzax3rIEg8pNaK6LVM32s81gh/3AGvFE8HDaKQDzb0S
	 MKyV/UBssrHEQ==
Subject:
 Re: [PATCH net v2 1/2] net: wwan: iosm: cancel the ADB timer on cleanup
From: netdev-bot+sashiko@kernel.org
To: davidlwesten@gmail.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 m.chetan.kumar@linux.intel.com, linux-kernel@vger.kernel.org,
 mail@maciej.szmigiero.name, nihaal@cse.iitm.ac.in, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 05:17:49 +0000
Message-ID: <179541106939.3135.3810191786366936844@kernel.org>
In-Reply-To: <20261119042714.505405-1-davidlwesten@gmail.com>
References: <20261119042714.505405-1-davidlwesten@gmail.com>
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

- [High] The patch adds hrtimer_cancel(&ipc_imem->adb_timer) to
  ipc_imem_cleanup() (drivers/net/wwan/iosm/iosm_ipc_imem.c:1242).

--

net: wwan: iosm: cancel the ADB timer on cleanup

This patch adds an hrtimer_cancel() for adb_timer to ipc_imem_cleanup(),
next to the cancels for the other imem hrtimers. The aim is to stop a
pending ADB timer from queueing a task that finishes the ADB on the freed
MUX, and to keep the hrtimer from being freed with the imem while it is
still enqueued.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> index 4405c85318880..20f8da53a3ea7 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> @@ -1239,6 +1239,7 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
>  	hrtimer_cancel(&ipc_imem->tdupdate_timer);
>  	hrtimer_cancel(&ipc_imem->fast_update_timer);
>  	hrtimer_cancel(&ipc_imem->startup_timer);
> +	hrtimer_cancel(&ipc_imem->adb_timer);

[Severity: High]

Does this cancel fully close the use-after-free that the commit message
describes? When it runs, the netdev TX path, the IRQ handler and the
ipc_task tasklet are all still live. Any of them can re-arm adb_timer
before ipc_mux_deinit() frees the MUX.

ipc_imem_adb_timer_start() only checks whether the timer is already
active:

void ipc_imem_adb_timer_start(struct iosm_imem *ipc_imem)
{
	if (!hrtimer_active(&ipc_imem->adb_timer)) {
		...
		hrtimer_start(&ipc_imem->adb_timer,
			      ipc_imem->hrtimer_period,
			      HRTIMER_MODE_REL);
	}
}

The netdevs stay registered until ipc_wwan_deinit(), and the TX queues
are only stopped inside ipc_mux_deinit(). So TX traffic during cleanup can
still go through this path:

ipc_mux_ul_trigger_encode()
  ipc_task_queue_send_task(ipc_mux_tq_ul_trigger_encode)
    ipc_mux_tq_ul_trigger_encode()
      ipc_mux_ul_data_encode()    /* only checks MUX_S_ACTIVE */
      ipc_imem_adb_timer_start()

The mux state stays MUX_S_ACTIVE until ipc_mux_deinit(). That means the
timer can be re-armed for 500 us at any point between this new cancel and
ipc_mux_deinit(), including during
cancel_work_sync(&ipc_imem->run_state_worker).

ipc_imem_handle_irq() also calls ipc_imem_adb_timer_start(). Its only
guard is an unsynchronized check of ipc_imem->phase at the top. The MSI
IRQs stay requested until ipc_pcie_resources_release(), which runs after
ipc_imem_cleanup() returns.

Next, ipc_mux_deinit() calls kfree(ipc_mux) and leaves ipc_imem->mux
pointing at freed memory. After that, ipc_imem_device_ipc_uninit() polls
for up to 30 ms before ipc_task_deinit() is reached:

	while ((ipc_state <= IPC_MEM_DEVICE_IPC_DONT_CARE) &&
	       (ipc_state != IPC_MEM_DEVICE_IPC_UNINIT) &&
	       (timeout > 0)) {
		usleep_range(1000, 1250);
		...
	}

Could a re-armed 500 us timer fire inside this window and run this?

ipc_imem_adb_timer_cb()
  ipc_task_queue_send_task(ipc_imem_tq_adb_timer_cb)
    ipc_imem_tq_adb_timer_cb()
      ipc_mux_ul_adb_finish(ipc_imem->mux)    /* freed MUX */

ipc_mux_ul_adb_finish() writes through the MUX with no checks. It updates
adbh->sequence_nr and adb_tx_sequence_nr, and it calls skb_put() on
ul_adb->dest_skb, among other writes.

If the timer is still pending later, its callback would use the ipc_task
that ipc_imem_cleanup() has already freed. If it is still pending when
ipc_pcie_deinit() calls kfree(ipc_pcie->imem), the hrtimer embedded in the
imem is freed while it is still enqueued.

There is also a second case. Suppose adb_timer fired just before this
cancel. hrtimer_cancel() returns once the callback has finished, but the
ipc_imem_tq_adb_timer_cb entry that the callback queued (wait=false) is
still sitting in the ipc_task queue.

Nothing flushes that queue before the MUX is freed:

- cancel_work_sync() only covers the workqueue.
- In IPC_P_OFF_REQ, ipc_imem_channel_close() skips the synchronous pipe
  close messages, so ipc_mux_deinit() doesn't flush the tasklet either.
- tasklet_kill() in ipc_task_deinit() waits for an already-scheduled
  tasklet to run instead of dropping it, and it is only reached after
  kfree(ipc_mux).

If the tasklet is delayed (BH disabled, ksoftirqd, PREEMPT_RT), can that
stale entry run ipc_mux_ul_adb_finish() on the freed MUX?

The next patch in the series, "net: wwan: iosm: fix S3 resume by
re-binding the driver around it", doesn't change ipc_imem_cleanup(). It
does run this teardown from the PM_SUSPEND_PREPARE notifier on every
non-s2idle suspend, and that happens before tasks are frozen. With that
patch, live TX traffic during teardown becomes the normal case.

Would it make sense to stop the producers (netif TX, the IRQ and the
tasklet) before ipc_mux_deinit(), and cancel adb_timer after that point or
add a second cancel there? Two other options would be to skip
ipc_imem_adb_timer_start() once teardown has begun, and to keep
ipc_imem_tq_adb_timer_cb() from using a stale ipc_imem->mux.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119042714.505405-1-davidlwesten%40gmail.com
