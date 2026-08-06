Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3441BA94
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006174; cv=none; b=UK8ajCqwu8TLQfc2FzCbgy/gWAW24GKs1KH1hqhScbbQPZFEX2hVOzRqdf1OAmMlTlcZypx4dwiuXVQ/t9bgrT4aeX+fETF4EXAWkjESFsEQpJu5hT+LQ5RpccckF+yb3/QMSTigLJf0HIIJEM/nbwAVATa9u5mR4biY0+Wu57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006174; c=relaxed/simple;
	bh=KhzSMHpkl+T0k3/D4bj/TXm71L2GvbGLt9WmQapRokg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryr7cALt4o5K1FjBOweJ05TlXu5zzVFZ53GgEhaIVwRH3SR5rvRKXUFgjREfY1izdwaWs0gJZu+GnJTouIRKmJmgpUbhyPdepeHGOO3QoxKUqc/4y6FQ843jxeoleoC7pnQqJ3XrSt9bXPweCD79Zcor+CpYq+6tAX/p6rETEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTpkEE+Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDqJklcd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTpkEE+Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDqJklcd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763wu04482392
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 08:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fXWx2kJuD1txleNLiOTk7MZh
	NagWXN9ujUDiGfg4Op4=; b=hTpkEE+QLyetKxFDc7Z1I1UwO5H/bsHl+/Zj+H6w
	SNlZ7T7LuE0PuXG+sLgLbbWV1bScdilkE5ru8hg+niCNThaA0u7pv08eBEQBe8jy
	3VWpnssSwdSXO+flBX1G3DbZO8W7UZIIKCNTpkTTPP133Mki19FDAKlLe3o9qa7h
	9OJ/mos/LyYPYIsPuDutRkmJIlLKyVyCCB2/cTLAeV39GpoAyYNktNAC3s4FhsDQ
	nsWYMAuEKVpgJpTwaiDYE10X4yGHVTYkdM1h5gLUN2Kp/FrgRgWt+oTHgSNtunEo
	Dem99xo+SjV7L/O+ZbBKgxk0+H4FWwZosjk8xXmIKluuXg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjueh42n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:49:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso20380156d6.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786006171; x=1786610971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fXWx2kJuD1txleNLiOTk7MZhNagWXN9ujUDiGfg4Op4=;
        b=CDqJklcd9itEv4dd4CyZz1w7+lIkSb011DXhlzaINBC3m1LTAlTBB99rZTOrbphhrj
         Sux6n3hFk5mluIUS1lYBuooVo4Og7DoLLKaie48KblsTMzUzyMd8XqKifvhSeuT+3Qx3
         EdxclpIgr4483edKjtqy4vmZKUqo1L7YfWrM8Q16U31nEoeDgxbog7NexOW5geYaHwkj
         g4r0yVX1/J34uQ/um0TUHvawVGSgtnZTCFTLZX/H9TSba4STrZ9YgWYJKewOCJpHbzHq
         kCChIZLF6/sGgl1r8dXUJ03p38eqVopRXPzEqAxfcgGYPTERcM4bBXZ5/VpW4QKW3mN4
         AaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006171; x=1786610971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXWx2kJuD1txleNLiOTk7MZhNagWXN9ujUDiGfg4Op4=;
        b=T1Ht9PSUkgVWfogc5Ny/WTrND7J81ZKuKhNiHJfg717Gg1FmIzFi+CF9M5T0sIXK/t
         +naagFkR5jd5Ke1IjwxfjVV3za4r4q21y0PFHh7ngf8bHvQwwOUvjtuD100lIs3ZQXAG
         HAf7WdQuPCTwb8kWr5Q3MVMexi7eZHT+tMTaT+gyGZsalQta7TgXHsOmEuZTlaeq90cM
         4TL5ZWkM/86DvGlPof2OwPoJsP0nHCXBG4+dIXFmRUA3/kkOoo/e+8R1mHgK2EmZB7Ay
         lcN6ZDoNLnnTeL89gVxY/6D1neXf5AaRTKWwch+X858X27hmVNjpmbXY2JE0ULmqafAo
         ISSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+BXre8mNEDrovxLukrNEr3xRNL3wbo8NMEvKcFA95+kpLJbhMV20vDO0R9mpksJA9dXRMgqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9DkGk3yWutUtk1765/TtGVzAgLREUweGQDMs6OJdnDTFtiRb
	Ck/XJVhaCldjjLzbkAvKxGPtPWae7X6HgMiKHOK9SPDAMNfnf7SqIGFZOw9BHgco3a//NDl7QCO
	qJDg4p4d+ADB78dqwNCaCQ2lvofJbK6/ogLUqiDrtjEqPDjw8JC0J72Wndls=
