Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794156297;
	b=Xo36Sfx2CGzyJQ6HGOyZwmVVqin4s0bU7rEW46PfwOQPDFrJjT7aoJTDRtC0aX/63AWi
	 8E0X/T1ooGDgArR/DCZBRHLnLKc1PRPclHQtORagep/SDj/6xgTNLmF29BbTf8SPaNfSD
	 PTQkdXeJtJF3E0qsa1sS/f63DwfG8xLVb2p/W3b3J2pJj3/gNjGxKbi3nk5FG5u27WR/P
	 xltrXSRioM51q2SSpgW+XxHO7VXDwEeeBYLNuHycjuSCRWMhpA3hEahyMHE3pFNlzREYB
	 9QLMXbmFhFwfj6Td4ZIyme8450UxSrbmR+SbYaQ7lrsBZdfWaPOLCeTdEfGowv9b3mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VSdOXir0KqgstOa90Y7/+TFLedl+ex/hx3CBpVcVcnk=;
	b=uwX1nEvqvK/UPZ7MS4cFh4oNruv8wAKNXCXeiEyDWRaZDiVEIk4+y4BrimbPR6Vfxe7t
	 A722OJmxvFPEPaU0Npkwq+m4FV3yDDKz8mbm/GZB9bxv/GsQXeCza5KzPlHyXDleQJdin
	 De52uJubH2ZV2qs3iRlKRmc4OVohi/ehzUhbLrIhLPjoRmQu46Zf3ER6UikuPV/EwRHlz
	 I8vPAPy0tzHA+hh09jepi5KoXn/aRYzPO6bOa2sIjD7Al8RDwFYuLi0NoQy+BbmsxRreQ
	 gSsLaJbyMBORUftdU6ZXlNKBxFA/plPp9w4cGd7yv2f1+CLxbXKoaO4OzLdWXThJzww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGVc3mTx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A60606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A60606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGVc3mTx
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so349219eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794156296; cv=none;
        d=google.com; s=arc-20260327;
        b=etBnBcd52+WznrAeWL3TA6ja1pCFGTxUNkup68LUS4Yom0b6arWH/PvW4F1V5F4lXY
         U3rdBwsNwQAWpu11rAgis3SP6dQDPoSMlY3bc3i1Aok/USrnGWdu8rc590kqZcpY2Ol1
         yi3YHKVqFY2M5cmJ7A5SKgN7ns9uD1w9FS/Q1sZVnAlsxE1fcunoA3l1ggn4pXHu04U7
         lrYa1YZYjYpy9MTrxtaPTsdGk5HzVLm1ifAUfPmNNb1XI4dIDwBGZvLOCg+PrCo/mmiK
         b/UEgFydI1jgJOfvztPab2/brFVqSLIawluky2bG88q4tCFzmMD2Rurlahr6Otz/y9rl
         AciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSdOXir0KqgstOa90Y7/+TFLedl+ex/hx3CBpVcVcnk=;
        fh=FeIHSEO2gLeBnkttrV/mQsAA3CIaWdYb0GkRgf4CC5I=;
        b=nZObMMfa4f/5yii48Lssan3RW7BVJBJLQNZZK+EKx1aq9PhrtpvuJJqbOZfUIGzIlo
         S2Q1/BQWNuBVZA22nYAm/segD2+LSfIG6+jzZhziNkqzGPb3whAjgV+3Dc0a0vQNt6R+
         9hNVZhquYhvsjFx6pt9JQrqsYs9Xkx2xetSxTkksxAzLBFVpqoWMbBEpHFFWERa3e43R
         by5BqnrKCZ/imz0gVPW69nBwIaggOnI6BKIm0lpt+r587AyVknbKqgLAI76PXlfDqu+q
         BzPeUpiGBLZZfHQ4f2jmpnze/KqzC1l1ynSudG3GpqUDhlm/th/ipIie4c96i/FUw/V+
         Zj9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794156296; x=1794761096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSdOXir0KqgstOa90Y7/+TFLedl+ex/hx3CBpVcVcnk=;
        b=dGVc3mTxzs5TaHTrjDBddOEhDnFHztDcNjd73h4P55tQ63wPMiESkNoB9Lde3OzaV7
         iUAOVUlFh1sfIJ+qrGFrYhwQghANfLjzIySMTWAeE9pSGBdnHcsCiibMDBufFLZEWOvp
         jW2F4JFkvCply8e246LWG0adkARKQPvY+8ppfwSC8YJBGqAO9p8FYkvaK1yQhnidXc/0
         O22ewF6CvQzzCCVoViTM6fbwkoeJzylYTlxrlNgSYXQ3/sMn6a02UZuV5SP+WIVLorxq
         dxVuA2f6lbJXMTpX1tfVmL/XjQ4Qx2IvHPYQXH/mP47X/5mKLrm4srzDVF/TOTUE42nm
         vrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794156296; x=1794761096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSdOXir0KqgstOa90Y7/+TFLedl+ex/hx3CBpVcVcnk=;
        b=afg6BpQy0RQFXZ9yvpdAoJ/KsHsn88o/+HkTsekF5dAUFc7bhQc1TpCtyuIDIQ0z96
         i3eEis8/+UOSZwEDVf6Nt3iVERbFvHWqMTFU9LiQlUGwADbLGcdabIrARzT+G0TsfMkK
         vGE4Gs0RTX+6iFB6QWMzsBSr6jVKqZjZdEvIMvKQC9MuGeiwc7vlsEhboSz9864HLc0i
         zTWCR7KP0415F02nHk+sd0+FMxX60RxzK2KZeu6dkLPl/a2sG0IdmoLIvON4HqoPC9V7
         3ZWGj9DtWnnHVVBwMvIG20RiQDfdKJklQFhCLMMZ5s2cvO5qY20PLMeNP+yhBpEwhy9l
         InjQ==
