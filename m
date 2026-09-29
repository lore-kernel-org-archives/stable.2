Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6A568FAB;
	Tue, 29 Sep 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710194; cv=none; b=lEfuOGjaeSPjwC9+9Vv5mjZyRFw7sM4b9z7kPjEdwrQY2YD+fPB8/+Gs65EDYTUxxpr9tfbVaYs9hnZpE5Umr9CibvS4g8lgXfnjwPodoLZRoGwwxPBiMm3IW5V9y6SD8KBYCvMY+bnizVutyiRUW+cg4j6EHSzuQOEqa+IefIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710194; c=relaxed/simple;
	bh=HO9dQ3K1izqUQTkFKiKj8R22d1RdD5KdpZcGv4rTSvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad486h6VeW3xdDfDSaCktShizJDOwXmLgvsT5WzjMIIY84COAg39OjrFJQaCb3gw2OPlrxNQISBRcu6iS+GjZQAd+GEjkP1sOJbbNcVj4P7xJWKkZn18fC1Zb+3rz9NX586B/6KPs5z0HwkMgsTgMF/5PitLJmcO1eTbgWJ41z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsAVMMsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsAVMMsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8C51F000FF;
	Tue, 29 Sep 2026 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710189;
	bh=K/oYGgJ3UYBSUbhjBKJHrFqG06qIYdIEjAcmpZ4Llwk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TsAVMMsX0PakIsfpvPlUhoGp5lDtIK/iDzoE350YFG4ig/QT7f4i/MO3QT48mhyTh
	 EQNG+/QGGAGjguvTznKOYnIZvAl57bjoiqAZS8HPQ0QbUAlPXjO0U7INCWgrps9fnJ
	 lB+Vah+jhUDlKD6V6Xt0zI8jmHj1v8xrf8S0VCveSr1pEtVCisb9OBhCOOKMny+KEp
	 fSh8Ph/aGhwGwmhMFbkrfadWfAGc1yog8KBn/UUsBdrYrWCIddNz4Rn7jq6tVrO+Xt
	 JcSKPWuT3xdoViifk6/uxJ6gN6GOqB4Nzv+6d7ltwPsp3c4+4UIk5/qfe8q4H+JL0E
	 EuZ+sLw8KRsVg==
