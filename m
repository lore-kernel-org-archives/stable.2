Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC1345CA1
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790388396; cv=none; b=eMIYXLCB9Avp4GRc5Itmp8NBRw3IgiKDEcGSrPuClgoGnYAeh+G6fQZ/pyyZdIFGE92bAbyqjFo7xDUmfxPbdNLhQduSCV1FJR9JonraT1M52ts6G62OPNcIlzRJvnk5mkARPDTJ/benDRgtX0KmMbfFhFmKL3p8xEnTj1XEGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790388396; c=relaxed/simple;
	bh=wuI2TebdT4731npF2uvIR5BLfhA5sfVfMRK6qldeiN0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bAll3hX8UU+R53xgpwDBJKiWMw0dFJc7RDIx91lwgwKIWrbGesSoxOL5cQggbsPwz/yTUST4uAar+yDIjfqoDEmBq7K/+HA1tUVq4JG8OYtxwgEv3QstE6v5K63SBnlND/g9Z1ZM9LFvCwxEx+YmrFLkSlzur2BVZfUBE1SFKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9Ikiee/; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9Ikiee/"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f516c271so1391131d50.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790388391; x=1790993191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTiBH4pFhHFt7w7VVYwkFnH5D0BtF1ULS8CrJhbu7BY=;
        b=J9Ikiee/vIAbqC5CK/FcugdMycE9cMqZSMAXrwEfXWqLaB+PGliV8kPSm9XOW76dNQ
         ZDJ+w05AltOOqL0sVavfTMut+3+GECnkPj8PJPi6xBjBrEYR5pw8KUesBOos9Xscykw7
         LcvP7Q011D/igA2yUzgLbOfN0QfPxvGCphvpC5/GvkIAqEpiCByQY6fFnHsqE85pTJth
         5LGjGzxDgf9LamKaBdx5jl6ioY2Y0V1lnGSUfeuVmKeZmdSmvUSXKK2JFnONVviZcwzK
         md7rXcw92XJ5Goo8lJiEItWmb84lZCWsF1DGnKO7R4Ct6qUIDvvh+H5+vUU7JpSJ6bBD
         VZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790388391; x=1790993191;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTiBH4pFhHFt7w7VVYwkFnH5D0BtF1ULS8CrJhbu7BY=;
        b=i+YVrDe7Q+43Vo7pDnpZoLdNmhGG2f/nvKVGhG04bqJ3Bd67Cm1I+qpWhJaCx+6cRe
         2EJLCUAPD2Ki4KSGDGJSqAEKgEmtFyL2cfkdag0V59g28JwEyXewGdQHujsHAqeV3J9I
         e68PnBeyoGx0zqA3MB2gUG8lMOTLh45kd+lqFLiCty1HJ9HJB2Ndra4bZBDH5gaV2LD6
         e1or3lbVu9iH1ykA2AnCYKTgm6ZS79WVs41GSACoIyTnRaTwgjmYaWEHbz1EUE3j1QMo
         reo8Ts0Hy4xN6eH6IHt1LlubgTihIEE6uZjLklRGLB3i2wKmGz7+LGUKiaqAIZnjqm9G
         Evvw==
X-Forwarded-Encrypted: i=1; AKwUvByx4rPX/WNNrPy00B42+WhvQa4sc5L0XdnsUszisZ3j8vSe7A/Sq1ZtS9yKEmEIIl7i1qCVw8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOHTbB3D+s3L6MIC71kDEK3ezkSHteZbQatDUmvOWkUcubRssq
	sVJIsylhvrwPmwAjiOeuikcjzqXGBg9JUdvmjh4YWasZ4CEvWqwCO9aT
