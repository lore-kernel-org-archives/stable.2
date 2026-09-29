Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76389175A95;
	Tue, 29 Sep 2026 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640476; cv=none; b=IaxL8uwYAAG+VkCUmLE54Ize6CP/HOALeubIJsr8rKjFKE0I/S2Gs9NmxMU1eJbANwWRrPua1oGmyj4FLegC+ZPVhQWtUoZL/6uipAvzWpmShiYU0HPoFSe0Aukz5DY3jSFP15QBH/1trsIOZssAAZA+mUYSctFHBhPJdhOpjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640476; c=relaxed/simple;
	bh=eszMuzjSUoBmMtD7cpQURN1VHH+HMmyvsyMYtwiZ89w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5qFZzC4J0rPC3Mqdvac92hEB2+TDmxqEKqqEKlzYc1Fhjd4V/8v8pjrReZ6me9OecjGAoo18vBBZqLnxOav6zrASa7t5vWY25QOkKltEFknW1GwTXv2zkcBkc0x1Ohy0gv0+40buPCA6Car5BcheEKg8LD43jdIv+6k9Us1T68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFX/JoZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFX/JoZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7031F000FF;
	Tue, 29 Sep 2026 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640475;
	bh=p6CdxTYFaQ6PkQto7LRrk2p1Wt6bRQTe6yWxfoqoeTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CFX/JoZTZ3QG7By3JuVgEgUMz//yRHJST72KxFj+6KTGC3PYoZzvksEMOoWbXB7XC
	 Pv5ECnKOlZxPYT4zMcJ1wic4LoLwDEF/IQRqslaEz4C/T7Z+/uDvdnwi+z2OkIpgSU
	 tywfewMPdXyKRlxH86zP8DIjzWUlCkymJxbboePWHDOB2hL7dxFMkRvlMBsQDbxbcf
	 tHh5julaKXysfVCBf63444pmHNq+3KwY+LGZCU8xJpM+S3BqjxkW3avUGHtCWx3S3P
	 J1PpCACk+w7pgUqV7KNg51wiicqau95I0bbdR/pHZUsutrlV4SF1pVxSokm7zVPrXu
	 +Sk4A++byWIMg==
Subject:
 Re: [PATCH net v2] net: extend IPv6 exthdr detection of tunneled packets
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, xietangxin@yeah.net, willemb@google.com,
 stable@vger.kernel.org
Date: Tue, 29 Sep 2026 00:07:53 +0000
Message-ID: <179064047393.3145.16303551892146530587@kernel.org>
In-Reply-To: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
References: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: unnecessary software checksum fallback for outer UDP
  tunnels
- [Low] The old non-encapsulated branch cleared features only for
  SKB_GSO_TCPV6, or for SKB_GSO_UDP_L4 over IPv6.
- [Low] The in-tree NETIF_F_IPV6_CSUM contract
  (include/linux/skbuff.h:77-86) still says the feature covers only…

--

net: extend IPv6 exthdr detection of tunneled packets

This patch replaces skb_gso_has_extension_hdr() with
skb_has_ipv6_extension_hdr(). The new helper checks ipv6_ext_hdr() on the
outer IPv6 header and, when skb->encapsulation is set, on the inner IPv6
header, reading both through skb_header_pointer(). gso_features_check()
and skb_csum_hwoffload_help() now both use it.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc..aa74aa60ca2a7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3818,20 +3818,36 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
>  
> -static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
> -{
> -	if (!skb->encapsulation)
> -		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> -			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
> -			skb_transport_header_was_set(skb) &&
> -			skb_network_header_len(skb) != sizeof(struct ipv6hdr));

[ ... ]

