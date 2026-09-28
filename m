Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116A4E06FB
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612030; cv=pass; b=hcbfU/teKCJKRa6VW1uiN5AiD7s30TOsGppRtvid2t6cGXUiNswGt4hywkuTBBkS4igwglPf9vOFc7dcPS0NMppv7XV47kcdynmILrp7kI8Wmy3RD+XotPw90eHU7/ZuYpxCGrCZzY+14mVpd3sID2SD+UF9YrM52KjQaW3+enE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612030; c=relaxed/simple;
	bh=t3ocf52Q+sxwlNU7sDw/sQsHiS3xPKtl9PS6SCcb/Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGZ7Or7jPYcmECGfoG6HU8vyDCov+UNfrj8KbMqrjxI2d5Sgg9d7e4Qsf0fbZPLtCqgIbjOZJ2URJuSCcj4Y+cG4FSkjnSUCdNLopN3/TKer3d2BaoqWGDFaBpNMjCxHpORc410LMAhR+kIffe0lpJPxbzfzv3ooNkOjeLD2QOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCoM/Hh0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6S3YBQ+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCoM/Hh0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6S3YBQ+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEeTi5941350
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=; b=VCoM/Hh0XIxHSNNE
	FqanhQ/ehAyRBAk/KHM5nDfDJEQWGpi5OaQpEs1u82XBXTPZbVQmVgCZg0ESPV7h
	It7DC/lddQ0XmK2ZNxkARSYbPYurhsXNdZrYP5nO2E5NUHorONcGKW6qdPVHkS8V
	Fmyt5mkBPTOyPT9EjkdDVGZ7lXMYXPE/MtaZo/k/Uf8upY3oiykM9RJzsO8Pyhoo
	fPrJlibDJrga4nljh43zYB+HgN66Z18ZGad7PgMGhKjgh/pVY5orDFkqyMr50Heb
	pmK/EgJPB2eW/RKIHFz5IVBlebNFEan1HBmqxYuJAYmisOkNAyh3RoDro0xbqRYS
	pOBMqA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt12bcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a0ad137e87so5013956a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612024; cv=none;
        d=google.com; s=arc-20260327;
        b=cbQ5uni+FnfntNhx0tZm6AHqs0acaUHDCoYdfReaVTgSpZ/f07/+CPKuv2sAWDuCzV
         41xbnrTkRPMrbBCUHPgqrH32wsltBoVK95p4ZngrgB2zmIPbyueemoCkmXj4uBVWB626
         2sp1frUQ3KroThFI/w3f8Q6wzUUwntodA49Gb4WH9fHtDbFsSgx0h8PwcenbPhwYeYXt
         sfRF773oTbxGtq+fjf+niAdMfbqIU5QU4MnbbbGb/SnF4Uh75wr9ALvUQVRZActAkM80
         YGY6WK9v/ORvrjOyKVDkkwtWNmdRdRgZjyE64Hv31FjjNV5o6smkqZY2j5fHpzGL9168
         tJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        fh=Wgr47TZE6QsMrIIHAnZIr8WJKqSEXybYK2SguHCxRyA=;
        b=pJv15oDvWoyX+AdXpQenHNvyHN/vGSlNeOCAcZpeFOzpWALcPM2g96ONDKow2zBIGQ
         bzIhJmeqNlCL7eOQNt4cXrJcLwwepNzfI0p3dXx19z9uU2tLRVWAoCgwo+3wWtvuVFsh
         8OLr435M5+AH/PfjjdWflofECZY7vB0BJwwZtQRZchEqbyCnnXcmsgqQdy02gGQiMqQ4
         5a8PJgWcCMkGJz48xE9sO3i7YIfJLHY81x5h9nFcY8t0zv/PPn7gAP+wsKZeTXWIcBng
         qRTp6KV69bdczTFKWwknPigQIDFp/NdWBUnxo6HColCaR/s2KP8qOGmF8G3pbR8Njn39
         3FOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612024; x=1791216824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        b=I6S3YBQ+HmiBur0EWIaBJzg6mZJdLr/oVg4Q6vneSGXVhsFpGE9viB8mb0DYpWdY7D
         FicIQdnADbcOrtyES4b8wWX+0f1GsVU87YDP8jiwyuGApqp/Rj8zqtFMcDclq7F33FJ0
         u0a6XWIpbVUIMldjSFaxN5DZLm7sVZkN450kJN5nLHsUDCTBEXX6SdS7O1jpCK9GRcOm
         kPI8BLQ+Zkg02bgQFyXj91dxjqX5pCjeAu7wieEbNqHTwpVEhJUdRTHqNZQHHRIwZsjw
         N8Sb/X69Jf5pa+/wHYeb9inJjNoxkLppfzq3SGeYLmh4RhkJz/n3GMnehS6Qeeh4xC1G
         D9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612024; x=1791216824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        b=cue0BvpsB5haQr0Gt32nxEUJ762AF433OXs0c4OKGaK9O8X8/fYAIkVelyNtSamXYy
         Ffk/6f+MTVmjqSgK3XuMJf8/eP0ynCu0Q1gY2bF8YNCUTXuKH7oNE5+a9BxgT6EGy6i1
         AfhyjOqvgthEYi4RF+5A2ueUfCN1iHpnTSMX7/P4/jC8/GTrGfvr0BHhAAh8D1us1Y5G
         7Q1/ByyTOavYoR0YoS8SpkMTcCCStOyGt4aEBVUBAfM+uKOYsMlhQHC0KiKvVpKHQJyx
         9Rjt9sIWquAx/zRQwnj0EIL9ltVZG3Vx+ZsEYY5r+uTTlrOtY9PfgG1F8WJMC/VutcxR
         LBoQ==
