Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624416;
	b=h16yq/Xw5k3EgH9J/V34eiZ5pLd1SAHeMR4K7Yy/G9032Vf2Rms2g640FFTSSS0mnLpl
	 ewzC5LdsfNx1/SVIkbWvuH4XcdLKY/pO3bi7BFbulCrBUpJMkIkF7gUYcUAIzChYTxmrH
	 P77504TwBceBh83daXe2M7rq1iMCa+zkEXx+uLMvWk1Rv7NmDGMmUGNY97BtvxHQTB8ji
	 MjlGZeKpP1kVhMR1tSg/B/sBLQVNoc3lZgaI0jHipaV1MXRH5v1p3a2MoVh+ZXU4/9iPc
	 JYwuUm/ZajrAeCsEAqo/hMLclis0j1ll+QM59u/XAUjCKtrbYhRw04xeBq9AJJbe/Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624416;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/z8A8FiI3Y74g57CyXo8FDKptY16TKYdsUYglXNCiV0=;
	b=5OWrg2KdiYNBjz49UAw1oXexrCxlCSJdfeOkquXkUZR+iM+bJG9hYkdJU9LOLps/FmNQ
	 OL0PGJvbBRdO3Opx6V17mkWr9z0CjXefj3IVvApTV+r7vJmm29XhVsOJNQpmHimM5zfLp
	 sJYaJFbY1sNyAAPEZxKblEBoaulbQ/hKyDHhqYrzrkboGYYHs6kW0xcxCme3Djjpvodnq
	 rEXXyX9ywna44zM7JtH/UfU38LaJzzsbAr/o4F3II2t+7ASAT2WDkwFRXn/OvBIEp7JX4
	 j5Pb5gQVw1M/GlRgPNfGIHnQDxCUiT9fD2wRWOqUUTTw3TF4MEVnwQ+OJ4Nsr6d4h1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT0SSbgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5BB606A32E;
	Mon,  2 Nov 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT0SSbgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA641F00A16;
	Mon,  2 Nov 2026 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624416;
	bh=/z8A8FiI3Y74g57CyXo8FDKptY16TKYdsUYglXNCiV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CT0SSbgv0QAAS4I/bInaHUIlr3Q7JWQk5kjcUS7DFtAMyy+ZzdvEbsWpDxAp+wUjo
	 GY+D94F9ewWkb5cSIVojMpKz66fUUZqbVs5VLzZ7gSz38FKAzLqSUeUnD+QJC5Z9/9
	 S2dSaT4K7dIWpM1o32+ffPLsUAK8p7/2rxzIK/bsG6lrUuJg3piDMFPPfZm8jNoQ4+
	 qQfAO4ZHJQRhKPd1QZiDJplL1hKDQ4v1IOQ9ZpeuZhplpc6q8wDVA/yWqUD9pwGhWQ
	 BjcA8IuslP5RiPr0mZTYDQPRu75ZMXWdQM4bUjV8rqv6z2qA9H041+oOKA5+pFlLFr
	 kyMn8Bru7CPTg==
Subject: Re: [PATCH net v2 1/2] net: gro: do not undo remote checksum offload
 on merged packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 tom@herbertland.com, cenzhang@linux.microsoft.com,
 AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:00:14 +0000
Message-ID: <179362441482.3131.6727826907455197680@kernel.org>
In-Reply-To: <20261030125955.3107383-2-edumazet@kernel.org>
References: <20261030125955.3107383-2-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that skipping
  skb_gro_remcsum_cleanup() for merged skbs is correct, and that…

Pre-existing issues:
- [Critical] At this commit, skb_gro_remcsum_cleanup() can still write
  through a stale NAPI_GRO_CB(skb)->frag0 when a fraglist handler has…

--

net: gro: do not undo remote checksum offload on merged packets

With this patch, skb_gro_remcsum_cleanup() returns early when
NAPI_GRO_CB(skb)->same_flow is set. A merged skb therefore no longer has
its remote checksum offload adjustment undone. Once an skb has been
merged, grc->offset does not point at the original header any more. The
2-byte write could then land in payload or, with fraglist GRO, in a page
the skb no longer references.

> diff --git a/include/net/gro.h b/include/net/gro.h
> index 2300b6da05b27..00b49b6b9e74f 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -351,7 +351,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
>  	void *ptr;
>  	size_t plen = grc->offset + sizeof(u16);
>  
> -	if (!grc->delta)
> +	/* Once merged, grc->offset can not be trusted: the frags or head
> +	 * of this skb now belong to the GRO packet, or skb->data was pulled
> +	 * past the headers before adding it to a frag_list.
> +	 * Fraglist members keep their adjusted inner checksum, which is the
> +	 * value skb_remcsum_process() would have written.
> +	 */
> +	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
>  		return;

