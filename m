Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627206;
	b=uhsYzLqbDw8k+QhUz2B3UDVy6kMIV8rbs9Yb14M8eDGJPsTlgjP8lUHJgjIW12tx66nU
	 gtRn6yDOE90RSNv+0Zz/DRRYHCkwJwIYFC0EfLIoHJJTY7e50FDt2nDgQ75BILP16Sb2S
	 348Msg+6Xw1v/xQX5Ym3CG+JNeqN6yNmeMXzxBMmV9URv7dleeDOfBjwbn52ZP38rXiTr
	 +MI6EQO0YhiN/jJTUMAbghgsjIA7aFeTWzGOCRzlCoPH9KYU2u0e1R5cmzdc9QoadNjqV
	 1uHGzwGnyGLhDMMJDgGwQJ93boQVJYiLzGZi/MxGVrlU44q7TEDVzXmBvQl826ZKFSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627206;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vFMMIEZR5ZqyObdP64d3oDSzWnXF1pfF29ub6G+xXYo=;
	b=DlIqE5uqqRuWQUtIzZ4kIzXi9nnbcjQJlIGuRRXX1bxD8OdnbhNnasVRWCIZHnXLhsay
	 2p6E+gjwoHN7oRmPw3xNQnH5TjXv9Yq+lRqaUooGGwFXAaT5ATxvHRtIvIrqevRhY75/K
	 twQdnuJjdJZ6OGZ/8HyAVtd3ASzuA17XfIIHtln2MTXLlXcxi9oEUaw0o1noj7L/0e7HU
	 I81Wp/k/+8iRJt0kVyM7tDxliAFS7wpgmO8GEwrcQdMyQBIccbDiwmCr2eFLnwDUt21sT
	 ST7uEkhpIM8ne2W65nNzx01g9DIpakIbleTSeDhPgPeKJLChhlPQWbxTUg9Bk+/9O3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBFeUdNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D312606A31A;
	Thu, 22 Oct 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBFeUdNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990A31F000C1;
	Thu, 22 Oct 2026 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627205;
	bh=vFMMIEZR5ZqyObdP64d3oDSzWnXF1pfF29ub6G+xXYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cBFeUdNTLcNWXsVL30bdlV/Sw2o1XJuvHz3lwm+AYddfYDk1m9V3aHQXknU1YiRAl
	 n7Nf/NuW4FRYISfS7jMUTa3IM1pQ5m1JstJq5hXAl5eVQLvoIqTflVWA0r4NR/RMRb
	 9tIQ7e9BXPWbIHvWxRmBmQpyj4iMy+3kyNH9E3oglifK7KxngMlQI7ozSO/bFdjpVh
	 kU1R9ERy5Bg/uYI8XqtKOac6PiFph6Ct/wCheQmOnQMgYuZl6nx8ekXALVNIGIso4O
	 UDw1bt90UsBSTmxHd0sJ8dO6eqDIXITG7urJwqBsV4YBMHrQ/4VUW/zbStWL9MNtw3
	 Gr77qPX0rDSBg==
Subject: Re: [PATCH net v2 3/3] rxrpc: Fix RACK-TLP implementation
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 00:00:04 +0000
Message-ID: <179262720415.3135.5535463489251782086@kernel.org>
In-Reply-To: <20261020201258.290827-4-dhowells@redhat.com>
References: <20261020201258.290827-4-dhowells@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Item (6) of the commit message describes a change that is not
  in the patch.
- [Low] Item (1) of the commit message says the "in/exiting Fast or RTO
  recovery" flags, plural, move from rxrpc_ack_summary to rxrpc_call so…
