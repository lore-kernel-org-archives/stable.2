Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8F484246
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549510; cv=none; b=b5hg6fc2AWppG2nsSQKbgqzQImShICQqR8i/26GI0OUXyhX9uInD59AeAh0yIGY3JjeJRKRq3hrVrn9gg3YLSTGuPR9scL4lSSoioiiSnpDRv2s1SdwWS1USBumOJkBZt3BuIrBpD/DhXFyhbYSgmeCMg5F6QMD1shEu6IRyLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549510; c=relaxed/simple;
	bh=5WsJee6RnG8FDL/km9AY8oElVGx145sSlu07kgjc8jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcwDHEBSUsxhJ4Ii0u/pG6vSP8oKfxT6vqrgdyX8Ol/dbBkGrnlEjne0IJdz2ndw98USZ4JI2Lnyhg5zRzb4hddOkb6lvWQtag6sg8gyZ3gHLXYr+ahhsMTJwgY8yZGxf5D8kT2bH9wiSbyKg0nJLs+hEUR1dZZt4qKEC/zvmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lswnwMII; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ajaiem5Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lswnwMII";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ajaiem5Z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbvkg2728948
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kQLR4H1Nicj+xSHL9x7Wan7JxfTrbvx2Q5V49rtcMEY=; b=lswnwMIIpg3FLu7d
	AxZTGAhy9V6liPRDkU0u/Jb0s6QlxvPV3QJY1hcCpFEqndv3NNfkrz9ENtkDVOcK
	McTqjwEm2szea+lecKpDWggqH3oMCYlcXtlVINtpLLgEsfwaNviyTjHUK7Jobpbi
	kXzVkqGZcnTISDsVFeCCs7cmiCMWCiC0U4+K19JNnkFi9ttfNimSJwJUTdBxFt9f
	f0MA+DmKQXdA9RquU26rv4715AqEMY6RjVPuQys1OSFZMqx1A9UlwwugvMyV8bu9
	aqpyxRNZKa9ArmMSI0MezpYo7A7f7TiwQ7cIj6Bb7cKGoKvLSf0xrcupdjBkeMKh
	yVuksA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw2rvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:45:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fcaa5f82cso1267726a91.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786549506; x=1787154306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQLR4H1Nicj+xSHL9x7Wan7JxfTrbvx2Q5V49rtcMEY=;
        b=ajaiem5ZFfCl+jtoCp/e0QS3j8GE6/FAyI1CymSd+CyWLw62fXSM4kj8Tp2PLrgMgn
         TTVBsDRvYz/Nr3imTb4wpEaBvO/48IggaMzxk1ltpj58mXxhcmmtSki2atiS1I85kIRc
         KekHFTGg6Np4ouEWD1SYZ6oYYIkmfjULOGySzBPcDXz9OU5MpRejexQ1qKrooIM5W8iU
         ZD96kLJYuzYLexsVB4zQaAP+YAKhCa9BRwTDhWS3KlimVVs9hl9u3ggleCqzM9DXO4ar
         ENs8SZaKwndJbtvl8xvvJyOQbg86OKG560m5fcs5gQhrEbOF2P12OvBOk9wVRR2UCPuw
         DcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549506; x=1787154306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQLR4H1Nicj+xSHL9x7Wan7JxfTrbvx2Q5V49rtcMEY=;
        b=tBmdowMnEdROk/1xHHveZuR7k8W1vxkA883vKQsBmnVVs96J+3NOszykL4Kyo1+ug9
         eokevgETYloO83R9rf/9aef+b2TKdZXxdCmH3s+O2TRG/i5DqCbTGvEeeS6qz09JbOPQ
         ijhHmbDbzRGU2quyaouVsINCT8IR6WmuNTHSz683eVXR0rLdNfslFDvgnAE34wvIFCS6
         q4z1Z98hcAijSeiqitW+lQc+Ps3eTmwhTddFxOFgQlIQoNyvEYyfU3uDjRPrmR6gfPqS
         4v+F9HUW2asiCQ5AdmkL5RI8rE2XYrYCSfHk/inj+jCtcLCyojZhQ+GS6rq1dbWlAyj2
         QvGg==
