Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213753;
	b=jQQ2Aqya19jO8yKV15PjVhRtN15AtOksNf+vWKKRl4HTcISgUwqRizE/ahC+FUln+29B
	 lOuaNqLV98j4i2kP2yLVslaKZZ46OjxZ7+pvqFkELTzj7qQH5oVoFBBedGMbJrhLRdaw0
	 xg9Mr1Uts2Ic95mIF3zlqUQxj4EVVla1WpWQyEyfisC0UimXI3NT5lpT401LquzmPH74Z
	 R+lcNDVKEXbFasneOJVOBnRBaL0DMLUEJtYRxA0dnG7wRiYJZkn7Or0zAgXeYRG9kxter
	 Tjtkr1/gdZkPBQqHV1oFFECbSXd40m2Ro6r1IGaCtWpOLHqbTkEQ+WbC6BK4p5F9pmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213753;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0oDMEFhu/JmPLudE7M83PqlDBn/SvgKbYi6IfCMq3dI=;
	b=B7tmahi7ZJ6OIyKqO899Ch/GnT61PKxcwIZPHnQ8ZIix7RCHP/DVG5nEacKFqOwFAsPs
	 CRwuJ153lM1J88Nz6qWrDh0zPUAIrAIZkp1bQmpZlwwCRZ/zHMmd2IihG3MH8Q9jM7At2
	 4YSsaXGtO4AvN+LD8LHLGN1KJEKbAcJAAUndv82Pn64RAUUqFwPukWWefNDHAgAMsWJLk
	 4HcvJg1aMWiUojzZ6PFzTaZjfgO6YWT7ox7ugEMU7NURymU9CoV5BInlkG9MjwQcInJN2
	 JRzv6pC1IuIDa4/OBikcinYCCDJXgWqALoQ4ljydoDRCNvdS+fz4wSEQTzoCB4sEngw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8YVW2ek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4B606A31A;
	Wed, 28 Oct 2026 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8YVW2ek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CB11F01825;
	Wed, 28 Oct 2026 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793213752;
	bh=0oDMEFhu/JmPLudE7M83PqlDBn/SvgKbYi6IfCMq3dI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G8YVW2ek8N6dHWAFzKmkiVUC7dFQkO050z8QF6JgC2UEEw49pP/G2Pvh6dUDPzU3j
	 hpA86kZagPl/Ugp6K8892s2n1u3Bz3UExzClmLinG0SO9JVT+aeZKHypJMETvhB1SY
	 zAImpcxt7mCFZwMiL5/eHt817cPp2auWoqMGyYr0+nwQLSFgRaQHf/b7UtPOceKGDW
	 F9wFdNdow5MxFUIDS7b+FDAccH96u3vSSciDRCt56yNUV9+UnSV1CAEEIlwYZyffKz
	 1gWFqrG3wleW5Bud0QhkbH9ai+BuXLCK8aP0rOx/CLnl8x8WCxXhRwRc2trbqJjvWv
	 EGlgDVgmBl0ug==
Subject:
 Re: [PATCH net] ipv6: fix dead half of the MTU guard in __ip6_append_data()
From: netdev-bot+sashiko@kernel.org
To: treebacker@foxmail.com
Cc: greg@kroah.com, netdev@vger.kernel.org, davem@davemloft.net,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 28 Oct 2026 18:55:51 +0000
Message-ID: <179321375161.3134.12690504630171635307@kernel.org>
In-Reply-To: <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
References: <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
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

- [High] The fix is incomplete.
- [Medium] The commit message calls the new expression `mtu -
  fragheaderlen <= sizeof(struct frag_hdr)` "a direct check of the…
- [Low] The From: and Signed-off-by: names do not match.

--

ipv6: fix dead half of the MTU guard in __ip6_append_data()

This patch replaces the always-false second half of the MTU guard in
__ip6_append_data() with a direct comparison of mtu - fragheaderlen
against sizeof(struct frag_hdr). The goal is to reject MTUs that make
maxfraglen underflow below fragheaderlen, which defeats the datalen clamp
and leads to skb_over_panic() from skb_put().

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>

[Severity: Low]
This isn't a bug, but the From: name and the Signed-off-by: name don't
match. The author is "平之 <treebacker@foxmail.com>" and the sign-off is
"bo cao <treebacker@foxmail.com>". checkpatch.pl reports this as a
FROM_SIGN_OFF_MISMATCH warning.

Could a resend use the same name in both places?

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..7d4d4d45e2074 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1500,7 +1500,7 @@ static int __ip6_append_data(struct sock *sk,
>  		     rt->rt6i_nfheader_len;
>  
>  	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	    mtu - fragheaderlen <= sizeof(struct frag_hdr))
>  		goto emsgsize;

