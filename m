Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CE442376;
	Mon, 21 Sep 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977135; cv=none; b=NeZEZUNIqTXp0GvE81UHE2E0OcKHV3yxq28TXY8mKXucC8zQswlFRnQZG/1BrYJ87T98tKlzavD6S5UqKRRYUDbuFy4NpNUq6LoNPPEzlP3XWHlCvrhQtYyq6SKwjoSQgxcoAP/DaYcNg6F+uY2yKmaF58qdaAwLhYXgXx9b2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977135; c=relaxed/simple;
	bh=NMlgFTLxbCvq2LWyhTPvexRgP1j6mhv+TA3qcvvEjaA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Crb0sJdPQpUt0HtdUaegRlz6qgZXJDFhfAw+LUuXp3YdcatTpdrA8YnfSG8PCrCn2JyVdRmXmwvMQzUZCyKVl/JYEBaVKUZlaa7xr4CyhBeiXBMGMsxdA24jjS+HVein2QCCCnwigpKsarvCJUvS/iusN0mD5ONH5dRWEMyTx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofiqzLic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofiqzLic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAE21F000FF;
	Mon, 21 Sep 2026 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977132;
	bh=55c1QkG4fsfIs1XKlJIP6tOtu8CGAPjj2WVC5czzpN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ofiqzLictosPQHRCfMccRuimEMRP8duMaFr9nKeXwsXGNKUFLCoOR0VeVnRxHGriy
	 vTjkx7ZQv6979HpzZ8BNXV+ClQgEaWHvhFMqdDfU2Jlgoaml3aBeRYXA9w6gwlqMe8
	 2CNaViBWz0RqQzISqzI569Rn+l/qxtxprVWK7ko1/P6f0kFVjjbNGXY1eTS+XbCxS4
	 OJ9GWs/MAfJldIJwz5riKJPVFeQy1RKg8Z/siwO/MyZAq8UoAxN/a7qa5K1jkgSu6K
	 ArwWDvjYbRQKYNACHhmp1hHYKRKgYlgaoX3rBit1hUuCXFeL3OjdhLx7mRyiCcHB7j
	 Pkm1v4ywJmA+Q==
Subject: Re: [PATCH] xfrm: validate ihl in xfrm4_transport_output()
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 21 Sep 2026 07:52:12 +0000
Message-ID: <178997713210.2160803.14018605703606783403@kernel.org>
In-Reply-To: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/xfrm/xfrm_output.c:69-70, xfrm4_transport_output(): the new
  guard validates the attacker-controlled IPv4 header length against…

Pre-existing issues:
- [Medium] net/xfrm/xfrm_output.c:66-81, xfrm4_transport_output(): only
  an upper bound on ihl is added, so iph->ihl values 0..4 (ihl = 0..16…

--

xfrm: validate ihl in xfrm4_transport_output()

This adds a bounds check on the IPv4 header length read from the packet in
xfrm4_transport_output(), rejecting the packet with -EINVAL when ihl exceeds
skb->len, before the header relocation done by __skb_pull() and memmove().
The stated goal is to close a local denial of service reachable by injecting
frames into an xfrm interface, for example with AF_PACKET on an xfrmi device.

> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e305ba32e356b..3abb21d113a45 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -66,6 +66,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
>  	struct iphdr *iph = ip_hdr(skb);
>  	int ihl = iph->ihl * 4;
>  
> +	if (ihl > skb->len)
> +		return -EINVAL;
> +

[Severity: High]
Is skb->len the right bound here?  skb->len covers the paged fragment data
too, but the two operations further down in xfrm4_transport_output() need
the linear head length:

net/xfrm/xfrm_output.c:xfrm4_transport_output()
	skb->transport_header = skb->network_header + ihl;
	__skb_pull(skb, ihl);
	memmove(skb_network_header(skb), iph, ihl);

include/linux/skbuff.h:__skb_pull()
	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();
	}

So for any skb where skb_headlen(skb) < ihl <= skb->len, the new check
passes and __skb_pull() still drives skb->len below skb->data_len and
BUG()s, and the memmove() source range still runs past skb->tail.

