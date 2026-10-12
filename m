Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE739FCBC;
	Mon, 12 Oct 2026 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778674; cv=none; b=LDRNBmaIBU7xeZneehZvpxPH2pLRB8ge0goiV6LbzQFti4nERSx63jX4+HiLTPFsMRnUhXHE6shPYP7kAspv2vqKTuCMQxVY6nhggCVOn3AxNndSR3limR8qNw/kfc7Mn60BCdSBfAfPpFb9iuao9nogtArYVYLCekuV8vRpCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778674; c=relaxed/simple;
	bh=CgkdFpAqCVRCzVE+PYz2IQijLTuFOPJsZpy0Kx8XkMo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0xDeDZzZtNCWMRwwxADupT0Aix6J3l9lY1uG+TBCHM3VaxPQLHmcskDGyf+/o4NYCHeUUsworY/zybDadoFKyb9APGcifwrgBxGRwXWYXYVBpnP4CInG0rkRM8k3flPEhv1IQ6vNDLpyRayQqDFZgRKZJ0iTu1NwKnYUQk03Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DunZAkjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DunZAkjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C691F0089C;
	Mon, 12 Oct 2026 04:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791778671;
	bh=asWLN1Q3IYBdzkpvxIJly5tsOqhiKd4PQpQGDPeSCyo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DunZAkjZozle8C+4Malie7WTuXhIK5A/h6K2akonxmUXnh8WNMTUtjY08fSPOQe26
	 YmfAX7e4+ykVQyxVbOLmMMB/lfqdU03/Iw04oed3t3OZCVe6ncdc42h5BRStGU60yU
	 R3DGNz0ADERwNwGWuCSVOgIuHJ3uQdAs5o1Wr3QlUohiipBz4VlfFcEBrl83+q+zrj
	 NJm6wWglIGJil82Ba9xrQOkPBYpb/w2DFV289YxpGIqgnVxNBJoRjJcpogVpkWU7K3
	 Uoiab6TZeIFxPbamohOOGEWvRmADIoIwpwEdISg1pF+Fph+GOS6BfCuvnnG+U1CcnO
	 /qtYb+qgsTjFw==
Subject:
 Re: [PATCH net] net: mpls: keep transport offsets valid across label changes
From: netdev-bot+sashiko@kernel.org
To: bestswngs@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, xmei5@asu.edu,
 ndaugoing@gmail.com, stable@vger.kernel.org, co+b3e1928dd33a1bd6@bugs.sh
Date: Mon, 12 Oct 2026 04:17:50 +0000
Message-ID: <179177867078.434549.277032987760934746@kernel.org>
In-Reply-To: <20261011041436.1424222-2-bestswngs@gmail.com>
References: <20261011041436.1424222-2-bestswngs@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The new `if (skb->encapsulation) return -EINVAL;` in
  skb_mpls_pop() (net/core/skbuff.c) rejects every encapsulated MPLS…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but nsh_pop()
  (net/nsh/nsh.c) leaves transport_header behind skb->data in the same…

--

net: mpls: keep transport offsets valid across label changes

This commit changes skb_mpls_push() and skb_mpls_pop(). After a label push
or pop, a transport header that sat at or before the old network header is
moved to the new network header. The commit also makes skb_mpls_pop() reject
encapsulated skbs and refresh mac_len after a pop. The goal is to prevent the
negative skb_transport_offset() that makes qdisc_pkt_len_segs_init()
dereference about 4 GiB past skb->data.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..eb49201534fff 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -6676,6 +6681,10 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
>  	if (unlikely(!eth_p_mpls(skb->protocol)))
>  		return 0;
>  
> +	/* Networking stack does not allow simultaneous Tunnel and MPLS GSO. */
> +	if (skb->encapsulation)
> +		return -EINVAL;

[Severity: Low]
Will this drop non-GSO encapsulated MPLS packets that were popped and
forwarded before this patch?

The crash only happens with GSO skbs. qdisc_pkt_len_segs_init() returns
before it reads either transport offset when gso_size is 0. Also, a pop only
moves bytes up to the MAC header, so the absolute inner header positions
stay the same.

Encapsulated MPLS skbs can exist in tree. Take a locally generated VXLAN or
GRE packet with an inner CHECKSUM_PARTIAL that is not GSO: it keeps
skb->encapsulation set, because iptunnel_handle_offloads() only clears the
flag when ip_summed != CHECKSUM_PARTIAL. If the outer route uses an MPLS
lwtunnel, mpls_xmit() does:

	skb->dev = out_dev;
	skb->protocol = htons(ETH_P_MPLS_UC);

and does not clear skb->encapsulation. skb_scrub_packet() does not clear it
either when the skb crosses a veth into another netns.

If tc act_mpls pop or OVS pop_mpls then handles that packet, skb_mpls_pop()
now returns -EINVAL, and tcf_mpls_act() drops the packet:

	case TCA_MPLS_ACT_POP:
		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
				 skb->dev && skb->dev->type == ARPHRD_ETHER))
			goto drop;

