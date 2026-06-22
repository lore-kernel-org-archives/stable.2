Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D523783BE;
	Mon, 22 Jun 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126412; cv=none; b=qv9L/c5PUvn8SnFATTcBZL6lHgFdEDJI4yYdKc6GLspF13HrybtTCFflNA5Jdv73JtSb72o8J9JUgUoseKpqYjKwnnoL8g4ykC12YvtIHKrzyxw0zgMhPDPZWqNagkZZbfv4YVN8uUGfHcJMcotQXIzpC1wd4FBIzPOclql5h/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126412; c=relaxed/simple;
	bh=S4t7knOEyAEnRPoAGDPAFDafyWVIJvVclnF9cmeZyaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uion6bHUvkyX8LqaHqIme2EqQ4fILo8Htt6Ju8b31jmK/YDL9qms7b5BKe8EDCHO/83f9hVgqzILv0tNFXit+J1Dbxj7ba9iqiam0j12/cUGyDs4A6tMYBwAy+eMoJH5+ojPRfBmmjCXI+KMOg9Y0ZJ/ajjYOwiVWGokI7OlNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GDgitpaR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GDgitpaR"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65MAuRbA52486224, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782125787; bh=MsSe1SF/uIbh6o12XSI2mniba15A+fRCte2j+2lUt7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GDgitpaRGYlNM/6IbC/Rfo74HJbrliPGaJLV6xmJOIgDi+EPKCaK5PUuUGP6YZQoW
	 RvwJcnpNdknC/NgjLIWi8Fp/F0BfD9eEk6P5wwp8gB4enpqQ9niVbTS764jRatwRmr
	 NLC3cYuo9RvMPt0Y1+fDDBiJxPmFJ07AYfrhFTgsS6ns6Z7/hNpOVqj198zfd2BgM2
	 0vjBI4FZ1ZdkUmi8vuGp4Oc6btWmRemNHccUsBL4CFGX3IwxZXUdNixxQBgpII5Nuw
	 evZGFYJx75aoikRq6idMbH+rYHlr4ZcgWaDZOEUGKjSHbJoVch7Ym0oTl7Th/1o454
	 QQRrFiKRHNKFg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65MAuRbA52486224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jun 2026 18:56:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 18:56:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Mon, 22 Jun 2026 18:56:27 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Topic: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Index: AQHc/Mk9ctTr65FPK0GOwiW0nIIMYrZB75eAgAh/vtA=
Date: Mon, 22 Jun 2026 10:56:27 +0000
Message-ID: <23922667b00c4ec7aba7efca227f85b1@realtek.com>
References: <20260615131653.15730-1-justinlai0215@realtek.com>
 <20260617085942.843250-2-horms@kernel.org>
