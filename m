Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF13A9861
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482506; cv=none; b=qYpFWTeAM0YMzHI0N8LOMgaMPJbdp4MIzKOMWWmUFxBV+x+x95FFOvkQCf2C3QowlnclTdcKoqqYkOtMmIKnHWwJvN12skO9BJCKXPfIsOa7+LyViCR+rz5rnJX26+G5emxStf9wKCIV4KN1XPqPfpFP68H8wS7mpOV++orDrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482506; c=relaxed/simple;
	bh=XJ3EOygyCWf8kRyzqBMGiUXQUIc4BAySYEv22NdFvMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsQxQFjt6NY4QUK2aRhKoApicdaGlekZTG3DNV/+MjbNJe7CgSUF2JObV7Cl5yS/0EibELJchyCa8/E94wM6UPHuIHHanDs/DR08oOEcGdckOOASumUQlqdz9qxiAy6n/0P6GPkt6JcHxrok28Y5y/ou/tOa3lHZQifsRr/VreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMlSW1+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKR2hWeN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMlSW1+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKR2hWeN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7IbuZ3170226
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	shlC9LzYi8PSRyTYodCWNLn52HBePlprGMEhr/jUl+Y=; b=ZMlSW1+kG+GAzPuM
	xHPhPLZ7fwxtyELKLSi4UIL2gEU61eROSojfekS/GdHl6Zc76mEdU8HiDRJJPKhU
	vaTq/YE9LxW6mmmuN7B+ngNUV8IfbmLQyeVRBWsgdUIRt5kGpmj3gYlc2IggXdCP
	KavGn+spKjLTTA8ZjFDTYYseN/I5HqlSq3fyOp6ZnL7BLbE9zzOtxqk7HXlazNNN
	2RJQG50HOYlP/vmk3ZykzofTYQxjDeT4o1WRht9vq95EjxChj/LPZsBQ/FKx/7Ib
	LoUX0uw7iyUC4dCsnbyIFdvKVJ0oKqI6nYwH1Mss4p4DrrcGBS7iq8MEjFxUZHpI
	eYDLBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frq6tg09u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:21:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb687f82eso9773515ad.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785482492; x=1786087292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=shlC9LzYi8PSRyTYodCWNLn52HBePlprGMEhr/jUl+Y=;
        b=LKR2hWeNlRVebhLzv2/YGOMnRYa6Lt5q3qsNNkrpPEwX5GwlXYtOFv4KbSDLifL0us
         JUYR+Y4iSPlstcly1GdA+iRSxdHzlHLnpbsP/O3BXFWlqIISiM7Z8w8ktuHw83UNa/xd
         iYG2yl7CQ/L46i8ibJiwAtqGu/hY53lOnU9cl8Z0Lm5CkKc4rCpMY5dwvDln+OGiK6S1
         /gvZBzqakNFkL6xXdLR5xBa2wYO/bsGEdWWyw63/5QE6FuyQC6lOz+VxDrkbzx4/4OV3
         xFqlm4B1b3g3hpHDkxkuGw9MeffPLj9Mn48IonWAMELhWE4+bmPQNZeTBgxIMvi6oGMz
         oyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785482492; x=1786087292;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=shlC9LzYi8PSRyTYodCWNLn52HBePlprGMEhr/jUl+Y=;
        b=Hw46nIdyRrQRgfgNUzhx6rpW98dy3vDCOVqXpUSR1mc9jC+/GqrziB5S5LLWjapNoi
         7zJ8SvUTSPGH2NlcK0KoiTQTwrD3/mX0GH8Xq87m7h0xxMqDfP8OKnKl2zbJYB1nnsu1
         NLzTkGnKfmLGJrIAtMScQjZ0Fn91xaLOQndTfeirLX/9XrwmTeDZKTYq2QoarPEE8t0I
         Chx6VvqyUMbocKMTlta6zOSYU/tqCw9E7xp4mzvV9No/nA4zfmr3GABCE9oE62/Z3U62
         CBwZoU4NDxeScOhORAGb4yVMLKB0cT/jTjEJRuMjyCEHBUwjTDfmlfzSxUvFy7RWMuXd
         W8XA==
X-Forwarded-Encrypted: i=1; AHgh+RphQk8suZ+90gK9GjtK2EFgVIISMSt0THB5XCQA7bF7571AfCUBZNju1eYzx7i4kB1G6o1z5QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzr+UC6zv09E8OnaI3nMeflZ5asnz6agxzIpXl5nuTRh7K7Kde
	3TnqEJB6QNXaNjyjN7nxnySv/LgcNG0Q7rogQfdxA4ibm3RDIeubQjzEv9Dt0BVEzJOHdCqlDDS
	g7LgVwgj/QD6yw6eHmPpuKM/WsP4QOVba5em7Lxg4fURxtTkLwUTSkS50LFc=
