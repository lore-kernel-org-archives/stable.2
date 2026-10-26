Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012361;
	b=icA+gs4DeL1WsiYg2cZbuljRHtTMc3nSGo6Yz6asvLZD0NyFMPwFjozpeQGTmzmeDK+F
	 kCki9HmLWpDzV7t8R5yw/McdY8TLdgOaVdX5xIVUOtDVY7G8CXzRWL1EVBwxkF/r7P5Za
	 AGX9mWiptg1Px6RMibYg4M4ouW7I4pMcr/hYH6rPSIgeCdW1lhokTEkA5xnIAH/oGPeaK
	 sRmVMFRbIlQh73TbXoFXZomBCtnHh8QQ9zcI3C/uKLqCNF7nw83NHWnPAVSRIspnGBub0
	 VCkgBTaZn6YUyzcdYZBQW+6FRlDS+eoEFCqkiSJcsc66FTubcyxo2YxBXbjSPGZ1Gwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AGezTdH/BGVGTlUMmaGBhI8YtAvNj4R/9yrQQ0+maDQ=;
	b=AydeD6GTW0PLO3yG5AEA1tEzMGca419C4XiaJcMNryrPnZzewVjRScPiBTlb+7tsywrP
	 x0vUA+ESDrbl2TWN94EQfHV9E5iV0NiqYZsfZMr9/mvY9SmqsjLtE37IcUduCci2m1bvr
	 cBAEIRcZTjguxAP8R11uJMHZcnhTG+jacuLEaBw73c02XJW29aey0sGEUN6V+kKDmYswi
	 a7stN45/Ri3LQRYfUF114gZc8pis6/DH/FTOpZNgvm82HhO9leIvVgtmuF+PywcUCk0tq
	 D2AibW6fgG4Gce0JkWbIib+PeQpNtqn0jBRD2SKAM/NNPMgRul9pljrKqX1g+44dYiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyPawvPd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DA606A334
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E0DA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyPawvPd
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso413471866b.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793012359; cv=none;
        d=google.com; s=arc-20260327;
        b=JVfNwdDRIsYmZUWGIxkcR3aXV3rQVeXp8cvG/UrE09lqQ9ONRTsMjegbfn12DmJ17v
         0iq/YFnnE9JQ7wyH9DIF08WLh2zpmlW5wodzSFGza2Y5MBOMY4j3o/zQK0VlZQAF92Fv
         cA++a5AnX8VtDefGfH7yHU0Qr+u2QUK46nPhn8BILf7SvRAwhPP1iFRFUHXI4HevNoj/
         Phk4G2N1GHn7PiliTr3l+GBjbWXRxr14AlSGREiKw0ueiaA3VEh8Ugf51myL7yhZPNX8
         +4/cwZfe6B10R9Xyuo6CCOFM+7EHt9yCX+2xQ1HNwy6xt0PK57Eoj6v412q+H0FnoRUI
         iD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AGezTdH/BGVGTlUMmaGBhI8YtAvNj4R/9yrQQ0+maDQ=;
        fh=hYpjQaZspRCY0txBz07J9rkgXQt3YHeMx5CUX639CBQ=;
        b=YrqWRdelvbJ4b5kW8L4ELRQUFMc/TrjukUcSyW8dWBBNTTVwscTmU4QqcnB/CA0/KK
         PkAjPb8a2HVXlDh1R43pSVohE2DyN8eE8NhlewsZx/eINM/0ZiNxFfbxF3AFhMjWM3Vo
         1UoQPnaRUywClWlw/CqNXr5VYI7lKNRa/Yr/IMdpA2rKj63tr2t/RbsWBMPKBOHDMH83
         ZEAI9wbsJuiEx0bdGPwY1uUd90IQrUoUKYyZPOkwjcIksGKFAq5fpY5NJJs9Bh9G3W1f
         I3mPHp/FrrcH1aLbMlZzyGT7wLR8oq8c5uVSPiCWQ/WYN0vvMM1aCcGXZ11RLz8ZpUef
         AeUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012359; x=1793617159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AGezTdH/BGVGTlUMmaGBhI8YtAvNj4R/9yrQQ0+maDQ=;
        b=DyPawvPdLZA+/2VQT40qcS75p1VuyCgyKbNWWe1/i4Jnn6zhdb7Z5sGIcVCCBtzdve
         wY+MWGwTyiwmh1jMbTXm/hMxmssgBPKY80B+fg+N4kMxRsexoLJTWfqZAgmVmtoKDIZN
         Tbb54fm41IwBUFBGvf0lX5jW4Ji5On0stoi33OFpy9+4mLy9ONwueNlz5I0b6o4vXjr6
         9lTvlwvI3nXk+I7s8tC/G+umy7MC91YkNkJ4WunVziJq4nd80XNkWjBGEIV6u+EX4wpO
         VIdqIHIV40AlLQTZ8v+rmxT4JWsuL8tU9RrZ/vfE1jo7UsTkJEuFDmvaFcQGR6rl888e
         jK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012359; x=1793617159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGezTdH/BGVGTlUMmaGBhI8YtAvNj4R/9yrQQ0+maDQ=;
        b=HQN2+1ZK4NUx+DOD5br+A45Mu04klQW/w9JDiugftWYxP4jSzVpZCFNiyqGKmlV+iD
         DCSJbn5SinI8inf89godl7dgr2vmCrWmAYl5TrcDHRoWtcRAcu/HY47rLp644/1kXi6e
         gE3/4LQORrqRsUpcX9st8NRSlaiyBEwLhAm3t9XZZgv3/Nh2sMOnYQDPeqhnAwZS7g71
         c3OxXNAB9MuclfYDohXcI8E7Y0zngw93og6rEq7DtcKJ7rPyNXyipPVZr3LRf099GePJ
         JPrYwXLr7mQKslA5JotGx83Gn8BKs/oANR1ntgomzL0ApCGUC3O+83YuMapYhyLQiT7X
         ouBQ==
