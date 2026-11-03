Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698426;
	b=zpUkUsSmtGq2jX+j0qKu6OqxQIUFMTjQ/82ovYkVH0V4ssDNU7rre/ChSt+o92SAiiLa
	 0ckDxvJ0p525RqTpTQFQC1aR7Z1GIepvYR0MY1Y6DS44nuBooTrde2RLEYmsUdI/Dgkye
	 4rK17pg8nKcKYtynAxCTrlqLB2BLQ9DEZXbvM9/zqWDk8xzfA83SkJinA4bu20FSRmA++
	 mm/y/YWRSaA+3vE6i46FwqLmgoghm9R34/l3Dodn+tjcZJNzDIG+uTicvNFDPsPlhk/Iz
	 bI685gewGotgpcUFVsdwyWD6v4nKplWJiB39bfDLrJsdNM2WgRCgBCq01sPcc4M2BbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698426;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D6rny5kjXK5DrJDvzkFSnRh5hQ+TqEu9S3skisSzk08=;
	b=qkNAKHj8cVRyOUXqA8mh+v3o10/hpp0TMJbn8Oat7Zzl8hZ/P0boqjV6TZbKo6NMl36I
	 IqfY5bnIL2isoi6GyYMWTz8PTKYwUQKByQtpVRQsMVYGXmuOo45/kpZWmnq2jVsm7JwIp
	 UkLlpmAZOErOafeIGOxjOoX8wNEsdtgpzBvIMJJU5uQutqyv1jIUovB3fH93rWr9y/AMs
	 4Qk1LfcYOCfgPhkgdDOEWj6zTIqDh7t28TQsx4YzD31H7QVGX+/k9V60O3tIE1IipJjVj
	 bZhyqbMCLEpbovoEjsSM3LRaDtD7WWBStwOWj/K9ydF1bU2bp+tc0xFJGcDqbW4xkTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XDwNz6/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A554606A329;
	Tue,  3 Nov 2026 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDwNz6/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588901F0093A;
	Tue,  3 Nov 2026 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698426;
	bh=D6rny5kjXK5DrJDvzkFSnRh5hQ+TqEu9S3skisSzk08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XDwNz6/X0GpDQK0tjwuoGy3TWaQl/Dxzlr5GxqbYRhKwwtzuoBRRTXln1RQ7g3mf8
	 kPcKMs5zlFnb8gNclOOmphQCGI4EnSaF3r9KGrNIxHIfGLlnNbXbnrxgfHCqfhA7zS
	 GbZZlEFsGH5ZGpdcRQJqoWw63YqXMyYnQuhvid0TA6on96iRybfnHPp2YIye1JeQhN
	 v1Erbwp+3Cg+KQ9FCc4b9PLGyWv+OJxEcQ/L/yRaBxUcXqgbTKsy56kBLZf8WH5ol6
	 WVDh4+1BaQslqT5bAuI93g2gQygc6DCujpnhZnB7xHJnnsM4PB2LPQMVetJUTA7aRI
	 AJ3rCxzCO3bfQ==
Subject: Re: [PATCH net v3] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
From: netdev-bot+sashiko@kernel.org
To: treebacker@foxmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@kernel.org, idosch@nvidia.com,
 horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 09:33:44 +0000
Message-ID: <179369842489.488856.13715635403726520174@kernel.org>
In-Reply-To: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
References: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In __ip6_append_data() (net/ipv6/ip6_output.c:1502-1507), the
  patch adds a new minimum check: `mtu < reserved_headerlen +…

--

ipv6: fix dead half of the MTU guard in __ip6_append_data()

This patch replaces the MTU entry guard in __ip6_append_data(). The
second half of the old guard could never be true. The new guard requires
room for the fragmentable headers, plus dst.header_len for non-tunnel
xfrm, plus a fragment header and one 8-octet payload block. The goal is
to stop maxfraglen from underflowing, which leads to an skb_over_panic()
in skb_put().

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..936dad85f1c98 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c

[ ... ]

> @@ -1499,8 +1499,11 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>  
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	reserved_headerlen = fragheaderlen;
> +	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
> +		reserved_headerlen += rt->dst.header_len;
> +
> +	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
>  		goto emsgsize;

[Severity: Medium]
Does this new check also reject datagrams that fit in the MTU and would
never be fragmented?

The minimum is computed only from header sizes. It runs before
__ip6_append_data() knows whether this send needs fragmenting. Take an
IPv6 socket whose extension headers (for example a hop-by-hop options
cmsg) leave mtu - fragheaderlen between 1 and 15, and a payload where
headersize + transhdrlen + length <= mtu. That send used to work.

On the first skb, the alloc_new_skb path picks the mtu side of the
clamp, because cork->length <= mtu:

    if (datalen > (cork->length <= mtu ? mtu : maxfraglen) - fragheaderlen)
        datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;

The clamp does not fire, so fraglen = fragheaderlen + length <= mtu. The
underflowed maxfraglen is never used on this path. After that,
__ip6_finish_output() sends the packet without fragmenting it:

    if (unlikely(skb->len > mtu ||
        (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)))
        return ip6_fragment(net, sk, skb, ip6_finish_output2);

With this patch, the same sendmsg() returns -EMSGSIZE from the new check,
and ipv6_local_error() reports a pmtu.

The commit message says:

    Replace the dead expression with a single check that requires room
    for at least one 8-octet payload block after the fragment header,
    matching the minimum ip6_fragment() already enforces:

ip6_fragment() only applies this minimum to packets that are larger than
the MTU and are actually being fragmented:

    if (mtu < hlen + sizeof(struct frag_hdr) + 8)
        goto fail_toobig;

Here it applies to every send, including ones that fit. Since IPV6_MTU
accepts any value >= 1280, it is not hard to land in that window. The
patch is also tagged for stable, so stable trees would get this change
in behaviour that userspace can see.

Could the minimum be applied only when this call will need to fragment?
For example, gate it on cork->length + length > mtu - headersize,
evaluated before cork->length += length. Or could the commit message at
least describe the change for unfragmented sends?

>  
>  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_AE3DA7423209553B562E5C7FBCB808EB680A%40qq.com
