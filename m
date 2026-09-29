Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8F528448
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687227; cv=pass; b=hCqhq6uglhXRKFRTl9Tc0SRIz/D7MJmOraBkx1evhm43oNJAPrS8XSFLduLbz/XtwesbpI2C7UF6Mv+zUuE4HZLsXpLgcmyJG8WxlxgKAgYTzz+Vf2bzY7GAChwjK4NDO9pr5NfJZIkY0WszzHGXrEJI4BNgDouFC2I4l63PtNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687227; c=relaxed/simple;
	bh=V1DsO2Pz3F72ju4dQ/Ux5BmxpF0TO0iwXoQe07SqAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7IqzYvQvz4EIJOw5DnRrcYhywLzCZ4MDkx+dbQixt3ndCABbSlD7BKFM/g04d2yVnd6+vDcFznNsk37pOUD56XZYoangC1Q9tBz3gdpnhlU32xU7eX+AwcMlC1namcf96CJTG0ohF/epCIrL038mYmG/1eGn1acpG2eWxQgDR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onXVlIRs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e8r5+W/C; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onXVlIRs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8r5+W/C"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqf4k3842780
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=; b=onXVlIRsP+NRcjVq
	+6r37hTQkQdyY0A6qkTNSYocZjGSU5TsTuhOi5F1/9TFr+VNpE0pc7qe+ACPYGdb
	M6Hcwh5IElWBjkPN3T3dOZ3HFqEXlhAk2LL1NwUFxFmqFq9tlF1rEdjwhIxxM6e7
	y7DJo2szT9xbp7viJveBkMhX4dJ9A94z6PWskIGcbdbjgm5A1/msCLX3jldVmYT6
	FPDlQ5fRW/FDdqRI1tO9VXo8xt0hc7A3wIXfS4Ze6KFMEl4i+7TQC1j/wRLkqzNe
	PitcJ2KlV571B0SGtJOlogpIEkl3ryP8swKWGVbHOfNAL9cNXK6OXgHE0PM0FJQu
	o+XiWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v8tag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:07:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so1111336a91.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687221; cv=none;
        d=google.com; s=arc-20260327;
        b=UISAwfIc5H3JjPdoeV5b8gdCQeL0jjHXByoJ+C5+8mPESaJxjZ7hw8nV0CKm6kMH91
         9coTlOM/PqbchVfwwO/AVfSlOPLO50WaE0o2y0uThLEgYTxjiFDuBwq1AoejbPNmvJfC
         z3b4loWarLuvj1vmR0hUIryzJWSU/f0LQavlYa4DDUMi6VmYQ8+F2b9IAI7SWJRF157w
         lShfAJgOmkCxknHIXY6dS0VARwrQU1IsTGQ/u8x2lYYPHySvWsKFmoHiMm/CCSQHTe/y
         MtsaPaWH/Ztuska8ApwmCaL9QttZsIWRsAjZgAWtRtzC1ESQWSPDqiWPBWj6awufwgtZ
         Aaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        fh=0oGX6FMofaN09sUxamcT/AU7kL0mKohysPh0qVkkAqE=;
        b=LbVQ4+YOwJw+lq2/Lqr5zJJ7tzNnIoeM6lPKeF/n585RJIJH+Ki268xNRCgu9Fsh7M
         PkoAVh9MkyUYp7hjYnbInbbahVYGrxbcvXz4ETZO4b5K/mCpvd5mbcLT5YV0LXKxoF3d
         WmC2kdQvZf2M11rd1RRaqpWUyGCaWu75/Ota/pqHmSQZIpsoogfVqzXHaK8dr3psYdbj
         ltot29RB3EfxmOMwztz4SQktlCrbQapFoFYw3M7zL6Xj+tMEy2A6IehI9Ql8vvG9iR1s
         ugv5BrvvkuozrJj+kCERnyH/kGBOUP+zod6bSOX+hBrDWfMSEw1U/7L+I1T3SIG7MwB5
         5CsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790687221; x=1791292021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        b=e8r5+W/CcebgGf848IVTIFhQsstQPFdh/rNRcw+qpd3EtT6YoTMLNUOlIIO0c/mLEt
         6rlVIVRRyVfPqrFaFpCSY9e2Fy0DlRIFcKUAK+xkA4ofXAlr5cB6DgbHRoU0HgWnNwYz
         q8Y0NDQHKIPHGy/H6jJ3RZ0rzm608Q3v5NP0ecdmsvzmag4NdbLRCrv49fQqudCuuVXQ
         h/1fQ6nRQJP4MqyRWux7jyO7bGZEt7z3qzYrwqCSne0pZSS2M3oKUHWcG+GM3egeyJdj
         30/N1lHDh0hGbxzgrrd6eivSS5v7uqLSFrd8ifzIQ1+mq796ZMk3x9dgYGl5G8D7mlOE
         zGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687221; x=1791292021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        b=bxje6j3mh7xtHB01v7eYOO1AMy2tevzVOR3A5l+LvPvTNxqMLsKUrQGPcjzsdUOoE/
         DSDtcOCn0QTpNRL5sMpez6AwFDV9MEejKfiCecLMc5EPA9a3tV1ybD15lnbSEcoQwZcV
         HYYAUptACB4ySIzBnXOsBtmwc5oJ6GRUH7Sq2pZaof/ripupLPzuFSc34xBHdxbvBpcb
         9DMv7XXSJlHhZDfbzNNfcqPBxQVg5bDDeF6KsGYwAYBghLJx7L/qiRek+iJ3nPmtEGZO
         IOmH800dVrXH+gzzmAWile0q39xouR38OXzTrKBlUH67CWJsb1FU2+g/te4GSxLcExcP
         7T7w==
