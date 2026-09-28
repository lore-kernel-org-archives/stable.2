Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7A4E324E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612047; cv=pass; b=mx6vhcB0VLDVbyz0Hf7ahPp9u7g26mlEKh344rDobsQX6TTVOocHToB0vNFVJPlDcMGtZWQ0YwYkQGZLO2OR38JVh/02Bx3kESUNFeKRWwq2FFVpG9pmveWLY6f+S8Hq4B6NH2SynWCzwZMPRjMPscGT5FKCEcq0V2NFppi7PWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612047; c=relaxed/simple;
	bh=laB01Nm6g2O5qjF28Y4NhRz2GOkRSZ1m6qBJQS5vSWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atAZWAVemY0lbRFsO107BXTpO+gYsz1CzqveVNT7o1fNZTiKKQJ2a70fnJqs72zSe3hFFKpKFdppaqNMppM0eQn8HU5r8mFWsi546z5b94Ydbtm8RX5EqxlMJHhQYftBnn3Da5R0n7HUfRAaqiqmvdMpMjlAAqdwl/ZYtt4mB0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dvOlzfBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5K4LTJn; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dvOlzfBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5K4LTJn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SFQhBD2249880
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=; b=dvOlzfBbD1FOz3as
	MMRh5DzcwN35T1zsbfVo8Znr1wueSLn+HGG4LPCIZbBV2UeqT1fejqDA8W9QNzqu
	g4w7BcVNNBsx6R+S6gvIN+z86hfueICiSJbM5LlBhWwW4MWQj8bM3BrfMczUpfrT
	iEFSIrt1DHDV+W7N5dnKkT7UP6oy5X7Coru9m8gnnm5i/F8cXMq5HltKwuUfFQ24
	s/YfNunJcghDb4UCWqBQl/0Q7+Z3DByg6iou7etk9Ei9qgyb5G6E8ewIFYQeAZ11
	8LmtGEO7DUa/M46UtblTzCYJxAiSrgJk8SpLTDAEVTKoYB9rHK3flOhornNOcpPT
	TEbLFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfksm3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a0bcf8b74cso3305368a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612039; cv=none;
        d=google.com; s=arc-20260327;
        b=BuPZgLVGJwwIsTX5lv7CzYrb9dbUX7QJX/z1gUF3viGaX1XNZ2UYcRyabxgdaZImg8
         8rmRchaRQSSxDTyd2dHGRCzTJyRegoBET2KTaOlUveQ8Ll/c43vbCPBQVwgQ+xg5SrV8
         XEIYe9PCRNrWONJwTeNTGmDCdfQZxLC84f/x37/zYZ5Vnjy7aQIwhF+Fj6o/fAiv+vrf
         1Zm9TR2c9AiXaS48zFUh9Zu3Lc2fLa/n+B4VVlb7q0ZlIPd+XYDXNGqDxGakK7mwyQO1
         vk1SyHNBxm9x+nKhb+9AgONkn84alfkoRWV3K/feNV1TaN4OAFedZP8o5IBjBKCzR8mM
         7pWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        fh=UALw4JgpfLpmuwvXLuBsMbFWBPNZyWBvrrat8JNtC2g=;
        b=QZlKrdvhzuF4rhPk6sX2yI31kHQCothSVkOx8dne/y8JF95mx6I/rfqagPiK24Z4gW
         n67gbsepZS6tozmc02Vycr3U2zt75tsWeRMhErx7ocUFFgHrj3e/UUfgoxLXl5bdr//L
         leTD6sH6MkoTFCh+RDaFVWQQqDku8qRCf7pWZErfIkLa91njVCfIkEtLvgp68QY7w5Ql
         nSluuUrq0D4d+aynZFovYquxVAhmCz21QqxaTKpyIIkdgeJZ9n5Alv/6VcKyKVgnuaws
         qhSoBj7qFEVfdbmHvAIyb4bhaesk+inC8k2H0IBAUKtMnORmERIsVZEmq8MgFJJ1hYSS
         6frg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612039; x=1791216839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        b=c5K4LTJnGD1DGPg0wwr11HGIM/9492ms21RHTQQFMFtggQBpOS3hNPnUKRWXgQ5x7G
         Qg8o3Di3SOKeMrjTnBUAh/qNmRFe3ZL+TFH51l8iP5864zzOQKLeQRoFEnpfjv8/4YHZ
         FLGA7+QO0uZOenh5sKUjLWe78h+jTcnjv/as7oJ36XnRtXHC5b0X3yxU1yG7N8Ts3KLa
         0nkNYXntU/1m6nRqK2rp8dZnzbN4NUvf7uZNE/pspb64j4K8sZBr+MzFmiPvjM2jLgts
         hoyLdDIsC6GXdxjm+lzmAeyXzns5dT6HRf3x18fHGuGl9mSQAnDCqCvkUWcEvoxj/o+X
         PlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612039; x=1791216839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        b=tPx5cAwyBxM167lvs5tlB62Svj7uAgUkpFXgqiTpz9FkNewhPJbqKsn2Gz4oFPI7O7
         CX3FuSO2bFbGblsmokO/G03Fek4TLJJatQ1gbWjjdrePdnEjxlTtdruBgtGJmEkGTTxy
         gKDEWnRAbh1gtskJzYFyJ5QMS5ix+WcLhMtY2Ki2AC+uo1cWkyjwxf847HNUKZ4rm6Av
         IMFTC4hWz0Dzt0QRckwkuZxHRpZtFO30ReTh3h6g2s/2S6gJ4r74LjCK1hv/q6xFo5ql
         NBd/OzGmbKfVLUjbV2R7OaBP8d7yQBDMzRxgZVUCMFe1CJavnYNM89PcvTgLsVoxoyRd
         Aoiw==
