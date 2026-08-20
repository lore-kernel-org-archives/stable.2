Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A11F8AC5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204402; cv=none; b=aLvwA9S7XBtiUpjVXz9GZxNAb6OS+PF7b1Xd/fGDSQ8D3bOxp1F/PQkAotua4kqMFxi/tKY4sXH5ysmi8bSk35SDF2EF4VjEYciWlO2ilebn+6wfqsAmwYeDJ/hhVBZ4NpmY2HbU06McmJ9/MTiOkldFohQUUQfVGpi7WUmgTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204402; c=relaxed/simple;
	bh=sp37ocaCCvh8mEqRApDXVrf0uLcNlKjOJsf8ZDK0AHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO0Vf636HMbq5l7aZcOeDJdauwilBt4nSI93dliviZ+DR6QC/uY91Z4eESELsh34e22G07/eECzWDw200RYZiCxYA7jn0TQ4YqenOeayMaF0HRFGM1vTrz7YuciYPbqxyci4c6EpuaGJEmYhvqBI/3P/u14DgHvKMQXWr7wWXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=his1vNIR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aiI1QpJ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="his1vNIR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aiI1QpJ5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K5ZDCW490916
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yr0+nommJTYT2OfeS5drPEQCv0SxAJnJA6eqUOoAqvE=; b=his1vNIRL81fFQ5W
	WGjoaYBN9WHeotrO6UdjbO5nrnHYbJb11Zwf4TsdUPfOpnprQm5ExqZ9+Rxt9sOg
	lu/KbJW+2LBvWRjZb4tIMe131XrqJxHeGoSvfEt5clDDkiMutXpZUfsStxwKT9h5
	Megs24ykqR/owF0H9OH332lZmU+TYBfSRW93ZhRzlLvs5n0tDq3OfAxuIFeTfWKL
	sAZsMzq7mSa7edPDKCZasvXZSjYM5Nw4OPDs0rmkHt+RIBbaWBk1uDEs0IqLBG3e
	TLCSjvr41ueHnTe7Edjnqpd2F7qJsjec8Gw+SG7VRzMqWDWNuQNU6A/9RYG5eKx6
	4/rFYA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervkc0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:39:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1526762a12.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787204399; x=1787809199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yr0+nommJTYT2OfeS5drPEQCv0SxAJnJA6eqUOoAqvE=;
        b=aiI1QpJ5uNPE6NJvMJOypeQYj4lbZ2IXpGS7GdHgkDFXNQqVnPPjlU/eIGfYfC064X
         A//ZNMIu0xbjcGKDD3cIbUZFaDrEy0W+BVvxqG7vx5E5PIOItmTTA0eLEOsD+R+6MJWt
         VVJe3ci0TA6DQnX1e6ijhME1TZsH/xk41IAPWbFBUfD9QCs0vmqzVTi46BriTReDTb0J
         IwAffCdUlYsdze1Ia+FGq9p2NMqIt8q+INbnECjnuqo0z22moo2yZD+NoMrlrr6QIQFF
         TkTHdNph/XS9lbZ231DisVK59mstItlBqZlL14NTy4cr7qpCMlAfhxUxdVT6rPgLPqEg
         0hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787204399; x=1787809199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yr0+nommJTYT2OfeS5drPEQCv0SxAJnJA6eqUOoAqvE=;
        b=pQXiwuvh/1MXYntEe0qILt+MBvWGmO8CGC7ks8HSmijRIHsvl+EgbkV06uIFuoBR3h
         QP0PU540z/B2fl+EEwDIVqjzw2BfEWkK2kWQ6GFdmIAyEX6MAioJnOXm+F8SqjQ08Axm
         0N1DTMKdB29d+47AyqhqFgtPE69c4Msgbr+brNIEL0sCJk/zbjLu2B2d5RZ8j68c57oi
         jOQI9Gh9ivjrEeOvdPTEEkFpNw/KRiUuygKuXN6BhQQ6kuXNaOsoOMRqJocw2IP/9VTi
         31c0e0v9Q1Kh06hKnNIdldS7uIr2q7A/cWakNSyFLKExSViQ52+MXioC1Lj8zZZoFeRM
         OFWA==
X-Forwarded-Encrypted: i=1; AHgh+RrukCN176aZwIlrkc9M44pbbiUHxICEccdeBg3+VVU9A9tfBpZxKeqso/1050lwhdwkX5VX8l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTU09zqSu/LvUQubH9kb/MGiyFYpzlW5aijp3dcnba4BTCFH2Z
	b81RxL8PNR59sd7r81NLJKgn6f/MbdHCTll4NEJYvRzduW3SE1h2XBfpKFTzUlGWOLYvhMpgqf/
	RwbhMeBzWO4XvqVwlLBRodNfgpYVl2m+yZTMR5LJjCpannByNo603/vGxdcc=
X-Gm-Gg: AR+sD13XHsqkcSabdKYcvDKt+5Ypr34LZ6wBc9kdYUzKXM88rMSgXkLTleofpvl7eRH
	0Y0yetEH3zu5ARh+NwXsXEvplSnzCz5wCGMpsyMWxFM7Ew4P2boONxCslzd0rwM2EV/i3OyGB37
	stA+RHRtmQG0dX58qdFy8QjoT04fw8LTDAoHPRbpV8jIsM68gwaLB7BjMleI1edobAJnAyZs+Rd
	JzQZSRPPln8Zke82hL0gVcqXyKR8JvipwstwlI81lu0Qd5TrLhHmvLN0+bEvoC+9oO43TCOZXiq
	8LsU5jFi+acTqSPMUrsjEaBeNkNiNNJKtUToldDOGtnQkhIB/WLtkGdMbDtavvsh2yPByvnp49Z
	ZVg8tDv39sZsuMxgzsHmx5Z88J6IH73zVj04A9PfjbjRBjS9TOQ7CnuI7M/y7UOIy
