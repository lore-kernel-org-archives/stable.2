Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444578;
	b=VN+fDzC0j4emQYwetFpQBj4sXGh27W8EDZY1sMJc2mNCzFOlcMC5nWcFy2fmbbQm4iX+
	 kuMLgd2KXW0NYWW9wW1MnECsZU0jELr14eOzbKI9Ez1XNxI/+bBRocb0X5UMaTYMrJ1xx
	 +3E+iRvr2pKlXHUXCN3zFsBT8S8ve17TdPDIBeHJvaa4ZO8liSB8VeOwgdkcGD41k4B1j
	 vzc8jxAs/2m2bVjnAFxcesh/VvIdXJJOuRF6QtAJjILuogw/ZSVLkLI3p4e1K5NCcW/9Q
	 DGwCzN4D8o7/BbOzpwxdEUpadeBJTBrWbbEQXFLILhEvwCo5g6G/t2Hb46OxyWfyJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444578;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80nZFoSGmcvbNydOF8zzSU5LT7EhYl+54rfxvJ/b8kg=;
	b=5N7f7Uvbpv76aTvZibBi1GnildRhW2rDr8g3Xf2WUCVusjouOkWwXac3PDY+yiWI306n
	 KNWtulKbhchl/IpwMpg4UfsiHx1z6RWTV6ondKFrmavqgV2EVeU2tlIWS6mHFms0IF9pH
	 qhwDTq3HM6YYUJXPbKUfLCe/c+pmiHJUQN62c36zl2UhAaKuNIIYmhPdIkB+oj9fvK1De
	 iSkXwLTjXBOm4TAgaIKuf72CbFRHq9QlJRqm38c5gKpfkkNDOFMfKnLzMQhX6hGqihLWG
	 AXafE1UKnx0G3s48udWW6tBsT79zdR/Da8hln8Thv76zGnOAZNgkGTuT9dgEQ+ec+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZPRKRgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018C606A326;
	Thu, 12 Nov 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZPRKRgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8FF1F00A05;
	Thu, 12 Nov 2026 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444577;
	bh=80nZFoSGmcvbNydOF8zzSU5LT7EhYl+54rfxvJ/b8kg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VZPRKRgvbteSwEFiiS4MMTuM++LNNdsJqSUP3FcxAoYKJgC6LwgQsIb/P2PKUgPmY
	 VeIwFLkhyIaF324pvwc0SZ5bak90vqZcPIlS8vUfKdMdn3ZpG7I+u+bUaCPB9ceeWs
	 j45BASbU/HcEvnpTMZHb1LTmQOYqsjjXRJGDeuDYT3BQAd214Y+hdWGCbNVOzPw6XW
	 unCJyycCudsWEnpqnvYFym2XaFVJmO3YN8vQDwGVV9O6WLQtviwpZR2AWc7Xxvgn5S
	 YzRav3DJmdrFFZknMvE04PeBLz2cXDKf5joh04RIo6+XdoGn1WLdsc+u50AaBvnNgE
	 CLDfltMEG19/w==
Subject: Re: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to avoid
 use-after-free
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 m.chetan.kumar@linux.intel.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 00:49:36 +0000
Message-ID: <179444457649.2199510.13745468904357221221@kernel.org>
In-Reply-To: <20261109124933.1603575-1-hj351016@gmail.com>
References: <20261109124933.1603575-1-hj351016@gmail.com>
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

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the use-after-free it targets, because
  adb_timer can be armed again after the new hrtimer_cancel().
- [High] hrtimer_cancel(&ipc_imem->adb_timer) in ipc_imem_cleanup() waits
  only for ipc_imem_adb_timer_cb() itself.
- [Medium] The new hrtimer_cancel(&adb_timer) removes the only path that
  finishes an in-progress uplink ADB during teardown, so the DMA-mapped…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but tdupdate_timer
  (and td_alloc_timer) can also be re-armed after cancel.

--

net: wwan: iosm: cancel adb_timer on cleanup to avoid use-after-free

This commit adds an hrtimer_cancel() for adb_timer in ipc_imem_cleanup().
The other four ipc_imem hrtimers were already cancelled there. The goal is
to stop adb_timer from firing after ipc_imem has been freed.

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

Can adb_timer be armed again after this hrtimer_cancel()?

ipc_imem_cleanup() sets ipc_imem->phase = IPC_P_OFF_REQ without a lock.
The ipc_task tasklet keeps running until tasklet_kill() in
ipc_task_deinit(), which comes much later in the function.
ipc_imem_adb_timer_start() has no teardown gate:

drivers/net/wwan/iosm/iosm_ipc_imem.c:ipc_imem_adb_timer_start() {
	if (!hrtimer_active(&ipc_imem->adb_timer)) {
		...
		hrtimer_start(&ipc_imem->adb_timer,
			      ipc_imem->hrtimer_period,
			      HRTIMER_MODE_REL);
	}
}

