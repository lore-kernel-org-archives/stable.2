Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774414;
	b=xO0Wlmr4/a1CZ5BzejllTQY07Mkx4ES26zy87YW2+oq+RGQb8KyVE7O/edPscyMzfRe5
	 Phk5DhH96OXK2CoFW1uH5jXCP2Rr/7pvLLIh9JKBZtOC23gow7gm72RsKtV5GquoNtcxO
	 3FLqFSQqJGLj9ijIsK0O59cFRucwU6DJpI6Ysq3Psku6iB8e289oXiuxELfX+hpcglrGe
	 QVtZOqDsU+qqp7QazWV0mCq5lTl0CjkXkdOpg1hHOCF5dEOFFpqhNobKFq2GDAUHlHye5
	 YOThfEdyfllfOccJYYFT2NX15ryLVxGnZG7oiGgGMnHESfELZqfD6YSUueXhI5xELeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774414;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J/+o2ghf5ux5aaFdaB9WRcYKAyPeVbgRfcIWmS+cA/g=;
	b=PGsjRjH4QOR6GKR/tA9tj6esaZquRIuxjo6XmPyi5t48fL8ZSZXBLMo+whK3y8fdJ3Rf
	 rC7lpq4e+909T4S0vNeFU/XDu/45Vv7xBdA+XHoNI/uuwon93cD3nw18RbBAZk3jpSu2B
	 1ZhHQL1AzalZ8xkaE12RtEcwgV5BSbxIipVw1FGeu1dRAWFu/db1jZqGAeM7OOqGrzVE8
	 hT9/6XHJppud/u8Y9rCsE92g49M86HVHY28OCnEusoBN3/+VljGlHEEwdWlaW35KBRfru
	 tF+Wg4DlK7/nJD3/CsdmsMWGbBkAfVvc7/EfIRTWZEuHtwodUAhF97IialDoQEdcOyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnccmdQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CA606A32A;
	Fri, 27 Nov 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnccmdQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D2F1F0089B;
	Fri, 27 Nov 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774413;
	bh=J/+o2ghf5ux5aaFdaB9WRcYKAyPeVbgRfcIWmS+cA/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fnccmdQ7V/FSkhqT9PaZZFHTrl72cNElYg8Bf9xCEPIgJR6G5n3I2BV+rg3ocOsun
	 iLbXtIxNjYcezCCyc1AKeTIHlJFLHnBk4LjvdWPETg5N23TUoW+1v9KpC0gRkkzERr
	 DYuf+uaGHEsABabgDEuV0JNlvL726zvImCDTKN1tu8ZiBbMZZ62r9T9TlDb+9tbBWN
	 VO/mH6eAT21bIy+vLXOqvmFyyYwDTnuydgaiK44MSuvJrWJHOwCJNe7qlByyZyGKEW
	 v2D6+4eIiQjMWRFLsacxlvfmR2zlu/s8BINaLyWK8ZSb1wx+gGyMXSZKyF3r0xrOox
	 YpORAVWPc9Pzw==
Subject: Re: [PATCH net v3 04/10] rxrpc: Fix ack parsing to mark reneged ACKs
 as lost for RACK-TLP
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:32 +0000
Message-ID: <179577441282.3135.1227787769894655291@kernel.org>
In-Reply-To: <20261124161302.4044422-5-dhowells@redhat.com>
References: <20261124161302.4044422-5-dhowells@redhat.com>
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

- [High] The fix only finds reneged ACKs in txqueues that
  rxrpc_input_soft_ack_tq() is actually called on.
- [Medium] Every ACK->NAK flip in the previously reported range now
  counts as definite loss and is retransmitted at once, with no…
- [Low] The commit message overstates the bug.

--

rxrpc: Fix ack parsing to mark reneged ACKs as lost for RACK-TLP

This patch passes the ACK->NAK flip mask (a_to_n) from
rxrpc_input_soft_ack_tq() into rxrpc_input_rack(). rxrpc_input_rack() now
calls rxrpc_rack_mark_lost() on each reneged packet before it processes
the new ACKs. The aim is for RACK-TLP to pick up packets that the peer
discarded after soft-ACKing them.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com

> If an packet that was ACK'd becomes NAK'd (ie. the peer discarded it), the
> now-missing packet is not picked up by the RACK-TLP implementation.

[Severity: Low]
Is this description accurate?

Before this patch, rxrpc_input_soft_ack_tq() already stored the new bitmap
in tq->segment_acked before RACK ran. After that, rxrpc_input_ack() calls
rxrpc_rack_detect_loss_and_arm_timer().

rxrpc_rack_detect_loss() takes its candidates from rxrpc_tq_nacks(), which
is ~segment_acked masked to nr_reported_acks. A reneged packet inside the
reported range is therefore included:

    unsigned long nacks = rxrpc_tq_nacks(tq);
    ...
    nacks &= ~tq->segment_lost | tq->segment_retransmitted;

rxrpc_rack_update() cleared segment_lost when the packet was first
soft-ACK'd, and segment_xmit_ts still holds the real send time. So
rxrpc_rack_sent_after() returns true for every reneged packet except two
kinds:

  - the RACK.segment itself
  - retransmitted packets whose RACK update was skipped

All the others were marked lost once xmit_ts + rack_rtt + reo_wnd had
passed, or the reorder timer was armed for them.

The real gap looks narrower than the message says. The patch also changes
the policy: reneged packets are now marked lost immediately and
unconditionally, with no reordering window.

