Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91D3BBFB3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041983; cv=none; b=RLs4ran9GkU96CAJo5sakItheZNxcVjcusIBhM5JWke+ZIbD3OO/0BD0Ek2EAcncFip6WttFz2TIqExPuC+9z5ddMiwL7O20novXYegXw/7vzQHQUOAhhrBJ/4PvRoCqlTJq8mrE6Co7W4q4Amsn+WPSMoqhfuAf5IDsrfI8XtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041983; c=relaxed/simple;
	bh=CrJtiZSByV1ruTZyteR8UZkww5m5n05N3axrILeFLCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZf+l32l6VQKlIUIhO0CrlGRDoPl4CkcLpcgYtYKrsFViO0Lspgl+P2uY7GrmUwZo987D0qzljAUB4pQAKwGWhkjp1dEtmFMpY7UUSZfdqFmb0b8FvPbHMFWVCgdUqGh1/UmUc99vRBRbiMULCIiiViHzarTwKbiq/fFvgtmy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XARgwUnI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NhO2mBJq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XARgwUnI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhO2mBJq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IISie3052711
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 18:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGzGd7KWv89/ZWC1ybyw1tQUi56N8SEPChMtYRMb+1M=; b=XARgwUnIfulBFz4/
	3V3iaa4b8dG32wAwRvpiQxBCj0BxpbbWYGZXsyRcxQbWSMJqRBb+9EFMNAzrAfJO
	zoVB5JjUxcCEA7A3XbvgATuzAAiU+iX7yWb+Tvgcajgww11HAXez8x0Ht/zQ6u42
	2CnA9AUJTel8JaMNEyM74s5prLDcTn2P46mlLveT3IQ10byLrE5soQddy613/0dz
	bpYzRpvZoOKK6DPSHUDD3gCfN55AVUW8sQgm2V57HBTsb8I7skz6fSkADq0uQ8z8
	C1oMs9R+0gdpHpEWcxsEaQDJnlLuFAsZAUDhPFFPN46I1+uW+RzeV+F5ZTNfpUb9
	MrgIOg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gr7yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 18:46:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ddc70b9d5so671488a91.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786041979; x=1786646779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGzGd7KWv89/ZWC1ybyw1tQUi56N8SEPChMtYRMb+1M=;
        b=NhO2mBJqiKkLMK1YbT7WwKLbYt8s+tDhhVZ2XtcuchkkK+2NeaR3p8XEG1hwQQDU8a
         X8sM+yYC1B5DXnAujYpMZvk+REYjbbDBz2Q2r8OvyBmualbjtbxqoyYhkLNGGss9oYg5
         /j67nDc8D3WS/FaSPSGi6bIdnR3OP2UrZqmb+WlISp2AxKeX3EATdYq3u8A+YjJjYmaG
         AWYChvebGgDpGMO84SV4BHyUKqdFJeyUrSnWggeR2aNwU+GUaBW11bzHmBF9J/jgFKVB
         SsDahrdth9LDxyESS5oHv4TLNkr7PYbUOgXpWbroUjjhrI31/LC2sckzRSKnXcpmnUXX
         XE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041979; x=1786646779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGzGd7KWv89/ZWC1ybyw1tQUi56N8SEPChMtYRMb+1M=;
        b=QsxVlGKVtMNlwcDzSC37Cf1eNNVquOXCAGreqSOOOGOIGlGVh7+r0HcRVhIz8fVA/+
         Vwp7GB+2oGULdaTTlGf0eo8w8VIIVy78iUoWXs0AiVnXukvc8Ypiy0kL+BfRSE9n9xQm
         0SbdYfNiyBn0hFuAnZurCVhsdgQxyParAuldmilzZHZuYLmvMPncFnZq248dOnTrNZav
         29sgdD0reIiNig/3rooYE7IRsmcEnVkjSSMfdGAQi2WEPY8JpEmHTuMWUe0inuyqsVHO
         W1tvU7v+UKmA+52VSpCO52ZeWoOP6xIuMa5/gvfmvWkHOB/sXVK/ygXr5et2GQD8byW6
         ELrw==
X-Forwarded-Encrypted: i=1; AHgh+RoUsBwDBHrys5ClhCMOq4u9r1lxiKkaVdY0lEA3Q3RXpnZgai7652X2iby9xTekHW1Qtx4EQv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1YvRWRK0a/BV3xfqssnnAm+CPQSEcOkRzYPmnLW0HudFAj2z
	72JSVeBPeeqqUJNHQao0QOf1uHLPGRBjY9T2Xll55MHnaNRbplNhgkuuCRGOS12SEOgl9aoIK99
	KWNx5RFDCZX2PuvEDTlaymsgBBw8+u12GeEioyxt6/qHRhgN169ReDqwI9ms=
