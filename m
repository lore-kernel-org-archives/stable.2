Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC3BB10C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905558; cv=none; b=rYSiBM+87GYeD11IaSCrFQ/Im9rMmUrB6d8Lyr7RMRxfTRs6ICPBwjBE1e+aR2Ky9wx6nAqflRZFLfJd3ePVFAOORNUdKcLM6Csc3/alDq1/s9mSOcoUXvQCbXsMx07Svno+F4nS7OPn/wq90usgqdMHfZaZdY3+nfjAIhRHas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905558; c=relaxed/simple;
	bh=1JtHhocoebZrFTJvALnvfNyMzljsrMzzzAnR9dePObY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyLI76nzETcPyUAciq7CNUu4mhdMOABG78lKKtFpQ7AWoK4YemcafjXVtr5+E6hyWyPU5qza0rMgQE8Le34O367XRVOHtJELM7WZmVkcsS+/HsXFg40o1oD0/YxNgdpIgBLHEk3mQDIZVo8Wp2z3v0KP1Uu4WfdkJdkie+RJqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mm6NVZEx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXPVIOJA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mm6NVZEx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXPVIOJA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6752bGuX1524355
	for <stable@vger.kernel.org>; Wed, 5 Aug 2026 04:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hy3gD/hWNpj5QmMEer9j4z3dhHyI6Fp27IAWNLW3gwg=; b=mm6NVZExLyiYM3HA
	OxUB9LbBVxc5bLF41vlaWFWfUVpdXNqfEI8fZwayGWQnSWH2AZpwMhCNCqUQL3nj
	+uAW+efqLKqU/4zzoJkEHIigu2wAD/ZDieB2kWMcIZyuFFvp6hqfIYdLi+GhzUs6
	T+HdnX8OMnA0QpvjMAb8ydHaTMg0feiwhcY0paXE30dRiBgBMMzslutEGN9dQBEK
	wVBgqQrB2lgjMfgoi41r5yyWU3OewSfxS98siIhgjL4lQIg0bth+D+P1XThBkXq1
	gvXD+clWyffFZurqo8km5SKCKIE+znp11mr32WmX+m5g39BLioe6w+iNmSJzuBJf
	mm+eqQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3ntma5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 05 Aug 2026 04:52:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso564528a91.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785905554; x=1786510354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hy3gD/hWNpj5QmMEer9j4z3dhHyI6Fp27IAWNLW3gwg=;
        b=hXPVIOJAkPWjEllXUqTZMYQPr/x8ZGrWgYuz6xH6q8K+j551jP/zvDAc/zNhZZbwkP
         O4eucvnb4KA5vNbjEomayF9UBR20V55lkAr10eNnzhzwf+cw4rnw3pXtAvZjvBKF+qTW
         mkNZjhvX8KI5/p+GoWGgkmm7KSnzcNxbKuHE9LwJtQ+Wu+MoD8z8jDO2cNn6VK3aM0M5
         Vl+pEnr8EXl+GrBKHya/Pjyd5vLfMU5VnQ1KvjMxJmfcI6pqyI5cZUAzOqbfbwK9byO1
         rhq/4MdTMj8lcX1h1Wo05eeTXOPc1UlP6YO8/iywDfNMzyFov/Ut+eLOy6p1cIKJ5CX5
         8qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905554; x=1786510354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy3gD/hWNpj5QmMEer9j4z3dhHyI6Fp27IAWNLW3gwg=;
        b=Jluv2xX9ePJCfuSMqncquO+vMYiVH9tHVVQd11v4n4HbzD91AzaThOmMxrhhfNQxzm
         HrGt1BH3w9uz6BYH/VKCP89FbpLgQgK/4OFABrfvG6MEDqCLs9g0/zNbjCYSpVloLNcP
         e5Q5rPCelcJMGWQqPqyKUJo1pTT8uw3+y0Q39AnsPY3Bvhsed1YSY52qT1z9xGPS0Imy
         /ylmckVbGXAWXcWFWpPZMKg4nQ8vsSaRxB9m8gzxnNH6JsvwWgH2dCkwUJ9/r+UOoWI/
         7k5xbteSr1zVF4tVWQE62SGCkZqPaCHyJxqeqyubkh6KbQhbA9mcHpj7CV60yNb3l1HC
         pshg==
X-Forwarded-Encrypted: i=1; AHgh+RpMMflXDCEK/mslRdJOGun3fDYoB4UI3Ckh5y2RGouEOnz6deMwaOLpp8I6MI4jlFwNd0iFV0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFsEUu+6fk2l4UF/TiYsvEdi8r7LcPU2UKll6+PgvCTWPL33V
	1aToD0dE+n2kWzrq08uICwHUK94nlYEyXoLk1ov67CBAQgDq14l8YouJtcCCEiXBTT5a8xwT37H
	K9nPWBXuLlGEcYx1/2tu/3ITzBPZtkyGrG/+tPxieausSmqvGbtfJEQUZwcM=
