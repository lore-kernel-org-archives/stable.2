Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A2C1594
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810301; cv=none; b=tRbLZFgCgf/qJ1p1jVYzzcvIbB+F5rAaMKzx4B+BX5k9tpiqlGLb0Bgm+W21lDcWsCRofBPW9ynwFkzRdxzNHCJ7Wqc8pONvcAPCCjilFa3iXA6kk7+wYTJpXHYtEw1NjP4H/2rYmrczP0lZVMx7g4ioIKIgyUa8wYBzgfh2u6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810301; c=relaxed/simple;
	bh=ZTp2cUUkkT21/rpxRKLxJRm5cuRD3FvaDw6wOAPKY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfGQrz3FGoVnpS/feYF3c6/a5Ccu49nZuIy3Fj/GWLeGXNOH94Wrb5m20ktUoPJRGNAcrMo/wwThJVC5P5ZzgcuzsAGGmFQAd2aXh1GDxoFpJf52yEX8urW6L+y1P6+bn8Cgl8IbHcnpdpVnSgM0oibi6V3BxXxfn82Q7ld1YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhrPGq/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kqabrFUg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fhrPGq/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqabrFUg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BKx2hO666331
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 22:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3oThxMyizgDkEn3KJey6UQ6i6siohpG1Fw7YPZTbPA=; b=fhrPGq/LHGRtI0cd
	Y9wQgX2hnhDCQsgGHFuExqaBn34VtcxlVXUcQZwdVteBder4S23GqJIOaV5cVZTs
	p0uwIUGI2XJUvYMndv8icTKx9vrMgMf6ymeA31/xpzm2Mych8Zp2C4E6FtKdqIwT
	JbzifziEvdDI9i8dj3ZLUNFKlZsnxpyC7/3jMXUaA+L5gmDywp7vOEvNEq7KaHro
	4AiXwrGyo+Lcn/WMRLT4timR3Qn8lq/pZxj9dSf8MUsRHeYdRsJvKMgK6VKzZJiK
	f4kyjDAjyQo6Bi5e9X+9GD3MXanp195/927Sp8h7m5b2MamOCViLPbYPRbP0RTAn
	bvqCzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamss01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 22:51:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacd6d37edso28182815ad.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783810297; x=1784415097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L3oThxMyizgDkEn3KJey6UQ6i6siohpG1Fw7YPZTbPA=;
        b=kqabrFUgMuZ0eK+S2tCtRO09bQfTqB2As6NZP5oNr6V4/H9kgPARMIUWCLMgELtZRX
         Uh8kf6/VWaCG/Rw66twkX12bjFkZ31IkyBW72XO0LHYKswJl8jGUUPLhdPO7dTp6zEaq
         5icExhk0oeHR1foVyjMP1cuUXfk1oanr415v21ge6nv6O1JdWGevuWTzz97/mPmcHy78
         fLtYkmgTgEaITqbVFzlACszXWfg1P5OoYbiCY966/njLzCmVMv1fLLZSqWSUFJ9NX+b+
         eOxFngqhnbtX0686wyqqAuFOK2NDZKrC8VYrSU0VD+UsJyoHrvLVdH7mBctQpcdOiA0g
         GC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783810297; x=1784415097;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3oThxMyizgDkEn3KJey6UQ6i6siohpG1Fw7YPZTbPA=;
        b=rjd6bRH/cagZISOyF9RBLV+hVIeaILd5xGzyc+Aajff3FCy7kWthCQBzOnJIXnnyLV
         RPuP0Yr1ncKIgC+3tA0sIERAKAGcD/igJD9A9azRyUND25EW3LLGAynqdN43mkcP3I73
         Oe1Dzdpn5yyTkhuUS0GusbalLNNH7ViRtb+tOaaSUg0NS51MGUmIEyvIjNxPK0NrXS5b
         ltrPBA/6uIdEZaguJ8wCox/iU+IK5B8EecFcT+L8V6WJacH6ZaGMX1wU++3lNKd60UHO
         jLwYtFTBMNk5VsaYKR9IPd6PCABk9stEfz2zzctKtwJWUL2rfO8nTyUR7NiqRKxWjCLZ
         v8Gw==
