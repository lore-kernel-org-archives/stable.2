Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671945;
	b=UPK/9HpQH66yiT/4eeaG9/YQygtYMq5iSleNmrx+axdexpqiRty2on/erPdpClx7cdOw
	 vSSXMgEPEA4vAbOWw1W/HtxP1SWKZ/mvCc/JYLVQLiJVrMTzazYXnXpOmH8JiVjQiBQmi
	 zeIxUea4+im57Y63uNqrq5zIvqkqximxT3YVtW+Z0SQUBtYOR0U7WSZGuLY1W2tRFYSH1
	 agvww3p5Kx9aWWYhmtfZzMNjhKHet18AXzEa4wyqPnfq/kLwWa0VH/7lKEC+zfjsgnZK3
	 ir1Mhsr4FFr6UKvsXtuROc1Y8Qb8mvFxox2QnDiqQ4R1uulqYPsKlFIWTJaxuXcbd6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671945;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mJIHOOCaeR8DxzawwcdybWdU2SofhKMdGPqxTT3nh7s=;
	b=NeAoCC9UE7bkrTSqeRQkotWkd4wBU7zuCdeu6/H1aaSbkkg6pdf4heSqaLcXBdd8+UW5
	 1DcHYdDrMtpoNEEpD/4HrfC837RIWxBV8GGkMuIRqIwCbBSY1CvzVtD5HRXqiPyNLC6da
	 ywG9BMJSmPUsPVUD7y5MDBpo3WsnCu80sq+rQFb8QRcqh3bB7YOqCrGpobMYYMlI43hGH
	 jStxGCOc6Ht8RZ9XNTVP76S4MXPSQJTgvPAaM/8cd6/h0PomgTuhzmPxdKGZRVnK7a0nx
	 MUbTC86y2UlUu7StVVUOfjr6CJwE+YvTd2R2HhPlAW3oqNprZXgoWVs+8tP3FUD1gxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCghxmjZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572A606A324;
	Tue,  3 Nov 2026 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCghxmjZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E571F000C1;
	Tue,  3 Nov 2026 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793671945;
	bh=mJIHOOCaeR8DxzawwcdybWdU2SofhKMdGPqxTT3nh7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fCghxmjZaIS/6Bav0uB7t0DBM8WVOLp9UOWUcjRd6sFiF1ES4CVKH84PNftxgkwW+
	 138uC4LtjbFAgkGMZOrhMkFttqXDeEtH6i8HTOWFkmZUMcAI+cMLHyNm5GUWekAQN0
	 1DUEFdGi9ylhKYIU85Py9bj1MhQYtNhLI+K61v+sDdmgc8s9RGAoxMCSqb3DUrYyoS
	 OmYTd27126upapVd2EJunLT1x9PijZu9ypm0oJxbXTRyKWe9Fk/54Q2o4Gq7uDb3mj
	 caAwi3xPkvt6k1ovNTuMHPE3tk4WyAE86RqfuOlxdslB/x9mEaf543DwqPsCXfDy6r
	 4wfC4FvoDejyg==
Subject: Re: [PATCH net v4] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
From: netdev-bot+sashiko@kernel.org
To: treebacker@foxmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@kernel.org, idosch@nvidia.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 02:12:24 +0000
Message-ID: <179367194413.488856.3007925660307195197@kernel.org>
In-Reply-To: <tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505@qq.com>
References: <tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505@qq.com>
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

- [High] ipv6: incomplete xfrm mtu check in __ip6_append_data()
  underflows pagedlen
- [Medium] The new fragmentation predicate in __ip6_append_data()
  (net/ipv6/ip6_output.c:1551-1556) counts non-fragmentable XFRM header…
- [Low] The new block comment in __ip6_append_data()
  (net/ipv6/ip6_output.c, lines ~1543-1549), repeated in the commit…

--

ipv6: fix dead half of the MTU guard in __ip6_append_data()

