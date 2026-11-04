Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800838;
	b=GY0LakL4KeZynJEsamA8LchU4V4zNNqZ9LoluCH7WBQyGhYC5/Ljk5nhbtSjUfd7ooob
	 o8i0r57/fKFanfLjjHzR4emi6Y7tSw+e1yU1vgycv5vhKzYVu0wgxrOUYvZKROLdY5noa
	 jCkAabhBGdqfRKeWtdSqAHPN0gwfmDOY31ygj7JJ71XqGRBSzuannpUe5aruf58sh9sOQ
	 rDq7mNyqWeLElBM/pEgKYLThnTpqXmc9p7KdX4BMkXz7SHVWDUsXCtAkyP0CfD/QztbJ9
	 C8RyPZEyqrstxk+ltvXvJOuNvgsSZ1y2ARhLaimHVHgrdP8iUJ2e/KC1ePZ9H1qyTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800838;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jHf3Xpco4UtrYw/n950IRJNyaPDQngxGO8tXn67B/bo=;
	b=d6n1TT1S+LG9L+ZbTdk9OXxSMUq5m2qhxhqxgHOzckvvVEX8U4i/X/zjqLC1BZEnaHhe
	 L9nD/+hkKuGoIyeTLrYyW2uUusZ1ydNi0OxkHUQqANnR/0SurHLR/ONmVFkjAzVakKHLk
	 9Y4sKpxVgLmfZiUyUeg8OWodtydYaDcw338QuEbD2NnheonD9JoAAkd2o3Hjr6rGrlQt8
	 s7fFYxALpW+JEP0pKSad/5grtcdzrsBik/K24MNjCVzTBMcjBOuQ59fDh6ErGfib3W7Fp
	 CXSAEQumxKry43U0MUNWoDgd/NhJJi87p5OEZ+g9QldHWbJvVp3Z1U+g9BJoSd0jGyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBIlYe9W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA38606A33A;
	Wed,  4 Nov 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBIlYe9W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD60A1F00A15;
	Wed,  4 Nov 2026 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800837;
	bh=jHf3Xpco4UtrYw/n950IRJNyaPDQngxGO8tXn67B/bo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UBIlYe9WZW6WQSRq1tDbj4Cux0iiG7SHjnWHYVL3hXXP52fWc1mzzbXKEArcwp64b
	 5YfnqSQj2ST7eiBG9d4m1Q/wdBApJDwWazd8ICozy5gxcv8JvFNMtJ+kz2DwZjYy7r
	 3TzARF4+lhysG1efYZiEhVZuLuRUBn5FhcB/eX/tM6U4X018A5RfuPxoDuGmamn2HH
	 tWAYmofCZdTf4R5cDWO6XjRMW21z8BLETkPV1j/cUb0IJYXweo5bfUt5Kx7ZbpFgLX
	 ZsFYDdZ5PfB7NIBvcet9Z9QtHrGx3pq6psP1HSSADzDPL0/aMhKV04EHdm9ktA9Z3g
	 dvsF//hyFTm4g==
Subject: Re: [PATCH net v3 1/2] net: gro: do not undo remote checksum offload
 on merged packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 tom@herbertland.com, cenzhang@linux.microsoft.com,
 AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org,
 tsgatesv@gmail.com
Date: Wed, 04 Nov 2026 14:00:36 +0000
Message-ID: <179380083642.488856.12336059973220391773@kernel.org>
In-Reply-To: <20261103105752.49542-2-edumazet@kernel.org>
References: <20261103105752.49542-2-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] For VXLAN, the new fraglist branch in skb_gro_remcsum_cleanup()
  (include/net/gro.h) breaks inner checksums when the VXLAN packet is…

--

net: gro: do not undo remote checksum offload on merged packets

This patch changes skb_gro_remcsum_cleanup() so it no longer undoes the
remote checksum adjustment on packets that GRO merged. Fraglist members
are the exception: their original inner checksum is restored in the
headers pulled by skb_gro_receive_list(). The goal is to avoid stray
writes into payload, or into a freed frag0 page.