X-Forwarded-Encrypted: i=1; AL+hErGxaoYKey99r+8U3mvWPUzn11bAPYgcKVUSOCkxJptuWrjHErMjdkR5yX3DkLM/147Ma2Z7ndg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t7woTcXQHXGTJh9bYeBKE7wI6LsJjvvIhSdgzdrzSSYEaB2jL
	97G924ofBt6Lqio0aqXAZw2DupeG3Cr/vxl6RjXo3ydHbXSNIOApsI5GUMXy2fpql+CSLpUHSPH
	NMqAT/QyGdjXgx6q3QW1L+gb3HjPlSF0=
X-Gm-Gg: AYBFou3CkG+bDJ7jLoujiNn5lrpZ7+X3N+vRGTtcfGLseL/hA3PqsPb1xRF1dQHgwol
	giCtJZVMLRBKHFVs4jZtQdq9yIzaDBg12xmNac2StkrkUcYQsYXCxaqlCfZzpNsZK7pRShH+VZ6
	SpGbQbthOmc6bga/YS34tbupAOwrTAA39JJzUQzVSyUh61080gHHEd5D/yM42TaVkoHVGcKb1Af
	5TUuPJF3I73sqgovy1r5V513aNJ5ZqVqf+rAi9vk6frOTTJ8oq5Z1MGUPxxsf/1LoqmYOZXRwiW
	hQN1wzSv3cscVzTyZ6UP1Nf0EPJA4W4ERFYZdVdBHiB92VeNSfiYmLm/trThvj6ojNRDBQgrqEg
	r3h2+KiQtE7KGfhypkneZad77Kb4e2VPw+KPwWllBh/siNf5XyyCtV++6thglwOU4/P8iPm0/D1
	fzYGm3m/RNOMK2Muk+rlB5DiV+Eck=
X-Received: by 2002:a05:7301:da8b:b0:36e:a321:5353 with SMTP id
 5a478bee46e88-372543bbbf7mr4144537eec.2.1794156295714; Sun, 08 Nov 2026
 08:44:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-redrat3-input-uaf-v1-1-b882e43d9803@gmail.com> <avCBzjIenoErsXhh@extorris.mess.org>
In-Reply-To: <avCBzjIenoErsXhh@extorris.mess.org>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Sun, 8 Nov 2026 13:44:44 -0300
X-Gm-Features: AclHuK9OUQ0JURmPmwyzwr6q9AbQnZBaFuj_eL060l-9qRbVh720idxJ-TbkSgw
Message-ID: <CAOCBhwFruAbWMWsDomwdO13xD9oQwtLsfmCEqtJfwEqedadGBA@mail.gmail.com>
Subject: Re: [PATCH] media: rc: redrat3: fix use-after-free of input device
 name/phys strings
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

You're right, I apologize for the incorrect analysis.

rc_unregister_device() calls input_unregister_device() before
redrat3_delete() frees the struct, so EVIOCGNAME cannot reach
the freed name/phys strings via the disconnect path.

Thank you for pointing to af452b9e01331b =E2=80=94 I should have checked
the probe error path more carefully.

Regards,
Joas


