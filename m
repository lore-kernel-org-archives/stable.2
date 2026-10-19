Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6F4E2F3F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411752; cv=none; b=dTpJCfQFxXAhIahIfjF70+Jv6WI1pPxB4E5Tuf28d9PvTYL8L275ern0JOMnWEOaXMsPJfkkAZuQg7cWAkTxLAjdtsXHvmTwjhLcDguwWo8hfs3S1mUSLnqbofzkF6+OvMmLaKV83OWEtes9ArJUG1XXQimBVgYYUs/rFexyPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411752; c=relaxed/simple;
	bh=B6PGmkEOmOTvRMG4KJSxa+Qi5H7nSmTaQb5cEDlkSyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF25i3F0lLD1w8hrDhKdxadG5wzNUPFknCdHv8aGn6gpbEfMrIYRwIrM8+5+CaGHguzZr7zvS9BWRIAAGauJYNw8Jq1ngzIZA32dpwzexIbkFRWPVuxYFCYf6jCK3QFY/gPzR33qa/Jh0PyUy3Wn3PYfr8yGeKtqZvIq8ay2+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG0nZZZc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG0nZZZc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so15184495e9.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411750; x=1793016550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQMT+oVedzgIQTTgsSc7H1Q1yfN1sP8EFn/tjZr2lw0=;
        b=aG0nZZZcNESLfrAJZ88dTK2CwmbB/xFE0YTlAIeNI3JH6AS3EtXBYYqJoUXNa8t1OG
         bqu+9nzydFdpZsPMtljMGEz+EiPasNyyN4v/N1BANtsJK4lvHZKV2eb4ZrQlJtO9rJU8
         GFhQ3uza5XhDizUYFWGt5eBMbZ9yje0ZAu3f7wPxHJ4FAYenBwEUWiOQNhW530wuXpPm
         9VHoao8d5EYpwOz/C+HiFlDbKhBOIPo6n/Yx9QGMntzEML64Ymn21T7jNEtcniUGz1It
         yEDNJaxe/uHBodggLQvTtIQYBEd9Rn52jeFLPKO+zG5qLQ9G1LurnbC/hq/sJpE7pCVW
         Vodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411750; x=1793016550;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQMT+oVedzgIQTTgsSc7H1Q1yfN1sP8EFn/tjZr2lw0=;
        b=GjiU10UEmuMTu8N93BVNyCVQixF+UGdBv2pLLzR+D2gKd87128RBjT6VR2/AWxjB7f
         Q4O8awIWIDupZB67zsxsNtME6mnz3UksnQVe3tnSrviEeBW5vq5abcRO3f1QP3b1qzCo
         EXhOZtkxtL4vhT7agwhzphacDoA4akzbVNqH1VV6tCbrobr6jshS62KAu+pyihjmCVof
         CJxT3B+grl7cWcq/I/5rVDFYcBulb3oyQWl9ifZb9XOzsGa//hxy/HLMw0E3TXVxMf0H
         I/6w7qvYcQTUu8loK0Hq+W6xp9s70fE5R/pfTciXmztvIpgAurItflL/zdVaiuU+1Cfj
         3TAw==
X-Forwarded-Encrypted: i=1; AKwUvBzVBfxJJrc4VrlIiJWKs+MX4gMqyQ/2ruI+c86zhVkOLcbsVINyAQoziRLOiDR2GhxyA03LEpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw+8r6qOiwM9OamIG9GVDiWayIfnFWEYSc/bHu2pKa/bv5d3u8
	+AxnoU4+kWo3Wl4/37x6cKQdZrR6e+7SzXc+s5YrfMBEYCRqjZBS08/3
X-Gm-Gg: AYBFou2NiUXlF4mpgjuHq2b+rA4/vJaocg0PZ3fLJK24dY6cYfS3YCO4luiIB9QHk3v
	/ObKW4M1GV+75s0WibTdH5F1C4VOx2pIkAwfuIJqo2XkIaikzZHC7dUBdO9NctHRJclOmMOljyK
	tDdxOmosBfGatVMFQxyoJKlZhvpMUlHeR0jI2cdhvpXUIxz3mcfjxPSBGDs55LvvVjb8xep+Ir2
	G06epXgByeKTbWAwi477dYQ94Izo1pr0NwiGt60kqPzaW36Fz/7Nc8hDJ7d3yZUc11LmuehwGFD
	kIGjdS/U6MQzh/burXTf3MAWGTOMO+FtjL6l191IaMuyFnvG1MIvlUIDiNy+Yk0MCbt0gTf/M9D
	2HVA7B39OLzqbEmjeijvzBVHpEDATZL8yzlogLfV0gqcLPa0fbxqcc5LxcrScHEz//oppRcA+a9
	3JFwCJr3M+Vp8b+RrFPFxn0euuA/DkxAmwLeOIPgmkNLNm2eZRftINBXqfk5nyqNcw7mg/R3rOk
	GfZtF8kVI3KtpQTdOOxSCfgSY9TaNRddqQk4zMv7qzMsvvrvvJFH+VtbQ9HLFngs8VWleomX1aY
	XEU0uk/homA4h9BDNefAK5e8YKogt3BplY48VHejWQOLlWExdj5bK9XLF5j94sWYfUJhtwotEqI
	Zz/YBAvncw/0L9OxQ7DOKSa3x+j4TE7ZJ89eNqfe4LBoZli83KpoII/ZA+nCBZTyAMP/zczc3k0
	nluU5r
X-Received: by 2002:a05:600c:4e8a:b0:4a1:8961:78dd with SMTP id 5b1f17b1804b1-4a1d7616464mr168857525e9.27.1792411749417;
        Mon, 19 Oct 2026 05:09:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm279022375e9.3.2026.10.19.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:09:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:09:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050: add missing trigger cleanup
 on remove()
Message-ID: <20261019140905.00000094@gmail.com>
In-Reply-To: <atX1alPtnByIsGFr@nsa>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
	<20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
	<atX1alPtnByIsGFr@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 11:54:41 +0100
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Sat, Oct 17, 2026 at 07:19:21AM +0200, Joshua Crofts wrote:
> > The mpu3050_trigger_probe() registers a trigger but
> > mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> > to clean it up, causing a use-after-free bug.
> >=20
> > Add the missing calls to the iio_trigger_unregister() function.
> >=20
> > Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> > Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.ke=
rnel@gmail.com/
> > Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/gyro/mpu3050-core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050=
-core.c
> > index 879caf3b729c..9e747836df3e 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1262,7 +1262,9 @@ int mpu3050_common_probe(struct device *dev,
> >  	pm_runtime_get_sync(dev);
> >  	pm_runtime_put_noidle(dev);
> >  	pm_runtime_disable(dev);
> > -	if (irq)
> > +	if (mpu3050->trig)
> > +		iio_trigger_unregister(mpu3050->trig); =20
>=20
> Yeah, I think sashiko is right... I think we can just reuse the if
> (mpu3050->irq) condition for unregistering  but then this patch depends
> on the previous one. And such dependencies can be set for stable so
> don't think it's an issue.
>=20
> I already pointed it out and Jonathan seems to have said the same. If
> you do have the time, converting the whole thing to devm would be nice=20
> - could be patch 3 :)

Bad time to be lazy :P I'll have a look.

--=20
Kind regards,
Joshua Crofts