The commit message says this is deliberate, to match skb_mpls_push(), which
already rejects all encapsulated skbs. This topology is also unusual.

Since this is going to stable, would a narrower check such as
skb_is_gso(skb) && skb->encapsulation close the crash without these drops?

> +
>  	err = skb_ensure_writable(skb, mac_len + MPLS_HLEN);
>  	if (unlikely(err))
>  		return err;
> @@ -6687,6 +6696,10 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
>  	__skb_pull(skb, MPLS_HLEN);
>  	skb_reset_mac_header(skb);
>  	skb_set_network_header(skb, mac_len);
> +	if (skb_transport_header_was_set(skb) &&
> +	    skb->transport_header <= skb->network_header)
> +		skb->transport_header = skb->network_header;
> +	skb_reset_mac_len(skb);

[Severity: High]
Is this fix complete? The subject says transport offsets stay valid across
label changes. However, mpls_forward() in net/mpls/af_mpls.c also pops a
label without moving skb->transport_header or checking skb->encapsulation:

net/mpls/af_mpls.c:mpls_forward() {
    ...
	/* Pop the label */
	skb_pull(skb, sizeof(*hdr));
	skb_reset_network_header(skb);
    ...
		skb_push(skb, new_header_size);
		skb_reset_network_header(skb);
    ...
}

If the route has no outgoing labels and the label is not BOS, nothing is
pushed back. The skb then goes to neigh_xmit() with transport_header behind
network_header.

Here is a single-hop sequence that looks reachable:

1. A tap writer sends a VID 0 tagged MPLS frame with a vnet header that has
   NEEDS_CSUM, gso_type TCPV4, csum_start=20 and csum_offset=16.
   __virtio_net_hdr_to_skb() does not check the protocol, so
   transport_header ends up at mac+20.

2. skb_vlan_untag() moves network_header to mac+18 but keeps the
   transport_header that is already set. transport_header now sits inside
   the first label.

3. mpls_forward() pops that label. network_header moves to 22 and
   transport_header stays at 20.

4. The route is "ip -f mpls route add L dev tunX", with no via and no
   labels. neigh_xmit(NEIGH_LINK_TABLE) calls dev_hard_header(), which does
   nothing for an IFF_TUN device, and then dev_queue_xmit().

5. __dev_queue_xmit() resets mac_header to data. Then, in
   qdisc_pkt_len_segs_init():

	hdr_len = skb_transport_offset(skb);
	...
		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;

		th = (const struct tcphdr *)(skb->data + hdr_len);

   hdr_len is (unsigned)-2, so the pskb_may_pull() length wraps to 18 and
   the check passes. th then points about 4 GiB past skb->data, which is the
   same oops as in the commit message.

mpls_pkt_too_big() does not catch this, because it only validates GSO skbs
when skb->len > mtu.

Multi-hop paths over veth reach the same state, since each hop pops another
4 bytes. A clsact sch_handle_ingress() on the peer also calls
qdisc_pkt_len_segs_init().

An encapsulated skb in mpls_forward() also keeps stale
inner_transport_header metadata.

The tun device, MPLS routes and the related sysctls only need CAP_NET_ADMIN
in a netns owned by a user namespace.

Could mpls_forward() get the same adjustment? Alternatively,
qdisc_pkt_len_segs_init() could reject a negative transport offset itself.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. nsh_pop()
in net/nsh/nsh.c also leaves transport_header behind skb->data, and the skb
reaches the same qdisc_pkt_len_segs_init() consumer:

net/nsh/nsh.c:nsh_pop() {
    ...
	skb_pull_rcsum(skb, length);
	skb_reset_mac_header(skb);
	skb_reset_network_header(skb);
	skb_reset_mac_len(skb);
    ...
}

Here is a possible trigger:

1. A tap writer sends an ETH_P_NSH frame with a vnet header that has
   NEEDS_CSUM, gso_type TCPV4, csum_start=20 and csum_offset=16.
   __virtio_net_hdr_to_skb() does not check the protocol on the NEEDS_CSUM
   path, so transport_header lands inside the 8-byte NSH header.

2. The tap is an OVS netdev vport. key_extract() leaves transport_header
   alone for non-IP eth types.

3. A flow runs with pop_eth, pop_nsh (np = TUN_P_ETHERNET) and output to an
   Ethernet netdev vport. pop_nsh() only invalidates the flow key, and
   do_output() -> ovs_vport_send() -> dev_queue_xmit() runs without
   extracting the key again.

4. qdisc_pkt_len_segs_init() sees skb_transport_offset() == -2 and reads
   about 4 GiB past skb->data, as described above.

OVS genl commands use GENL_UNS_ADMIN_PERM, so this can also be triggered
from inside a user namespace.

This patch fixes producers of the bad offset one at a time. Would a check
in qdisc_pkt_len_segs_init() cover all of them? It could drop skbs with a
negative transport or inner transport offset, using
SKB_DROP_REASON_SKB_BAD_GSO.

>  
>  	if (ethernet && mac_len >= ETH_HLEN) {
>  		struct ethhdr *hdr;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011041436.1424222-2-bestswngs%40gmail.com
