Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774420;
	b=bjNCK3AUB9fFhsykJaX7QLhdRH+26SavGCoHlcUDJ4v+PTOlXvkGtFuKBOcoD4qd3rT2
	 qdD7sjt2AP/00wZ9WSu5oVTYySC0TNU6pPlabHNoKKSDUqEBabyQPEWzSnsmYGWdKAyRo
	 5JzJQ6mAmagEcuF6Dc3Q52s1yadyNOGimVRn1V+cFG14YAHU5Sg0W5DwBMLQWX5V58zDn
	 2qJiNMHzw3TZsoZpv5hLA5KdZ6kCCcNyOpFPEAO9rG5+gi4vuA91LcJkUCxKNHnD9zImF
	 WdL9s4kFZ7uRa3XQyQyo/J5VuPdSe/LHk7maHn9TJ5bQOp8g5oAumpUaWxwzx1ZV4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774420;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=guoy1C++ARIXgbYKAlzD0wHiB3wfAoYXWV+G/twXV8U=;
	b=mbukj3KPH0TmygXiOxGKzbGrorqotWAJhr+Zj9r4VGozisCWe+Dx3kE35My/YAAcmnEJ
	 25eybDJLXwTYZNW2DuTKYyYkwk1N5sTxKOhHyjFndccxbKaXMWinR68oTcmGRNqia2H9w
	 QNuROy7a6IRdLJULyZ13IIkmzA3GbTt5GbwnhRsBS2y9VYZ6Yj7rGQ5NPSRBWBdi1DIW8
	 8370q1InQF0RdGkjwEdTMC8Q02HVAAzrNZMLQztC5ePvN/pLokRsY5B6r4Bz9Kcyl3l/y
	 uaSanofN60c9VVbOxrpQ0rUM6Zi/GyL+NdHSrnqcQOPuvAAK3O7cCF6nFT8DzyHzl9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNI7gdW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17D60A261E;
	Fri, 27 Nov 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNI7gdW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A531F00923;
	Fri, 27 Nov 2026 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774420;
	bh=guoy1C++ARIXgbYKAlzD0wHiB3wfAoYXWV+G/twXV8U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JNI7gdW3fwbmkhuSsdhnVa0GwXGiM1V8fCzxV5GPMkTmj2KhhmvoO3LMqaLIF4B8G
	 dvYcCc1yKtDMm+SDrYRUV/bP3/r3KPnLFBosfvvf2o/1RIEifvZRNZJa5InTxgIlQT
	 /kfT0DgjuejeHfiZELJsgUcaw0UBlXF63EXPIzhv+Ti2XR8ay/yWxS6Ish2rWa2iB/
	 NNml7LwiCqQAQr0da1RwQg8gT3bQR6SwJTKSHaW8n2YN4mQV5WPybLlgGRG98Q/uiZ
	 4kQ0kMwYFlaz81vjIwEubG9Qkfcb+WL2Ce3N45AtglTdFzZMq2KgqPDjfeGbqDGCVh
	 z9b+o/C8Kpisg==
