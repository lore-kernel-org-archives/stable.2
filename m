Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103879;
	b=DuPYKntAt0DaqFQ6sIS/Vw6Avvm8Kbq6OJnF2Tik9MlM9D6LaLy2n4QSWc+Wp2Go52IJ
	 Ov6cCUhfp0v7r+T+ZHUNiWfo+0IPVdl6fCWDBm/dvD51MjRrR7nHi7ghfnOHtL/j34Tbi
	 7nm2Aea9JV3pXdjSyDhUaMeBIYWN2PykQjK24g/H6K4IIMGU/rFT2BnaCXT0PDLKfqOhZ
	 0mYb+6K5raQ9gYvLE5Kh87d3GUD4T8M2J1LaaOUFhNd2QO0TaEC4CWscMfL4bIDL0ah+a
	 QNMhdFCZ2A3DMRAXF4bZoDoZQeINzqDcXmnJDrxP7Vm5XPqka0k2iHRWqrEVldpUE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103879;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mo/Ifisr6uF13jyRhb7Rytvceb6bZ3F1oSnHvoqB9LY=;
	b=4hncIeP35PDZNsHVhl9Oe55N8gRAzSpH9o8FiQ1OKVrHicNgQkPbxmztzHbg6cfj3u86
	 l+PBE+0OU/su8w379kI+k6o9WdvPlXjHIwq3xcqt7iHrDmBl96E62hwsQNYtPujAMSpGD
	 OLGD8ZFLiU5XzgM6FPpucYL0x6Tdohn3aGZUijO+VrYrrhYLtaqaixlOQA9Kddp8/Y5hk
	 sYCUUaWfsAciPI0BkI2WWQkBgylTnz0SgrG3y1JwtJ1UKLRuTLggFOa3QPSXYtiDiDVv3
	 UIcijC1rJU+pyBrQBysm/5REassHJrgIjaTTNYqM8ZiyZdsE+39L6bTsMii+sP8RJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoB3E8wr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CA606A31C;
	Sun,  8 Nov 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoB3E8wr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154651F0089F;
	Sun,  8 Nov 2026 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794103878;
	bh=mo/Ifisr6uF13jyRhb7Rytvceb6bZ3F1oSnHvoqB9LY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DoB3E8wrWqNr+Z/dTJDg0FRgdJNgxXTKfwYt2uKSppCvWIyo4TY2TLqdwLAV9Fqp9
	 H+NJm67lqgjDRWjeGriben+oOuj0tnTySkxDr0NguxJvJqkeE+sAbirkjCPTGWy4Lx
	 YgWKgxNb1LnhI5jrsfTkzsdM+G11Kc91Yc3b+PHG17KVSWfsFyD5z7B4tBMta5rAMP
	 1eWAh3SK7ylhZLYWkaDxw4TCvo4nRE0m1BJBU3nL0IAL/Dre+I55KV1/unXQ0HUBlG
	 I6OGxn1u5ItJwBWbPoHUuPCtMw0c2c5cKSz/6PKnhPFepTx4kDSPxZn9j1mt15tZ8B
	 6V+yVMzn5RjyQ==
Subject: Re: [PATCH net v2 1/2] xfrm: fix IPv6 first-fragment protocol decode
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 08 Nov 2026 02:11:17 +0000
Message-ID: <179410387761.994134.6172658851496311106@kernel.org>
In-Reply-To: <20261103225842.3204446-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261103225842.3204446-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes the bug only as an IPv6 atomic
  fragment followed by extension headers that is mis-classified on the…

--

xfrm: fix IPv6 first-fragment protocol decode

This commit makes __xfrm_decode_session() pass
FLOW_DISSECTOR_F_PARSE_1ST_FRAG to the flow dissector for IPv6. With that
flag, first fragments are walked through to the upper-layer protocol. It
also keeps the port, ICMPv6 and GRE selector fields in decode_session6()
zero for all fragments.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cea6842e6454d..4f6a5b81e3b5a 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c

[ ... ]

> @@ -3511,10 +3517,13 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
>  			  unsigned int family, int reverse)
>  {
>  	struct xfrm_flow_keys flkeys;
> +	unsigned int flags = FLOW_DISSECTOR_F_STOP_AT_ENCAP;
>  
>  	memset(&flkeys, 0, sizeof(flkeys));
> +	if (family == AF_INET6)
> +		flags |= FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
>  	__skb_flow_dissect(net, skb, &xfrm_session_dissector, &flkeys,
> -			   NULL, 0, 0, 0, FLOW_DISSECTOR_F_STOP_AT_ENCAP);
> +			   NULL, 0, 0, 0, flags);

[Severity: Low]
This isn't a bug, but does the commit message describe a narrower scope
than the code change? The message says:

    For an atomic fragment followed by extension headers, inbound policy
    lookup can therefore see the header after Fragment instead of the
    actual upper-layer protocol and miss protocol selectors.

The flag is set for every AF_INET6 decode. That means the change covers
all IPv6 first fragments (offset 0, with or without MF) in every policy
direction, not only inbound atomic fragments.

On a router without nf_defrag_ipv6, fragments reach ip6_forward() without
being reassembled. Both of these lookups go through
__xfrm_decode_session():

ip6_forward()
    xfrm6_policy_check(NULL, XFRM_POLICY_FWD, skb)
    xfrm6_route_forward(skb)

A non-atomic first fragment is now classified by its real L4 protocol
(for example UDP). Non-first fragments still stop early in
__skb_flow_dissect():

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
	case NEXTHDR_FRAGMENT: {
	...
		ip_proto = fh->nexthdr;

		if (!(fh->frag_off & htons(IP6_OFFSET))) {
			key_control->flags |= FLOW_DIS_FIRST_FRAG;
			if (flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG) {
				fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
				break;
			}
		}

		fdret = FLOW_DISSECT_RET_OUT_GOOD;
    ...
}

So the first fragment of a forwarded datagram can now be matched against
FWD and OUT policies with a different protocol than its later fragments.
With a destination options header after Fragment, the first fragment
uses 17 and the later ones use 60. Before this patch, all of them used
60.

This is close to how the decoder behaved before 7a0207094f1b, so it is
not a functional regression. Could the commit message mention the
forward path and non-atomic first fragments? Stable backporters with
protocol-specific tunnel or required policies on gateways will see a
change in how forwarded fragmented traffic is handled.

Could the message also say plainly that missing protocol selectors means
plaintext traffic can bypass IPsec enforcement when the default policy
accepts?

The following patch, "xfrm: fix selector matching for IPv6 atomic
fragments", does not change this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103225842.3204446-2-Jeremy.Jean%40oss.cyber.gouv.fr