X-Forwarded-Encrypted: i=1; AKwUvByZiFLuyBXKQEmvW3sz6sfyxvDEMW/gmVCdgsPVA1a3+QuOUyp1fJEzzVCDnsYSe+PFVYqIe/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeLGIdd5ZbYVEweQjgk9RvCjGBJdVLUq5KEleAuwjm6eyleg+s
	1TypKSmwAtIZFNaOtX5/YJ67bXgbIf9CGpKfBSgg6Srriw4YKPrXPvYnO1+8YTzRd5vZhR0NpBE
	9c9QQNDhCOUZrsEyxKw9ZshSdttMNFFI=
X-Gm-Gg: AYBFou3i7VaOm3ARoWw2kBQTVe4AChIuCPw0xJFSfR2pMSBYb4b73Q7cObTRSttx6gB
	gIaGqi6iyRqDaLt3updnKlTGU9U4I+IJqjMaAljwkM1lU8ubQ0tdUmJNZSDreG49FGG1dbqisYS
	XdiU9WykRf+VH9gnM8ZrLRbbb7sQUrTSXhg/01FdRVazeOZws++ZQwHAZSFffMUphn92BmCYWAl
	Ji+JFW4s7XJ3AgDr4qK+x5xuf4g32lEUt/AbrNWHWuJANvtn/jLem9SoGacb0ENyxly3nNBk8bZ
	4zG9iqKVyhXsRo52ENMGP9Y5zL84EMHYPtqd1hH4IHB706ipQlc8ubmQYfP2E2JpPQjpAZeRI0i
	wj+1Q9Hx3SSAALbZes/NXSgMVCXokTtjIeMFSejmnkO9B2zS9Cur0e1tg5yYnMlC7Lkqni9o=
X-Received: by 2002:a17:906:794e:b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c46bde7eadamr829450366b.34.1793012358782; Mon, 26 Oct 2026
 03:59:18 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com> <asjE_UdsewYa4kjz@alaakso-desk>
