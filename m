Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABA501F28
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883836; cv=pass; b=TA2eFOUuSwZD318ZxyavYOnTe1/rAGAYPeAMyIj4Q1DX7qmSntzuCtCnTGmCLc6r7BdDFi5i640iB4SW6rQeLZvE3YN3Zj5AawH6J5PkWudEh0owDuRgw+nBpXWgoad309ErMOOXErL9bX8IdtRAjLZ8qr1OSRFhjY5yOv8LEkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883836; c=relaxed/simple;
	bh=WjCczMzq7v2DMLMClL76SWWp3Z7LjHwb7cMCKyxrJCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYRIfN9stvd7KB3DA5vKXY9gF8/4oys4CAkYQ8rmH5+0YRo0JP2bGlYRjNkiGQKW2kiam6rtVc6MLZKRED5kh+UJCL6SYGdDb65wr2ZbQv8wZd5EuCWkbg9irRE8krB+MC8p+ueWe7A7QNLcrN5SAJZIfaHjHqExhvWK3WnD434=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFW0de9n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADVfhSjh; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFW0de9n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADVfhSjh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdbRB2899299
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 16:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=; b=hFW0de9na3S3aphS
	KMdpo/gpsWf6jTo8uGntP21Jl0kKTvtZSarFzZPOQl9KIzgkPdHmbsqDrLtxGD0w
	fghngdgPHdCm4GIs3bI5qm+xH00rGqe8hRWjvnQ2S0QOhxNPGryvxM5sorneBYkI
	0tpPrXPIoL5jYBFmuAf65IUcNre/SDyPHajBSIamTv+74dBlJvzn/02JBPeEuHYl
	RdU4Z05NVNCvSKSrNBRIol5e3w/UFETcVaT8c57qw0ushGQCSiujPnEmyUZkWi9W
	NZjT5JZsp0yUsN4YEJKUMBsVDp+ci+WsYUOo14Lc+w/jLJjZeuSk/4pLQoYJqA0z
	4XYeyw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvujhn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 16:10:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088203so5268521a12.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883826; cv=none;
        d=google.com; s=arc-20260327;
        b=UTyi9S+AMs4Av2psSUGbSadA4O8AlEPrn+5XgF3J46xRV0xGpM8acn/hdGCBdyAzZ+
         L8Nk0RTC6ny8IVv9ldz548WAGez4JaljkQFLnw9IATtgobFQ+w3xDl4TpkO2RYUEZg5p
         oN3nEw+9kcthL2uMRlsZLGS6iMPueIIKc4gnIjV798QLvPiDECD+9xFJr0yuO9FborVV
         xW6Oz7m3cby+luPUZX+NMxhR/4iTf0oNRAKm2geb9Pzsf87ClHth/KpmlVZXeHtJfPxC
         H4C3ZMjA6ZHkpZ+2U9ZeGfFGi3/9hJG9r45VCLycRP7GAgPiYZHpREPuxQHI2uBSZnT9
         aczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        fh=iclndi2r1IBH/CTacixhoMKXpyoSAlzYYk+wKTGoZPM=;
        b=QzibVH7K/ZSOGepCfpZpLvffVTZK766kcKBaPSiVXH27nUcI/d3Ny0x5aXiubGBPWN
         VJe9kScMvBzPYoAxeVdlb9S+L9p7CE14F+A1sdkdmdOpPSGKV9A1vw0LhAAyO8/g0WLp
         veslt6NQQNp9MAYf6p97pkf/Ez3Yw45eDHzA0NB0zvHlQa+MFFAa03TjpueZgzl62F2D
         9pgfG9Ht2REe7gg6Pt6jdDpkhw/Q8lLjT2zmfs2Q6G65ZUs9Z713f7JIuoQkonNG+sH4
         +i+uzHuAA4t38+WdH2ePBN8fhE8afnxbsaUgHQ1hVz0zd5O50/yBEObn51ApGosuQhz7
         VAzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788883826; x=1789488626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        b=ADVfhSjhBU6RigVAYZDtzkZEHN8y0o9QeMslPeSBOG+pvKJaVdzhioFBlxLSt9akOs
         vZAgCsPfagrxWJVlrN/tdXVpHEwIuW7fyBPFZPHLay1qWwJEZlADaVTiUtSgJg34kqPm
         F01R74WDgvky989cIJqzvLwAXnI7y7GUEhsJ74FSWECLL1pyfnFZWzZGjSNNx22Y8/mY
         ortQtnZsV+EsFDC8tBKON/3+xJcIDFqxRXCgN6H/IZg2Va7FpVpqwwgZkUtfFhTXTwkT
         OvIzoaC0WCKPk/fnpuBxHBl+c+cdIfyAvKjROb/42MvFLxzWER3tknhBf/YSWvz/4B1N
         +klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883826; x=1789488626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        b=Ltv7dJZiVuWXIfwIisxcnZjaJKuTobRz+1y1Q8B0pix+pi5MA56eIfIlTqB+NZuAgS
         64MNGgaOGDPrZBAjTqehwlJGTVsXJo56tMcFyKGbvt0iSyXh3M9NSW6x/vGWzFIld+oM
         TKq4e8iXCpLum98e9AdYW/a6qlf4DyifXfEnwXV4/Bmpl6u6SB2iQ4UIGOr1IVj0YwvG
         r8Gh/S2E3J+ohoiL/75CIj4aQ5/Sr0+/fdaf0/55vRDLVvmomvPCZMuX33mIQ4/3m6Ye
         Dy4lbTnrvw2ATyEXFe/bj9lujerwk2BWPapr2A3368VvUCnjQIGASLQ7pxONGKZGKBmf
         NcqA==
