Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC844F543
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752794; cv=none; b=UUHZFP1Th23d8Z5lJB3814/+a1OUsM/XkcIUaubcRmTdmngK0x9ysK4pT+2PxHrSALK5Oi1ZoHdoOnsVGPinnOUtsw9BCCDuTdYVXxpSzb2/k3ux51YuTWWEuTPE+9X1ap+LJvRd4qYczuCgj00o/QCk6/Jk/kmDrYlUBWn/+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752794; c=relaxed/simple;
	bh=3LSpxPMPHBZB4XoJ6enxTlYmQ3Ui0OnSeA/df2jpdDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgJ2P4eqs4ytG5/2EUQLBJ9POb+lwW04iAtduis+pBmdthe2tNzo3785V3ygykwdD5OJOUQOcwkTtxRAbNsmZnd0LS4YHDlWgGdyJA904DwX3ilpnz8ktbvr+e1Yy5Ceb51IsAAyg8wp/q87pexcaZwpVPgwvLefL2t1abmpF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkeyBOw9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgxpBp4K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkeyBOw9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgxpBp4K"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U6pWJg3380952
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=; b=AkeyBOw9FW2rckWv
	Vksy8cusoSCYFD3vrzd+FV0OULCAi0g4+dbR1pLZqF+qsgS8LXdW6fwTz2eSmWO0
	U54kCI8Irq0k8rFQ/3jOHL9yIynVqDoHxBpSp8nzLjfGUiqrwWNSQxBfnnjtVZsR
	bLAXWg4EAz12sA1+kgNLXyCHIc3WBvdP9JErBlBrpVNDOiYGTd5EuT1+jiMkPsjm
	mDSM9ZFkfPlT13R7zVXIjC9xvYXqrMOrASAoWQajmyc8hzePX7pssQ51tgBHXXwi
	5A2rfQRsEZUJknQwUoHKa6xiiyuPwpmg+ymqHR+FW12MqrBAiUz/0jCCFbNdEN6p
	4LkeLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97tx4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:19:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a470ead068so2602265a91.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790752791; x=1791357591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=;
        b=AgxpBp4KZOi6WPIELCldzhZpPpNpoTfGOOiSTiLs1D9UxRFh3xAl7YRL2NdbOwbH/D
         xDnyTKzRf3s5DLVU5qoLrsfewfiA2arPmg7lJvlPUlCDNiLf75XruLw0CkYjW31nzEaX
         wokMq/YfZZPhzQrjyNmLLCRZVcsb+x8KfTz021PhQhE0oLvaLM138lako7PItf7qTAFY
         yulur0EPbopg+lQqFUI5e6NIeMzRNDGR4oiv3+IrnYOntTWuJ7Fa/mtyskzKj0M+8Roa
         HiA10srbmFO+p0tdzhQ71DJ1V+cSmkE0gHadQr9ijjj+QWftw59mdHMvr36Kc7I6ZRXL
         rvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752791; x=1791357591;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=;
        b=pUhlOxONiNsJTdTXHRkTXs7GPp5nnWoN3fGD6+rODZC5cDWcnF2fWDfbvvB8xq6e8N
         kVl7Q0AEvcbIej54Y31f4quXnXQBcpVO7WkLv2AREUReeZ/oGHtpIfnHGaHA+qfzyY44
         1mL1sNSpXbQQAdrNNO3GKybqXVreKS6rVxtlLMASyxXg5M6hM7Gw3NgRj1mmNl8Nd6rq
         EFm/45U70bMncIUCR8U86SJ/ZyoO3eFTbllDOdVcITF2TcIk1n6YVIoADVdcDUZy7t41
         SnsWTFPsuVpFrxGLIY4REgpLf0aqes5HbkHVfoEgyQMKZP1d3vViSOKfzVHwuaETODpg
         uiww==
X-Forwarded-Encrypted: i=1; AKwUvBxN1t5qa4GL9JMWbwuLHmR4zloGpJyl/8jLPk5IoTEPfgm+0tTjVa9vA+ZC5gh2VsjVg0IaXYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLDvxH1EdHukYFTOC4jxV1NV5a7beDC3+/bP1TKDNHkfJ9tBAg
	5sc7I7vx2L1/FnejxyqVf2AbMnmiCSfy8hsrY7XzzSAqh93x9z8OqoUPaIbwoI5jXIRzYlEI5Mu
	cuxi6K+ujA91/S6vZ++Pudl0kwI4Scbjn57y24Z7k2gDBkOgJfqrNx7XtUII=