X-Gm-Gg: AR+sD10AknD9S+Mtx+Fi4C1b9y7XDFpDMhsG1KJOTUyXN7LELafiUhcMBYMG6OUVL3B
	vHRrqrC8w0FX8gfz7qpbLVeOXDtlZ7h88KET8Tkul0EQMk89nXDxGmDOs5b46AKwwrr0wvQwPd2
	FqVmI68VAG/cXj7Euk6M5mpngG99qL1adwLk5DdeUHql7XenT8r57MAa3uXTGv2mMtND3UXh5cs
	aH2/hKM9w0A/doJK9cQhwtLPuKvS4r77xNLjvPda8DEFOqOaxibPwIUAWVUALoKKUHcUzF/+ij6
	jVREzTWQbnd3aJ1gdKMvLs/VcCu1AjJ47kDvsIo19p6+lXCAdsB6jz2dRegRmmpA0zjKUouryJa
	UmGKrw2qKxUEBmA7yZ8qDx9NYFSWvDpHarhRaIk+qXYk/8DSPD9osE7coFzT7ia3n7lzLoU9SLR
	PRCm1OPgqa+hxzwQ==
X-Received: by 2002:a05:622a:587:b0:528:38b1:b54b with SMTP id d75a77b69052e-52ce61016ebmr130093431cf.20.1786006170620;
        Thu, 06 Aug 2026 01:49:30 -0700 (PDT)
X-Received: by 2002:a05:622a:587:b0:528:38b1:b54b with SMTP id d75a77b69052e-52ce61016ebmr130093181cf.20.1786006170210;
        Thu, 06 Aug 2026 01:49:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f6235e88sm588382e87.11.2026.08.06.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:49:29 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:49:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context
 bank subnodes to common schema
Message-ID: <xusr4efn5dmsvcs2hl5vg3t7ctqbbchnbdx3mx6km5s7s3se23@mzzqs54lp46l>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a744a9b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=jXNH7nskYnz8vVHi7d0A:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: zhjN_iNPoyudc2qJahUKsadF7X1Mr0on
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2NyBTYWx0ZWRfX8JW2LRbnANBg
 B524FEQzGPPSXI4hORVYBUrNKVN7uFxdDUFDhvJqWuojmFSbDVZcaNE5JWejc6XHFmIr0vqwzpP
 cVtzUbyDHqoopnSxZIo3nM8lgM8S8rEcFx56JnIdz7n03RWhM9aVYx8jFSvq1Ou1vYWM7s7QLxQ
 s2P/3RIg4FqP1YoTssn0li/SkEbMwT8S97vg22A7mbE4JM+OarCcU4lRwS+N/Dhy4B+h2cybCqB
 XndnBVZLanS1IJgjVoix76M8YjEHCrnKQTFTf0rrGWw3wCo9xVr+ArUuyajQ2BBeGQ8V6XOW/pQ
 sH5V1Gwo3QplKkDCWVjuNbzzf7GRO5OxwQuuw4XnOcTbz4UmyNeMV6/4cl4YTbnnqa9LfwMwFTv
 ozZTosdJWM8uMF++zga1WFyIiSuWcGTo1ucwYY/KUsTmkQFQYGtIbjLRU0vxaqkljsnkc8Xm/+F
 t9DrdTYN/y8W+tTlwAw==
X-Proofpoint-ORIG-GUID: zhjN_iNPoyudc2qJahUKsadF7X1Mr0on
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2NyBTYWx0ZWRfX4tiqtvaY0jym
 1Q2+IFGPkvW3Os8ewszZ7U64Ncrmw+0Ihwfq6vyBBpTgfCB7j0Khjz5d75M9t1kMHOZpxYTULll
 e02HDo/84RF9+s/2aYt/NR6JlErzNhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060067

On Fri, Jul 31, 2026 at 11:52:16PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> is restricted to use 0-600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing keeps a
> non-pixel buffer inside the low 600 MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
>  
> +  dma-ranges: true
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2

This would conflict with the 32-bit addressed Venus nodes (and it will
also break examples). So both should be just 'true'

>  
> +oneOf:
> +  - required:
> +      - iommus
> +  - required:
> +      - non-pixel
> +      - pixel

- #address-cells
- #size-cells
- dma-ranges

> +
>  additionalProperties: true
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
