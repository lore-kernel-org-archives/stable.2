Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623623;
	b=zJn9eN7VHx3kBIZ/eD1r7kc0KfbOQU2xHTtNH2adTZrbNgM0h3y+UAgqlxuk3LOkUOgX
	 D5rHF86xpnhFnM+W9O4DzozbigRVS4TQH4FVOefh/dCC7RYZeB8JabSqELKJNJlYgNjpU
	 MhJyITyLlkUkl0icdXWVXd5thZyujtWcQP6RBcJICSnQrj9m6jL+WiorGT5ZA0q28CFgt
	 WHdTjc7oknqWGfO8C7OKzwaSmKSGYWBIOdhM9VFJy+3Rhy4r1eZ8WePwV8uNruRf1U8ee
	 xbys7Rjh2wrTb0RCDJYMdsSIdlDfkRTMCts9PnLtiByIxtxAdaflwxYbGI2T2406UeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623623;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kcVN0VfboVi6VrY9yl+dHujm6iBJUTIYiZ/2tcPIgp4=;
	b=PPGEtXe78aeBCnVlpBE64TpCBkFia1IOORK8medXmerlDMCg9IXnAuJB0MHZK05S/huh
	 hKnmEQsCxY3Z4gwMQnOK6Lf1Bcm3PAwKkW4oQTBzGzhSOIqMpZ5ZBHivu2UXCRH5abHKY
	 nzKS79eWFVJKjNGwKfaI+kCmLOpZoESOBgKyS8FKketnunF2Y9+mAtISA0ZVykUVTsSRO
	 aX5mg5vyHUDi52hLpPrOqa1URWCkAb2IhcvtV88r1mwSrqzYGMQI3NYiW6Uq3eVTBLemL
	 VQ/vCVHy6o0m4bbohPUzBzpD691i3M/vufr1nrVv36RiJh4eHdbdW2p8obl62jg8IOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnzmRqkZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ao0AYPIH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE19606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE19606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnzmRqkZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ao0AYPIH
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AMck1821122
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 12:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kcVN0VfboVi6VrY9yl+dHujm6iBJUTIYiZ/2tcPIgp4=; b=cnzmRqkZOtbkKeM/
	GYWcgwpVIqDdqsQp88AO8H61KrXRo08UJjICqFbhm/trFV+hgXGHkRWyeg/heM/u
	5omLInZrkBB7YGGnHVC48MmnlTtGUzI8UeRIqhtsrKuPd558WuUGOhumnXPN68Fu
	4YhF4kRjnpLKlPtHcHquSkGOdRppWlXXYrV/v7+rVGU3JF/d7avydvADMAqQlCJd
	siR7Nn4Z3Hj0odovVhMHC7qlBESugrHOkLF3XFVCjaSL/1b60reim3mKXWoQio8A
	N2IPEv/OI6Za9y7cvY1xiOki9zXqopPJeQhAgghsryaEsFlDusOq/BmIg+6Z6zTd
	DWFJcw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hq79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:47:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5350173dc7aso7953111cf.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623621; x=1794228421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcVN0VfboVi6VrY9yl+dHujm6iBJUTIYiZ/2tcPIgp4=;
        b=ao0AYPIHgnPm801+52YtfreEZc8KcuKBrXdt8ArBI8AE0CoGPAkdKmMeqDs1nFkFyo
         XY2YtxiA5ByshLNWOkV3lKNVb+2x/s2S3svtZuT4G8dVLFtxIX5lQSibBrtPYGYqxbbh
         BDR0yO5gpwu6MbR+gN73f3VolaKUXdS1MLdBiMo6JOfvikQ6JC5+5L42lkKXr+zpcInz
         IVpJZDFXw1JzKypXZRuNEymcfNF1oI7QNot2+IN9cEmvoQvHAgwuUPQFPJAgc7WtnJ/v
         OCed/DNyIWu7AI/As0Q6aJbHz/ZMA1wSvuCD0v2opmvrCLoEQP9EjNV2CIcKUX/zLmqs
         exbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623621; x=1794228421;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcVN0VfboVi6VrY9yl+dHujm6iBJUTIYiZ/2tcPIgp4=;
        b=TzuHU4OFDLzGkQFeSduz9INh8oW2TX8oflxwoQGICAeC5Bex79zNOLi9xc1eVGq3fk
         oGLIwrcfmjpMonxD+fmFTrFaxix+v2NHCsGFt4cZEMb+w6tcNHH5WVegVgz5+qW6x7GO
         KjbMfZrT+e/LTd3YmsTi3Kn1RPmV2ifxRoLkw46g8E/fd6sdVRYXqPE7nDoq4NYGfkjt
         kguUr3Rnr3ESmWhomZKVqf6C6Gq2hvxt0wJD4ad7rcT4ra1UyX/Xw7vJfRKJ3taOpvZv
         bD9zU4Dg73T16isFnaQPVUwEhdk+EIUmA5jXUSyRlbFNvHtpu4KdBg1j2o/Amu3q5GHI
         7/dw==
