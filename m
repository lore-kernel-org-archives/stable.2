Received: from mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A63B9618
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296314; cv=none; b=jB4UuREV9ovu+aaH0ErSZmxiGuq2rmskc6swJWe5KuDdhKfjBtaljTNMeDrb4HrZgq0oDRdmJCKJSU0fH5nrV9CNz57xeDZCB2XXak6ZEFyxssIkPvURuyovPVh8VGm7+zF261vnNLTPmC6BkK1/BmS058ZgHvdQfpbzJaadJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296314; c=relaxed/simple;
	bh=lY+UNi6/Xewdo1898eoNR/G3xmaD28GHwyLqmqUFsco=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=s2gQQ2LsBR8TN6fartNdSfaEx9/e2GdIKiGXMcpW/zT17UyQuih9KI5h94J40Pnkg/f4dYuCALD2UGWeawOu60SUrUpEVFGp1lY0dn/2eD/iZMEq0f3urJBkwrnUDUydM/OqJoaTsbgLhu0/QsLRalrRD0QNUl+I5UssV6XV2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eA/Y2DTH; arc=none smtp.client-ip=91.218.175.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eA/Y2DTH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lY+UNi6/Xewdo1898eoNR/G3xmaD28GHwyLqmqUFsco=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791296310; v=1; x=1791901110;
 b=eA/Y2DTHp66qFKGiUpDevC98TwSGyHl3jiGvpFfEk7BAMpdLIiJgyP902VXfLGPoqShMi2oS
 Dh/32CV6/pFIKzIcEypU2SW/PfXpi1Mro+5VOEAHLQoBRYrzW9RQV7wUSqL0psg3nNQr0fxj4+v
 YYEQX0LbVpZW6KYA5SXl9aF4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 193ce7972a46e22a;
	Tue, 06 Oct 2026 14:18:30 +0000
X-Mizu-Trace-ID: 193ce7972a46e22a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 14:18:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <9821f85cc14d3e3d5c0ea557013002a732e3fb42@linux.dev>
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
In-Reply-To: <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-3-alastair@d-silva.org>
 <6665409e1d374c1face4936b827a6a9d@realtek.com>
 <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>

October 6, 2026 at 16:03, "Luka Gejak" <luka.gejak@linux.dev mailto:luka.=
gejak@linux.dev?to=3D%22Luka%20Gejak%22%20%3Cluka.gejak%40linux.dev%3E > =
wrote:


>=20
>=20October 6, 2026 at 04:03, "Ping-Ke Shih" <pkshih@realtek.com mailto:p=
kshih@realtek.com?to=3D%22Ping-Ke%20Shih%22%20%3Cpkshih%40realtek.com%3E =
> wrote:
>=20
>=20>=20
>=20> Alastair D'Silva <alastair@d-silva.org> wrote:
> >=20
[...]
>=20>=20=20
>=20>  static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
> >  @@ -1470,6 +1476,9 @@ static void rtw_sdio_handle_interrupt(struct s=
dio_func *sdio_func)
> >  rtwdev =3D hw->priv;
> >  rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> >=20=20
>=20>  + if (!rtwsdio->running)
> >  + return;
> >  +
> >=20
>=20I think we should keep this check too, per my explanation below.
>=20

Correction,=20as I realized I didn't include explanation for this below.

Sorry for that, here is the explanation:

This check sits on the interrupt path, which the cancel does not
cover. rtw_sdio_stop() only masks HIMR. The SDIO IRQ is released in
rtw_sdio_free_irq():

sdio_release_irq(sdio_func);

and that only runs at remove. A request raised just before the mask
can still reach the handler once after a stop, and without the check
that run reads HISR and writes the ack back on a stopped device.

Best regards,
Luka Gejak
