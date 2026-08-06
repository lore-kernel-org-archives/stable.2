Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6047886A
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018225; cv=none; b=OW1BfrU27cXjdn+iPNeX5vAendfcTlkC2AY3trlYPtx7BjnsNN9VcXtvjKsKyy8b6QqwTlGJ2NVTlQPueBDHkXJp+Qxbq//BMt2Muhu7Lu+iQ9uaYFbueLw5y5zaN/AyC1TfSV2WLi2XfSRqGh1T7ngSwsu63rE8XOz5EGGw51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018225; c=relaxed/simple;
	bh=epfdEmdQWF1LXChrd7bCh2YxTWsAOg+WkUubgRu4MNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0tk6dwFKpCajbZXtFYaE+NFM8YcOWteHmyI/15xVg9mHkQrmHDI5/P5derDua4ubkqEY87bHHbz/kA7zlhtnmLmjwJK71IQqcrMM6xkbimKKLBCe/nQHTiGqWG6kWW9nW4osocNcS4reAVfmHgMeSzppbD1NkDgW+HwdByCa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+hgvKNJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+0Iy3y5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+hgvKNJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+0Iy3y5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nr5e1228396
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 12:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rEBv5mbQUcmm8dCs+CeVZBi1
	W0eLFbJkEKta6P6jcRM=; b=R+hgvKNJFn/qo6+lLddsRTcAHQIOHY/RCzW82gto
	/AlTj5Omt20bsLW/TOfBZMHVcEfZkis7bC1XwME2vl2BvebK9nQgb0UhB3oQ3y6k
	QkryNJtAn0iNxdgKBgHGrogLlSrtIxqJHrZGR/pG01BC4PADEQJoEFWp0UZXBAGC
	adFDJ1mV6QZVGP7GBfilAl5dbXLE2zOZl0CxFYQBrXYL6gYCXZ+lAHMosY0hYu4+
	BRlWBsfIY4vX3IRuRtAUNGWhGwwtR+pZrNWtEGCl5GshVHkhWcTO0yWJUlk3Jdy1
	H55FLsbjZmiDqAew3t9NeFI1SZKldklHD907u9qstCEN4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvqdugt4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 12:10:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so23818381cf.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786018222; x=1786623022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rEBv5mbQUcmm8dCs+CeVZBi1W0eLFbJkEKta6P6jcRM=;
        b=F+0Iy3y5C0+Rvj1drv6puE2w4U3pxcwOHTsuL0xcj6kuK/PkiruHwfnsnMgsVnrpWk
         CWxWQU9Kq09j71tlpEQFSZZNG7JTeSbkvAq7CCmutf0gzt8RxS2rhaAq0xCcMZl6ux9I
         u2iZwh9Kwk35PX9xSbOwgksy5RbwTB/PkcqvG9a0O/AesrptpSJHK8SDiPI54k+rk4Y2
         OWmMVpKYD8YsA2W8XvI1aie5bbdnet2al5ox74OnTF/VyxI99LCvicxevHI0GUPAHzzN
         TlkUYJwbiGwJz45x8AAzp42dzIn/ImXPA9tBj/KlovHJYlPegCSQs8u2Yvr1fKPs4wHT
         /2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018222; x=1786623022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEBv5mbQUcmm8dCs+CeVZBi1W0eLFbJkEKta6P6jcRM=;
        b=LFyKkjrHufGI7jV6R7/QMth0luvsX8JYvkVEryMHmFkZ+k5veabH/Jcz9STZ/bG7xf
         a4MSeE3GFMce1Cb+U2WckrN0mWPjLn60NzFiu24Iu5Ur2Gr9lefEswEEtpNEwZUZJ+Og
         +1caAdFJ7/EH4W6WR8irDU32zcSSwX3W1Ep4N9TyGQz5T+SViM+GPJ6AlqbqZCFPTNog
         DyG+Xm4g1wEslmbgTTJ/oW0L1w9qh77s3o8TMV0qwjYiFYVnqR5BQHz7GfOVmyfRO3Hy
         nvIXUkKJDpRqNvJl0nmCE37IfADZutGgy/5iI7sOzF8GcKAqUW01PxRFt+pycMb1NYHC
         Hxxw==
X-Forwarded-Encrypted: i=1; AHgh+RrewIGuqBPtxSpvDKxFdZcvHcmjQYfmMag3KXiuVdmEciBuTDrRLlG5MkPm7NpMeZI0xP+Ww0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiU0CHj8qt8h0uAKTdHjrwnqMGhF1NqRYib8ThVDljoTitPMxk
	EEppqVCrgota4/49ZrMtqOUFKa22hQ6z1IjNMpNEj5iMaoW8oKM9GxVQ+ODmm5n21wJwV907MBi
	ipkld2vup95V/Y8RyFhYu2kIAJloHvYsnHYy6xFzSMxwOtD+6bcSs/aY1raA=
