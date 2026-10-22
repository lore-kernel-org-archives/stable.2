Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627205;
	b=iAaVk/T8e/IZzaCTQ+kKDGf6HF+KgK+7h8avqQ/NoKMRmwdah/FdXKQf5/A//X95Yo16
	 WrxD6dCvgkkUEuVWot77xosm2JP8ILbL4dit1/9BS88IUAVJNdmtNSV89Jywjo06hleBq
	 jdsDSvyY6Tk0m+pnsuTBZMFfEu9oJ8t5IDh5a4NoL2AASLcGUrjwR37cMbhXZXVYS4IiP
	 tIpnTm8Fm8diAHKakmRlwptoWTlZxsd18AUjFuZVsHzND/fZNmGoey17Jb2sYEo8SBbaO
	 gr0vJMhSpjsuIZ/ZVTd14Q41cj68htbrFZ1ItE1ipodkrFv/xhuwRzMzbaQ8MwzUK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627205;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JO8WSYwh8X7CHIjRO3ANQ9WJ5moVS4xf88mKtUCefLc=;
	b=5OjL+vZHzb+1y5YFJOfQc4NxEiqpTHfa5hr/mCtmaLrXgT2w1844kZQiPsdTUZowsC7R
	 WMhJ9zlYgHS0j5YGcwWU6uW/AhvPGr4CuypK4S3iaXTHebZmEC7PqzAnW5J44WZTi87Ce
	 NEp5tBlP5Lc9W1DkCQSeGu3yAtQ3j1kkUttr+dzLsFNgTmr1u8dBeePHKFs+2HyEl4LAe
	 Wb6CM4evOQNK1C3H4k48RAMe5cId+4D/AM4NwkTTEN+kPUtKnAH1dr57ecLQROr/0OEwM
	 nKdFw9pvLmJynFW9yYMaOBH3oHA7R4ytU6q5hUXNhyiavKAYEaSjJt7z9xvU4ChnrUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEcnaMjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D6606A31B;
	Thu, 22 Oct 2026 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEcnaMjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E51F000C2;
	Thu, 22 Oct 2026 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627204;
	bh=JO8WSYwh8X7CHIjRO3ANQ9WJ5moVS4xf88mKtUCefLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fEcnaMjDwKexYj5Jm6e+GCj1ZTHqEyvjKPt4zJPmHMlcBmP1ccHV6viP6S6Nv6/Mo
	 iBz3XyLZ0BhurYK5zsLkjd+FgQd8EYpTaS98arjYgL4+csp0xiWzLUAzKJ5BEHlCk0
	 /TvIx4e8UWQnJZDPFVhwPP3hzIL9xAVB9+ys7lDQht7Ivj+4z4camObRjAE5UtgWiO
	 qcGWBU+B2XkW5yqnOg6AuQjwEK9xOEzd/1q7T1TEp9z87iuWK06ggDWnHCn6ZvTWZh
	 1eIDwx2b22U0Wvv1kDvevyqHlyHTISq8MPKcssegTbJPQEj9B8ab28pI3mO7c8Cxhs
	 6o2av2jvB1okA==
Subject:
 Re: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted packets
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 00:00:02 +0000
Message-ID: <179262720290.3135.1509720869529893686@kernel.org>
In-Reply-To: <20261020201258.290827-3-dhowells@redhat.com>
References: <20261020201258.290827-3-dhowells@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete in-flight accounting: if a segment that is already
  soft-ACKed gets retransmitted, its tq->in_flight bit is set again and…
- [Medium] Behaviour change on soft-ACK reneging (ACK->NAK flip).