X-Forwarded-Encrypted: i=1; AKwUvBzl9h7tP364B5TLoyTf2EOnRF7XDNNncamvBs81NK7+1frh9o20Hty2YwaA7hWjZjjHrPxFqBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX/gteCSn+1NHIeunwI4lbK//vNXr+F4Y4qTE7ZegH2LQeaL2d
	qzM7coW2Vo3DL93RlUOw2tzk/Kyc0GD6Tz60YzLKS4zkCzxfDpzA8VfIJLKYdH2O6mIUKK9ZiTW
	nMFrYw3o+uHT9wNXEmtBwDb4DjQLsNwcjQDJOOIoMmyCRg05Kle+uZxhzKm6QNhZwz1B4zyDVuq
	kLPBQj4Dlp5gIHuZ2f775jT4eqXOAAjE0R6w==
X-Gm-Gg: AYBFou2Na7NLar548Su591HdxvmPveB3EgNqesp7X6IHCOSLoM/Xkq6giwFIAII8nBR
	Q62EMvUpILLeoehuBt93qip4Vwl9Ty5swbzG12vQoCSnaU/r4tX/VwWrJ9MoqQqmMNyVj4DiRMS
	3Gy8LODwc8N+/BVl9ciAAAoipIuwPsaMYsYIMJmelLqz5ovvkUUEs/AcSdsg==