X-Forwarded-Encrypted: i=1; AHgh+RovAe1+WT2z9tcPGHtx4o4bxHsR+M8q0NV8egRROLQQjkAph3FKRUu8Jgo4qG7JcuUOBUo6AhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV1nZbH9/NsBjGLT5CyXuUkbichELzdGVVkidO0LRIq0TUIXm
	k5ZCgE5nsaWojXIrpTIgoJVeLz1eDNtM2Ar11sy+CbwDDGY7t1xiajpn4uLli2WFO/CT+JH0N/3
	l2C/MOjTzTMxMGeKQqOW8y9NgS5u5DopHX5Qq1VZ+srzBkjnyj8xL0AXj1ng=
X-Gm-Gg: AfdE7cnI3BAg/y0WY4GSmE68dmgAH17IiFeXpjI5zdADkRepvYZA9oWf2Vsn7FRtrOt
	t91lUgjGblu0ehU16DXN6eHB3uzkekWiMM6mLT+J4jQMSDH4JFiMXjh9LT2ycFbTb+2vXjxGhtd
	Q9eRvp8YQGRRD9XLfyfSM7wSfKwDkB1J4ky/LyO+/IyyCFvqRY8xN/JbX67WzCYqod2h6lZsU78
	wSIJ73xyoCEeGCizKqUkojVIuv5m8dCtqEQqa4fTdo8D6rM7VtduFWZC77GFyg0KNTwd9RUznWS
	5UD8AQEE/Vd0c+mOnNfXTSqfArDO8JAPYEvQ/CzsEN47CCg/OMG1Pp23w0wJUwyIJkqr83pGQ/0
	3N7WoRgtO0AfLq6JdO/h3zynqIFg=
X-Received: by 2002:a17:903:3c0c:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2ce9f39973bmr40429315ad.44.1783810297123;
        Sat, 11 Jul 2026 15:51:37 -0700 (PDT)
X-Received: by 2002:a17:903:3c0c:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2ce9f39973bmr40429195ad.44.1783810296625;
        Sat, 11 Jul 2026 15:51:36 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e33sm76365505ad.74.2026.07.11.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:51:36 -0700 (PDT)
Date: Sat, 11 Jul 2026 23:51:32 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Message-ID: <20260711235132.1568bd75@jic23-huawei>
In-Reply-To: <BE1P281MB1426AC573E4DFA75DE2D522FCEF12@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
	<20260703200224.69d60475@jic23-huawei>
	<BE1P281MB1426AC573E4DFA75DE2D522FCEF12@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDIzMyBTYWx0ZWRfX+g6/zg45ht9h
 RwQRbZKh49BrpfA1chZe16H8dN+2e30eNV6hiZ/Pr/0v+rOvMeCV+t6f/anKlAiIer8AMhAVirP
 L8nPHMq+MUk4ezJG/bNflfH6Kn8c9sE=
X-Proofpoint-GUID: 3g_axelRTivapKXk308duaDNNyySvFL4
X-Proofpoint-ORIG-GUID: 3g_axelRTivapKXk308duaDNNyySvFL4
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a52c8fa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=tpoKPDdqsMjE0q__xjQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDIzMyBTYWx0ZWRfX9Z4hKnPuE3mX
 wK9C80tbDZgqSM427HZcLPaMw9NL4ppQgkKw1+WXPDcvDN/UG+CCR90hsFNbLcPzKyJmK6Y8y1A
 zHfudETO/y3nAno5lP1wpYvhzGdZYzxOmhtDjYrbPoAR/wFQN8UEgWv1evvWq6tIFpVPKdtSDL9
 DQjMIx3q4wrq5vZxz7RaOvTrWCrxhFS0fDpWX9v3QGAlyZj41lcjx5ZlyC04nkUWnux3Yc1ByDM
 s2bE+RF58STfZLpFEU6kUhGYYvmgEh9X9wxcqkAO97WtAXuQVaUblNlajcMnpoaD5idJBcoApqS
 g/397N15Cx9xanXgjZFOAG/+fcVf3E9PAeNpfPKeO58ImwomSnndx/yO77TlyFlg/f3v2/9ZL2d
 OdppIQCsynGXQab+UP/dJ5MzsQu2ZNd19dDMWxUyUAa9CFjpZGAkBGy6RNKJrKiNva8vLZt1vr5
 TQEjamT4VGGD5vocVQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110233