X-Forwarded-Encrypted: i=1; AHgh+RqwsTpHCbZjIaBWtwpeACCEQOp796Gp5xjs+CRGMIYBFj0Tq0G/gwaMcwekfKic4AAuW7KrLYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HT9nIthufpvkW4uVX/dzupxsEOFnUJjvy/PBofMKGnUqFEJn
	S1XR/M2Gc9o+fz0jiKYUw8/jzeqsAM/1AlhsIBAFVf9NDNvaR8QZvaKoQTtvtnIfYABD9LVqAIQ
	N4Lz/TIRbLsSjt42tKQVq6rlxxR1LAiTbMzoctZK2qvGeMRGdTsGgtx+hJek=
X-Gm-Gg: AR+sD127TdsJZqmH03x2EJOrdpGjxXJdCOCxVnLzMS7xUzo+7WzZ23mdzcD49SuwSCn
	s4WbGalDYQrw3Yd09+S73EAmKZGZH3FglhT+cue13pFeYgcxN1e+JcM5a4UpgoZqvOlQrZ6No0I
	5c93B6zNfTIzGb4L7O3u+I8FIC1YgnHWfug02n53nxAw0R2F9udPiFISP0RRyytxxBG03uIzBIu
	HxYDbkb7KqAUgXFyhbru6Jzo+i8h92VBFRKGuSVo5UMm9NHxF8j+RR8yybSTOgogbCyn129+kHP
	NFmacyVD/LYx9XvGQeIHS7GsqBNim1BTasiFDutCBSe6t3MYQ431z4YsDIMumcydIk9fKKM9Kvt
	4XN+ftJIz6BGfX6xbjgPYUSjkBnesJkh7sXg=
X-Received: by 2002:a17:90b:1b0d:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3930123788cmr6180006a91.5.1786549506253;
        Wed, 12 Aug 2026 08:45:06 -0700 (PDT)
X-Received: by 2002:a17:90b:1b0d:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3930123788cmr6179918a91.5.1786549505589;
        Wed, 12 Aug 2026 08:45:05 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.139.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3c08163sm11160525eec.7.2026.08.12.08.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:45:05 -0700 (PDT)
Message-ID: <1a7c222a-617b-4dfd-a551-2c00115747a9@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 21:14:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Rob Herring <robh@kernel.org>, Bryan O'Donoghue <bod@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <20260807162405.GA896590-robh@kernel.org>
 <c3hVumMy_QnRbUmbFTSWGjkfG7lPjGFEcZfPsZeGQ57nWKkhlBL3wgmcDcAgT9cNb8Ju3qZ_sSKgHk8vmow0xQ==@protonmail.internalid>
 <6ee7f32e-eb6c-e264-6f0d-541555f8fd62@oss.qualcomm.com>
 <56b3dfcf-b1ad-4192-8199-06c80cc5d124@kernel.org>
 <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXzr7ps9ehwnWm
 0+VD1H6Duw8GBFPybl3HI5nvjXCe0OCQG4lHbVJkVZVNj8eD1z/4ATvqAryEv+/1216UpwK/o6V
 svwsBK+PRJm4BrKHFA1hsTJ2oZN/O0s=
X-Proofpoint-GUID: e3al1mYlAXFL_2CWVeJ6ht9ESM625ne2
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c9503 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vZaankvBGbqXg3MvYcFdyQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=YG64nluAAAAA:20 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8
 a=EUspDBNiAAAA:8 a=JoBr3x7BRt4YSxSGyWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=CsAS6f0m0zARWR-uHzm3:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: e3al1mYlAXFL_2CWVeJ6ht9ESM625ne2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX8G1hwUQcmaG2
 ApLQGa7CVSjS7xpWXwMMgiGJwgnrjBhLWna7YeGbYmPv2PeLWP2yHFufGeCBe/brcWRxEthb8Jx
 SBIh6OCRDPDrqG8IUDPt8SvfCx7ddSwwGodS8ZH9tDLdM+8/cyj57Syyzhi6XHh+fAZPKJ7yIm4
 /4D2koZGqY50mMLQ2T1bQmkdptmldZ5rjGdC317xrX4Za1ICsto70gYt5PbmT0YsXBPkPa08F+7
 CahTjR3dAOJb1Yb1tJMzw6oRFYvGOD1HaEbqzgorUl4DsYWdq+sfPxRjKKRw0AX8kCHaI8n0ig6
 GAl3u3+Gf4BUnY/vToI9PWQVWTcSZ3xwfOozTytGx2AyUSGmcy5umBVHbDPNXETXYX4W435oh46
 Yvsn0sl6jFk0viDfNMFPdu7PSWLwZlptk78LhOWIjXvtRUkXc0yd8558Nb5V5hf3wLhGsmpZt4i
 QGA+R23EttFgp1VMdqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128


