Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358030;
	b=HLOdx0+jd5RLFg95IVo/m0mHwXGlKdHonUndWdGWmUwoW+bxLS8dvs1QtMiQGooVH+7V
	 GaNLBcHwuxkf0unoZukbGeGzNZcFWfnUn9xJIIJXhL2DbxCrHwKY2N/kdlFrkVSFZWs6i
	 Gsh5qQ4L5zgxrEbuULZfjZTNHZPPsVJZEYWL2dqOLj7pOjUgr0OstqMLTfT/AMvtBbi0G
	 EIQwwhOjTR1CzAf8pSsxPLvPRr2LuhUEdWWMYFHAKbCqgy7OdG8UjhaLts3RcFB3pSHzz
	 PaXDyuDnAAEPkdnizKcebJ8CYpCfOtGZH5/0T6KZYZq/2gB9E0n72DNKhNDMX68Ce2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358030;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
	b=R49DtsyqHz9Zdmme9GxmVRe+TVNMf4GH7g/9ylhcZ2V2jqD0w+c696OVbBIiV8ZD3uQc
	 0B+vmI227NQqqnf87jQZwzt+4nsfexl707JUAxBYWitZd7QBbeU3Z6Px6+saqIGaASNOP
	 yRHL9K2eAXFoonPT2OuoYDotCoTuJkf4mMgCxMDM5soLMPPqQo22yL27z2uPNeConoDFE
	 +ZLtlm2UAlVn+0Jniflm6iCv1gJZ1yeNaqQEFNnbdNl4cv+2jUFN0Q7gffq+4Ew457k0c
	 9wtFP3ZwV49XHf4Hs05mWW8jJkrb+bjjGJQAZD4M7TtCnRGvNiSGHRuCPOjqnBRrsOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmIUtBvE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PLR2cZHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C20606C6E3
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C20606C6E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmIUtBvE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PLR2cZHb
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U99IBq3435012
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=; b=HmIUtBvER/Y2SW+i
	q5qyGmDoHSPZdndt97PH0rykbu1/4QX7YiVLErRJi6rCe7850+rpnwajQdu5VUxp
	pIAPcjEXNDjPn+uQ1AtxgikcP/JNvGpX0H0YUVLl4OKVGBD86MAxL7/TcGsHBfjF
	VVCq697DkSz3vVq5I8JzA+m7+1xqRzrV2tEhmavl7NPBoWKP5n3xz0tuRm/66EsW
	CvFuCc81VYGmkzj51FYXmakxs7M5Qp/mtS32JBEoDxcFPhzbqqcvRxTakgGf/DU/
	nJWhukWUiGKGSNCZ7dqHeO6JbFzq1igI/QrfoxM1gpX35sZBWPP9eq/mcO/KKPJn
	emqnOQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qtjqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a06750c74fso518736b3a.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358028; cv=none;
        d=google.com; s=arc-20260327;
        b=ECTxsthXHCb4bNMRW/W+v5Ks4hqvlFcvwl9PGgQ690CRNmmQz3JCkewyCleAYUBZIA
         tVqXfiDB7mSeJ3qfFHVWP5cwhJV5PV36H5TwkIuuMqVsArP6bxvbOZUahNNU/q9wZ/fR
         LXxiDEXWaGumo8+PRqBC2ZtSW6ssBILLmpOSIJl7qfVXXIJNYYr9MQgmG6YUT2l7Dodz
         NgBnzJG3fKMiFXFE2CvgRz1wH8SBQYK70Jb5w38e7aGSLrSaTTXykw8OtvrtBvBcb/2e
         bhoIEiSMh3I0elLYlXA+dIVUa5VCkpd+0d81ekoPP0X+7sEpte/nW+JaSoSsWXcg92DT
         Wdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        fh=sNzm46mqESxtVNKsdDl/QcSIXRj6RiHdodoW3fSoP8g=;
        b=ha1PN+CVzAtEQfhg1zH8z849bCJfx07ImftR5ngR+jJP+tUsOqI9R6Zr2VVhu7du/r
         RRluQ2N+cIQQnCAWx7K5pTJxqj7WOUIkLkM1tpo4PtRv0Bg/L24ngy6VB0kOZqyApes1
         zl8fDsuuiuUAaEwQaU4sbBYTwky78MwMM3sdEph5g+yN3BRFG/ZV+wdBcrfraSol87mz
         78/DHMz9W0mgHbxaE6lOdGohW8JsRpYSrsGobn/I5t/YIMvhTs5bXRf6ZKhBxofaO3hl
         FlE4Yrf0eJHMs35fkgSduWOKQNIifyIWGJlkMlj9jE8BJ+qcPUWs5NdgA8NRQ4Rb0yGX
         ScFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358028; x=1793962828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        b=PLR2cZHbbRnab7AsDwAMHPeguKQkohBeNR/djnnwYXNAznUKIgAPo2Q6hzht5yobZl
         ZMS9bj1vcydu8Cx2x/USSDdvy3+fjfaXvw9bjBF4mzqL6MkgkKN4WPbal7ZnS8rGBHTa
         JWDFR4yqX+udJ9wzboy6hb6Ziah+Qx8JyEa07qSIS5CfNO+/bPn7mttIT84NCicna2hC
         BzpUhxI2bcEVkXWzfTRxFkTjI/1tsv7AgAW5AFHiIyHl2zSiLXYSs0KbN7ZXw/REtiWG
         YWdEHqHVr41QMffhEG5P3j+vT6EmGvF3+Ijc3Bhu0CmW5E07Uidp2x7UGT14pe+TVLA0
         dbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358028; x=1793962828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        b=lcBzq1mdKCOQmEWi87+/N5Z6zdW17vh2kgKmDjUTjcC8+MqAgE7Hh9+nIhE0LyQ6V6
         xtBeFsEphogKENW9rQpGamBnPm7OafkDrapd8SoORDEZaVHdf0IfZtM2zlEM43fLyX8P
         xUU/sW5GqJ3V7f7gqLLWQk2Bcp1HmiKmldnP6F1aDbqp0O27oF6+vxj8hLELhBqWY3/P
         Ajb6NhBSOQZrUyKsq8tqZzkyId2HZzPpw7tckk7m+X9+ajYCud54h+czWBOevHbscXbs
         EDktikZzq01qBL/TsLiB6TAUncKev4yD38a1ZwNKn+n7bOJWGM92JTtadQ6jFaGp22yZ
         T9Cg==
