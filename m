Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F3466B0C
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851006; cv=pass; b=hW7lIQEWNWbmvB5J4cdf6GgDV8bD2LnsHjzu4T5NMBb3UKFLaP8rAHLGRFFICE+13wJsnmkB5cas3tSLzbxSbEmLiFm1Vb2NssiRlBFzxx7FstfBtFz3dtHu7MBIYZbj0qXVZgqNSUFjrgE0UyhxwmqxMZylkkmKlEh+l2t8QPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851006; c=relaxed/simple;
	bh=6dD6Avw3p/9xzikD+B/WrFmvjUtHV2ReEf9NjuiMq4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYIJZFQp6t0vbJ5PsYybYJ3y6x206vt00BbsAs7BYzk1AK0bFZcYddq7OF59tYzQOAu4QawISMY2rMBLEaXrum2gUOZGOMQGw4IfLsOCRPqxqCq4VIvTeIGphH6rIFO6eYnFxrYFfryQda7NsfSXkSdPY/T5Sr84de8rNJPECXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PA6mgmD5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOJsKrUB; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PA6mgmD5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOJsKrUB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674D31YB4031637
	for <stable@vger.kernel.org>; Tue, 4 Aug 2026 13:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=; b=PA6mgmD5hOqCrDwU
	7kkXCDAj6n0okMUAx5VVCmgfRLsGmAsxLQIG+ViKmI0aZds0Ciasv+oK3fvWE2VK
	ds9nBu6wghv4kh2F7NVBdck58GQkA3bqDIt1n1A/P1UXGPgEzQ3cwUe7XdwjiT9I
	+Yp9emUDqHc+2VRpA/fbfCYadXZA2GLwsXqJ4E4SoY2lXGGgjFPP2Z8m25gRLJn5
	0cPIByjTWXQe971NabAcTZwzakT7eArxqCu0S5UQMizy0nw5hzrwP1gOP63yoRZ6
	xZ5pzVz1koY6eh3rYuQkf5Z/+NlNAVHzh3V6aTzCDIvIvpzAUSOyUAp0PooLVIRL
	bupZHg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmg05ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Aug 2026 13:43:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9087fb77109so1295486d6.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851003; cv=none;
        d=google.com; s=arc-20260327;
        b=iUjGxKsjw015Lb9PUfoB/RjAqslPJHC637t5EaoSV7J9J2a/8WeSsRsNc7qk+EBBDw
         zr8JFJJKFoAnUbz9Qdp/BJqcOHOuymJ+R/2LjrgnFZ+W1L6he5y2GLWZZx0nRgSkRwEh
         DX3s8GyCauDHMRPSevL1zP+CfUSgdcHFWiyj+QPd3BcUzgOd0Jx8FVuAnkRT/4XqdSCz
         BKu453waDYBr1+babOLDRPjWJj7r5p341wjzC3Mzxa9tuiRJJFnrvD1E0l/41ANFlhCU
         ZYng/SaCeEE8Fd4Gsvclp1ZnLF+YGMGBnqO4Eq5b1Lnf/tf2rwcftD6qVIrc1PmP6AD3
         9r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        fh=OnRZEXywPKh0jDX5h8HhAnL7eh8ytJFjJZhVW3Tqr0s=;
        b=ZjTIVTzDJSQhXcqFgpXolH23LYgxTOX9A+tLlyLTUtBkfzyX8RUcdI6NokTnXEqLzj
         bwoqHbCw43K9CiXEZPp0hk3drIEegFbEfDanvt+pQGwHwhyNCtaH3bkZZMXR7XFy9P3x
         6bW51Ut+T6G1Myyc3mm+FdFWoPAP0MayA7IZbRz7kYWTuOqEhkUn1zMOxSj9/VNQhlsU
         6wTlyuZ8z+OSOiZaLkkWMeW+FDKKpp0Yf+uNFj+oVvVJ5JmF8yK6DHw/FHThE51AKfRq
         j/+We/lz6zZ4SgqVFpbQQKn2/QoDOy6lEECV6cwGLFsOssC8HQok01lmr3fmaWw6PZJX
         9yhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785851003; x=1786455803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        b=YOJsKrUBm/ctyBaDMH3QJdKWDSJjiR2NDlm+9Ly+2+HG3BnmYF9rENwm11CWkB2REn
         pHCOejSDsDVOgUMGXjtUYV9L3uTbWOrXUuW2vWnoG+R+x4DvzLMSSFlCmUVbdpNs+0Xi
         ADpnz5beC33dyX1HXf/4PkKnXQfCbPgcbXvSviguSsRq2pNbZbJQXoRT8E0jcGT244vw
         lS1qiqAEs3VepywXv1Lo6mG//zVvhkpW90QAHfnRvFD7ZwRyVeVs5m33lGwAPUl4Vugm
         0cYTmEZmoNQmh66KHosUwgN6H094VP2h2Uc36/q7e7fTtbV4o2qi+UVUVMCvVa1xUVc+
         KvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851003; x=1786455803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        b=UhVS+DIr7PB9T1+VOnrqcAQN02qmyV+aE3NCP2i9Xh2u1aGfseWwN6BcBbuo6e3oRC
         cpnWAiBT4JFgRqyy5W5bdDfLWRrnGuGsLl4mgYqoslY/RaIO2ZdMX9kXB/57fArqrrwc
         /SmEgBGb3nErM9xxtl3VndUasfpKWs2M/P9osa+4yAGBev/aP2ayPlr03lo1iB2btN29
         Y0Hx742CfBLg6wSwQQMT8fR+zDk7373TFbtMzgs0etXHPwg747TD3aYwqDhUopQztRHu
         R3Y/sYYWjddbFuyC46gbATT2ZeSRYRBboWYFomASzrMfwu1UGZvpQWzZx3Md1CDQByvQ
         8OBw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/04OBGE38R0z71sRAenwzH72lb3TQEkvQ0qZwUF9KFVhps5CfojaQ4bLvWsrrJHQCI4OdrbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/7fwmZQrwv8rU2RoLX0ePOcsMggRnoTIHGd1c5PQQgbtcT+a
	g5fFMU/5Bt/mX8P4E2th4hHJMCkVJEKpz1Aji4qZ5GXkkp5yUOTSZlHG+ri8O6fE7+I9WcISlDq
	MVGSZaDSqvLAQPz4lF7CgrdFJG78ihWumDLT2FGdCoHHl8nuRJ9Fw8tpq/7ASf6/NZJwDlDa0fR
	mWwzyCOSPE6QFl8t9bClHkN+B308CQgKHSuQ==
