Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774424;
	b=3dBzxVWkMfr1BhyNTbsqS1aGfHFBUnKUXokgjkjq7GkVBV/8Z4pwdp+XtEb+ybNP5ElF
	 oT2IBfZC/7GQLxxYKiOLlfPdASRQifpIE4pEUcaIBugtPGO3tGUk0LlpNc8Gxfqte6nE9
	 z3lF779bi5eHKBEBKJVnGwA31p6sV6zAleUf0tLkwKIf5RDBk2Z+Ow3fdoPFz/cdNUknm
	 rLYyxooEtkFpXJ707r0N6XembvWL3y0Z372yQuNU8Jun2sWKCi8XN2ihVNfVPOwFu9jS7
	 DdjG/SKdCvpvfnHn3MLT8aUgC+HUv1LA3a4HXL4du72gEMxXt5hm0/by5D+9PVkyPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774424;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3j5RK3itpNq34OmIOuVkOe088Cm5IuS4Nvic86ZYVGc=;
	b=SnN2pNeuHkHAOX/gX46wsh9UOaktgjxl/z2JGnLpWo0YK8HFqoXKqpm6OM0p0VRHrpmE
	 Tx4yiQSnjtPFN91355c45r9Tnk5zfN9TeT5DHfgu8yy6MdBksmYisfDTNXzLpjyvvjCI0
	 14AL7W3TOCI7zskpTDrf7KjUvhafgf+VfhngY+1WocqvbudoUImhOtc/hje1V9+kZ+D9d
	 kpoOrBx9K+xo9PkHKvf0natj6zoTbpqzmOpogCaOsCGSMdDcMYjLVE/RA2YWQk+qiVR6I
	 /8E5JirdNGOjJdCdaPlLRGVuavtCMCu1zYQZK7bDx+5yu50BjnzDfoS6ZwGiCRtTpMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL2Knwde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683C606A690;
	Fri, 27 Nov 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL2Knwde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D651F0182B;
	Fri, 27 Nov 2026 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774423;
	bh=3j5RK3itpNq34OmIOuVkOe088Cm5IuS4Nvic86ZYVGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fL2KnwdeqDE7lI+V+1UkJQsGOw3SLbctxv8XK1RREyzRIy4ilv3wnwcFlBDtKgiSB
	 WCsDcrc1o5+r2a/YuBbtisIyW54kBOjHb0Jpwpyg+3cYHPdoDhIYdM+PC4EHhbtknu
	 V4Qbi4TNQ5N5dzzvriGKZ+lbz/D1DbcnPlMWBRxQ5IVhkPUBEm0tJSBnFkY/SvfmsV
	 KdQz4RkIlSKn2XjicMAtSdmD0dPOCWH6UMjVq05QgLrgtANaG4CEUOlBI8gQamWQXb
	 c6N/tcGUyt2WEjWCjF65+xwlM3ZLGQ1t+YWifLa1ijrtguvD27Cy3wprJlLr6ctTNf
	 PagWX2er7GIlw==
Subject: Re: [PATCH net v3 10/10] rxrpc: Fix RACK-TLP implementation
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:42 +0000
Message-ID: <179577442266.3135.14941327848364859850@kernel.org>
In-Reply-To: <20261124161302.4044422-11-dhowells@redhat.com>
References: <20261124161302.4044422-11-dhowells@redhat.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rxrpc_update_rack_rto_timer() (net/rxrpc/input_rack.c) never
  stops the RTO timer once every transmitted DATA packet has been ACK'd.
- [Low] In the new rxrpc_update_rack_rto_timer()
  (net/rxrpc/input_rack.c), `rto = ktime_add(earliest,…
- [Low] The new RTO rearm in rxrpc_input_call_event()
  (net/rxrpc/call_event.c:456-463) uses `rack_timer_mode == OFF &&…
- [Low] The new rxrpc_call::cong_in_recovery field is commented "If we're
  in Fast retransmit recovery", but it stays true after the call leaves…

--

rxrpc: Fix RACK-TLP implementation

