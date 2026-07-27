Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB542376C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169522; cv=pass; b=VYMXeR3Lrl1hPaoO8gJqT7530aQ5s/RS57Ij7+ecgMH5CC6OSoOtR7GXrxcSky94PmfSXQ9mvjT3GdKWALK3Auzypn+/68NTZWCLWVqYUl3le555mpQDgpXaqtdoy2MXG+m5TFKT7l9QN06lF2H7lv3DZVptV/st2MkVW6wwQ3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169522; c=relaxed/simple;
	bh=lIfbp4g5Tlq0Apfu2MZaanv5P3D1QanLfqpB53OYPvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wjw2H5GjSDHHXEjkZrAj4P6uy2ZUByiIfnJHDt+ZZdT+k1hh45FuhcHmRZTh+vxfJdvpLK/3E8Gs22wmnOsH87nR4DY/T9xm/Wzra8xgK4YXdN/vO6CPAANxjeH3j6n25E2AoSiB6ea0h9T+fF6JeM/hqCSJvFtEhO5N7prohsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dhUSwfLR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xns2RoRL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dhUSwfLR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xns2RoRL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmApK3823666
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=; b=dhUSwfLR4Mel9wX1
	WWcJjpG2CYJe+pOzmZ4Vl8QhCJWJnHOJY78EVI9KUvMRvuEDXpzyLU8xuxqOiiOR
	xeUbRNpN3I0AjPIZPEJ+cJqmfyjJbqnIQYeGCLwOmb4Avu3dsIhCbuFx0cXOlDjX
	hK5TncGulxPoYq/sjb4N4BWFMjNeLQQIf4seYsf0ClZQN8dxr/5k2QwhagCUsqSF
	aYcqiZwVgwo5pg0Pg3qacVt/c3GHlpaMu3AT1Im8GizQZx2/gz2hF9YYpNnDsfmu
	wL1Ohd6NjGA4xRDywMCDVTM3PS42RX9aUw/1v3ELM5y/KhP4FS3/q7RjPUH9A7uW
	Gu9epw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsscn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef18406878so38374536d6.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169519; cv=none;
        d=google.com; s=arc-20260327;
        b=o3B65SV079s7prqfRHIXK4nZpCRRoKOefkcdVjfQA4k1o9KGr+IrQqviIGjxeo7/kw
         isrMFuu3kr2gSlKsP+2fkRPIbgJmrS7UqQ4f81ncenW3QYbv5O/fEKZFu7E5yMKliJeX
         ECBL5ypewc2O7TebbV7FHPlpJSsTIgM7eRTocn/AxwUTo9DBHuLRT4oJEMhVwcf5BzZU
         h9RGFse9SHTASd4CNzHVw2BhGf0zx3Wb/7b31IQCQlk1SKnopnOOs6i2K3SJE6NN7Ene
         pVcn33kInmfQNVdGZs25fD24fOsMKc9sMb/cEIUsO3g/BDcBbgQowNrgmITgQp9cbYKD
         R7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        fh=qFPX3Ilw8LH4ifI5vBXiuQIo3jxv7slHRD2tdim9cU4=;
        b=OaARJiHkiADRy96RQNOYoePWtn67DhXtQ1g1GFVK0+fT1aI4p0uLlDVAz/yaEiLFvR
         c0Ki4KnyOP6fsJb9MqMoixg0Oy21KJ3AR/smzAnBKIpdumuFflOBpDDLq1RKU93aH8Jh
         JNl1yVrWfUb36HmpJlLP0UlwqLkZ7WZ86pBxaDhMR5r0PyZQI4RjnFnMQUgddHCcXJKR
         LQBGiEXGQ5sFG9ab4gT0hKER0AoeBq8izIBO8kE/fstGqyZ4/On9ihjBl3whRKrv6WA9
         bbXqvU93vrvaJyjN8Ys9WbQ61WZvQemsX41u2B1Yh0JWdWr8ARoJWDBh0VzOdElM8imQ
         MfgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169519; x=1785774319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        b=Xns2RoRLnw8qNQw6pFiwfHomckCgOOEtPMrN9ggBsDXCcH1X/1+Bj//BwWkkCgmWnJ
         Zxh5omfXW3D4AisFtvO4vsO3U6RCuEtZFhk4yH9ONu60n7/Uyl7tdTQeGyRQ62mVAFPO
         f6D5DSCL7fPjD1ZT1tQ9LzT3cZzIU60ZaD0VAPTmzdMXsC2uQIEQApO0ES7X4OoI84i2
         Ue8D5fjoNA1ZarBXZVsMguYLaKA0UF6JxhkyX2IXhkxcE3x7UxCMmtralNQdXIxNuCAF
         wJqBStG1NAVpckjLwRreStLSQmahmqCWqldoteFLx0/D0Sk1zfkJlW5YynauCnvL6oID
         mx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169519; x=1785774319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        b=arDGMX3/Plm6VHFfQg1k0vewUcZUComZ26E4mxk412Gw4WnAfBe8TGCNCzopNk3VvP
         +Yv+U7DKHE6xpWkQUXWqms5nmcw9pa+ioAfESKQEK6PanIRRcxEX/HVM1AV0SoDLpNzF
         wx7ypgiZ9KGnw8mtDDZWJUukNJ2UQlCW1mt+DXDsOIkRXasox59Imdu4fc+eduWEvp5E
         4w6xpDGfja/WPyli+rwYJn7JEgribG7CBypFipnFh26Bxo6rtJ006q/DZRZRBMIpkhTE
         YebM2INwQCkTtYP9xarA/GwYQj202cdU3NY3Evlyq8ONiSt3Mf95HvCRSySTtDoA+B+D
         tzlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rof4kRPglPvH4w94pLYlAxLhHXGLlrhJKCSUL0MqPBMVpLgSj3rJeWJCyclobXuITJN0Aq7OPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVnnNVkEC8LzWe8LAG3Ae4dwm8HRjhv34mfR1wt3nG6AW1EMIk
	vRPvlab4HswToNnKDj8APtf6iDrF78mR6PrUMB8Ensh7UvZv2Pw7K0kOjyCfwhVBSMgYBwaEmCi
	p8n3mnR2JGv4x/dkXsnii6Q+1iuwdWV4q+UEQOj/KzoC7OIusPgNyk829f/+74h86bCnC5gagR1
	han/slPLDgOKXODnD5vwQCE8kJDObhMfzbRw==