X-Gm-Gg: AR+sD10P4wMY54pkcdj5yoTRGK/1VSdZqM7h/l+qcpL1J6UT4Tzqv3hns3H3BNE99Xr
	AUuNBnOzwDqoNlc7+1y+62y0DIahg9PxkRJtnnUtaCBvLEJu+Opmbt+kB1V8EmmdA4ob/Px0uS7
	rrvOg/S4gmbLmOCrwtMg3MxlYb+N8Hf+8hKgy0MWkfyZLzIFYsfdh6YPxLWA==
X-Received: by 2002:a05:6214:4689:b0:8ee:cee4:7497 with SMTP id 6a1803df08f44-90849633f52mr303443066d6.16.1785851003005;
        Tue, 04 Aug 2026 06:43:23 -0700 (PDT)
X-Received: by 2002:a05:6214:4689:b0:8ee:cee4:7497 with SMTP id
 6a1803df08f44-90849633f52mr303442586d6.16.1785851002614; Tue, 04 Aug 2026
 06:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804061200.3897779-1-zhoubinbin@loongson.cn>
In-Reply-To: <20260804061200.3897779-1-zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:11 +0200
X-Gm-Features: AUfX_my9G4GMj9t1tipBgw864axA381Z_4yd99gGO1XwfRclHVSZN0NTfBqW_6U
Message-ID: <CAPx+jO9p4ALxFfU5eeTUwfoC03LEFTHH6zVicVtiu7BjBeFK-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: loongson2: Fix sg iteration in data reorder functions
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX/Vy5gROmAlKB
 qf+dZdfk0bEI9Q9Et34R6uzbcKO5gWbzTm2co6bfVAtPl0wnnVC5XLGuZCkJcK8sKrYQYTjnRpB
 eRYU4zGOUYSdus7SIMCnizr7Xp8nFlc=
