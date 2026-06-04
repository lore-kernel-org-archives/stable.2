Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09913C768A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555943; cv=none; b=OwhiLT/IwXcwAY1ui4ZQdtj4Fa+Bd9Trek2wmfLeR9x4xV96MONwCDmib9QuL+F8kWSLKiQbBFtIRNyV50pZ4z2QlKyVN4sO/b24J4+4FU3GC6uAtIGoXiOMQsl0dJ52ylkMPyeE2TQPpBvfmjY3yG1RAvWgfeKvC6fwX1Qr7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555943; c=relaxed/simple;
	bh=GY9HWYcYN2vZxgT/IMPbqLYpuIufDKnKhahxeGgORFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9QTFuXxAvtFXWRNxJVYj85PDyIQBAWWJLGawHvgwk9KuspU8m5oMROROcUADbjPiL2wsUiYbQo5hPI5Oy1417+6EQWa3Yl7T7yI6BTqqK4/+FmdA/APzdkKrVu6CWcbRxVh6FpU6GRrhlYEmlioykCwaL+CxFI0Qb0YktuG62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsvTztIu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrJ+I78t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsvTztIu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrJ+I78t"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6540um8U600152
	for <stable@vger.kernel.org>; Thu, 4 Jun 2026 06:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=; b=UsvTztIukAjLYmBe
	JIt0gPAqHJgHNuaWhw07hXE6Yj0D0umA+iNeSyjT8pdpP99BdENsPRlLPNm9fjBM
	CCz8+7MuuUsT9z4V1D0wyXO00okNExyq1lJn3s7p7AoegTBharldE8s8kvu3dH1Z
	YreOzaJ3q4BPRyjwfjKdiPnRxxx5zbuuZ/kdey0z9vbJ5hrwLrSzFl3lGPCxfz2O
	CJ2+iw8jW4iaHMFMTGHMncjzecjEjTnY4de5A7EwFXn9qSsIHeuoO1/2e0XeTp16
	J3ilqimm6Tce1w0yMDxOVlWZtajLxhKAvZdc1SHWrLfk3jqt+7jJ7ipxAMtwDVob
	MlNeTw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m11mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:52:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccd77414afso4665586d6.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555940; x=1781160740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=;
        b=NrJ+I78tXCpJGH2tMKNgZ2cFm/JSTI8dliXPJTX+hhbMS6MOCyrRD9AHqLhL3n+MAh
         0E0VcRIGzlI9zxhn5m5VOww+Eu3R5sQuN70R3uQJoJ+04aiN4DGMfGnHhKAx2FGNfkyb
         Fl5H0Mf9W+DCF57phVPheMjN5NkAdQTnCnRL4tHv2uIyzb/XPOKUvwUR3cc1wKImw3A9
         GBRV931s5wwAdOHlDNmR7dxlax5LuegmZnKRQ1fTB/l8cyXL2zNGvjAZnZj6fIvpj1hU
         kcdWOCq5yFQtnFE6fapsJYcR2jxychFxWMD8s0PkSqnJ6EsQ9phiMUta5UcIaSKECYe/
         2bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555940; x=1781160740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=;
        b=SRDfBAYAop76ZVVr9aucwTqE5jzOA+EBhNI5XDNg7JnZyfWw8Bv2jiukTOEPG+c7c0
         VI5mHLgUS/7evS9B9Nx+PEIZwzYV2slyK8ZExmpBnj4KjwjWAL/BRRrqHHJbj0D/K7ea
         jMDt8jJbEdzbK1AtyIqqlzEKban/dukcYGFhVapY4FXMnRuG6oneLQN2hxCQVtvZpOzs
         WHKur2RThezYiPxhQG6DuJYsMelGSAKQhdVvWt1UbYJsi6VUWjgD9z+tr8E2nMTbd8ox
         fnHmhuMl8GtPBFYOEQcet4DnqZOxZT5G5eFHsTUiTCDYoQPVoqK/zeBM91fvs8791idW
         gndQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pCLlu/0zWQlB5id4/mhRDBG+mJ7gWDYrYROOsvXR9mEKASVExh1GqppeBqWTXYS7hw2LBn5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9cic5iaQ8X6AyooWHTab10mJCx/pfo3DwcypSTPFPsVMkg/G
	Gbwjxh7IB43fm2OgkGrT5sNP+CVAP6wRp0Fpnz6hATSP6lxBqhnz1RlZbwtJxhb/sgCa4QDeyhH
	qYces/QoR+kQ/A5R9AJQbSOyVFDpC54RSEDJ+5exYybwef3QiR9a+gwfTH5g=
