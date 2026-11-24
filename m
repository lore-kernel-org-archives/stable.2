Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510334;
	b=o2xHIfCCmg5zOMuxiAxQkPJTwcEjHFRtzoAfFv4B83g3KYkppVg2/h0Kle/F7HagiJvG
	 geFoBfLwv+mcYC+XqBbcJ+tcRGoTOPc5Pb6RpGg0t34ildZZerQ03G/gQLrlEt6eS0YzV
	 s6kKEQBlvWuJpspAZE+3yt6OpX02dp1+W6Pnn6mGAZRY/Wt85VQ9NjKa15m3yt610gdKu
	 ddasPqEHDWwqeS15F5+L3lFTfK/90PRWoU9A9cUWF4ut3fQkQZprHQFtwNnhtwXKi61fb
	 uxAEIylqcDQ10xQ7+um1/nt9NHsi6ThnCr7bgh26lFh5DIJU7yN4u1oPqdk3SrAbljg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
	b=e3GPti1c5E4nJqC94MRBnTEFobDfWIkAW44JO8H0WZfZb1A6WLaDn07tC9lc4C1oqqC8
	 EYGdW5IAgm0zQ+TC+GZ9vwB4RDdR/utHw2Xm1lVSSTQauSkQ+3+zdMJmgDWu+Rrla9kIF
	 Ezu1ldBq2FtHde1fIFjQJCIXF0R533Nh4Mpqtv6BFgdql4t3xNbNVzyOaQhgroGPoWOX8
	 iqlOUKBSiYC3t26mYKuTKgjOuytAinH7Uq6Bz+Ehi4u2yL3AxPC50xWNtukHaoYCw8Ry0
	 PaieaN4mLazokUqGhN1qM/97UiphI/fGVrLIDmMNQY8E0LVLe5xV+pjmFhdboqtP+Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gULAaHek;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJBkI7Ky;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FE606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894FE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gULAaHek;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJBkI7Ky
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8DLN72209206
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=; b=gULAaHekKgIQsjv9
	G4FUbn8KOs70p9fRP3Z6T3j25V1tkmBhH8gLkOgJTNlifcpeNyppzllUTUDMOb3Y
	c0hCImuX/3jtOcOHliQTtYe966wxKG2VP7QA4bLNwn+5YHeWJskWeZi5GYxCbmLt
	IO1QQX/QN0E2Kf+okUJkOMZIBcjbBYUJc8N+s3uqSILvm87w3yAh7jWzNiPCx90v
	8VODdoptdGiLMKqaNK2zpMVWCZtBD6A40L5/ki1tqXYXWDnZoucvF4ILB6VUACUY
	qh43wOs0rzVfBEli7xv4ywaeJXGhfsrPK1WfMvtATAMk1GdZNY+xHn/+rzydye0v
	j68nEg==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy11rq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:52:12 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67c0efb7b97so2179124d50.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795510332; cv=none;
        d=google.com; s=arc-20260327;
        b=Yf08UnXJg/IrpGgunZIMsbtzAO2HGefISb9SDmoBWYi0a+lRbyyHB5JFXGhzizLSJV
         GpCZwTZ6k650MjoJrxlgHFcTlaYY32fNs7dUHMgeEWEzvHmLv98C/RrOvK6d/Ys017lF
         vnuly8oR9RYmkJaoo31+gxnNnm2xWfz5PgvkUByGb6c6OtceejcNAZVQ9Cinj+utKT4r
         0KAKov1DP25HKtYTnsWQYa+8G86wC2LVz/U256KkSXlIZnCTr0ixrfSNec7XgOvMddSd
         Gu4BHf/vaSZunIEu7BblFEZHFLQ0HHFyWet3fHirakentApLEuHKg2mOTf7fnIluxksY
         8DIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        fh=/OswrcVMEk+hPZB6JGssAjop/4weQAAnRbIKqgLu/mA=;
        b=BkLrwX3jonGcM3t/yBQFZ782cqJBgGLY1a59r2PmWnhKnizm/ja9ol3Ya4ph8AhexH
         64mDb3pwZZmpB0ztgX3Y5JtKicFFPyt6sIVStVwo40WYZl+BKsTUyEHg3dvQeQDci4Q+
         juZA5sDrHRcNy2sOVb5DjjduHRBZjyP5Xd9duPLvquvrJOFq0IgA2cvXYHzCympL38yV
         o6W2wUX2TBAzYPX/KLcpmoTDGskgrW5Xs8wIdvMG/oUaYN08A1H3HovuoS6UvBuv///c
         rLpFiJevU9WOMU1Y7Z8iaII47U+/ojq46JWR4KUPNIMUMiodLmv0TMNIoWHKMq34LAxt
         VFZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795510332; x=1796115132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        b=DJBkI7KyQYqYCIhYq1QI1/aMNkekO1BIJVTkEP/7qv9/TZ8NNpZIjd9yL5LI4RxgJW
         kPe02xxK4XfzCg+8psdyRKpIZvdV9WZTbiVC6wgR9PQ0PAhevjGUli7Yo3Z1C2voAXE5
         mt/tA0Ri2DBAdOpl9uBNovHd+dcvEtDqCN4/H03ty9kDfVRknA1IK3jWS3vpF7j234E1
         mxbLSL/+tkn3XeXV6/t9nNGewf/LwSp7fcAreTVlL81kX+Z+MDpOd9sQhNgOV4mjV29i
         zIBoRWsD3n00Q/4GUNS5sbUggIm606/sosIAOKtYVkC37psFfc+9YDH3IwM8Lvzas0jY
         OKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510332; x=1796115132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        b=Nlk/glZi9yMsR/VRrLBWh63Sqw/A46jgK+ylLbcMvzL9EEkk65JC+OlRVzVpjiLagY
         syBps85T1DkZoXr+Sg7QTMea10m9lhkAr4aoe7zFaausiHPkvk22bQUfUC7zaS1FRSa1
         SiexySEfEUzWH4xldCC2uaWFgXXHYyFjuxurxPUP4gf879oITGBO3BJ0yirEwG2IoPHU
         TTeMYgDmLlmwl36LMwWy6tzO3p930xpRXIfOuRlQb0kpVF7OcoHxHrEAXgOX+so+JXvS
         KxfHk30TE+S4BLULvZPMkMsxKPCVGlCQezRGKfBZEtRCpWA9b1y81m72meiSSblDNhJk
         riGg==