> +static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
> +{
> +	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6)) {
> +		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
> +			return true;

[Severity: Low]

The removed non-encapsulated branch cleared features only for
SKB_GSO_TCPV6, or for SKB_GSO_UDP_L4 over IPv6. The new outer check has no
gso_type gate. Is it meant to apply to every IPv6 GSO type?

SKB_GSO_SCTP is one type whose behaviour changes. sctp_packet_pack()
always makes the GSO head CHECKSUM_PARTIAL:

net/sctp/output.c:sctp_packet_pack() {
    ...
	if (gso) {
		...
		goto chksum;
	}
    ...
chksum:
		head->ip_summed = CHECKSUM_PARTIAL;
		head->csum_not_inet = 1;
    ...
}

Take SCTP over IPv6 with IPV6_DSTOPTS or IPV6_RTHDR set.
gso_features_check() now clears NETIF_F_IPV6_CSUM. harmonize_features()
then sees ip_summed != CHECKSUM_NONE and
!can_checksum_protocol(features, ETH_P_IPV6). It strips all of
NETIF_F_CSUM_MASK, including NETIF_F_SCTP_CRC, plus NETIF_F_GSO_MASK:

validate_xmit_skb()
  netif_skb_features()
    gso_features_check()    /* clears NETIF_F_IPV6_CSUM */
    harmonize_features()    /* clears NETIF_F_CSUM_MASK, NETIF_F_GSO_MASK */
  skb_gso_segment()
    sctp_gso_segment()      /* CRC32c computed in software per segment */

Some devices have NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SCTP_CRC
but no NETIF_F_HW_CSUM. One example is hns3 without
HNAE3_DEV_SUPPORT_HW_TX_CSUM_B. On such a device the CRC32c was offloaded
before this patch and is computed in software after it. The output is
still correct, so only performance is affected.

Could the gso_type restriction be kept here? If not, could the commit
message say that the check now covers all IPv6 GSO types?

> +
> +		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
> +		if (!skb->encapsulation &&
> +		    skb_transport_header_was_set(skb) &&
> +		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
> +			return true;
> +	}

[ ... ]

> @@ -3988,8 +4004,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  		return 0;
>  
>  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> -		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
> -		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
> +		if (skb_has_ipv6_extension_hdr(skb))
>  			goto sw_checksum;
>  
>  		switch (skb->csum_offset) {

[Severity: Medium]
skb_has_ipv6_extension_hdr() checks the inner IPv6 header whenever
skb->encapsulation and the inner network header are set. That is right
for gso_features_check(), where the device computes the inner checksum
of every segment. Here it is applied regardless of which checksum is
being offloaded.

The commit message describes the case where this matters: if the inner
packet is CHECKSUM_NONE, the device offloads the outer UDP checksum.
csum_start then points at the outer UDP header and the device does not
need to parse any further.

Suppose the inner packet is IPv6 with, say, a Destination Options
header. The inner check still returns true, and the outer checksum is
now computed in software:

validate_xmit_skb()
  skb_csum_hwoffload_help()
    skb_has_ipv6_extension_hdr()
      __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb))
                          /* inner nexthdr == NEXTHDR_DEST */
    skb_checksum_help()   /* outer UDP csum in software */

Before this patch, skb_csum_hwoffload_help() only compared the outer
network header length, so the outer checksum was offloaded.

The same regression affects an IPv4 outer header on a NETIF_F_IP_CSUM
device. The old test never looked at those packets, because
vlan_get_protocol() returned ETH_P_IP.

The output is still correct, so this is a performance issue. Whether
it triggers depends on the contents of the inner packet.

For non-GSO skbs that are not CHECKSUM_PARTIAL,
iptunnel_handle_offloads() clears skb->encapsulation. That likely hides
this for the common in-tree tunnels, but the helper should not depend
on it.

Could the inner check be skipped here when the checksum being
offloaded is not the inner one? For example, it could be skipped when
skb_checksum_start_offset(skb) is below skb_inner_network_offset(skb).

Note that validate_xmit_skb() sets inner_transport_header to csum_start
just before calling skb_csum_hwoffload_help(). That field therefore
cannot tell the two cases apart.

[Severity: Low]

The NETIF_F_IPV6_CSUM description in include/linux/skbuff.h still says:

 *     - Driver (device) is only able to checksum plain
 *	 TCP or UDP packets over IPv6. These are specifically
 *	 unencapsulated packets of the form IPv6|TCP or
 *	 IPv6|UDP where the Next Header field in the IPv6
 *	 header is either TCP or UDP. IPv6 extension headers
 *	 are not supported with this feature.

skb_has_ipv6_extension_hdr() rejects only extension headers in the outer
and first inner IPv6 header. It also skips the length check when
skb->encapsulation is set. As a result, skb_csum_hwoffload_help() returns
0 for encapsulated packets whose outer nexthdr is GRE, UDP or IPv6.

Encapsulated GRE and UDP over IPv6 could already be offloaded before this
patch. The new case is IPv6|IPv6|TCP from ip6_tunnel with encaplimit
none. The old network-to-transport length check sent it to
skb_checksum_help(). Now it goes to the device.

The commit message says:

  A NETIF_F_IPV6_CSUM device must parse through the outer headers to
  reach the inner ones.

Should this requirement also go into the NETIF_F_IPV6_CSUM documentation
in skbuff.h? Driver authors who set the bit in hw_enc_features would then
know about it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926140506.2335137-1-willemdebruijn.kernel%40gmail.com