This patch fixes several parts of the rxrpc RACK-TLP implementation. It
moves the recovery flag from rxrpc_ack_summary into rxrpc_call, rearms or
extends the RTO timer at the end of rxrpc_input_call_event(), and
initialises the TLP state only on entry to FAST_RETRANSMIT. It also moves
the segment_xmit_ts reset out of rxrpc_rack_mark_lost() and changes the
flight_size check in rxrpc_tlp_calc_pto().

> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 62e15b03c9c2e..2b3bd5355a023 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c

[ ... ]

> @@ -448,6 +450,24 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  				       rxrpc_propose_ack_input_data);
>  	}
>  
> +	/* Need to rearm the RTO timer if we don't start the TLP-PTO
> +	 * timer [RFC8985 7.3].
> +	 */
> +	if (call->rack_timer_mode == RXRPC_CALL_RACKTIMER_OFF &&
> +	    call->tx_in_flight > 0) {
> +		ktime_t rto = rxrpc_get_rto_backoff(call, false);
> +
> +		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
> +		call->rack_timo_at = ktime_add(ktime_get_real(), rto);
> +		trace_rxrpc_rack_timer(call, rto, false);
> +		trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);

[Severity: Low]
Can tx_in_flight be non-zero here only because of a TLP probe, after the
Tx phase has already ended?

The commit message says the RTO is rearmed "if DATA packets have been sent
but not yet ACK'd". However, tx_in_flight also counts a TLP retransmission
of a segment that has already been soft-ACK'd:

net/rxrpc/output.c:rxrpc_send_data_packet() {
    ...
		if (req->tlp_probe && test_bit(ix, &tq->segment_acked)) {
			...
			if (!call->tlp_in_flight) {
				call->tlp_in_flight = true;
				call->tx_in_flight++;
			}
    ...
}

Suppose the final ACK then hard-ACKs the whole window. tlp_seq goes
through the soft ACK to hard ACK branch of rxrpc_rotate_tx_window(), and
that branch doesn't call rxrpc_tlp_end_probe():

		} else if (test_bit(ix, &tq->segment_acked)) {
			/* Soft ACK -> hard ACK. */
			call->acks_nr_sacks--;
			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_sack);
		}

rxrpc_input_ack() then calls rxrpc_end_tx_phase(), which sets
rack_timer_mode to RXRPC_CALL_RACKTIMER_OFF. It then jumps to send_response
and skips check_for_tlp_probe, so the probe isn't ended there either.

Back in rxrpc_input_call_event(), the mode is OFF and tx_in_flight is 1.
An RTO therefore gets armed on a call in CLIENT_AWAIT_REPLY or
CLIENT_RECV_REPLY. When it fires, rxrpc_rack_timer_expired() calls
rxrpc_congestion_timeout() even though nothing is outstanding.

rxrpc_tlp_probe_loss() may not clear the probe if rto_us has grown since
the probe was sent. In that case the mode goes back to OFF with
tx_in_flight still 1, and this block arms the RTO again.

Could this keep rearming the RTO on a call that has finished transmitting?

[ ... ]

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 66be37f214105..aa3af5a10c015 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -97,12 +98,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
>  		call->cong_extra = 0;
>  		call->cong_dup_acks = 0;
>  		summary->need_retransmit = true;
> -		summary->in_fast_or_rto_recovery = true;
> +		call->cong_in_recovery = true;
> +		rxrpc_tlp_init(call);
>  		goto out;
>  
>  	case RXRPC_CA_FAST_RETRANSMIT:
> -		rxrpc_tlp_init(call);
> -		summary->in_fast_or_rto_recovery = true;
> +		call->cong_in_recovery = true;
>  		if (!summary->new_low_snack) {
>  			if (summary->nr_new_sacks == 0)
>  				call->cong_cwnd += 1;

[Severity: Low]
Does cong_in_recovery stay true after the call has left recovery?

The new field is commented "If we're in Fast retransmit recovery". On the
exit ACK, though, this case sets it to true and then leaves recovery:

		} else {
			summary->change = rxrpc_cong_progress;
			call->cong_cwnd = call->cong_ssthresh;
			if (call->acks_nr_snacks == 0) {
				summary->exiting_fast_or_rto_recovery = true;
				goto resume_normality;
			}
		}