X-Gm-Gg: AR+sD11Uoyc5SLtoMoQy9qk4RM5FHCWx3Ymowd5un4p34WiAV8wrbb1qWDUYq3HqGFp
	8b/gCOx1nD0aY2Eww8tLNLSSTFlErdohAERSn+KfEUhW6ciqGq1FwHSieLrK85ehjEAjL0vISP3
	4rDiCb3MCg6+Cyz7KG/Acn2cuZBub6gPwO2kKvnmJ33iTcOLlkkoXArEj0ROT/GKorDL8JDcWyy
	jGWlIHmQQHkQiEk3QX+Hl/GgXBdj2y1lyftkGNpz0S8k1S/afacF51lpLgzPi+CYZQe25c/fM4h
	rBFR/i6TPZcquEuru6LovActHS8r+ZlXNrFGsaGw0mk0t/nkTOvu5veRowchGrdHLCX9h13a/2M
	6RtjXyYDvT6V/ehFPTIe9Vo22J2149p6soQawSYK4UvvwkgIqUKWtX8/HQ2GHO3OnIA==
X-Received: by 2002:a17:90b:1e53:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3903c5f34c9mr3217745a91.19.1785905554171;
        Tue, 04 Aug 2026 21:52:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1e53:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3903c5f34c9mr3217722a91.19.1785905553703;
        Tue, 04 Aug 2026 21:52:33 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aef87sm1652224a91.13.2026.08.04.21.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 21:52:32 -0700 (PDT)
Message-ID: <1dc44e5e-7787-47f7-938f-1ac0676d96d2@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:52:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mieczyslaw Nalewaj <namiltd@yahoo.com>,
        Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
 <20260804115817.16886-1-kuncy7@gmail.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20260804115817.16886-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDAzNCBTYWx0ZWRfX8bsOXviULQzp
 IfYwkxlv53icZaakQc1JUIWgWOs6TsderXES7htW/GYsCe1HCJulbCbzPmSNzUjwtORgiqioE6g
 G6AMAXOld5Rb7dw/9NTLi/nh5c/WpZ6KQ4j16gxZ4saM4aWZoovQzCUZ3qCF/HYUKMc9Pkx1CMo
 PuRbL/g+BAtPG8YpoOXNa61m3cXodhSlnFeJtO6vvcAiRCnN/Pa/TyFMBmaoZ5MegQutqhjXSxA
 53hBS5AhXqo9Rpr8VOrT6LpxeU8ez0MPcSteZI3nF9n+IZNGPGoG0KfAD2LZMSswTWXU7dJD7Fg
 VIpQ2bLv1p9U0lFDIlExuV/upVYtbVSycuisFYTQNJy6/vXdu8I+z5wAsRJtE+4GzrYq+9IAMsA
 ZKdeVVf2o44WbiZ8TehZcMRhkmvOZPhN4xVarfh6oYy5k6Ez+XVkk8QyzEOal1+GFc3qaxWaxpB
 n8rPyzHPGGEPXVSvV1A==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a72c193 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=BeYBAa9Oa5wRmjjIsxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: I2NKUbCgOvBBH6xugrKVFdao1FMIle59
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDAzNCBTYWx0ZWRfX3fEyFY6x7QFc
 93qeof3v2TjrE/iShFEUg+35cj4SvZvpOwjt3ZXCmeHp/FqnRIK1C1EgeFe5bZnu9SUEgfKyuFj
 EM6k7xISOdy+eoYgNVboRwUukjNfQxE=
X-Proofpoint-GUID: I2NKUbCgOvBBH6xugrKVFdao1FMIle59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_01,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050034



On 8/4/2026 7:58 PM, Stanislaw Pal wrote:
> On 8/4/2026 Jie Luo wrote:
>> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
>> continue to operate correctly at the fixed rates even when the AHB
>> and SYS clocks are disabled. Therefore, once the CMN PLL module is
>> loaded, its output clocks are expected to operate at the correct
>> frequencies.
>>
>> The downstream consumer is used to keep the AHB and SYS clocks enabled,
>> allowing the CMN PLL registers to be accessed.
> 
> Agreed on both points, and they match what I measured: with the bus
> clocks gated the PLL outputs keep running (ethernet and wifi stay
> clocked), only register access dies.
> 
> But I think these two points together are exactly the argument for the
> patch. The register accesses do not stop when there is no consumer: the
> CCF invokes the driver's ops regardless. clk_cmn_pll_recalc_rate() does
> two regmap_read()s and runs on any clk_get_rate() of the PLL and on
> every debugfs clk_summary read - the latter user-triggerable at an
> arbitrary time. clk_cmn_pll_set_rate() likewise accesses registers
> whenever a rate is set. On IPQ5018, where no DT consumer exists at all,
> every one of those calls after probe touches the block with AHB/SYS
> gated, and that is the measured hang - the boards died during boot with
> no userspace involved, so an in-kernel path hits it too.
> 
> And note the consumer mechanism only guarantees access "while the
> consumer is active": on the SoCs that do have a DT consumer, a
> runtime-suspended consumer plus a clk_summary read is the same
> access-with-gated-clocks situation, just harder to hit. So having the
> provider hold the reference for as long as it can be asked to service
> clk ops - i.e. while bound - seems like the robust shape regardless of
> platform.
> 
> I have just posted v2 which does exactly that, in a cleaner form:
> devm_pm_runtime_get_noresume() in probe, so the reference is dropped
> automatically on unbind and the existing put in the error path stays
> untouched.

Is there any use case that requires accessing the CMN PLL registers when
no downstream consumer is active? If not, I don’t think a fix is needed
here. As you may have observed, debugfs clk_summary can still display
the clock rate correctly even when there is no downstream consumer and
the AHB and SYS clocks are disabled.

> 
> Thanks,
> Stanislaw

