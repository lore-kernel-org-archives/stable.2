Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235E30FC26
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784495694; cv=none; b=gEGePcSQutul8oDg4Q3iO1UpZFM3m68wWZWz1j6UYMdZzyYVfWDj3GdhDYF/Kg0UsPBV4W3BKIxDFYMXGRzNnCNKGYoeT9drxuXl30hXUAo5HtoVqNa7bKW+zMqlT0rigldpjgD1jUGaqfPao2qa1h2Vx5EBEk/yvdEXosvFcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784495694; c=relaxed/simple;
	bh=U9HvmCvpRC0PdwshPiDg79v4iyuivDBJ/X8yCQTdP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br4Gv/N0ZdR7HFO7t5Hc0wGomz0CRYZ4OKMrpftSN0O7nlp3ziphFk4wFXCe+uJuA2AMRcV4uJi48irUY8vT7yyUcsZ8Ux0VF1YCqjNGK/2f5RupuIKYgYpbhJtwSv2V7UiAI0ef+WHoupNJcOdS7leKDi0ce41u25MXjEKNILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qjv0Wcr9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+t/qPuM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qjv0Wcr9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+t/qPuM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKRKnL236922
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 21:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=; b=Qjv0Wcr9e/ofF0/G
	5/mXsAOTZmv5MlHp/tWlEgPtErd/wIxyaOC8+pIkToOQ0ebrbpqmpDLORbR/ZGCx
	QMTt7NUps9DF/K7hPajZIRIfPTAo0EHwhviU4IsJXhqQgA7WngmwlSKoIxM2UlK4
	grqyGc/gPhfNgEOtQIoOsN0a1GkGj5pxGesUxczj+vB5B/AQzG02OPjpKDMwg+d3
	c0W9UMvVlNzXDKesFpqV8b26kx1wPPIq/GHtUQjJiH2dQlFPbWYhayFl6XshjViA
	PNZRAwrwHQqJ6FB080c/Xzc7D+Q3yFbIlnXVSONLrPt6Xl/S2Eifi9cfVOy7yAo7
	o5plbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chkejv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 21:14:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so14331897a12.3
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784495691; x=1785100491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=;
        b=f+t/qPuMFNCHuXvOE+7Jt940nfKpJvLvoYQ5fL7arNZbPwZ5dg4bHvDftu/rQyoZHJ
         adypZkLMYj4XvaW4ffSRP7IWwS3SJ0gq9B0GBOrCug3FnzpLPzCJfUdPfWGeiAchVev/
         m82rEkKAjuZbOeSjusL6PHYvkpBDmW6cKNyD+o2Zdu7Bgk/AheaAQf8d8YhxQXfygieV
         ZXB5K2wIDYk09aVzGU7sGBVfXDWmNbfPv2NEtxBlDByNNILoel/IBSoZI9fyhJUT8m7a
         /coGNddDnGamGA0PjWo5xCpYDZyvgCg/8+n+no/+qdJrkUDUortSprd3mFg/+SaO9CAj
         IDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784495691; x=1785100491;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=;
        b=pF779OCQ1vy3SoMkwfE7AlT5uCADjRRa5J/60wWuuA+t4g6IWq3HC2gzPk0yyEezF+
         Ailvz0Wsuwn9FBI9vg9TXG/NjEcJbkVCpZA6lzfkOy0S9i9OfEPy2YhzJgbSnCyFDJhC
         TJZ+Cw3LpTsutSZ5bbXfCABurekFmqQwMt90VUf3OXGWCF36451vbD02bHsRzAobTwKY
         sCCHB7KonWigpHdwkkPdRmbYdk7Z9gZv072euKwcC7VjSYPBhlglopx4cexlhVPJTh9L
         0Erxq1IUqXrPavbpPMVjNNxKjDapwebP0oOMjf4FI6X6SUDGtJmRXxVpcCCg7yG4lEQB
         WGAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcPxauZafQrRE4MCGlApPFTTZ3vnt9iylIcnLqdQGW6kDqLi3fD/VOtU+TCDrbpOJHW4O4Lz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSj85E4rE/qDoGylPB+ut7fbq6j92WArzdrsqWy+mODqb7Tu5
	+HENFgZ+6cB6JPuWQ1X2BSW/s7dBzFhPZzhnpqSiJVwEiui1bwaRIrANdPCI3MVtAgYjCWXjSX8
	kziRR6ukos1BHybPhgeG7oYIt/UopFJDtKZJtlNt8xF/105ZHUDCj88u2aso=
X-Gm-Gg: AfdE7cme+M6Da5/rA1b2pAEAGWGxz+CRti52QiSYI6ovy2yJi58imrM5AFwS0GoKDq2
	qJu0QOH2Gn3pnJpbX2IqCTB+QQUBnoPzqCLA/JP4ZPt3TMEJWJ9JFbPQ9fyYam6NkJA+AL1AoZm
	9os8GpUYgDAIQ1i4TRNgNNzEbDDsg25+yc6H7iBa0oCzElRc8lriYTMEg/xqh1eZQwfu2c/nnGj
	RLwox2q0EV1E7upkzOmyaOJ0CEzzgQPiq6AETJqg3rVL3YVsCUUMv4V08XyM7LNo9OrzBsX7k2o
	koTiSSQ2xGse9zlad7o/6I6mpl3ghuYi66GIUkezHGLMpc2KNgTKo4ZZFCs9s9SPrUINsWyfMdB
	/f5DL7K88X/iuz1sc
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c3ad66b702mr14057729637.21.1784495690667;
        Sun, 19 Jul 2026 14:14:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c3ad66b702mr14057709637.21.1784495690247;
        Sun, 19 Jul 2026 14:14:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb51a2c1b0dsm3440525a12.30.2026.07.19.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:14:49 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:14:46 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rupert Zoone <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Kai-Heng Feng
 <kai.heng.feng@canonical.com>,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on
 ACPI probe
