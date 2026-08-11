Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534542652A2
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451542; cv=pass; b=Wiu1iVUqRHcKgNH2ejJwfRBA5MFLb2RhEOAsv1mVPlVcNhWVZOJUwbYaAJH/ZmB+bk5IYDUD1uORrD4MmM1+VZWEcoRrPXK5/bEX1ORDEq3rR7htxvlS6pW4N+nUrQ4ZlJENGpN+9gmOztZ98gvRrxdLnPhADKd2NKDLUiHu21k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451542; c=relaxed/simple;
	bh=qdl0GsQeNVi2RVf/6cQbI0QgrQm5I5gflgFpZKzDYEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyCq0daOyPJwsliZPVRf3Ifgl7Rk2tgPgPSY6nAFZG3vFDIhh75D7cYPOHaEkNXpwZlep5MxrXsQOgvtR0NXxo6JLQazM7PYRjIHBqLIgPSDhiJ95X28SYO8uTgqOEGvGMMxV0XMjpAInzpoCTq9pSCMxlk/Y+4nmXuyKefYCRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tek3bJd0; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tek3bJd0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a18af264f9so602612a12.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 05:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786451539; cv=none;
        d=google.com; s=arc-20260327;
        b=YvHYpivWtG3uikB7gI1n6EIJYDhtEXB3MmrVRXHmfQHpWv5TLbPA9l3TDjj4R1HzMW
         bQg3Ja1EpehT2EeOvNtq8Nns6/ONrhFbz6rMRAUQlenrTzF1IM+N9VYav8M6B/SD6Zsm
         89BtQeVGmVaVozMN4PJBIrP6O5rp7jAY111NdQpMkeMzSRtGAIEOfcmhh9sti05339DC
         WPVVQzpRmhSd8h7SBPAsnmYYtsEqS86FN+uhTUJH1AXPzHGtRXq34DgrHPWVG7E//TSY
         P+3DLV6onfdgDs4HfAXd8nXrH4mo+qtLp6w9ztUkGK7I8YcqOH6iEEjNchfJ9h6J+e04
         fVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ny5M4i1pCdXNjkKDgAcVF5xrGkifNBxPo2Yc8QJbVVY=;
        fh=nI2hHScxdwVQsrwSdTaJ616mHKJzcAb3YBYZYpzkE6g=;
        b=WRRHEW5Ik959dxAhbzg0jQYLPjj3m8oX/UK8mYoAwf0agcas/R7nV3Zpcp//OKcLMB
         qoIfeW4q2qWvFgDL1fEFuvCOSvD3fQUTYSOAaE43TSXWcixxboEFSpv278srfoaPN0aM
         z5FTELheeCs6+s9vJVz/60fS5RFVB3XOVVWyH2RtfPwxa+0ZlN6uXID/sPEey1/1GcA/
         lknNn7lS3mH1PUGZejXPtTM5LVvke1uNSgvRJfovCzaoIpBrOC+N0CTaWj0wTnna0i/o
         bYiJFKEnqxzCXxw1lZCBwzHlGuA+8K4UCCncATzyuI5AMrAWbaY2gpTkzmR6oHsdwVLn
         EWIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786451539; x=1787056339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ny5M4i1pCdXNjkKDgAcVF5xrGkifNBxPo2Yc8QJbVVY=;
        b=Tek3bJd0qaZXSwcKUu/fwMgo+l9jOiDaB7WrxerVLHdpcKi1mVKjdDwu4nr8L7k/fy
         1gcgRHTHCmUc8L61PatGaG5N4Qfb1cYd3XS1kBDVKRmOyl+xk0YvBlF3XHZ2wc65p+2S
         zQA8yA4J+C8W5bh6Eq9ll6aHIrNetgP/Y6ui6UXnd0by8qFEOdNU8Nf047VOzlwT1y21
         y6R7U5JPmfy+7n54gpvZ0NpOrRb5adx94lZj26zCE4KYpsYZ0H89JwDu2qbevSOogSVi
         BkeVYLHurByjuxEj1P82pzVbneRVQ5szIOz9bWurRWw78cZC1a3ZoBheOsE2Tsk/eOBI
         ddDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786451539; x=1787056339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ny5M4i1pCdXNjkKDgAcVF5xrGkifNBxPo2Yc8QJbVVY=;
        b=RF11ge3ABpnSw+y6AMa4AoByqt4ghK3skJLozYYv0FTDBdPdbZqz1L2iTbNCBwJVbs
         8YO/MbveftPf5ZNB3BrqxAGkG1iiWbHLlS6N2X4IVVI0Pvc08TQD+hwhptJeENaJjdmC
         +XQ96pVLJKDRy0wnScr3Eo0RXOz/01KAT/wMYpA29+zJsODMIbkamViAEu34gMZcPIBX
         PhUl678JjP3T37kER6j1SKQbYu6id/0ZmVc8mF891Ds4xQfp/miKWb9TWoIc6kEdrM4X
         NqM9bZhBwNXUTIHndcafvTEcYvtbJvBxbYBkqZX55bTQ6hTfuVdGPjIVVBpTOhY/1Me0
         Idtw==
