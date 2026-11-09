Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225008;
	b=cqxHCRuVdmsPq09cTGm24xVxxt8BPw2Ga1G09OFqhTIR0tbFBhxXuEvBPdNnHXpXYQik
	 RS52lfCG84sc136aCuFvBGCnI8ENZ3vrpNUzz/AlNnKRRsiYyXaRzUL6w/OtKYKPc6QKK
	 /Fv5E4EpLetJPisdUTh5RvWMWXFrF1Wd/btAPzlie8YJd59LShaf+DDGUUFx1fivKyB1v
	 6xgGeGMpEjskHWZWgn7Gn+1muHSlIAhzy6TKILTFEvIeX61AWoXMgMNlmVDGmNfH1umUb
	 nCnF3FPSPQtqOajzA2DbiclOJAUlGO7DqsaWxjYDQ579ZPc8ap+n1sDG3nG4jgIzbgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u0TI0VRhkkEuzSSXfjCVwhEWLOzK7uV4x4syO3ophfI=;
	b=Jlbc1SHEIX6d+akWQ53snfoIWH7RHf/FLP4qgPdyDLuAMqVjOujYYaSi361CzGiFi/gi
	 hOQCuLuMrCkq+nKnpNQI9tdlExOA0F9orGM4wYwnsyUcTEDSBRHbDYnFcVCPWuOAEoEl6
	 cfgwCxFws7r3yMZcAXiH3vuirWu4gn2Vc/5Ii0Ocjek9QLeuld5D8f03qqZ7V2sAyc70q
	 +LOjnPY7qNtQ94BGmvGYr8EEsbil59h+PsuIV+SkjZzuoWhjIQcvJMozJrc2aIgp8glA0
	 YUtBSSrz9CtI7WkWn9F6DPqsFZTOA4r13GxioaP7AZqrPeb2Xzv2kUUXwQHDzBRRbYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zW/EhxmY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F135606D80E
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F135606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zW/EhxmY
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so1749041eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794225006; cv=none;
        d=google.com; s=arc-20260327;
        b=RvA5+zxeKMSI8UWNYtetnfJ9L/0R4p5tOoknAaa8FpwfibMYI5xH0uChhDCXEXM6wt
         EbHhqA2GnFpiLRUsE/qxbomtLpRuLzyuO+Al8Nmfz83x7+OFP8oeKoIjmpgukKAikhTZ
         Kb9lz3wD7ZjQc0FofK8RBWpsZo6mdNWSp+RYWIrrbkHSKkKeNXr/UI0JDwrvi7Pu9F+d
         rR7eWTwcjdK2TxcagAwnaYLOYX1lNdU3SSvhfBcfpqaehx02eyHyN6RcLpJX2L9OVbJ5
         JieyosYxG1oij7lc0NZ6UcNIMzroJkoAZ/bH3/rF7lp0Md3FkwEKnj86hbhWBcY1H2Gc
         z7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0TI0VRhkkEuzSSXfjCVwhEWLOzK7uV4x4syO3ophfI=;
        fh=iIZTJOd+Z7BJq6jrDU6f8VkUZreMUsugT6QRSc+AP0g=;
        b=dmGrDfUrXO1FX0wFMUerYvfkEfNf3XPouTHK930UxuNFJSiUf76vDgiJOcHyKcFsVN
         qf3C9ziEx8F1QeJiAN8J2WNX1zB4C+Lz1G8HeF/jDERCSAMblK+Un2b8Tp5XsNt3XTpB
         6ReWuunNSzIGW4O13/V8mkuSfCCpvyOOEUqN9gr1peOlK6IqWS5Jyk/mYVT+PMCQ9h4g
         4rawYsOEqdWqTiabvP+cg3TNQPzpbHzSwS8kkJ3F+k/7qs60L45A6mw9ydX21Zo01xBd
         M+nHuz9pDn44K3bIbXzNC7d8hSHb4207nXv8rmnDOfYXSWOp7uLJMhJ06kLTIQYGrFpa
         POng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794225006; x=1794829806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0TI0VRhkkEuzSSXfjCVwhEWLOzK7uV4x4syO3ophfI=;
        b=zW/EhxmYBy/BH6jzgIF4YiDgBBl9udT8iHk9JOMG7UZUecSr8e48+v/LACrv4tmjsQ
         /5EywIHSkdJRWDUDQ98DAZOwkeVv4v52yltTq/WYZWH5K4kQgEMvr7Mn/MEuJpZidd0R
         5mLFGVSepeI/fsd5S22nLYbZSXWLyIGkdcbcsici3dWHXs1K3cSQ4xiMMSeQrLCyTl0/
         eXswSKEkOxQ/dAf9Bj6AL4QIhjdbItOEc/ez4DTHRy+Ed8H3mX0BhWHFlkJw6sTJ6VAQ
         y6jpIxM14f+1Mbo24GNnPLb+jqElocrtQOdMkEEtiwGVYbJtc7u+qmWqQoNKZ53+hVdX
         JItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225006; x=1794829806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0TI0VRhkkEuzSSXfjCVwhEWLOzK7uV4x4syO3ophfI=;
        b=buXnAEo90+2w93ehNgYpemYYtBgV7GPtcr1Mnqw8wi7wIAjrGPVPmdF/Uon4qDKi8e
         XuFLcld9dG8MFdxxJXCNFRqXnhvYkr6eleGi3A2T9StT7xdcEKmf5wlBDovcnKMUCY1g
         EVk4ppNVpxN0Tja2OujMLrEUjFuWOksEQl7oRKphicc09GJ/vX8mI8wu8tlOAMB56cJJ
         LWQ+Swx+fxDIeWIgUMwOFnx261OxN2u8QYCUSLSsaC3gbjbqttdHq7THAhsxo/yo9I/t
         3+9Stm4XvQLoQG0rDzixSwQVX36gKkRjni2eikgMf0sW22qgn+avYlhm3iuslt3e4z69
         vyRw==
