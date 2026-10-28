Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207686;
	b=XHrD1boBnE8IGUhwKYn/NcPHWcSFALKryzhsaIzndwE/wtwMF03PEQ71b6dX2dpuR8uC
	 +c8b6nL2l/aI/AIZiJnNqzl7DUa3sx+yE2d3RoKBXRbLC6jJJyh66paCpIlBJKubTISY6
	 FIVQJrT0RjcLbLuGD3G82DjEUZcLeHjvS+Uak3koFJ0XPecph6v5bDLSWom3mZKvMwd93
	 6pke7IRJI1MtJZxVEjZkBajqUeDB5docm8xQ+WBtC8vqj7HDtepHwnd4Ch+xslsNUMjLJ
	 lHT3sI/DPMWSSQ8SFFfFXPPTttcrymUQfG1i2xwFzLJ/fqOZlzwl8jOLFuMS/vl0GGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
	b=a0Nemce2srh0nmtywXqCbxSJYPjnaliWE25V53Cc3xqEuH1EFKDhLKI56ZnaaarQOWkh
	 cKQHdryBpx0MVK/6fExqFNL7ipXamgmPmgsIFjV0kv3Hgim51xSBjqOPAwcwRzQFLgoJv
	 F+xNxJK43GKWCgCT/+7E2qWx3T8aIgZ0bLTF1Gy8cVJDE/JK4op5dSNCHaDueZR6TWN/O
	 iicLHfUm38QeYbbOA416Ex3zaJha3bNcvHsTXiG8Ilw3fYkeTBqx+LTHCGVlXlkSc6hr9
	 7SWcu27QrbGULKAGp9VeTr/6vdvaxeWBT6+wKzEP4XsDBubPlAX5QDUnjOYYRPULyKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYGmdgia;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ItWYps3q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DD606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYGmdgia;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ItWYps3q
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAhaD1154397
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=; b=RYGmdgia+3ENWT3K
	8+9fUgyk3+OJ48GqrcLUDuwVBC9OSko/LEE1L/7t9RXLVs4tE1UHXsyw9MBM171X
	soVqa+8kcSxMwLw6aKmHKma7nuVbkr09rYqDakq8oZRPuWIyxKPSGBFu0dxAL0Sp
	Ez+h5JedlHpuq2D4MGclYUBV0DaB780wGy2MgucF9vVEALqYzjQuTDrJYQdAGtwE
	m/LPl1MRV//GkFz1jINnl0hZuJ9wxS0OlpbuxTOfDdXF6bnGn5Qv+mtPWkqsGgtn
	38v4cf5wkYahd2NDWLH2klgFk/XgEEWejb0wMkwRzsZUrhukUndRLnjyoFz0wtA8
	PzrMoQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be3pjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so1066180a91.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207683; cv=none;
        d=google.com; s=arc-20260327;
        b=FvVJpm5RB2USFjmmsoankA2Ez3r8+l+5IQHbtctzsgByL3usshKTUofidFgShQBBfu
         xCBNnXeX31ShR9TBp2CVCbIFb/QaQhyyFEqYW/2FqLHj+EOSKnKIZmpOfmnZPkqRzKfe
         ZylQCMPUHBuiJRrR45Abh5LRIXFhsWB4qgfTkLEvyesZKERq9wU+4rjG4flxnp/A44J6
         A4gp2uo1y0EdHAfeuvSYJHgrL+n6R2tG9QnG7ve45xNwd3c9SYLI/PK2mXrg1Gi8sLV8
         jRwKRlIJQR64L2/QU1i6tXm9HsbIFsW4pSDWTEZON0TdvyhxWDAXhAhcrQysZ+fbMuy+
         yyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        fh=YMCujNmHfqg58IDnQMom12BxkN4pELlU/62C53JTHsA=;
        b=Y6Kp9o0OLyjAlKVfj01m1IEnZBgaM+VCavrjbP2Gs3Wq6qTwZDPO/Udu5fgIMX1FMI
         P2ql/e4SzojVhmQupv3uMyFQQMm6Ii6D8F0wWyvn/qddJJoFrnTkZInJs6Nnw9bdz35I
         rBlktsMVEuMuQrWaTvyMR6B8njfZEKzXJgnFR4lXSHziHA3pKU8Bw2MhXGS0s/MrUN9T
         n1xINS8sZAy1M5v26Bmb1UpmwimbK1qCWQsBuKtx4InK3gy15wCzKGqIY2U5S/0+FC9g
         0jm1woQv8qY9HhaJZsjqVt5CeNJKSLuAVjwfyW66ccZc39qTzJIuEeQdeD7ey6in40sU
         VKFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207683; x=1793812483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        b=ItWYps3qeISaj+0QKytoXeoyep6Hd4pn5F0pyPX5ltoPrLVbYbtoFBMhtaB8nAb+ZW
         6/kzRMD4/0pIFPCS0NbSyMQYtkMHnBPt7NBI2vSbgRP/1nNe2PW+CINN4sjZj9YMgAMM
         1IPz7+611RruaRWGV8TpDYyFQiZORyPZIBEYYPrnJx4HV6WMpffohdc4tJ3JgSjlkJvi
         l3gEDy55CJODaUzSxnfHWugj6zQiJVuhgNwbthIgwe5wyhTinGkrXAUJrvPK4Rcpz5vQ
         2JLGCpYOPZvJza+YNhuOtV8MVaVVnjMt1ttWBHlHEelHs4y6nVMVy/OqaMGemayskbhf
         2jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207683; x=1793812483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        b=BQQuSi9aPUNxmmO1ARiCNMph8z5y6EsUXsF3tGbYBsH65d4WURM3AEqsB9OOGd4nF2
         MO+DRwfC1W+CS+punKpXjvqNr5alySUrarU+eLefWnA8WWtJAhEG2UyboNiBvgODbVPm
         fPhHbauwBDptJfhLl3T4mlM9sjB6iU4qChXoIzk/AxqZubVJS33Nzs2h0BtDL7R6TEap
         M7Xxh+KIF1cL6G98mXpRfvm3/oq+WXzFadkxRRDWDbdU8Ni/Var3lLkVzFYhBB/Y/kTO
         KSGVj+5fZeWKTnV4ovgHBG4lE6XCb2nx1XcY54SuwQyiDWhNo7olYBGdrEBRDIdoc/TQ
         UFFg==