Em dom., 8 de nov. de 2026 =C3=A0s 11:06, Sean Young <sean@mess.org> escrev=
eu:
>
> On Wed, Nov 04, 2026 at 09:03:01PM +0000, Joas Antonio dos Santos via B4 =
Relay wrote:
> > From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> >
> > redrat3_init_rc_dev() sets rc->device_name and rc->input_phys to point
> > at the name[] and phys[] arrays embedded in struct redrat3_dev.
> > rc_prepare_rx_device() then copies these pointers into input_dev->name
> > and input_dev->phys without duplicating the strings.
> >
> > When redrat3_dev_disconnect() runs, it calls redrat3_delete() which
> > kfrees the redrat3_dev struct, freeing the embedded name and phys
> > arrays.  If an evdev client still holds the input device open, a
> > subsequent EVIOCGNAME or EVIOCGPHYS ioctl calls str_to_user() which
> > reads the freed string via strlen(), triggering a KASAN
> > slab-use-after-free on the freed kmalloc-2k object.
>
> This is nonsense. rc_unregister_device() calls input_unregister_device()
> so EVIOCGNAME will not work any more.
>
> My guess this syzbot issue is resolved by commit
> af452b9e01331b5338a1e5141624f17607239207 and this is the error path in pr=
obe,
> not disconnect..
>
>
> Sean
>
> >
> > Fix by allocating the name and phys strings with devm_kasprintf() and
> > devm_kzalloc() respectively, tied to the USB interface device lifetime.
> > This ensures the strings outlive the input device, since the USB
> > interface device (and its devres) is not released until all references
> > to it are dropped.
> >
> > Found by LLM-assisted code review of syzbot-reported crash patterns.
> >
> > Reported-by: syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Daec1962419768c5caf88
> > Fixes: 2154be651bfd ("[media] redrat3: new driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> > ---
> > redrat3_init_rc_dev() stores pointers to the name[] and phys[] arrays
> > embedded in struct redrat3_dev into rc->device_name and rc->input_phys.
> > These are copied into input_dev->name/phys without duplication.
> >
> > When the device disconnects, kfree(rr3) frees the strings while evdev
> > may still hold the input device open.  A subsequent EVIOCGNAME ioctl
> > dereferences the freed string via str_to_user() -> strlen(), triggering
> > a KASAN slab-use-after-free.
> >
> > syzbot link: https://syzkaller.appspot.com/bug?extid=3Daec1962419768c5c=
af88
> > ---
> >  drivers/media/rc/redrat3.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
> > index 3e82b5e66..d9e37ede2 100644
> > --- a/drivers/media/rc/redrat3.c
> > +++ b/drivers/media/rc/redrat3.c
> > @@ -229,8 +229,8 @@ struct redrat3_dev {
> >
> >       u32 carrier;
> >
> > -     char name[64];
> > -     char phys[64];
> > +     char *name;
> > +     char *phys;
> >  };
> >
> >  static void redrat3_dump_fw_error(struct redrat3_dev *rr3, int code)
> > @@ -943,11 +943,16 @@ static struct rc_dev *redrat3_init_rc_dev(struct =
redrat3_dev *rr3)
> >       if (!rc)
> >               return NULL;
> >
> > -     snprintf(rr3->name, sizeof(rr3->name),
> > -              "RedRat3%s Infrared Remote Transceiver",
> > -              prod =3D=3D USB_RR3IIUSB_PRODUCT_ID ? "-II" : "");
> > +     rr3->name =3D devm_kasprintf(rr3->dev, GFP_KERNEL,
> > +                                "RedRat3%s Infrared Remote Transceiver=
",
> > +                                prod =3D=3D USB_RR3IIUSB_PRODUCT_ID ? =
"-II" : "");
> > +     if (!rr3->name)
> > +             goto out;
> >
> > -     usb_make_path(rr3->udev, rr3->phys, sizeof(rr3->phys));
> > +     rr3->phys =3D devm_kzalloc(rr3->dev, 64, GFP_KERNEL);
> > +     if (!rr3->phys)
> > +             goto out;
> > +     usb_make_path(rr3->udev, rr3->phys, 64);
> >
> >       rc->device_name =3D rr3->name;
> >       rc->input_phys =3D rr3->phys;
> >
> > ---
> > base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> > change-id: 20261104-redrat3-input-uaf-b6d3789e63c9
> >
> > Best regards,
> > --
> > Joas Antonio dos Santos <joasantonio108@gmail.com>
> >
> >



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