This patch removes the second half of the MTU guard in
__ip6_append_data(), which could never be true. It adds a new check: if
the datagram has to be fragmented and the MTU cannot hold the fragment
header plus one 8-octet payload block, the send fails with -EMSGSIZE.
For non-tunnel xfrm bundles the check also counts rt->dst.header_len.

Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.22a3131380a8c@gmail.com/

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..4353b154f216f 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c

[ ... ]

> @@ -1533,6 +1532,29 @@ static int __ip6_append_data(struct sock *sk,
>  		return -EMSGSIZE;
>  	}
>  
> +	/*
> +	 * If the datagram has to be fragmented, each non-final fragment
> +	 * must leave room for at least 8 bytes of payload after the
> +	 * fragment header, matching the minimum ip6_fragment() enforces
> +	 * once skb->len > mtu.  This rejects the MTUs that make maxfraglen
> +	 * underflow below fragheaderlen and defeat the datalen clamp,
> +	 * which leads to skb_over_panic() from skb_put().
> +	 *
> +	 * reserved_headerlen accounts for the first fragment's xfrm header
> +	 * space (with a transport-mode xfrm bundle, ESP/AH bytes counted
> +	 * in dst.header_len are not part of fragheaderlen), regardless of
> +	 * whether this append is the first one on the cork: a subsequent
> +	 * append that pushes an initially unfragmented datagram past mtu
> +	 * still fragments, and ip6_append_data_mtu() subtracts
> +	 * dst.header_len from mtu for the first fragment.
> +	 */

[Severity: Low]
Is this description accurate for a subsequent append? The commit message
gives the same rationale.

On a subsequent corked append, skb_peek_tail(queue) returns the skb that
is already queued, so skb is non-NULL. When the loop reaches
alloc_new_skb with skb_prev == NULL, it passes that skb to
ip6_append_data_mtu():

			if (!skb || !skb_prev)
				ip6_append_data_mtu(&mtu, &maxfraglen,
						    fragheaderlen, skb, rt,
						    orig_mtu);

ip6_append_data_mtu() then takes the non-first-fragment branch:

net/ipv6/ip6_output.c:ip6_append_data_mtu() {
		if (!skb) {
			/* first fragment, reserve header_len */
			*mtu = orig_mtu - rt->dst.header_len;
		} else {
			...
			*mtu = orig_mtu;
		}
}

So on this path no dst.header_len is reserved for the first fragment. The
first skb is filled and trimmed at the maxfraglen computed from orig_mtu.

Take a non-tunnel xfrm bundle with:

  fragheaderlen + 16 <= mtu < fragheaderlen + dst.header_len + 16

Does the new check return -EMSGSIZE on subsequent appends in that range,
even though maxfraglen would not underflow there?

Could the comment and the commit message be updated to match what the
code does? Alternatively, the check could be adjusted for subsequent
appends.