X-Gm-Gg: Acq92OG6RM34xLM9i2zJ9JnsgUvzj64sB7FkM0EBd8e9MEsXmGAGfxvRtN2z4FavzZy
	HdomBeuP2+iZ77iWPxl5eACMIfXtL8Ja4OZ51ORyXGQrCMB5vk28cWUfuq7kfXPjtzCxzz0ieag
	MVUziBScL/ewEqI8QrTsqGEgnRz/u/BOcJGzBICWH4szOHJgEUESIZ53GNgKhtJ5QOSrvgfb9FY
	WN+nUUFr6D0tCwyxEbWycndNvMlRbmxdszBB6AAalCeVm77AMjsgt/ElI6dxXIOVnrSAZi1TFHs
	o8EY4+nARpFPwwqcDwx9HmPjjJjjSJ0hs4T+5AT/fUp98u2acgotO6rRWZ5qHohLgT3el5htV73
	N3zrpr0QfmkTsqVIdFNJ4Yy6h5Ii4P9gTNeXjqDYIS1sZrpQZXujoCp1J488EW6Jw/qA=
X-Received: by 2002:a05:622a:d0a:b0:517:85d7:f5cc with SMTP id d75a77b69052e-51785d7f8acmr41866521cf.16.1780555940308;
        Wed, 03 Jun 2026 23:52:20 -0700 (PDT)
X-Received: by 2002:a05:622a:d0a:b0:517:85d7:f5cc with SMTP id d75a77b69052e-51785d7f8acmr41866271cf.16.1780555939874;
        Wed, 03 Jun 2026 23:52:19 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.249.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e06dddsm262483066b.36.2026.06.03.23.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 23:52:18 -0700 (PDT)
Message-ID: <9d0224f0-efb7-4bc2-8f09-70a9b4d62810@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 12:22:05 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] media: iris: Add support for glymur platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <kunwuij4ntmh2hwxdrfwlpiza7kbcwtdlty2cai3xlxybkn2er@7wmo5irzum44>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <kunwuij4ntmh2hwxdrfwlpiza7kbcwtdlty2cai3xlxybkn2er@7wmo5irzum44>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a2120a5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=QLLTW4K7kuvKcNWOCmVsWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=MmbEFYbivRMSk88UmGwA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2NSBTYWx0ZWRfX3ouK3V2kIx+i
 dnxzupXWtaTMu4HyJPfQMv9gHh3cogcGFDzHjjKSKjNpZYUX4JoEgOYcw3cc1z8BXep57nCru7P
 9z+s22SnVcIOSobQNVrIlm8hkh9RVDp1/Atkr+O8DFRnLe73671PKf+A/cunoUZcDNMk+Dl+U54
 XmPUr4xWbek+dZJXeKCJi2Lxy0SU/G6JZ+RF7NDLpNSGGgDyzYntVRKNYVSF5TjkPUgQ1vhQPtu
 3gC1SJE9yt5fpI8ULgyTRtKiTZujKLyQc5mzeLrd4mFkBBwnVEPt2arFtwda4ZApUhukSuabR3R
 LqwEe1/dm/nXHexwLQYkREI+SjSDMi5AwZw8L3z8Iyx1/mADnkWeswCs2Ia9r54xDjoeZlmU0xW
 pddkYnM4fNX8U2SETOTGxFlxgR7YwpGUOU53TRaHU60q3eiS7FQ14yMTf8nRI7R48cLM8PNkwp4
 xD2YSeazZxvNpX3b64A==
X-Proofpoint-GUID: j8qAMoHa0bKCoezU_v3z-Is40RMByXGt
X-Proofpoint-ORIG-GUID: j8qAMoHa0bKCoezU_v3z-Is40RMByXGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040065

Hi Robin, Will,

On 5/28/2026 4:24 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:15PM +0530, Vishnu Reddy wrote:
>> Glymur is a new generation video codec that supports dual hardware cores
>> along with additional power domains and clocks.
>>
>> This series adds platform specific support in the iris driver to handle
>> the extra cores, power domains, and clock requirements introduced by
>> glymur. Add support for firmware loading through context bank firmware
>> device.
>>
>> Dependencies and merge strategy:
>>
>> Patch[1-2]: IOMMU maintainer need to apply and provide an immutable tag
>> which can merged into media tree.
> 
> [...]
> 
>> Vikash Garodia (2):
>>        media: iris: Add iris vpu bus support
>>        iommu: Add iris-vpu-bus to iommu_buses
>>
> 
> Robin, Will, do we stand a chance of getting these two patches in 7.2?
> Or should we use some other approach?
> 

Could you please comment if the patches are good to go or any 
suggestions you have ?

Regards,
Vikash

