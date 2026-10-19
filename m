Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B11E0DE8;
	Mon, 19 Oct 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792371207; cv=none; b=F6liznqcAW70WyMHwDJUoEISDqFrfVtvzrm2REDmmCdVDDfUeFdu4agovVH8iUM6Q9yeqaU+HmCLPc848Go1SlBANudiES0/qPCjflRrB9rMjwp9y4ki3UpQjVRYLVZS7/vD9f/Ei1owWbGbouaScCot+g7ANQB4GbAYvPbkDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792371207; c=relaxed/simple;
	bh=L4oPWyRdOWJ4WVXaJxwGqu9Vbq8LJS2AJQIOWUdz7hY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyDKLFfhH9U7NLzGtAWKAQSRShsIaBnJvLHrAcaD/9YUR50OQ+ghPaevH5m3wSTrmp89F9w141lYmw5WOeSnZgM1lTgb/fJ8KZEg9l7nspwhsN6IfpNgIHo3eBq2PO7JWjt9k4XVdi7Ha+iFsxycvM3SUncNVfUNCUJVc8PLqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdhnWjiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdhnWjiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3121F000C4;
	Mon, 19 Oct 2026 00:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792371206;
	bh=wNMFNftTQpWPPQEWb1Qcvc/380NyQkhR94vu+vFqq4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XdhnWjiXh3ovA4Z1wHt3Cq6FHvaoIp25E/mmiunK1bwHDFfW06u/17DpzQTawjFSJ
	 WnPVeVTKDsC3fDQR6CCQaf8hVxhhcCxBsCH8T1mcqCF6ThhBeHvFCbXyRihwvW9rPB
	 yX4OaCtb9+RWNLwZ31oXKrnhaxl82jN7GboTZmD9z0s8fchFOHeXinD6d7JrqGfYv0
	 XxyuKJ9KCEzUzD/QqP0KmCA5q/o4vYop85FXrvn5Oqytj3wjx1d/8PIxZVPV7QIXQZ
	 zCR/WRU+mRDyUoKnvdh+dvzDk8P6rDcmxKEMOO6M6ubN8DbXURh9cnY/2p0q6UcJMe
	 Dpc9ABVdGlNGg==
Subject:
 Re: [PATCH ipsec] xfrm: esp: reset outer TCP GSO metadata on espintcp input
From: netdev-bot+sashiko@kernel.org
To: yangguoshuai@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 00:53:25 +0000
Message-ID: <179237120528.3135.16925112275068010433@kernel.org>
In-Reply-To: <20261018005218.53267-1-yangguoshuai@gmail.com>
References: <20261018005218.53267-1-yangguoshuai@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix clears the outer-TCP GSO metadata only on the head
  skb.

--

xfrm: esp: reset outer TCP GSO metadata on espintcp input

This patch clears the stale outer TCP GSO metadata (gso_size, gso_segs,
gso_type) on espintcp packets. It does this at the skip_cow label in
esp_input() and esp6_input(), where the skb is no longer cloned. The goal
is to stop skb_segment() from hitting BUG_ON(!list_skb->head_frag) when a
decrypted inner packet with a strparser-built frag_list is forwarded.

> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index e76db5817e78e..416638c990825 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -900,6 +900,9 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
>  	nfrags = err;
>  
>  skip_cow:
> +	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
> +		skb_gso_reset(skb);
> +

[Severity: Medium]

Does this reset only reach the head skb? skb_gso_reset() writes to
skb_shinfo(skb) only, and the frag_list members seem to keep the outer
TCP GSO state.

In the case the commit message describes, strparser chains a cloned
spillover member onto frag_list. skb_cow_data() then replaces that member
with skb_copy(), and skb_copy_header() copies the GSO fields over from
the shared outer TCP shinfo:

net/core/skbuff.c:skb_copy_header() {
    ...
	skb_shinfo(new)->gso_size = skb_shinfo(old)->gso_size;
	skb_shinfo(new)->gso_segs = skb_shinfo(old)->gso_segs;
	skb_shinfo(new)->gso_type = skb_shinfo(old)->gso_type;
}

So after decryption the member still has, for example, SKB_GSO_TCPV4 with
gso_size set to the outer MSS.

The head is no longer GSO after this patch. Take a forwarded inner IPv4
packet with DF clear that is larger than the egress MTU. It passes
ip_forward(), since ip_exceeds_mtu() is false when DF is clear. It then
goes through ip_fragment() instead of ip_finish_output_gso():

__ip_finish_output()
  ip_fragment()
    ip_do_fragment()            /* frag_list fast path */
      ip_fraglist_prepare()     /* CHECKSUM_NONE, gso_* left as is */
...
validate_xmit_skb()
  netif_needs_gso()             /* true for each such fragment */
    skb_gso_segment()
      inet_gso_segment()
        tcp4_gso_segment()

The fast path is taken when the head payload is a multiple of 8 and fits
the mtu, each member fits the mtu, there is enough headroom, and nothing
is shared or cloned.

Take an inner TCP packet over an IPv4 outer stream. tcp4_gso_segment()
accepts the stale SKB_GSO_TCPV4, clears th->check, and writes a
pseudo-header checksum into what is really fragment payload.
tcp_gso_segment() then either returns -EINVAL and the fragment is dropped
(payload <= stale MSS), or splits the payload into garbage segments.

With an IPv6 outer stream (stale SKB_GSO_TCPV6) or an inner UDP packet,
the gso_type check fails and the fragment is dropped with -EINVAL. The
same applies to esp6_input(). An inner IPv4 packet arriving over an IPv6
espintcp SA can reach ip_do_fragment() with stale SKB_GSO_TCPV6 on its
members.

In either case, would the forwarded datagram fail to reassemble at the
destination? This path does not seem able to reach the skb_segment()
BUG_ON from the commit message, because the members are standalone linear
skbs by then. But the outer TCP GSO state is still set on them, so the
reset described in the subject is only partly done.

Could the GSO fields also be cleared on each skb_walk_frags() member at
skip_cow, in both esp_input() and esp6_input()? The members should be
private there, because skb_cow_data() copies every cloned or nonlinear
member.

>  	err = -ENOMEM;
>  	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
>  	if (!tmp)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018005218.53267-1-yangguoshuai%40gmail.com