X-Forwarded-Encrypted: i=1; AKwUvBxwr+kUCqAmCBzlV35aukAERN2SQ6Jzvo7rcLxKvEHJ+DEsUYOq1j4LK3QHZIMaMBJxH4kTymI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi3m7FAGx0h5pdFZGyTOx1EXaGcaHYEcQgp47zH6O9n/dUYttZ
	GTB7xG3BZpLHS4HbklCUiBt/RAruMi4We3X73pXKf4oflW5zQhlUPLokq+o0xCbem22S2mddTC/
	Jl00MFEp+HZLRItGSfbdzYiFQJv1yn4UFnmnVND3gla/rKwzTol/CC/boCS9NbOMtek9v5dZRGG
	2lva/UO81G4YYrd3n6zbY8LZyX23y6Q1Ui7Q==
X-Gm-Gg: AYBFou0A9nn7QFB3Bb6XTHv9o/zfmPpQeE+1CUZe/in19OXYGbk++eEstfBZiNLKhz+
	5v5wh+CVvLRtPCI6lTc5h7jqzeBuEhXj0AIeKG4BAFMV7tTQ41aSGztXYChohH8D8MlEwL2ef8M
	LZIsMlJasl7TZnwpviKpob8HdZbr/H45B2Ejx5JEZ2Ft/Nd6Y0+fFmEgZI7Q==
X-Received: by 2002:a17:90b:2807:b0:3a0:c621:74a with SMTP id 98e67ed59e1d1-3a0c62112dfmr7217607a91.35.1790612038764;
        Mon, 28 Sep 2026 09:13:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2807:b0:3a0:c621:74a with SMTP id
 98e67ed59e1d1-3a0c62112dfmr7217589a91.35.1790612038206; Mon, 28 Sep 2026
 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915155724.2468892-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915155724.2468892-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:45 +0200
X-Gm-Features: AclHuK8NijbscYmEbRRTTVsCxytg6cYy0JdOJL7tcaZsXJf3cMG4wS2s8SQ8LSk
Message-ID: <CAPx+jO9duanFSkuQJ9ZrhWAAPzG2zhaYUtXaXhTVyOKDVKrS8Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: destroy slot platform devices on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pan Chuang <panchuang@vivo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXzPXyswgM1Mw4
 ovO3ZVONNZaRsLBvaRM5IAg8p7xPHlxyP1osatU1BRmj4smp414CPDhhjeucz0Ijol5Gs8O25X2
 c7qhR9l2VctKmUKuFpYR33d86Xfl5Wa2uRpejyG3qG2P4pGh17J9Pmi7Io6qb4K+PGHptd4lMG3
 bx/5IsHlDOIPagQ544bSQzus8sRQt6x1ypaZb7Dk5izfh1wd3CHcKxsuwaLuyQK2Ler7Rx4IAcM
 ndMe+d3WgzFl43zALtv6mnvL4z9rCS8LciM2xDmchCt/+0dQ1MWLzXag9mmd5OolO84yHzIEiPN
 xD3MByEFFZ64YnNd79uM4Zts3pMG7dZKtEsioX92eiiKh1MgDsUQ/Tch8GUy17kQWMD5ZEzCEFR
 kWphxRX9mHc9RSa18DtgNf+4lmzpwf/fGkCGB+ezxAeDmheOJBLgIMaoqeyaj80+GXiNGDqk5kC
 MOooR1fZnhhNoa8hMbA==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba9247 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=2raNofmJN35FeuP7pWwA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5NcpirvlGuV2H4KDmlj5DI8N8Xn7PoB1
X-Proofpoint-ORIG-GUID: 5NcpirvlGuV2H4KDmlj5DI8N8Xn7PoB1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX0RSI6vO7MgXG
 fSOQ+OoeoEXU8mAy4ov0NfN6bpBdkBuq7+74p1jkmzg+3GilVzS1KjVmIQLGyVO/R02Zu8Re2Ts
 bvNNsXAnjJw3m7AQ0MgZDaBwcwRrQD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 5:57=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> octeon_mmc_probe() creates host->slot_pdev[i] with
> of_platform_device_create(), while octeon_mmc_remove() does not destroy
> the child platform devices.
>
> The probe failure path removes each MMC slot and destroys its associated
> platform device, but the normal remove path only removes the MMC slot.
> As a result, the child platform devices remain registered after the
> Octeon MMC controller is removed.
>
> Destroy each slot platform device during removal after cleaning up the
> corresponding MMC slot, matching the probe failure cleanup path.
>
> This issue was found by manual code inspection.
>
> Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/cavium-octeon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-o=
cteon.c
> index 1bfc1a4f9fe9..671dd1a36a74 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -295,9 +295,12 @@ static void octeon_mmc_remove(struct platform_device=
 *pdev)
>         u64 dma_cfg;
>         int i;
>
> -       for (i =3D 0; i < CAVIUM_MAX_MMC; i++)
> +       for (i =3D 0; i < CAVIUM_MAX_MMC; i++) {
>                 if (host->slot[i])
>                         cvm_mmc_of_slot_remove(host->slot[i]);
> +               if (host->slot_pdev[i])
> +                       of_platform_device_destroy(&host->slot_pdev[i]->d=
ev, NULL);
> +       }
>
>         dma_cfg =3D readq(host->dma_base + MIO_EMM_DMA_CFG(host));
>         dma_cfg &=3D ~MIO_EMM_DMA_CFG_EN;
> --
> 2.43.0
>
