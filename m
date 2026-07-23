Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297D46F488
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811026; cv=pass; b=HWGW/c2rrg6Imu+AevQEHhhF2zb771KXbixcD7xbmxEgznXUOcfbR7UVXEGn2h0z16zvz4y2OGnBzWB/vv++0ljXEgxo0w+zc0LGEHCMb9YOh8ML7HPs0V3d5Lby0MViP7oeDNI59QXgECIvfwrjIA6vIDy9J1/AqrKxMX0hhmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811026; c=relaxed/simple;
	bh=hlGGDYwymH6mg8D1WDX6uDKt7eM+j3/WsmB9hbKOAzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8TRBI6BnH18mfupkJ8/Ps6T00I28cZNeN5EnEXCVcnoBjKaAghkfypmQy8dYPJqsdXte22mZDrhoOP2IGkpYyCSFbO5Wgu505p521dA/XP31s2DqMZcoUz4apX81NcJ4o/XDbaDkyrR5Lni6vRgQwJRxuX9nprsQjCnMFpxgbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0U5Rj74; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V6bjz1R8; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0U5Rj74";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6bjz1R8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qaBf3668003
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8e7ZsseomCptKcwVNGi5wJcqARzu7xwaQuKtNwqprBw=; b=n0U5Rj74LXzfJUj1
	Hb1IpHD/zYmylCIzNjGhWRg+adyRcS5lKro0nlvbeYFhcGOXC3/RQJYKGEMvDnGa
	H4JaDgwXvBkMXZvODTXY8n2wejPhMff9X7BwBZOO+C043Nf7YXnkKEkuOdTXUzrW
	OdN9ho1r2GYPSDXvxwWeWGwH46gxktKPyotyad/Ww+DwK7Zvd/AmpR4G93USDpnq
	NvdUg3zd8eCNNxH4RMdMJiYlXkUivl896rFTpBu3Ep3AufzsshKHWWOfPv6tO6Cn
	upeLtXoO0Puy9XfkxfbgbOhYEqsPyEA1CajM9LnZ4c2gSXaqp0k02R8kCqaUfucw
	xTm/pg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc3955-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:50:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso18074076d6.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 05:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784811023; cv=none;
        d=google.com; s=arc-20260327;
        b=HMmk+Lc675bbtrlEGBluGAYKlehS7iV56+nOg6LYhqvtMoyqk28xu2uWkH734njsFK
         dtYd34F57bL8xW6FRbPYkZO8O77nj90WWxj4gxsw+1sNNuzOQWTrsgmlk3d8RlalAPIh
         CpBKgYs3DXUWDWmPE2w+HTCJWQuca01IzX9GYKLdNHQMQ9BRycNqqOOk/Oskp8+n2xas
         jfLve/bAfrErYVbXJA/VkT7pK+AU+3k64sqPevlB1pS192Y0oEFWAA0C9SRLnimAkSdT
         3ns8HQup+agLBUkZN6FC4y4sTVXhx8YQoUW4JBhtgMIiSzZuNGL3Ly0HNpqY508AbE/b
         Gucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8e7ZsseomCptKcwVNGi5wJcqARzu7xwaQuKtNwqprBw=;
        fh=64JNRqOfoupUXV4Mr9HV7/I1ROyHtug9P1zaljFb92E=;
        b=ZHFnIx0g4l4XVXawDGrkqKW9OxJ7dY0HXkpG6glnoezDRXLd/Pgjau4g+7rT51iB0h
         LZaaFjHk8Ez85xFqI+Uzo1a1/jM3gDUqq2Hcau2gb/VAtoy+bn53I2Tu3Orunw4Msr38
         7dVdcuWWjEf5/tAYSZ5Ymu30WPi5AViVDD2vvGN/J3OeBBYkAdYaQ73zFnMXQgEnucU7
         eTpNxoBrptzy/2VkWqNsMRgZ2qEOzIgYHpb3wnZr2GEXLZspESS0O71KPfy3IAgVvwR4
         KhKhrXxxuagQ/6gAt+Aap7r4adsyLG8T7tjHY3jGODlXZqPESd9hx9ib8oJyqZGy35CB
         2+hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784811023; x=1785415823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8e7ZsseomCptKcwVNGi5wJcqARzu7xwaQuKtNwqprBw=;
        b=V6bjz1R8+ILuMZ6/aDfB5kGvHOUjqMbFFDSLNjOtRqdTvJ8lBg/TEY6tqmjOOpmGqN
         uv+djoNw/c+nLT6s30t3GDh8SJbXKG8gux+JQjr76dENgs2R1UWpVVedtT1qOJ0sfbbp
         EfuhIV4bPJ8VT2xIzelMfcaSdzUriy1VznIjSRVvmemDuENBlPX5iMip78Cdw4i5iBra
         ebzpFQlbw3F5LqeEqiVlffoUcVgYgeODDcJb6WuBNpYY9bFmR8lTYfwKh0FmtFDhqtci
         sohVu41iRgbqJvK/mdEUQgr/wKWxmeQ3CBHZ3t233A1uC4/ALewlPPYl9AOCdhwcQgQJ
         5/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784811023; x=1785415823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e7ZsseomCptKcwVNGi5wJcqARzu7xwaQuKtNwqprBw=;
        b=TjQsnhN8BtBcHEmJhSGWKNDx6i4rThQbwholyUY0LB6GYddJLYSD+Q7H9xR/7yKDjF
         jLCY3bLl2RUMzl/iYpiuaaHvMtWvSVyrHJa9bq93tge5NTKlD6m9eIBCU7kuBSgxC8HP
         FxHkjRb5N69DDtWCiT+Z1UrZo3nsvMOX5fx+G7EantYzlWNWgH6u8QKyE5GFu1tTXtYd
         x/VGAlz0cgdkYi17JVJ00+EKWrzJsovIk87dTdchB3hvHRKfGqYnBRgq97NlS1v2mZ5Z
         ddxxp70SHoWj8nUY8B0O6T5QuZQg+Acfm9xwktAu6+raNhYX0PUYor3PoBcmKxdHSdna
         23TQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqQoF4n2PIxs77u46pO3NGz9m0wRgaLQfeQ3TAgIGNA7QK9D/GXxBb11ziyRNi0jR7lXgF4Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHPdMjvZ8s9PH8mp5KmfElaF7Jwg2dNsx1jvRky1k8Rz8MAKF
	ETRPmbcRRV0px3w9nFHQMBvHtFkBTJirARQDL7ODJjlJnGejzGYakBDtUzOrzYRI8L1vV09k0A6
	LD85NT4cK93A06HAYZAevJ4YyCEVJ1LZ4v72mICajPOzdj+IIgKFZOruDrLsphvH0JJ5xB1eMyc
	hyvLNHnhWpGLodMzeF7BIwHlvlzUBO6YNZ+A==