X-Forwarded-Encrypted: i=1; AKwUvBz3AKKOBuSCkRMh8YBjrhq65V0q16ZkBfNyifq9b+YQSrG0VblulnudhieAJVUxvwRaFCzitHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJl6cIJnVMqHh/kjO2gBqcxqFFPGxxvA9rMxBHyHEo4U1Mq7gO2
	wkcnoi/jiDSVYrWiGOti5kN2xEegSXUDZeckdE5BO7WcjAGSH2Fwr44K77/YUHJQ7HnMQ6WZShJ
	v55vCJ0dy20RR6DrtRFI+W5N7/Y2obVoLJc9m9JvdOyqjsx5tlN2xWWwrJelsWUm7Klhme4o/IG
	X4r2CewBze7bhDz4nUvhQTJOamLxVvZ9MPfw==
X-Gm-Gg: AYBFou1VyYCsrmhavmU3Pl8MEV3Q34WvGK5XOq6h2pVgXVxMhGViIIXC1wb/BkeXXhF
	gR1AJ9P4BvLLwIx/og6jl6bmgffrrkihlknS5hHygZpu8+oYTx6F2h/p5JCrfDt4kSjjKVtE9H1
	ndaYTUlpOuocnW7zgMAosNLlNE6qu6SDkIP9nEfn9Dsql/zjbkOBzOaA+i5A==
X-Received: by 2002:a05:6a00:4b52:b0:89e:7bfa:f880 with SMTP id d2e1a72fcca58-8a9be4912efmr1664015b3a.11.1793358026772;
        Fri, 30 Oct 2026 04:00:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b52:b0:89e:7bfa:f880 with SMTP id
 d2e1a72fcca58-8a9be4912efmr1663980b3a.11.1793358026227; Fri, 30 Oct 2026
 04:00:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020220140.31752-1-anferneemelokc5@gmail.com>
