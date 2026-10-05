Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33834A260B;
	Mon,  5 Oct 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212118; cv=none; b=lOAcqdmlMDlBQp5iev62+RBS/woask7oCL1qntbIORfeLgZCPQRrrEA5DngRpKZcD3Y9lcOysTvlb2NDpSSsuBZzISe/9jezQ32eOP7YMlizen1pPjPcw6n5NPRQO8c8okV+mkDTNYo6HmMn//vLclvN25tZcHeH7DZEFvSA+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212118; c=relaxed/simple;
	bh=LMHf96mDX/Hz+lwct1zv89lYiBr0I7S4BGrBw7/kvSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSAIPqmBO9Cb+hdplezx/gad8L3fMrEkP4S1uvGUzPls1GMHJlb0phk5Ag43sPAC8mofKqSzZtGZPk+sTN4Y7TOvuc/gwKkhFYGWQwcnO/3tSEjTG9VRGeMBL+BoEQnKyEAOwcyZhqrjfoQJFJOCCtVfwrGcgwrwoGFqzWyn9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/wHWk4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/wHWk4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C771F00893;
	Mon,  5 Oct 2026 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212112;
	bh=vpOmNC/2ZLcT4VnPNQrb9R9hSpyseE66F2HsXbR3ZzE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V/wHWk4i4D/7R4dGjPBPVrN8O474fHDYA4pW0JeaNQiHziA5kuu3roNKiRFk+0H1q
	 YRULJkxA98sCW2hDcDGgmMU48L3pDkmYbqQoqlED/TjKEv0mAsDVaYLR7zumHV1hxt
	 cOOtzst7xpp0ijwfs4z2ZMNNcxxvrfQ6CIiOWEcFhSfxweA/O4YN+uuohDHYF3WUrR
	 f7aDwbXKpaSac6XLIvJ2oghbphcVwTwNGkZJfMTIMLs+34NkmHd2K2gE3zGsUXXWpL
	 b/TJSnWj7TfBT+w1mSp3FWWY9tvIN/OkZ7rdN5ViUnvth59j7pUI0j7NgRD7YxY9ON
	 oxYITUz6nxkdQ==
Subject: Re: [PATCH net v4] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, fw@strlen.de, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, mazin@getstate.dev, matthias.may@westermo.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 14:55:11 +0000
Message-ID: <179121211133.434549.1381649683777834470@kernel.org>
In-Reply-To: <20261004145205.226974-1-littlesmilingcloud@gmail.com>
References: <20261004145205.226974-1-littlesmilingcloud@gmail.com>
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

Critical: 0 · High: 2 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The check/parse mismatch the commit says it fixes is still
  reachable in ip6gre_tunnel_xmit() on ip6gre devices that have…
- [High] One of the parses this patch is meant to protect is the one
  added by Fixes: b09ab9c92e50, i.e. payload_protocol =…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the IPv4 GRE
  transmit paths have the same check/parse mismatch, and the patch…
- [Medium] This problem wasn't introduced by this patch, but on
  ip6erspan, frames that are not resolved to IPv4/IPv6 pass the new…

--

ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()

