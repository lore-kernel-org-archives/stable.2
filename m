Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A42275AFD;
	Tue,  9 Jun 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993248; cv=none; b=hMIruLp+7weWN2Nvi1tO7/a2z57wFZDyoRhdyKVjuLDjQ39TD/0Rg0FpgjsQp0JiKzTNpn5XSmsVKYkiUmCmYR91ppekwrPZV0RxUyq3aFEJ9TatprGG3XpjUnev0NopXHytgP4sy1zxOOhFD/xWNu+46RjOSOnPoNY5MbFK71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993248; c=relaxed/simple;
	bh=z+4WmctUidFXFQDyEm7ERxDDVRzf/RAPEGVGf7k0aZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UT6Y9XFhhFnmhGvuF1sLQ4S+xgFfELEbCK2l9thzN8GkEBSgpbdFdKas1gb63oU0/aIkeIZLny2s0FeTJzfKEqxch0IqplJ3lLta66tmgNEgodWHYGFP6qMPL0fC1ssu4UbbZ+w6p2VgNn3f78P2k+c35o0OOi5S8jY3oqLT5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LE5RKuDy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LE5RKuDy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6598KAr04052415, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780993210; bh=fnq2zFBFn7ZoOSIc7CbTMgWZukXawYw1fOZCj0Cmu5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LE5RKuDyPlUj7m/A6yciPGbzQ5Xkks4T+c4/GlLZj7YYDtf6iaCHb+9VFnbWbg82G
	 o24PPjrNVR1SRlYlmlZYoqjcu8cGglfaIwA4qZlnDeiX2ZWMbPn4ptMRNtoSgddy8s
	 8wRKdhdU2KIBlpE3jhetEx/alU34Xt6H1n7HkX6co2tPb/9FMvE17IUQx+q/sOh/Yh
	 +fvL3ZP4MZ5dXoqKmL9eHBCouVZCzeG74FSvQ9ajwLrQfK+T5erLVm0MPCFPAtXoQ7
	 i2SBXcd8OaH5iXKKqH4PT+KPZwPT9Kevc9PDXfexSXddT+x4N4D+TqiF5r4TT0no5W
	 gUAf0DJvxTIsQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6598KAr04052415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 16:20:10 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 16:20:10 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Tue, 9 Jun 2026 16:20:10 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Thread-Topic: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Thread-Index: AQHc9ArcvLfvYqn0fkOKy9pKm3m4Q7Y0hZ8AgAEzauA=
Date: Tue, 9 Jun 2026 08:20:10 +0000
Message-ID: <1340406ab190498ab857ad9017529722@realtek.com>
References: <20260604101356.15611-1-justinlai0215@realtek.com>
 <20260608190627.182292-2-horms@kernel.org>
