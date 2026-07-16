Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75D28C869
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186862; cv=none; b=RFFuSAbscKRANJZHKTQ1/1k3Ly7UMMran7m/73KEuRnUOwoH9wXTSVN1SY3Zuvqfqy6Wzv2S4QxOu2bUjFb2WzV9UdSiXcEaaz4x05FKEtuTY7+3U7M9/opUUCAc9VYmcNDBh5q03eGJqeAHU447H4DBwZ9KKF3SUf3JBwBkhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186862; c=relaxed/simple;
	bh=AKpy4pnIDwSZQN/myaZIK15rW6VRJX80vHJ1H8+v1ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU9vavReZK4CuQLwqvIYOM3+6DeUvvXSFe0bLVNzGfopGWcjbExrRqgkNxCRxIUBPyMyrDinqa+J3QQTgbH+wGoeEcjFphyHTiROKMY0OHhF/FHHJvuM8CThGK6d3ZMPHYqr0zx4e0Lw+0K1eL8VF+6w7ugpQVt/nBHp96XaPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX/m6RZe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoqfsUxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX/m6RZe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoqfsUxd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DpiV2011951
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bx9Xs0p7V4nn88GnuV9d3SGR
	DdrnnmJ7s4DaIuEh7P0=; b=XX/m6RZeFQsgLhOnR0lybETLbDxpJzgBK3zY05Gq
	uDQyKM4T5GDvl0gJvAmu4h9lc3cvXOWxYwRMkfClWsR7GzUcvc7FQzwMtp2BeCzM
	5laO9EXvfmemFPz//MQtzvXY0rc76ErRpE5KsUFu/g8FM4fj68EUiek/0IkwyRya
	kqzO1lw/1kcESVSDw6oxHxbBpyrOQsrg2L7UAbKNPbDs+TJae+DQgxKmy87g7yAB
	FlhvjPDufVyN8mhqhVVvKsEYSix5lqxBrV+saIC8P9jqHh75qw51lBikGIABwh6j
	Za1Add4icEEb/KR3s4kMzczxS+NyEBGh2227Dk3koPxbQQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q64gmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:27:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38869800848so9685539a91.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784186855; x=1784791655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bx9Xs0p7V4nn88GnuV9d3SGRDdrnnmJ7s4DaIuEh7P0=;
        b=hoqfsUxd4OjjJckNCGcpeJi0bY/gEVHbEHAvL1umvnceTtEX5AR265Lr7CvxsItSNp
         xXjs/40iKEAYw4cq/3xLRhpxz0Se1FiIbqvJGAxo0taxHNexQSQU0EfpI1e6zbp21Z/K
         dR+zsCU87eaf1B4/sknXBYwLGELVDFuMXNH8B7vnlXEp3r37EOAlLFg0hXSz8GrIT+np
         n29LUY+wSQZw7JkJg6QyVBHg+798uXuOISFR3lEg7Bdsq6bc2MRc0UQSt1paRGKFrGx/
         nY+XkfIPm0Pvc/pew3MiQdnrTJH0RPaCdisb/etCe/NfJ2zcxj/UKbvkJK1XrL+Drp1b
         +5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186855; x=1784791655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx9Xs0p7V4nn88GnuV9d3SGRDdrnnmJ7s4DaIuEh7P0=;
        b=WSEuW/pqKXjfGY9FUj+wKUiSjPu4C1HZmcZKIecWqLg7rSJR9QBRQ0052gh3jyk+IE
         41/sSWuazETPMRTT01vmrGOcLlP9B9huUYdLRIMdQkyTuV/flSV7PgD2VT7UdtUcWVsX
         H+i0Xe8X64H18BBZpsBVsNt7gRGzmParyzO0dE2vBNABpUbTXFtTowzf8e5PM5db3hrA
         tUhdDhhR2yvRmni1W6LK2+Uw+yYpMc17y1BVSOUF728VmKnhlt/M4fyIlOk3n9M/zCSj
         iUQ7q1LObHmD6HLKwabuAsRFQdnrQ+j3hVPdY11q+Vbpq+QX4RVZj51vOSXuwjXQXKZ6
         UYRA==
X-Forwarded-Encrypted: i=1; AHgh+RrPQtlUUX49k9V134bouoCj55Q7FF+oAO/Sc2n+HsHLeNs5EBbpRaEhMpM2K79Gij9vLl1cu1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjPnoucBfPMfPbLdA/nNRQSgvP3t3WrBRTPlisJ9CSyoq8VWl
	wo1yi5Bgu3VZc6OESIk+yNyphCGMvcVtilsSDylatxZCt4neUaO87UMvhKi7uV/CCqFAfOqzw8z
	2u+NFipwIOXe9RMecHG9gIqdDLPGvGRT4JUuIFsa6uLAoDkGtBpJ1Wq7yqCK21h66hww=