X-Received: by 2002:a17:90b:1dc8:b0:3a0:a781:2c39 with SMTP id 98e67ed59e1d1-3a0a781310emr12666118a91.7.1790687220844;
        Tue, 29 Sep 2026 06:07:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc8:b0:3a0:a781:2c39 with SMTP id
 98e67ed59e1d1-3a0a781310emr12666092a91.7.1790687220319; Tue, 29 Sep 2026
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
In-Reply-To: <20260926122908.866-1-ian.ray@gehealthcare.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:06:48 +0200
X-Gm-Features: AclHuK8ohi6TIyO3G8ZsjJJvVIubQzRERp_6C1DA8_Wo8f5Uw_B-NFxG6PGshS4
Message-ID: <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
To: Ian Ray <ian.ray@gehealthcare.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -eJG3WpbOh5ow0ahard5PoIhw6bJ10z6
X-Proofpoint-GUID: -eJG3WpbOh5ow0ahard5PoIhw6bJ10z6
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abbb7f8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=lb8OlhKpAAAA:8 a=VwQbUJbxAAAA:8
 a=ChPqmsTiKTP6iP7Wuk0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=7GnFejQYy5TgUzHuXd-m:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX4ZCR7SOt1SkJ
 /IQN/jwrWDcaDWwrwtEylMrsy9XOL1nNpRLFwinE2sJSBSDIdnZH8fUpaOk6cskJlv3JsfOISKQ
 1E9gY2lU+/cu20QbGg+QnwS9l6mSp3WtRTV3rgkK18yLSpdIkUnHQUjUXI9aXeZpn4TBxYPqH4n
 5HsEcknUniygVnWeUQRLI+YAHF+I0bwqBTE39a6LdWl/x4apfBTHdLQjZa3BsZo6PhxdQUdRat6
 AjQ2rFJvZ/L32m9dYNKNgusxked0Y+vYIwCgzRaUYYnMDlb8MgIb3CuDE0QiIKHLlRUf7IRxK3C
 ZJt8U0PiV7KkSn5NnRn3hKGSYqpPVyhKSitcMOMy2Ql6NvvFKdgxr+3DsvBb2BqymsPUxD+pFt/
 cutg3T4Fwh56/5ZVZyzRRypUZje6kbXruAyt7GBWrwQ87WfJqZCfaAY77zI7+pp74wHtNHlTfFs
 oRRLSgiTkIb/LzkdGmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX0H7apVDAoK4F
 1ekt9HtFxCFqpIK3owcTgR8a3uMkrLwtwnUjCKaa2SWdPx96zBQPQuu8yHuNHIXOVg2o0Gwo+Uh
 rN50qB5pblhoiQYjBlFzR0/K7+cMDGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290052

+ Adrian

On Sat, Sep 26, 2026 at 2:29=E2=80=AFPM Ian Ray <ian.ray@gehealthcare.com> =
wrote:
>
> The host controller driver type value used by the MMC core [1] _mostly_
> overlaps with the eMMC device I/O driver strength value [2] as shown in
> the table below; however, there is _no_ host mapping for eMMC value 4.

I think the mapping exists only because that is what the SD spec
provided when this was introduced.

We can certainly add something that corresponds to value 4 from the
eMMC spec as well, to make this complete.

>
>   host value/type   | eMMC value | nominal impedance | strength
>   ------------------+------------+-------------------+---------
>   0 / Type B        | 0          | 50 Ohm            | x1
>   1 / Type A        | 1          | 33 Ohm            | x1.5
>   2 / Type C        | 2          | 66 Ohm            | x0.75
>   3 / Type D        | 3          | 100 Ohm           | x0.5
>   (none)            | 4          | 40 Ohm            | x1.2
>
> [1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h
>
> [2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
>
>
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the selected eMMC driver strength is passed
> directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
> this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
> complains on every ios update:
>
>   mmc2: invalid driver type, default to driver type B

Perhaps the print above from sdhci_set_ios() is simply a bit
misleading. For example, it looks like arasan_select_phy_clock()
actually uses the value in ios.drv_type as is.

To me, it looks like the problem is that mmc_select_drive_strength()
doesn't really do its job correctly, as it should help us to figure
out what is supported by the card *and* by the host, so we can request
a proper driver type when calling the ->set_ios() callback.

>
> The mmc card itself is still programmed correctly (the HS_TIMING driver
> strength field is set from card->drive_strength independently), so this
> is a spurious, repeated warning for a valid, documented configuration.
>
> Change to only program the host when the eMMC driver type value maps to
> a valid host driver type.
>
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type =3D <4>`: the warning is no longer logged and the
> HS_TIMING register contains 0x43 as expected.
>
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixe=
d driver type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

I have looped in Adrian, to get his opinion on this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..ff5d4b805998 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card=
 *card)
>
>         card->drive_strength =3D drive_strength;
>
> -       if (fixed_drv_type >=3D 0 && drive_strength)
> -               mmc_set_driver_type(card->host, drive_strength);
> -       else if (drv_type)
> +       if (fixed_drv_type >=3D 0 && drive_strength) {
> +               /* eMMC driver types >=3D 4 have no host controller equiv=
alent. */
> +               if (drive_strength <=3D MMC_SET_DRIVER_TYPE_D)
> +                       mmc_set_driver_type(card->host, drive_strength);
> +       } else if (drv_type)
>                 mmc_set_driver_type(card->host, drv_type);
>  }
>
> --
> 2.49.0
>
