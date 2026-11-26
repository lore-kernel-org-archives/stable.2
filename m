Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736415;
	b=1UX9AZcrXhCRZwU1mJv8qWWhF+yb/y/d5v6Tf8eUrWpuxAmJQw998FaH5/R9dg3GtnsU
	 ndWMIT+5LvlC+73UlRdluv0MY7GzEAFEGPRtcGJViVbeE6QbCl4+QT9oH0oyQZFEJOfGC
	 +GH1XlRvv4lsCyolHwoSHyrQqfwKkWs9pEa1QD68egbd6nt7QU//3c2xkqAm5nSMOEprk
	 B6bDxAds9tzAj6FK3AImFlKPb+ENUOkR7GjHeitqxYdV7dmK8lkNVmir+OftgbIzAi2+J
	 9zhDXTiQYnBc06wFbybgk4rzeteOu+F/5+r1ZG7MMLClq2HV+yoCNDnWTP6+SPxOKBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736415;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XD91xl1FtojR7aO41dAkbHISOANHgfKEd+NNW6AKExs=;
	b=WyfMB6pXXgSRBMbhDhaoU7FxduGdm78q6FlyuJpNIlnYg1meX6nvukYXWevPXoeNracO
	 PsGdUEznxm8utqAUakcN+RgIeoQN3bJIvp49jpNBU7gjb9osW2BsoQB83xpC9wfLTWyc9
	 52Yi28kRERa53RMYB92JK/dykEaPKx153q1J7SwQ8wHNyOVgOtRtq5mkCyCm95ER+VBRO
	 lz1e02tiNRyMniS6O8zcTnjR72VqTqyme8o+ciW8OpUjP0gYp+8KE5+C+dSWdLtV6W3UF
	 zthZGEBrDXPQZgPq0V6hS0w/oKjca9WPhGGhZpXgokVqiVjh31UciLUBSVUDwRJUqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgKL8oR+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6B606A32E;
	Thu, 26 Nov 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgKL8oR+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86201F00896;
	Thu, 26 Nov 2026 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795736414;
	bh=XD91xl1FtojR7aO41dAkbHISOANHgfKEd+NNW6AKExs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CgKL8oR+gLBmeKx1m4QMCZy9WEZ0ZxRKsQl++WAK0KgAqFbkdLx/kJKZp4RM0Tk0d
	 moYZFJsgLhCbEUk90Q+B91o7tJju4aMQvmvSIRI1M7ru1NLlZ9YhYuKc3Xg757XFf4
	 nKViiqa9sF/6HRH/NoBP6p7Ck6M/1iSoum6zDWXQLao7mfQDX1RsBu+nS0HUpWnMpi
	 jTeDVqZ6HrAj4v2nj6knDKwv7cngPMqLukGgq/zHI4cZ0jbtSXl9tx2wfEevWJOWPk
	 vF9S35KZhX+4CtuuHIH2HSXQc+EMaW/tMjQeO5t9jW8w7H+WtKkuK3UZt0uOcuFeUO
	 W5vUNi67MmsOw==
Subject: Re: [PATCH net 4/6] idpf: keep the mailbox up while tearing down
 vports on shutdown
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, willemb@google.com,
 netdev@vger.kernel.org, tianxun.ng@bytedance.com, oss.patchbox@gmail.com,
 emil.s.tantilov@intel.com, richardcochran@gmail.com, milena.olech@intel.com,
 konstantin.ilichev@intel.com, stable@vger.kernel.org, Samuel.salin@intel.com
Date: Thu, 26 Nov 2026 23:40:13 +0000
Message-ID: <179573641346.3135.10145335142730257135@kernel.org>
In-Reply-To: <20261125225145.4126333-5-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-5-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix still misses its target when the control plane is slow
  but alive.
- [Medium] During shutdown, idpf_wait_for_marker_event_set() computes
  wait_all as false, because vc_xn_timeout_ms is 500 or 0, below…
- [Medium] The 500 ms cap and the sticky zero apply to the whole adapter,
  but idpf_shutdown() shortens the timeout before every other mailbox…
- [Medium] The shutdown path can now free the mailbox rings while a
  control-plane reply is still pending, and the mailbox queues stay…
- [Low] The new kernel-doc for idpf_send_mb_msg() in
  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c says -ETIMEDOUT is…
- [Low] The struct idpf_adapter kernel-doc for @vc_xn_timeout_ms
  (drivers/net/ethernet/intel/idpf/idpf.h) says the field is "set to 0…

--

idpf: keep the mailbox up while tearing down vports on shutdown

This patch sets IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(). The
vports are then torn down while the virtchnl transaction manager is still
up, so the device is told to disable and destroy them before reboot. Each
teardown transaction is capped at 500 ms through a new
adapter->vc_xn_timeout_ms, later synchronous sends fail at once after a
capped one times out, and after one SW marker is missed the remaining
marker waits of that vport are skipped.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index f214023095ee7..533b069d97f94 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

[ ... ]