X-Gm-Gg: AfdE7cksR93ztLLWdvRi2JoOs5Wblh9aNIFF+3d/LBux52SA2/zsQCfqEZunyTkyv3P
	+fa1YprD1jPxRjjEHGsEcLE9eaiNgSo9q2UxkohifD9wuMJD3FDyE77Sx+ovz2GBpEfopFaphlu
	zHJvO1LflSbQViWKy9ZdemQGwePXLdW57DoWG7bpOrR7uOS+cen4fYOy3cfvTVYTjxxMhSv8Ce5
	nSYzpzvLEoiRa9mwxp7den/O1lCAP5U89pqb0zopi87I8/3fbwHCT7VeuxVyUMdwqagOdUPAJUf
	4F4t0XLVZi/NYBCyhGZ9a4YyzcPhd7QV/YG09uMpImNYIUIf4jqcEH8WPJNxO/TmWOJTjvAnG29
	aFT2CiHS0TVotWAwCbAZ2W8kJqbQ=
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr7365600a91.16.1784186854614;
        Thu, 16 Jul 2026 00:27:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr7365580a91.16.1784186853996;
        Thu, 16 Jul 2026 00:27:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6f0fcdsm8559669eec.30.2026.07.16.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:27:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 12:57:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: robin.clark@oss.qualcomm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/msm: unwind probe state on registration failure
Message-ID: <20260716072726.njo62a2xbaum43u5@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716013229.91014-1-xiongwm2026@163.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3NCBTYWx0ZWRfX4obnWYl6FlL9
 PTaSFW5FRBcPEkz/A+7hlbgyTxDVmMCAIv0AcnealjS1iF64JvC3mqFEVJX8X1HpslLIGqComXT
 prtFYTJeoqAdkJ7c+wGACVzC8BR9/k0=
X-Proofpoint-ORIG-GUID: OtMOCTvBxBVwnHxfa14pU2jTwzGv_e97
X-Proofpoint-GUID: OtMOCTvBxBVwnHxfa14pU2jTwzGv_e97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3NCBTYWx0ZWRfX922v8di3Wh3L
 0EL7js5g3KaUS+VN40t/GRjA4mlrD6lwPua5mB3QpMJnV/IoY7py5IR9GI/5299D7xp+EATcJCl
 hZrEJPtA6LXyDlBNF/7E8yqhHYf6ZRN7WVDhaOMzVHEoE7TMQx+KsEV6k42HtSJDnfD4vZiwBku
 su/kTdGQY/TGTI6/J5ZM3MmNkW9UVmjkL1EsN8jzait6sG6wXkd9vRmYD0OUX0LWq4/NZ++wNsF
 tWMLYGX6lcrJIGQVR7FEi9u2n6eP9rlf3oEEIu8b0KwyscbTGZQv4G7Mq2jtmYykgOAmVmu8ym4
 HZguoBVMC8i/UAhXmNuulQrntHDTeXIJuehspj9panwq+Es0dLMbjp26O1nT4Bg4xOelHpZYXHq
 IZdS4gaqUmkhHFqtSBOCrje2nzeulXnxJaIClj/4PDt6fAfpA1N2jE3q3XXi07paoIhUUap+rXU
 GAMY7+ffddE5KdWD8hQ==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a5887e7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=a8LOBI3GJTFK-6nigkEA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160074

On Thu, Jul 16, 2026 at 09:32:29AM +0800, Weimin Xiong wrote:
> msm_iommu_probe() adds its devm-managed IOMMU object to
> qcom_iommu_devices before adding the IOMMU sysfs device and registering
> it with the IOMMU core.
> 
> If iommu_device_sysfs_add() fails, probe returns with the object still on
> qcom_iommu_devices. The driver core then releases the devm allocation,
> leaving a dangling list entry that later list walks may dereference.
> 
> If iommu_device_register() fails, the same dangling list entry remains
> and the sysfs device is left registered as well.
> 
> Unwind the sysfs device and global list entry in reverse setup order on
> the corresponding failure paths.
> 
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> ---
> Changes in v2:
> - Resend the former patch 4/4 independently; patches 1-3 from v1 are
>   dropped.
> - Explain the dangling list entry and stale sysfs device consequences.
> - Add Fixes and stable tags.
> - No code changes.
> 
> v1: https://lore.kernel.org/r/20260714060930.220277-5-xiongwm2026@163.com
> 
>  drivers/iommu/msm_iommu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0ad5ff431..d0d926be7 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -784,19 +784,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  				     "msm-smmu.%pa", &ioaddr);
>  	if (ret) {
>  		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
> -		return ret;
> +		goto err_remove_list;
>  	}
>  
>  	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
>  	if (ret) {
>  		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
> -		return ret;
> +		goto err_remove_sysfs;
>  	}
>  
>  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
>  		iommu->base, iommu->irq, iommu->ncb);
>  
>  	return ret;
> +
> +err_remove_sysfs:
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +err_remove_list:
> +	list_del(&iommu->dev_node);

IMO, this can be avoided if we move the list addition to the end.

-- 
-Mukesh Ojha
