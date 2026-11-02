Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588100;
	b=Cuclabq8RayweiymH9CBJfMLYQRekYjQhB/NE3f2Xv9PIEcLe+zL6kkd4pgh9Q3N8ozv
	 4aVfyhXDufMMOZgTABzo/ZZW++LmeGpfA1gWW4/8T2dacIaDbLhJ0iYbGQDwoo+MpcDh8
	 37dw50T4KPwAkAehX3n+wLZRBa3L+pD04pDLk+roHOKV8wt8mBStFAqkbR+DA6d7fiiIw
	 gJIonaoDV8nJzF/yXKNGh1jGiI/oqn0N3iP3l+kPRIRc+A2YFMOIsEV5f2iMXDdXo9vDV
	 og4ISt3ItiZ+utg9oonEoOyoeyNW0+fSLI1vPz3GRXwHPVOxUCGdqcR1e1KoZQue5IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588100;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+qyp3SpKsDT53zfVX02a+O9Um1u2U0JP0ur5RXFLGKk=;
	b=VhQ424H1zt0lGV55cQzGbpWmhH7q4h30owseUxsvmlMHzFsiLjPoNv2zKDNyHnjMEerY
	 tctar1EqtA2zsoUpy/JMaCi4VXtIIDs/HsLCQ0cgAOtc40fUy6Cw3CZC8o/NrjMRVpJsr
	 TYnD6q88+Mpxaklq83Id1GNcmAUY+DpcVSu9K4s1L5H/Xdw+ig8YnxxN1ajOoWX0qSFk7
	 07rrgCOse0rvqaSaroJYaOR7vetZf2FNZvNNJkPIDl+wz2bzMIfNDksC+R/qWRzldzEZM
	 AJhXjMbct8JOrlWhlE9axkzw1RzckZ7l2rWx5L6D7ly6O4DmV/NLuE4ad46AdA4h5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8nWEYE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5116606A324;
	Mon,  2 Nov 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8nWEYE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94B1F000C1;
	Mon,  2 Nov 2026 02:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588099;
	bh=+qyp3SpKsDT53zfVX02a+O9Um1u2U0JP0ur5RXFLGKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J8nWEYE5uq5nJXw1ymig/jLa9Oe7aOsXKZnAqjl5Z3OiufAtY/B+akDd8jO4DxcSv
	 zzUQt1z9E1FOBit8PdkvkwqaDirur9HFhKJjvp15zD6x1bl4j7PzCvjPXM1Pt81U+C
	 RQKxAyGhEjzeLsgXgUdiORf1aELT3MHJIykEfs0c9olYEmh0nrFuoIcrXNkE6BDBza
	 74eYlJN8MyEZZgals51I2m0O9EPETdF3w3nbelghE1eHyctg226IBO4b1IuVKKNv+d
	 MnEQP1yIMXN6FvHSIwl/sdv47tvAzpjJJadLl4iGUnGG/sfUJAEP+tvjSPaezNXt+Y
	 YFsa88yF5TOoA==
Subject: Re: [PATCH net v2] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
From: netdev-bot+sashiko@kernel.org
To: treebacker@foxmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 02:54:58 +0000
Message-ID: <179358809842.3131.7173406503620605404@kernel.org>
In-Reply-To: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
References: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a failure exit inside the fragmentation loop of
  __ip6_append_data() (net/ipv6/ip6_output.c:1662-1666).
- [Medium] The new entry guard in __ip6_append_data() counts the fragment
  header twice, and it disagrees with the patch's other new check in…
- [Medium] Both new checks reject a datagram whether or not it actually
  needs fragmenting.
- [Low] The commit message has several defects: - The subject line is
  repeated as the first line of the body.

--

ipv6: fix dead half of the MTU guard in __ip6_append_data()

This patch replaces the always-false second half of the MTU guard in
__ip6_append_data() with a check that requires payload room after the
fragment header. ip6_append_data_mtu() now returns false when the
first-fragment recompute (which subtracts dst.header_len) falls below a
similar bound. When that happens, the fragmentation loop jumps to the
emsgsize label.