X-Gm-Gg: AYBFou2q2y8PwcezdwxgjHAAoYfN1uFepvnDBNVZNR6eqlxfboUaNLHPD2ElrWQjQbk
	iJAVi6/QGqoNVTeoJrcm12GcLn4JbsG8qdIpVW9CblYHTRzolJ7V6KTkil4FU+kjYR2lbZn5kao
	algcu4XNE0Tgj4aj8usx0+Txup5jE9XlXfTDz56kxk/GDznuwnFDbEaiMSrA05v+nnTeePNbDgz
	T9wJWcUQTZqO0kp7nRGeQxh5bJxMUtUGaZY9TLBYlpJhMxDg2zPCdau2Tt2JFmOcDFoIfCLR5kJ
	A3fYOKqqlssiIEuJG5t3wrthG4FcSm1GgwwJbgBR+GGaY8+05MBzDGUoIqGMm1nRBHECSUayVzu
	Tey1KSVxaQv0B26hxL/G3E8tkXVSPRcZvRA==
X-Received: by 2002:a17:90b:1c08:b0:3a0:dec0:c0cd with SMTP id 98e67ed59e1d1-3a4d17a0c3bmr303034a91.28.1790752790480;
        Wed, 30 Sep 2026 00:19:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:3a0:dec0:c0cd with SMTP id 98e67ed59e1d1-3a4d17a0c3bmr303018a91.28.1790752789784;
        Wed, 30 Sep 2026 00:19:49 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae89d76sm2054551a91.15.2026.09.30.00.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 00:19:49 -0700 (PDT)
Message-ID: <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:49:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Daniel J Blueman <daniel@quora.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929041444.9837-1-daniel@quora.org>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260929041444.9837-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i4Pi92qbZqirOoCCuTL0xDCrZSFVeSy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOSBTYWx0ZWRfX5LlzCHdTfkYu
 RrJP4tYIxyz5UBXlqUcg2xtWY5l+R3ChnVvJKVBPVGgJ+PXKipF216fuOYDo18Wm+lUHO0/J+8D
 nqdstgtJDTQfUNEHlbh/HSALZptYvzGfkj6bJOTBDXtu9iV2wQROIbegz5MYiaEw10uyVo6uWLB
 5O51MhFVwfYWQ0QfAkGPYC2RwgruGwIsldu1U6XHBlEYpia5dfhQnjn1n8qYtgQ3a+SHh0HUr4d
 d7Ik/Fx4NUb3VcwZ1PMmLM0sllkuB5vwl9zwjEy9SKTUWRV/+GlsBGxzDkpyPfn/Wmid1cpThRc
 0O6UcrgbdOYQTzJan2FKfszIx4wDuTnQEu3pfOlHBU6FPmvXLm4Xz8t3k4R6Tg1dca8X3b5GOwq
 02P3koxLpN3LLTK5QGkX0dh5H3ubUIRX0vn4wsvCntyq1p8GJj0AXL2m10W5QhM7mmQvhppkWxs
 AmH2+eCCR9DnRM0vXfQ==
X-Proofpoint-ORIG-GUID: i4Pi92qbZqirOoCCuTL0xDCrZSFVeSy9
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abcb817 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=tsASe9PyN1Vfnx5TqtMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOSBTYWx0ZWRfX8U1rKkVm0Oy5
 nvMdDpSHwTDKYvBScaYRGmpt+G6AGVAB1JzyAkCMQGUsMfzWvNUvfRofgEfvUx24cAaW7mIrB/X
 Kfal6kmCyGCk2E7Wg5BiJOaxAwH+k20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300029

Thanks Daniel !

On 9/29/2026 9:44 AM, Daniel J Blueman wrote:
> Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
> SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
> timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
> on all boots, and touchpad unusable on some boots, resulting in:
> 
>    i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
>    i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> 
> With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
> versus the previous default of 521ns, however the I2C spec has a
> minimum tSCL of 600ns.
> 
> Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
> verified on Lenovo Yoga Slim 7x X1E-80100.
> 

There might be a final count which i should get and update back.
Since this fix is working though not suggested per hardware guidance, 
should we consider as temporary fix and move ahead to prevent failing 
usecase ?

Any thought @andi ?

> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 6a39e21d5ed4..1336a09ca183 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -193,7 +193,7 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>   /* source_clock = 32 MHz */
>   static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>   	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
> -	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 5, 9, 19 },

Exact change to come from hardware experts, till that i am hoping this 
revert should be fine.

>   	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>   	{}
>   };

