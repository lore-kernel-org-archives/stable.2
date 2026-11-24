Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515528;
	b=DjO4iQj9CshjX6tg3atiJKNAWXDCDAmOn+PDgfIFTMNEGp0qgF+ILAGX2cV/KUBFP+Rm
	 GmE3L+XfOSdUiOHPtg0JuXWwjjN80KWFooib+7Lzvc1M5ilcyeDV/PfoSJvrhptbelCmv
	 Y+QXRAZueHweDOlG7736h6ZtsuItFWofbryHqImiEbdOL+lk/ls5eV/E0SXg5RWNxFGWx
	 IxWAAMj4hfcftdKmSCL0HLX347PFO2WmiYB7g74FvkSHwAr2s6MhvZ0LtAGpf9ibtFN28
	 wPv75tas6MQbSNpdxMSJRLrXuTEXgwwwxbOjTTxFDH2mvm2mnmOHFOax0SZrMcLlMfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CUO4ExU02cQGrmPrcJ49fSWnHPQqWJxdiEswQmxThgM=;
	b=F6v40DLEvRmIdF7l7MpMHmgVt3QZHgdyBa7zYEZi2sNy+/IVd/pKcJ1waH6ckATqUHbH
	 vN3whlz5R2O2oC71OzISYT6Qnf9HSPDpJLGhiAs2JYGmfEaImw+lyMe5sdT9yshkv9puJ
	 IJwCglUnozroSXDBYB9Fw4ykfnm/cuPkjRppw+NEs/dZM7aodhyKh4+Bk+wGiD1wBmjNN
	 XtydBR6vouvZVRCgLNm2Nh/4KPwkjIZRwgGJgX8pzV5HYvMwL10CBn83iRcMsY2s4sPfg
	 WtGH7Cf+8c2yg9whaiUPsYLeH/EP117JKYPP7ihL+R8IRPobKbt4/drtKh7r66G/brA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7Bw9TsG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD7606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEAD7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7Bw9TsG
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a42b34e930so3776710f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:18:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515526; cv=none;
        d=google.com; s=arc-20260327;
        b=MoS5Ir53YWoO++qXehr0Ypw9UdoJrgg468LmsCTOKQFyKzYW1icCipuWwN4jGC6kqW
         xPCyw+HS9NvCUvfEOaPSknCbVxcvhcE5app1UNCUUcyv472sh7JsToHB9oHArTA2gR2g
         0YK2zAfz8dbZEhfLSdkBYRA6LQWZItMX0WdeHxp4V1RLGEMVuBtAzdQ4eDGI5jXTu6Bl
         lmutZoyCmjzqOhlr/zhoveQS7MeseA/4JVrJAXoIKdd6+rj8KQ1BQ/nhu11Zjv0/RWAj
         YOJYnxckEhyCx5RI69/hhCU4ACyznGYTLjgrXpgIN/NH/D2C+FMSunpdGRwc7PBpsd/6
         Y8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUO4ExU02cQGrmPrcJ49fSWnHPQqWJxdiEswQmxThgM=;
        fh=vYlLNI+vd9xISbOPrS7nwhYx7pHxPEMthtI0DXlIYOg=;
        b=PqIWemzR1kjDh7LyMWBAIL6md2gcFQTKgl//L2rFENOxTyPrmoSTNUrECr3AZf3/r3
         ///aZHl+zrV1tav/E0UhW4hh3q02Xli+as3yDgtDrof9qwofOcdMlBFhVbbxuWVhVeOR
         imeUSxDMokxZwCJL8aC8bAur947q+e1wNsRjewzunQD3I5XY474zZi3ryCbV2v8hsH6O
         MO1DPcs/i8DYUMiOaRQipfaSlRmtv2o3nsgOe7qzFX+/RrsMeF9rIWAO0E2k+AG+F03E
         yG3EpiKBBKSZ8Ela93HN32pdtIxH2I5iKE6NGoLXFw+QR6P+BiZaLWl5eGHcwpBg2ZBc
         KemQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795515526; x=1796120326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUO4ExU02cQGrmPrcJ49fSWnHPQqWJxdiEswQmxThgM=;
        b=z7Bw9TsG4OANK41aSJfx8Lx42vGTu6EfpD/A4/S+62rlzAAld2aM9T2rndBLbwNGfi
         VUHNrmDzd3bP4sGgqonXQ459tcvQCh/Ig5ieK4Xc5H+doyalKkY1OqGh5SoD/k1TXgEa
         PGd/f4alC4T31elB5DPYDkglEDecs8ZXeQS/9LQN1VAm/35Ji2ROfikeupQ7VnUCkwaV
         M31aWODSRCgaLXE0pwQc62QMIIn6BYiG0u2S1WBnxaCg71d8Ennal7FnMmGQChvVhZKN
         +/Xn/f+DeOr1Trd+RdoPoPfaa6xRLxMo4hJSxblVSb2EP2zuffaJmnU+UOlj676YIYV9
         h4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515526; x=1796120326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUO4ExU02cQGrmPrcJ49fSWnHPQqWJxdiEswQmxThgM=;
        b=Ebpre9zRQYhfVH35YcrZsmw9+M0WBezio2+HujErY8b5jeHDOfMCmtxAgzQn8zMsST
         vBn8qUPP0dwUYKu6uU5tppB41ojmfU40V7pcZbmyazs4UqtVdbcAtq1DVFraB6d8wf5d
         cmnneL0ZtYVtqIsUF3JnNwv+K9R1/R3v1E55ydwdn1TcoQg6zt/9bUlJ210oQ38fKa9U
         PXLqNuNmJxcGnvg2SiwoPrb3zSGQrRasaTrZX1e2Gi+r5Shnw03CYqtnK+cMtyN5lRFx
         GpqQs9obz74KkrkjLMsVWdiwwL2XbayEYUjueW4tNOC/QNZ2xxtkCG8SUR7Soy92kttC
         R/UQ==
