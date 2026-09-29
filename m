Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE3395ACC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652202; cv=none; b=MR+loA/aAcRe2vCMnruJeeOHF8rJS1vRTIN6iGFNJMFl4IhBYKozs5bcu6KgJL26rEFoH4VBOACZRuUvJIy81puZMPZM7G4GmaVo/kRV2tTdYGoCfAzRqixPaf2QSVZ+G46lAu8pOT0tPYVzEtj/W0knO0iDtkZLTZ+zxj2tNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652202; c=relaxed/simple;
	bh=uNQzoL0DkP7LC8m7rn7E+jvjV4AXcM8fLkMcrHglncc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AM8npzBbxjPvS0swONnWgemWAsj8VEFqHDv56VVsCCBOO0xHTurLULBw+NyvOVnJ7rrWsGZaRbwKfekTkmql89A6o7LdvoWpoezbiqLaLmybycEp+d2RWus57jom0uGGCmEMBCuNeWN3dMiDUvgBnPgG/qE1/KXhkiOV5mmCp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYnTnGdM; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYnTnGdM"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67568357b63so2689d50.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790652200; x=1791257000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WEn2fBY4eZ4Yetamg7UIqe5VCu7bhvysFxpD1bcP+Zs=;
        b=cYnTnGdMORu79CJy2T9Iybxd46E/0PhYfjAjEiukHdgGW7Fd+bs/6oGvYra9UPGYBt
         goyMwffmYg9l6P3uB7sweqV0r6x2hYrXGBuCFbYEdUNwdND09dMa3g4y/vof06jUBqvG
         ZvJgVnnLvrEzrQPaRkHUVIuHiDs2iBLwuvYJx+OLboKaK8qXhew9vNrwVEbGVEzwqmbo
         /xhzU9OlHWtYaf7qjSQQScqnXrh2EKZ5cJ4Pejlh/PnWLZNVf1/DM5qnKzZ1MUjGuY1k
         O/RqAu0yjuN6rAzT9Ao+5WNZKGLSz45+9lXDAgTsnClJTCVv13U5g2OG3Nn8H6/qzJB7
         1pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790652200; x=1791257000;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEn2fBY4eZ4Yetamg7UIqe5VCu7bhvysFxpD1bcP+Zs=;
        b=szILFP2wyYOF9QRAr7GKj0f/N4iuA3Nm106+OnxhReJRrroL4lZS2I790B8Pxl7Tfh
         K+kDmuUVr2ZD13wI1cvL3XUUrKTW9VGTH9sIgm3XjpaB/Px00djuDVobEjnzsPrEjP5F
         N7pjvyGHJPMOf0S9NPqUvk/xBPtdiJXF94rQtkTTY57HaoN4lnQCMHNL5VdvA2FQLdfs
         gHdl4spP3ZNG+tYYWGT2pyqF2SX9KNthwN/iPLqyfcn6KlHAYkiaWcn6Z3voxqTLxP/O
         m4HK0JLCfQi+OisGVxxGY9+FcK/pE57aYhq+DoojZ+vntfsLxdTR2+cI59GtpObMvXam
         TquA==
X-Forwarded-Encrypted: i=1; AKwUvBxatJfU2zsgmCWl0IsG7cl9xJmiBi2QmjMH0cqK15OyJZw8RbEnbJHOGzFdzYo5K1Y+EcOgms4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK+/s7eIAs766vDN6TPR57auvacg7c/z1tZBci1LekMRE8RuoQ
	fRrBXmSdQg4NAb9KWDx8ssINZlhdCSDZ3+TWPVGuQVqA2T8sqsumzkGc
X-Gm-Gg: AYBFou0phTNzsWeT1oYk2WlqHcja8LYocNl2ZVAirPQCyPDiUWJv69M9MtfgecAL5OZ
	5KC2vAZJglHbcFSjf9+jADQEnZBfE/tFRt1jm4Lc6ceDoYAKKF9Lals2uPIMwY+99Jn1VWbZkRr
	QinJw7RNO6DpXNtACg3RRjzZHQQcwcwV2aRx5WYA2oXm+9HguLeQ/z9BULaKq6WW3cKWsfpi478
	uuqBwBWmge7xahAkI84pj6WUcSMlL69WDIrT2jhsh7AKnS2zUY0iw/p9NFtkJoh6JqRJBlmMHvJ
	DKhLNtmaRB7tbZ5+9dhpIveRyvfG2C+TYOFsB29ML6+QVWO+zHiVDzD1Z9qLfsCig68H0ogHPX7
	3lyj6sZJKiuyiNGCctjsr9HkT3fNSY5a8ufYGEFM+S0cDSSLUt9tbh1TPL8k69Wa68hoLEo41nC
	7mrir/ds35sp/VQH3ucKi4cF3MWrOk7U/f5R2aq50NUtJwe97NEVO3l/4oj9+fUr7YSU6Rgi37v
	aqlaOU1UOWLfNuKaWAf2Ec3Po30p3oXQoZrFTaU/3/glUZzyKlL