> @@ -635,6 +635,8 @@ struct idpf_edt_caps_ilog2 {
>   * @asq: Send control queue info
>   * @arq: Receive control queue info
>   * @xnm: Xn transaction manager
> + * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
> + *		      on shutdown and set to 0 once a shortened one timed out

[Severity: Low]
This isn't a bug, but is this description accurate for async transactions?

The only code that writes 0 is in idpf_send_mb_msg(), and it runs only
when the synchronous libie_ctlq_xn_send() returns -ETIMEDOUT.

Async transactions with resp_cb set also get the shortened cap through
min_t(). Examples are the MAC filter, promiscuous and PTP Tx timestamp
async handlers. For those, libie_ctlq_xn_send() returns 0 right after
posting. Their timeout is reported later through resp_cb, which never
touches vc_xn_timeout_ms.

The idpf_send_mb_msg() kernel-doc says "synchronous". Should this one say
it too?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6baa8..21be83dc82b1b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  {
>  	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>  
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>  	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound the teardown transactions started from here on, so that an
> +	 * unresponsive control plane costs a single timeout. A reset or a
> +	 * transaction that is already running keeps its own timeouts.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);

[Severity: Medium]
Can a transaction that has nothing to do with the teardown pick up the
500 ms cap here and latch vc_xn_timeout_ms to 0?

Only serv_task and vc_event_task are cancelled before this write.
init_task and stats_task are cancelled later, inside idpf_deinit_task():

idpf_deinit_task() {
	cancel_delayed_work_sync(&adapter->init_task);
	...
	cancel_delayed_work_sync(&adapter->stats_task);
	...
}

idpf_init_task() never checks IDPF_REMOVE_IN_PROG. Any message it sends
in this window, such as idpf_send_create_vport_msg(), gets the 500 ms cap.

In idpf_statistics_task(), the new test_bit(IDPF_REMOVE_IN_PROG) check
and the READ_ONCE(adapter->vc_xn_timeout_ms) in idpf_send_mb_msg() are
separate reads. A worker can pass the bit check before set_bit() and then
read the timeout after this WRITE_ONCE(). That GET_STATS is then sent with
the 500 ms cap.

If either of these times out, idpf_send_mb_msg() writes 0. Once
cancel_delayed_work_sync() returns in idpf_deinit_task(), every vport
teardown message (DISABLE_VPORT, DISABLE_QUEUES, DEL_QUEUES,
DESTROY_VPORT) then fails at once and nothing is sent.

The commit message says "A request it already has waiting ... keeps its
own timeouts". Does that also hold for a stats worker that is past the
flag check but has not read the timeout yet? What about init_task, which
has no flag check at all?

>  	idpf_vc_core_deinit(adapter);
>  	idpf_deinit_dflt_mbx(adapter);

[Severity: Medium]
Can the mailbox rings be freed here while the control plane still owes a
reply, with the mailbox queues still enabled in hardware?

Before this patch, libie_ctlq_xn_shutdown() ran first on shutdown, so no
teardown message was ever posted. Now the messages are posted with a
500 ms cap, and once one times out the rest fail right away. The code then
reaches idpf_deinit_dflt_mbx() almost at once:

idpf_deinit_dflt_mbx() {
	...
	if (adapter->xnm) {
		libie_ctlq_xn_shutdown(adapter->xnm);
		idpf_mb_clean(adapter->asq, true);
		libie_ctlq_xn_deinit(adapter->xnm, &adapter->ctlq_ctx);
	}
	...
}

libie_ctlq_xn_deinit()->libie_ctlq_deinit()->libie_ctlq_remove()->
libie_ctlq_dealloc_ring_res() frees the ARQ and ASQ descriptor rings and
the ARQ buffers.

Nothing in libie/controlq.c ever clears the len/enable or base address
registers; libie_ctlq_init_regs() is the only place that writes them.
idpf_remove() calls trigger_reset(adapter, IDPF_HR_FUNC_RESET) before
idpf_deinit_dflt_mbx(), but idpf_shutdown() does not.

If the reply to the timed-out request arrives late, could the device write
a descriptor and payload into the freed ARQ memory, or read a freed ASQ
send buffer?

>  
[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 854eb1f1ada4c..e7a8ccbc35857 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -195,20 +195,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
>   * Cleanup the mailbox queue entries of the previously sent message to
>   * unmap and release the buffer.
>   *
> + * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
> + * synchronous transaction with a shortened timeout times out, later ones
> + * fail at once instead of waiting again.
> + *
>   * Return: 0 if the request was successful, -%EBUSY if reset is detected
> - *	   or Tx control queue is full, other negative error code on failure.
> + *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
> + *	   already timed out, other negative error code on failure.

[Severity: Low]
This isn't a bug, but this text ties -ETIMEDOUT only to the early-fail
case where nothing is sent.

The function also passes back -ETIMEDOUT from libie_ctlq_xn_send() when
the transaction it just sent gets no reply in time. That can happen with
any timeout, including the default 60 s.

Should the doc mention both meanings, "message never sent" and "message
sent, no reply"?

>   */
>  int idpf_send_mb_msg(struct idpf_adapter *adapter,
>  		     struct libie_ctlq_xn_send_params *xn_params,
>  		     void *send_buf, size_t send_buf_size)
>  {
> +	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
>  	struct libie_ctlq_msg ctlq_msg = {};
> +	int err = 0;
>  
> -	if (idpf_is_reset_detected(adapter)) {
> +	if (idpf_is_reset_detected(adapter))
> +		err = -EBUSY;
> +	else if (!timeout_ms)
> +		err = -ETIMEDOUT;
> +
> +	if (err) {
>  		if (!libie_cp_can_send_onstack(send_buf_size))
>  			kfree(send_buf);
>  
> -		return -EBUSY;
> +		return err;
>  	}

[ ... ]

> @@ -219,10 +231,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>  	xn_params->xnm = adapter->xnm;
>  	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
>  	xn_params->rel_tx_buf = kfree;
> +	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
>  
>  	idpf_mb_clean(xn_params->ctlq, false);
>  
> -	return libie_ctlq_xn_send(xn_params);
> +	err = libie_ctlq_xn_send(xn_params);
> +	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
> +		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);

[Severity: High]
Can a control plane that is slow but still alive leave the device in the
same state this commit sets out to fix?

The first synchronous transaction that takes longer than 500 ms during
shutdown sets vc_xn_timeout_ms to 0 for good. From then on, every
idpf_send_mb_msg() takes the new early return above. Nothing is posted to
the ASQ, nothing is logged, and nothing resets the value.

idpf_vport_stop() ignores these return values and frees the rings anyway:

idpf_vport_stop() {
	...
	idpf_send_disable_vport_msg(adapter, vport_id);
	idpf_send_disable_queues_msg(vport);
	idpf_send_map_unmap_queue_vector_msg(adapter, rsrc, vport_id, false);
	...
	idpf_vport_queues_rel(vport, rsrc);
	...
}

idpf_deinit_task() tears the vports down one after another. A single
timeout on an early vport, for example on DISABLE_VPORT, also suppresses
DISABLE_QUEUES, DEL_QUEUES and DESTROY_VPORT for that vport, plus the
whole teardown of every later vport. The device keeps those queues enabled
over freed rings.

If DISABLE_QUEUES itself is the one that times out,
idpf_send_disable_queues_msg() returns before the marker wait:

	err = idpf_send_ena_dis_queues_msg(vport->adapter,
					   &vport->dflt_qv_rsrc,
					   vport->vport_id, false);
	if (err)
		return err;

	return idpf_wait_for_marker_event(vport);

The rings are then freed while the CP may still be processing the request
and writing markers into them.

The commit message measures the slowest transaction (DEALLOC_VECTORS) at
about 300 ms on an idle system, against the 500 ms cap. It accepts an
incomplete teardown only for a control plane that dies.

Would a larger cap, a cap that does not stick at 0, or an overall time
budget for the teardown avoid this?

> +
> +	return err;
>  }
>  
>  /**
> @@ -372,6 +389,11 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
>  	struct net_device *netdev;
>  	struct idpf_tx_queue *txq;
>  	bool markers_rcvd = true;
> +	bool wait_all;
> +
> +	/* On shutdown, once one marker is missing, don't wait for the rest */
> +	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
> +		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
>  
>  	for (u32 i = 0; i < qs->num; i++) {
>  		switch (qs->qs[i].type) {
> @@ -381,7 +403,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
>  			netdev = txq->netdev;
>  
>  			idpf_queue_set(SW_MARKER, txq);
> -			idpf_wait_for_sw_marker_completion(txq);
> +			if (markers_rcvd || wait_all)
> +				idpf_wait_for_sw_marker_completion(txq);

[Severity: Medium]
What happens to markers that are late rather than lost on the queues that
are skipped here?

During shutdown, wait_all is false for the whole teardown, because
vc_xn_timeout_ms is 500 or 0. Once one Tx queue misses its
IDPF_WAIT_FOR_MARKER_TIMEO window, the remaining Tx queues of the vport
are never polled. Their SW_MARKER bits stay set and their completion
queues are not drained.

idpf_vport_stop() then carries on and frees the completion rings, while
DESTROY_VPORT is sent only later from idpf_vport_rel():

	idpf_vport_intr_deinit(vport, rsrc);
	idpf_xdp_rxq_info_deinit_all(rsrc);
	idpf_vport_queues_rel(vport, rsrc);

Before this patch, each queue got its own wait, so markers that arrived up
to N times the marker timeout late were still consumed before the rings
were freed.

If a remaining marker arrives late on a completion queue other than the
one that was polled, can the device write it into a completion ring that
has already been freed? The commit message describes the shortcut as
intended, but it does not cover late markers.

>  			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
>  			break;
>  		default:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125225145.4126333-1-anthony.l.nguyen%40intel.com
