Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDC430CEA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010791; cv=none; b=u7VWDKqXKKQxOVcMp0AhCLQHHmxWIf56gXk6hmUZZdD+BSUfAXPcjh2cJVoSCL3nBFv9O+ezNE26lorIVTVpgRnxSUQ5ZtdOztCaDQBVrDTGweV/y7W85kItBXqd9XRsze4pdj46S8YY+GRjhQOYg+wRLp1sott/dIm/wEPurK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010791; c=relaxed/simple;
	bh=DCfnosgwu/FrZqMiH5UhrO0v0ind7PYqih6HdlBm4PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvvvVbqMoDspzGWj/MtwbWVaafYw7VDUEvMBe0qr6B0yJYaOBus16ouTlWVr4hdHqSk/cPmrfgMB84KM1Vwi+JgaGtVHOoxCm/T702UDln2R2R4ts41DCYkJb7QWA8el3MaHle7g7pHIOvf2YXTqt9icIG/u8ql3Lkp6wsDDtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZRrEjnM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1resibR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZRrEjnM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1resibR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769o5pa1627565
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LQMZkO/gS0JEQk5Oj8c4mHgy2yd4gw33IkvrUv+5FNk=; b=NZRrEjnMMDy99V/e
	dusxbYqNgJvj9qw1O07hyhTJi3K7mHSodH8zjnjtJ6X8FHIhMSWN0HxkAas6nP3A
	L+9WljRyp6xK4EKjZ3rhV7ROz/5Aljfq5vDbSrphyuvq2LEqxz8RUb4q/sfGm9f9
	4OfCVvhIUScjCkOWMAWX8Dlr+bS/cgqBaW1AZ5A9Zbd23Q062W//SVjO7jrb5lBT
	v77h+yK9jfMt+UHCKSzF/ROtTiSiTeJl01wQtWV4gg7O3UWnIafsnLLxHrlrqT1o
	A5ol+Jv/bFJ+aVjc3ePy9vliDDqYjFdUJxLTh7jNGcpyjtYC3h/yQi45FA+Hai3i
	VUhHKg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntngntg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 10:06:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso36142035ad.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786010783; x=1786615583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQMZkO/gS0JEQk5Oj8c4mHgy2yd4gw33IkvrUv+5FNk=;
        b=O1resibR9XvbxyX/I4yjXAf09YHvQJGK0HsXMtCylwQYxLHEf3xiUtKAT0S/IW6pH7
         rhPQwyzhoCUNP9GgNnjKI5l44ESkMR1SNofe1qWqOOUnR9i4KWPAyRjvEtAbKluBXa2V
         WDMp3pn1DIoIfC4K89XfJ9y3eqO7m9XAfi82SXZJ94vJQNNvoY8nC73odjxiUl9SYjiY
         Ke87oXpVeRJcgDJGdTQEty0SwrMqZogmZT7QDwCBbeTdeE9DFWdyDN1evvErUz+U5ZCb
         eLwgmA4DgTxsmbcbkHAUZ7azombYQRYkyYrQztC7qDt5yhw7khT7HGwr7E9JEvv624nG
         uPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010783; x=1786615583;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQMZkO/gS0JEQk5Oj8c4mHgy2yd4gw33IkvrUv+5FNk=;
        b=pOymkmkmOIrdCNaHqbIzNIc9EsGzF7P9klWk9tJaagzlkTTBdv9H7V9NRTrouKnMeF
         bttbgyoZTTvnh6Z48wUMIRjiTZMV3BVmn/2jPyTDUBnlkKHZVehEiY7q1ki8ktg/RlYs
         jGNTXvtwvlknhcc+fVHvjg4w74crPppTOJEnM8z42zvdPGE6WFcSoby0arH/AeIYWWOZ
         L3CIl0R3hazMaFSdpWtR9zoOV7t+RgCDqTEkrYOYA6+l9XfrcvCvXuGYtcdAM1uBHBa3
         jeIDRuDZA+aTglN5QfCdPI8zGU3sNt2vvzdQto5ENSAWF/IEMphElihbdzASz8Io/UPX
         WUXg==