X-Forwarded-Encrypted: i=1; AL+hErH/1KMwOHwRGhdJT8hhn7vGy0n3il1L7dmbHDxWOCNSQ77inBKTOLbmJC/ehC6usIFwGzYMkm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HAJ+ZJARz6VuxoXSGpvtAzaI0sQnKb7ytJ+KqLL/8ZT9TnjOE
	+A92LA2GOVSj6PC7zuwHDj7rTgecROpuhTe73aUhF1LZhGNbhV9cAfvE+1RcIW8mO5vPxHTIW8k
	8/Jdifil6soNMd1Fuc10MODdopD5gLNlHfVABISzcYmrkgfS6+OCeY1XBMwa+VCWSyaXlkbewEh
	T28T4+Iohvk/KSGxXrpIUVTeqkx3Z55gLNxQ==
X-Gm-Gg: AZFdTZc7JS+2Ssx9ZikdUokPe7zqyxFY4lJDfwLiIAb8+c89hpuEkxMWTQR5jBZacJC
	DIAOCiDMcksyU1HOO6g4Vl0S4/2Tk9rOCVs8l4gafH7mlq+GIhPURZAgoNlSFWEAXVaaPR7RhgB
	hbyABAx1j3sW2qjk0qCpz8zeyoDUfoQ2cjQNMNjyeFnI6T+YAXpibyID7ENjl06O2QUCWKB6OVn
	O8zRYVr5p5d+d5oPzzGEOcpjrCpdbE3oUmGLJwy
X-Received: by 2002:a05:690e:450c:10b0:67d:eb6d:7458 with SMTP id 956f58d0204a3-67df44555damr2919001d50.55.1795510331873;
        Tue, 24 Nov 2026 00:52:11 -0800 (PST)
X-Received: by 2002:a05:690e:450c:10b0:67d:eb6d:7458 with SMTP id
 956f58d0204a3-67df44555damr2918995d50.55.1795510331414; Tue, 24 Nov 2026
 00:52:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
