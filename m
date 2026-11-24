Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481752;
	b=lcycdMlUmbCFe793D6XpMjKa6f3p+mGTY6zJfu4z4KJP68sdJlhKentqslQGY7H6WCPB
	 EAki9aXIPAlch6KGsAvWVoFpkPir9s0HqR4rAymsCeLDOyVWHc9YUn8kHril+vYooeiVB
	 YQU9gUldxbeHbvXxZCj7KLNDN0P0UT++55A5CZpQcM0pdEQb77tP6uPuELSgLu9ZtdWHn
	 /H1Yvpt5DoUuMcyn3K9yiCQJz3wXCLlHyg2IiJviL+Imp2IfhsjXz3ca9q8JQ8toisN5t
	 EJmDAMbUUh5jIp2RLIPJc87IxGBiVO/B/VyHRgJLFAxuRbtqALVFk/YqNhEuVWUgTug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G9FzbT/zJBdbcTMwuCKv/u2XIeFkphN379eodz2mpIw=;
	b=Rd1fJA8L6ZtqjZplgXQsJ7xkS8WaA8t1W1EDspTvoVu/TLspud8kN16+BAxcMbkEdW4Q
	 FCXQmiF4+AFhmeAcP+iAhOd7y33oeQdAhdRqRbb68U8n6bBCa55oGoXcAfnWLra7kkB+b
	 mrxUDUmdR6UdOs/WqN2lveuPTXPU/UJJ/xBujgTqaDuKS6jWH5YahGEZmSkFgNYuhQKN1
	 L6SgQvXsjs7re3s68zhGZ0qhHEoAmrwBtYeF46mX1AW8ilOL+fkLBzwXLK2Td2dNwrW20
	 n/8Gp/ZvRfSOov88zb9ZB/KNNzaE5Mxnjc5mtEbn7dYqUxdPJRkrSPgLHcoqA4zjkYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHKdUv7V;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3C606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHKdUv7V
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-94958650b09so395720885a.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795481751; x=1796086551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G9FzbT/zJBdbcTMwuCKv/u2XIeFkphN379eodz2mpIw=;
        b=WHKdUv7VI2ka8Hv6xmfPtJrAyFhu1sa+j6HxyLbkAHBmiFpGQ4zjvZoi2zhH+kt2PR
         SGzMa0ckh2n5RY7b72rWzY+qlJQwUlEpRwCPO8Go+yKELj6uiDfJnDxg1LRNtsKMRPCO
         ePWyqC/Ma2UUlruQULuiCRbULB1BoqKLDa+eUolmBqJ7U9YXtGF6rWCutehEF3cnXr3+
         ZooGkM6uxtEefYsMuDAEg73hknyG+cBeAvBgiYsPp823Kbltm6gxEOMRd2OtELuoOYx8
         3lyb31YHsme47hBEwh9sE7BOfb8R16BmRbUNbAwXNmtLVXgmMGIKjAvyZX6amQJDuVa1
         TYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481751; x=1796086551;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9FzbT/zJBdbcTMwuCKv/u2XIeFkphN379eodz2mpIw=;
        b=2AWfslvggOj04qf47cZfsc5UbDCZrGSj676LDiSdUVAnM6h4PFSiNBklNju5BGKga7
         euCeZRsWf7YjxjY4fkSYH5VHitRJgStbnzu5MlCtvnNkrGqRnAmFEVR4l2oHVO1F3JAu
         /wUi6EK94VA02wNfe5qkGvwXrIP4Rwkp5OXnwkTVNE/n5Z7BE/mq3/WIRr+Xu8r5zUqv
         9bZ+wFrX+9iECbweGiBH666B2JCbICCE3atcHBJMNBfntJePhvb3HgYNvUlv+l+cvikW
         jDScgENivdJhDxaADtybW6PzAl/SZAy5aOBskNLPhEr9KO0fSvs1UO8qtsfBqma/lTiu
         alag==
