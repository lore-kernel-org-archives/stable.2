Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A1F63D9;
	Tue,  6 Oct 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252238; cv=none; b=LNpajzwhaBXwXEPsxBJuwcilYKpyzs+n15VEZG+ywrTxdf4ugqHcTtePqFHdZMLuMf90864Pdxj3l5I7lHxyn4AOHQGZPNR/eIliqk/K7Fgkm9J84D/njocvvl4XZgZEAHTxqIFQHZ1uVK3gVIXLi+/YxW6C1LLOpXxlnyNKEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252238; c=relaxed/simple;
	bh=UcM0fLnuGlmsrwdCZCIHYWrOXsQyz/njPtJz8HsJXLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiestiLRtIvJ1Qp+ubfPp0SQyg/VYQL7eDXDPt/ueATb06+ZeeXqAp7qG4QH9fPlEw8LN7aD3J2U7rT42knozletYUXmop0YH1hNYgDr1bkM/elrJTTXdTTr5WqOXqGEa6MQJzfAv7nlS1jyYuMtloIhUir5XJlkEhIqlI9goFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oTstYb34; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oTstYb34"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69623ANB02459980, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791252191; bh=NaPWYimvtZtuDQltgIr9cFosYb2Zkq08dfDxQDfohJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oTstYb34zKRFqUYtoo+AvpCeqq23KQIQG+BbZjXEVc5KtxyQM8WNCLEWKCIdZDH9U
	 PilL+LlHiX4Kd52hy35HUfLToCgX7tVJiJNFv1fEYxGMmBK9i7q9AT3NvvKoOYWFDV
	 nz8O+ndH576P8tQ2Ru4QRbCvKrJ2aSHVZo4/L3qjdM7VVX86gqJ5vxLyZdktji+r/Y
	 /yU6Xp4LiPh2Jt2k4akH6BNOI2MaXrluaBnETyiq/48VW8qNM+TenJi8sXzgGL/xzd
	 uMQ19rY6RQdDWsw7lRPmOzxtXCAbyqWdwUbx8ZzcRmdYzrkd6YulSEIBgIJ6aydlq4
	 /uJ/O7zDa3cvQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69623ANB02459980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 10:03:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:03:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 6 Oct 2026 10:03:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Topic: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Index: AQHdVKaABn3K541ouEKSWwSRfxdAa7bvvepA
Date: Tue, 6 Oct 2026 02:03:10 +0000
Message-ID: <6665409e1d374c1face4936b827a6a9d@realtek.com>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-3-alastair@d-silva.org>
In-Reply-To: <20261005084849.3109337-3-alastair@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Alastair D'Silva <alastair@d-silva.org> wrote:
> When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
> delayed TX work may still run against a powered-down device.
>=20
> Track the operational state in rtwsdio->running (similar to PCI), check i=
t
> at the entry of rtw_sdio_handle_interrupt() and rtw_sdio_tx_handler(), an=
d
> cancel the TX worker synchronously in rtw_sdio_stop().
>=20
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 12 ++++++++++++
>  drivers/net/wireless/realtek/rtw88/sdio.h |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index e39284b71837..d2f4d7e8bc83 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1054,6 +1054,7 @@ static int rtw_sdio_8723bs_check_rqpn(struct rtw_de=
v *rtwdev)
>=20
>  static int rtw_sdio_start(struct rtw_dev *rtwdev)
>  {
> +       struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
>         u32 clear;
>=20
>         if (rtw_is_8723bs(rtwdev)) {
> @@ -1075,6 +1076,7 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
>                         rtw_write32(rtwdev, REG_SDIO_HISR, clear);
>         }
>=20
> +       rtwsdio->running =3D true;

Is there existing race between start/stop/interrupt? Need a lock?

>         rtw_sdio_enable_interrupt(rtwdev);
>=20
>         return 0;
> @@ -1082,7 +1084,11 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
>=20
>  static void rtw_sdio_stop(struct rtw_dev *rtwdev)
>  {
> +       struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> +
> +       rtwsdio->running =3D false;
>         rtw_sdio_disable_interrupt(rtwdev);
> +       cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);

I think this is the major statement added by this patch, but I'm not sure
if this is actually needed. (Maybe, Luka can help this)

By 'git blame', the work is added by
28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on page st=
arvation")

Maybe, the fixes tag should be 28eaf7971a20. I think there is no way to app=
ly this
to 65371a3f14e7 (your fixes tag)

But I think you need this because patch 3/4.=20

>  }
>=20
>  static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
> @@ -1470,6 +1476,9 @@ static void rtw_sdio_handle_interrupt(struct sdio_f=
unc *sdio_func)
>         rtwdev =3D hw->priv;
>         rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
>=20
> +       if (!rtwsdio->running)
> +               return;
> +
>         rtwsdio->irq_thread =3D current;
>=20
>         hisr =3D rtw_read32(rtwdev, REG_SDIO_HISR);
> @@ -1703,6 +1712,9 @@ static void rtw_sdio_tx_handler(struct work_struct =
*work)
>         rtwdev =3D work_data->rtwdev;
>         rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
>=20
> +       if (!rtwsdio->running)
> +               return;
> +

I don't think we need this, since you added cancel_delayed_work_sync() in
rtw_sdio_stop().

>         if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
>                 rtw_sdio_deep_ps_leave(rtwdev);
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wire=
less/realtek/rtw88/sdio.h
> index 6e7e6009744b..a3851d4a58e7 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.h
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.h
> @@ -168,6 +168,7 @@ struct rtw_sdio {
>         bool sdio3_bus_mode;
>=20
>         void *irq_thread;
> +       bool running;
>=20
>         struct workqueue_struct *txwq;
>         struct rtw_sdio_work_data *tx_handler_data;
> --
> 2.53.0