In-Reply-To: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:52:00 +0100
X-Gm-Features: Aa3M54rFHqUJNXQjemvxf-Zt82SGX1HKER8XMMPmIBzLcusnrFpbxg6otAaKEJw
Message-ID: <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: sync DMA memory for the device before it is lent
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5fHUu2ry9Yrg6fWjd_B3QYUcdW8kdIFx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX+9Wb5uc2GpYc
 /iyiZpuSdMGttJVSUDhoiK0jWBm8OGVpw8FFeX77SvmW78QIIAq7FT1VHIlNDHyWuFosQBvXvDj
 E9vPuoXdPBgf1jBRn3Atv5afWQyg1R0=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b05503c cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=6jbKIeu7AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=i7LB113YSaF0UBaY600A:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22 a=-0VUF4iAjVmhXKmeMUOz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfXxTRQKKvUTFaN
 PpNQ/ktDAcV9o3RGOZBOIsyI9DvW4d8vAs5qVpBuTNvLAjBI1uct6y72ehV6SEKEkvOXIDPmh9Y
 VRyLG4nGEvLpd42A9oe8R1wQLsEsGGTm9MaFZ6z6uhGkGQ8FKjHlfEqreVG+I66r1xOpohRYRPs
 WSV3yh+5k3ueznyQo8jmTRhHkvBUCsCjD9lqohyUcmDYSjujVET2L3fmF9r5/Sh99pGi04qoPyA
 BjYt0jZbyIknTBb7JvNjnMI6HSM52g7DEV6tdHpYPwVANl1yH2JG9tBeyTt+HJdWg/y5FnFngZi
 YE5KkhfJ4ki4rONrMyOt0FlTttk8vnFiOD/P6AhZ8J/tY2GW4f/7h1+25gkjPBsPxUHtJbSAUHe
 BXbCoSIagrayVTbcXbXg+qlnFWy2W5i/HvLlIuFD/zWtjoxN4lIHX4tX2HfHgVkWvJh//hJC5Iq
 XDQ/uEAME04H13zzsRw==
X-Proofpoint-GUID: 5fHUu2ry9Yrg6fWjd_B3QYUcdW8kdIFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034

Hi,

On Fri, Nov 13, 2026 at 2:22=E2=80=AFPM Tyler Baker
<tyler.baker@oss.qualcomm.com> wrote:
>
> tee_shm_alloc_dma_mem() returns dma_alloc_pages() memory without the
> dma_sync_single_for_device() that the DMA API requires before a device
> uses it. dma_alloc_pages() zeroes the pages through the cacheable
> linear map, so the zeroes can still be dirty in the cache when the
> optee protected memory pool lends the pages and a Secure Data Path TA
> writes them through its secure mapping. A later eviction of those
> lines overwrites the TA's data.
>
> On an Eliza EVK with OP-TEE as the FF-A SPMC, a TA decrypts into a
> protected buffer, a read of all RAM through /proc/kcore evicts the
> lines, and the TA's digest of the buffer no longer matches:
>
>   frame 0: 0e534d8c..., reference d98ddba1...
>
> Sync the allocation for the device before returning it.
>
> Fixes: ab09dd6d9201 ("tee: add tee_shm_alloc_dma_mem()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---
> Vincent's direct-map series [1] cleans the range in
> dma_zap_direct_map() before the lend, which also covers this when it
> can unmap. It returns -ENODEV without any cache maintenance when there
> is no lendable pool and the direct map cannot change (arm64 with
> rodata=3Dnoalias or rodata=3Doff), and it is not a stable candidate.
>
> On a dma-coherent TEE device the sync does nothing. teedev->dev is not
> configured from firmware, so it is not coherent today.
>
> Without the fix the TA's data is lost:
>   https://lava.infra.foundries.io/scheduler/job/554467#L2262
> With it, the data is intact after the scan and 50 lend rounds:
>   https://lava.infra.foundries.io/scheduler/job/563840#L1979
>   https://lava.infra.foundries.io/scheduler/job/563840#L2008
>
> [1] https://lore.kernel.org/all/20261111110738.872947-1-vdonnefort@google=
.com/
> ---
>  drivers/tee/tee_shm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 5c47a36916c45..70a273a425f88 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -297,6 +297,9 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_cont=
ext *ctx,
>         if (!page)
>                 goto err_put_teedev;
>
> +       dma_sync_single_for_device(&teedev->dev, dma_addr,
> +                                  page_count * PAGE_SIZE, DMA_BIDIRECTIO=
NAL);
> +
>         dma_mem =3D kzalloc_obj(*dma_mem);
>         if (!dma_mem)
>                 goto err_free_pages;
>
> ---

Looks good. Sumit, do you agree?

Cheers,
Jens
