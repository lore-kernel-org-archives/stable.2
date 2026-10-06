Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967203EC685
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295404; cv=none; b=oa5ehw5MZrtr3n+d8YsagkDB2WWOyNgt70RlSZw2jNjOV3oMy+m1G8CFuzCrfWAlFHqOLBzDVB1htV8EUIEiyvMCU+TL8nkDCrV3R3wOwOFkYFJ35lltQO5OorpOuQMbJT8tJqYWtktehKbJzqjVoG61JkghR2zjCNuFhy3BCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295404; c=relaxed/simple;
	bh=GPmw8AqftBV38rZhW8wE/zQAx5QAmhgjAvNnumw0xs0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dQ8au+ZYDE+gP5vfWbr5h5WU0Q/IdEExpht4WewhKg0TMGWVOktvkzdn/PqvHYkqUudoL/F+GMk9q6JzNsmy4Mkg3/8r+5OGakppvJRP7OAySOidpUGGfhHqpX4mgEyo0S3mbI9b1FnitZ4ijD0F7tiPplE967jpK2+6F8ElidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OnT1ksDM; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OnT1ksDM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GPmw8AqftBV38rZhW8wE/zQAx5QAmhgjAvNnumw0xs0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791295397; v=1; x=1791900197;
 b=OnT1ksDMSNgrOSH8ktxOwVl7sBmO9/mXtKVv5FzP6XDYEQjWcRuqgM/wSSC79KtirrbKNy2i
 um754iBGXaUzWU/B6hmtXBAmCD8+sT+4cymziOkWQ+D1BCQ8DINbzlO6KtGWclEpXNQYrJFSXdZ
 2dFpmduJUNaFz2IS1Bqjo/Sw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 748223c0c7949980;
	Tue, 06 Oct 2026 14:03:17 +0000
X-Mizu-Trace-ID: 748223c0c7949980
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 14:03:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>
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
[...]
>=20>  @@ -1082,7 +1084,11 @@ static int rtw_sdio_start(struct rtw_dev *r=
twdev)
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
>=20By 'git blame', the work is added by
> 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on pag=
e starvation")
>=20
>=20Maybe, the fixes tag should be 28eaf7971a20. I think there is no way =
to apply this
> to 65371a3f14e7 (your fixes tag)
>=20
>=20But I think you need this because patch 3/4.=20
>=20

The cancel is needed. Nothing else cancels this work before the
device goes down, the only other cancel is at remove:

	cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
	destroy_workqueue(rtwsdio->txwq);

The stop hook runs from the chip power off op, so the MAC is powered
off right after the HCI stops, but items can be pending at that point,
because the 8723bs retry re-arms the work with a delay:

	if (!rtw_is_8723bs(rtwdev))
		return false;

	queue_delayed_work(rtwsdio->txwq, &work_data->work, delay);

The delayed re-arm came with my back-pressure work, 28eaf7971a20.
So in my opinion cancel should stay with changed Fixes tag.

> >=20
>=20> }
> >=20=20
>=20>  static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
> >  @@ -1470,6 +1476,9 @@ static void rtw_sdio_handle_interrupt(struct s=
dio_func *sdio_func)
> >  rtwdev =3D hw->priv;
> >  rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> >=20=20
>=20>  + if (!rtwsdio->running)
> >  + return;
> >  +

I think we should keep this check too, per my explanation below.

> >  rtwsdio->irq_thread =3D current;
> >=20=20
>=20>  hisr =3D rtw_read32(rtwdev, REG_SDIO_HISR);
> >  @@ -1703,6 +1712,9 @@ static void rtw_sdio_tx_handler(struct work_st=
ruct *work)
> >  rtwdev =3D work_data->rtwdev;
> >  rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> >=20=20
>=20>  + if (!rtwsdio->running)
> >  + return;
> >  +
> >=20
>=20I don't think we need this, since you added cancel_delayed_work_sync(=
) in
> rtw_sdio_stop().

I think we should keep the check. The tx work arms the SDIO work at the e=
nd,
and stop does not cancel it:

	rtw_hci_tx_kick_off(rtwdev);

	cancel_work_sync(&rtwdev->c2h_work);
	cancel_work_sync(&rtwdev->update_beacon_work);
	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
	cancel_delayed_work_sync(&coex->bt_relink_work);
	cancel_delayed_work_sync(&coex->bt_reenable_work);
	cancel_delayed_work_sync(&coex->defreeze_work);
	cancel_delayed_work_sync(&coex->wl_remain_work);
	cancel_delayed_work_sync(&coex->bt_remain_work);
	cancel_delayed_work_sync(&coex->wl_connecting_work);
	cancel_delayed_work_sync(&coex->bt_multi_link_remain_work);
	cancel_delayed_work_sync(&coex->wl_ccklock_work);

so a kick can land after the cancel has run, and only this flag
keeps the item off the powered-down device.

Also I believe this series should be tested on hardware to ensure
nothing breaks.

Best regards,
Luka Gejak