X-Forwarded-Encrypted: i=1; AKwUvByUAu61JMmV3vJxNdiglxq4iZQQnDWjnD9Jxd6322D9GxW/5OZpJQxhRFqIl8bgqnxW+zRL1Fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi/PhyCpS5msLQ6ITei3Kyi5EGqbjHG9TOQ1I0/WnNRExGT3D3
	+mJDGUJrrgayryI2N1XlqW0YTSs1qUC0OcLuPxwX57wvLb9BFXaBDNoGP2yUrKxVpnL5hrMnjMf
	wnWQVBQmrfZ+QFb5tt08RhCZnjtw98Jd3IrHPS91viDjXxBDun+Y6S6WDN8/fCdBty2CAo8EGuW
	Orvf2fb8TEYdsEnETX+xyz1LEU8t4n6deLrQ==
X-Gm-Gg: AYBFou0EERKsjtmBuBh2Ks0ngH1hGl2t7RTVBjdY1F86Yu0v5VijPLUrdNjxXyPFn3T
	prm11Uc3yY7F4nc+Vjm2NeTGzISN5QsRiiFN9sWG6t0I5izn8lPMsjB/C2EuNw2aPSOP+TKKFOq
	GYdVs0uqKGplMFEA5XY6Nz0Pffp55EJdgS/SbQ6fXxvD6/8xVVbbY8tllTZQ==
X-Received: by 2002:a17:90a:e7c7:b0:3ac:9a03:20bc with SMTP id 98e67ed59e1d1-3ae5824d380mr2248112a91.47.1793207683160;
        Wed, 28 Oct 2026 10:14:43 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c7:b0:3ac:9a03:20bc with SMTP id
 98e67ed59e1d1-3ae5824d380mr2248076a91.47.1793207682688; Wed, 28 Oct 2026
 10:14:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261007070313.863-1-ian.ray@gehealthcare.com>