X-Forwarded-Encrypted: i=1; AHgh+RrSMQPYPxlVrorp0R+cT9DxAyFzrzuyGdjtlY0zWEJYw6v5IH1TI+CF4sJUlqWXBbY7H+KljGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChFwROYfoa7k1FfmLffDxQbC5xBrtIexGf37V4Cg5wsAkuyjS
	tjsKXC9fWPvO6VGsbVWxIp8fl2T9X3K+axNU7hFQ/Q5cL82MMmMcAxYMXef50uxnStv+Fg+0uvm
	cyYrR8x8SBMfBLlpn0BfLnGXbNMtA3bg=
X-Gm-Gg: AR+sD12vOH7KvRxEJWTeTFQm23YS6QrWq45yoNdG3FXjQIeoHdndTAXGoQ66xJ4cAIf
	waicPLF3MCB24DjeQcQjSX5Dp12Q8iTCjNre50pRB/+Giurd8+RFUCOSdkfY+wxN0dTYOT2Ya18
	UVwb7bPzv02LxdFfIMIA+Meb4ofBr6LaWhdMQuw5KgrF9LGzkKQrlgkzBT+I9Q/+0iqR/XyU3ak
	gZ6VMPT0OcAXQFG5Kv6lG36ANG2szdsITefHl6RHbCozdQi3JcbfCOEUMcUAGRoBeQXTQEvjgvi
	oFW/jKn2hpoE/hxK+A10ysY0xKG1y3SOlry3FIB1MEJi6/hg5TEBqk8fld5M/lh4BKyk4738ZYE
	K8w==
X-Received: by 2002:a05:6402:2488:b0:6a1:faeb:c519 with SMTP id
 4fb4d7f45d1cf-6a364512797mr945524a12.3.1786451538427; Tue, 11 Aug 2026
 05:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ov5640-1lane-v1-v4-1-c4a05d4c1b32@gmail.com> <b70b5fac-a39c-443c-bb9c-6f45d9826ad5@oss.qualcomm.com>
In-Reply-To: <b70b5fac-a39c-443c-bb9c-6f45d9826ad5@oss.qualcomm.com>
From: =?UTF-8?B?5qWK5pm65oiQ?= <jason98166@gmail.com>
Date: Tue, 11 Aug 2026 20:32:05 +0800
X-Gm-Features: AUfX_myVr9CGZ8fR6zVhcy5AI7QSa50CcXQMmyLdftOb3LhVRja-6uSJy57QHgk
Message-ID: <CAPwA33LtG6UQUXbR8pVO4G4poy9WrbGvoym7VUdH6OrVLJs+9Q@mail.gmail.com>
Subject: Re: [PATCH v4] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
To: johannes.goede@oss.qualcomm.com
Cc: Steve Longerbeam <slongerbeam@gmail.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Sorry about the name mix-up. I'll make sure to credit this to Hans de

Goede in the next version.

> Sorry that I missed this previously, but should this not also

> write the correct lane-count right away, rather then waiting

> with fixing the line-count for 1 lane configs till we hit

> ov5640_set_stream_mipi() ?

I intentionally kept the fix to the streaming path. The value written

during power-up is overwritten when streaming starts, before any frames

are produced, so it should not affect the actual stream. I also wanted

to keep the Fixes: patch as minimal as possible to make backporting

easier.

Would you prefer me to extend the patch to program the correct lane

count during power-up as well?

Regards,

Jason