X-Forwarded-Encrypted: i=1; AKwUvByONMIn3gWNjeialRj0clFddoL0a2XbQRdTDlMoogItG+/0W/ziLK1OooaotH27lI3HsMLYZmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuyxmET6zQFpTjETDXIOhfp0Sg+MuA8rrcL+bEde3al4H2sLSY
	JuoUxIp5ZKqw78meXG+cD7t1Efddza6JT0cklrrsfOgTClkAYmNwb317c52RLzClB8Wk5vEpQWd
	UUNeDLmhALsfrfWP/qEQbqVpIqmia+SycUzfkyisuXqTkOMLsqJsFOfan36g=
X-Gm-Gg: AYBFou0AS3UmrPmA2NLYCpBQPcjwkkDGjSdSckItO9Cbq0mjt7VfrG3IC2Iz/pGAC7F
	eJwx2XikaG0IP2Dsq0MlTWFRs5w03nBlsjXk1ce5dtdTKdVa/rSZWIGx2OD4BlzrB5wq9VJOc8B
	L1wjU6sfP70w0YSlB3S7xH2Cgk6ZexE9QAuGwlfsoshfe3dzl2Riha7867NmSI1ILv2uNURWmm3
	yPpbtu7M6zfZMDMQ6pwWHJKjZgtwf6BposRmYDbRhU2LOeXirk3UUtC5qtrXAfa2+dE3jsI3q5v
	NjrYQq5HQb5+xK/r9yw30Q/lLDztMFjIbU0KjYTB/4CtiEQJ93TNuUOyzGS/DkMSKrut5rgOJfL
	ScN68NTXCveMLC5BSGDMv5LSWgnyVURjb0V1QweqU4Um1k4icqo1I39gjtqPzjfEGzuWZcto=
X-Received: by 2002:a05:620a:a8d5:10b0:93a:14c:329c with SMTP id af79cd13be357-944214d09d9mr1632533985a.1.1793623620851;
        Mon, 02 Nov 2026 04:47:00 -0800 (PST)
X-Received: by 2002:a05:620a:a8d5:10b0:93a:14c:329c with SMTP id af79cd13be357-944214d09d9mr1632529985a.1.1793623620444;
        Mon, 02 Nov 2026 04:47:00 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f376sm3452213a12.26.2026.11.02.04.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:46:59 -0800 (PST)
Message-ID: <30265695-c3a7-4440-a0ff-7fd80fc721e3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:46:55 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Fix iommu stream ID masks for
 CDSP compute CBs
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org
References: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 95d0ytuv7TTsB1Ak_6OSzAHNdiV1n8aJ
X-Proofpoint-GUID: 95d0ytuv7TTsB1Ak_6OSzAHNdiV1n8aJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX3vScdhb5069d
 NWYIqOMWAIv9IH/0n0Y9Bj7hw667jp0Qm8SFzNte1uYcZNBxXlDdpiaU8rFIVaa5kE9LmiP/oWc
 jhVjbe/BdWBe96E1awn8vOnw+nNaRPA=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae88646 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rqUuZ-GaD-BuahIUHWQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX1tzavSKwQlZo
 eSSi+09H4/68AmHeTRcVAzxQ08l2/ZL9z9VmtOWIH63oUiZQW+THs9xLVhSPUsuQliwmeBkWPlb
 fhOkW90XetPKAASst0GgahyBfl9ETBqz9jqmzyAMwnoeXSkuLbURk1uBs+hK41q4J48SO/DnmRE
 TydGdkYAqwA7XhHMArNAcQjmRzm2cCgiUG87Y8cLum4+Px1rgxYUKbg7fUsv/9EgtKo0PvIWBsv
 pi9XC0+keh4QWM7HYEUk44AXcAY+HOuLUs8Izatuy361++OQQ2GDUkISeOuRsBgSybneA3B7tos
 uw11rNNZlT1Sp3D5iXmidZns2GJhLeBDEbUK+INSnpXzJdzHD5O2eWAHiF4jdb5cS4o9F5ux0P6
 0hTtzcrfDl60ALqTuNlc9n/spThsEXQWJ2WMRT8P1kGt22BlvKPWCbx99USSYgf2vsE3jVXNgft
 77aidUYIT19HiusPd3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 3:41 PM, Vinayak Katoch wrote:
> The stream ID masks of compute-cb@12 and compute-cb@14 are wrong, so
> these two context banks fail to probe.
> 
> Fix the masks:
>  - compute-cb@12: SID 0x0c2c, mask 0x20 -> 0x0
>  - compute-cb@14: SID 0x0c0e, mask 0x20 -> 0x40
> 
> Fixes: 58471055ae76 ("arm64: dts: qcom: sm8750: Add CDSP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