X-Gm-Gg: AR+sD10s/tey2fPwBgNWPphA+vnULzz85pf16N30wFwjuM86r0jGmBmg9mcNbTC5A1p
	e1GCXBQAjrYVsKFXwzKVfxx8mIRKd7ajtqQYTxyLKaxSxDqMtlOKNNlRExFPXzlzm4OnsmyelAd
	N/P8BUf2THT8pjTHfWsmUXiG8BqbGcCyBS+XcHtcVZqFPvAzFWFxw40SmKGPxhQv4h7T+ALWwuy
	Na/efbX6o7t1jwgupNVjZvIfVW8NI3xonCraSTS/wgnkwdROtDZeOqfsRrBlblIvr1UDtTVWujP
	RNSgazxBuXD4wt76+MG3wTij4R1DNWa6iDFBz3LOuUW+DA2imyEIS+a0Q6/GUv7nsiY49jMeLA7
	ynxVX0ZBEhrYh+xqSdR2RhTgpLQtCBOYiHF/VeZzsmJT6CQOvMltCsmdXZWttAA==
X-Received: by 2002:a17:903:234c:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d0caa0b9a1mr132823255ad.3.1786041979386;
        Thu, 06 Aug 2026 11:46:19 -0700 (PDT)
X-Received: by 2002:a17:903:234c:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d0caa0b9a1mr132822605ad.3.1786041978771;
        Thu, 06 Aug 2026 11:46:18 -0700 (PDT)
Received: from [10.110.96.87] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm44458302eec.11.2026.08.06.11.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:46:18 -0700 (PDT)
Message-ID: <b8915782-d11f-40d7-980b-52470db76ed4@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 11:46:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a74d67c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J7Er906AdXdpP4zEtWAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 27ftDH-_6nwkqC3ZrGeJY-G8kz02D5DL
X-Proofpoint-ORIG-GUID: 27ftDH-_6nwkqC3ZrGeJY-G8kz02D5DL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NiBTYWx0ZWRfXwmZDRlAU0rBq
 TxT5jUCDQGkNnc7j+Kd8oIRwDIFcM/t54wxSzRpOnShyJEBGTsO15AuKGbYj8Tz6AKs1BHLz427
 mwdFc35vMh+kMkHwNziEBCg0CRtigM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NiBTYWx0ZWRfX/87I/2urru53
 zRlclpDDamsgxoGcACXqZUuWg88a8NFVM5KHWhPcJTyMmQ653rSawv2CwdMNaUoqzk+YA2Rsy9T
 pOfR5/v3h9CR1Ko2L9vrSEF8n1d0P2osxclBh+sWFkY43YH8JduIYsphkiYOTzQMg1qbO2zMeM4
 VlZiQhihSa7uykRsP6Z7IZt0gZnFFJTj71wFBvNqmVyZK4jOVJ9kVn9kNG4t07mVpWNvfDH736m
 NM6v67tn4Wvx8LI33KEGie47hqG+yOy5XeqyR56Bu9sFSVSnKom6doe5e2JTJGV/U+vssjUBuRz
 s7EP9GKbhYN9w/xWKhamGDVse1DAIie9Z/u7YXJM8XocEbZ/a4rZ05yNsJjvt5LSnKAG545gFSd
 H+p39S/Xc3K+2uHlzpHWVw3cp+i/tr9ukR/WJk0rTAoQiuCleN7r1tye+JLdUU7cyY0E7Tdq2DR
 L5WKMLHLUDF0l5N6/pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060146


On 8/1/2026 12:37 AM, Vishnu Reddy wrote:
> While testing with some higher resolution clips, the venus hardware
> triggers a fault due to wrong input data being received. Corruption
> was also observed in the captured output when the client dumped it
> to a file.
>
> On debugging, this was traced to the venus node not declaring
> dma-coherent. As a result, DMA buffers shared between the CPU and the
> venus video hardware/controller are not guaranteed to be I/O coherent:
> CPU writes to an input buffer can remain in CPU caches without being
> visible to the video hardware when it reads the same buffer, so the
> hardware receives input data that does not match what the CPU wrote.
> Likewise, on the capture path, data written by the video hardware to
> the output buffer may not be visible to the CPU, so the client reads
> stale or partial data, resulting in corruption.
>
> Add the dma-coherent property to the venus node so that DMA buffers
> shared between the CPU and the video hardware and controller remain
> coherent.
>
> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index f74fa66f1a67..98184760b4bf 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -5024,6 +5024,8 @@ venus: video-codec@aa00000 {
>   					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
>   			interconnect-names = "cpu-cfg", "video-mem";
>   
> +			dma-coherent;
> +
>   			iommus = <&apps_smmu 0x2180 0x20>;
>   			memory-region = <&video_mem>;

> Is this fix applicable to only Kodiak platform?
> Or are there other smmu coherent platforms that might need a similar fix?
>