X-Gm-Gg: AR+sD11sn64s9wnLLgDat4KpNvVXI5apP2wZzsCCk/x2kOYoi+FNXdj0sTIN2UuLBvx
	AC6o3F/62G8Vyy/cRJFtdsEDZ5hXSM3JFJOJiohn9aJS7/QT+ozUI8uRcQKOBx8WmyE9Q5t2sJ2
	BTqUqVDsEU666T4fNmjQUOZR+KFi220b0F1YavcZHDVuvnDDm4CNJeoUCpb4thEvGRKMwp5ns+8
	6cysfGpOVswFGr0uiSxRsgyeMU2hOR/iD8oVzCP1+56UaYbqoYp0lfJ7C2tjuZhcyEZcflFX1dO
	+Z/tkD1THVvHJVlAtHxmoK01EJZuRywiQruaRw+3FepcmgMKUXE4JXUA8ssCeij91//exQJnG5S
	2ZBmf3ZvmF9rXcUu4ioeS4Iq/ttY=
X-Received: by 2002:a17:903:1acb:b0:2ce:9c48:22d3 with SMTP id d9443c01a7336-2d046d912b8mr10074755ad.11.1785482492121;
        Fri, 31 Jul 2026 00:21:32 -0700 (PDT)
X-Received: by 2002:a17:903:1acb:b0:2ce:9c48:22d3 with SMTP id d9443c01a7336-2d046d912b8mr10074495ad.11.1785482491663;
        Fri, 31 Jul 2026 00:21:31 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.67.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19edbsm1754615ad.12.2026.07.31.00.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 00:21:31 -0700 (PDT)
Message-ID: <ab3c3006-bfa0-417b-86f7-95470c73e547@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 12:51:25 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0139/1276] arm64: dts: qcom: sc7180: Add power-domain
 and iface clk for ice node
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, vegard.nossum@oracle.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20260721152446.065700225@linuxfoundation.org>
 <20260721152449.211750681@linuxfoundation.org>
 <a0273f34-8596-4b6c-a489-66a4533b6dd1@oracle.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <a0273f34-8596-4b6c-a489-66a4533b6dd1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX0H9OFk3Ktepx
 JzFptg6FPR/AzhyQAh8bQwx+5WUc7Plhz2l0IJhG9BIWnEfJJiHJnll8+p+he8kzeFZc1vuV4eh
 TBUZlXScsquinXMLFySlSO2n7sM2zMI=
X-Authority-Analysis: v=2.4 cv=OKkXGyaB c=1 sm=1 tr=0 ts=6a6c4d01 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=mrmDAJacfjHp5PIfN2e9YA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=MmdMlfdirAaFi6ld6HsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX+N6DqwJYe8qd
 LbByavykoNJ76YZFDwAhO7JUcwZvszympPGxkm35GTQd4MoXmc4XcRxvQdJtuQmg2XSn3x2S39S
 EQm+V/Le8WXR1q5W/ZFaUYqdAtcQfZhLefThHgqX09WTbyMT/PlYdffuQNEt5W0ORyw0vmwRZEw
 wnTUdmhqYDUruQ3iCpknKi6VD/ObtYZ/n+GrmvMZyG6UM1GI0y7Iv8//l07dw79zi6KeMlpUuSz
 8I8SqpTMSjtYFx3P2jKs8v9FG5Xq2mtuMz3YcqRyRd2Fom5l2LWjp39Y4Q7gjHjOK6Rc7XXJsE1
 7Uc1U/hrjfIUuHNlQ9hNqg62qRJJv+fsooDBcSH1ysX2i7SJdd/2KLJXex5N/WoDKjpVx1PPJUf
 cpcAfqttzU1j6EfMlodjQRN92vB6sSc0f1j8nXE15Tq8c9/NWfXPwIDdYc5ik2wA/SVWyKEMcFW
 gr14X2fIzVWdgxdD7+Q==
X-Proofpoint-ORIG-GUID: HxEgrEh-8zyYd3fpUwLcET_z_J74ALLC
X-Proofpoint-GUID: HxEgrEh-8zyYd3fpUwLcET_z_J74ALLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050

Hi Harshit,

Apologies for the late response, I am currently on vacation.