On Mon, 6 Jul 2026 08:00:43 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >From: Jonathan Cameron <jic23@kernel.org>
> >Sent: Friday, July 3, 2026 21:02
> >To: Jean-Baptiste Maneyrol via B4 Relay
> >Cc: Jean-Baptiste Maneyrol; David Lechner; Nuno S=C3=A1; Andy Shevchenko=
; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kern=
el.org
> >Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period =
by using lower value
> >
> >On Tue, 23 Jun 2026 16:=E2=80=8A22:=E2=80=8A15 +0200 Jean-Baptiste Maney=
rol via B4 Relay <devnull+jean-baptiste.=E2=80=8Amaneyrol.=E2=80=8Atdk.=E2=
=80=8Acom@=E2=80=8Akernel.=E2=80=8Aorg> wrote: > From: Jean-Baptiste Maneyr=
ol <jean-baptiste.=E2=80=8Amaneyrol@=E2=80=8Atdk.=E2=80=8Acom> > Sorry for =
delay - I'm finally
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >
> >ZjQcmQRYFpfptBannerEnd
> >
> >On Tue, 23 Jun 2026 16:22:15 +0200
> >Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.=
com@kernel.org> wrote:
> > =20
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >> =20
> >Sorry for delay - I'm finally getting back on top of my emails (for IIO =
anyway!)
> > =20
> >> Clock period value is used for computing periods of sampling. There is
> >> no need for it to be higher than the maximum odr, otherwise we are
> >> losing precision in the computation for nothing. =20
> >
> >Silly question - what are the user visible results of that precision los=
s?
> >
> >Less accurate time stamp estimates, or something else?
> >
> >Jonathan
> > =20
> Hello Jonathan,
>=20
> that's not a silly question, it will effectively lead to less accurate ti=
mestamps.
>=20
> We are measuring the delta time between 2 interrupts, and for abstracting=
 the ODR
> we divide this measurement to go to the configured clock period. Then we =
compute timestamps by multiplying back this measured clock period. If we di=
vide
> too much, we are losing precision. Since maximum ODR is 8kHz, there is no
> need to go further than this value. Internal chip clock is 32kHz, but max=
imum
> ODR is 8kHz.
>=20
Seems I applied this and forgot to say so.  Anyhow, now upstream.

Jonathan

> Thanks,
> JB
>=20
> > =20
> >>
> >> Switch clock period value to maximum odr period (8kHz).
> >>
> >> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
 =20
> >
> > =20
> >> ---
> >>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 4 ++--
> >>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_accel.c
> >> index 532d5fdffaf8..7df920ef3cf0 100644
> >> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> >> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> >> @@ -1170,10 +1170,10 @@ struct iio_dev *inv_icm42600_accel_init(struct=
 inv_icm42600_state *st)
> >>       accel_st->filter =3D INV_ICM42600_FILTER_AVG_16X;
> >>
> >>       /*
> >> -      * clock period is 32kHz (31250ns)
> >> +      * clock period is 8kHz (125000ns)
> >>        * jitter is +/- 2% (20 per mille)
> >>        */
> >> -     ts_chip.clock_period =3D 31250;
> >> +     ts_chip.clock_period =3D 125000;
> >>       ts_chip.jitter =3D 20;
> >>       ts_chip.init_period =3D inv_icm42600_odr_to_period(st->conf.acce=
l.odr);
> >>       inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
> >> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> >> index 11339ddf1da3..a18dcac93929 100644
> >> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> >> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> >> @@ -755,10 +755,10 @@ struct iio_dev *inv_icm42600_gyro_init(struct in=
v_icm42600_state *st)
> >>       }
> >>
> >>       /*
> >> -      * clock period is 32kHz (31250ns)
> >> +      * clock period is 8kHz (125000ns)
> >>        * jitter is +/- 2% (20 per mille)
> >>        */
> >> -     ts_chip.clock_period =3D 31250;
> >> +     ts_chip.clock_period =3D 125000;
> >>       ts_chip.jitter =3D 20;
> >>       ts_chip.init_period =3D inv_icm42600_odr_to_period(st->conf.acce=
l.odr);
> >>       inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
> >>
> >> ---
> >> base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
> >> change-id: 20260623-inv-icm42600-fix-timestamp-clock-period-931338a848=
c3
> >>
> >> Best regards,
> >> --
> >> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>
> > =20