Message-ID: <20260719221343.2a797351@jic23-huawei>
In-Reply-To: <CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
References: <20260719000752.75936-1-zoone.rupert@gmail.com>
	<alyTjkq2bCuTE3OO@ashevche-desk.local>
	<CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDIzNyBTYWx0ZWRfX8+bLE1W0D00H
 ufneWKvZR97hnyo+q5+Uj0oEzK2oAudDSippbVDGQHCrgqo/QTXGHAllQUHpY12MlCLFQCmsbMK
 OI6iF+edL1QjW5P74ih/RQoMcrWxBNQ=
X-Proofpoint-GUID: q3jSl2nJ9JYCpVidoI7NxHj0VICWGOTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDIzNyBTYWx0ZWRfX8HK8lGyL3GqP
 dcF8fD/wON0VKGOcDC+9vsIq2R87PSMgWCTK2J1RyvBKzd3Sv0umS5RBrGrX1cavNYyL+8BpbTN
 IkQPBAMEWD0xpbCb3kzBvCYqA2wpxhO75Qk7+STjKKRE6eFfbGm5XZDJutWPAsemNRpL8XFE46C
 Wk9VRq1yAgw76tm5PcDe39MbMNAixG0I/99JsJk3I0g3u2lsfQCkyALhyDYC7w5c3iutUVZmUr1
 XjhRHbx5t6DDtifqNObCJ2PCoUWrK3mA9951Aa1gJBufewJVvtAiLDFk/8SB78PFvm1btfRxX72
 SNE60mrJUtGPVmb9opnw75b0BrXE4w5f0iKbQNuY9ziMn58XGJs7ZccGuQotz8oL4VWhPBGJKFh
 8ruGitZxND88E3/4Rm1ASwF3nRNBPaLf6PARb9qRrl/28nBa8yra14Qyx9bMPiLuaAoIqVfwP7Y
 xw8hvmczZOVXjQ7w8+Q==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d3e4b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Qx8pq7cJZwYMmCun04IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: q3jSl2nJ9JYCpVidoI7NxHj0VICWGOTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190237

On Sun, 19 Jul 2026 15:16:02 +0300
Rupert Zoone <zoone.rupert@gmail.com> wrote:

>   On Sun, Jul 19, 2026 at 12:06 PM +0300, Andy Shevchenko wrote:
>   > As a quick fix this patch is okay, the proper one is to go with chip_=
info
>   > structure in the driver_data. where the name will be defined. =20

For this particular driver I'd not do that as it only supports one device.
Can leave bringing a chip_info structure in until someone sends support for
a second one.

>=20
>   Thanks for the review. I'd like to keep this one as the minimal fix so =
it
>   backports cleanly (it's Cc: stable). The chip_info/driver_data rework i=
s a
>   good idea, but I'll do it as follow-up on top rather than fold it into =
the
>   stable fix.
>=20
>   > On top of that mutex_init() should be devm_mutex_init(), which is a f=
ix,
>   > and some cleanups:
>   > - unused i2c_set_clientdata(); may be dropped
>   > - C99 initialisers in ACPI ID table
>   > - IWYU principle for the header inclusions
>   > - some unneeded GENMASK()s due to use of sign_extend32()
>   > - perhaps converting to use get_unaligned_xx() where it makes sense
>   > - use time multipliers in _read_poll_timeout()
>   > - use fsleep() and time multipliers instead of usleep_range()
>   > - get rid of min_t(); perhaps replace with clamp() or min()
>   > - use SI multipliers from units.h =20
>=20
>   Agreed on all of these, including the devm_mutex_init() change. I'll se=
nd
>   them as a separate cleanup series once this fix and the triggered-buffer
>   patch are in, so each change stays easy to review on its own.
Excellent.  I've applied this one to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
>   Thanks,
>   Rupesh
>=20
> On Sun, Jul 19, 2026 at 12:06=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Sun, Jul 19, 2026 at 03:07:52AM +0300, Rupesh Majhi wrote: =20
> > > When the device is enumerated through its ACPI HID (IFX3100),
> > > i2c_client_get_device_id() returns NULL: the ACPI-derived client name
> > > does not match the driver's i2c_device_id table. dps310_probe() then
> > > dereferences that NULL pointer in "iio->name =3D id->name" and crashe=
s the
> > > kernel during probe.
> > >
> > > The IIO device name is always "dps310", so set it directly and drop t=
he
> > > now-unused device-id lookup. =20
> >
> > ...
> >
> > As a quick fix this patch is okay, the proper one is to go with chip_in=
fo
> > structure in the driver_data. where the name will be defined.
> >
> > On top of that mutex_init() should be devm_mutex_init(), which is a fix,
> > and some cleanups:
> > - unused i2c_set_clientdata(); may be dropped
> > - C99 initialisers in ACPI ID table
> > - IWYU principle for the header inclusions
> > - some unneeded GENMASK()s due to use of sign_extend32()
> > - perhaps converting to use get_unaligned_xx() where it makes sense
> > - use time multipliers in _read_poll_timeout()
> > - use fsleep() and time multipliers instead of usleep_range()
> > - get rid of min_t(); perhaps replace with clamp() or min()
> > - use SI multipliers from units.h
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