On 24-07-2026 05:50 pm, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> On 21/07/26 8:39 pm, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
>> [ Upstream commit 7cd7271ac525e4eadd22734f418219f247638f43 ]
>>
>> Qualcomm in-line crypto engine (ICE) platform driver specifies and votes
>> for its own resources. Before accessing ICE hardware during probe, to
>> avoid potential unclocked register access issues (when clk_ignore_unused
>> is not passed on the kernel command line), in addition to the 'core' clock
>> the 'iface' clock should also be turned on by the driver. This can only be
>> done if the UFS_PHY_GDSC power domain is enabled. Specify both the
>> UFS_PHY_GDSC power domain and the 'iface' clock in the ICE node for sc7180.
>>
>> Fixes: 858536d9dc946 ("arm64: dts: qcom: sc7180: Add UFS nodes")
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Link: https://lore.kernel.org/r/20260416-qcom_ice_power_and_clk_vote-v5-6-5ccf5d7e2846@oss.qualcomm.com
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 6ae5ca00c7187a..e52d938df1bece 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -1601,7 +1601,11 @@ ice: crypto@1d90000 {
>>               compatible = "qcom,sc7180-inline-crypto-engine",
>>                        "qcom,inline-crypto-engine";
>>               reg = <0 0x01d90000 0 0x8000>;
>> -            clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>> +            clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>;
>> +            clock-names = "core",
>> +                      "iface";
>> +            power-domains = <&gcc UFS_PHY_GDSC>;
>>           };
> I ran an AI-assisted backport review and what it found is likely worth noting:
> 
> I reviewed these four 6.12.y commits and checked the current 6.12 ICE driver and binding: Patches 139-142:
> 
> - e49e61994f4d ("arm64: dts: qcom: sc7180: Add power-domain and iface clk for ice node")
> - 4960fae719ad ("arm64: dts: qcom: kodiak: Add power-domain and iface clk for ice node")
> - bac1108e0040 ("arm64: dts: qcom: sm8450: Add power-domain and iface clk for ice node")
> - c4a4e6c6255d ("arm64: dts: qcom: sm8650: Add power-domain and iface clk for ice node")
> 
> I may be missing something, so I wanted to sanity-check my reading.
> 
> These DTS patches add a second clock named "iface" and also add
> power-domains to the ICE node.
> 
> Upstream commit 0d5dc5818191 updates the driver to request both clocks:
> 
> if (!engine->core_clk)
>         engine->core_clk = devm_clk_get_optional_enabled(dev, "core");
> 
> engine->iface_clk = devm_clk_get_optional_enabled(dev, "iface");
> 
> But 6.12.y still only requests one clock:
> 
> engine->core_clk = devm_clk_get_optional_enabled(dev, "ice_core_clk");
> if (!engine->core_clk)
>         engine->core_clk = devm_clk_get_optional_enabled(dev, "ice");
> if (!engine->core_clk)
>         engine->core_clk = devm_clk_get_enabled(dev, NULL);
> 
> if (!qcom_ice_check_supported(engine))
>         return ERR_PTR(-EOPNOTSUPP);
> 
> My understanding is that these DTS patches add a second clock to the ICE node, but the 6.12.y ICE driver still enables only one clock from that node.
> 
> If so, the new "iface" clock on the ICE node would never be requested on
> 6.12.y, and ICE could still touch registers during probe and resume with only the "core" clock enabled. Is that the right reading?
>

Yes this analysis is correct. I can see Greg already picked this patch:
https://lore.kernel.org/all/20260730141436.745713281@linuxfoundation.org/
 
> Separately, the 6.12 binding still seems to have clocks: maxItems: 1 and
> does not describe clock-names or power-domains.
>

It doesn't right now, yes.

> If that reading is right, should 6.12.y take adapted versions of these two commits before the four DTS patches?
> 
> - 0d5dc5818191 ("soc: qcom: ice: Allow explicit votes on 'iface' clock for ICE")
> - e27264daac7d ("dt-bindings: crypto: qcom,ice: Fix missing power-domain and iface clk")
>

The 1st can be taken on-top of the four DTS, since describing the clocks first but enabling them
later via the commit is totally fine.

The 2nd one should be taken to make the DTS patches comply with an updated binding. The binding is
written in a backward compatible way so it will not break any out of tree DTS still relying on
the old binding. However, the patch must be adapted to 6.12 to not make the power-domain and
clock-names mandatory for Eliza and Milos since those targets arrived in 7.1 kernel. Only the first
portion of the patch is applicable for 6.12.

Regards,
Harshal 
> Aslo the patches are from a series which includes the above two, so should we either queue the above two or drop the 4 patches for now ?
> 
> Thanks,
> Harshit
> 
> 
>>             ipa: ipa@1e40000 {
> 