X-Forwarded-Encrypted: i=1; AL+hErEoqiiBn5+PpZGjzIb812Y862QbXVYws5E504mZRw89/bUxXcuViLMwPiqNcKYQCFtkx4R6VvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RCJOSlL4YeDRwGLuA3ipMdN0XnD6B+Fmtuq5Z8pPYo9XA5sbs
	uXipvd3wb5iU1/+BZTIl95SgLrjBJjpEis/L3UkeHBzKYhKXbTKZSdq52eocIx+RgV2V3r5afol
	lX8KQteAwWF8ltS6Nl4yBUWVJ304hh2g=
X-Gm-Gg: AYBFou1tjv7qlwGCtuWIzaAL4GGm2AJP1QGbvmS0VRyihKgO2Y244LUMLSjeW1mNbQ0
	eotDgfu8W7UsesJnX/DeJZWU9WlZOxw6ggujlMcOA6A2WJM8JP5z4wVQlIZWiWG+e27rAUIS1te
	mW1UtiKdvJaAdD1ZlxLNV9DSfmkIDQ24EF5XkeU3B50Jvk/HzaHTIGNsug/0QQb83f9N+tQffhj
	CFNsI75Jcp5WzLjDppGqvotFRR7tX0BACmrnVRkCtcirgzt+ZFwWmX8qr34+m5p7ubkJiTH5s9Z
	QzAWda6qEtpr+FHhZYL0BhykpsepWSXntRVFE8jzbommcHqoi1m50iTqZDesdtofQrmVo8ZGvEp
	xKT0dJunq4wK+NtHaFjMkcxnqj5H46Xb8iX8NQcUlPA/O3aHx5C6LAWsV/6194DCr53g0
X-Received: by 2002:a05:7301:d809:10b0:36e:9773:84b9 with SMTP id
 5a478bee46e88-37256df029cmr6649578eec.23.1794225005998; Mon, 09 Nov 2026
 03:50:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109113121.1534929-1-hj351016@gmail.com> <TY3PR01MB113466938179F6797D7406F0B86732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113466938179F6797D7406F0B86732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 20:49:53 +0900