Two callers run in tasklet context. The first is
ipc_mux_tq_ul_trigger_encode(), which has no phase check at all:

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:ipc_mux_tq_ul_trigger_encode() {
	...
	ul_data_pend = ipc_mux_ul_data_encode(ipc_mux);
	if (ul_data_pend) {
		if (ipc_mux->protocol == MUX_AGGREGATION)
			ipc_imem_adb_timer_start(ipc_mux->imem);
	...
}

A TX can pass the phase != IPC_P_RUN check in
ipc_imem_sys_wwan_transmit() before cleanup changes the phase. That TX
still queues this task, and the task can run after the cancel.

The second is ipc_imem_handle_irq(). It only checks IPC_P_OFF_REQ on
entry, so a run already past that check on another CPU can reach this
after the cancel:

	if (ipc_mux_ul_data_encode(ipc_imem->mux)) {
		ipc_imem_td_update_timer_start(ipc_imem);
		if (ipc_imem->mux->protocol == MUX_AGGREGATION)
			ipc_imem_adb_timer_start(ipc_imem);
	}

The re-armed timer fires 500us later
(IOSM_AGGR_MUX_ADB_FINISH_TIMEOUT_NSEC):

ipc_imem_adb_timer_cb()
  ipc_task_queue_send_task()
    ipc_task_queue_add_task()
      reads ipc_imem->ipc_task, takes q_lock, writes args[]
      tasklet_schedule()

Would this touch freed memory if ipc_task_deinit() and
kfree(ipc_imem->ipc_task) have already run, or if ipc_pcie_deinit() has
freed ipc_imem?

If the timer fires after ipc_mux_deinit() instead, the queued
ipc_imem_tq_adb_timer_cb() would run ipc_mux_ul_adb_finish() on the
freed mux.

The code that re-arms the timer is still live at this point. Would
teardown first need to stop TX and the tasklet, or add a synchronized
gate in ipc_imem_adb_timer_start()? Only after that would it cancel the
timer and free the mux and ipc_task.

[Severity: High]

Does anything drain the ipc_task tasklet between this cancel and
ipc_mux_deinit()?

hrtimer_cancel() only waits for ipc_imem_adb_timer_cb() itself. That
callback just queues this onto the tasklet:

static int ipc_imem_tq_adb_timer_cb(struct iosm_imem *ipc_imem, int arg,
				    void *msg, size_t size)
{
	ipc_mux_ul_adb_finish(ipc_imem->mux);
	return 0;
}

If adb_timer fired just before cleanup reached the cancel, this task can
still be pending. It may be deferred to ksoftirqd or running on another
CPU.

The phase is IPC_P_OFF_REQ at this point, so ipc_imem_channel_close()
skips the pipe close calls:

	if (ipc_imem->phase == IPC_P_RUN) {
		ipc_imem_pipe_close(ipc_imem, &channel->ul_pipe);
		ipc_imem_pipe_close(ipc_imem, &channel->dl_pipe);
	}

Those calls do synchronous message round-trips through the tasklet,
which would otherwise flush earlier entries.

ipc_mux_deinit() then frees pp_qlt[] and kfree()s the mux without
clearing ipc_imem->mux. tasklet_kill() in ipc_task_deinit() runs later
and waits for pending entries, so they would run after the free.

Can ipc_mux_ul_adb_finish() then run on the freed struct iosm_mux, its
ul_adb state and channel->ul_list? Would the tasklet need to be drained or
killed before the mux is freed?

[Severity: High]

This isn't a bug introduced by this patch, but tdupdate_timer and
td_alloc_timer seem to have the same re-arm problem.

Both are also cancelled at the top of ipc_imem_cleanup(), before the
tasklet is killed. Several paths re-arm them after that:

  - ipc_mux_tq_ul_trigger_encode() calls ipc_imem_td_update_timer_start()
    right after the adb_timer start.
  - ipc_imem_handle_irq() restarts tdupdate_timer and td_alloc_timer
    after its entry-only phase check.
  - ipc_mux_ul_adb_finish() also calls ipc_imem_td_update_timer_start().

ipc_imem_td_update_timer_start() only checks enter_runtime,
td_update_timer_suspended and hrtimer_active() before calling
hrtimer_start(). Its callback then does this:

ipc_imem_td_update_timer_cb()
  container_of(hr_timer, struct iosm_imem, tdupdate_timer)
  ipc_task_queue_send_task()

Suppose the re-armed timer fires 1.9ms later
(TD_UPDATE_DEFAULT_TIMEOUT_USEC), after kfree(ipc_task) or after
ipc_pcie_deinit() has freed ipc_imem. Isn't that the same use-after-free?

Should a teardown reordering for adb_timer cover these timers too?

[Severity: Medium]

Does this cancel leak the unfinished uplink ADB held in ul_adb.dest_skb?

With MUX_AGGREGATION, mux_ul_adb_encode() returns 1 while the ADB is still
open. The DMA-mapped buffer taken from free_list is held here:

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:ipc_mux_ul_skb_alloc() {
	...
	case IOSM_AGGR_MUX_SIG_ADBH:
		/* Save the ADB memory settings. */
		ul_adb->dest_skb = skb;
	...
}

That same return value is what arms adb_timer. So if adb_timer is pending
at teardown, an unfinished dest_skb exists.

Before this patch, the timer would normally fire first.
ipc_mux_ul_adb_finish() would then move dest_skb to channel->ul_list, and
pipe cleanup would free it.

With the timer cancelled, nothing finishes the ADB, and ipc_mux_deinit()
only drains free_list:

	/* Empty the ADB free list. */
	free_list = &ipc_mux->ul_adb.free_list;

	/* Remove from the head of the downlink queue. */
	while ((skb = skb_dequeue(free_list)))
		ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
	...
	kfree(ipc_mux);

Would the 16 KiB skb and its DMA_TO_DEVICE mapping leak on every such
teardown? Should ipc_mux_deinit() release ul_adb.dest_skb with
ipc_pcie_kfree_skb() when it is non-NULL?

>  
>  	/* cancel the workqueue */
>  	cancel_work_sync(&ipc_imem->run_state_worker);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109124933.1603575-1-hj351016%40gmail.com
