Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774422;
	b=fQoxiiFgqhjEvoH4IX8dmIxL0H578+GgB6ofXwiFqyxGxkePI010hkiItjJVRDDqEAXB
	 WpVS/I2SpghVfSxhMQvpjtjFtmZfdkL0yqEPhDectuervBfyzwFfRAMvLrOHLOwLVG5aX
	 sEOD5iymSb5hVPELf61OQiYNH5rOmzoMsnqCpMg9SPRE3QlT4cCJvID9mHQXv3G/wRh8k
	 BnqlT37kz+8rpX5s/08ccJuJKC9pDrsSUvBIyWEJMvvefWr/cy/prqGzkJofyLdMA9Bx3
	 nXi5Qda3c0gsfysqV8ra/XyO9C2pvEE6xu1EngxR00XwybC50SPitUsnK2fvFFIwKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774422;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XGdmHFNjY89EEeZRDw1GOEvXLMVlv2DgLY3EiKvFCow=;
	b=ENNrckKl3S09G5YtoBd8TBvWAqb3by/+4Zr+VTqnhVBfXH/kZeRh2ST2t6PqQNP0B/+D
	 nk0ZhnBNSICBTYgSX3+M2elfkYhF1xnNQMuTa484QZpKjsWalTJAx8Xo0anmBBGCaFotb
	 X3Kp5Rf7ZphItckit4Y+TppNdw/2XbuB8k932bZ1ewrXbCkT3OQ9/MSPlW9YRywCaEXPO
	 Gi/DzHEc865/auVpXiZN6QUb+MgQoU/3tJzpmPzxKXuvITlTKz42bcsgNwC8dSBXxYWHX
	 Kwwn2JU8SErmRKD4rsMxczP5x+rWgJRnaT0dAcSQqL3F9tigDZ50z24MLCz7aybpGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1dPYliL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071D606A6A8;
	Fri, 27 Nov 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1dPYliL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BECE1F00933;
	Fri, 27 Nov 2026 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774421;
	bh=XGdmHFNjY89EEeZRDw1GOEvXLMVlv2DgLY3EiKvFCow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J1dPYliLHm1wffT8lzZls0esySofXIgQyWg1jm4vHf/QSykMq74hd0PXrXZKRYMQB
	 kg7Px6vc4MM8f1X5YNfrOFbsH/2tpBvgOsK5vMM+jDFFTMVCoaMrZPmTxSd4/EOEqI
	 05tTxPTtmJTi9w+VgYJI+BjRdNmxIQngeP0r4CKLS4nCDjnBctlWNMIQEucBeN9UNU
	 I5uWzuEFpirLJ4ZfPqA1UC1aETzdyplWqFsByjDStAsmulyUP8LNskQ1ZOYXk3R+zU
	 VN6omIxzlCRg5LgIVBikvNIZhqR1YFgc1vr3iKHyc5o9ejsHTvYcf6ruFpfi0P9Mfn
	 83XMCAVv1kaRQ==
Subject:
 Re: [PATCH net v3 09/10] rxrpc: Fix counting of in-flight transmitted packets
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:40 +0000
Message-ID: <179577442085.3135.14809535451796847192@kernel.org>
In-Reply-To: <20261124161302.4044422-10-dhowells@redhat.com>
References: <20261124161302.4044422-10-dhowells@redhat.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rxrpc_rotate_tx_window() (net/rxrpc/input.c) now calls
  rxrpc_tlp_end_probe() as soon as the probed sequence is hard-ACKed in…
- [Medium] The 'Soft ACK -> hard ACK' branch of rxrpc_rotate_tx_window()
  (net/rxrpc/input.c:286-289) does not call rxrpc_tlp_end_probe().
- [Medium] rxrpc: tx_in_flight double-counted when soft-ACKed TLP probe
  is reneged
- [Medium] rxrpc: TLP probe state not cleared on RTO in
  rxrpc_tlp_probe_loss()

--

rxrpc: Fix counting of in-flight transmitted packets

This commit drops the derived FlightSize approximation. In its place it
tracks in-flight packets directly, using a per-txqueue in_flight bitmap
and a call->tx_in_flight counter. TLP probes that retransmit an
already-ACKed packet get separate accounting (tlp_in_flight), and RTO
expiry now also checks whether the TLP probe was lost.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index d01a8d95dc6db..66be37f214105 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -276,8 +276,10 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
>  			tq->nr_reported_acks++;
>  			rxrpc_input_rack_one(call, summary, tq, ix);
>  			if (call->tlp_serial &&
> -			    seq == call->tlp_seq)
> +			    seq == call->tlp_seq) {
>  				summary->tlp_probe_acked = true;
> +				rxrpc_tlp_end_probe(call);
> +			}
>  			summary->nr_new_hacks++;
>  			__set_bit(ix, &tq->segment_acked);
>  			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_hack);