X-Forwarded-Encrypted: i=1; AKwUvBzlB/XK8sbaqGOdABNiWsz9TndU8RaFjcKf8qD+q02H7Y2KWYzhZBN1wnDh8/SPH8T9Jue0Mis=@vger.kernel.org
X-Gm-Message-State: AFuF++n77SmqZe+0CHCzs3o+WmcJzxBq15SZAN/A2Ar5TjA/96Ljfkkv
	E1VhlOkKMb1jYTi0KTTf3I3V47xBmWHhpgPTkdQ69cRad6jX3Vzqs6mVNT/wHQygXz7JhchXhTz
	cNoXzsJEpwlGGrWYpIgdUjFnU5biW8cXuzJz6Ld47yyaDuWqXJ2Q5QiGo/O3EjSuhoVpB5ORjBu
	9Hq0OqlYYTUBJZS3URhJVvwhxrJuj7MkrMsA==
X-Gm-Gg: AYBFou2u0xoyblCcVQAhsFCo2J6oml8fO5iUh/u5lnG7Ru9O9XESveACctEIPAn0VaN
	HcbcZhu3qrRtmcadR0tWijYp0HaxfELCx67+rGcCsQGfkYcZ2KY4KE7x5ljfmLwmJgao/McMytp
	Ukegnnz+6GjoQPbhVKVz1XbW+7jfwa+/vgbsp0T3NqgYmwi+J61uEC35SJXw==
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id adf61e73a8af0-3da39f7bf83mr45855677637.10.1788883826568;
        Tue, 08 Sep 2026 09:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id
 adf61e73a8af0-3da39f7bf83mr45855537637.10.1788883825825; Tue, 08 Sep 2026
 09:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CD1C18732FB187DE+20260818113153.3521044-1-raoxu@uniontech.com>