X-Authority-Analysis: v=2.4 cv=F89nsKhN c=1 sm=1 tr=0 ts=6a71ec7c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=X4fetLzOTNcJ9inZm0IA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: y1JPbZMf66tQ_ToYCfBin78wEsBRDgxG
X-Proofpoint-ORIG-GUID: y1JPbZMf66tQ_ToYCfBin78wEsBRDgxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX+GgMypxFMm9I
 lWxe9qWDiBSe3sCPvIZTIRsKJDwiVFTE3lRHiZ1RLZDwIbkzkG9Xm3c1xSGh4zO1LGmi4SI642/
 pCZ2VGUGuv2NApVym5jHIpU008nRRxdSQaYASsKGlocOBxhW8dUcnS4EfRTMIugYgLcrvzuKSu3
 D4zETM4tQ4Rf5JjeYa0CtLHvIvhWC/1Ba3O7ouXUL8z6zUgisJjf31m/+mpXWs05x4+NTv9OsHW
 alCIHiLYyFE8RRuLFnxfXSEn387gjGOz5PGbuGgfMRvN3/Acb+geWUN6Uo9vQu0mEgEB7cD3M2D
 vpQQ7reim+9qGa+PrZ8XOZdeRiugyAMYs7bFvgcwKy1ZXwpubWFjyAL1mCJg2KxfevBFApuDclM
 m5ZjGANLiIj63MjPsd/Yyk2AZezFH0khB9BngMNla363MWmGdQwNVkqbb20rop8FkcPbWnJXz0S
 cnlajDKJxElY6uDXVHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Tue, Aug 4, 2026 at 8:12=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> In ls2k0500_mmc_reorder_cmd_data() and ls2k2000_mmc_reorder_cmd_data(),
> the for_each_sg() macro already iterates over the scatterlist entries,
> with 'sg' pointing to the current entry. However, the code incorrectly
> uses '&sg[i]' and 'sg_dma_len(&sg[i])' inside the loop, which treats
> 'sg' as an array base and indexes it again, leading to access of
> wrong sg entries (or out-of-bounds if the list is not an array).
>
> Cc: stable@vger.kernel.org
> Fixes: d0f8e961deae ("mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC co=
ntroller driver")
> Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller =
driver")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson=
2-mmc.c
> index f553e92fd9e5..118eccbaf8cd 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -641,8 +641,8 @@ static void ls2k0500_mmc_reorder_cmd_data(struct loon=
gson2_mmc_host *host,
>                 return;
>
>         for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> -               data =3D sg_virt(&sg[i]);
> -               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +               data =3D sg_virt(sg);
> +               for (j =3D 0; j < (sg_dma_len(sg) / 4); j++)
>                         if (cmd->opcode =3D=3D SD_SWITCH)
>                                 data[j] =3D bitrev8x4(data[j]);
>                         else
> @@ -758,8 +758,8 @@ static void ls2k2000_mmc_reorder_cmd_data(struct loon=
gson2_mmc_host *host,
>                 return;
>
>         for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> -               data =3D sg_virt(&sg[i]);
> -               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +               data =3D sg_virt(sg);
> +               for (j =3D 0; j < (sg_dma_len(sg) / 4); j++)
>                         data[j] =3D bitrev8x4(data[j]);
>         }
>  }
>
> base-commit: e27c946b589c53520409a0956b33d52ef7a0898f
> --
> 2.52.0