This patch replaces pskb_inet_may_pull() with skb_vlan_inet_prepare() in
ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit(). Before the check it
clears skb->mac_len on Ethernet devices. pskb_inet_may_pull() is still
used for ip6gre devices that have header_ops.

Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index e61cb10b50dc9..f48141820fb5a 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -883,8 +883,22 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
>  	__be16 payload_protocol;
>  	int ret;
>  
> -	if (!pskb_inet_may_pull(skb))
> -		goto tx_err;
> +	if (dev->type != ARPHRD_ETHER && dev->header_ops) {
> +		/* ip6gre_header() has pushed a pseudo header in front of
> +		 * the packet, so skb->data is not where the packet starts.
> +		 */
> +		if (!pskb_inet_may_pull(skb))
> +			goto tx_err;

[Severity: High]
Can the VLAN check/parse mismatch still be reached on this branch?

ip6gre_tunnel_init() installs header_ops only when the device is created
without a remote:

    if (ipv6_addr_any(&tunnel->parms.raddr))
        dev->header_ops = &ip6gre_header_ops;

Nothing clears it later. If ip6gre_changelink()->ip6gre_tnl_change() then
sets a remote, ip6gre_tnl_link_config_common() recomputes
IP6_TNL_F_CAP_XMIT. ip6_tnl_xmit_ctl() then passes, and packets still take
this branch.

When skb->protocol == ETH_P_8021Q, pskb_inet_may_pull() uses nhlen = 0 and
checks nothing. The dispatch further down still does:

    payload_protocol = skb_protocol(skb, true);

With mac_len == 0, that walk reads a vlan_hdr at skb->data + ETH_HLEN. That
location is inside the pseudo IPv6 header that ip6gre_header() pushed. The
encapsulated protocol it returns is saddr bytes 8-9, and those come from
t->parms.laddr:

    ipv6h->saddr = t->parms.laddr;

So if the user picks a laddr such as 2001:db8:0:0:86dd::1, the walk returns
ETH_P_IPV6.

One way to get there is AF_PACKET SOCK_DGRAM with sll_protocol set to
htons(ETH_P_8021Q), a non-zero sll_addr and an empty payload.
packet_snd() resets the network header before dev_hard_header(), so the
network header points at the empty payload. ip6gre_xmit_ipv6() then reads
past skb->tail:

    if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
        return -1;

prepare_ip6gre_xmit_ipv6() also reads nexthdr, dsfield and flowlabel from
the same unpulled bytes. If the protocol is ETH_P_IP instead,
prepare_ip6gre_xmit_ipv4() reads the tos.

KMSAN would report uninit-value here. With USE_ORIG_TCLASS or
USE_ORIG_FLOWLABEL, the stale bytes can be copied into the outer header.

There is a separate case on the same kind of device. When it receives a
frame through tc mirred or bpf redirect, ip6gre_header() is skipped, and
__gre6_xmit() reads this without any length guarantee:

    if (dev->header_ops && dev->type == ARPHRD_IP6GRE)
        fl6->daddr = ((struct ipv6hdr *)skb->data)->daddr;

NBMA devices that still have no remote don't seem to be affected.
ip6_tnl_get_cap() returns only CAP_PER_PACKET when raddr is any, so
ip6_tnl_xmit_ctl() rejects them.

The commit message names this mismatch in ip6gre_tunnel_xmit(). Does this
branch need a VLAN-aware check measured from the existing network offset?
Alternatively, should VLAN ethertypes not be treated as IP here?

> +	} else {
> +		/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN,
> +		 * or at ETH_HLEN if it is 0, and a forwarded skb still has
> +		 * the mac_len of the device it was received on.
> +		 */
> +		if (dev->type == ARPHRD_ETHER)
> +			skb->mac_len = 0;
> +		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
> +			goto tx_err;
> +	}

[Severity: High]
Does clearing mac_len here match the walk in ip6_tnl_xmit() that the second
Fixes tag (b09ab9c92e50) added?

That walk runs after the tunnel headers have been pushed:

__gre6_xmit()
    gre_build_header()
        skb_push(skb, hdr_len);
    ip6_tnl_xmit()
        payload_protocol = skb_protocol(skb, true);

skb_push() moves skb->data but does not change skb->protocol or mac_len.
With mac_len now 0, __vlan_get_protocol_offset() reads its vlan_hdr at
skb->data + ETH_HLEN, counted from the GRE header. skb_vlan_inet_prepare()
checked the Ethernet frame instead.

With a 4-byte GRE header the read happens to land on the TPID. In the
other cases it reads MAC address bytes:

  - tun_hlen 8 (key or seq): source MAC bytes 2-3
  - tun_hlen 12: destination MAC bytes 4-5
  - ip6erspan, after 16 pushed bytes: destination MAC bytes 0-1

Take ip6gretap with a key and an 18-byte VLAN-tagged ARP frame.
skb_vlan_inet_prepare() pulls 18 bytes and lets it through. If the source
MAC is xx:xx:08:00:xx:xx, ip6_tnl_xmit() treats payload_protocol as
ETH_P_IP.

