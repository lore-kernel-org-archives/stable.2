Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC2427A03
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439842; cv=pass; b=Cka5JPjzChql1QaWw2b/BAIz3/mU25e5wqMAppUdIu6BGDCOS7mClCuYgtFX/48vlQn1UZAMB4kuPmpNciUv+66v+XghZ83jbMsOIagdB1Qh2BIspOGAgBHeGtblmyAumlMBmDsI8VNIWfYfgwJK9Zu2T/ASELBs3pbgmVyor3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439842; c=relaxed/simple;
	bh=KpcqzEH1ePmPvfI72lRYO2R89XBPggH7Y6FsYa5Szgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NprGgm3RZh19GjoGIQA36/3UcGXkRl1y5lYS9CMihz1zXNc2Z4xZRHpel7leEIrW7KrBdit+d/W8H5qwm4l+WWs0TEdy2z+K2k5FH8PRTE+KlUdzr63hxIn8TuPkpFkuN/0L9leNYF85TXqyzh8SZnJBuN/J/H3gr65MCCo/2fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoMqf0I9; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoMqf0I9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69a1c7ce59dso506908a12.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786439839; cv=none;
        d=google.com; s=arc-20260327;
        b=HzmHwAZj5yOKdlFKgmaVfCJjIR21jJmuGoudQ/AUqtEFZUBoEouTe+/gKdIAnTwT3E
         o/QXvTzsB7pgvFc7/bEZWvw23axo7BLLzkk9AmeOrxlSoQpnDoo0n3EAquzn3BjkkhxG
         xTQdq7sAKP9X1nwILiE7ALNTVJnawA5O4+jBBClt4CvGd8UBegX/sH/l+cs8xqqeZVcE
         9HjdtCnS7Ijih4ROcKHcDD32h/IrBxvdRCoAFZA1b42HaYYWWS/8eKjv5U6MUna6Qtmx
         0yhEHa9zCP+hzAtrtpXwsdoALygFafHsSLv5LgfVzl3gDgrLQJLWgYWkGALh3its0Kj+
         MTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZSuQ7916Bf9+Y+2gxJN3rLoU22x89w0ikU47PZS+4I=;
        fh=N0d0Fx3gR1y+a46dOgwHf+9gt9CLviIaJEutLUjMpRw=;
        b=V43JnDeNDd5L9YOZ0ut1rHjdV3CB1H2UHtcgLaye0mgzH4zva9ljcst4tjMo9Qv9NB
         tYcXl02do/9/GPkFgxpOqkkXkTm7Wd4MJZz4SWk8N7Dsjn8UFuakibZu0F+FkDclNfJK
         94gCMvwUDZRlGkKWcyyRjODuiOHHAUmjMHMjz0Yh+JQydgpqLAcieY5pQqDXkct797OE
         JqyyHb28QnccwEL35Iv8h+OlJUdbONzw+EJtZuGxrf27aR817IVSyJXkBF8ibjCDmnex
         Lutx2jyfvglRy53zTusy5Apw+udK3oIn5yxWIDRLo5kkqzCzn6rHy47gVWiYB30oATcV
         5/fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439839; x=1787044639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZSuQ7916Bf9+Y+2gxJN3rLoU22x89w0ikU47PZS+4I=;
        b=VoMqf0I9Xd3T/MAol2jU17ncYvWKokfKYadQotnUa16IV2UV9vKpPpjfIndl8WOpWZ
         9WCvF9bG8wSGx7/5WbUzOD0I/cQy1Uq4Zl5ykzQGzecgavEGlRMS1ckyCFtwjENofGsK
         kRBhHnXAt906oho/fjrfknnDb065GmvG+1dCnYR6BY3jbTG54BkJL/aVhfr0j8+K5uwB
         W0Q8PSZiC945GuKE3nPwzRYN6fY6athktyMlpvNPXP3WLeaJTwLC3ujK/yDz/dnnJzpv
         sFSPSgfWjVx4YSv9Bx5y3wgVxfYIh/lqZDjIJp6m9z7ieTcfHB4XZ+kKnPLoR1THGrhG
         Yiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439839; x=1787044639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZSuQ7916Bf9+Y+2gxJN3rLoU22x89w0ikU47PZS+4I=;
        b=AVDW3RCag0BVFJ4fT4Xtot+nHUFNY2yvA8eCJVdWl/uar9sZKsFXBzaKhj3F7P3TKM
         07E+DHdRmCRtoE3u2/X761QjmKH6Zf5OBI1KZqakRr+9K+fyzpiuGQfIL8ieiFRQG4sL
         RCGN0czwiTZ8678L/Z2gW8Oiy+5g4Zq2We+a7XNKEO5YMISfYFTxld5DwG+KK7hiQ8fy
         vN+uRL7Yq1pJIJ/WKDp20BniwCeEdHLRTk0BFqOWqQgbxjzHjLQbV1CSEoylg2NxnF8f
         WtUe+fFzwO/tw9KZ6azIufmuwPbNv3XE+NybnRSpPL+Lz38fN1fWRslM10xbyvfyQwT2
         qwaA==
