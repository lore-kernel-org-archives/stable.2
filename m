Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45326ED3C;
	Tue,  6 Oct 2026 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275348; cv=none; b=GXnIrmkT/8Fy/oHmjjIn5sbMSrM5LYWOt/zP1H+hpHktC4GPtjlDOa3Etyw9HtY2vaHTRWfGuciIKS9wRRVSIp7DQHkD3FD67XlfE0B3xa0e9NFM+BUvi/RU5IjWF2IWQxPnWnriJb7K1xPE6ASjT9WWP8ij/V0/5IwPsCsZL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275348; c=relaxed/simple;
	bh=4E90XbME5YYrCHUynb8Gq04uOMIs5TinNGnJqDgIEo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VWGXi5gyJFxVdbzx09oWRga0uOrNGXeRDZoL0TEvn+usH1MemIssxlQ4c9Ys85xqcgJRVQhQ9WT/je+4OcSJrGxpNiKVbK65ZL2zPD9TmTcP5PWutHEoICAVGIubQyg5DBb7gh2dyw9wmfdMu2G7SMt2ZCAKKgbmzuaKoYHI3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WrTuxpWN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WrTuxpWN"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6968SRylC2756064, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791275308; bh=YTvTHDWQ0MPVFXdmQKE3U9s9hkDXT5kOh2ihQfR5+pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WrTuxpWN3KxPc7nwUDcwojj1fJkMhfbBAWUaLKrXmrWN7MUHX4XLozxILBBzO7FDv
	 kobnoxH6cj6qzJENJh9djb0FNTmTSVdXFQ00kmXu4szYSL+quSDwGcmHBbX9bNOlNP
	 rCcpy8f+gbJYL/4dOiE51T+xHf36/tLX6DSy+LdAS+erhVqJ7j++EBJ14jqOhDo0ek
	 Wf4TbgQtbbqIzNzJeUqJFIbytVDbWQNiQDa436I5XyONGvfRYA+yCipJBIjrRMNDgr
	 Qhc0BoIAi8suGpgqdHUrLLwjV7k1d5daGz7zAhRs+CD+UrbT9lpTESraE9qdJWi/PC
	 /XEWRU4YorAEg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6968SRylC2756064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 16:28:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 16:28:21 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Tue, 6 Oct 2026 16:28:21 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
	Birger Koblitz <mail@birger-koblitz.de>, Xiangqian Zhang
	<zhangxiangqian@kylinos.cn>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Topic: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Index: AQHdVLexra3FlE5swkqMdmzmTHCGJ7bwLnWg
Date: Tue, 6 Oct 2026 08:28:21 +0000
Message-ID: <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
In-Reply-To: <20261005105249.1281648-1-lilinmao@kylinos.cn>
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

Linmao Li <lilinmao@kylinos.cn>
> Sent: Monday, October 5, 2026 6:53 PM
[...]
> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
> BMSR_LSTATUS can still be latched low when the carrier comes up.
> Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the netw=
ork
> cable is not connected"), the first speed query after link up can then re=
port
> SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until the next carrier
> change.
>=20
> Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
> driver consumes the latched link down itself. If the first read still rep=
orts link
> down, the next link-up notification triggers another read and brings the =
carrier
> up.
>=20
> Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
> replugs, the first read returned LSTATUS=3D0, a second link-up notificati=
on came
> about 32 ms later, the second read returned
> LSTATUS=3D1 and the carrier went up; NetworkManager reported 1000 Mb/s.
> Runtime suspend/resume with the link up did not change the carrier.

I think this patch may introduce a new issue.

Our newer ICs do not generate periodic link-status notifications. They gene=
rate a
notification only when the link status changes. Therefore, with your patch,=
 BMSR
will not be read a second time until the next link-status change.

Best Regards,
Hayes

> Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network ca=
ble is
> not connected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
> v2:
> - Fix it in r8152 instead of mii.c, detecting the link from BMSR as
>   suggested by Andrew Lunn.
> - Also use BMSR in rtl8152_runtime_resume().
> v1:
> https://lore.kernel.org/netdev/20260930113842.2640928-1-lilinmao@kylinos.=
c
> n/
>=20
> Only tested on an RTL8153B, with a 6.6-based kernel; the changed lines ar=
e the
> same in net/main. I could not check whether BMSR_LSTATUS is reliable on t=
he
> 2.5G/5G/10G chips handled by this driver.
> I could not reproduce a link drop that recovers while the device is runti=
me
> suspended, so that case is only covered by code inspection.
>=20
> r8152_mdio_read() cannot fail today. The pending RTL8157/RTL8159 series
> makes it return errors, so these two callers will need error handling onc=
e that
> is merged.
>=20
>  drivers/net/usb/r8152.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> f61686433031..e3947eb796c5 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -6979,11 +6979,8 @@ static void set_carrier(struct r8152 *tp)  {
>         struct net_device *netdev =3D tp->netdev;
>         struct napi_struct *napi =3D &tp->napi;
> -       u16 speed;
> -
> -       speed =3D rtl8152_get_speed(tp);
>=20
> -       if (speed & LINK_STATUS) {
> +       if (r8152_mdio_read(tp, MII_BMSR) & BMSR_LSTATUS) {
>                 if (!netif_carrier_ok(netdev)) {
>                         tp->rtl_ops.enable(tp);
>                         netif_stop_queue(netdev); @@ -8653,7 +8650,7
> @@ static int rtl8152_runtime_resume(struct r8152 *tp)
>                 set_bit(WORK_ENABLE, &tp->flags);
>=20
>                 if (netif_carrier_ok(netdev)) {
> -                       if (rtl8152_get_speed(tp) & LINK_STATUS) {
> +                       if (r8152_mdio_read(tp, MII_BMSR) &
> + BMSR_LSTATUS) {
>                                 rtl_start_rx(tp);
>                         } else {
>                                 netif_carrier_off(netdev);
> --
> 2.25.1