X-Gm-Gg: AYBFou0uCqaxofwJTUbaIF+FQfTu9u7vp2Fof6eT1eoWUW1iMF4biZeOdJAn+goPHfP
	ovOoGzncwF9cfpVQgTWzXI1lhUS8aPmZfZ55m7IHI+jrQRBkS1sJkQbE8mA7E38bDdP3cfWR2Xi
	EJJ37ZUkL80jeQkwbt8Lu/i2/95MIOFxMInKZ62daeU8SIFoVFFx1PDYBTyUe+Yk5dwkStGJ/xO
	/31J4LzHdTW2xZw5dWo823+mzmHsLV3bzMIfeCp0vn6+AMLM3GRTivRXAUnQ/yxwa2j3G8BSA8A
	Hun4AJDTL+OP0/B4Ii9dUe6603CxC0mpBpF/0s+Jd3ppmRBVucxfPJh8AGGMIh71wofxA0Vo/JN
	Uef6ehFCis2cASTU3P9YY4Lfh2IyVHblXw+gOUAz6KuZacHq6xP9mVlnyO3jaGYZ0yYsDfe03du
	856sT4ePLdmKkFccsFGg8GBnXRf87vZf+EUvD0tXcAMLALs8nZ7i3sEmTDe9J6h7r91NrEICE+b
	9pE2hfpTrUyQXHcj1vxNruPFRvD1CXJ0izaZWTUxMn1Es+H0UA1
X-Received: by 2002:a05:690e:43cc:10b0:672:d32d:8ee with SMTP id 956f58d0204a3-672ed42d6aemr2613664d50.50.1790388391061;
        Fri, 25 Sep 2026 19:06:31 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740eef1173sm1755545d50.8.2026.09.25.19.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:06:30 -0700 (PDT)
Date: Fri, 25 Sep 2026 22:06:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 xietangxin@yeah.net, 
 willemb@google.com, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.386226098beef@gmail.com>
In-Reply-To: <179036410829.2160803.1955366625960078958@kernel.org>
References: <20260924192128.1197118-1-willemdebruijn.kernel@gmail.com>
 <179036410829.2160803.1955366625960078958@kernel.org>
Subject: Re: [PATCH net] net: extend IPv6 exthdr detection of tunneled packets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [High] Regression for non-encapsulated IPv6 CHECKSUM_PARTIAL skbs in
>   skb_csum_hwoffload_help(), plus a matching gap in=E2=80=A6
> =

> --
> =

> net: extend IPv6 exthdr detection of tunneled packets
> =

> This patch replaces skb_gso_has_extension_hdr() with
> skb_has_ipv6_extension_hdr(). The new helper runs ipv6_ext_hdr() on the=

> outer IPv6 nexthdr. For encapsulated skbs that have an inner network
> header, it also runs it on the inner IPv6 nexthdr. skb_csum_hwoffload_h=
elp()
> now uses the same helper instead of its open coded skb_network_header_l=
en()
> test.
> =

> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f660fccfc0dbc..992b78308c13f 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3818,20 +3818,29 @@ static netdev_features_t dflt_features_check(=
struct sk_buff *skb,
> >  	return vlan_features_check(skb, features);
> >  }
> >  =

> > -static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
> > -{
> > -	if (!skb->encapsulation)
> > -		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> > -			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > -			  vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> > -			skb_transport_header_was_set(skb) &&
> > -			skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr));
> =

> [ ... ]
> =

> > +static bool __skb_has_ipv6_ext_hdr(const struct sk_buff *skb, int nh=
off)
> > +{
> > +	const struct ipv6hdr *ip6h;
> > +	struct ipv6hdr _ip6h;
> > +
> > +	ip6h =3D skb_header_pointer(skb, nhoff, sizeof(_ip6h), &_ip6h);
> > +	return ip6h && ip6h->version =3D=3D 6 && ipv6_ext_hdr(ip6h->nexthdr=
);
> > +}
> > +
> > +static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
> > +{
> > +	if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
> > +	    __skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
> > +		return true;
> > +
> > +	/* Tunnels without an inner network header, such as SCTP-in-UDP or
> > +	 * PSP, have no inner IP header and thus no inner extension header.=

> > +	 */
> > +	if (skb->encapsulation && skb_inner_network_header_was_set(skb) &&
> > +	    __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb)))
> > +		return true;
> > +
> > +	return false;
> >  }
> =