In-Reply-To: <20260617085942.843250-2-horms@kernel.org>
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
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> rtase: Workaround for TX hang caused by short UDP packets entering
> hardware PTP parsing
>=20
> The patch adds a workaround for a hardware bug in rtase where short UDP
> packets triggering PTP parsing can cause a TX hang due to out-of-bounds
> reads.
> It pads affected packets so the transport data reaches a minimum length.
>=20
> Cc: stable@vger.kernel.org
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 55105d34bc797..4c295a39c7a0c 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> [ ... ]
> > @@ -1249,6 +1250,81 @@ static u32 rtase_tx_csum(struct sk_buff *skb,
> const struct net_device *dev)
> >       return csum_cmd;
> >  }
> >
> > +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> > +{
> > +     int no =3D skb_network_offset(skb);
> > +     struct ipv6hdr *i6h, _i6h;
> > +     struct iphdr *ih, _ih;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
>=20
> [Severity: High]
> Does relying on vlan_get_protocol(skb) allow an unprivileged user to bypa=
ss
> this workaround?
>=20
> If an attacker uses an AF_PACKET/SOCK_RAW socket to inject a raw Ethernet
> frame containing an IPv4/UDP packet, they could set skb->protocol to an
> arbitrary value like htons(ETH_P_ALL). The switch statement will fall
> through to the default case and return false, causing rtase_skb_pad() to
> skip the padding.
>=20
> Since the hardware independently parses the raw frame based on the
> EtherType,
> could it still process the unpadded packet and trigger the TX hang?
>=20

Thanks for pointing this out.
=20
Since the hardware parser operates on the actual Ethernet frame
contents, relying on skb protocol metadata is not ideal for this
workaround.
=20
I'll update the code to derive the L3 protocol and network offset from
the Ethernet/VLAN headers in the skb data before parsing IPv4/IPv6.
This makes the software check match what the hardware parser sees and
avoids depending on skb protocol metadata.

> > +             ih =3D skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > +             if (!ih)
> > +                     return false;
> [ ... ]
> > +static bool rtase_skb_pad(struct sk_buff *skb)
> > +{
> > +     __be16 *dest, _dest;
> > +     u32 trans_data_len;
> > +     u32 udp_offset;
> > +     u16 dest_port;
> > +     u32 pad_len;
> > +
> > +     if (!rtase_get_udp_offset(skb, &udp_offset))
> > +             return true;
> > +
> > +     trans_data_len =3D skb->len - udp_offset;
> > +     if (trans_data_len < offsetof(struct udphdr, len) ||
> > +         trans_data_len >=3D RTASE_MIN_PAD_LEN)
> > +             return true;
>=20
> [Severity: High]
> Does this logic inadvertently skip padding for underflowed lengths and ti=
ny
> payloads?
>=20
> If the IP header is malformed such that skb->len < udp_offset, the unsign=
ed
> subtraction for trans_data_len will underflow to a large positive value.
> This causes trans_data_len >=3D RTASE_MIN_PAD_LEN to be true, bypassing t=
he
> padding.
>=20
> Additionally, if the packet has fewer than 4 bytes of UDP payload, meanin=
g
> trans_data_len < offsetof(struct udphdr, len), it explicitly returns true=
.
>=20
> Since the hardware blindly fetches the UDP destination port at
> udp_offset + 2 via DMA, won't transmitting these short or malformed packe=
ts
> without padding still expose the hardware to out-of-bounds reads?
>=20

Thanks for the review.
=20
I'll add a check for udp_offset > skb->len before calculating
trans_data_len to avoid the potential underflow.
=20
If the computed UDP offset is beyond the packet length, the packet is
malformed and cannot be safely handled by this workaround, so it should
not be transmitted.
=20
The out-of-bounds access occurs after the packet has already matched
the PTP classification criteria (UDP destination port 319/320) and
enters the hardware PTP parsing path.
=20
If the transport data is shorter than the destination port field
itself, the packet cannot match the affected PTP classification path.

> > +
> > +     dest =3D skb_header_pointer(skb,
> > +                               udp_offset + offsetof(struct udphdr,
> dest),
> > +                               sizeof(_dest), &_dest);
> [ ... ]
> > @@ -1362,6 +1438,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buf=
f
> *skb,
> >               opts2 |=3D rtase_tx_csum(skb, dev);
> >       }
> >
> > +     if (!rtase_skb_pad(skb))
> > +             goto err_dma_0;
> > +
> >       frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
> >       if (unlikely(frags < 0))
> >               goto err_dma_0;
>=20
> [Severity: High]
> This is a pre-existing issue, but does the err_dma_1 error path in
> rtase_start_xmit() contain a double free of the skb?
>=20
> When transmitting a fragmented packet, rtase_xmit_frags() maps the
> fragments and assigns ring->skbuff[entry] =3D skb for the last fragment
> descriptor. Back in rtase_start_xmit(), if dma_map_single() fails for the
> linear part, it jumps to err_dma_1:
>=20
> err_dma_1:
>         ring->skbuff[entry] =3D NULL;
>         rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
>=20
> err_dma_0:
>         tp->stats.tx_dropped++;
>         dev_kfree_skb_any(skb);
>         return NETDEV_TX_OK;
>=20
> rtase_tx_clear_range() iterates over the mapped fragments and calls
> dev_kfree_skb_any() when it finds the skb pointer. Execution then falls
> through to err_dma_0, which unconditionally calls dev_kfree_skb_any(skb) =
a
> second time on the same skb pointer.

Thanks for pointing this out.

This appears to be a pre-existing issue and is unrelated to the change
in this patch.

I'll investigate the reported double free scenario further and address
it separately if a fix is needed.

Thanks,
Justin