X-Forwarded-Encrypted: i=1; AL+hErEKhu0OvzW57sKq2oo4LnG6ROdUukkC4cVOnUyfviXE6lUiVK1tm0LXbvl3gqpyXuei4gaLXxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aceY0+9FYA+dA5EYRvg+nPfFVqJlCJU41Iztv4qP6CrMIGPUr
	ksuDR6nfUAo7ljLzjqcf/7wfRT6wTXJEOaaMGCES8twxXttXiW9IDQ75hFW3uaC7tSD2TM/D/9S
	lJVc/ekv+n6waI7v/2jyRHtcjwTIilG0=
X-Gm-Gg: AZFdTZeouVQBLi+SJX0Og7xbPivUx7r0HIktGWrblaAlTvGAIJBnuB+F73VlBsLrWpQ
	w3K+uLjZJSKUorisnZXGEjK3+JnkQ3psRVPwOFggiWkjwcRBXP4NgwQEWKV0FjibjtdBUe1K0F3
	e4gnYGvOy9BBQMbFTuNT1YItJhmR3KqvLHfy601CH26muK7Keg4WeHqdzcs9KdtHi+Kfkg3SZmU
	0a2dsEDmSTkvhAEXqxnJZvJbrJWcPRaXtHM6hBFXd6oEmqRaryjicpiJBm3+aWLKx4oYLieXBUY
	Efo0mMxxExKV8OoXEwCEDVeib8aXSLAMfqCfzaymh1fdH0fNrMj8Yoy8gBI5A7ivc9uiz6o0084
	G8FzGEzHi4Z6HjbkS6B6L4m4x4gO3M8kvO0c8zzxu
X-Received: by 2002:a5d:5846:0:b0:4b5:fdc3:33ca with SMTP id
 ffacd0b85a97d-4b5fdc33455mr5655709f8f.32.1795515526164; Tue, 24 Nov 2026
 02:18:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
 <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-4-f2322a91686d@gmail.com>
 <179551183567.11700.4795900066384429160.b4-review@b4>
