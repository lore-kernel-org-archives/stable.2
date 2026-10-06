Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC9366074
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261900; cv=none; b=k5327oF+ZZK6tD8kUChOorMs5s+YRL6mh6YUcthfTgSKZXkOwoIUU80W8Y/WAR/3xWA3y6UuBBaMllbosfUDOWXU+MUpgd/hQlQft3TCIomXvMQgLypJ8mBNG+HyCG/ouhJWava6fTAZs/L7iv02Lorwj3LkgJHeHrlLGHUR3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261900; c=relaxed/simple;
	bh=LvTzX7cb6p8OiIRr0hc3ZNBGkEWS0lY1HmU+S902xDI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=R9fmubJJ1cdoGVH7AfayUEcdF9T9EY8y5XdBRG1vVl9FkNSESQ8VtlR2fexLQFMd94qNmcYaI+nRXk6IeA1sbetq7FA9I7IFREmM3zLdZC/Iheu3p3OhAtYHiDSKSLJNBQldLvCEtrBare2NxbwgTPYMoIqUTt2M5HbgdZwvRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ja/NyRp4; arc=none smtp.client-ip=91.218.175.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ja/NyRp4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LvTzX7cb6p8OiIRr0hc3ZNBGkEWS0lY1HmU+S902xDI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791261897; v=1; x=1791866697;
 b=Ja/NyRp4xpiLhi6obGBjF5HIwjZWvYMC36l8q2dra+My74o0z8TL6oWWgD1AAqOwOrbNf5CD
 DFWN10i6+j+h+7Qscd50+tRhXx438npXcARYQfgWkqaPQV7X3PXuI+2RdCTW1Etuz87m6rRAsJM
 Nw3dt45bSenlMR6DVe6l3Dfc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4802f2a4ace27c64;
	Tue, 06 Oct 2026 04:44:46 +0000
X-Mizu-Trace-ID: 4802f2a4ace27c64
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 04:44:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <4d0885941b74480c7fd6399b9dff7ed64540a87e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
To: "Ping-Ke Shih" <pkshih@realtek.com>, "Alastair D'Silva"
 <alastair@d-silva.org>, linux-wireless@vger.kernel.org, "Kalle Valo"
 <kvalo@kernel.org>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 luka.gejak@linux.dev
In-Reply-To: <6665409e1d374c1face4936b827a6a9d@realtek.com>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-3-alastair@d-silva.org>
 <6665409e1d374c1face4936b827a6a9d@realtek.com>

October 6, 2026 at 04:03, "Ping-Ke Shih" <pkshih@realtek.com mailto:pkshi=
h@realtek.com?to=3D%22Ping-Ke%20Shih%22%20%3Cpkshih%40realtek.com%3E > wr=
ote:


>=20
>=20Alastair D'Silva <alastair@d-silva.org> wrote:
>=20
>=20>=20
>=20> When rtw_sdio_stop() disables interrupts, in-flight interrupt handl=
ers or
> >  delayed TX work may still run against a powered-down device.
> >=20=20
>=20>  Track the operational state in rtwsdio->running (similar to PCI), =
check it
> >  at the entry of rtw_sdio_handle_interrupt() and rtw_sdio_tx_handler(=
), and
> >  cancel the TX worker synchronously in rtw_sdio_stop().
> >=20=20
>=20>  Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation fo=
r SDIO based chipsets")
> >  Cc: stable@vger.kernel.org
> >  Assisted-by: LLM
> >  Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> >  ---
> >  drivers/net/wireless/realtek/rtw88/sdio.c | 12 ++++++++++++
> >  drivers/net/wireless/realtek/rtw88/sdio.h | 1 +
> >  2 files changed, 13 insertions(+)
> >=20=20
>=20>  diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/n=
et/wireless/realtek/rtw88/sdio.c
> >  index e39284b71837..d2f4d7e8bc83 100644
> >  --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> >  +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> >  @@ -1054,6 +1054,7 @@ static int rtw_sdio_8723bs_check_rqpn(struct r=
tw_dev *rtwdev)
> >=20=20
>=20>  static int rtw_sdio_start(struct rtw_dev *rtwdev)
> >  {
> >  + struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> >  u32 clear;
> >=20=20
>=20>  if (rtw_is_8723bs(rtwdev)) {
> >  @@ -1075,6 +1076,7 @@ static int rtw_sdio_start(struct rtw_dev *rtwd=
ev)
> >  rtw_write32(rtwdev, REG_SDIO_HISR, clear);
> >  }
> >=20=20
>=20>  + rtwsdio->running =3D true;
> >=20
>=20Is there existing race between start/stop/interrupt? Need a lock?
>=20
>=20>=20
>=20> rtw_sdio_enable_interrupt(rtwdev);
> >=20=20
>=20>  return 0;
> >  @@ -1082,7 +1084,11 @@ static int rtw_sdio_start(struct rtw_dev *rtw=
dev)
> >=20=20
>=20>  static void rtw_sdio_stop(struct rtw_dev *rtwdev)
> >  {
> >  + struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> >  +
> >  + rtwsdio->running =3D false;
> >  rtw_sdio_disable_interrupt(rtwdev);
> >  + cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
> >=20
>=20I think this is the major statement added by this patch, but I'm not =
sure
> if this is actually needed. (Maybe, Luka can help this)
>=20

I=20will take a look at this series later during the day.

> By 'git blame', the work is added by
> 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on pag=
e starvation")
>=20
>=20Maybe, the fixes tag should be 28eaf7971a20. I think there is no way =
to apply this
> to 65371a3f14e7 (your fixes tag)
>=20
>

Best=20regards,
Luka Gejak
