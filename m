Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A633CBE8F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093553; cv=none; b=ZOW4xCWRBn+S1gvsFDBYvArM1xvhhxoyerdnAeQsSO54qwB4jdnq0W0vhgvcYBg8xXw03w4R6fXcpE+K02V7O58fvZlvDllULw/wISLt81blO5N3eoWLJKM46llvVE7z8YVsGSyriMelLcwNuptt9BF955MomscvWi54cwU42Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093553; c=relaxed/simple;
	bh=mGv92fPDKTDgi/M1tLT70EngJtlD2QV5OTlgO3iQp98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKWganIP1RA3Z+b6G4LqceJ2JDYiLGHvtCnzAHQWT2lNw/FdkMPWsJbgqlZa/HS8FFHYuSlX07KhfQkirRcFbj0PcNbWlnaf92iDTgp8rFK1E9NQXkbUiOwQvOr4ScVaWSB+kMqXzl0jJQ5gnvVT4CE1MuvTAuIrRd2ASjRr30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5hsLqOk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HcI4QL2n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5hsLqOk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HcI4QL2n"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6778Aie43822259
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 09:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4sMy9lKdqb+KnOmevtsdmhiZovlqPN/jquIBmM3Sjng=; b=D5hsLqOkLmOcfch+
	/R+z92Z9TjUz7IuofH55zEL12WUu4g+vdyZH7e9s6PvUzdREE2mW4FLedJk6t4DH
	9j4ZWWnSL+7a/JFH5jjOjTZdzQSwJr8GVIrRf8FREJBiLdRW1U+Cr5UlJyS+L52I
	0dL0lDNijmvoIX7Cp17SzUIpVf/BA6LqTpU41hW0UyjS2SRIhEoT8XoL2Fz9bnPX
	xWpIV7Tdh1lA3FYqOSQpXQMxGsBgTWP2mdUK18Uz/VmC9RQlBootvHuctIAjmjbO
	u2Jip0xCAx5x4PJVL5c88t+1qcadZ4QtJTPld5EV4KMDNaIfzQLF6jbdPhCFadF+
	fbwLiA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gu6t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:05:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so2068133a12.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786093547; x=1786698347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4sMy9lKdqb+KnOmevtsdmhiZovlqPN/jquIBmM3Sjng=;
        b=HcI4QL2nnHXzdJXtmDpmIiN9QDyjCK5y5H7rn6AQTDd1WE7LvklEzUb+ALiXCxGXoG
         UwkRXw8luJIcTlyoo1nKH2Gkct1yuM/ng6Gm26D1H615/qh0IYM7MzFTNrzKv9Y6rxB6
         Z1YxmKm7vr3a9CSA5zgO+EaBS8/6jE84Om3kxKiebLZfb+fF0ZztIHrqp629gQjj3FYA
         mgtrfwmRtHWtsuQLo7bjL7bP9mAc7PLXjAfIcgcvNccrlutl36dA+ph7W+dLsVc9Yxrw
         hn4uDQvwSWJqz/MMKXPMmFumhhACNITjsDzo4qZ888RVwIdxwSVHpFlUaoMOp1yRdpGI
         Pk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093547; x=1786698347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sMy9lKdqb+KnOmevtsdmhiZovlqPN/jquIBmM3Sjng=;
        b=SeavB98ntCiR7GAmQEJXlDbUi+wYnDYss08SdhRAMX6BMipHH7uF71Ngj//2DpKFcN
         KlZYFEQceNVXF0ftTqS9we0TEFzoTIyy7mfO2101JBU6xGnnDXbeXI7Uq87+R/22HKmy
         oSG319J/lSc0dGq6YQWgFthfrAuM4+KxuppinKiznhagldWMThqrQgxt36gGI4i2c9I4
         Zkgomfg+7+YrryLjW3cXHvrCrARcksR9OgkCaNkLfgJH3bsVxJasxRbPj59kM9lrZKAa
         ZH+NiOUmvs1409DXAjCq7+WwxvJKn7HqF3ZjpHJFTXvxL04OlGKOY7am0QKGypXeFAuk
         +jmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpkphye6lntxHHxnjYZnV1HdKrlNv6k3L/P9KplG9NqE72uKmd5QTea499qLRK9MnEMq3EGAX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO62NaHP6Iy9MkOf9yle6P4CqmNzIx4iVwj40tymifiyYMcmPH
	XyUCVMxl/e8MsFA/st4Ehs6sxrptWAHpHIH18hoDGeHpsPl2od9B3P2N2aCNfF/TADIjyaO+Lzc
	HjhNqmv3ORNmmv/rLd9ZvRedxLk62cJI/mNM0fJSq5UkMB2LXx2+YuWGDDD4=
