Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517128;
	b=df47s35I2qYDgXjUww4PB6w1+ZseAtH2Fc2Jp9ha95hYTe7X3+RkOg+SwNkhklLGb0T6
	 tZGkFiOaFW1hCUhoG98FYbBQ3y6LA5Z5e+Cqro5cCSbcERDPnVClRrc0UVod1StVjqSm3
	 9TScTyP9IxrIDrROwjoNuEEgboGS8NJ0eSXMvu957ces6roJqrk2ohEd1qXBgsmgB53X/
	 UXLi8/UrMUeonInCiVWNe4Owg8D2whmVEE64puP5ZmXssX1+e7r/ejWMNY6Wgyi3OTgE/
	 meoi7vUAZbttiwecujuxbZW5LxBLTrXBQ9ocT3zRyrEd63c/23nz2Xg3kKiRlfFUGtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517128;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hzR6M++7UtjG6jy2cgDIkbudvx9HYvO95GsCqnL8xxE=;
	b=gRuBMpqifF0B4TTQXpRgxj2yGuEMg6quTx+FEGOW4my9cZc0sOjjtuztY5NYx/17kw+3
	 G5+S97it+X6lMz7yHfg3UmUaVGB36iolNB8oDfL/GkTCJqj8ZOeb/52hlOxXaLtFip67y
	 NIfYLstetehPOFGWgV/lUO5VMfOKFOtJnPBGudppE8SdCGJTsd05/Y50LHVCNq0bRRW84
	 mAFJOTAkaOLUHzPYyikS0c5PsbyGGWYOEC6GfJne8jFYivdiTXp44Q6TcZdAIz13O5c4P
	 +Gb/ZdmHjuFW2gUq5XGbRrpHAo06V6kpiN/SmahAZ99Af4NwFY35H1B6F1sKd7Pu0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGEGSFf2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E43606A32C;
	Tue, 24 Nov 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGEGSFf2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22A41F00A01;
	Tue, 24 Nov 2026 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795517127;
	bh=hzR6M++7UtjG6jy2cgDIkbudvx9HYvO95GsCqnL8xxE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HGEGSFf2eRNaDxwZooS2w98FsY8/y8xBntEsgPw7bL1TbDOtxeiuYSg70jKZ8BrGG
	 hV+OC01miwgYDRrfpz71gYzzzIYhCKx3QLTGjlKpW6PHHhidaPbKNPE2Aixv0Ah0Zp
	 cKoLWaWPwF2KtIa2sXLVlEPdlbUmjcm4fJGhzF6DNTUmg3PFSxhKsW2mulCqmZoW4G
	 bFNR+mX9dbpN0D9mJQCkEK/3R+Kp8WSaD3OZZooWVGcGUvdT9+ipNg7Cr/EluzIKYl
	 l/sAmrJnuWX1EV0Hrv/Tu9+aqB60WJ5md1uxMCAcmPJiY64X+uCZSxK8DO/vC82hSE
	 VPp0Vn/mLvrRw==
Subject:
 Re: [PATCH ipsec v2] xfrm: use the frame's own socket in the too big checks
From: netdev-bot+sashiko@kernel.org
To: rmustafin@cloudlinux.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, ipsec@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 10:45:26 +0000
Message-ID: <179551712630.3135.52212996809224784@kernel.org>
In-Reply-To: <20261123104236.4179425-1-rmustafin@cloudlinux.com>
References: <20261123104236.4179425-1-rmustafin@cloudlinux.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix misses one of the too-big checks.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a kernel
  heap info leak on the same path.

--

xfrm: use the frame's own socket in the too big checks

This patch makes __xfrm6_output() test skb_to_full_sk(skb) instead of its
sk argument in both the IPV6_DONTFRAG check and the local error check. It
fixes a NULL pointer dereference in xfrm_local_error(). The dereference
happens when vxlan, geneve or another udp_tunnel6_xmit_skb() user forwards
a frame that has no skb->sk over an IPv6 tunnel mode xfrm bundle, and the
frame exceeds the MTU.

> diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
> index 44b221a09a0c8..d383116459089 100644
> --- a/net/ipv6/xfrm6_output.c
> +++ b/net/ipv6/xfrm6_output.c
> @@ -88,14 +88,14 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  	toobig = skb->len > mtu && !skb_is_gso(skb);
>  
> -	if (toobig && xfrm6_local_dontfrag(sk)) {
> +	if (toobig && xfrm6_local_dontfrag(skb_to_full_sk(skb))) {
>  		xfrm6_local_rxpmtu(skb, mtu);
>  		kfree_skb(skb);
>  		return -EMSGSIZE;
>  	} else if (toobig && xfrm6_noneed_fragment(skb)) {
>  		skb->ignore_df = 1;
>  		goto skip_frag;
> -	} else if (!skb->ignore_df && toobig && sk) {
> +	} else if (!skb->ignore_df && toobig && skb_to_full_sk(skb)) {

[Severity: High]

Does iptfs_is_too_big() in net/xfrm/xfrm_iptfs.c still have the same
mismatch? It tests the sk passed to dst_output(), not the frame's own
socket:

net/xfrm/xfrm_iptfs.c:iptfs_is_too_big() {
    ...
	if (sk)
		xfrm_local_error(skb, pmtu);
	else if (ip_hdr(skb)->version == 4)
		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(pmtu));
    ...
}

IP-TFS states replace dst->output in xfrm_bundle_create():

	dst1->output = xfrm[i]->mode_cbs->output;

As a result, __xfrm6_output() never runs for these frames, and the check
changed here does not cover them.

Take a frame forwarded into vxlan or geneve on an IPv6 underlay, routed
over an IP-TFS SA with dont_frag set:

udp_tunnel6_xmit_skb()
  ip6tunnel_xmit(sock6->sk, ...)
    ip6_local_out(net, sk, skb)
      dst_output()
        iptfs_output_collect(net, sk, skb)
          iptfs_is_too_big(sk, skb, pmtu)
            xfrm_local_error(skb, pmtu)

Here sk is the tunnel socket and skb->sk is NULL. Wouldn't
xfrm_local_error() then hit the same skb->sk->sk_family NULL dereference
shown in the trace in the commit message?

For IPv4, udp_tunnel_xmit_skb()->iptunnel_xmit()->ip_local_out() ends up
in xfrm4_local_error(). That function returns early because
skb_to_full_sk() is NULL. Since sk is non-NULL, the icmp_send() fallback
is skipped, so the frame seems to be dropped without a Frag Needed being
sent.

The subject says "use the frame's own socket in the too big checks", but
the commit message never mentions the IP-TFS site. It appears only in the
notes below the --- line, which won't go into git, even though two earlier
reviews pointed it out:

https://lore.kernel.org/all/20260908224856.1591189-1-kuba@kernel.org/
https://lore.kernel.org/all/179369310739.488856.16665150928122536725@kernel.org/

Could iptfs_is_too_big() get the same one line change to test
skb_to_full_sk(skb), either in this patch or in a companion patch?

[Severity: High]

This isn't a bug introduced by this patch, but this branch leads into
xfrm6_local_error(), which looks like it can leak kernel heap memory:

net/ipv6/xfrm6_output.c:xfrm6_local_error() {
    ...
	hdr = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
	fl6.fl6_dport = inet_sk(sk)->inet_dport;
	fl6.daddr = hdr->daddr;
    ...
}

Nothing checks that the inner packet is IPv6. The only family check is the
socket check in xfrm_local_error():

	else if (skb->protocol == htons(ETH_P_IPV6) &&
		 skb->sk->sk_family == AF_INET6)

An AF_INET6 UDP socket connected to a v4-mapped address passes this check
while it sends IPv4 packets.

Suppose such a socket has IPV6_RECVERR set and sends through a vxlan
device whose IPv6 underlay is routed over an IPv6 tunnel mode ESP bundle.

vxlan advertises NETIF_F_SG | NETIF_F_HW_CSUM. With MSG_SPLICE_PAGES or
MSG_ZEROCOPY, __ip_append_data() takes the paged path. The linear head
then holds only the 20 byte IPv4 header and the 8 byte UDP header, with
CHECKSUM_PARTIAL.

Along the way:

- skb_scrub_packet() in the same netns keeps skb->sk and clears ignore_df.
- iptunnel_handle_offloads() keeps encapsulation set for CHECKSUM_PARTIAL,
  and inner_network_header points at the inner IPv4 header.
- skb_tunnel_check_pmtu() returns 0 for local, non-bridged traffic.

Next, __xfrm6_output()->xfrm_local_error()->xfrm6_local_error() reads
hdr->daddr from offsets 24..39 of the inner IPv4 header. Bytes 24..27 are
the UDP length and checksum. Bytes 28..39 are past the skb tail, in
uninitialized tailroom of the head buffer.

ipv6_local_error() copies these bytes into the error skb. ip6_recv_error()
then returns them to userspace in sin6_addr when serr->port is non-zero,
which it is for a connected socket.

Can this expose up to 12 bytes of uninitialized slab memory per error to
an unprivileged user? It could be repeated, for example with
IP_PMTUDISC_PROBE so that every send exceeds the xfrm MTU.

Even without the paged path, isn't the reported address wrong, since an
IPv4 packet is being read as an ipv6hdr?

Before this patch, the local vxlan path already reached this code because
sk was the non-NULL tunnel socket. This patch keeps that path reachable;
it neither opens nor closes it.

>  		xfrm_local_error(skb, mtu);
>  		kfree_skb(skb);
>  		return -EMSGSIZE;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123104236.4179425-1-rmustafin%40cloudlinux.com