Pre-existing issues:
- [Low] In rxrpc_tlp_send_probe(), the retransmit branch
  (rxrpc_resend_tlp()) does not re-read call->tx_in_flight, so the `if…

--

rxrpc: Fix counting of in-flight transmitted packets

RACK-TLP used a FlightSize value derived from several counters. This
commit replaces it with a direct count: each txqueue gets an in_flight
bitmap, which is set on transmission and cleared on ACK or loss, and
call->tx_in_flight counts the set bits. The tx_nr_sent and tx_nr_resent
counters are removed and the rxrpc_rack tracepoint is updated.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index 072e1d9ecb2ec..e43ce032a2618 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c

[ ... ]

> @@ -136,6 +137,8 @@ void rxrpc_input_rack(struct rxrpc_call *call,
>  		unsigned int ix = __ffs(new_acks);
>  
>  		__clear_bit(ix, &new_acks);
> +		if (__test_and_clear_bit(ix, &tq->in_flight))
> +			call->tx_in_flight--;
>  		rxrpc_input_rack_one(call, summary, tq, ix);
>  	}
>  

[Severity: Medium]
What happens to a segment whose soft ACK is later reneged? The in_flight
bit is cleared here when the segment is first soft-ACKed. The ACK->NAK
flip path in rxrpc_input_soft_ack_tq() only adjusts the SACK counters:

net/rxrpc/input.c:rxrpc_input_soft_ack_tq() {
    ...
	flipped = (tq->segment_acked ^ extracted_acks) & old_reported;
	if (flipped) {
		n_to_a = ~tq->segment_acked & flipped; /* Old NAK -> ACK */
		a_to_n =  tq->segment_acked & flipped; /* Old ACK -> NAK */
		...
		call->acks_nr_sacks	+= a - n;
		call->acks_nr_snacks	+= n - a;
    ...
}

Under the old formula, the drop in acks_nr_sacks put the reneged packet
back into FlightSize. Now only rxrpc_prepare_data_packet() sets
tq->in_flight. So until RACK marks the reneged segment lost and it is
retransmitted, it counts as neither acked, lost nor in flight.

In the same ACK, rxrpc_congestion_management() reads call->tx_in_flight
for cong_ssthresh before RACK loss detection runs. The segment may not be
marked lost straight away, for example if it was the most recently
delivered segment or the reorder window delays it. In that case the
undercount also reaches rxrpc_tlp_calc_pto(), the in_flight != 0 RTO
decision in rxrpc_tlp_send_probe(), and the tx_in_flight > 0 RTO-rearm
check added by the later commit "rxrpc: Fix RACK-TLP implementation".

Should the a_to_n case set the in_flight bit again and increment
tx_in_flight?

[ ... ]

> @@ -313,7 +316,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
>   */
>  void rxrpc_tlp_send_probe(struct rxrpc_call *call)
>  {
> -	unsigned int in_flight = rxrpc_tx_in_flight(call);
> +	unsigned int in_flight = call->tx_in_flight;
>  
>  	if (after_eq(call->acks_hard_ack, call->tx_transmitted))
>  		return; /* Everything we transmitted has been acked. */
> @@ -333,7 +336,7 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
>  			call->tlp_serial = call->tx_last_serial;
>  			call->tlp_seq = call->tx_transmitted;
>  			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_transmit_new);
> -			in_flight = rxrpc_tx_in_flight(call);
> +			in_flight = call->tx_in_flight;
>  		} else {
>  			/* Retransmit the highest-sequence DATA sent */
>  			call->tx_last_serial = 0;

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The
new-data branch re-reads in_flight, but the retransmit branch does not
re-read it after rxrpc_resend_tlp(). So the later check:

	if (in_flight != 0) {
		...
		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;

uses the value from before the probe was sent. If the flight size was 0
before the probe, could a TLP retransmit leave no RTO armed? The old code
took its snapshot in the same order.

The later commit "rxrpc: Fix RACK-TLP implementation" seems to cover the
stall. At the end of rxrpc_input_call_event() it arms the RTO when
rack_timer_mode is RXRPC_CALL_RACKTIMER_OFF and tx_in_flight > 0, so
what remains may only be an inconsistency. Would it be cleaner to re-read
in_flight in both branches?

> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 88cad087f13bf..3ccd9a27643a8 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -571,15 +571,16 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
>  
>  		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
>  
> +		if (!__test_and_set_bit(ix, &tq->in_flight))
> +			call->tx_in_flight++;
> +

[Severity: Medium]
Can this count a segment that is already soft-ACKed as in flight again?

The commit message says:

  (4) Clear a packet's bit when an ACK is received for the packet ...

However, the bit is only cleared in rxrpc_input_rack() for segments in
new_acks. rxrpc_input_soft_ack_tq() builds that mask from newly reported
ACKs and NAK->ACK flips:

	new_acks |= n_to_a;
	if (new_acks)
		rxrpc_input_rack(call, summary, tq, new_acks);

One possible sequence:

1. DATA is sent and rxrpc_prepare_data_packet() arms the TLP PTO timer.

2. The peer soft-ACKs call->tx_transmitted but leaves a hole lower down,
   so acks_hard_ack < tx_transmitted. The hole is marked lost at once, so
   no reorder timer replaces the PTO.

3. The PTO fires. rxrpc_tlp_send_probe() passes the
   after_eq(acks_hard_ack, tx_transmitted) check. With no unsent data or
   no window space it calls rxrpc_resend_tlp(), which retransmits
   seq == call->tx_transmitted without checking tq->segment_acked.

4. rxrpc_prepare_data_packet() sets the in_flight bit again and
   increments call->tx_in_flight.

5. Later ACKs keep reporting the segment as ACKed. It is in old_reported
   and does not flip, so it never reaches rxrpc_input_rack(). The bit
   stays set until rxrpc_rotate_tx_window() handles the hard ACK.

Until that hard ACK, tx_in_flight counts a SACKed segment. That value
feeds cong_ssthresh in rxrpc_congestion_management(), the flight_size
test in rxrpc_tlp_calc_pto(), and the tx_in_flight > 0 RTO-rearm check
added by the later commit "rxrpc: Fix RACK-TLP implementation".

rxrpc_resend() doesn't seem to hit this, because rxrpc_rack_update()
clears segment_lost when a segment is soft-ACKed. The old formula also
overcounted here through tx_nr_resent++.

Since the aim of this patch is exact tracking, should the in_flight set
be skipped when segment_acked is already set? Alternatively, should
in_flight be cleared for every segment reported as ACKed, not only the
newly ACKed ones?

>  		/* Record (re-)transmission for RACK [RFC8985 6.1]. */
>  		if (__test_and_clear_bit(ix, &tq->segment_lost))
>  			call->tx_nr_lost--;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com
