Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D983D76
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957727; cv=none; b=noynyql2t8MArp9e7B67aA7DphkR6t8mWx8AC/dFEWoD6DulOfYDehexb/NrTqlPJ+4p09sLjf7Al6i4tkgdKjo+Nj3/ljFfFXvcdFEYERqaxUc6xyYKvkxYNtMvU07b+8GwF0wjIA//Y2dp5+PBZvRfZmsyy558BJGvoFIQhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957727; c=relaxed/simple;
	bh=stLCkYxJ6QOmDpgV06/UDcu3jC7cDAcM43Ynr6QCEtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9t6QdBGV+WEUL62Bkl7eT5yrYd8fNdVwJIr5eY4BoiyFVcD2ldRYQ9BnOkGJ8VBsqmvYSjfBhuPgB6UIhUCRgmF1Y//0K14CQQqtFP0SwzGNJpyyZZX5vs0UZN5gFWGPkIPoW6baGGbtTNr+EEx9ZNCGUkUMMer5+DAQpke/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B865agWi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMEyvYvD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B865agWi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMEyvYvD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FGs2x1246617
	for <stable@vger.kernel.org>; Fri, 2 Oct 2026 16:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=; b=B865agWiG5xspc+w
	WgWYYTqo+iTDyWJshan7tS/0iYYuC8lGR+4kwt/DWsWZKIa795pZF27cbe5MihjV
	HKaFySRImpS6J/rh7LLasYujdDcU8h7L76xmVtGIV+LiEUsfI1vzif/j08NMiGiO
	ckIBOi/xvfPTajGZ9z4IsoXv/RugnUSLiX4rHydwuqwFU3iFLE7+SRQb4d1BYK9/
	gMcyCvakdcmjBUnO0S3tcfq9+xHDde4iH4Xn/R0Id6wfWLUwyBJWeieCyJoxEpSc
	K+VEX7rPjVS2tfVizRj0Qzek4I/lIo4liYJSRTIDAhxPWgAd1j2HLjtRfsodcsWy
	OZAQfg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d89k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Oct 2026 16:15:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a053dcadso83855a91.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790957724; x=1791562524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=;
        b=IMEyvYvDnWhIiVHrTwxNI2rWPoX30JrPhgVAkAxTj8lNk0T+FhDIMuMKR0FlzhC/LK
         ZiKcTIVqtf5PNCyLSrwmr5izzZpsuw24d9E9tDjxjOziyORkiOvqLqnLJ5okL+2qQRan
         tRLyU7d1rk0unp3pvvDKvrF1ZaR9Z+k3am7ERNRKlledp6tPG+a2A3Q0syGWVDQziO1O
         jsN4v9JzpEfVSugHROYE6YZ3edjXhm/QpMU/0qKN312fWFiN6qOqvaoHo+GSRBLFyM7S
         QFqb+aVln/FTUteFQGIeYxeaO2PPq6zt1W1iGizZ4GZE4/H6e2uk1pCdiP3Wm5/XLfvh
         hJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957724; x=1791562524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=;
        b=FQ7YoCEH1KH4EMylhFbpIIR+oGLluTDRzdICCm4KtEV+rRHsV81Cs46TgUYng/RdB+
         S9BmIcNquKB38dG7+B93rhzC2CAWGqey4N1nJr5+Iq1xYX64Ax0BPZf2yESmd/hQWSt8
         SYtaZW3N6Bj9x8W/kXAHBE/7lt3l7YaxAqCNHuEmWSrpYBnPAutaXfhMaYgUZbV7xDbB
         RY+6ZY3x9uZy9VcQbM2f9xTUsJXgeC8snpWKnC6wLstoYIMxQRB6SWHZdogRwmiMvQqR
         uiwFlCQ3E7E2IasxbJpluePlof2d4LENa8xJhdyGRYZRZrb0r0Lizrr2D8H7SS1ZAUBI
         ipGA==
X-Forwarded-Encrypted: i=1; AKwUvBygMC89pbeOeFhx8PHKpu1z0wjXMkcm3Bi+e3BaoMV8HhjtRc5gXSObZjq9UEPbsBmI5EulcFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeJF/cmaDx3qJIODCfwf991xzsYVnAuBPC28uOHDQKp05FRTVM
	0Nzmt/QgjXQEcH/KvQa0bXmaKKu5HgmHxifdYubuihzAVWetGyCgvPW0zdXWgsWigQATjGBQSni
	tYQ5eVPlw/9apNehavMUFDqdiMHsAx6EmfBmHr//Ubo7o1XZZR4zmWhyIchM=