X-Forwarded-Encrypted: i=1; AKwUvByoM0ufC1n/vPUj4hw5aamVpc3ijjSKsVRuVjNLoWAicAdPeeh77o/hG4pSHmFJmKLKxWjLKYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/fD5P5bg4qXsZeawoyEBQ0/ZLUVBgy+WoHVMBq+SweNFixJdH
	B0aNVEB2SUsvhSSYo5sC0KNB/kb0iE3UJQ2qSQMUHAmDFcmjELmzEiOYGshUXKHPrpL9iHnlT8/
	cd827AQDnAu9LK57MxyurSlWCDgE/mI4IkU+D9NTEyFTN3G9cnze5MYE6SOUClvmA0ppFgQGAVJ
	rsewHuLFne4g4iA6BREgM5Kzu3K3cjUUChTQ==
X-Gm-Gg: AYBFou3JkZMHMxkBaKYSSKYbdOTwXm9X1z8AGlOypKQ+JlwuOUk+5t9SG36yigC/U/a
	OBvt+572ZZugVS/Y8lvu0m8QPQ2UI9qXzGFTdJLIIyrfGIX8ir1rIU4UMYwx20ESUh3Tq0POVKn
	b66aNZuHa6pH9tRFXmK9IWk8wA0CC4z0EHQVLbngGHC64nXZcuD0Bh1cRn2A==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id 98e67ed59e1d1-3a0dec0d44cmr6441825a91.63.1790612023146;
        Mon, 28 Sep 2026 09:13:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id
 98e67ed59e1d1-3a0dec0d44cmr6441541a91.63.1790612015533; Mon, 28 Sep 2026
 09:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915161947.2479111-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915161947.2479111-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:21 +0200
X-Gm-Features: AclHuK-rCSkbx6ET_8ztVCrCgQ1IFSY-9oEQLK62J2Ir0H3NwcNF5BRthCX7OXw
Message-ID: <CAPx+jO_1wuE-zTxQB+-k-yKTzFfpLMGwvae3mKnG7v-ocB8b2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: disable runtime PM on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3tqEpYjO8rH7
 DJZZdY549P5wAfjU/lts7qRlcdlq3e4LgSi+jraqr/tR4NrMxIlQ8gy7u7hEDTiLwwb3a58m9b6
 YVHLEB/hUlL3z9gcRElIH0/YLJN+JygCASI096AHDqG1f/Xuf+k7QRLGbpRGt3zTGODOQV9rIf+
 K1YgNkZz6U9cAtOsYn0lcky6ok2jdsyr+Dl1cCxd1NIJuwoivsr0DZH+rLy9nNf6K+f9mU/cHMQ
 vn9wkfUa4WOe+d51sOOmxlwh4V/vZTIFhV25azWBtrG+JA15N0MJ9SKPHUKY6LGEB5KCJPADnB+
 8644rixsxdlN4jL7y9ohHWS5OqGSVBRI1miHdGx9VI7YAxHT0VFUcFXvCxgOehQPf0a3x0GGV0N
 TL/8qsJnjH3djXYUMt/woXsrl1ndQZaBMieuipLXguPROfRO8Cz+ugXfmyYQ+TNDKrL34uVN7bd
 6a4fUW42+0kX9jlu1gg==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba9238 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ntNj6TDCI3ddbZwZ8hEA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: rvypCbNK0lBZrdlNKeQ6fwVC8lBPHgL2
X-Proofpoint-GUID: rvypCbNK0lBZrdlNKeQ6fwVC8lBPHgL2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+0PgJ9TSUth5
 OycFovdRXCUB5SsXQvrF/pePnl3GYLb3phbQDT/B1ap26ZPFA02k6FLbmsce2wkLLjhaJcINkDz
 16b8mVqiRgo5DrM+Ct5CA2PA5hNrz2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 6:31=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> sdhci_sprd_probe() enables runtime PM, while sdhci_sprd_remove() does
> not perform the corresponding runtime PM cleanup.
>
> The probe failure path disables runtime PM before disabling the clocks,
> but the normal remove path directly disables clocks that are also
> managed by the runtime PM callbacks. If the device is runtime
> suspended, those clocks may already be disabled.
>
> Resume the device before removal, disable runtime PM and drop the
> temporary runtime PM reference before disabling the clocks.
>
> This issue was found by manual code inspection.
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host cont=
roller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 3584a2b314a9..0c8f389fe584 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -890,6 +890,10 @@ static void sdhci_sprd_remove(struct platform_device=
 *pdev)
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_sprd_host *sprd_host =3D TO_SPRD_HOST(host);
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_remove_host(host, 0);
>
>         clk_disable_unprepare(sprd_host->clk_sdio);
> --
> 2.43.0
>
