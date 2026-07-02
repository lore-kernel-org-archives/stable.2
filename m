Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B43CAE75;
	Thu,  2 Jul 2026 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989606; cv=none; b=MjWwqxO88bPxrArvfvPeol1y+dFXBEi3tKWfh7XhrJFCVmlMO+VWn2vzzse+DpXdLpivNJZXDrxZMmlK39GFsArhgg7PrSSZPn4NAMZn3gMDWRCjSQKCJ2kv+OFSRc8A3kGRAL9P2BG3ZSQNnuzWyrsYUmM73Kd0go8UrIYif1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989606; c=relaxed/simple;
	bh=l6NIVmclJOukYwpYuRypKxwUsOtZfK45Vb/F2yIhi6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxjgYYNacoOuJ08QgwxGnEn7gg/t4iZEhEC3aKVLjB69uhYvxcg2vh2ESpahIYNhLmEnA/D3C/T0PbstSkZSKG2A6uVUsSt8IG3Bcgt1tiFSuIkDJAvwYD7r0SanKQGKl98ABxROGD64cqwo0XERHaynhXdZdV/WZBh5/D0X/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pyVxAYXY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pyVxAYXY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 662AqsbJ71875067, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782989574; bh=6oidG+GErJm8FvmpYYel3i5fYgxw3UFmmr9RQwtIHOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pyVxAYXYh/rteNKSpsBnZjZpqCt2sGG9ZTNwFSHozdjmqa5k620AtKSgaczaFhAly
	 jZ1Ot/h71DNc6MnAYCWMFUgw+KMyQz6Joyh7XjHEzZ0hPfVgcNKGQOwKxb2x67lZXq
	 Xz3c3qmHUG0mkuGqr/tPYeqiJlpvCtGxAJxMt9OPGxvHzRV1RyrNaS2GbVYzrCVNTV
	 /SPsxztPU+aeQ8dtYToCZpgE4TxdMWPg6aV15ObSCHSUQugtBDImOYEXzO46vy28H+
	 DKeNcmKprLgUiWck3UEoa+vFkeOWFxUaXAAYQ5k+qqvi05c4wSQTPdqHHGvKXFtB0H
	 KaEb4pZfhsi+Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 662AqsbJ71875067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 18:52:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Jul 2026 18:52:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Thu, 2 Jul 2026 18:52:54 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v4] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Topic: [PATCH net v4] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Index: AQHdBSawlGaS5q8//kGEPfCefRjucrZV2E0AgAQ5B3A=
Date: Thu, 2 Jul 2026 10:52:53 +0000
Message-ID: <20c431f98e00464fa8a4ba1f431e89fd@realtek.com>
References: <20260626044539.37753-1-justinlai0215@realtek.com>
 <20260630020126.2366786-1-kuba@kernel.org>
In-Reply-To: <20260630020126.2366786-1-kuba@kernel.org>
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

Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     rtase: Workaround for TX hang caused by short UDP packets entering
> hardware PTP parsing
>=20
> This commit attempts to work around a hardware TX hang caused by
> out-of-bounds
> reads during PTP parsing. It introduces logic to pad short UDP packets to=
 a
> minimum transport data length before transmission.
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 255667775f0e8..944ffe71b2d07 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> [ ... ]
> > +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> > +{
> > +     struct ipv6hdr *i6h, _i6h;
> > +     struct iphdr *ih, _ih;
> > +     __be16 proto;
> > +     u32 no;
> > +
> > +     if (!rtase_get_l3_proto(skb, &proto, &no))
> > +             return false;
> > +
> > +     switch (proto) {
> > +     case htons(ETH_P_IP):
> > +             ih =3D skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > +             if (!ih)
> > +                     return false;
>=20
> [Severity: High]
> Does this skip the padding workaround if the IP header itself is truncate=
d?
>=20
> If the packet is shorter than the IP header (e.g., less than 34 bytes),
> skb_header_pointer() will return false. This causes rtase_skb_pad() to
> return true, allowing the packet to skip padding. Could this small unpadd=
ed
> packet still trigger the hardware parser and cause the TX hang?
>=20

Thanks for pointing this out.

A truncated IPv4 header can also trigger the same hardware TX hang
issue.

We'll update the workaround to handle this case as well.
We'll also update the commit message to document this hardware
limitation.

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
> > +     if (udp_offset > skb->len)
> > +             return false;
> > +
> > +     trans_data_len =3D skb->len - udp_offset;
> > +     if (trans_data_len < offsetof(struct udphdr, len) ||
> > +         trans_data_len >=3D RTASE_MIN_PAD_LEN)
> > +             return true;
>=20
> [Severity: High]
> Can an attacker bypass the workaround if the transport payload is very sm=
all?
>=20
> By returning true when trans_data_len is less than
> offsetof(struct udphdr, len) (which is 4 bytes), the packet is passed to
> the hardware unpadded.
>=20
> If an attacker sends an IPv4 non-initial fragment with a very small paylo=
ad,
> the hardware parser might identify the fragment as UDP and attempt to rea=
d
> the
> destination port at offset 2 from the payload. If this out-of-bounds read
> hits residual uninitialized memory in the TX FIFO containing PTP port val=
ues
> (319 or 320), the hardware could incorrectly classify it as a PTP packet,
> continue parsing out of bounds, and trigger the TX hang.
>=20

Thanks for the review.

The hardware fetches packet data according to the packet length
specified in the TX descriptor, so it does not fetch residual data
beyond the end of the packet during DMA.

The affected out-of-bounds access occurs after the packet has already
matched the PTP classification criteria (UDP destination port 319/320)
and entered the hardware PTP parsing path.

If the transport data is shorter than the destination port field
itself, the packet cannot match the affected PTP classification path,
so padding is not required for this case.

> > +
> > +     dest =3D skb_header_pointer(skb,
> --
> pw-bot: cr