X-Gm-Gg: AR+sD10r3CcokdeyqF/7hj0bgRsqdVG34UjjMiSQ+rjVWOV3G9O0jVA9+HcCz7q40/Z
	x7qviCmD/jqu4O67p4KZu3iS4itc/W5BtW16HBvRLvOMdEBmyHfWHY3MRyqtEy0FH/C0GroQMDp
	JHsZ/nbnhaQ0fpz7KPeiNToG2yShp+cxn3UNZialWZfubSZtzI+18ewmaFfpZwR1vtXMijx5qIY
	+FulcIMfdNr6t6F0B00BheVkSrBX0ya3HoTnL4Rl6gLoH1inQqwm76NLvBNKSdShEWldWTRM9U=
X-Received: by 2002:a05:620a:4726:b0:930:f7ee:2cf5 with SMTP id af79cd13be357-93103b22fe2mr283339885a.66.1784811023431;
        Thu, 23 Jul 2026 05:50:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4726:b0:930:f7ee:2cf5 with SMTP id
 af79cd13be357-93103b22fe2mr283336185a.66.1784811022869; Thu, 23 Jul 2026
 05:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 14:50:11 +0200
X-Gm-Features: AUfX_mwF21VL9ibLPXKd6XDb1LktyT-nN-Sq53-IY29arpzrGXEA5oSTVWM1quc
Message-ID: <CAFEp6-2KX+iVPNaTHHRC+QYvn7b7iowPtd3ysgpKFhEdaY9AfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] media: qcom: camss: Add "gcc_axi_hf" to 8775p VFE
 lite clock lists
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: enzdo6DEKpVstTowUkb3o4X4JMoiwKqE
X-Proofpoint-GUID: enzdo6DEKpVstTowUkb3o4X4JMoiwKqE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNiBTYWx0ZWRfX0fLi6QyiyHQs
 npUGCV4U3zb0Qjk4AH/+jdj5+DeXH5MCjwlO5g7wSQlcNIUTj6KHRGrydEj1paVjC2zCSnHuR4Q
 1pMyU390Avbx802qfvvu0I2vVgzB0JQ=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a620e10 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=idSoneugJW-k1LHGf6cA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNiBTYWx0ZWRfXx8flTVc0odSd
 EHkObsJLQoXmwQZ2hQF3pb9W9UeWaB0GNZ3g9zBI3m6lbxqyOCz/6k9e1rX5RFfAG6scJoyjHge
 s8uwP1Lkcm4X2uCEQelP+HKXxjNeV7rYBgmrYvSglKo2M2AZLvyhWSfuQR3F2PP94DGeVBIxc18
 FCLTy0WrpbZVcWazWVGRqls36N3gOMogZ0WHGGnVQWfdSddqWK/xkj1DEavDto4cPgR7BhNVGyp
 FSxd/V8jVHMVdt1Xi4t3QkcgUGHJ29YVbLj93rx50usCTlecXMZQ/FSixXyDgUhdZ+mM5SwA1iM
 6Z7l601pNwd92qMSkKMq58keFFBAcrmDdQ6W8r3toRP9FuPemnzhi2xfPOPOOV8usofLpEPGAGZ
 lqnF0UJ9NyIbUlI4qkIvKcLfRqR3n82QxnKwd0C9RP05DSxcQ+vpmQHM8kQWWTY2AU6T87SiX9Z
 s9UCbFMDJ6N2uHYjwDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230126

