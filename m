Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC903A6F11
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786558; cv=none; b=JO/ZeEIUYIackttPLXSupyVHvTvxoot0mm24ADKDq22si3QPX8EdhMZhw9cF0h+gVR1S3tXF4+Wf5K1XfQ4jm1DEolnI3b3uR3tCdOtBfQ9XuxrHCMqi3G163HC3dSNLey7cguTd1yAPDeDXwq9Ei5Hvqph7tClb+S3xNx31xIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786558; c=relaxed/simple;
	bh=j0l5Yeu1IXxRzCWqFLFRgG5sM1UaUE3FtBu5zbwZqkM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aUXnprE6hsd4SFm2ONYLg6GXxA7RuhoosCDqf3XFwKqtCexJmBfS5Zv2zkt42aX4r/JDaQyPDPEb8JTdQON6XKqmaxHgh330kABRRqp+zwL6m04YYI8p0ehGMiYc25asLWxcRi68ghZG3s4WMhaQ4adYOJ66aODjsY4HvyTNzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RSfSIjWC; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RSfSIjWC"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j0l5Yeu1IXxRzCWqFLFRgG5sM1UaUE3FtBu5zbwZqkM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791786553; v=1; x=1792391353;
 b=RSfSIjWCUtrl0Ndo0OsOVB2S6CAmm/XWiRwea0euAbUI0XJJtKhwxxPZKTTXR7E8x4NfNR1T
 uqu8uzGH2gxX1jMwaUdFuNplONOwQ8Evpx+SJnWXoMCs7C2OpvN2UEtSYb3R3jxhD/QkVNAZZWL
 p/9/qWgp8qD4cfMVm5e/w6qY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3ba7e7c67ee29c0e;
	Mon, 12 Oct 2026 06:29:13 +0000
X-Mizu-Trace-ID: 3ba7e7c67ee29c0e
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 06:29:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <8a73778af0a82247f689236e0e7fb8387db71f75@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
To: "Ping-Ke Shih" <pkshih@realtek.com>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Ulf Hansson"
 <ulfh@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Kalle
 Valo" <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <13bac899a2ea49d28dcbd4a8c765f3ca@realtek.com>
References: <20261009123022.87787-1-luka.gejak@linux.dev>
 <13bac899a2ea49d28dcbd4a8c765f3ca@realtek.com>

October 12, 2026 at 3:53 AM, "Ping-Ke Shih" <pkshih@realtek.com> wrote:

>=20
>=20Luka Gejak <luka.gejak@linux.dev> wrote:
>=20
>=20>=20
>=20> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> >  +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> >  @@ -1389,6 +1389,14 @@ static void rtw_sdio_rxfifo_recv(struct rtw_d=
ev *rtwdev, u32 rx_len)
> >  curr_pkt_len =3D ALIGN(pkt_offset + pkt_stat.pkt_len,
> >  RTW_SDIO_DATA_PTR_ALIGN);
> >=20=20
>=20>  + if (unlikely(pkt_offset + pkt_stat.pkt_len > rx_len)) {
> >=20
>=20Can you use real hardware to test this patch to see if there is actua=
l case
> falling into this branch? (see below)
>=20

Sure,=20it does happen. I ran it on the 8723BS with debug_mask=3D0x40000 =
for 3
hours 27 minutes, cycling iperf3 RX traffic, scans and reassociations, an=
d
the message came out twice. Both times the descriptor claimed more bytes
than were left in that transfer, so this is not just a theoretical bound.
The aggregate gets dropped, the link stays up, and nothing else stood out
at the time.

> >=20
>=20> + rtw_dbg(rtwdev, RTW_DBG_SDIO,
> >  + "oversized RX packet: %u, %u bytes left\n",
> >  + pkt_offset + pkt_stat.pkt_len, rx_len);
> >  + dev_kfree_skb_any(skb);
> >  + return;
> >  + }
> >  +
> >  if ((curr_pkt_len + pkt_desc_sz) >=3D rx_len) {
> >=20
>=20Because I wonder if this condition is right? In my perspective, the
> curr_pkt_len =3D pkt_offset + pkt_stat.pkt_len + align_bytes
>  =3D pkt_desc_sz + ... + pkt_stat.pkt_len + align_bytes
>=20
>=20Why does the if-condition plus pkt_desc_sz twice and compare with rx_=
len?
>=20

pkt_desc_sz=20turns up twice because two descriptors are involved. The on=
e
inside pkt_offset belongs to this entry:

        pkt_offset =3D pkt_desc_sz + pkt_stat.drv_info_sz + pkt_stat.shif=
t;
        curr_pkt_len =3D ALIGN(pkt_offset + pkt_stat.pkt_len,
                             RTW_SDIO_DATA_PTR_ALIGN);

rx_len is what is left of the transfer from this descriptor on, since the
loop subtracts curr_pkt_len from it each time round. The second pkt_desc_=
sz
is the header of the entry after this one, so

        (curr_pkt_len + pkt_desc_sz) >=3D rx_len

means there is no room left for another descriptor. That makes this the l=
ast
entry, and the original skb can go up instead of a copy so the stack free=
s
it. Without that term, whenever less than pkt_desc_sz is left behind this
entry, the loop would come round once more and read a descriptor out of
padding. curr_pkt_len is rounded up to 8, so it stops up to 7 bytes early=
,
which only decides whether the last packet is copied or not.

> However, it should enter to handle/free the last aggregated packet.=20
>=20Can you enlighten me how it looks like that?
>=20

For=20a sane aggregate that is exactly what happens. My check reacts to t=
he
other case: the descriptor claims more bytes than were read, so curr_pkt_=
len
is already past rx_len and this same branch hands the entry to
rtw_sdio_rx_skb() with a pkt_len the transfer does not have. I would rath=
er
drop that entry and the rest of the transfer than pass it up, and after a
descriptor like that the offset of the next one cannot be trusted anyway.

Best regards,
Luka Gejak