[Severity: High]
Is this guard enough to close the skb_over_panic() when the route is an
xfrm transport mode bundle?

This check only sees orig_mtu, which comes from cork->fragsize. When
DST_XFRM_TUNNEL is not set, ip6_setup_cork() does not subtract
dst.header_len from fragsize. The first fragment then lowers mtu again
in ip6_append_data_mtu():

net/ipv6/ip6_output.c:ip6_append_data_mtu() {
	if (!(rt->dst.flags & DST_XFRM_TUNNEL)) {
		if (!skb) {
			/* first fragment, reserve header_len */
			*mtu = orig_mtu - rt->dst.header_len;
    ...
		*maxfraglen = ((*mtu - fragheaderlen) & ~7)
			      + fragheaderlen - sizeof(struct frag_hdr);
	}
}

Nothing checks a lower bound after this recompute.

For ESP, xfrm_bundle_create() adds the header length to dst.header_len.
It only adds it to nfheader_len for XFRM_TYPE_NON_FRAGMENT types:

	header_len += xfrm[i]->props.header_len;
	if (xfrm[i]->type->flags & XFRM_TYPE_NON_FRAGMENT)
		nfheader_len += xfrm[i]->props.header_len;

Also, xfrm_lookup_with_ifid() sets DST_XFRM_TUNNEL only for
XFRM_MODE_TUNNEL and XFRM_MODE_IPTFS. So for transport mode ESP, the ESP
header is counted in dst.header_len but not in fragheaderlen.

When orig_mtu - fragheaderlen is in [9, header_len + 7], the new check
passes. After ip6_append_data_mtu(), mtu - fragheaderlen is then 7 or
less, or it wraps, and maxfraglen falls below fragheaderlen again.

For example, take fragheaderlen = 1280 (a 1240 byte HOPOPTS cmsg),
IPV6_MTU = 1289, and an ESP transport SA using AES-CBC (header_len = 24,
trailer_len = 29):

  orig_mtu - fragheaderlen = 9, so the new guard passes
  mtu = 1289 - 24 = 1265
  maxfraglen = ((1265 - 1280) & ~7) + 1280 - 8 = 1256

The clamp in __ip6_append_data() then compares against a wrapped
bound:

	if (datalen > (cork->length <= mtu ? mtu : maxfraglen) - fragheaderlen)
		datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;

It never fires, so datalen stays equal to length. With MSG_MORE on a
device without NETIF_F_SG, alloclen = mtu. The later
skb_put(skb, fraglen - pagedlen) then goes past the tailroom and hits
skb_over_panic().

Every capability involved (CAP_NET_RAW for the raw socket and HOPOPTS,
CAP_NET_ADMIN for the SA) is namespace scoped.

Would it be better to check the effective first fragment mtu and
maxfraglen after the header_len reduction? One option is to reject
maxfraglen <= fragheaderlen after each recompute in
ip6_append_data_mtu(). Another is to include dst.header_len in this
guard when DST_XFRM_TUNNEL is clear.

>  
>  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -

[Severity: Medium]
The commit message calls the new expression "a direct check of the
payload space available in a fragment, which rejects mtu - fragheaderlen
in [1,8]". Does that account for the & ~7 rounding used here for
maxfraglen?

For mtu - fragheaderlen in [9,15], the new check passes, but this
computation:

	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
		     sizeof(struct frag_hdr);

gives maxfraglen == fragheaderlen. That leaves zero payload space in
each non-final fragment.

When the message needs fragmentation, the datalen clamp in
__ip6_append_data() sets datalen to 0, or 0 - trailer_len with IPsec.
For a raw socket, transhdrlen is 0, copy is 0, and this line never
shrinks length:

	length -= copy + transhdrlen;

The loop keeps allocating header-only skbs until
sk_wmem_alloc + wmem_alloc_delta exceeds 2 * sk_sndbuf. sendmsg() then
fails with -ENOBUFS instead of -EMSGSIZE. For UDP, transhdrlen is 8,
copy becomes -8, and the call returns -EINVAL instead.

ip6_fragment() uses a stricter bound:

	if (mtu < hlen + sizeof(struct frag_hdr) + 8)
		goto fail_toobig;

Would checking ((mtu - fragheaderlen) & ~7) <= sizeof(struct frag_hdr),
or equivalently maxfraglen <= fragheaderlen, match both the commit
message and ip6_fragment() by rejecting [1,15]?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08%40qq.com