X-Forwarded-Encrypted: i=1; AHgh+RqMN3CoxvxwHHTa8gDTyMTmAbkaNl3PteScuvXqUBkqI7t+dp1rScF6F2tBWOoHQ4Pdb8L/hAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCSLn050prqSC3qwPKp/8NiY2X12LiGBhmbZKDwheruFfL0d1f
	g9kDGoXTGhlZx6CIR6jlEw9xRdZKd5CbrAZh5YwUQf4Z2egC8H2AxDWP/jx9E+jN44PKw+yigXD
	vWPtNA9YHqk0uULROCNhGJ6CkJnzlZLQ=
X-Gm-Gg: AR+sD11I3IGuWjoZ8U317QHDLHCa3QE3P1o6BtoSZSRIf3OKbH5oVtJ3wDteVyJILWq
	JBiODe3qSNFBmUdgCDtOEZ0lEFE2IboJI7F6KATDj8QAIztRh3xfI4DLxPYtsHUaPDngyOh4WXm
	3HtDjV+r4/nphzhwuCHYonpEFatBGDwsxS/fj7iLOcKnb2b7pk/MdjQBydUDHDnn529C+yjmdkD
	WMcl62EssdfKbFvoU5RApuZNbbCuvwAHVKtyhtEsvQTlW8aKRjqPFkBd1ysffn4Y33zKZybRcsJ
	NAXfbi6KIA1DKdAZv9hCOW9LZ26XwH6ri3KlfhDB0UI=
X-Received: by 2002:a05:6402:3507:b0:69c:794d:4866 with SMTP id
 4fb4d7f45d1cf-6a36451210amr549230a12.4.1786439838260; Tue, 11 Aug 2026
 02:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com> <cff4de4b-3a94-4a5d-acb9-726939a75791@oss.qualcomm.com>
In-Reply-To: <cff4de4b-3a94-4a5d-acb9-726939a75791@oss.qualcomm.com>
From: =?UTF-8?B?5qWK5pm65oiQ?= <jason98166@gmail.com>
Date: Tue, 11 Aug 2026 17:17:06 +0800
X-Gm-Features: AUfX_mwvAcly8I6-88t7WFFW5unFKbTgdsOtp3Ivfbg8asrINcSNy_rjnatdgIY
Message-ID: <CAPwA33KyHsKm2U40n-i=tnoYBcJJHBmSufBxNUKO8tDEP8VfUg@mail.gmail.com>
Subject: Re: [PATCH v3] media: ov5640: select the MIPI lane mode from the
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

Thanks for the review.

> Only changing the low nibble for on / off and always setting the correct
> lane count.

You're right, that is more consistent - applied exactly as you
wrote it in v4.

Regards,
Jason

<johannes.goede@oss.qualcomm.com> =E6=96=BC 2026=E5=B9=B48=E6=9C=8811=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:57=E5=AF=AB=E9=81=93=EF=BC=9A

>
> Hi,
>
> On 11-Aug-26 09:30, Jason Yang via B4 Relay wrote:
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
> > index 8deb5f5501fa..18c3bb5498f8 100644
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
> > +                            on ? 0x5 | sensor->ep.bus.mipi_csi2.num_da=
ta_lanes << 5 :
> > +                            0x40);
>
> You're writing 0x40 aka 2 lines now when turning the sensor off in 1 line=
 mode.
>
> I believe this should be:
>
>         ret =3D ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
>                                sensor->ep.bus.mipi_csi2.num_data_lanes <<=
 5 |
>                                (on ? 0x05 : 0x0));
>
> Only changing the low nibble for on / off and always setting the correct
> lane count.
>
> Regards,
>
> Hans
>
>
>