> diff --git a/include/net/gro.h b/include/net/gro.h
> index 2300b6da05b27..13a8ef217a1d7 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -354,6 +354,23 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
>  	if (!grc->delta)
>  		return;
>  
> +	if (NAPI_GRO_CB(skb)->same_flow) {
> +		/* skb_segment_list() keeps the inner headers of fraglist
> +		 * members: restore their checksum. skb_gro_receive_list()
> +		 * pulled these headers, then moved skb->data past them.
> +		 * A valid remote checksum offset points to the inner
> +		 * transport header, which is part of these headers.
> +		 * Headers of other merged skbs are not used anymore.
> +		 */
> +		if (NAPI_GRO_CB(skb)->is_flist &&
> +		    grc->offset + sizeof(u16) <= skb_gro_offset(skb))
> +			remcsum_unadjust((__sum16 *)(skb->data -
> +						     skb_gro_offset(skb) +
> +						     grc->offset),
> +					 grc->delta);

[Severity: High]
Restoring the sender's checksum on fraglist members is correct when the
outer VXLAN packet is forwarded unchanged. Is it also correct when the
packet is decapsulated locally by VXLAN?

The VXLAN socket accepts fraglist GSO packets:

drivers/net/vxlan/vxlan_core.c:vxlan_create_sock() {
    ...
	udp_allow_gso(sock->sk);
	return sock->sk;
}

Because of this, udp_unexpected_gso() returns false for the
UDP_TUNNEL|FRAGLIST|TCPV4 aggregate. udp_queue_rcv_skb() then passes the
whole aggregate to vxlan_rcv() without segmenting it.

The decap side then adjusts the checksum only once, through a pointer
into the head skb's linear data:

drivers/net/vxlan/vxlan_core.c:vxlan_remcsum() {
    ...
	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
    ...
}

include/linux/skbuff.h:skb_remcsum_process() {
    ...
	delta = remcsum_adjust(ptr, skb->csum, start, offset);
    ...
}

Nothing walks skb_shinfo(skb)->frag_list. So after this patch, each
fraglist member keeps the restored sender checksum, which is not a valid
final checksum under RCO.

iptunnel_pull_offloads() removes only the encap GSO bits, which leaves
SKB_GSO_FRAGLIST|SKB_GSO_TCPV4. Suppose the decapsulated inner packet is
then bridged or routed out a device without FRAGLIST support. In that
case skb_segment_list() reuses each member's own inner TCP/UDP header.
__tcpv4_gso_segment_list_csum() also leaves the checksum alone when the
addresses and ports match:

net/ipv4/tcp_offload.c:__tcpv4_gso_segment_list_csum() {
    ...
	if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
	    iph->daddr == iph2->daddr && iph->saddr == iph2->saddr)
		return segs;
    ...
}

Would every segment except the head then leave with an invalid inner L4
checksum? This path needs:

- a remote sender setting VXLAN_HF_RCO
- REMCSUM_RX and REMCSUM_NOPARTIAL on the VXLAN device
- rx-gro-list on the lower device
- no local socket for the inner flow, so is_flist gets set

Before this patch, with frag0-based drivers, the member's linear header
kept the adjusted checksum, which is valid for this path. The stray write
went to the stale frag0 page instead. The commit message does not mention
the local decap case.

GUE does not seem to be affected. FOU/GUE sockets do not call
udp_allow_gso(), so the aggregate is segmented before gue_remcsum() runs
on each segment. The follow-up patch "net: gro: invalidate frag0 after a
pull" does not change this logic either.

Could fraglist GRO be refused or flushed once a NOPARTIAL remote
checksum adjustment has been made? Alternatively, could the VXLAN decap
path adjust the frag_list members too?

> +		return;
> +	}
> +
>  	ptr = skb_gro_header(skb, plen, grc->offset);
>  	if (!ptr)
>  		return;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103105752.49542-1-edumazet%40kernel.org