Subject: Re: [PATCH net v3 08/10] rxrpc: Fix detection of TLP probe response
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:39 +0000
Message-ID: <179577441933.3135.16643898652433850053@kernel.org>
In-Reply-To: <20261124161302.4044422-9-dhowells@redhat.com>
References: <20261124161302.4044422-9-dhowells@redhat.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The probe-completion test in rxrpc_input_ack(), `if
  (after_eq(summary.acked_serial, call->tlp_serial)) call->tlp_serial =…
- [Low] The first paragraph of the commit message says the patch fixes a
  bug: without a ->tlp_serial check, an ACK of a packet matching a stale…

--

rxrpc: Fix detection of TLP probe response

This commit adds a ->tlp_serial check before setting
summary->tlp_probe_acked in rxrpc_rotate_tx_window(), and moves the
->tlp_serial check out of rxrpc_tlp_process_ack() into its caller. It also
makes rxrpc_input_ack() check for a TLP probe response on ACKs that
rxrpc_is_ack_valid() discards as out of order or duplicate.

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 63a0feae2081d..d01a8d95dc6db 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -275,7 +275,8 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
>  			/* Packet directly hard ACK'd. */
>  			tq->nr_reported_acks++;
>  			rxrpc_input_rack_one(call, summary, tq, ix);
> -			if (seq == call->tlp_seq)
> +			if (call->tlp_serial &&
> +			    seq == call->tlp_seq)
>  				summary->tlp_probe_acked = true;

[Severity: Low]

The commit message says:

  Fix detection of the TLP probe response to include a check that
  ->tlp_serial is valid, otherwise it's possible to see an ACK of a packet
  that matches an old value of ->tlp_seq as a probe response.

Does this part of the patch change behaviour at this commit?

Only rxrpc_tlp_process_ack() reads summary->tlp_probe_acked. Before this
patch, that function already returned early when no probe was
outstanding:

    if (!call->tlp_serial || after(call->tlp_seq, call->acks_hard_ack))
        return;

Within one rxrpc_input_ack() call, call->tlp_serial can't go from zero to
non-zero between the rotation and rxrpc_tlp_process_ack(). Only
rxrpc_tlp_send_probe() and rxrpc_prepare_data_packet() set it, and both
run from the rack timer path. The summary is local to each ACK, and no
tracepoint records tlp_probe_acked.

So a stale tlp_probe_acked was already being ignored. The new guards here
and in the soft NAK branch look like they only move the existing check
into the callers.

The guard starts to matter with the later commit "rxrpc: Fix counting of
in-flight transmitted packets", which adds rxrpc_tlp_end_probe() to this
block. Could the commit message describe this part as preparation for that
change? Otherwise stable backporters may think they are getting two fixes.

[ ... ]

> @@ -1139,7 +1141,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>  	/* Discard any out-of-order or duplicate ACKs (outside lock). */
>  	if (!rxrpc_is_ack_valid(call, hard_ack, prev_pkt)) {
>  		trace_rxrpc_rx_discard_ack(call, summary.ack_serial, hard_ack, prev_pkt);
> -		goto send_response; /* Still respond if requested. */
> +		goto check_for_tlp_probe; /* Still respond if requested. */
>  	}
>  
>  	trailer.maxMTU = 0;
> @@ -1217,9 +1219,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>  	 */
>  	rxrpc_congestion_management(call, &summary);
>  	rxrpc_rack_detect_loss_and_arm_timer(call, &summary);
> -	rxrpc_tlp_process_ack(call, &summary);
> -	if (call->tlp_serial && after_eq(summary.acked_serial, call->tlp_serial))
> -		call->tlp_serial = 0;
> +
> +check_for_tlp_probe:
> +	if (call->tlp_serial) {
> +		/* Need to check to see if the ACK is a TLP probe response,
> +		 * even if the ACKs may have come out of order.
> +		 */
> +		rxrpc_tlp_process_ack(call, &summary);
> +		if (after_eq(summary.acked_serial, call->tlp_serial))
> +			call->tlp_serial = 0;
                    ^^^^

[Severity: Medium]

Can this end an outstanding TLP probe because of an ACK that doesn't
respond to any packet?

An acked_serial of 0 means the ACK wasn't sent in reply to a particular
packet. Elsewhere, rxrpc_input_ack() checks if (summary.acked_serial)
before it uses the value, but after_eq() here treats 0 as a normal serial.

rxrpc_get_next_serial() hands out connection serials starting at 1 and
skips only 0:

    serial = conn->tx_serial;
    if (serial == 0)
        serial = 1;
    conn->tx_serial = serial + 1;

After a long-lived connection has used more than 2^31 serials, tlp_serial
will be above 0x80000000. At that point after_eq(0, tlp_serial) is true,
and any ACK with acked_serial == 0 clears tlp_serial.

Linux peers send these ACKs routinely. For example,
rxrpc_input_call_event() does:

    rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
                   rxrpc_propose_ack_delayed_ack);

and it sends IDLE and PING ACKs with serial 0 as well.

The in-order ACK path had this problem before this patch. The new goto
check_for_tlp_probe on the rxrpc_is_ack_valid() failure path means that
discarded out-of-order and duplicate ACKs, including serial-0 ones, now
reach the same comparison.

If tlp_serial is cleared early, a later ACK that really covers tlp_seq
fails the call->tlp_serial tests in rxrpc_rotate_tx_window(). It also
skips rxrpc_tlp_process_ack(), so the RFC 8985 section 7.4 handling never
runs. rxrpc_tlp_send_probe() only checks !call->tlp_serial, so it can send
another probe on the next PTO.

The problem is still there at the end of the series. After the later
commit "rxrpc: Fix counting of in-flight transmitted packets", this line
calls rxrpc_tlp_end_probe(). That also clears tlp_in_flight and
decrements tx_in_flight while the probe packet is still unacknowledged.

Would requiring a non-zero acked_serial here help, something like:

    if (summary.acked_serial &&
        after_eq(summary.acked_serial, call->tlp_serial))

> +	}
>  
>  send_response:
>  	if (summary.ack_reason == RXRPC_ACK_PING)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