<johannes.goede@oss.qualcomm.com> =E6=96=BC 2026=E5=B9=B48=E6=9C=8811=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 11-Aug-26 11:17, Jason Yang via B4 Relay wrote:
> > From: Jason Yang <jason98166@gmail.com>
> >
> > ov5640_set_stream_mipi() always programs IO_MIPI_CTRL00 with 0x45,
> > which selects the two data lane mode: the number of data lanes
> > described in the devicetree endpoint only feeds the sensor's clock
> > tree computations, so a module wired with one data lane starts
> > streaming in two lane mode and the receiver never assembles a
> > frame.
> >
> > Take the lane mode from the endpoint instead. The field encodes
> > the lane count directly - 001 for one lane, 010 for two - per the
> > current sensor manual (version 2.33). The 2.03 manual documented
> > 000/001 for one/two lanes; OmniVision corrected the table in
> > version 2.1, which is why the long-standing comment here found 001
> > unusable for two lanes and validated 010 instead.
> >
> > The power-up path also programs a two data lane mode, but that
> > value is overwritten when streaming starts, so it is left alone.
> >
> > Tested with a single data lane module on an i.MX8MP board
> > (imx-mipi-csis receiver), where the unpatched value produces no
> > frames at all, and on an RK3588 board.
> >
> > Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Yang <jason98166@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > ---
> > Changes in v4:
> > - Keep the lane count programmed also while the interface is
> >   disabled, toggling only the enable bits (Hans Verkuil); with one
> >   data lane the disable value becomes 0x20 instead of 0x40.
> > - Link to v3: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v3-1-a=
e476eaf5024@gmail.com
> >
> > Changes in v3:
> > - Inline the lane count in the write instead of going through a
> >   local variable (Sakari Ailus).
> > - Link to v2: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v2-1-6=
5205ae86feb@gmail.com
> >
> > Changes in v2:
> > - Compute the register value from the lane count in the single
> >   write instead of branching on it (Sakari Ailus), with the count
> >   in a local variable to stay within 80 columns; the programmed
> >   values are unchanged, 0x25 for one lane and 0x45 for two.
> > - Request a normal stable backport rather than opting out of
> >   AUTOSEL (Sakari Ailus).
> > - Drop the quotes around the function name in the reference from
> >   ov5640_set_power_mipi() (Sakari Ailus).
> > - Link to v1: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v1-1-7=
9699457ce13@gmail.com
> > ---
> >  drivers/media/i2c/ov5640.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index 8deb5f5501fa..a99e4edb6a75 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -1831,22 +1831,16 @@ static int ov5640_set_stream_mipi(struct ov5640=
_dev *sensor, bool on)
> >       /*
> >        * Enable/disable the MIPI interface
> >        *
> > -      * 0x300e =3D on ? 0x45 : 0x40
> > -      *
> > -      * FIXME: the sensor manual (version 2.03) reports
> > -      * [7:5] =3D 000  : 1 data lane mode
> > -      * [7:5] =3D 001  : 2 data lanes mode
> > -      * But this settings do not work, while the following ones
> > -      * have been validated for 2 data lanes mode.
> > -      *
> > -      * [7:5] =3D 010  : 2 data lanes mode
> > +      * [7:5]        : data lane count, 001 for one lane and 010 for t=
wo,
> > +      *                per version 2.33 of the sensor manual
> >        * [4] =3D 0      : Power up MIPI HS Tx
> >        * [3] =3D 0      : Power up MIPI LS Rx
> >        * [2] =3D 1/0    : MIPI interface enable/disable
> >        * [1:0] =3D 01/00: FIXME: 'debug'
> >        */
> >       ret =3D ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
> > -                            on ? 0x45 : 0x40);
> > +                            sensor->ep.bus.mipi_csi2.num_data_lanes <<=
 5 |
> > +                            (on ? 0x05 : 0x0));
> >       if (ret)
> >               return ret;
> >
> > @@ -2535,8 +2529,8 @@ static int ov5640_set_power_mipi(struct ov5640_de=
v *sensor, bool on)
> >        * Power up MIPI HS Tx and LS Rx; 2 data lanes mode
> >        *
> >        * 0x300e =3D 0x40
> > -      * [7:5] =3D 010  : 2 data lanes mode (see FIXME note in
> > -      *                "ov5640_set_stream_mipi()")
> > +      * [7:5] =3D 010  : 2 data lanes mode (see the note in
> > +      *                ov5640_set_stream_mipi())
> >        * [4] =3D 0      : Power up MIPI HS Tx
> >        * [3] =3D 0      : Power up MIPI LS Rx
> >        * [2] =3D 1      : MIPI interface enabled
>
> Sorry that I missed this previously, but should this not also
> write the correct lane-count right away, rather then waiting
> with fixing the line-count for 1 lane configs till we hit
> ov5640_set_stream_mipi() ?
>
> Regards,
>
> Hans
>
>
