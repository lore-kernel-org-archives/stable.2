Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774417;
	b=ibTaltsp4B4IgFisMEua6Lx2jKU07U3ga4vqzGpg42Zsq2vuplUyXLNtx5u/QMUmc8cB
	 S3ZsJ+2McUaMvt7f/lUPg0Uf7V1EsnnsppGOpO8DUH3KqtqtYkgTMs0eMiDmlEpmRkGcM
	 i/INeSeoUZeL+2bfrZM0IBwft3XnHbICVumhhd70hOXYe1Mi6ieOZwlTFgePBjXKxcFEd
	 0UWaeQaZnnAKAY02MRRC9vECU+/K5cNpK8DHWZTgQkHoyNjbz17nSDnlxsPPnB+hJx+7T
	 31rAU/RM7Bvmgqx4jSnOLiKW4DnooPHZ2eiFkuqVRItd+IezbLqHloyRV/4zAFQ6pSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774417;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zD42wT85pOHIuUnLPpbuWq+X6OhgyJVnppWQhnqeN1o=;
	b=0/HiT/ue13dxwgWJgYgx3oxvCjlNqsJyUBla6trDxr9KysLhKuyGe3Avl471rcfQHQDS
	 xCUokhSf7NRqdPxpljP7myUzNocQvl/ld0pGLsgidHBej3ZPqv7TlOi1jbMEYgn+qvgDk
	 H8WHh0hODsS2X/Egfauw5ccdaNkx4fJzQNOjpu9ZMy5HrcR5fs8AJb+8mWu94hoscJ7y1
	 GWGLlRG4oUiWLL/WFpKZKdZJmxUx/08jiiyQgpGIAmrREZafCQ1fKroeg5PMA4dXKhk2Y
	 NKIuwUGJo03LMEt19olwqB87XEMaLoKvwb7mxLrBPvc9B/6FQMYUJ4XHwsPSDOp478A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSRXR8WR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA3606A687;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSRXR8WR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB01F00893;
	Fri, 27 Nov 2026 10:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774417;
	bh=zD42wT85pOHIuUnLPpbuWq+X6OhgyJVnppWQhnqeN1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aSRXR8WRW+NYnyrCIwov7IPHcY1gR3tMw/N4zjrWSixiVx6Sno+ozOnMYgxgY2b1N
	 zHOq7PFQeHVXSvBopKFf5asmw1BCvdpqXFgYqcyb/pUsMWo3oT485xT9h3A/rnLv8e
	 mv3NGdf2QrWXyg4Z77/TIAEeCm19xtAejVh02Cl+xerIt3iz+Li0USNkKCLw87wSXB
	 XQUrq2oDaIO/mr3cVlU41F/iNG59ybQgObgMGd/as8w25zDToeaygyaserPNbwKVjX
	 0p2rn5bEEr/9zuWvcu3D4irwOgxONQw3Zv841OPL/t6mjINC7Zjz+yQw9b/Crb6Gkz
	 S4z4DmTiQUPFg==
Subject: Re: [PATCH net v3 06/10] rxrpc: Fix lost driving of congestion
 management retransmission timeout
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:36 +0000
Message-ID: <179577441601.3135.13037869649269792957@kernel.org>
In-Reply-To: <20261124161302.4044422-7-dhowells@redhat.com>
References: <20261124161302.4044422-7-dhowells@redhat.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In rxrpc_rack_timer_expired() (net/rxrpc/input_rack.c), the
  RXRPC_CALL_RACKTIMER_RTO case now calls rxrpc_congestion_timeout()…
- [Medium] The patch makes previously dead RTO congestion code live by
  moving it unchanged into rxrpc_congestion_timeout()…

--

rxrpc: Fix lost driving of congestion management retransmission timeout

This moves the unused RTO congestion code out of
rxrpc_congestion_management() into a new rxrpc_congestion_timeout()
helper. The helper is called from the RXRPC_CALL_RACKTIMER_RTO case of
rxrpc_rack_timer_expired(). RXRPC_CALL_RETRANS_TIMEOUT now only marks
that this happened, for the rxrpc_congest tracepoint.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 9b02e36264aa4..63a0feae2081d 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -199,6 +190,22 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
>  	call->cong_cwnd = umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
>  }
>  
> +/*
> + * Handle congestion being detected by the retransmit timeout.
> + */
> +void rxrpc_congestion_timeout(struct rxrpc_call *call)
> +{
> +	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
> +	call->cong_ssthresh = umax(rxrpc_tx_in_flight(call) / 2, 2);
> +	call->cong_cwnd = 1;
> +	if (call->cong_cwnd >= call->cong_ssthresh &&
> +	    call->cong_ca_state == RXRPC_CA_SLOW_START) {
> +		call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
> +		call->cong_tstamp = call->acks_latest_ts;
> +		call->cong_cumul_acks = 0;
> +	}
> +}