X-Gm-Gg: AR+sD13S1zFf5V7xYQTAxP98YCOA/ABWtqpJ/Qqd8TozKLwN+ekLeg9Lr64ChioeJKX
	hI1OAPj3TWTbN75CfBWuLzx1W/hg1A363ivfKfdzhaQH5jhtNrtKpDDnD3W6QaVhMJ72FdqmJ1e
	4zkaVFL4nNoR++OYZIKIDJ/3Yh4aewHEDfzcrxB7Yy7cEUjTRuk19c4TiIUSw/wO/xAj/dLf2A6
	2ZfYvvMKjybHkDGg5mMxGtjdOmhd365I2caXzEksVLDW1/LDEjtZAdyFyyGE+Xk0poHA4ml/WKE
	UmbqlsDBPapmgp+xIAmZJSBTpOO4cdscv46EdUKIbkaAqNoIyhz/UaHvQzXUsAqS5biaAVbkFG8
	NV9tJ20J3BRI1eL4i/waON2c6qUxDBw59kkw=
X-Received: by 2002:a05:6a21:4c0f:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3cb85ded9cbmr27306301637.12.1786093545877;
        Fri, 07 Aug 2026 02:05:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c0f:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3cb85ded9cbmr27306225637.12.1786093545435;
        Fri, 07 Aug 2026 02:05:45 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm7785014eec.18.2026.08.07.02.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 02:05:44 -0700 (PDT)
Message-ID: <a3856ad7-f522-44af-828d-eaa1cc91484f@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:35:29 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] media: iris: Restrict lower IOVA range for Venus
 and Iris VPUs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <5pnnu5nc6tpptw2wriq7r7mxcjvn3kvi5auz4vqffdent5bxiu@k5pbypgpgexl>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <5pnnu5nc6tpptw2wriq7r7mxcjvn3kvi5auz4vqffdent5bxiu@k5pbypgpgexl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a759fed cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LEUcfjZBBKQ5YW9IAxkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: eTUi4_kpdNRlWG7bDjZiM8fOT24ZKqJd
X-Proofpoint-GUID: eTUi4_kpdNRlWG7bDjZiM8fOT24ZKqJd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX9Xijgn8RBaHD
 wTsiI8AkKR0cPQdjf32dTC1lCJcYyVikR+CSBXCdUJrO6ZL3vjXzOjn+ET7IQeSraLJkFGNSVNE
 YLqQczTNPTvnu5WRJkhQmdGWeGzYbZI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfXwIcPn66tS3Ir
 nSeDU6k85+O7Vl3gpDNhaXslDIZ7F8z0bm0BmA1FaKvoXp0rPeaWpCDCA+MhNnbxYt/0d3vMoWB
 QCbQ6J19OK5GWvANFwKSdtUcp+iZuUHsuI+fDni1WYEnu1JSkPNx1GH78EEmR9raUl4amuguCc2
 RoP6t5ejcCvTYfcU3MpR7PcPr9f5M3GZ8dnqTefiPSpVDrsULLxUcZlfEM5J/y0kKDxmKaMDRlI
 D3B7S/1N8zrW5Jjo6kJAi9ePt6bIkru3NN3oRhQBdeoQRjKR4aOEVquMpU+eMX3YXViNLw/Kv/k
 mFBSivOC+cxae4sQBhVUjtvjWytQf0ghF+BW/b9+JUFIiRyFEkBoJI+nVUPVTj4C0HkiLXlr74M
 EBTZXg5v+3qwcoQeoWyk9pI+MewFGiCowVwfTfLGASQpyIKZiVhHIWtHv5py7egZNB03Y/HO6Tl
 ftC516jykGpQwK3OCbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070067


On 8/7/2026 2:29 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 07, 2026 at 01:54:44PM +0530, Vikash Garodia wrote:
>> Qualcomm venus and iris VPUs reserve IOVA addresses below 0x25800000
>> (600MB) for non-pixel stream ID in secure mode. When the kernel
>> allocates DMA mappings from this restricted range, the VPU generate
>> unhandled SMMU page faults, leading to video failures and, in some
>> cases, spontaneous system reboots.
>>   
>> The issue is readily reproducible on affected platforms by running
>> multiple concurrent video decode workloads, such as opening several
>> browser tabs containing video streams.
>>
>> To prevent allocations in the restricted region, this series introduces
>> support for an IOMMU IOVA reserve memory-region in the Venus and Iris
>> bindings and updates all affected device trees to reserve the low IOVA
>> range [0, 0x25800000]. The memory-region is referenced by the video codec
>> node, allowing the IOMMU layer to keep DMA allocations above the reserved
>> boundary.
>>   
>> The series consists of:
>>   
>>    * Binding updates for Venus and Iris schemas to permit an additional
>>      memory-region phandle describing the IOVA reservation.
>>    * DTS updates for all affected Venus platforms.
>>    * DTS updates for all affected Iris platforms.
>>   
>> This ensures that DMA allocations do not overlap restricted IOVA
>> mappings for non-pixel stream IDs and prevents the resulting SMMU
>> faults.
> Some of these patches have been sent already. Why is it again at v1?

By some, i assume you are referring to the 2 patches from Daniel. Kept 
it as part of this series to maintain the continuity with patches across 
other socs, other option would be to bring them as dependency and drop 
them from here.

> 
>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> ---
>> Daniel J Blueman (2):
>>        dt-bindings: media: qcom,sm8550-iris: Allow IOVA reservation memory-region
>>        arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris
>>
>> Vikash Garodia (20):
>>        dt-bindings: media: qcom,venus-common: Allow IOVA reservation memory-region