[Severity: Medium]
Is the probe meant to be ended here, during rotation? The commit message
doesn't mention this change.

rxrpc_tlp_end_probe() sets call->tlp_serial to 0. rxrpc_rotate_tx_window()
runs before this check in rxrpc_input_ack():

check_for_tlp_probe:
	if (call->tlp_serial) {
		...
		rxrpc_tlp_process_ack(call, &summary);

So whenever an ACK hard-ACKs call->tlp_seq, rxrpc_tlp_process_ack() is now
skipped. On the normal hard-ACK path, doesn't that bypass the RFC 8985
section 7.4 classification (new_data, dup_acked, hard_beyond, acked) and
every trace_rxrpc_tlp_ack() event?

summary->tlp_probe_acked is set just before rxrpc_tlp_end_probe(). Its
only consumer is this branch in rxrpc_tlp_process_ack():

	} else if (summary->tlp_probe_acked) {
		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_acked);

The other place that sets it, rxrpc_input_soft_ack_tq(), only does so when
tlp_seq is beyond hard_ack. In that case rxrpc_tlp_process_ack() returns
early.

Does that make the 7.4.2 special case unreachable? It would also remove the
hook that the existing "TODO: Invoke congestion control to react to the
loss event the probe has repaired" comment depends on.

The soft-NAK -> hard-ACK branch gets the same change. The last patch in the
series, "rxrpc: Fix RACK-TLP implementation", doesn't seem to change any of
this.

These calls also don't cover the soft-ACK -> hard-ACK branch, which is the
case tlp_in_flight needs most. That is covered in the next comment.

[ ... ]

> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 88cad087f13bf..e053db0c22e6e 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c

[ ... ]

> @@ -571,15 +570,26 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
>  
>  		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
>  
> +		if (req->tlp_probe && test_bit(ix, &tq->segment_acked)) {
> +			/* Account re-transmission of an already ACK'd packet
> +			 * separately as the ACK parser ignores re-ACKs of
> +			 * already ACK'd packets.
> +			 */
> +			if (!call->tlp_in_flight) {
> +				call->tlp_in_flight = true;
> +				call->tx_in_flight++;
> +			}
> +		} else if (!__test_and_set_bit(ix, &tq->in_flight)) {
> +			call->tx_in_flight++;
> +		}

[Severity: Medium]
Doesn't this miss the TLP probe's in-flight count when a soft-ACK is
reneged?

When rxrpc_resend_tlp() retransmits call->tx_transmitted after it has
been soft-ACKed, rxrpc_prepare_data_packet() counts the probe only
through call->tlp_in_flight. The segment's bit in tq->in_flight was
already cleared by rxrpc_input_soft_ack_tq() when the soft-ACK
arrived.

Rx soft-ACKs are not binding, so a later ACK can turn that segment
back into a NAK. rxrpc_input_soft_ack_tq() then puts it in a_to_n and
rxrpc_input_rack() passes it here. The tq->in_flight bit is already
clear, so tx_in_flight is left alone, and call->tlp_in_flight stays
set.

Nothing else in rxrpc_input_ack() ends the probe either. tlp_seq is
still above the hard-ACK point, so rxrpc_tlp_process_ack() returns
early. If that ACK's acked_serial is below call->tlp_serial, the
check after it doesn't fire.

Because tx_nr_lost is now non-zero, rxrpc_input_call_event() calls
rxrpc_resend(). That retransmission has tlp_probe false and
segment_acked clear, so rxrpc_prepare_data_packet() sets the
tq->in_flight bit and increments tx_in_flight a second time. The one
segment is then counted twice, once in the bitmap and once through
tlp_in_flight.

The extra count stays until something calls rxrpc_tlp_end_probe().
Until then, these all see one more packet than is outstanding:
summary->in_flight in rxrpc_congestion_management(), cong_ssthresh in
rxrpc_congestion_timeout() and flight_size in rxrpc_tlp_calc_pto().

Should rxrpc_rack_mark_lost() end the probe, or at least drop the
tlp_in_flight count, when the segment being marked lost is
call->tlp_seq and tlp_in_flight is set?

[Severity: Medium]
Where is this extra count released once the probed segment is hard-ACKed?

tlp_in_flight is only set when the TLP retransmits a segment that is
already soft-ACKed. rxrpc_resend_tlp() does this when call->tx_transmitted
has been soft-ACKed.