Link: https://lore.kernel.org/netdev/179321375161.3134.12690504630171635307@kernel.org/

> ipv6: fix dead half of the MTU guard in __ip6_append_data()
>
> ipv6: fix dead half of the MTU guard in __ip6_append_data()

[Severity: Low]
This isn't a bug, but the subject line is repeated as the first line of
the body.

> __ip6_append_data() validates the path MTU against fragheaderlen
> before the fragmentation loop, but the second half of the guard is
> always false: it compares (mtu - fragheaderlen) + fragheaderlen
> against sizeof(struct frag_hdr) (8), while fragheaderlen is at least
> 1280 for any packet carrying a Hop-by-Hop options header of 1240
> bytes.

The old second half is false for every packet once mtu > fragheaderlen.
fragheaderlen is always at least sizeof(struct ipv6hdr) (40), which is
larger than sizeof(struct frag_hdr) (8).

Could the explanation say that directly, instead of citing a 1240 byte
Hop-by-Hop header? The specific example suggests the guard might be live
for other header sizes.

> An IPV6_MTU socket option that makes mtu - fragheaderlen
> underflow below fragheaderlen therefore passes the guard

This phrase reads as garbled. Isn't it maxfraglen that drops below
fragheaderlen or wraps?

Also, the Link: tag sits below the --- separator with the v1 changelog,
so git am would drop it.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..ab4eee51f1737 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c

[ ... ]