In-Reply-To: <CD1C18732FB187DE+20260818113153.3521044-1-raoxu@uniontech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 18:10:12 +0200
X-Gm-Features: AcwNN1Vap-n-hNxpqf0uBnt7qV4BRywFtHrgMgkW8s4z4JbnZUCZDoemIXHPZM0
Message-ID: <CAPx+jO9BF2ZjPsL9MJE_dTT8pmO4WqRmQEWF=MWNR8VtsOM9WQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: reset bytes_xfered before retrying CRC failures
To: raoxu <raoxu@uniontech.com>
Cc: ulfh@kernel.org, error27@gmail.com, rex.chen_1@nxp.com, kees@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6aa03378 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=iHwBjlyiAAAA:8 a=VwQbUJbxAAAA:8
 a=8VdVo41s6FPOG_PhRFkA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-GUID: n7jWnp3_o08y019YamTyByOe3YQVl3cZ
X-Proofpoint-ORIG-GUID: n7jWnp3_o08y019YamTyByOe3YQVl3cZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX2n/xKEjKo1iO
 udYyHAktW5Ehc4wvMh4XBUaqlBDueiSMa7Pzd+twYZo07o0ku57EZbCnNaQAr13/TAvDYnPa5F5
 xM0NeRJpFRAUe3hybj5P2o8hUFFtob+TSGWxeAvk1xOX4I+QcIvsK3JAKeZYHEG9c27BVeApuRi
 S/ZFe5jf5P+8YsLJShzTj8H1dP0LdMOevAhHt6++i0+BvZA0vwGuT6a4xVtx0dA7zNEkugBZBAj
 bhaGIliHoVeCidWABvV8IvIXxAEK5xkPWbcJ7V3KONCthrsuBF1zO5rqZGfBKNQaCCprA58Qf9C
 YIcZpye7I4GSV8xLIaa6hU8rPdtykj+bnaffSgbROUmcnslnrxQz3ggfjx5EGmHUfvEwr0zo6nN
 IQS6MUT/rl/FYytuyLw4nT+m1/Y9rxcRJ2hTR3rUeNt0aTO+CHl0GdV+enYaz4aK2jW6ywaRcDQ
 aJlFKfKHd0wWGXmXf+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX/GG+bKNTtnPB
 Pa823I3Gu6Sxqi2BojCGRhoKjsQ5Cy4t5Q43YrwR5Tr1ao4N8QJs0qaY75pCaJsifwDBX+psXCk
 RbyC5jOt2jsQJJGZ3PYg4qx82xkXSKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080174

On Tue, Aug 18, 2026 at 1:32=E2=80=AFPM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> mmc_spi_data_do() updates data->bytes_xfered after each block has been
> transferred successfully.  If a later block in the same data request
> fails with a CRC error, data->bytes_xfered may therefore contain the
> number of bytes completed before the failing block.
>
> mmc_spi_request() has a private recovery path for such CRC failures.  It
> sends STOP_TRANSMISSION, clears data->error and jumps back to
> crc_recover to issue the same command and data request again.  However,
> it does not clear data->bytes_xfered before the retry.
>
> If the retry succeeds, the request is completed with the bytes from the
> failed attempt still included in data->bytes_xfered.  For a multi-block
> request this can make the completed request report more bytes than were
> transferred by the successful retry, and can even exceed the request size
> when most blocks completed before the CRC error.
>
> This is most likely to be observed on MMC-over-SPI systems where long
> multi-block transfers occasionally hit a data CRC error but the
> mmc_spi-internal retry succeeds.  The data itself is retried, but the
> completion accounting is not.
>
> Clear data->bytes_xfered together with data->error before repeating the
> request so the final completion reports only the bytes transferred by the
> successful attempt.
>
> Fixes: 061c6c847eeb ("mmc_spi: Recover from CRC errors for r/w operation =
over SPI.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b471a7795b4d..5217d713c826 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -952,6 +952,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>                         status =3D mmc_spi_command_send(host, mrq, &stop,=
 0);
>                         crc_retry--;
>                         mrq->data->error =3D 0;
> +                       mrq->data->bytes_xfered =3D 0;
>                         goto crc_recover;
>                 }
>
> --
> 2.50.1
>