When that segment is rotated later, rxrpc_rotate_tx_window() takes the
soft-ACK branch, which has no rxrpc_tlp_end_probe() call:

		} else if (test_bit(ix, &tq->segment_acked)) {
			/* Soft ACK -> hard ACK. */
			call->acks_nr_sacks--;
			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_sack);

The in_flight bitmap can't drop the count either, because the probe never
set the segment's in_flight bit.

If that segment carries RXRPC_LAST_PACKET, rxrpc_input_ack() skips
check_for_tlp_probe entirely:

	if (after(hard_ack, call->tx_bottom)) {
		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
			goto send_response;
		}
	}

rxrpc_receiving_reply() also rotates the window and ends the tx phase with
no TLP cleanup.

Wouldn't this leave tlp_serial non-zero, tlp_in_flight true and
tx_in_flight at 1 with nothing outstanding?

After the final series patch ("rxrpc: Fix RACK-TLP implementation"),
rxrpc_input_call_event() re-arms the RTO whenever rack_timer_mode is OFF
and tx_in_flight > 0. Could the stale count arm a spurious RTO after
rxrpc_end_tx_phase()? That RTO would run rxrpc_congestion_timeout() and RTO
loss marking before rxrpc_tlp_probe_loss() clears the probe.

Without rot_last, the probe can still be classed as "incomplete" in
rxrpc_tlp_process_ack() when hard_ack == tlp_seq and acked_serial is below
tlp_serial. Until the probe's own ACK arrives, FlightSize is one too high
for rxrpc_tlp_calc_pto() and rxrpc_congestion_timeout(), and no new TLP
probe can be sent.

Would it close the gap to call rxrpc_tlp_end_probe() when
seq == call->tlp_seq in the soft-ACK branch, or on the rot_last path?

[ ... ]

> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c
> @@ -396,12 +392,32 @@ void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *su
>  		/* Special Case: Detected a single loss repaired by the loss
>  		 * probe [7.4.2]
>  		 */
> -		call->tlp_serial = 0;
> +		rxrpc_tlp_end_probe(call);
>  	} else {
>  		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_incomplete);
>  	}
>  }
>  
> +/*
> + * Handle TLP probe loss.
> + */
> +static void rxrpc_tlp_probe_loss(struct rxrpc_call *call)
> +{
> +	ktime_t lost_at, now;
> +
> +	if (!call->tlp_serial)
> +		return;
> +
> +	lost_at = ktime_add(call->tlp_xmit_ts, rxrpc_get_rto_backoff(call, false));
> +	now = ktime_get_real();
> +
> +	if (ktime_before(now, lost_at))
> +		return;
> +
> +	/* Presume the probe to be lost.  Cancel it so we can have a new one. */
> +	rxrpc_tlp_end_probe(call);
> +}
> +
>  /*
>   * Handle RACK timer expiration; returns true to request a resend.
>   */

[Severity: Medium]
Can this miss a lost probe because the RTO grew after the probe was
sent?

call->tlp_xmit_ts is recorded when the probe goes out, and
rxrpc_tlp_send_probe() arms the RTO using the rxrpc_get_rto_backoff()
value in effect at that time. Here, though, lost_at is rebuilt from
whatever backoff and rto_us are current when the timer fires.

In between, rxrpc_resend() can call rxrpc_get_rto_backoff(call, true)
and bump call->backoff. For example, an ACK for an earlier serial can
let RACK mark an earlier segment lost, and rxrpc_input_call_event()
then resends it. A new RTT sample can also raise call->rto_us.
Neither of these moves call->rack_timo_at.

When the RTO fires, rxrpc_rack_timer_expired() turns the RACK timer
off and runs rxrpc_congestion_timeout() and
rxrpc_rack_mark_losses_on_rto() before calling this function. If the
backoff has doubled, lost_at is roughly tlp_xmit_ts plus twice the
original RTO. Now is still before it, so the function returns without
calling rxrpc_tlp_end_probe().

call->tlp_serial then stays set, so rxrpc_tlp_send_probe() keeps
taking the busy path and no new probe can be sent. If the probe
retransmitted an already soft-ACKed segment, tlp_in_flight stays set
too and tx_in_flight remains one too high.

If the RTO is re-armed, the losses it marks lead to another
rxrpc_resend(). That raises the backoff again, so the next check can
fail the same way. The probe is only cleaned up once an ACK happens
to cover it.

Would it be safer to fix the probe's loss deadline when the probe is
sent, using the RTO in effect then, instead of recomputing it here
from the current backoff?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