X-Received: by 2002:a05:690e:4851:b0:674:17ca:25dd with SMTP id 956f58d0204a3-6755f0bfde8mr512832d50.78.1790652199670;
        Mon, 28 Sep 2026 20:23:19 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860e5e9besm54705637b3.11.2026.09.28.20.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:23:18 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:23:18 -0400
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
Message-ID: <willemdebruijn.kernel.1c50b2a7a6f39@gmail.com>
In-Reply-To: <179064047393.3145.16303551892146530587@kernel.org>
References: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
 <179064047393.3145.16303551892146530587@kernel.org>
Subject: Re: [PATCH net v2] net: extend IPv6 exthdr detection of tunneled
 packets
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
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] net: unnecessary software checksum fallback for outer UDP
>   tunnels
> - [Low] The old non-encapsulated branch cleared features only for
>   SKB_GSO_TCPV6, or for SKB_GSO_UDP_L4 over IPv6.
> - [Low] The in-tree NETIF_F_IPV6_CSUM contract
>   (include/linux/skbuff.h:77-86) still says the feature covers only=E2=80=
=A6
> =

> --
> =

> > +static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
> > +{
> > +	if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6)) {
> > +		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
> > +			return true;
> =

> [Severity: Low]
> =

> The removed non-encapsulated branch cleared features only for
> SKB_GSO_TCPV6, or for SKB_GSO_UDP_L4 over IPv6. The new outer check has=
 no
> gso_type gate. Is it meant to apply to every IPv6 GSO type?
> =

> SKB_GSO_SCTP is one type whose behaviour changes. sctp_packet_pack()
> always makes the GSO head CHECKSUM_PARTIAL:
> =

> net/sctp/output.c:sctp_packet_pack() {
>     ...
> 	if (gso) {
> 		...
> 		goto chksum;
> 	}
>     ...
> chksum:
> 		head->ip_summed =3D CHECKSUM_PARTIAL;
> 		head->csum_not_inet =3D 1;
>     ...
> }
> =

> Take SCTP over IPv6 with IPV6_DSTOPTS or IPV6_RTHDR set.
> gso_features_check() now clears NETIF_F_IPV6_CSUM. harmonize_features()=

> then sees ip_summed !=3D CHECKSUM_NONE and
> !can_checksum_protocol(features, ETH_P_IPV6). It strips all of
> NETIF_F_CSUM_MASK, including NETIF_F_SCTP_CRC, plus NETIF_F_GSO_MASK:

NETIF_F_SCTP_CRC is not part of NETIF_F_CSUM_MASK:

#define NETIF_F_CSUM_MASK       (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
                                 NETIF_F_HW_CSUM)

 > validate_xmit_skb()
>   netif_skb_features()
>     gso_features_check()    /* clears NETIF_F_IPV6_CSUM */
>     harmonize_features()    /* clears NETIF_F_CSUM_MASK, NETIF_F_GSO_MA=
SK */
>   skb_gso_segment()
>     sctp_gso_segment()      /* CRC32c computed in software per segment =
*/
> =

> Some devices have NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SCTP_CR=
C
> but no NETIF_F_HW_CSUM. One example is hns3 without
> HNAE3_DEV_SUPPORT_HW_TX_CSUM_B. On such a device the CRC32c was offload=
ed
> before this patch and is computed in software after it. The output is
> still correct, so only performance is affected.
> =

> Could the gso_type restriction be kept here? If not, could the commit
> message say that the check now covers all IPv6 GSO types?
> =

> > +
> > +		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
> > +		if (!skb->encapsulation &&
> > +		    skb_transport_header_was_set(skb) &&
> > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > +			return true;
> > +	}
> =

> [ ... ]
> =