Can the injection vector named in the changelog produce exactly such an
skb?  In packet_snd() the linear length is attacker controlled:

net/packet/af_packet.c:packet_snd()
	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
	linear = max(linear, min_t(int, len, hard_header_len));

xfrmi_dev_setup() never calls ether_setup(), so hard_header_len is 0 and
linear stays at hdr_len, and packet_alloc_skb() keeps the rest paged:

net/packet/af_packet.c:packet_alloc_skb()
	if (prepad + len < PAGE_SIZE || !linear)
		linear = len;
	...
	skb_put(skb, linear);
	skb->data_len = len - linear;

With hdr_len = 1 and len larger than PAGE_SIZE, skb_headlen(skb) is 1 and
the single linear byte is the attacker's version/ihl byte.

Does anything linearize the skb before the pull?  xfrmi_dev_init() sets
NETIF_F_SG | NETIF_F_FRAGLIST, so skb_needs_linearize() is false, and
xfrm_output_one() only calls xfrm_skb_check_space() (pskb_expand_head(),
which does not linearize) before xfrm_outer_mode_output().

Would using the linear bound instead work, i.e.

	if (ihl > skb_headlen(skb))
		return -EINVAL;

or

	if (!pskb_may_pull(skb, ihl))
		return -EINVAL;

which also makes the memmove() source in-bounds?

[Severity: Medium]
This isn't a bug introduced by this patch, but since the check being added
here is the ihl validation, should it also enforce a lower bound?  Only the
upper bound is checked, so iph->ihl values 0..4 (0..16 bytes, less than
sizeof(struct iphdr)) are still accepted.

The changelog points at the validation in ip_rcv_core(), which rejects both
directions:

net/ipv4/ip_input.c:ip_rcv_core()
	if (iph->ihl < 5 || iph->version != 4)
		goto inhdr_error;

and sibling xfrm4 code already assumes ihl >= 5:

net/xfrm/xfrm_inout.h:xfrm4_extract_header()
	XFRM_MODE_SKB_CB(skb)->optlen = iph->ihl * 4 - sizeof(*iph);

Can a short ihl leak uninitialized headroom?  In
xfrm4_transport_output() mac_header is placed at a fixed offset while only
ihl bytes are relocated:

	skb->mac_header = skb->network_header +
			  offsetof(struct iphdr, protocol);
	...
	memmove(skb_network_header(skb), iph, ihl);

offsetof(struct iphdr, protocol) is 9, so for iph->ihl <= 2 the byte at
skb_mac_header() is never written, and esp_output() reads it:

net/ipv4/esp4.c:esp_output()
	esp.proto = *skb_mac_header(skb);
	*skb_mac_header(skb) = IPPROTO_ESP;

esp_output_head() then puts that value on the wire:

	esp_output_fill_trailer(tail, esp->tfclen, esp->plen, esp->proto);

For iph->ihl == 2 the emitted outer header bytes covering check/saddr/daddr
are similarly never-initialized headroom, apart from tot_len and check
being rewritten by __ip_local_out()/ip_send_check().

On reachability, the IP_HDRINCL raw path cannot deliver this because
raw_send_hdrinc() rejects it:

net/ipv4/raw.c:raw_send_hdrinc()
	if (iphlen > length || iphlen < sizeof(*iph))
		goto error_free;

and for the AF_PACKET/xfrmi path the flow dissector bails out on short ihl:

net/core/flow_dissector.c:__skb_flow_dissect()
		if (!iph || iph->ihl < 5) {
			fdret = FLOW_DISSECT_RET_OUT_BAD;

which leaves decode_session4() with an all-zero flowi4, so a wildcard
(0.0.0.0) transport-mode policy and SA would additionally have to be
selected.  I could not establish that such a state cannot be installed, so
would adding an ihl < sizeof(struct iphdr) rejection alongside the new
check be worthwhile?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917072226.80788-1-q.h.hack.winter%40gmail.com