On 8/10/2026 7:17 PM, Rob Herring wrote:
> On Sat, Aug 8, 2026 at 4:55 AM Bryan O'Donoghue <bod@kernel.org> wrote:
>>
>> On 08/08/2026 05:37, Vishnu Reddy wrote:
>>>
>>> On 8/7/2026 9:54 PM, Rob Herring wrote:
>>>> On Fri, Aug 07, 2026 at 12:03:50PM +0300, Dmitry Baryshkov wrote:
>>>>> On Fri, Aug 07, 2026 at 01:54:48PM +0530, Vikash Garodia wrote:
>>>>>> From: Daniel J Blueman <daniel@quora.org>
>>>>>>
>>>>>> On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
>>>>>> below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
>>>>>> into that range, from any other stream id would triggers unhandled SMMU
>>>>>> page faults that cause spontaneous device reboots. This is readily
>>>>>> reproduced with one or more browser tabs driving multiple concurrent
>>>>>> video decode streams.
>>>>>>
>>>>>> Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
>>>>>> and reference it from the Iris node so the IOMMU layer keeps DMA
>>>>>> allocations above that boundary.
>>>>>>
>>>>>> Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
>>>>>> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Daniel J Blueman <daniel@quora.org>
>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
>>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>> index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>> @@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
>>>>>>                     hwlocks = <&tcsr_mutex 3>;
>>>>>>                     no-map;
>>>>>>             };
>>>>>> +
>>>>>> +          /*
>>>>>> +           * The Iris VPU reserves IOVA below 0x25800000 (600MB),
>>>>>> +           * primarily for non-pixel buffers using different Stream IDs.
>>>>>> +           * DMA into that range triggers unhandled SMMU faults and
>>>>>> +           * spontaneous reboots, so reserve it to keep IOMMU
>>>>>> +           * allocations above this boundary.
>>>>>> +           */
>>>>>> +          iris_iova: iris-iova {
>>>>>> +                  iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
>>>>>> +          };
>>>>>>     };
>>>>>>
>>>>>>     qup_opp_table_100mhz: opp-table-qup100mhz {
>>>>>> @@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>>>>>>                     interconnect-names = "cpu-cfg",
>>>>>>                                          "video-mem";
>>>>>>
>>>>>> -                  memory-region = <&video_mem>;
>>>>>> +                  memory-region = <&video_mem>, <&iris_iova>;
>>>>> I don't like the idea of this series, because it _again_ doesn't tell us
>>>>> the truth about the hardware. This typicall ends up with bigger problems
>>>>> later on, when it starts to affect other bits and pieces.
>>>>>
>>>>> I don't want to NAK it, but I'd strongly ask to reconsider it.
>>>> I think this is an abuse of /reserved-memory. reserved-memory is
>>>> reserved *physical* memory. Reserved IOVA is a property on top of that.
>>>> I'm surprised this passes validation. If it does, I may go fix that.
>>>
>>> As per the reserved-memory.yaml schema document, the iommu-addresses
>>> property for IOVA reservation into /reserved-memory is allowed — it's
>>> documented for IOVA carveout reservations:
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L56
>> I think that is an entirely reasonable reading of the text
>>
>> Quote:
>>
>> "If no "reg" property is specified, the "iommu-addresses" property
>>    defines carveout regions in the IOVA space for the given device. This
>>    can be useful if a certain memory region should not be mapped through
>>    the IOMMU."
>>
>> Which is exactly what this series does. Excludes a specific IOVA range
>> from being allocated for this device.
> 
> But if "iommu-addresses" is the only property of the reserved memory,
> why put this property in reserved-memory rather than directly in the
> device's node? I'm only questioning where is the right place to
> describe a reserved IOVA.
> 

a single property node vs multi-property node should not be the reason 
to decide the place i believe, rather having them all under 
reserve-memory keeps all reservation at one place instead of scattering 
it all over.

Regards,
Vikash

> Rob