X-Forwarded-Encrypted: i=1; AL+hErFe+sCyhDKGtwje+66XGIkeecVGwJayj7sDVNLsjT5+PrwWr8INMp12x+U82ORuGbprmDP5RIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KmvMa8HII+UIU5/blJGxXP9bORqQUtihUwRYLjtGX334nUs9u
	I/ukt5yLOSNuADHwCQ+3gB9AJsA3gNdFzQl8+ZQsafv5IOBH6Aj4llU/
X-Gm-Gg: AZFdTZflNXA2RPLpq4Ca94wCFIAanJGTwHCVUtiD0XarLNrRqB8aIu8JqktYOdWb8CR
	MyUAGEo5UMOG3IVdh5RAjkjkywKwiR1AEDVO/aF6jycTBE2opsDnxY9t6z66e9VytLHaLC/LEy7
	CyzL2YJuK/UUCddQ6LtruS0nLR3GJ7VgJuzrR5uDHlLbF4DSJn4Zt3eMipndkMVYp7gldlS4+e2
	LhB5zn0K0OmE52gozWCaL3PeGFAavS/x5elmciMSJmGYQGXcFs3mPRxurfzCEoDxlKivggn3sDg
	MrinRhefbOxseMBmfV9/sNr+ZZ4C5qiWVDtLCl0fCSwjucadFtW71sDRsUqwOwqxb+pUuPPnsGr
	NkR7ySusZvA1yBL9jiEmzy0sD/HwD/k6KOmBVrjVmmr3xo7hmDPl3i5Sj9K3Sk3tqLICVc6tTOJ
	D5l+v1eMy2lebK73UBm8dOKnva8TOFCueSRJE5H2Xlq8o20C9hZAA5Nkg/Zw4wxFdIu98pMkMSP
	lKx1jo98Vf/PzdzSe8C5gl8wBDHUmGgla5TZctnf0VL6B4g32WXjePPKj/o0PAKrb6uJJ4riQBN
	SBSJw8HIwE0SmhNhzr0zrsxir4/ZsK/4byjmnom0RuDJvOpU998lF2IjjMVeqIQBWj85x2N7IPw
	FvX/SjPdWGzq49HQNanR5JSbb5r415rUxgvO0bhHV0VBCZv2em0mtTnWko1lv9Dw=
X-Received: by 2002:a05:620a:1992:b0:949:743e:9149 with SMTP id af79cd13be357-949ba8239bdmr2301367185a.6.1795481751033;
        Mon, 23 Nov 2026 16:55:51 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40efc4sm921340685a.36.2026.11.23.16.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 16:55:50 -0800 (PST)
Date: Mon, 23 Nov 2026 19:55:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Julius Bairaktaris <julius@bairaktaris.de>, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 stable@vger.kernel.org, 
 hassansultan@google.com
Message-ID: <willemdebruijn.kernel.609ac1383a60@gmail.com>
In-Reply-To: <20261122164204.4058652-1-julius@bairaktaris.de>
References: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com>
 <20261120044733.222627-3-willemdebruijn.kernel@gmail.com>
 <20261122164204.4058652-1-julius@bairaktaris.de>
Subject: Re: [PATCH net v2 2/2] net: gso: fall back to skb_segment when
 fraglist cannot satisfy checksum
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Julius Bairaktaris wrote:
> Willem de Bruijn wrote:
> > 1. Outer tunnel checksums. __skb_udp_tunnel_segment() and
> >    gre_gso_segment() compute these with gso_make_checksum(), which
> >    reads stale SKB_GSO_CB() state, and needs an inner payload sum tha=
t
> >    skb_segment_list() does not compute.
> =

> Patch 2/5 of my "ipmr: forward GSO multicast packets" v6 changes the
> same three conditions for this case. With this series on net, the case
> from 2/5 (TCP from a local udpcsum VXLAN device, CHECKSUM_PARTIAL
> aggregates, forwarded with rx-gro-list on) leaves no wrong outer
> checksum, 3 of 3 cases in 2 runs, so 2/5 is not needed on top of it.
> The other four patches apply unchanged on top of this series.
> =