Since this is Cc'd to stable, could the commit message say what was
actually being missed, and why skipping the reorder window is intended?

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index bda6e7d77013e..9b02e36264aa4 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -951,8 +951,8 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
>  		rxrpc_input_soft_rtt(call, summary, tq);
>  
>  	new_acks |= n_to_a;
> -	if (new_acks)
> -		rxrpc_input_rack(call, summary, tq, new_acks);
> +	if (new_acks || a_to_n)
> +		rxrpc_input_rack(call, summary, tq, new_acks, a_to_n);

[Severity: High]
Can reneged packets in a txqueue past the end of a shorter SACK table still
be missed?

rxrpc_input_soft_acks() only calls rxrpc_input_soft_ack_tq() for txqueues
that the current nr_acks covers. It calls it once at each full 64-slot
boundary, and once for the tail only when nr != 0:

    if (nr) {
        unsigned int nr_reported = seq & RXRPC_TXQ_MASK;

        extracted >>= RXRPC_NR_TXQUEUE - nr_reported;
        ...
        rxrpc_input_soft_ack_tq(call, summary, tq, extracted, nr_reported,

Consider this sequence:

  - an earlier ACK soft-ACKs packets in txqueue N+1
  - the peer discards them
  - the peer sends an ACK with the same firstPacket whose table ends
    inside txqueue N, or exactly on its boundary

In that case txqueue N+1 is never visited. At runtime, only
rxrpc_input_soft_ack_tq() writes tq->segment_acked and
tq->nr_reported_acks. So the stale ACK bits stay set, a_to_n is never
computed for that txqueue, and the new path in rxrpc_input_rack() never
runs for it.

The existing fallbacks work from the same stale bits, so they skip these
packets too:

    rxrpc_tq_nacks():
        unsigned long nacks = ~tq->segment_acked;

    rxrpc_rack_mark_losses_on_rto():
        unsigned long unacked = ~tq->segment_acked;

As far as I can tell, nothing marks these packets lost until a later ACK's
table reaches that txqueue again, for example after a TLP probe.

This also differs from the case where the table shrinks inside a single
txqueue. There, the tail shift zeroes the dropped slots and they get
marked lost immediately.

The comment in rxrpc_input_soft_acks() says the peer is permitted to drop
soft-acked packets and that the nack count can go down, so this case is
expected.

With the in_flight tracking at the end of this series, these packets are
also removed from tx_in_flight when first soft-ACK'd. If nothing else is in
flight, the tx_in_flight > 0 RTO rearm in rxrpc_input_call_event() won't
fire, so no timer may be left to drive recovery.

>  
>  	if (call->tlp_serial &&
>  	    rxrpc_seq_in_txq(tq, call->tlp_seq) &&
> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index 87084cea88b1a..c4276534f5398 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c
> @@ -130,8 +130,17 @@ void rxrpc_input_rack_one(struct rxrpc_call *call,
>  void rxrpc_input_rack(struct rxrpc_call *call,
>  		      struct rxrpc_ack_summary *summary,
>  		      struct rxrpc_txqueue *tq,
> -		      unsigned long new_acks)
> +		      unsigned long new_acks,
> +		      unsigned long reneged_acks)
>  {
> +	/* Packets that got un-ACK'd get marked lost. */
> +	while (reneged_acks) {
> +		unsigned int ix = __ffs(reneged_acks);
> +
> +		__clear_bit(ix, &reneged_acks);
> +		rxrpc_rack_mark_lost(call, tq, ix);

[Severity: Medium]
Could this mark packets lost that the peer never actually reneged on?

rxrpc_input_soft_ack_tq() computes a_to_n from any flip within
old_reported:

    flipped = (tq->segment_acked ^ extracted_acks) & old_reported;
    if (flipped) {
        n_to_a = ~tq->segment_acked & flipped; /* Old NAK -> ACK */
        a_to_n =  tq->segment_acked & flipped; /* Old ACK -> NAK */

Two cases seem to produce flips that are not reneging.

First, rxrpc_is_ack_valid() accepts an ACK whose firstPacket is unchanged
and whose previousPacket has regressed, as long as it stays within
base + tx_winsize:

    if (after(prev_pkt, base + call->tx_winsize))
        return false;
    return true;

So a stale ACK that was reordered in the network is fully processed.
Packets that a newer ACK had soft-ACK'd then show up in a_to_n.

Second, for the tail txqueue, rxrpc_input_soft_acks() does:

    extracted >>= RXRPC_NR_TXQUEUE - nr_reported;

This zeroes every bit at or above the new nr_reported, but old_reported
still covers the old, larger nr_reported_acks. When a later ACK has a
shorter SACK table, each slot that drops off the end counts as an a_to_n
flip.

Before this patch, in-range flips went through the RACK reorder window
(rack_rtt + reo_wnd). Slots beyond the new nr_reported were masked out by
rxrpc_tq_nacks() and left to the RTO.

Now rxrpc_rack_mark_lost() is called on all of them, which increments
tx_nr_lost and sets segment_xmit_ts to UINT_MAX. rxrpc_input_call_event()
then calls rxrpc_resend(), unless a newer ACK in the same batch reverses
the flip.

This conflicts with the comment above rxrpc_input_soft_acks(), which says
packets beyond the end of the ACK list are left to the timer because the
peer may not have processed them yet.

Is the extra retransmission on reordered or shortened ACKs intended?

> +	}
> +
>  	while (new_acks) {
>  		unsigned int ix = __ffs(new_acks);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