> [ ... ]
> =

> > @@ -3988,8 +3997,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb=
,
> >  		return 0;
> >  =

> >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > -		if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
> > -		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > +		if (skb_has_ipv6_extension_hdr(skb))
> >  			goto sw_checksum;
> =

> [Severity: High]
> Does this weaken the check for non-encapsulated IPv6 CHECKSUM_PARTIAL
> skbs?
> =

> When !skb->encapsulation, validate_xmit_skb() sets the transport header=
 to
> csum_start just before it calls skb_csum_hwoffload_help():
> =

> net/core/dev.c:validate_xmit_skb() {
>     ...
> 		if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> 			if (skb->encapsulation)
> 				skb_set_inner_transport_header(skb,
> 							       skb_checksum_start_offset(skb));
> 			else
> 				skb_set_transport_header(skb,
> 							 skb_checksum_start_offset(skb));
> 			if (skb_csum_hwoffload_help(skb, features))
> 				goto out_kfree_skb;
>     ...
> }
> =

> That means the removed skb_network_header_len() test checked that
> csum_start sits right after the 40 byte IPv6 header.
> =

> The new helper only checks whether the outer nexthdr is one of the six
> values listed in ipv6_ext_hdr(). It skips the inner check because
> encapsulation is 0.
> =

> Take IPv6|UDP|VXLAN|Eth|IP|TCP, or IPv6|IPv6|TCP (nexthdr 41), with
> csum_start at the inner TCP header and csum_offset 16. Would that packe=
t
> now reach the csum_offset switch and return 0?
> =

> Such skbs can come from untrusted input. __virtio_net_hdr_to_skb() is
> used by tap, vhost-net and AF_PACKET with PACKET_VNET_HDR. It accepts
> VIRTIO_NET_HDR_F_NEEDS_CSUM with any csum_start via
> skb_partial_csum_set(). It does not look at nexthdr and does not set
> skb->encapsulation.

This is correct. virtio_net_hdr can insert packets with tunnels,
without setting skb->encapsulation.

> One case: a guest sends IPv6 VXLAN traffic with a CHECKSUM_PARTIAL inne=
r
> TCP header (LCO). The host bridges it to a device that has
> NETIF_F_IPV6_CSUM but not NETIF_F_HW_CSUM.
> =

> On a device that parses headers itself, such as bnxt, bnxt_exthdr_check=
()
> accepts an outer nexthdr of UDP for non-encapsulated skbs. The hardware=

> would then fill in the outer UDP checksum and leave the inner TCP check=
sum
> holding only the pseudo-header seed. Before this patch, the kernel
> computed these checksums in software.
> =

> The skbuff.h description of NETIF_F_IPV6_CSUM covers only "unencapsulat=
ed
> packets of the form IPv6|TCP or IPv6|UDP where the Next Header field in=

> the IPv6 header is either TCP or UDP."
> =

> gso_features_check() has the same gap. For non-encapsulated skbs, the o=
ld
> branch removed NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4 whenever the transpo=
rt
> header was not at nh + 40. The new code removes them only when the oute=
r
> nexthdr is an extension header.
> =

> The commit message talks about removing false positives, but it doesn't=

> mention this relaxation for non-encapsulated skbs.
> =

> Could the offset test stay for the !skb->encapsulation case? For exampl=
e:
> =

> 	skb_checksum_start_offset(skb) - skb_network_offset(skb) !=3D sizeof(s=
truct ipv6hdr)

Will do in v2.

Reintroducing this check is the safest way to detect this edge case.

> Or could the check require nexthdr to be IPPROTO_TCP or IPPROTO_UDP,
> instead of testing ipv6_ext_hdr()?

Only checking two transport types is insufficient.

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260924192128.1197118-1-willemdebruijn.kernel%40gmail.com