In-Reply-To: <179551183567.11700.4795900066384429160.b4-review@b4>
From: GaryWang <is0124@gmail.com>
Date: Tue, 24 Nov 2026 18:18:34 +0800
X-Gm-Features: Aa3M54p4pYVawcdbet-1QzcXbMDc3P95wSAEB4W3N0rsbxri08OxfQ1k5YM--u0
Message-ID: <CANYHO6pWocCPaO=_6Feh9nAY4EpQOtznviwks7N5VOp9cAKszA@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO
 OUT not function mode
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniele Cleri <danielecleri@aaeon.eu>, JunYingLai <junyinglai@aaeon.com.tw>, 
	Louis Chen <louischen@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, BillyChou <BillyChou@aaeon.com.tw>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:17=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> > The CPLD I2C pin mode setting following uart & spi used modes array
> > on device AANT0F04.
> >
> > CC: stable@vger.kernel.org
> > Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP b=
oards")
>
> Please explain the real issue you met and how you fixed it.
Ok.
>
> >
> > diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctr=
l-upboard.c
> > index b9af6dd93c34..66c1c3e3bfe0 100644
> > --- a/drivers/pinctrl/pinctrl-upboard.c
> > +++ b/drivers/pinctrl/pinctrl-upboard.c
> > @@ -225,11 +225,21 @@ static const unsigned int upboard_up_i2c0_pins[] =
=3D {
> >       UPBOARD_UP_BIT_TO_PIN(I2C0_SDA),
> >  };
> >
> > +static const enum upboard_pin_mode upboard_up_i2c0_modes[] =3D {
> > +     UPBOARD_PIN_MODE_FUNCTION,
> > +     UPBOARD_PIN_MODE_FUNCTION,
> > +};
> > +
>
> Add a static_assert.
>
> >  static const unsigned int upboard_up_i2c1_pins[] =3D {
> >       UPBOARD_UP_BIT_TO_PIN(I2C1_SCL),
> >       UPBOARD_UP_BIT_TO_PIN(I2C1_SDA),
> >  };
> >
> > +static const enum upboard_pin_mode upboard_up_i2c1_modes[] =3D {
> > +     UPBOARD_PIN_MODE_FUNCTION,
> > +     UPBOARD_PIN_MODE_FUNCTION,
> > +};
> > +
>
> Ditto.
>
> >  static const unsigned int upboard_up_spi2_pins[] =3D {
> >       UPBOARD_UP_BIT_TO_PIN(SPI_MOSI),
> >       UPBOARD_UP_BIT_TO_PIN(SPI_MISO),
> > @@ -289,8 +299,8 @@ static const unsigned int upboard_up_adc0_pins[] =
=3D {
> >
> >  static const struct upboard_pingroup upboard_up_pin_groups[] =3D {
> >       UPBOARD_PINGROUP("uart1_grp", upboard_up_uart1_pins, &upboard_up_=
uart1_modes[0]),
> > -     UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, UPBOARD_PIN_MO=
DE_GPIO_OUT),
> > -     UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, UPBOARD_PIN_MO=
DE_GPIO_OUT),
> > +     UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, &upboard_up_i2=
c0_modes[0]),
> > +     UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, &upboard_up_i2=
c1_modes[0]),
>
> I personnally prefer the actual implementation because it saves some line=
s.
>
> But if you really want to use modes array even if the mode is the same fo=
r all
> pins of the group, you should convert all groups to modes array, drop dea=
d code
> and explain the benefits.
The benefits just have flexibility in the future. if 2 pins mode is
not the same.
AI code review is not the whole accurate, The current code hasn't NULL
pointer modes array in UP2.
However the UPBOARD_PIN_MODE_FUNCTION starts from 0, if there is a pin
that has set UPBOARD_PIN_MODE_FUNCTION then it will get NULL pointer
modes.
So the good fix I'll set UPBOARD_PIN_MODE_FUNCTION as 1 then we can set I2C
to UPBOARD_PIN_MODE_FUNCTION as you wish.



>
> --
> Best Regards,
> Thomas Richard
>