X-Forwarded-Encrypted: i=1; AHgh+RoseocpoevlOgkUcs1pTcyy1ONXsb2+Sv9ZQkh5In+g5RIQdkmcvUQSrSUHVvv6Marb0+o866k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDlvL9bc+d+HMgmE23n2CJcQuTMDhaOm3vkkTEZsFMf7f9Mli
	SiDn/t9Kk/6CreKIxQg2b8V0elFhKbVlIeWgMj7gTCg4dlq5cN2sEk7N/tmY2Dz4PArdq8jU/SG
	wuyvlZKZAsV9PvoeTTIpunrl3DPsR2FcfaI6lcHFD4H9I3p83iyQdAa3Mg64=
X-Gm-Gg: AR+sD129qxUXXthY6QjMaQh3dcp8fjpfZOw1HhTxlmWtC195FGSFuKn0D/vUN86QlCu
	SrMIkbAS6rJsaYSrT8oVtOLyXKmi8v0iqNCYdyHD4veK9yHfquPLhDrW24KWhCMrpp1crnpaZ4i
	aahboYaWqJCJXMHTXhwixqRR7cV/otuoePczIrzyVhis+ZquOyvif4UKpin8itSX4u1q2UAqEwP
	YRpd+VNirk/PV++IdqA7aag86pD9tNGCqmpuI3ErvZF/qIdaZ3D51dc7lg0cZcm2iTJfZIsaagr
	dbQnQt6/abozZPc8jYOLMzF0r6T6UgqECOpFBp/8TcXUxO7B2UA/p97PVOtJm00hU5QBXWAjODh
	uxDOwUTh1K/1xHfaTKhGz/HSvsVnOSRADg0c=
X-Received: by 2002:a17:903:17c3:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2d0ca165189mr158754785ad.0.1786010783125;
        Thu, 06 Aug 2026 03:06:23 -0700 (PDT)
X-Received: by 2002:a17:903:17c3:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2d0ca165189mr158753755ad.0.1786010782680;
        Thu, 06 Aug 2026 03:06:22 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm38499323eec.1.2026.08.06.03.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:06:22 -0700 (PDT)
Message-ID: <639adb25-2495-476e-9b8d-d07d34c12895@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 15:36:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] media: iris: Create pixel and non-pixel context
 banks on VPU3x
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        stable@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-7-da52b5228dbd@oss.qualcomm.com>
 <4lhoiiuaiathwqscyvm2ruqfqnz2bzjbfe7s7tqbcxfcqphjas@u7vvrj2scxi4>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <4lhoiiuaiathwqscyvm2ruqfqnz2bzjbfe7s7tqbcxfcqphjas@u7vvrj2scxi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3OSBTYWx0ZWRfXwq5zcLQSl7+i
 A009GoELPbRuAAKUS8rIHS76vHxtRH5P8nm+MmxPkeXZc6KZM0KVjRhx3l1q6aXvJfjklhxkM0C
 iEn6obdp7kuBxi3eZx37Nzf9MdkUbSLOD/Uex+blxvHlwsfbaDVBkhS2M6pF+vGP7PEwi1/4asH
 nLwopFjmdPtQBo0XnLd0ulo1QF63ab7DizLu3lC6LxCSmkNDLo1Nr0V10K89JhPKCggKMNRCeUZ
 ybwmTy5r1JYbvksPf5Kbp7nnzH9Ld5A9ZieTgm3ukV7dEEaIQGly70igvjZOJSFgSqEAb892RGF
 GDImb8binU/bIYXykRmQPjtjTD/6pPEWJa3Yknla1PMLuz2Alr38g6eIldjYBokitMzYBxXI4N6
 4Ug3aJsUOpEtueOzQ68y1NSAb8RvmeEHdgUUb1TK5UsNRjwInxSybXw/Nomo/uFsWfNQPIgCajy
 oDVNWuAcrpA0+ROzGPw==
X-Proofpoint-ORIG-GUID: XJwUDwcKRJIGiJSXlnv5VSSvknNxPCsC
X-Proofpoint-GUID: XJwUDwcKRJIGiJSXlnv5VSSvknNxPCsC
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a745c9f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=fMNUo35Ht3zVPTVqK28A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3OSBTYWx0ZWRfX2EIEH9fJI00E
 ns7FYV7QWR2XdBjJAM54WUXnknOZVfYRDNGfC5i4vk+HjZe1kVR/1i4Jaecu7knV1vqX1ovpxpw
 n5oGe1YVIeXVwioNvp9Kxg2huaMZocA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060079