> +	reserved_headerlen = fragheaderlen;
> +	if (!(rt->dst.flags & DST_XFRM_TUNNEL))
> +		reserved_headerlen += rt->dst.header_len;
> +	if (reserved_headerlen + cork->length + length > mtu &&
> +	    mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
> +		goto emsgsize;

[Severity: High]
Does reserved_headerlen cover everything that ip6_append_data_mtu()
takes away from the first fragment?

The new minimum counts only fragheaderlen and rt->dst.header_len. It
does not count transhdrlen (the L4 header plus opt->opt_flen on the
first append) or rt->dst.trailer_len. After ip6_append_data_mtu()
lowers mtu by rt->dst.header_len for the first fragment, the loop
clamps datalen to maxfraglen - fragheaderlen - rt->dst.trailer_len.
That value can still be smaller than transhdrlen.

Here is a concrete case. Take a transport-mode AH bundle with
dst.header_len = 24 and trailer_len = 0, 1200 bytes of HOPOPTS
(fragheaderlen = 1240), an 8-byte fragmentable dstopt (opt_flen = 8,
so transhdrlen = 16 for UDP), mtu 1280 and a 2000-byte send. Both
entry checks pass:

  headersize + transhdrlen = 1264, not > 1280
  mtu < reserved_headerlen + 16 is 1280 < 1280, false

ip6_append_data_mtu() then sets mtu to 1256 and maxfraglen to 1248,
so datalen is clamped to 8, which is below transhdrlen.

On the paged branch (for example MSG_SPLICE_PAGES on a NETIF_F_SG
device), pagedlen = datalen - transhdrlen - fraggap wraps to
0xfffffff8. The wrap cancels out in copy = datalen - transhdrlen -
fraggap - pagedlen, so copy is 0 and the copy < 0 check does not
fire. skb_put(skb, fraglen - pagedlen) then puts 1256 bytes, which
is past maxfraglen.

On the next fragment, fraggap is computed as 1256 - 1248 = 8 before
ip6_append_data_mtu() restores maxfraglen to 1272. Then
skb_copy_and_csum_bits(skb_prev, maxfraglen, ...) reads at offset
1272 from a 1256-byte skb_prev. That hits the DEBUG_NET_WARN_ON_ONCE()
in skb_copy_and_csum_bits() and puts garbage into the second
fragment.

On the non-paged branch the same input reaches copy < 0 and fails
with -EINVAL partway through the loop, instead of taking the emsgsize
path. With ESP and dst.trailer_len > 8, the datalen clamp itself
wraps.

The commit message says this patch also covers the transport-mode
xfrm re-lowering. Should the minimum also include transhdrlen and
rt->dst.trailer_len, or is there a better place to bound this?

Separately, the headersize + transhdrlen > mtu check, the dontfrag
check and the CHECKSUM_PARTIAL and MSG_ZEROCOPY decisions all compare
against the unreduced mtu. A UDPv6 datagram that only needs
fragmenting after ip6_append_data_mtu() subtracts dst.header_len can
still get CHECKSUM_PARTIAL or zerocopy, and it skips the dontfrag
path. Is that intended?

[Severity: Medium]
Does this count rt6i_nfheader_len twice?

fragheaderlen already includes it:

	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
			(opt ? opt->opt_nflen : 0);

xfrm_bundle_create() adds XFRM_TYPE_NON_FRAGMENT states to both
dst.header_len and nfheader_len:

net/xfrm/xfrm_policy.c:xfrm_bundle_create() {
	...
		header_len += xfrm[i]->props.header_len;
		if (xfrm[i]->type->flags & XFRM_TYPE_NON_FRAGMENT)
			nfheader_len += xfrm[i]->props.header_len;
	...
}

__ip6_append_data() itself subtracts the overlap elsewhere:

		dst_exthdrlen = rt->dst.header_len - rt->rt6i_nfheader_len;

Here is a concrete case. Take a Mobile IPv6 route-optimization destopt
state. It has header_len = nfheader_len = 24 and is not DST_XFRM_TUNNEL.
Add mtu 1280 and 1184 bytes of HOPOPTS. Then fragheaderlen is 1248 and
reserved_headerlen is 1272.

A corked UDP send of 0 bytes with MSG_MORE passes the new check (1272 + 8
is not > 1280) and queues a 1256-byte skb.

Appending 1 byte then meets both new conditions (1281 > 1280 and
1280 < 1288), so it returns -EMSGSIZE and calls ipv6_local_error().

Before this patch, the existing-skb path appended the byte
(copy = 1280 - 1256 = 24). After __ip6_make_skb() pulls fragheaderlen
and the mip6 type inserts its 24-byte header, the wire size is
40 + 1184 + 24 + 8 + 1 = 1257, which fits within mtu.

Is this a newly rejected datagram that never needed fragmentation? The
patch is tagged for stable.

On a first append, the existing ip6_append_data_mtu() computation counts
nfheader_len twice in the same way, so such a send already fails with
-EINVAL. The new behavior change applies only to subsequent corked
appends.

Would it make sense to add only rt->dst.header_len - rt->rt6i_nfheader_len
here, as dst_exthdrlen does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505%40qq.com