In-Reply-To: <20261007070313.863-1-ian.ray@gehealthcare.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:29 +0100
X-Gm-Features: AclHuK8OzKAlNJgB9bkGdb-Xga4FUgj0a3CnfcJYrvb6cJly0UazM3hY7LrTXlM
Message-ID: <CAPx+jO8o3+ca6LE-1DPuiOrxOWVRosuW7rf23SzLAGq4vRHqeg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: map unsupported driver type to
 Type B
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
        linux-mmc@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: xgweqT8n1RLh6G-FVY9MYOn2oA-EmNqQ
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae22d84 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=lb8OlhKpAAAA:8 a=QyXUC8HyAAAA:8
 a=NVfV2Rmm9NVekzJLEn8A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=7GnFejQYy5TgUzHuXd-m:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfXxYfZCe5hoqQy
 AMtQLxvMfzvz51EBjt9ku2Mz13e+q09YoWLQbjSeScrpR7pzDxjZW69DompSjIvDQZs6Tx5gqh1
 vdwB5TmaPE/E3vbR6So51nNFR1SdZrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX1h+LWEWSHVh2
 h26RzsvclSdnRxvIa+GxZLOcr7zK2MGgH6QRIjqw8kgnKNFGktQgHtEU9n59BGmH+3aXuktbWXv
 SQkfYqmyNY/FAmINEbmhgbiG/i1dbpR6ImdxRPcMX/9naOfJc/E0tADiMidBsnYJDpHdOsYiv2q
 clxRBXQAYoBVr+qWQjPkPjW0tkRWKdscPWnPQRKGfR2ie0LX3Su3G44cbIy0E7bU/Uf2T/j2nqF
 HaJoMPZ6SFwzYnVM8Lq+KPSVY4RtKULaDj9tAtz0+Mm9MeMv0fGHhqhpkFZ7yUGEbveVEEYULN8
 8zjR/Twzm14W0ZE8cuDQaTH80lIp8x1rghA0img5cr35YUTx7IcnvYxaFOZ4CfFZ18pHT26OGfs
 ccQ4YvgnPurdi4Gga/lVAABooxH0uoUhxx8l3u1a2oqmFk7I2rifwKEv0tMlaft9rjTtEJEK+QA
 A5iL+sMPq1dZJ60Ug3w==
X-Proofpoint-GUID: xgweqT8n1RLh6G-FVY9MYOn2oA-EmNqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280068

On Wed, Oct 7, 2026 at 9:03=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> w=
rote:
>
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the eMMC driver strength is passed directly to
> mmc_set_driver_type(), which propagates the value through ios.drv_type
> all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:
>
>   mmc2: invalid driver type, default to driver type B
>
> The host driver type has no effect on this controller: esdhc_writew_le()
> never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
> set_ios() and force drv_type to the always-valid Type B, so that SDHCI
> never sees an unsupported value.
>
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type =3D <4>`: the warning is gone and the HS_TIMING
> register contains 0x43 as expected.
>
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixe=
d driver type")
> Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthca=
re.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2 -> v3: Force drv_type to Type B unconditionally;
>           hook set_ios() for all esdhc variants, not only usdhc (since
>           the driver-type field is ignored in all variants);
>           reword comments.
>
> v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per review
>           (see "Link:" above); always provide a valid host driver type.
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 6ab59d3e346f..931e383748a9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *=
host)
>         }
>  }
>
> +static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> +{
> +       /*
> +        * This controller has no driver-type control: esdhc_writew_le()
> +        * discards the driver-type field when writing SDHCI_HOST_CONTROL=
2.
> +        * The programmed value is therefore irrelevant, but SDHCI reject=
s
> +        * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-t=
ype).
> +        * Force an always-valid Type B.
> +        */
> +       ios->drv_type =3D MMC_SET_DRIVER_TYPE_B;
> +
> +       sdhci_set_ios(mmc, ios);
> +}
> +
>  static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {
>         struct sdhci_host *host =3D mmc_priv(mmc);
> @@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_de=
vice *pdev)
>                 host->max_timeout_count =3D 0xF;
>         }
>
> +       /* No SDHCI driver type control */
> +       host->mmc_host_ops.set_ios =3D sdhci_esdhc_imx_set_ios;
> +
>         if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>                 sdhci_esdhc_ops.platform_execute_tuning =3D
>                                         esdhc_executing_tuning;
> --
> 2.47.3
>