On 8/6/2026 2:37 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 31, 2026 at 11:52:22PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> is restricted to use 0-600MB of IOVA space, while the pixel stream can
>> address the full range.
>>
>> Implement the context bank hooks for VPU3x. iris_vpu3x_init_cb_devs()
>> creates the "non-pixel" and "pixel" devices from the matching device tree
>> subnodes, and iris_vpu3x_deinit_cb_devs() unregisters them. If creating
>> the pixel device fails, the non-pixel device is unregistered and its
>> pointer cleared before the error is returned.
>>
>> Wire the hooks into iris_vpu3_ops and iris_vpu33_ops, which cover the
>> platforms whose device trees are converted to context bank subnodes.
>> iris_vpu35_ops is left unchanged, as sm8750 still describes its streams
>> with "iommus" on the parent node, and the fallback in iris_get_cb_dev()
>> keeps it working until its device tree is converted.
>>
>> Backports are intended since the first DTS of 8550 binding schema.
>>
>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
> 
> Drop

how do we backport these to the prior kernels ?

> 
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Tested-by: Daniel J Blueman <daniel@quora.org>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu3x.c | 38 +++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> index 3dad47be78b58f6cd5ed6f333b3376571a04dbf0..623a0f8a7982c0b5c2e3741a34c1367e9aaf4e27 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> @@ -254,6 +254,40 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>>   	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
>>   }
>>   
>> +static int iris_vpu3x_init_cb_devs(struct iris_core *core)
> 
> What is 3x-specific in these functions? Can they go to vpu_common
> instead, as they seem to be applicable to all generations. And also, if
> they are common, do we really need callbacks? Can we just call these two
> functions directly?
> 

I think we can even do a direct call, thank you for the input.

>> +{
>> +	struct device *dev;
>> +
>> +	dev = iris_create_cb_dev(core, "non-pixel");
>> +	if (IS_ERR(dev))
>> +		return PTR_ERR(dev);
>> +
>> +	core->np_dev = dev;
>> +
>> +	dev = iris_create_cb_dev(core, "pixel");
>> +	if (IS_ERR(dev))
>> +		goto unreg_np_dev;
>> +
>> +	core->p_dev = dev;
>> +
>> +	return 0;
>> +
>> +unreg_np_dev:
>> +	if (core->np_dev)
>> +		platform_device_unregister(to_platform_device(core->np_dev));
>> +	core->np_dev = NULL;
>> +
>> +	return PTR_ERR(dev);
>> +}
>> +
>> +static void iris_vpu3x_deinit_cb_devs(struct iris_core *core)
>> +{
>> +	if (core->p_dev)
>> +		platform_device_unregister(to_platform_device(core->p_dev));
>> +	if (core->np_dev)
>> +		platform_device_unregister(to_platform_device(core->np_dev));
>> +}
>> +
>>   const struct vpu_ops iris_vpu3_ops = {
>>   	.power_off_hw = iris_vpu3_power_off_hardware,
>>   	.power_on_hw = iris_vpu_power_on_hw,
>> @@ -261,6 +295,8 @@ const struct vpu_ops iris_vpu3_ops = {
>>   	.power_on_controller = iris_vpu_power_on_controller,
>>   	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>>   	.set_hwmode = iris_vpu_set_hwmode,
>> +	.init_cb_devs = iris_vpu3x_init_cb_devs,
>> +	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
>>   };
>>   
>>   const struct vpu_ops iris_vpu33_ops = {
>> @@ -270,6 +306,8 @@ const struct vpu_ops iris_vpu33_ops = {
>>   	.power_on_controller = iris_vpu_power_on_controller,
>>   	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>>   	.set_hwmode = iris_vpu_set_hwmode,
>> +	.init_cb_devs = iris_vpu3x_init_cb_devs,
>> +	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
>>   };
>>   
>>   const struct vpu_ops iris_vpu35_ops = {
>>
>> -- 
>> 2.34.1
>>
> 