X-Gm-Gg: AR+sD107YQ2vAs77yeQDokBzSB/91eQKf1EQNRX0n2gkpXQF9pEuSyxYIz69/dAo8uF
	Ryx9bMHCZDXkCe4hBZ28D2ueY64mhSaHwoj1cwPUb5ujqSKWt3+DWq8ZA7yq4qR2/QXnQZ3EdE+
	UNXHE0u4We0XpXINWFmPvnwka8iKOOGHXaHEZe2JFbuRrtOTbC8st2HOe1bxMXTGt3zFMVt/bkM
	rCXvo4IBnFG9Wd1VifqUaYyJsT74dJMiG6YICq4M7AbiM12pSFjEXmZNjfB7tN17/F7/2CRQt4i
	OlOdpzopte+KvWj/AKYmdGoFolJpVMFjD1sZrvbc9v5mIZpszxv7WONgiUbcyiFKLxfjSssKrFN
	IO9y8kNsH417MbSLVqGpFVW0++dfwyZ7PDXOrZAcd9GHkh3M/Z2DyQNtUxcsSmAj2/oYz58h9tO
	rNKAK9M17h8/vKcw==
X-Received: by 2002:a05:622a:1ccc:b0:51c:9b44:c59e with SMTP id d75a77b69052e-52ce60d3fd2mr155473661cf.22.1786018221992;
        Thu, 06 Aug 2026 05:10:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccc:b0:51c:9b44:c59e with SMTP id d75a77b69052e-52ce60d3fd2mr155472761cf.22.1786018221498;
        Thu, 06 Aug 2026 05:10:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f62af4d9sm675938e87.49.2026.08.06.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:10:20 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:10:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
Message-ID: <dpyynzha2vkpbzmhspeinfe3yhl5j76vrtlf5vhf4dbm3tluzh@36qp6slwsfsq>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <20260805-dark-voracious-jacamar-6aae4c@quoll>
 <7a546bc6-a2b4-457d-ac27-05fc1cfe17f5@kernel.org>
 <m4rccl6zsdzmkzntc3njv3uczcppva3passjr5ukmru5q6rylx@wlwha7ydttfp>
 <163c24ba-6b78-44bb-afe9-3dcbb4d47475@kernel.org>
 <zqpgl3esozn4dgnm7remmwmquxasyc4qpyh3fgcdfblmn2xe3g@vhp5umdahvmi>
 <9921567d-4b3a-43b6-bf5e-eb0e92102e34@kernel.org>
 <npojagmk7x24wpbqcmzg4mijscqz63aluh6lj5uaciztzl53wl@ld342uighqaa>
 <d0dfd058-f0a0-41e3-a7ad-89eccd0571cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0dfd058-f0a0-41e3-a7ad-89eccd0571cb@oss.qualcomm.com>
X-Proofpoint-GUID: 7sa9T2YJyR71MS9Tt79Cq1-zLEEtIssW
X-Proofpoint-ORIG-GUID: 7sa9T2YJyR71MS9Tt79Cq1-zLEEtIssW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5NSBTYWx0ZWRfX7J9KtgCeHY/F
 3j6gHe9toct/PXE4cHXmhRKm3K2eUkPr+y6XyBMMbQ4kQWmE4BbiF+T6VETV69fI8e51hVjJFzF
 OXX3D6bY5ZVUqwvNpKL+XSDXtAozH8WjTJ8keTEQ01BJeqGq1TVt5dV/XglgKzjMfcvCMNV0aMk
 47WXEMuauSp2PKpOQOvDDXlduQE4bmUTxOFPMnmpSODBcyLQE5rMTYkB/Kx677lz5wXyzJX5sdQ
 bnL3bh2aW7f0LEV9ib1ThlgO8e8FjC8g72Xkyj9DBKTQRF8kzcFdMLJ/Y//y+xE9125NAMCqnlB
 g9qTdVXMZHV16canID4ZTmHJwkasSUhqrbpfvgTlSF4gBtwGt7hNAM+jBQSorsIf2q/TgT6r5JR
 0s4Y+3u9YrPMa0nKGFePWKHSgDq0Q5ZHwYNRL6STPFUN8sw2SzD1JOQVBtaH2klUGowrnFyHitE
 v1QqZ4Vgj2Ok330wjMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5NSBTYWx0ZWRfXya46JQpdeP/I
 Bi3bzIUpuRKDt+De5+HJyAO7UdNQi82rxPrFgP2SfWnF36S+O0FDog8RNcM27c19yBwNDKkFdMg
 k5djj2tjzIQ/OBVf1eGCP6uAvhvP8Qg=
X-Authority-Analysis: v=2.4 cv=bdtbluPB c=1 sm=1 tr=0 ts=6a7479af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=9BINTe81hO8Yagh1QJMA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060095