X-Received: by 2002:a05:6a21:3a85:b0:3cc:a18c:b6d1 with SMTP id adf61e73a8af0-3cd019dc603mr20385937637.17.1787204399322;
        Wed, 19 Aug 2026 22:39:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3cc:a18c:b6d1 with SMTP id adf61e73a8af0-3cd019dc603mr20385857637.17.1787204398872;
        Wed, 19 Aug 2026 22:39:58 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523b579sm1412666a12.3.2026.08.19.22.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 22:39:58 -0700 (PDT)
Message-ID: <181944c2-2484-4384-9c91-45cc87f31955@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:39:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mieczyslaw Nalewaj <namiltd@yahoo.com>,
        Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260730191353.557494-1-kuncy7@gmail.com>
 <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
 <20260803091003.15285-1-kuncy7@gmail.com>
 <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
 <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H-kdybX0GCpjcaLu_zf70rZViO8jKk0P
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a869330 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=BrIDYzEHq6298WO724AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzOSBTYWx0ZWRfX0dngovOrV9Yu
 NnseNYoAqFX3pR+Z2PPL96PMo6oMt23YgO3ghcAZPrY204p/ROVYQwz3GJBLi0WdJCmSR+JJQ3v
 /Y8hLPzPKHqh1HMIsRbzNG6+4RkKsC3ebWoXucDDxvYXP8YBeJSXMNGO6ga3UX8E5YF4XFlT9bS
 7qUXoClxoPjYI6F//cGH78cr+0ZjGFXdZsST0tsDoU7L296rTgkAwjL4BlCQy9nJvxLseHOrtof
 kYHxk3KkaCAHx/2+liRWdkUt2AbJVCoykzMY95m0eCzIGQVgL1Prp0Ka3yCo/+XSboz7GtGyo93
 J6cww+v6Fp/ITN/qqsbKnrh8sVZNe6oOU3/qenJu80blsX8hK6C4VBgweBNSRk+SZtbMqyzIGA7
 zc8Wq1oM3CLEYn0RjfZMot/sKQLQ9M859K8112EoD02XJGqdIorZgI2W3EcoG0V4RlDJ2f1yZTW
 grXxpRxpKxdlzSNfjyw==
X-Proofpoint-ORIG-GUID: H-kdybX0GCpjcaLu_zf70rZViO8jKk0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzOSBTYWx0ZWRfXz/tcDY/q71HE
 HK+ycps4VC1PKZBobWL5cA6RGwznUdTWPDvdl5rZPxryQyKAozHzIJYCNra0HGg/ULPPWZPxwzj
 FaEDOVW8fE0pwBebtrgwxre6gwu3hsc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200039



On 8/19/2026 9:00 PM, Konrad Dybcio wrote:
> On 8/4/26 1:03 PM, Jie Luo wrote:
>>
>>
>> On 8/3/2026 5:10 PM, Stanislaw Pal wrote:
>>>> The CMN PLL AHB/SYS clocks will remain enabled as long as a downstream
>>>> consumer of the CMN PLL clocks is active — this behaviour was confirmed
>>>> experimentally on the IPQ9574 platform as example.
>>> That is exactly the mechanism - and it is exactly what IPQ5018 does not
>>> have. On IPQ9574 the nsscc node consumes the CMN PLL outputs in DT:
>>>
>>>   ipq9574.dtsi:
>>>     nsscc: clock-controller@39b00000 {
>>>         clocks = <&xo_board_clk>,
>>>                  <&cmn_pll NSS_1200MHZ_CLK>,
>>>                  <&cmn_pll PPE_353MHZ_CLK>, ...
>>>
>>> so the device link holds the supplier active, which is what your
>>> insmod/devmem experiment shows.
>>>
>>> On IPQ5018 there is no such consumer: nothing in ipq5018.dtsi references
>>> any cmn_pll output clock - the only occurrences of the phandle are the
>>> provider node itself and its own assigned-clocks. The actual users of
>>> the CMN outputs on this SoC (the internal GE PHY and the uniphy blocks)
>>> take them directly in hardware, with no DT linkage, so no device link
>>> ever holds the provider active. A few ms after probe the autosuspend
>>> gates the AHB/SYS clocks, and the box dies on the next bus access -
>>> which is the measured behaviour the patch description quotes.
>>
>> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
>> continue to operate correctly at the fixed rates even when the AHB
>> and SYS clocks are disabled. Therefore, once the CMN PLL module is
>> loaded, its output clocks are expected to operate at the correct
>> frequencies.
> 
> Linux sees there's no consumers for the clocks the CMN PLL provides
> and gates them, subsequently also gating the PLL itself as all of
> its children become offline.
> 
> I can't find the docs that would show me what IPs consume this block,
> could you please help out here Jie?
> 

On IPQ5018, the CMN PLL provides a 50 MHz output clock that is used as
the reference clock for the connected Ethernet device.

> Konrad