Subject: Re: [PATCH net 2/2] rxrpc: Fix RACK-TLP implementation
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 19:29:48 +0000
Message-ID: <179071018818.434549.17838739359651740041@kernel.org>
In-Reply-To: <20260925191520.2206700-3-dhowells@redhat.com>
References: <20260925191520.2206700-3-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new RTO rearm in rxrpc_input_call_event()
  (net/rxrpc/call_event.c:446-454) calls rxrpc_get_rto_backoff(call,…
- [Medium] The patch moves the recovery-exit flag into struct rxrpc_call
  (call->cong_exiting_recovery), and it is cleared only at the start of…
- [Low] rxrpc_tlp_calc_pto() (net/rxrpc/input_rack.c:300) now uses `if
  (flight_size <= call->peer->pmtud_jumbo)`.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rxrpc_tx_in_flight() (ar-internal.h:1613-1616, `tx_nr_sent -…
- [Medium] This problem wasn't introduced by this patch, but
  rxrpc_rack_detect_loss() (input_rack.c:228-229) still writes the…

--

rxrpc: Fix RACK-TLP implementation

This commit fixes several problems in the rxrpc RACK-TLP implementation.
It moves the in/exiting recovery flags into struct rxrpc_call and rearms
the RTO timer at the end of rxrpc_input_call_event(). It also moves the
TLP init to FAST_RETRANSMIT entry, moves the segment_xmit_ts reset into
rxrpc_rack_detect_loss(), changes the PTO flight_size check, and stops
tx_nr_resent growing on repeated retransmission.

> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 21be9c86d7a74..07e9aac42163f 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -440,6 +440,19 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  				       rxrpc_propose_ack_input_data);
>  	}
>  
> +	/* Need to rearm the RTO timer if we don't start the TLP-PTO
> +	 * timer [RFC8985 7.3].
> +	 */
> +	if (call->rack_timer_mode == RXRPC_CALL_RACKTIMER_OFF &&
> +	    rxrpc_tx_in_flight(call) > 0) {
> +		ktime_t rto = rxrpc_get_rto_backoff(call, true);

[Severity: Medium]
Does passing retrans == true here make the RTO backoff grow twice per step?

rxrpc_get_rto_backoff() increments call->backoff when retrans is true:

net/rxrpc/rtt.c:rxrpc_get_rto_backoff() {
    ...
	if (retrans && timo_us * 2 <= RXRPC_RTO_MAX)
		WRITE_ONCE(call->backoff, backoff + 1);
    ...
}

When the RACK RTO fires, one pass of rxrpc_input_call_event() looks like
this:

rxrpc_input_call_event()
  rxrpc_rack_timer_expired()
    call->rack_timer_mode = RXRPC_CALL_RACKTIMER_OFF;
    rxrpc_rack_mark_losses_on_rto()
  rxrpc_resend()                                 /* tx_nr_lost > 0 */
    rxrpc_get_rto_backoff(call, req.did_send);   /* backoff + 1 */
  new block above
    rxrpc_get_rto_backoff(call, true);           /* backoff + 1 again */

rxrpc_prepare_data_packet() only sets rack_timer_mode for new data or a
TLP probe, not for retransmissions. So the mode is still OFF here, and
rxrpc_tx_in_flight() is non-zero because it counts the resent segments.

With a 1s base RTO, wouldn't the armed intervals become 1s, 2s, 8s, 32s,
64s instead of 1s, 2s, 4s, 8s, 16s, ...? That leaves fewer retransmission
attempts before expect_rx_by aborts the call.

The same double increment seems to happen after a RACK reorder timer
expiry that marks losses and returns a zero timeout, even though no
retransmission timeout has occurred.

For comparison, rxrpc_tlp_send_probe() rearms the RTO for the same
RFC 8985 7.3 reason with retrans set to false:

	if (in_flight != 0) {
		ktime_t rto = rxrpc_get_rto_backoff(call, false);

Should this call pass false as well? The commit message doesn't mention
any change to the backoff behaviour.

> +
> +		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
> +		call->rack_timo_at = ktime_add(ktime_get_real(), rto);
> +		trace_rxrpc_rack_timer(call, rto, false);
> +		trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);
> +	}
> +

[ ... ]

> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index 072e1d9ecb2ec..66ef2fc6d3d9b 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c

[ ... ]

> @@ -174,14 +173,14 @@ static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
>  		call->rack_dsack_round = snd_nxt;
>  		call->rack_reo_wnd_mult++;
>  		call->rack_reo_wnd_persist = 16;
> -	} else if (summary->exiting_fast_or_rto_recovery) {
> +	} else if (call->cong_exiting_recovery) {
>  		call->rack_reo_wnd_persist--;
>  		if (call->rack_reo_wnd_persist <= 0)
>  			call->rack_reo_wnd_mult = 1;
>  	}

[Severity: Medium]
Can rack_reo_wnd_persist now be decremented more than once for a single
recovery?

call->cong_exiting_recovery is only cleared at the start of the next
rxrpc_congestion_management(), which runs on the next ACK:

	call->cong_in_recovery = false;
	call->cong_exiting_recovery = false;

rxrpc_rack_update_reo_wnd() also runs from the reorder timer path. That
path uses a zeroed summary, so have_dsack_option is false and this else-if
branch is taken:

rxrpc_rack_timer_expired()
  struct rxrpc_ack_summary summary = {};
  case RXRPC_CALL_RACKTIMER_RACK_REORDER:
    rxrpc_rack_detect_loss_and_arm_timer()
      rxrpc_rack_detect_loss()
        rxrpc_rack_update_reo_wnd()
          call->rack_reo_wnd_persist--;

A possible sequence:

- An earlier ACK in FAST_RETRANSMIT arms a RACK_REORDER timer.
- The exit ACK sets cong_exiting_recovery and decrements persist once.
- That ACK's rxrpc_rack_detect_loss() returns 0.
  rxrpc_rack_detect_loss_and_arm_timer() only touches the timer
  if (timeout), so the old REORDER timer stays pending.
- No new data is sent, so the mode isn't switched to TLP_PTO.
- The REORDER timer fires before the next ACK and decrements persist
  again.

Before this patch, the timer path's zeroed summary had
exiting_fast_or_rto_recovery == false, so this couldn't happen.

Wouldn't this let rack_reo_wnd_mult drop back to 1 after fewer than the
"16 DSACK-free recoveries" described in the comment above?

> @@ -227,6 +226,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
>  				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
>  				if (remaining <= 0) {
>  					rxrpc_rack_mark_lost(call, tq, ix);
> +					tq->segment_xmit_ts[ix] = UINT_MAX;
>  					trace_rxrpc_rack_detect_loss(call, summary, seq);
>  				} else {
>  					timeout = max(remaining, timeout);

[Severity: Medium]
This is a pre-existing issue and wasn't introduced by this patch. What
happens if a segment marked lost here is ACKed before it is retransmitted?

rxrpc_get_xmit_ts() maps the UINT_MAX sentinel to KTIME_MAX, and
rxrpc_rack_update() doesn't check for it:

net/rxrpc/input_rack.c:rxrpc_rack_update() {
	ktime_t xmit_ts = rxrpc_get_xmit_ts(tq, ix);
	ktime_t rtt = ktime_sub(call->acks_latest_ts, xmit_ts);
    ...
	if (ktime_after(xmit_ts, call->rack_rtt_ts)) {
		call->rack_rtt	  = rtt;
		call->rack_rtt_ts = xmit_ts;
	}

	if (rxrpc_rack_sent_after(xmit_ts, seq, call->rack_xmit_ts, call->rack_end_seq)) {
		call->rack_rtt = rtt;
		call->rack_xmit_ts = xmit_ts;
		call->rack_end_seq = seq;
	}
}

A later queued ACK can soft-ACK (NACK->ACK) or hard-ACK the segment before
it is resent. rxrpc_input_call_event() processes every skb on rx_queue
before rxrpc_resend() runs, and the retransmit can also be skipped if the
header allocation fails. The segment isn't marked retransmitted, so the
segment_retransmitted check in rxrpc_rack_update() doesn't return early.

rack_rtt_ts and rack_xmit_ts would then become KTIME_MAX, and rack_rtt
would become hugely negative. No real transmit time is after KTIME_MAX, so
these values are never replaced.

>From then on, lost_after in rxrpc_rack_detect_loss() is hugely negative,
and rxrpc_rack_sent_after(KTIME_MAX, ...) is true for every segment.
Wouldn't every NACKed segment then be marked lost immediately, with no
reordering tolerance, for the rest of the call?

This patch removes the sentinel from the RTO path but keeps it here.

[ ... ]

> @@ -297,7 +297,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
>  	if (call->rtt_count > 0) {
>  		/* Use 2*SRTT as the timeout. */
>  		pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);
> -		if (flight_size)
> +		if (flight_size <= call->peer->pmtud_jumbo)
>  			pto = ktime_add(pto, call->tlp_max_ack_delay);

[Severity: Low]
Does this check work as intended when pmtud_jumbo is 0?

peer->pmtud_jumbo is only written by rxrpc_input_probe_for_pmtud(). It is
0 on a newly allocated peer, and it stays 0 for peers that never do PMTUD.
rxrpc_transmit_fresh_data() clamps the same field:

		int limit = min(space, max(call->peer->pmtud_jumbo, 1));

With pmtud_jumbo == 0, flight_size is at least 1 right after sending, so
the single-packet case from RFC 8985 7.2 never matches here.

There's no visible effect today, though. call->tlp_max_ack_delay is never
assigned. It is only declared in struct rxrpc_call and read here, and the
call is zero-allocated, so ktime_add() adds 0 whichever way the check goes.

Is item (5) in the commit message expected to have any effect before
tlp_max_ack_delay is actually set? And should this use a clamp like
max(pmtud_jumbo, 1), as rxrpc_transmit_fresh_data() does?

> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 88cad087f13bf..9e082f7403312 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -576,8 +576,8 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
>  			call->tx_nr_lost--;
>  		if (req->retrans) {
>  			__set_bit(ix, &tq->ever_retransmitted);
> -			__set_bit(ix, &tq->segment_retransmitted);
> -			call->tx_nr_resent++;
> +			if (!__test_and_set_bit(ix, &tq->segment_retransmitted))
> +				call->tx_nr_resent++;

[Severity: Medium]
This isn't a bug introduced by this patch, but does rxrpc_tx_in_flight()
count a lost-then-retransmitted segment twice?

	return call->tx_nr_sent - rxrpc_left_out(call) + call->tx_nr_resent;

On retransmit, this code clears segment_lost and decrements tx_nr_lost.
It then sets segment_retransmitted and increments tx_nr_resent. For one
such segment that gives 1 - 0 + 1 = 2.

RFC 6675 pipe and tcp_packets_in_flight() keep the lost mark after
retransmission, so there the segment is counted once. The first branch of
rxrpc_rack_mark_lost() appears to assume that model:

	if (__test_and_set_bit(ix, &tq->segment_lost)) {
		if (__test_and_clear_bit(ix, &tq->segment_retransmitted))
			call->tx_nr_resent--;

However, segment_lost has already been cleared by this point.

Wouldn't in-flight then be overestimated while retransmissions are
outstanding? That would inflate the ssthresh that
rxrpc_congestion_management() computes from in_flight / 2.

This change stops tx_nr_resent growing without bound, but the commit
message doesn't claim to fix the double count.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com