On Thu, Aug 06, 2026 at 05:26:51PM +0530, Vikash Garodia wrote:
> 
> On 8/6/2026 4:05 PM, Dmitry Baryshkov wrote:
> > On Thu, Aug 06, 2026 at 11:36:45AM +0200, Krzysztof Kozlowski wrote:
> > > On 06/08/2026 11:22, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 06, 2026 at 11:11:09AM +0200, Krzysztof Kozlowski wrote:
> > > > > On 06/08/2026 10:46, Dmitry Baryshkov wrote:
> > > > > > 
> > > > > > > dma-ranges tell how this bus - so venus/iris - performs DMA translation
> > > > > > > in respective to parent. Address/size-cells are obviously also needed if
> > > > > > > this is a bus with addressing.
> > > > > > > 
> > > > > > > But there are no children with addressing, thus what sort of bus would
> > > > > > > it be?
> > > > > > > 
> > > > > > > It looks to me that having here both:
> > > > > > > 1. dma-ranges + address/size-cells
> > > > > > > 2. children without bus addressing
> > > > > > > is some sort of abuse of the DT syntax. It is allowed, but does not
> > > > > > > really represent hardware.
> > > > > > > 
> > > > > > > IOW, dma-ranges alone feels okay, although unusual, and it states proper
> > > > > > > DMA translation for this bus. If you add address/size-cells, it means
> > > > > > > this bus HAS addressing and thus YOU MUST use addressing.
> > > > > > > 
> > > > > > > If my understanding is correct, then solution would be to add addressing
> > > > > > > to the children (so unit address and "reg" property) or drop
> > > > > > > address/size-cells as Rob pointed out. [1]
> > > > > > 
> > > > > > Doesn't dma-ranges require address/size cells? In the end, how can you
> > > > > 
> > > > > I think it does not require, at least how I understood the DT spec,
> > > > > unless you provide actual addresses to the property.
> > > > > 
> > > > > IOW, this requires address/size-cells:
> > > > > 	dma-ranges = <0 0 0 0 0x10 0>;
> > > > > 
> > > > > > specify the DMA address if the device doesn't have addressing at all (or
> > > > > > MMIO-style addressing)?
> > > > > 
> > > > > Yeah, that's why having here children without bus addressing is
> > > > > confusing. I would interpret it that, children are not on MMIO bus, thus
> > > > > the venus/iris is some sort of proprietary bus with no mapping between
> > > > > parent MMIO and children nodes.
> > > > > 
> > > > > If there is no mapping, then we do not have 'ranges' property. But I
> > > > > could imagine that such no-mapping bus still provides access to system RAM?
> > > > > 
> > > > > Actually this feels like a huge stretch, so I tend to think that the
> > > > > only reasonable option is to have children with MMIO, which would make
> > > > > it explicit: Venus/iris is a bus which provides translation of both MMIO
> > > > > and DMA addresses to the parent.
> > > > 
> > > > But there are no separate addresses for those subnodes. Would you prefer
> > > 
> > > There might be some or maybe these should be the addresses of DMA?
> > > 
> > > > them to duplicate the addresses of the parent node? Or would the
> > > > 'ranges' be enough?
> > > 
> > > I made mistake earlier - 'dma-ranges' without values is not described in
> > > DT spec explicitly, but should be treated as 'ranges' without values,
> > > thus direct mapping from parent to the child.
> > 
> > Documentation/devicetree/bindings/iommu/iommu.txt:
> > 
> >    An empty "dma-ranges" property means that there is a 1:1 mapping from
> >    IOMMU to memory.
> > 
> > > 
> > > So it also requires address/size-cells, just like 'dma-ranges =
> > > <mapping>'. And dtc checks/reports that.
> > > 
> > > I think therefore now that the binding is unusual (because no bus
> > > addresses of children) but actually correct.
> > > 
> > > > 
> > > > Or, thinking about it, if Venus / Iris have 32-bit addressing, then
> > > > dma-range should probably define the limited DMA range.
> > > 
> > > That's another point which I also raised to Vikash already - mapping
> > > should be restricted to 32-bit if this is how the child devices operate.
> > 
> > Souds so. Then we need a non-empty dma-ranges.
> > 
> > 
> 
> based on this discussion, below works for schema check and dtc
> 
> schema:
>   '#address-cells':
>     const: 1
> 
>   '#size-cells':
>     const: 1
> 
>   dma-ranges:
>     maxItems: 1

If this works, then LGTM.

> 
> 
> Now in the schema examples, soc is added to match the reg/dma-ranges of
> parent (iris)
> 
>   examples
>      soc {
>           #address-cells = <2>;
>           #size-cells = <2>;
> 
>           video-codec@aa00000 {
>             compatible = "qcom,sm8550-iris";
>             reg = <0x0 0x0aa00000 0x0 0xf0000>;
> 
> DTS
> 
> iris {
> ....
>   #address-cells = <1>;
>   #size-cells = <1>;
>   dma-ranges = <0x0 0x0 0x0 0xe0000000>;
> 
>   iris_non_pixel: non-pixel {
> 	iommus = <&apps_smmu 0x1940 0x0>;
> 	memory-region = <&iris_resv>;
>   };
> 
>   pixel {
> 	iommus = <&apps_smmu 0x1947 0x0>;
>   };
> 
> Please review if anything is missed out.
> 
> Regards,
> Vikash

-- 
With best wishes
Dmitry