X-Gm-Gg: AYBFou0ppoP7xjvh9ySE6NofR60mcEVA9LCf9zvpVgypL6d5xEOWcIQtWUX0FL/Astb
	XZLrXKIPeBwjgwXEFIEjOhODKPysWdvJLFo9izHpOt/3YElO+Ukj7gyVI44LK0ZPPwe3Fld0YS+
	6qWFu0XL9mUnYhi1NJZEKrydVfMAS2BxeSrXGZLQZHtslj8JT0mpwc9qHiM6DHj5BgOgKV8EMZz
	MxCTUNpuuZJ0CBhSS2UEw1H5ZMoISwS4Z9FwzKmYB2AgvD1HlzAhPaVCd13EddJyqBjbDougDHv
	HAZOqBYGcYZcZp2ooaANpsCon9akHa6Mqc3867moEkF1gv9MBmATFj182RqLQ5e9evbjQB+f1PW
	y/ZFegrNEeq40z8HB0eGOY0iUs8A8533PAvrYFX9ycLO+cZRb5w==
X-Received: by 2002:a17:90b:2804:b0:3a0:50bf:d497 with SMTP id 98e67ed59e1d1-3a6ce5fa39dmr2940507a91.3.1790957724404;
        Fri, 02 Oct 2026 09:15:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2804:b0:3a0:50bf:d497 with SMTP id 98e67ed59e1d1-3a6ce5fa39dmr2940474a91.3.1790957723876;
        Fri, 02 Oct 2026 09:15:23 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7384ca1sm1221797a12.21.2026.10.02.09.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:15:23 -0700 (PDT)
Message-ID: <439f1169-5fbf-4d68-97e3-c37f31b2116b@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:15:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Cancel Sahara read data work on removal
To: Myeonghun Pak <mhun512@gmail.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
References: <20260917192512.56205-1-mhun512@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260917192512.56205-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LkOZ4sr0hfYSxYL17ApCJEECKr4AzDw-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfX2SW/6SiSgJFZ
 3nxkvN1scqK4XsgEb7HlaTICBeK6f6Fkc+P9Btz0NlE9wV93RpOYA1B4L7u/boKS3nikZ6hJHOS
 Z2tGSU2CJivc2+BZkehch1e5+p+rFfg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfX9ecrmvvfMbJW
 ql6IRs+7gsBIcVodU5dlLRttZgcDNFN5XRCBf8So6RDGMB4bwcw3YUCofwhIepOTJwkxrpeC4iV
 irzRhFnE0DOs04/2rtIGA2CIYo2dRLuwDsCUW7BVFVJhxycBnzpLKA6Pu0zVH1Xo6CLpipQTuD7
 4EIbKzeldYeEIFGeZO+G7w5Nkz9jp5Ot50CI2R1JAMJPrWWo2p8xpEJVyDmve1g5m5HpPkk3ZWz
 S7oXLeUgfe+l0vLSDY1uUl/RSiuf/4vOg3lG6LQmRk6lDYLH9X5fQSKc0uq5Vf0969ilXFY7vS1
 7rvCCoVm3/zhRZTwG/4vMB3cT2mQWBKNGEBUJ6AO3eKy5AM/6GcAMYot+Yczmz6M6txZzrsd8OM
 mBrSFvKytbf9ry0wyzsT1l2V0vd3APpfJUdsIwG2H7Prl7JJKj1N1FpfakHSvc2anQdcDLwwLJv
 iMSFBYy8c+hDANB0CGw==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfd89d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oeivAFFXM94eOaBaf2QA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: LkOZ4sr0hfYSxYL17ApCJEECKr4AzDw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020064

On 9/17/2026 1:25 PM, Myeonghun Pak wrote:
> Sahara removal cancels fw_work and dump_work, but leaves read_data_work
> pending or running. The latter accesses the firmware and the device-managed
> context and transfer buffer, which are released during removal.
> 
> Cancel read_data_work after fw_work, which can schedule it, and before
> releasing the firmware. The MHI core suspends and resets the channels
> before invoking the driver's remove callback.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code. The same omission was also reported by the
> Sashiko bot while reviewing the Sahara relocation series.
> 
> Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Validated with static source review, apply checks and strict checkpatch.
> No build or runtime testing was performed.
> 
>   drivers/accel/qaic/sahara.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
> index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..6487961bbf14a1c284caf91f500968b90a064ef4 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/accel/qaic/sahara.c
> @@ -879,6 +879,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi_dev)
>   	struct sahara_context *context = dev_get_drvdata(&mhi_dev->dev);
>   
>   	cancel_work_sync(&context->fw_work);
> +	cancel_work_sync(&context->read_data_work);

The typical convention is that ordering of operations in remove() is 
related to the order of operations in probe().  Adding this line here is 
arbitrary where it would fit the convention better if moved one line down.

I'll fix that up when applying this.

>   	cancel_work_sync(&context->dump_work);
>   	vfree(context->mem_dump);
>   	sahara_release_image(context);

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