[Severity: Medium]
The new comment says fraglist members keep "the value
skb_remcsum_process() would have written". The commit message says
the same thing:

  grc->delta is only set with VXLAN_F_REMCSUM_NOPARTIAL, where
  skb_remcsum_process() writes the same adjusted checksum in the non
  GRO path. Keeping it is the intended result.

Is that still true when skb_segment_list() segments the fraglist train
before any remote checksum processing runs?

Two paths seem to do this.

The first is a transit VXLAN or GUE train that was aggregated because a
wildcard-bound local tunnel socket matched in udp4_gro_lookup_skb(), and
is then forwarded. 26c4f7da3e41, the commit named in Fixes:, was written
for this case: GRO must not change a packet that may be forwarded.

The second is GUE local delivery. fou sockets never call
udp_allow_gso(), so udp_unexpected_gso() returns true for fraglist
packets:

include/linux/udp.h:udp_unexpected_gso() {
    ...
	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST &&
	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
		return true;
    ...
}

As a result, udp_queue_rcv_skb() segments the train before
gue_udp_recv() runs.

In both cases, skb_segment_list() copies the head's outer and tunnel
headers onto every member, including the RCO flag and start/offset.
__copy_skb_header() also copies the head's remcsum_offload bit, which
skb_gro_flush_final_remcsum() has cleared. That means the check below no
longer stops the adjustment from running a second time:

net/ipv4/fou_core.c:gue_remcsum() {
    ...
	if (skb->remcsum_offload)
		return guehdr;
    ...
}

vxlan_remcsum() on a remote VTEP has the same check. If remcsum_adjust()
runs on a field that already holds the final checksum, won't it produce
the pseudo-header sum instead? Every member except the head would then
carry a bad inner checksum. This requires rx-gro-list enabled on the
ingress device and a NOPARTIAL remote checksum offload flow.

This patch did not introduce the wrong member checksum. The old cleanup
never restored the members either; it wrote into the payload or a stale
frag0 page instead.

Could the comment and the commit message qualify the claim that keeping
the adjusted value is correct? The member headers still appear to be in
the linear headroom after skb_pull(), so they could be restored.

Also, GUE sets grc->delta as well:

net/ipv4/fou_core.c:gue_gro_receive() {
    ...
			guehdr = gue_gro_remcsum(skb, off, guehdr,
						 data + doffset, hdrlen, &grc,
						 !!(fou->flags &
						    FOU_F_REMCSUM_NOPARTIAL));
    ...
}

So is "only set with VXLAN_F_REMCSUM_NOPARTIAL" accurate, or should it
mention FOU_F_REMCSUM_NOPARTIAL too?

>  
>  	ptr = skb_gro_header(skb, plen, grc->offset);

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch. At
this commit, the non-merged case can still write through a stale frag0.
In udp_gro_receive_segment():

net/ipv4/udp_offload.c:udp_gro_receive_segment() {
    ...
	if (NAPI_GRO_CB(skb)->is_flist) {
		if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
			NAPI_GRO_CB(skb)->flush = 1;
			return NULL;
		}
		if ((skb->ip_summed != p->ip_summed) ||
		    (skb->csum_level != p->csum_level)) {
			NAPI_GRO_CB(skb)->flush = 1;
			return NULL;
		}
    ...
}

pskb_may_pull() can release a header-only frags[0] through
__pskb_pull_tail()->skb_frag_unref() without updating frag0 or
frag0_len.

The function can then return NULL on the ip_summed/csum_level mismatch,
or skb_gro_receive_list() can fail after its own pull. In either case
same_flow stays 0, so the new check does not apply.

With the stale frag0_len, skb_gro_header() takes the fast path. Can
remcsum_unadjust() then do a 2-byte read-modify-write into a page the
skb no longer holds a reference on? With page_pool, that page may
already have been recycled into another RX buffer.

The commit message says this case is handled in the following patch.
"net: gro: invalidate frag0 after a pull" appears to add
skb_gro_frag0_invalidate() in three places: before the pskb_may_pull()
calls in udp_gro_receive_segment() and skb_gro_receive_list(), and in
skb_gro_header_slow(). Once that patch is applied, cleanup on a
non-merged skb takes the slow path and writes at
skb->data + grc->offset.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030125955.3107383-1-edumazet%40kernel.org