- [Low] In rxrpc_congestion_management() (net/rxrpc/input.c), the
  RXRPC_CA_FAST_RETRANSMIT case sets call->cong_in_recovery = true (line…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  call->cong_in_recovery is documented as "If we're in Fast/RTO…
- [Medium] This problem wasn't introduced by this patch, but the patch
  rewrites the exact line involved.

--

I found five things worth raising on this patch. Two are about the commit message not matching the diff. One is a small state problem the patch introduces. Two are older bugs that this patch touches but did not cause, and those are labelled as such inline.

rxrpc: Fix RACK-TLP implementation

This commit makes several fixes to the rxrpc RACK-TLP code. The in-recovery
flag moves from rxrpc_ack_summary to rxrpc_call. The RTO timer is now rearmed
in rxrpc_input_call_event() when no other RACK timer is set. TLP init moves
to the transition into FAST_RETRANSMIT, the segment_xmit_ts reset moves into
rxrpc_rack_detect_loss(), and the PTO flight_size check is adjusted.

> Fix the RACK-TLP implementation in the following ways:
>
>  (1) Move the "in/exiting Fast or RTO recovery" flags to the rxrpc_call
>      struct rather than rxrpc_ack_summary so that they persist beyond ACK
>      parsing to the next time rxrpc_congestion_management() happens (when
>      the next ACK is parsed).  This allows those values to be accessed by
>      RACK-TLP when invoked by the Reorder timer expiring.

[Severity: Low]
Does this match what the patch does? Only the "in" flag moves, and it
becomes call->cong_in_recovery. The "exiting" flag is still in the per-ACK
summary:

struct rxrpc_ack_summary {
	...
	bool		exiting_fast_or_rto_recovery:1;
	...
};

rxrpc_congestion_management() still sets it for each ACK, and
rxrpc_rack_update_reo_wnd() still reads it as
summary->exiting_fast_or_rto_recovery.

rxrpc_rack_timer_expired() passes a zeroed summary from its stack, so the
exiting flag is always false on the Reorder timer path.

Keeping the exiting flag per ACK looks deliberate, but could the commit
message say that only the "in" flag moves?

>  (6) In rxrpc_prepare_data_packet(), only increment call->tx_nr_resent if
>      the DATA packet being retransmitted was not previously transmitted
>      otherwise tx_nr_resent will keep getting bigger and cause RACK-TLP to
>      malfunction (the value is used in the in-flight calculation).
>      tx_nr_resent is decremented when a packet that has been retransmitted
>      is discarded - but only by 1 per packet.

[Severity: Medium]
Is this item still accurate? The diff does not touch net/rxrpc/output.c,
and struct rxrpc_call has no tx_nr_resent member in this tree.

The previous commit in the series, "rxrpc: Fix counting of in-flight
transmitted packets", seems to have removed tx_nr_resent and tx_nr_sent. It
replaced them with the per-txqueue in_flight bitmap and call->tx_in_flight.
rxrpc_prepare_data_packet() already does this:

		if (!__test_and_set_bit(ix, &tq->in_flight))
			call->tx_in_flight++;

This patch is Cc'd to stable. Could item (6) be dropped, or reworded to
refer to the previous commit?

> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index d0e18eb6301e9..d3b1b095192da 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -811,6 +811,7 @@ struct rxrpc_call {
>  #define RXRPC_TX_SMSS		RXRPC_JUMBO_DATALEN
>  #define RXRPC_MIN_CWND		4
>  	enum rxrpc_ca_state	cong_ca_state;	/* Congestion control state */
> +	bool			cong_in_recovery:1; /* If we're in Fast/RTO recovery */

[Severity: Medium]
This isn't a bug introduced by this patch, but does anything set this flag
during RTO recovery? rxrpc_congestion_management() sets it to true in only
two places: the PACKET_LOSS to FAST_RETRANSMIT transition, and the
RXRPC_CA_FAST_RETRANSMIT case.

The RACK RTO path never touches it:

rxrpc_rack_timer_expired()
    case RXRPC_CALL_RACKTIMER_RTO:
        rxrpc_rack_mark_losses_on_rto(call);

The other RTO hook in rxrpc_congestion_management() looks unreachable.
RXRPC_CALL_RETRANS_TIMEOUT is tested and cleared there but never set
anywhere:

	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {

So after an RTO, rxrpc_rack_update_reo_wnd() uses a non-zero reordering
window. RFC 8985 section 6.2 step 4 uses 0 during RTO recovery. The old
summary->in_fast_or_rto_recovery flag had the same gap.

>  	u8			cong_extra;	/* Extra to send for congestion management */

[ ... ]

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index f497eba59cf6e..815749c7abeb8 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -34,6 +34,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
>  {
>  	summary->change = rxrpc_cong_no_change;
>  	summary->in_flight = call->tx_in_flight;
> +	call->cong_in_recovery = false;
>  
>  	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
>  		summary->retrans_timeo = true;
> @@ -106,12 +107,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
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

[Severity: Low]
Should cong_in_recovery be cleared when this case leaves recovery? The flag
is set here before the exit check, and the exit path is:

		} else {
			summary->change = rxrpc_cong_progress;
			call->cong_cwnd = call->cong_ssthresh;
			if (call->acks_nr_snacks == 0) {
				summary->exiting_fast_or_rto_recovery = true;
				goto resume_normality;
			}
		}

resume_normality sets cong_ca_state to RXRPC_CA_SLOW_START or
RXRPC_CA_CONGEST_AVOIDANCE, but leaves call->cong_in_recovery set.

The flag now lives on the call. Until the next ACK, it says the call is in
Fast/RTO recovery while cong_ca_state says it is not.

Suppose a Reorder timer armed by an earlier ACK fires in that window:

rxrpc_rack_timer_expired()
  rxrpc_rack_detect_loss_and_arm_timer()
    rxrpc_rack_detect_loss()
      rxrpc_rack_update_reo_wnd()
        if (call->cong_in_recovery)
            return 0;

If rack_reordering_seen is false, call->rack_reo_wnd is set to 0, and
rxrpc_rack_mark_losses_on_rto() later uses that value.

acks_nr_snacks is 0 on this path, so the timer has no NACKed segments to
mark lost. The practical effect looks small.

> +		if (!summary->new_low_snack) {
>  			if (summary->nr_new_sacks == 0)
>  				call->cong_cwnd += 1;

[ ... ]

> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index e43ce032a2618..1f6b51fa9721f 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c

[ ... ]

> @@ -230,6 +229,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
>  				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
>  				if (remaining <= 0) {
>  					rxrpc_rack_mark_lost(call, tq, ix);
> +					tq->segment_xmit_ts[ix] = UINT_MAX;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but the
patch moves this line. What happens if a segment marked lost here is acked
before it is retransmitted?

rxrpc_get_xmit_ts() turns the sentinel into KTIME_MAX:

	if (tq->segment_xmit_ts[ix] == UINT_MAX)
		return KTIME_MAX;

If the original packet was only reordered, a later ACK can still ack it.
One way is the old NAK to ACK flip, rxrpc_input_soft_ack_tq() ->
rxrpc_input_rack(). Another is the soft NAK to hard ACK case,
rxrpc_rotate_tx_window() -> rxrpc_input_rack_one().

rxrpc_rack_update() then uses KTIME_MAX as if it were a real transmit
time. segment_retransmitted is clear for this segment, so the serial and
min_rtt checks are skipped:

	ktime_t xmit_ts = rxrpc_get_xmit_ts(tq, ix);
	ktime_t rtt = ktime_sub(call->acks_latest_ts, xmit_ts);
	...
	if (ktime_after(xmit_ts, call->rack_rtt_ts)) {
		call->rack_rtt	  = rtt;
		call->rack_rtt_ts = xmit_ts;
	}

rack_rtt ends up hugely negative, and rack_rtt_ts and rack_xmit_ts end up
at KTIME_MAX. Only rxrpc_rack_update() writes these fields, and no later
timestamp can be greater than KTIME_MAX. So the bad values stay for the
rest of the call.

After that, lost_after in rxrpc_rack_detect_loss() is very negative, so
every reported NACK is marked lost at once. The deadline in
rxrpc_rack_mark_losses_on_rto() is also skewed.

Could this cause spurious retransmissions for the rest of the call? No
concurrency seems to be needed. rxrpc_input_call_event() handles several
queued ACKs and Reorder timer expiries in its rx_queue loop before
rxrpc_resend() runs.

>  					trace_rxrpc_rack_detect_loss(call, summary, seq);
>  				} else {
>  					timeout = max(remaining, timeout);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com