In-Reply-To: <20261020220140.31752-1-anferneemelokc5@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:14 +0100
X-Gm-Features: AclHuK9cDn85gWrusMMP-W9L41_UYwMzVXdFFjFJTDQP7QMovH4WYgXI-UJFkXY
Message-ID: <CAPx+jO8ZmctKiQntoYrrYW61zwFXkT0_jR8Uqgup8iB1m0C8mQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8nCsTzywCWfYNDeUlng7aEyNBE4CWig4
X-Proofpoint-ORIG-GUID: 8nCsTzywCWfYNDeUlng7aEyNBE4CWig4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX3K+CThcmlyG0
 BTIDS2ILB5KOxYu8MX5lZ/PqzZI4rphv8k1C1fFPKXK8kFeSbKZ7dxz2Yma605k/Cwjv8oHP84L
 n5KxlfGScWNBYKgWEEw+s5IfOnR1X5C8TfyDZbtgrnqWKyZtQUBxOssbQxA2howW91QrGeADvGD
 HY8klIWUDIj+Kj1VsHU/5KQk8h1l9rhV/Bi7U9+mUq9us8i9PDMuaPypjA0WBBKnMxhmY9FOMpz
 TbTtTJsjTrI6VjFqrbP7GQYsy1inSvslKrbB4qe+Yjj8qCFD1AAUxoH0Uv5YDWgwtpP7vumC46G
 IfxtAm6AR8aWXPOru87AUqXrvAKdiQI9Avm5D8t5qgek5+eWL6OvzGfJ6vktHrwBDLmzEA1Binx
 B5UC052DAV0GRyQboFgTRxnGlQcZktkBJtmRh2OjOK4qqPtQRXFHx2HXtfoqhRtBdPYintetADc
 zPrZjsEsMRIBq1JsiDQ==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae478cd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=BnDUjJD_-KrmPbzgTPgA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXyLRzyVBEZDPT
 VdtRsKbSgq9+HoR5w7KXYK6wUIihjKI+Rm4Zp0G7d86kUWvkWVLzjLnRcaXXX8xMWKcqB+TaJYj
 NwiOpv7R/8PBxRREv4XtKTbyGWV5lzU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Tue, Oct 20, 2026 at 4:01=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> sunxi_mmc_resource_request() enables the bus, card, output and sample
> clocks before returning. Several failure paths later in
> sunxi_mmc_probe() leave them running:
>
>  - If devm_request_threaded_irq() fails, the clocks enabled by
>    sunxi_mmc_enable() are never disabled.
>  - If dma_alloc_coherent(), mmc_of_parse() or sunxi_mmc_init_host()
>    fails, probe only frees the DMA buffer and the mmc_host.
>  - If mmc_add_host() fails, runtime PM has already been enabled, but
>    pm_runtime_disable() is never called.
>
> Besides leaking the clocks, this leaves the clock enable counts
> unbalanced, so a reprobe (for example after -EPROBE_DEFER) calls
> clk_prepare_enable() on the same clocks again.
>
> Disable the IRQ and the clocks in the probe error path, and disable
> runtime PM on the mmc_add_host() failure path. Also handle a failure of
> devm_request_threaded_irq() in sunxi_mmc_resource_request().
>
> Tested with QEMU's orangepi-pc machine: with forced sunxi_mmc_init_host()
> and mmc_add_host() failures the MMC clocks stay disabled in clk_summary,
> and a normal probe with an emulated SD card still works.
>
> This issue was found by manual code inspection.
>
> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Al=
lwinner sunxi SoCs")
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fe4c0f6d73f3..437fdadb5950 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1354,8 +1354,13 @@ static int sunxi_mmc_resource_request(struct sunxi=
_mmc_host *host,
>                 goto error_disable_mmc;
>         }
>
> -       return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc=
_irq,
> -                       sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", hos=
t);
> +       ret =3D devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mm=
c_irq,
> +                                       sunxi_mmc_handle_manual_stop, 0,
> +                                       "sunxi-mmc", host);
> +       if (ret)
> +               goto error_disable_mmc;
> +
> +       return 0;
>
>  error_disable_mmc:
>         sunxi_mmc_disable(host);
> @@ -1385,9 +1390,11 @@ static int sunxi_mmc_probe(struct platform_device =
*pdev)
>
>         host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
>                                           &host->sg_dma, GFP_KERNEL);
> -       if (!host->sg_cpu)
> -               return dev_err_probe(&pdev->dev, -ENOMEM,
> -                                    "Failed to allocate DMA descriptor m=
em\n");
> +       if (!host->sg_cpu) {
> +               ret =3D dev_err_probe(&pdev->dev, -ENOMEM,
> +                                   "Failed to allocate DMA descriptor me=
m\n");
> +               goto error_disable_mmc;
> +       }
>
>         if (host->cfg->ccu_has_timings_switch) {
>                 /*
> @@ -1467,7 +1474,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto error_free_dma;
> +               goto error_disable_rpm;
>
>         dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
>                  mmc->max_req_size >> 10,
> @@ -1475,8 +1482,13 @@ static int sunxi_mmc_probe(struct platform_device =
*pdev)
>
>         return 0;
>
> +error_disable_rpm:
> +       pm_runtime_disable(&pdev->dev);
>  error_free_dma:
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
> +error_disable_mmc:
> +       disable_irq(host->irq);
> +       sunxi_mmc_disable(host);
>         return ret;
>  }
>
> --
> 2.54.0.windows.1
>
>