X-Gm-Gg: AR+sD13RaechWkLryNOmNdl74btFndl6zPWEztPKkwcpdMfAxvysl0/qw4o8UtqUxPB
	DIhO06IZnubjnzviQIkTvuvt2NftmfMa4FZ0PYE2LOHdh7bkjbB96y2NBfi4AUYg7ovds8AnpSH
	Y3QO0N1GLnsRKnVGEsx+qhvbfo52eX4Qsxzalz7BbeNWeZTeFJFdRlnFS16g==
X-Received: by 2002:a05:6214:5f02:b0:907:c056:d648 with SMTP id 6a1803df08f44-90812698557mr2993026d6.2.1785169518613;
        Mon, 27 Jul 2026 09:25:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5f02:b0:907:c056:d648 with SMTP id
 6a1803df08f44-90812698557mr2992576d6.2.1785169518146; Mon, 27 Jul 2026
 09:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:07 +0200
X-Gm-Features: AUfX_mzb6CJnSNATmuSVX-ITtBNLIJwIGjfcTpgtCMAwtkjufHh4_V1qYf0WOC8
Message-ID: <CAPx+jO8kyok_cYyUPFMviOC9KsUbAhT5t4jbTGYqcO1sHZNCag@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: via-sdmmc: stop card-detect handling on probe failure
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yAKpgK7-gIvkuAhbWPMWGIRxrYwXXyqg
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a67866f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=T_pAX8yLOfAJcNyp_v8A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX/y9OGsqK5wst
 4lVeoJy+fmoM2MCtN9xr5TTjg8EgvHoOFs2De6ij6bpV9LDdmB7GNEoGABgP2zZkqBYGaghidyn
 5Xl5wPU5yl+hI/LfpTkL9LlIj2pkiEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX8FjWMvaeWFn+
 rkuie7osRZGkY6oLJg3nd45LZXHeJi9Thw0jI62+vWGI1RbEINCS6yqlQ//STho+3measxlrqwh
 My1G39CJZZgILVdOmkGIVisBajgK9t8fmQNWXMd3Zqyteyi6rRuMbOZUk8Ij15K6lSao1OOy9e6
 YS7tf/yspQiVDndcZf0pGfvz7ezkzshrJi/Sv+7qIhAvlAvvtrMnRmfn2dkgm9brLI9QjePgCFF
 65FTdXg+gwO7T2fLTN/8L2q7CK4RYsTRYtk7HNeLHZg5Ag3PG6Zc6BVSg0yx2+ufZdCoX5AeREd
 GtCxAlnITVSuumPE2uUUNKEvfiD0DSgpNE21FMxggfXsZoOnUFKVUs+Z1qbJgRmvirkC3lCpmMh
 wBv8vigFEHlBEqstJ8QBD6mUTnSRnuww8EIiW1q19hRjkNnus4MynOmEI5Q1WoMaRms1lCE2all
 oyamcipA91U8zDUdaXQ==
X-Proofpoint-GUID: yAKpgK7-gIvkuAhbWPMWGIRxrYwXXyqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Thu, Jul 23, 2026 at 1:28=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> request_irq() registers the SD card-detect interrupt and the probe enable=
s
> it before mmc_add_host() runs. If mmc_add_host() fails, the error path on=
ly
> unmaps the registers and returns: the interrupt stays registered, so the
> handler keeps running against the host once it is freed. via_sdc_isr()
> dereferences sdhost and its MMIO base and schedules carddet_work, which
> via_sdc_card_detect() also runs against freed memory through its
> container_of() dereference.
>
> Add a probe-error path that disables and frees the interrupt and cancels
> carddet_work before unmapping. carddet_work can re-enable the device
> interrupt via via_reset_pcictrl(), which restores PCIINTCTRL, so mask it
> again after cancelling the work.
>
> This issue was found by an in-house static analysis tool and confirmed by
> manual code review.
>
> Fixes: e4e46fb61e3b ("mmc: via-sdmmc: fix return value check of mmc_add_h=
ost()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index c628b3bbfd7a..5228a1fe0495 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1154,10 +1154,16 @@ static int via_sd_probe(struct pci_dev *pcidev,
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto unmap;
> +               goto free_irq;
>
>         return 0;
>
> +free_irq:
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
> +       free_irq(pcidev->irq, sdhost);
> +       cancel_work_sync(&sdhost->carddet_work);
> +       /* carddet_work may re-enable the interrupt via via_reset_pcictrl=
(). */
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
>  unmap:
>         iounmap(sdhost->mmiobase);
>  release:
> --
> 2.34.1