On Thu, Jul 23, 2026 at 1:09=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> The "gcc_axi_hf" clock is correctly listed in the clock list of the
> 8775p 2 main VFE-s, but it is missing from all the VFE-lite clock lists,
> causing these to not work on platforms where the firmware allows turning
> off "gcc_axi_hf".
>
> Add the missing "gcc_axi_hf" to fix the VFE-lite blocks not working on
> these platforms.
>
> Fixes: 924f45e58b1fe ("media: qcom: camss: Add missing clocks for VFE lit=
e on sa8775p")
> Cc: stable@vger.kernel.org
> Suggested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v2:
> - Also update clock_rate lists
> - Add missing Fixes: tag
> ---
>  drivers/media/platform/qcom/camss/camss.c | 25 ++++++++++++++---------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index 2123f6388e3d..68491b16d647 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4037,10 +4037,11 @@ static const struct camss_subdev_resources vfe_re=
s_8775p[] =3D {
>         /* VFE2 (lite) */
>         {
>                 .regulators =3D {},
> -               .clock =3D { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
> -                          "vfe_lite_csid", "vfe_lite_cphy_rx",
> +               .clock =3D { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
> +                          "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cph=
y_rx",
>                            "vfe_lite", "camnoc_axi"},
>                 .clock_rate =3D {
> +                       { 0 },
>                         { 0 },
>                         { 0 },
>                         { 300000000, 400000000, 400000000, 400000000 },
> @@ -4062,10 +4063,11 @@ static const struct camss_subdev_resources vfe_re=
s_8775p[] =3D {
>         /* VFE3 (lite) */
>         {
>                 .regulators =3D {},
> -               .clock =3D { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
> -                          "vfe_lite_csid", "vfe_lite_cphy_rx",
> +               .clock =3D { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
> +                          "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cph=
y_rx",
>                            "vfe_lite", "camnoc_axi"},
>                 .clock_rate =3D {
> +                       { 0 },
>                         { 0 },
>                         { 0 },
>                         { 300000000, 400000000, 400000000, 400000000 },
> @@ -4087,10 +4089,11 @@ static const struct camss_subdev_resources vfe_re=
s_8775p[] =3D {
>         /* VFE4 (lite) */
>         {
>                 .regulators =3D {},
> -               .clock =3D { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
> -                          "vfe_lite_csid", "vfe_lite_cphy_rx",
> +               .clock =3D { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
> +                          "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cph=
y_rx",
>                            "vfe_lite", "camnoc_axi"},
>                 .clock_rate =3D {
> +                       { 0 },
>                         { 0 },
>                         { 0 },
>                         { 300000000, 400000000, 400000000, 400000000 },
> @@ -4112,10 +4115,11 @@ static const struct camss_subdev_resources vfe_re=
s_8775p[] =3D {
>         /* VFE5 (lite) */
>         {
>                 .regulators =3D {},
> -               .clock =3D { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
> -                          "vfe_lite_csid", "vfe_lite_cphy_rx",
> +               .clock =3D { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
> +                          "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cph=
y_rx",
>                            "vfe_lite", "camnoc_axi"},
>                 .clock_rate =3D {
> +                       { 0 },
>                         { 0 },
>                         { 0 },
>                         { 300000000, 400000000, 400000000, 400000000 },
> @@ -4137,10 +4141,11 @@ static const struct camss_subdev_resources vfe_re=
s_8775p[] =3D {
>         /* VFE6 (lite) */
>         {
>                 .regulators =3D {},
> -               .clock =3D { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
> -                          "vfe_lite_csid", "vfe_lite_cphy_rx",
> +               .clock =3D { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
> +                          "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cph=
y_rx",
>                            "vfe_lite", "camnoc_axi"},
>                 .clock_rate =3D {
> +                       { 0 },
>                         { 0 },
>                         { 0 },
>                         { 300000000, 400000000, 400000000, 400000000 },
> --
> 2.55.0
>