resume_normality moves cong_ca_state to SLOW_START or CONGEST_AVOIDANCE
but doesn't clear cong_in_recovery.

The flag now outlives the ACK, so a reorder timer that fires before the
next ACK can still see it:

rxrpc_rack_timer_expired()
  rxrpc_rack_detect_loss_and_arm_timer()
    rxrpc_rack_update_reo_wnd()

Here cong_in_recovery is true while cong_ca_state says recovery is over.
With !rack_reordering_seen, rack_reo_wnd is set to 0, and a later RTO
uses that value in rxrpc_rack_mark_losses_on_rto().

The reorder path itself can't declare new losses, because acks_nr_snacks
is 0 at exit.

Would clearing cong_in_recovery in resume_normality keep the field
consistent with cong_ca_state and with its comment?

[ ... ]

> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index 240362109a3b3..473046562b0bd 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c

[ ... ]

> @@ -446,3 +447,50 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
>  		pr_warn("Unexpected rack timer %u", mode);
>  	}
>  }
> +
> +/*
> + * Update the RACK RTO timer after new data is ACK'd.
> + */
> +void rxrpc_update_rack_rto_timer(struct rxrpc_call *call)
> +{
> +	struct rxrpc_txqueue *tq;
> +	ktime_t earliest = KTIME_MAX, rto;
> +
> +	if (!call->tx_in_flight)
> +		return;

[Severity: Medium]
Should the RTO be stopped here when nothing is in flight, instead of
returning with the old deadline still set?

After this early return, rack_timer_mode is still
RXRPC_CALL_RACKTIMER_RTO and rack_timo_at keeps its old value. The new
block in rxrpc_input_call_event() can only arm the RTO or move it later,
so nothing cancels it.

Here is one way to reach this:

1. The RTO is armed when rxrpc_input_call_event() starts, so in_rto is
   true.

2. An ACK hard-ACKs everything that has been transmitted. The last packet
   hasn't been sent yet, so rxrpc_end_tx_phase() isn't called.

3. rxrpc_rotate_tx_window() drops tx_in_flight to 0, and
   RXRPC_CALL_NEW_DATA_ACKED gets set.

4. Nothing new is queued, so no TLP-PTO replaces the RTO, and this
   function returns early.

The timer is still rearmed through set(call->rack_timo_at). When it
fires, rxrpc_rack_timer_expired() calls rxrpc_congestion_timeout():

	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
	call->cong_ssthresh = umax(call->tx_in_flight / 2, 2);
	call->cong_cwnd = 1;

This sets cwnd to 1 and ssthresh to 2 even though nothing was lost.

RFC 6298 section 5.2, which RFC 8985 uses for the RTO, says to turn off
the retransmission timer once all outstanding data has been acknowledged.

The new arm-on-OFF code also makes this more likely. It now arms an RTO
after RTO-driven resends and after the reorder timer fires, where
previously no timer was set.

[ ... ]

> +	if (earliest != KTIME_MAX) {
> +		rto = ktime_add(earliest, rxrpc_get_rto_backoff(call, false));
> +		if (ktime_after(rto, call->rack_timo_at)) {
> +			call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
> +			call->rack_timo_at = rto;
> +			trace_rxrpc_rack_timer(call, rto, false);
> +			trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);

[Severity: Low]
Is rto the right value to pass to these tracepoints?

Here rto is an absolute CLOCK_REALTIME deadline, because earliest comes
from rxrpc_get_xmit_ts(). Storing it in rack_timo_at is correct. However,
trace_rxrpc_rack_timer() and trace_rxrpc_timer_set() take a ktime_t delay
and print it as to=%lld via ktime_to_us().

The other rack_rto trace site added by this patch, in
rxrpc_input_call_event(), passes a relative rto:

		call->rack_timo_at = ktime_add(ktime_get_real(), rto);
		trace_rxrpc_rack_timer(call, rto, false);
		trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);

Traces from this path will therefore show the wall-clock time since the
epoch in microseconds, not the time left until the RTO fires.

Should a relative delay be passed here, as the other callers do?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