In-Reply-To: <20260608190627.182292-2-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Simon Horman <horms@kernel.org> wrote:
>=20
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> rtase: Workaround for IP fragmented UDP packet hardware bug
>=20
> The hardware parser incorrectly interprets 319/320 in a short IP fragment=
ed
> UDP packet payload as standard PTP destination ports and treats the fragm=
ent
> as a PTP packet for further parsing. Pad these packets so the transport d=
ata
> reaches RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
> hardware issue.
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index ef13109c49cff..b686b84e15fe2 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
>=20
> [ ... ]
>=20
> > @@ -1247,6 +1248,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb,
> const struct net_device *dev)
> >       return csum_cmd;
> >  }
> >
> > +static bool rtase_skb_is_udp(struct sk_buff *skb) {
> > +     int no =3D skb_network_offset(skb);
> > +     struct ipv6hdr *i6h, _i6h;
> > +     struct iphdr *ih, _ih;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
> > +             ih =3D skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > +             return ih && ih->protocol =3D=3D IPPROTO_UDP;
> > +     case htons(ETH_P_IPV6):
> > +             i6h =3D skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> > +             return i6h && i6h->nexthdr =3D=3D IPPROTO_UDP;
>=20
> [Severity: High]
> Does this check fail to traverse IPv6 extension headers?
>=20
> If an IPv6 packet contains extension headers, such as an IPv6 fragment
> (IPPROTO_FRAGMENT), the nexthdr field will contain the extension header's
> protocol number instead of UDP.
>=20
> Doesn't this bypass the workaround for the exact fragmented packets it is
> intended to fix?
>=20
Thanks for the review.

Unlike IPv4, IPv6 does not require extension header parsing for
this workaround. The hardware only treats IPv6 packets without
extension headers as PTP packets for further parsing.

Therefore, IPv6 packets carrying extension headers, including
fragments, do not enter this parsing path and are not affected
by the hardware issue addressed by this workaround.

Skipping such packets is intentional.
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool rtase_skb_pad(struct sk_buff *skb) {
> > +     u32 trans_data_len;
> > +     u16 dest_port;
> > +     u32 pad_len;
> > +
> > +     if (!skb_transport_header_was_set(skb))
> > +             return true;
>=20
> [Severity: High]
> Does this early return skip the workaround for forwarded (routed) IP
> fragments?
>=20
> The networking stack typically does not set the transport header offset f=
or
> forwarded packets or non-first IP fragments.
>=20
> Could an attacker still trigger the hardware TX hang by routing short,
> fragmented UDP packets through this interface?
>=20
Thanks for pointing this out.

I agree that relying on skb_transport_header_was_set() is not
robust enough.

I will rework this logic to derive the required offset directly
from the packet contents using skb_header_pointer(), rather
than depending on skb_transport_header_was_set().
> > +
> > +     trans_data_len =3D skb_tail_pointer(skb) -
> > + skb_transport_header(skb);
>=20
> [Severity: Critical]
> Does this calculation miss data stored in paged fragments?
>=20
> By only subtracting the transport header from the tail pointer, it treats=
 the
> linear portion as the entire transport payload length.
>=20
> For non-linear packets, won't this incorrectly evaluate the payload as sm=
aller
> than RTASE_MIN_PAD_LEN and trigger the padding path?
>=20
You're right that skb_tail_pointer() only covers the linear area
and can undercount non-linear skb.

skb->len includes both linear and paged fragments.

trans_data_len =3D skb->len - skb_transport_offset(skb);
> > +     if (trans_data_len < offsetof(struct udphdr, len) ||
> > +         trans_data_len >=3D RTASE_MIN_PAD_LEN)
> > +             return true;
> > +
> > +     if (!rtase_skb_is_udp(skb))
> > +             return true;
> > +
> > +     dest_port =3D ntohs(udp_hdr(skb)->dest);
> > +
> > +     if (dest_port =3D=3D PTP_EV_PORT || dest_port =3D=3D PTP_GEN_PORT=
) {
> > +             pad_len =3D RTASE_MIN_PAD_LEN - trans_data_len;
> > +             if (__skb_put_padto(skb, skb->len + pad_len, false))
>=20
> [Severity: Critical]
> Will calling __skb_put_padto() with a length greater than skb->len cause =
a
> kernel panic on non-linear packets?
>=20
> Since __skb_put_padto() unconditionally invokes __skb_put() when the new
> length exceeds the current length, and __skb_put() contains
> SKB_LINEAR_ASSERT(skb) which triggers a BUG_ON for non-linear packets,
> won't this panic the kernel when processing a fragmented UDP packet?
>=20
Thanks for pointing this out.

Before calling __skb_put_padto(), I will check whether the skb is
non-linear. If so, I will first linearize it and then apply the
padding. This avoids calling __skb_put_padto() on a non-linear skb
while still ensuring that the workaround is applied to packets which
may trigger the hardware issue.

if (dest_port =3D=3D PTP_EV_PORT || dest_port =3D=3D PTP_GEN_PORT) {
    pad_len =3D RTASE_MIN_PAD_LEN - trans_data_len;

    if (skb_is_nonlinear(skb)) {
        if (skb_linearize(skb))
            return false;
    }

    if (__skb_put_padto(skb, skb->len + pad_len, false))
        return false;
}
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *s=
kb,
> >                           u32 opts1, u32 opts2)  { @@ -1360,6
> +1407,9
> > @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
> >               opts2 |=3D rtase_tx_csum(skb, dev);
> >       }
> >
> > +     if (!rtase_skb_pad(skb))
> > +             goto err_dma_0;
> > +
> >       frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
>=20
> [Severity: High]
> This is a pre-existing issue, but doesn't rtase_xmit_frags() crash on hig=
hmem
> pages?
>=20
> The driver advertises NETIF_F_HIGHDMA, but rtase_xmit_frags() attempts to
> map SKB fragments using skb_frag_address() and dma_map_single():
>=20
> addr =3D skb_frag_address(frag);
> mapping =3D dma_map_single(&tp->pdev->dev, addr, len, DMA_TO_DEVICE);
>=20
> Since skb_frag_address() returns an invalid pointer for HIGHMEM pages,
> shouldn't the driver be using skb_frag_dma_map() instead to prevent panic=
s or
> memory corruption?
>=20
Thanks for pointing this out.

This appears to be a pre-existing issue and is unrelated to the change
in this patch. I will investigate whether skb_frag_dma_map() should be
used in rtase_xmit_frags() and address it separately if needed.

Thanks,
Justin
> >       if (unlikely(frags < 0))
> >               goto err_dma_0;