In-Reply-To: <asjE_UdsewYa4kjz@alaakso-desk>
From: Praveen Puglia <praveenpuglia@gmail.com>
Date: Mon, 26 Oct 2026 16:29:07 +0530
X-Gm-Features: AclHuK9VDEMKyVEvJ3-kD0nYb3I9skZQwkqBvSZv2CuCDHv1Z2D4dG5lwnZqJg4
Message-ID: <CANfatsqw=XxmJvbCPxD9T-=FBwd_h-e4KaEf+Mz5dgtGoK+pRw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: cvs: Leave the privacy LED to firmware on
 Synaptics SVP7xxx
To: Antti Laakso <antti.laakso@linux.intel.com>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mehdi Djait <mehdi.djait@linux.intel.com>, 
	Marco Nenciarini <mnencia@kcore.it>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

Gentle ping on this one. It has Tested-by tags from Marco and Antti,
and no review comments so far.

Anything you'd like me to change?


On Fri, 9 Oct 2026 at 16:12, Antti Laakso <antti.laakso@linux.intel.com> wr=
ote:
>
> On Thu, Oct 08, 2026 at 08:39:37PM +0530, Praveen Puglia via B4 Relay wro=
te:
> > From: Praveen Puglia <praveenpuglia@gmail.com>
> >
> > The Synaptics SVP7xxx (06cb:0701) quirk sets ICVS_HOST_PRIV_CTRL, so
> > SET_DEV_HOST_ID tells the CVS firmware that the host owns the privacy
> > LED. Nothing in the driver drives it, though: V4L2_CID_PRIVACY is a
> > read-only placeholder. The firmware then never turns the LED on and the
> > camera streams with the LED off.
> >
> > The host has no way to drive it on these machines either. On the Dell
> > Pro Max 16 Premium (MA16250) the only camera LED that INT3472 exposes
> > is the IR flood LED. The out-of-tree Intel vision driver sends
> > privacy_led_host =3D 0 for this bridge, and the LED works there.
> >
> > Drop ICVS_HOST_PRIV_CTRL from the quirk (quirks 0x7a -> 0x3a). The LED
> > now turns on while streaming and the stream is unaffected.
> >
> > Tested on a Dell Pro Max 16 Premium (MA16250) with v7.2.8.
> >
> > Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vis=
ion Sensing Controller(CVS)")
> > Cc: stable@vger.kernel.org
> > Link: https://github.com/intel/ipu6-drivers/issues/417
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Praveen Puglia <praveenpuglia@gmail.com>
> > ---
> > This is my first kernel patch. I found and debugged this with an AI
> > assistant (Claude), then verified it myself on the laptop: quirks read
> > 0x3a, the LED turns on and off with streaming, and the stream is
> > unchanged. Tested as a rebuilt module on Fedora's v7.2.8, not on
> > v7.3-rc.
> >
> > Marco Nenciarini reproduced this on the same laptop with Debian and
> > v7.2.6, and found no host-controlled privacy LED pin in the DSDT/SSDTs:
> > https://github.com/intel/ipu6-drivers/issues/417#issuecomment-599673834=
6
> > ---
> >  drivers/media/i2c/cvs/core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.=
c
> > index d4a3b9c3ba..3520325717 100644
> > --- a/drivers/media/i2c/cvs/core.c
> > +++ b/drivers/media/i2c/cvs/core.c
> > @@ -72,7 +72,6 @@ static const struct icvs_device_quirk cvs_quirk_table=
[] =3D {
> >       },      /* Lattice NX33 */
> >       { 0x06CB, 0x0701, ICVS_SKIP_FW_RESET |
> >                         ICVS_HOST_SENSOR_PWR_CTRL |
> > -                       ICVS_HOST_PRIV_CTRL |
> >                         ICVS_FW_BUF_SIZE_256 |
> >                         ICVS_FW_HEADER_SIZE_256
> >       },      /* Synaptics SVP7xxx */
> >
> > ---
> > base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
> > change-id: 20261008-cvs-privacy-led-7d0f2327c31f
> >
> > Best regards,
> > --
> > Praveen Puglia <praveenpuglia@gmail.com>
> >
>
> Tested-by: Antti Laakso <antti.laakso@linux.intel.com>



--=20
Cheers!
Praveen =E2=97=89 praveenpuglia.com =E2=97=89 @praveenpuglia