hop_limit is 0 by default over netlink when IFLA_GRE_TTL is omitted, and
also for a collect_md key with ttl 0. In that case ip6_tnl_xmit() does:

    if (hop_limit == 0) {
        if (payload_protocol == htons(ETH_P_IP))
            hop_limit = ip_hdr(skb)->ttl;

This reads past the end of the frame and puts that byte in the outer IPv6
header.

The same applies to ip6erspan_tunnel_xmit(). There, the ip6_tnl_xmit()
walk is the only VLAN-aware parse after the check. So the base described
in the new comment ("The VLAN tag walks below start at ...") doesn't seem
to hold for it.

The NBMA daddr parsing in ip6_tnl_xmit() can't be reached here.
ip6_tnl_xmit_ctl() drops raddr == any first, and collect_md skips that
block.

Should the payload protocol be computed before the header push, or taken
from the network header that skb_vlan_inet_prepare() set?

>  
>  	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>  		goto tx_err;
> @@ -934,7 +948,12 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  	__u32 mtu;
>  	int nhoff;
>  
> -	if (!pskb_inet_may_pull(skb))
> +	/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN, or at
> +	 * ETH_HLEN if it is 0, and a forwarded skb still has the mac_len of
> +	 * the device it was received on.
> +	 */
> +	skb->mac_len = 0;
> +	if (skb_vlan_inet_prepare(skb, false))
>  		goto tx_err;

[Severity: Medium]
This is a pre-existing issue, but on ip6erspan, frames that don't resolve
to IPv4 or IPv6 still get through with only ETH_HLEN bytes guaranteed.

skb_vlan_inet_prepare(skb, false) starts with maclen = ETH_HLEN and adds
nhlen only for IP. For a VLAN-tagged frame of 14 to 17 bytes,
__vlan_get_protocol_offset() fails in skb_header_pointer(), and
vlan_get_protocol_offset_inline() leaves depth unset:

    if (depth && res.type)
        *depth = res.depth;

So pskb_may_pull(14) succeeds, and the network header is set at offset 14.

ip6erspan_tunnel_xmit() then calls erspan_build_header() or
erspan_build_header_v2(), which do:

    tos = is_ipv4 ? ip_hdr(skb)->tos :
            (ipv6_hdr(skb)->priority << 4) +
            (ipv6_hdr(skb)->flow_lbl[0] >> 4);
    ...
    if (eth->h_proto == htons(ETH_P_8021Q)) {
        qp = (struct qtag_prefix *)(skb->data + 2 * ETH_ALEN);
        vlan_tci = ntohs(qp->tci);

Both reads hit skb->data[14..15], past skb->len, and the stale bytes are
sent in the ERSPAN COS and VLAN fields. The tos read also happens for an
untagged 14-byte non-IP frame.

This patch is still an improvement here: before it, the 10-byte frame
from the commit message was not dropped either.

Should ip6erspan_tunnel_xmit() require enough bytes for these reads in
erspan_build_header()?

[ ... ]

[Severity: Medium]
This isn't a bug introduced by this patch, but do the IPv4 GRE transmit
paths have the same check/parse mismatch?

ipgre_xmit(), erspan_xmit() and gre_tap_xmit() in net/ipv4/ip_gre.c still
begin with:

    if (!pskb_inet_may_pull(skb))
        goto free_skb;

That check uses nhlen = 0 for ETH_P_8021Q and ETH_P_8021AD.
ip_tunnel_xmit() then does payload_protocol = skb_protocol(skb, true). If
the walk returns IPv4 or IPv6, it reads
inner_iph = skb_inner_network_header(skb). By then
gre_handle_offloads()->iptunnel_handle_offloads()->skb_reset_inner_headers()
has made that equal to the network header.

The fields it reads include tos (tos inherit), frag_off (unless ignore_df),
ttl or hop_limit (ttl inherit) and, on NBMA, daddr:

    if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
        df |= (inner_iph->frag_off & htons(IP_DF));
    ...
        if (payload_protocol == htons(ETH_P_IP))
            ttl = inner_iph->ttl;

For example, send an 18-byte tagged frame with AF_PACKET SOCK_RAW on
gretap. packet_parse_headers() sets the network header at 18, so the
frag_off and ttl reads land past skb->len. Native IPv4 erspan v1 also
reads ip_hdr(skb)->tos in erspan_build_header().

The IPv4 side came from the IPv4 counterpart of b09ab9c92e50. Was ip_gre.c
looked at as part of this change, or would it need a similar follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004145205.226974-1-littlesmilingcloud%40gmail.com