> > @@ -3988,8 +4004,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb=
,
> >  		return 0;
> >  =

> >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > -		if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
> > -		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > +		if (skb_has_ipv6_extension_hdr(skb))
> >  			goto sw_checksum;
> >  =

> >  		switch (skb->csum_offset) {
> =

> [Severity: Medium]
> skb_has_ipv6_extension_hdr() checks the inner IPv6 header whenever
> skb->encapsulation and the inner network header are set. That is right
> for gso_features_check(), where the device computes the inner checksum
> of every segment. Here it is applied regardless of which checksum is
> being offloaded.
> =

> The commit message describes the case where this matters: if the inner
> packet is CHECKSUM_NONE, the device offloads the outer UDP checksum.
> csum_start then points at the outer UDP header and the device does not
> need to parse any further.
> =

> Suppose the inner packet is IPv6 with, say, a Destination Options
> header. The inner check still returns true, and the outer checksum is
> now computed in software:
> =

> validate_xmit_skb()
>   skb_csum_hwoffload_help()
>     skb_has_ipv6_extension_hdr()
>       __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb))
>                           /* inner nexthdr =3D=3D NEXTHDR_DEST */
>     skb_checksum_help()   /* outer UDP csum in software */
> =

> Before this patch, skb_csum_hwoffload_help() only compared the outer
> network header length, so the outer checksum was offloaded.
> =

> The same regression affects an IPv4 outer header on a NETIF_F_IP_CSUM
> device. The old test never looked at those packets, because
> vlan_get_protocol() returned ETH_P_IP.
> =

> The output is still correct, so this is a performance issue. Whether
> it triggers depends on the contents of the inner packet.
> =

> For non-GSO skbs that are not CHECKSUM_PARTIAL,
> iptunnel_handle_offloads() clears skb->encapsulation. That likely hides=

> this for the common in-tree tunnels, but the helper should not depend
> on it.

This is the key bit: tunnels disable skb->encapsulation when
checksumming of outer packet is requested.

This is not only something the "common in-tree tunnels" do, but
required.

For one, validate_xmit_skb sets either the inner or outer transport
header to csum_start depending on skb->encapsulation just before
calling this function.

        if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
                if (skb->encapsulation)
                        skb_set_inner_transport_header(skb,
                                                       skb_checksum_start=
_offset(skb));
                else
                        skb_set_transport_header(skb,
                                                 skb_checksum_start_offse=
t(skb));
                if (skb_csum_hwoffload_help(skb, features))
                        goto out_kfree_skb;
        }

 =

> Could the inner check be skipped here when the checksum being
> offloaded is not the inner one? For example, it could be skipped when
> skb_checksum_start_offset(skb) is below skb_inner_network_offset(skb).
> =

> Note that validate_xmit_skb() sets inner_transport_header to csum_start=

> just before calling skb_csum_hwoffload_help(). That field therefore
> cannot tell the two cases apart.
> =

> [Severity: Low]
> =

> The NETIF_F_IPV6_CSUM description in include/linux/skbuff.h still says:=

> =

>  *     - Driver (device) is only able to checksum plain
>  *	 TCP or UDP packets over IPv6. These are specifically
>  *	 unencapsulated packets of the form IPv6|TCP or
>  *	 IPv6|UDP where the Next Header field in the IPv6
>  *	 header is either TCP or UDP. IPv6 extension headers
>  *	 are not supported with this feature.
> =

> skb_has_ipv6_extension_hdr() rejects only extension headers in the oute=
r
> and first inner IPv6 header. It also skips the length check when
> skb->encapsulation is set. As a result, skb_csum_hwoffload_help() retur=
ns
> 0 for encapsulated packets whose outer nexthdr is GRE, UDP or IPv6.
> =

> Encapsulated GRE and UDP over IPv6 could already be offloaded before th=
is
> patch. The new case is IPv6|IPv6|TCP from ip6_tunnel with encaplimit
> none. The old network-to-transport length check sent it to
> skb_checksum_help(). Now it goes to the device.
> =

> The commit message says:
> =

>   A NETIF_F_IPV6_CSUM device must parse through the outer headers to
>   reach the inner ones.
> =

> Should this requirement also go into the NETIF_F_IPV6_CSUM documentatio=
n
> in skbuff.h? Driver authors who set the bit in hw_enc_features would th=
en
> know about it.
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260926140506.2335137-1-willemdebruijn.kernel%40gmail.com