X-Gm-Features: AclHuK-Q7RAQrlbltV2_yA6asy4NURVFS_s2TMwZElMAGdCfnMAGwiTLjN8f_BU
Message-ID: <CAGr5VtOoyaNcLbBeZwA1gb08c1_qfvpVvWC07iEHjp5GnWFZEg@mail.gmail.com>
Subject: Re: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to
 avoid use-after-free
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Biju,

 Thanks for the review :)

 devm_add_action_or_reset() runs the action once immediately if it
fails to register it, and then returns the error. So on failure
rcar_gen3_phy_usb2_cancel_work() is called right away, i.e.
cancel_work_sync(&channel->work).

 That is safe here: channel->work has already been INIT_WORK()'d on
the line above, and the IRQ that schedules it (rcar_gen3_phy_usb2_irq)
is only requested after this call succeeds, so at that point the work
has never been queued. cancel_work_sync() on an
initialised-but-never-queued work is a no-op -- it just returns false.
(Unlike a timer, a work_struct has no uninitialised-object check on
the cancel path once INIT_WORK() has run.)

 So both paths are fine: either devres registers the cancel and runs
it on unbind, or registration fails, the cancel runs once immediately
(a harmless no-op), and probe returns the error.

 Thanks,
 Hyunjung

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 8:45, B=
iju Das <biju.das.jz@bp.renesas.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi hyunjungg,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: hyunjungg <hj351016@gmail.com>
> > Sent: 09 November 2026 11:31
> > Subject: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to a=
void use-after-free
> >
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > The OTG role/VBUS interrupt (rcar_gen3_phy_usb2_irq) and the role sysfs=
 attribute schedule channel-
> > >work (rcar_gen3_phy_usb2_work), whose handler dereferences the channel=
 (ch->extcon). The channel is
> > devm-allocated, so it is freed at unbind, but nothing cancels channel->=
work:
> > rcar_gen3_phy_usb2_remove() only drops the role sysfs file. A work sche=
duled just before unbind can
> > run after the channel has been freed, a use-after-free.
> >
> > Cancel the work via devm, registered before the interrupt is requested =
so that on unbind devm frees
> > the interrupt first (no new work can be
> > scheduled) and then runs the cancel action before the channel is freed.
> >
> > Fixes: c14f8a4032ef ("phy: rcar-gen3-usb2: fix mutex_lock calling in in=
terrupt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> > ---
> > Changes in v2 (thanks to the Sashiko AI review):
> >  - correct the Fixes: tag to c14f8a4032ef, which introduced channel->wo=
rk
> >    and rcar_gen3_phy_usb2_work(), rather than 2b38543c8db1 which only a=
dded
> >    synchronous extcon handling
> >  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/ren=
esas/phy-rcar-gen3-usb2.c
> > index b5ba751..35e519a 100644
> > --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> > +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> > @@ -1171,6 +1171,13 @@ static int rcar_gen3_phy_usb2_vbus_regulator_reg=
ister(struct rcar_gen3_chan
> > *cha
> >       return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(cha=
nnel, enable);  }
> >
> > +static void rcar_gen3_phy_usb2_cancel_work(void *data) {
> > +     struct rcar_gen3_chan *channel =3D data;
> > +
> > +     cancel_work_sync(&channel->work);
> > +}
> > +
> >  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)  {
> >       struct device *dev =3D &pdev->dev;
> > @@ -1277,6 +1284,17 @@ static int rcar_gen3_phy_usb2_probe(struct platf=
orm_device *pdev)
> >               return irq;
> >       } else if (irq > 0) {
> >               INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
> > +             /*
> > +              * Registered before the IRQ so that, on unbind, devm fre=
es the
> > +              * IRQ first (no more work can be scheduled) and then can=
cels any
> > +              * work still pending before the channel is freed.
> > +              */
> > +             ret =3D devm_add_action_or_reset(dev,
> > +                                            rcar_gen3_phy_usb2_cancel_=
work,
> > +                                            channel);
> > +             if (ret < 0)
> > +                     return ret;
>
> I have a question,
>
> What happens if this return error? Is it ok to call
> cancel_work_sync() before scheduling it?
>
> Cheers,
> Biju
>
> > +
> >               ret =3D devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq=
,
> >                                      IRQF_SHARED, dev_name(dev), channe=
l);
> >               if (ret < 0)
> > --
> > 2.43.0
> >
>