[Severity: Medium]
Can this if block ever run? cong_cwnd has just been set to 1, and
cong_ssthresh is always at least 2, so the condition is always false.
cong_ca_state is left as it was.

At the baseline this code was dead, because RXRPC_CALL_RETRANS_TIMEOUT
was never set. This patch makes it live. After an RTO, though, the call
never moves into slow start, which RFC 5681 requires.

If the RTO fires in RXRPC_CA_CONGEST_AVOIDANCE, cwnd grows back from 1
by at most one packet per srtt:

rxrpc_congestion_management() {
    ...
	case RXRPC_CA_CONGEST_AVOIDANCE:
    ...
		if (call->cong_cumul_acks >= call->cong_cwnd)
			call->cong_cwnd++;
    ...
}

In the usual tail-loss RTO case, the ACKs after the retransmission carry
no soft-NACKs. So the resume_normality path, which would choose
RXRPC_CA_SLOW_START because cwnd < ssthresh, is never taken.

If the RTO fires in RXRPC_CA_FAST_RETRANSMIT, the call stays in
recovery. The next new_low_snack ACK does this, which mostly undoes the
loss window:

			call->cong_cwnd = call->cong_ssthresh;

By contrast, rxrpc_congestion_degrade() sets RXRPC_CA_SLOW_START
explicitly:

	call->cong_ca_state = RXRPC_CA_SLOW_START;

Should rxrpc_congestion_timeout() also set cong_ca_state to
RXRPC_CA_SLOW_START (and reset cong_dup_acks and cong_extra)? The
behaviour is unchanged at the end of the series.

>  /*
>   * Add an RTT sample derived from an ACK'd DATA packet.
>   */
> diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
> index e5288e5beb592..c652451cc9b55 100644
> --- a/net/rxrpc/input_rack.c
> +++ b/net/rxrpc/input_rack.c
> @@ -420,7 +420,7 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
>  		rxrpc_tlp_send_probe(call);
>  		break;
>  	case RXRPC_CALL_RACKTIMER_RTO:
> -		// Might need to poke the congestion algo in some way
> +		rxrpc_congestion_timeout(call);
>  		rxrpc_rack_mark_losses_on_rto(call);
>  		break;

[Severity: Medium]
Should this call be conditional on there being unacked packets? The
commit message describes the lost behaviour as setting the flag:

    when the retransmission timeout expired (and if
    there were unacked packets).

Before 7c482665931b, the call in net/rxrpc/call_event.c was guarded:

	if (unacked)
		rxrpc_congestion_timeout(call);

Here, rxrpc_congestion_timeout() runs on every RTO expiry.

The RTO is only armed in rxrpc_tlp_send_probe(), and only when
rxrpc_tx_in_flight(call) != 0. Could a stale RTO fire with nothing
outstanding, like this?

  1. rxrpc_tlp_send_probe() arms RXRPC_CALL_RACKTIMER_RTO.
  2. An ACK hard-ACKs everything transmitted, but RXRPC_CALL_TX_LAST is
     not set (for example, a MSG_MORE sender waiting on the
     application). rxrpc_end_tx_phase() therefore never cancels the
     timer.
  3. rxrpc_rack_detect_loss_and_arm_timer() only replaces the timer
     when the reorder timeout is non-zero.
  4. No new data is sent before the RTO elapses, and the timer fires.

rxrpc_congestion_timeout() would then set cong_cwnd to 1 and
cong_ssthresh to umax(0 / 2, 2) = 2, even though nothing was lost.

That low ssthresh also outlives the call. rxrpc_disconnect_call() copies
it to the peer:

	call->peer->cong_ssthresh = call->cong_ssthresh;

Later client calls (rxrpc_connect_call() path in conn_client.c) and
service calls (call_accept.c) to the same peer inherit it:

	call->cong_ssthresh = call->peer->cong_ssthresh;

This seems to still be present at the end of the series.
rxrpc_update_rack_rto_timer(), added by "rxrpc: Fix RACK-TLP
implementation", returns early when tx_in_flight == 0 without cancelling
the RTO, and rxrpc_congestion_timeout() still has no guard.

>  	//case RXRPC_CALL_RACKTIMER_ZEROWIN:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
