Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02413CA92
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338378; cv=none; b=MzPUuwliV2stj7GuQK0x6VIZAvyZdX35KPl+0kE1TwofCfn/qJS/DX282K6OcvOVFxu0+l0/oIhMEw5a031upswvnXWWjx1hCZkRMNKia/GiE4FztgQA4SxosuLDD6aGrNHeYBQa1AXoZ7/sCXFGLycLCCMyQdWsbWM1Fmu7mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338378; c=relaxed/simple;
	bh=UwtoF8WCtXk9zFXDkcpLrNH/XAXzLP3ASIL5gUziyrM=;
	h=Content-Type:From:Subject:References:In-Reply-To:Message-Id:
	 Mime-Version:Content-Disposition:Cc:To:Date; b=TINAeSYgQ5ChY0ve6Kli2CoxHo7O2LBLijAUrxR1MfDA/mwNyYxFaWA2B4kfbf6YlrXYRf0W6qGKt08bYKd7T0ierPXFZsYkbG6c0dpc6xd7Kd2tGmHr7xTsMw8vG5cDcBQmPREE8YoTtuthQogWYBzss3RY6a/r4UACVDd9XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=ZxwagLtB; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="ZxwagLtB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786338369; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pGLKIkrykXTegAbf95GWZLKiQkazLl3chVfsyo2cLj0=;
 b=ZxwagLtBjVwbUVMMp6WgQmuMIZgsDRTm6f1uiemqW6oEN+VoFWlgFloihD083M2c1KgWxk
 0FXaG4k26p0wtj4AasK3tTkEDs8o02TLioJi7IPehJ83yyZD3eyP1xvldLMTXi/jjlV6ou
 u2VUuRnKkBV9En6z4AQEIeKlRHg7khxNShJ5LXt5l4KmXr4pGOMBVe4wrL3nhoWin8r9hM
 f+uO6OWErwOg0fZ5gWC2YD5DUXF1hp8rt7hyBByNqTEwPfvkcy/zsTo5vnxUYTWHe7codo
 QR0AsQ1cgbUIS8ES35fulbfI8uC/Bf3qc9YETn10KpAKwYojM7bDXCZRDYmldw==
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH] iio: accel: adxl380: clamp FIFO sample count
References: <20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc> <20260810002808.76ffd95a@jic23-huawei>
X-Lms-Return-Path: <lba+26a795c3f+1c6dba+vger.kernel.org+me@cherr.cc>
In-Reply-To: <20260810002808.76ffd95a@jic23-huawei>
Message-Id: <anlcOa5tkTUN9EQr@nobug>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Disposition: inline
Cc: "Shengzhuo Wei" <me@cherr.cc>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Ramona Gradinariu" <ramona.gradinariu@analog.com>, 
	"Antoniu Miclaus" <antoniu.miclaus@analog.com>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>, <linux@analog.com>, 
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Received: from nobug ([202.112.51.208]) by smtp.feishu.cn with ESMTPS; Mon, 10 Aug 2026 13:06:06 +0800
Content-Transfer-Encoding: quoted-printable
To: "Jonathan Cameron" <jic23@kernel.org>
Date: Mon, 10 Aug 2026 13:06:01 +0800

=E5=9C=A8 2026-08-10 00:28=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=EF=
=BC=9A
> > Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
>=20
> In my opinion at least, these are not fixes. In general we don't expect
> drivers to be hardened against broken hardware returning out of spec
> values.  I don't mind taking simple cases though that don't complicate
> the code much and if anything make it a little easier to follow,
> but I don't currently see any reason to mark them as a fix.
>=20
> So drop that tag for v2.
>=20

Hi Jonathan,

Thanks. Understood =E2=80=94 I'll drop the Fixes tag and stop clamping.=20

> This is papering over what we think is a hardware failure. Unless I am
> missing something the device is returning garbage, otherwise we are in
> range and this has no affect. We have no idea how much data there is
> if we get a value outside the expected range.=20
>=20
> As such I'd expect an error print and probably no attempt to carry
> on reading as we have no idea what happened.

For v2 I'll treat an out-of-range count as a hardware error,=20
log it, and skip the read rather than carrying on:

    ret =3D adxl380_get_fifo_entries(st, &fifo_entries);
    if (ret)
            return IRQ_HANDLED;

    if (fifo_entries > ADXL380_FIFO_SAMPLES) {
            dev_err_ratelimited(st->dev,
                                "invalid FIFO entry count %u (max %lu)\n",
                                fifo_entries, ADXL380_FIFO_SAMPLES);
            return IRQ_HANDLED;
    }

    fifo_entries =3D rounddown(fifo_entries, st->fifo_set_size);
    ret =3D regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
                            sizeof(*st->fifo_buf) * fifo_entries);

Same for adxl367 (push_fifo_data: dev_err_ratelimited and return true
without reading the FIFO).

I'll send the two as a single series with a cover letter, no Fixes tags.

Let me know if this looks OK to you, or if you'd change anything, and
I'll send the v2 series.

Best regards,
Shengzhuo Wei