> @@ -1357,8 +1357,20 @@ static void ip6_append_data_mtu(unsigned int *mtu,
>  	if (!(rt->dst.flags & DST_XFRM_TUNNEL)) {
>  		if (!skb) {
>  			/* first fragment, reserve header_len */
> -			*mtu = orig_mtu - rt->dst.header_len;
> +			int new_mtu = (int)orig_mtu - (int)rt->dst.header_len;
>
> +			/*

[ ... ]

> +			 */
> +			if (new_mtu < (int)(fragheaderlen +
> +					    sizeof(struct frag_hdr) + 8))
> +				return false;
> +			*mtu = new_mtu;

[ ... ]

> @@ -1499,13 +1513,23 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	if (mtu <= fragheaderlen)
>  		goto emsgsize;
>
>  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
>  		     sizeof(struct frag_hdr);
>
> +	/*
> +	 * Each non-final fragment must leave room for at least 8 bytes of
> +	 * payload after the fragment header, matching ip6_fragment()'s
> +	 * mtu < hlen + sizeof(struct frag_hdr) + 8 check.  This rejects
> +	 * MTUs that make maxfraglen underflow below fragheaderlen and
> +	 * defeat the datalen clamp, which leads to skb_over_panic() from
> +	 * skb_put().
> +	 */
> +	if (maxfraglen < fragheaderlen + sizeof(struct frag_hdr) + 8)
> +		goto emsgsize;

[Severity: Medium]
Is the fragment header being counted twice here? maxfraglen already has
sizeof(struct frag_hdr) subtracted:

    maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8

So maxfraglen < fragheaderlen + 8 + 8 is the same as
((mtu - fragheaderlen) & ~7) < 24. That requires 16 bytes of payload per
non-final fragment, not the 8 that the comment describes.

ip6_fragment() only requires mtu - hlen >= 16:

    if (mtu < hlen + sizeof(struct frag_hdr) + 8)
        goto fail_toobig;

The new check in ip6_append_data_mtu() compares mtu rather than
maxfraglen, so it also only requires 16. It accepts
new_mtu == fragheaderlen + 16 and then sets
maxfraglen = fragheaderlen + 8, a value this entry guard rejects.

That doesn't seem to match the commit message's statement that the same
bound applies "both at cork setup and after every recompute in
ip6_append_data_mtu()".

As a result, sends with mtu - fragheaderlen in [16, 23] now fail with
-EMSGSIZE. Before this patch they produced valid fragments with 8 bytes
of payload. One example is a fragheaderlen of 1264 with an MTU of 1280,
which an unprivileged user can reach with a large IPV6_RTHDR SRH.

Could both sites use the same formula? For example, compare mtu against
fragheaderlen + sizeof(struct frag_hdr) + 8, or compare maxfraglen
against fragheaderlen + 8.

[Severity: Medium]
Does this also reject datagrams that don't need fragmenting at all? The
check runs before anything is known about the datagram length, so any
send with mtu - fragheaderlen < 24 gets -EMSGSIZE.

For example, take mtu - fragheaderlen = 20, opt_flen = 0, and a UDP send
with 4 bytes of data (12 bytes including the UDP header). The old code
computed maxfraglen = fragheaderlen + 8. cork->length (12) <= mtu, so
the datalen clamp was skipped. The datagram went out as one unfragmented
packet of fragheaderlen + 12 bytes.

With this patch that send fails with -EMSGSIZE.

The new check in ip6_append_data_mtu() behaves the same way. On a
transport-mode xfrm route it rejects the first skb whenever
orig_mtu - dst.header_len - fragheaderlen < 16, even if the whole
datagram fits.

The skb_over_panic() only happens on the fragmenting path, when this
clamp is applied:

    if (datalen > (cork->length <= mtu ? mtu : maxfraglen) - fragheaderlen)
        datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;

ip6_fragment() likewise only applies its bound when it actually
fragments.

Should these checks only apply when the datagram needs fragmenting? If
not, could the commit message mention that single-packet sends in this
range are now refused?

> +
>  	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
>  	 * the first fragment
>  	 */
> @@ -1635,10 +1659,11 @@ static int __ip6_append_data(struct sock *sk,
>  			else
>  				fraggap = 0;
>  			/* update mtu and maxfraglen if necessary */
> -			if (!skb || !skb_prev)
> -				ip6_append_data_mtu(&mtu, &maxfraglen,
> -						    fragheaderlen, skb, rt,
> -						    orig_mtu);
> +			if ((!skb || !skb_prev) &&
> +			    !ip6_append_data_mtu(&mtu, &maxfraglen,
> +						 fragheaderlen, skb, rt,
> +						 orig_mtu))
> +				goto emsgsize;

[Severity: High]
Can this leak the zerocopy uarg? ip6_append_data_mtu() only returns
false in the !skb branch. That means this exit is reached through
"if (!skb) goto alloc_new_skb", after __ip6_append_data() has already
done its setup:

    } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
        uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb),
                                    false);
        ...
        extra_uref = !skb_zcopy(skb);
        ...
            skb_zcopy_set(skb, uarg, &extra_uref);
    ...
        tskey = atomic_inc_return(&sk->sk_tskey) - 1;
        hold_tskey = true;
    ...
    cork->length += length;
    if (!skb)
        goto alloc_new_skb;

The emsgsize label only reports the error and returns:

    emsgsize:
        pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
        ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
        return -EMSGSIZE;

The cleanup lives under the error label:

    error:
        net_zcopy_put_abort(uarg, extra_uref);
        cork->length -= length;
        ...
        if (hold_tskey)
            atomic_dec(&sk->sk_tskey);

With skb == NULL, skb_zcopy_set() does nothing, so no skb owns the new
uarg from msg_zerocopy_alloc(). Its sock_hold(sk), its optmem charge and
its locked_vm accounting would never be released. sk_zckey and sk_tskey
would be left with gaps, and cork->length would stay inflated.

One way to trigger this is a UDPv6 MSG_ZEROCOPY send on a route covered
by a transport-mode SA. The non-fragmentable headers have to be sized so
that orig_mtu - dst.header_len < fragheaderlen + 16, for example with an
IPV6_RTHDR SRH, which needs no capability. That is the same case this
hunk is meant to handle.

The pmtu reported here also looks off. *mtu is only written after the
new check passes, so the value given to ipv6_local_error() is computed
from orig_mtu and ignores dst.header_len. A sender that follows that
hint would fail again.

Would it work to set err = -EMSGSIZE, call ipv6_local_error() and then
goto error here? Alternatively, the first-fragment header_len check
could run before the uarg and tskey setup, since all of its inputs are
known at that point.

>
>  			skb_prev = skb;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08%40qq.com