> https://lore.kernel.org/netdev/cover.1795295554.git.julius@bairaktaris.=
de/

Good catch.

> > +	/* Tunnel headers and outer checksums are not rebuilt */
> > +	if (skb->encapsulation || skb_tnl_header_len(skb))
> > +		return false;
> =

> 1/5 is still needed: the fraglist branches of
> tcp4/tcp6/udp4/udp6_gro_complete() leave inner_transport_header unset
> for qdisc_pkt_len_segs_init() and skb_gso_transport_seglen(). VXLAN
> forwarded with rx-gro-list on, 20 cases of 1000 packets, 2 runs: 34 to
> 241 reach the receiver with this series, and with 1/5 and 3/5-5/5 on
> top every packet the router received, with valid checksums.
> =

> Is v7 without 2/5, based on net once this series is applied, how you
> want the two combined?

How about splitting into two series.

One that is not ipmr specific: patches 1 and 3. That is ready to be
merged I expect without major comments.

A few comments to Patch 4:

    > @@ -1948,6 +1952,15 @@ static int ipmr_prepare_xmit(struct net *net=
, struct mr_table *mrt,
    >      if (vif->flags & VIFF_TUNNEL) {
    > +        /* An encapsulated packet carries the inner headers of its=

    > +         * own tunnel. Only IPXIP4 GSO packets nest: their IP head=
ers
    > +         * are segmented by protocol field, while GRE and UDP tunn=
el
    > +         * segmentation read skb->inner_protocol, which ip_encap()=

    > +         * sets for its own header.
    > +         */
    > +        if (skb_is_gso(skb) && skb->encapsulation &&
    > +            !(skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP4))
    > +            return -1;

    [severity: high, confidence: high]
    Checking only !(gso_type & SKB_GSO_IPXIP4) lets compound tunnels with=

    SKB_GSO_IPXIP4 set slip through: FOU/GUE over IPIP/SIT (both from GRO=
 via
    udp_gro_complete() -> {ipip,sit}_gro_complete() and local ipip/sit de=
vices
    with encap fou/gue) carry SKB_GSO_UDP_TUNNEL[_CSUM] | SKB_GSO_IPXIP4 =
(and
    esp4_offload.c can combine SKB_GSO_ESP | SKB_GSO_IPXIP4). ip_encap() =
then
    unconditionally overwrites skb->inner_protocol_type and skb->inner_ip=
proto
    to IPPROTO_IPIP, so skb_udp_tunnel_segment() dispatches SIT-over-FOU/=
GUE to
    ipip_gso_segment() on an IPv6 header, dropping/corrupting it after vi=
f stats
    already counted it.

  The hidden assumption is that SKB_GSO_IPXIP4 is mutually exclusive with=
 SKB_GSO_UDP_TUNNEL[_CSUM]. It isn't: FOU and GUE wrap IP-in-IP /
  SIT inside UDP, so a single skb carries both SKB_GSO_UDP_TUNNEL[_CSUM] =
and SKB_GSO_IPXIP4 in skb_shinfo(skb)->gso_type.

  The check tests the wrong sense of the bitmask: it asks "is IPXIP4 pres=
ent?" rather than "are any non-IPXIP4 tunnel bits present?"

  Admittedly double encap is a bit niche. But something a fuzzer will fin=
d. I'd lower the severity to medium though.

    [severity: high, confidence: high]
    Even for pure SKB_GSO_IPXIP4 (IPIP/SIT without FOU/GUE), pushing a th=
ird IP
    header without segmenting first breaks the invariant enforced by real=
 ipip
    devices (IPIP_FEATURES omits NETIF_F_GSO_ENCAP_ALL and hw_enc_feature=
s is 0,
    so validate_xmit_skb() segments any encapsulated GSO skb before ipip_=
tunnel_xmit()).
    NICs advertising full NETIF_F_GSO_IPXIP4 offload (i40e, ice, iavf, io=
nic)
    take the 3-header skb directly and only update skb_network_header() a=
nd
    skb_inner_network_header(), leaving the middle IPv4 header with the f=
ull
    aggregate tot_len and static id on every segment (and patch 5 widens =
this
    from DF=3D0 to DF=3D1 traffic). GSO_PARTIAL NICs (mlx5, bnxt, ixgbe, =
igb, igc)
    also replicate the middle header with a fixed id even when DF is clea=
r.
    Either drop all skb_is_gso(skb) && skb->encapsulation here (as in v5)=
 or
    segment already-encapsulated GSO skbs before ip_encap().


  struct sk_buff only has two sets of header pointers: outer (network_hea=
der, transport_header) and inner (inner_network_header,
  inner_transport_header). Every hardware TSO driver and NIC descriptor f=
ormat is built around that 2-layer model.
  Normal ipip tunnel devices enforce this automatically. ipip_tunnel_setu=
p:403-422 advertises NETIF_F_GSO_SOFTWARE (which excludes
  NETIF_F_GSO_ENCAP_ALL) and leaves dev->hw_enc_features =3D 0. When an a=
lready-encapsulated GSO skb (skb->encapsulation =3D=3D 1) is transmitted
  to tunl0, __netif_skb_features:3998-3999 masks features with dev->hw_en=
c_features (0), so validate_xmit_skb() segments it first before
  ipip_tunnel_xmit() pushes the second IP header.
  VIFF_TUNNEL bypasses dev_queue_xmit() on dvmrp%d and calls ip_encap() d=
irectly inside ipmr_prepare_xmit(), so nothing segments an incoming
  IPIP/SIT GSO skb before ip_encap() wraps it in another IPv4 header.

  The root tension is that v6 added && !(gso_type & SKB_GSO_IPXIP4) solel=
y to appease a review comment on v5 about preserving pre-existing
  DF=3D0 software-GSO IPIP/SIT behavior, but doing so violates the kernel=
's 2-layer GSO invariant and creates both Issue #1 and Issue #2.
  =

  There are two clean ways out:
  =

  1. Minimal net fix (revert to v5): if (skb_is_gso(skb) && skb->encapsul=
ation) return -1; =E2=80=94 drops all already-encapsulated GSO skbs on
  VIFF_TUNNEL in one line, avoids illegal 3-IP-header GSO skbs completely=
, and eliminates both Issue #1 and Issue #2.
  2. Full fix (matching ipip netdev semantics): Segment already-encapsula=
ted GSO skbs (skb_gso_segment(skb, 0) / software GSO) before calling
  ip_encap() in ipmr_queue_{fwd,output}_xmit() =E2=80=94 then all encapsu=
lated GSO traffic (IPIP, SIT, GRE, VXLAN, FOU/GUE) works over VIFF_TUNNEL=
 on
  both software and hardware TSO NICs, with zero drops and zero 3-header =
skbs (though slightly more invasive for net).

    > @@ -1982,6 +1995,17 @@ static int ipmr_prepare_xmit(struct net *net=
, struct mr_table *mrt,
    > +    if ((vif->flags & VIFF_TUNNEL) && skb->encapsulation &&
    > +        !skb_is_gso(skb) && skb->ip_summed =3D=3D CHECKSUM_PARTIAL=
 &&
    > +        skb_checksum_help(skb)) {
    > +        ip_rt_put(rt);
    > +        return -1;
    > +    }
  =

    [severity: medium, confidence: high]
    A unicast SCTP packet inside VXLAN/GRE/IPIP with a multicast outer
    destination can reach here with skb->encapsulation && CHECKSUM_PARTIA=
L &&
    skb->csum_not_inet (unlike unencapsulated multicast SCTP). skb_checks=
um_help()
    writes a 16-bit 1's-complement checksum over the first 2 bytes of the=
 4-byte
    SCTP CRC32c field. Use skb_csum_hwoffload_help(skb, 0) instead, match=
ing
    validate_xmit_skb() on an ipip device.
