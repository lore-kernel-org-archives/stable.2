Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A630DED5
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144466; cv=none; b=cvY5B8SdF4r0Yy/GezvSuMQHGzJswuAQWTIuzWMk0dcdBBb+OEdOoTwMbRYqD1Xfe3wnYBAROUWQ08UibJatwqHpbOgdsjoKHNMolMbqsSFIQsE9zLVkSkABBv0YDDKDiWAs/mvHp6LnprnJHmi7c3QSnRjlLF833L6yqTenHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144466; c=relaxed/simple;
	bh=VZHnQPoCn9GBriYz27om5Bobo67ZK2vwUDrWFIKF85I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctwSJ3PFEI1O+E+6GrmaP6vAJbjgWp4bRZ+BLARcmysr1dcHm++T06L+mzExkG3QFgb53Ei5h3OrPz43AHszsETslqNhWrFhVvkrwLTM7H3VfFV2OCoJ8ZMUZ03+/rBV3EOcd6akrxGUjVQK3hzn7DG18chfuA7S95eGUtHiHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GIere6Xj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+w6GP76; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GIere6Xj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+w6GP76"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0QXc372683
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VwGkEVKn5pCyCeQJq0GNY+Q9U4bmzQvlyvJMw8F30W4=; b=GIere6Xj2mP7Ceyj
	fjtfXAJ6BHQQ1bAaW9g1kMMKEixfhCaSs2sBOqAd/qvL/VJo0pQM9Koj08W8JkDG
	VjevGjMzgXacHnjEcMuNdHqi/II4c11oG50ot0DQ5BI8Us9y6YnxJUQTpOhk03NR
	eJwlTMugEXTh4U1G+Qu+OENP+cgXFWOUZGu1CHMzo9JekDz7x/0ALlhR2A+bV6Dl
	OP7+AC9QmfYD5GcXHce18okiMT1b3RbNsSj0ZS6MjUG0WYeFUK6bFuGcS0WtDEkZ
	5u0zAOf+0KSY1extua4WmchLtPXE6AfrTb1K/s1mpro9uN1ySf2ENIaYB4wnVy6V
	BY00lg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkb9ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:01:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934a8cd3a8bso9073285a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787144463; x=1787749263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwGkEVKn5pCyCeQJq0GNY+Q9U4bmzQvlyvJMw8F30W4=;
        b=J+w6GP76S12E9Wue3gOUBybIeRv/5FE85LfbA44l2Iscpjr9CJ5/c72ZXzEmZDG0D5
         rgrdyNRKvBZ3Wmmud0PuE1WeiFLTYr4eyGMDXh13AbB0Ar4r+lYAye55ByaPpBqxQv6x
         ltVzk3KQK5CWVvljZzRBzI/jWluyw3fFR/kftyijA6xSW3ej7fHTvbmfjIoWDtJEPuv1
         5uTouWKDqJRlH/n+2rXH4l0a4OF1/i4E4Yx9Tz/tL+pjwciBhgp7RhHGJuyGWn0T5EBS
         QTF53QpL78kMz0ZEC1pMKo4nEXoNwV6xVIb/ktuqzLYu4xdJFUgiYercv7WbD5i36g1W
         2ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144463; x=1787749263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwGkEVKn5pCyCeQJq0GNY+Q9U4bmzQvlyvJMw8F30W4=;
        b=CZ5v6bWZd2tHA+du3aAGsQmdbthgWr+MeTSnqO4Y2KwqpCwPoL7Cv4KTyF14XJ3s7V
         60tr00tDJqX+zYTQnL676Hn+V6CfY5lyD3TizxoY57ynd56NnWqGvC9k+VQZF4/EBVnj
         nGmF0kbVpAXgd6ms5SZar8sQNsQDV6CXad1BoMmi4HaKnuBE4A3Sm0ksxGzl2zh0fz4X
         4pB7ruJA+X/b4o7gbnRXTllsQAP/WO5T1+ZvVHvI1tIcqQn1PZIpYnlOESDmNmaVIRxU
         gW6KEk46QJymvhzj9zz5hvmFzAMYzJBOr8f9WhUyEdUFDXxkxyHxLqTHKJCPE7BGQ78E
         hp3g==
X-Forwarded-Encrypted: i=1; AHgh+RrgbK7HBeuEt4sRXKNAvJc1QRbmrLmoCFZbHTT0OUcKWYI+vn4OvA2Q45wzGbjwr05NE+uz0mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0SejcIIXUxAow+P1CqALZdVvP30VqHWpY9bcLPnZO74msVqM
	eW2eaTE7yDxL2LioDJrBDIHdSAnfZQRkqi836rRQM9MTxishVYHNsYAOaGQonE6dRqfdoQqa2tR
	/fdwDxxWxuzxmGAvfeN4cbyD+dhoJMGX7VCtIiuXU1NKqsX1GUaKL062672s=
X-Gm-Gg: AR+sD108TkjhRbp6lbJb8MtRxKcj1IkSwQi4U97j26Df/FIKiOq2L5luzRcQjjDVZFk
	kP+bInfwCXqorECTZCyNY2coMBiTM56nzvpXXeCFEfo/zkArUf6f6ZN7zDYQ/PRnSR/xs+XxRuy
	3n7RAP91IKXZCz9jfSIbO529oBVIOn+McpVnNdh9wuCQjZO+7niQ1gJOWBd2Ntrz/RsNXAH8Uch
	ZY1VzD54MTC+wMsqJyeOYYBt4CKyOpw3TdIb3JohBnw0A6k4prjBrVkT3RCl+yk8t6iliLcehsK
	Q7oMeK0Jv40+L4106Qq3Hidd8ELSceanhVJeymlJdoqMUyLOQIMsMI3svQQfpX9p4QHSYKSDT+y
	AzD+cX/fpLXpneA7oT+oP1CLg
X-Received: by 2002:a05:620a:1728:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9371e1af3d1mr306224385a.0.1787144462683;
        Wed, 19 Aug 2026 06:01:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1728:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9371e1af3d1mr306215585a.0.1787144461995;
        Wed, 19 Aug 2026 06:01:01 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478854951sm502596e87.3.2026.08.19.06.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 06:01:00 -0700 (PDT)
Message-ID: <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 15:00:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Jie Luo <jie.luo@oss.qualcomm.com>, Stanislaw Pal <kuncy7@gmail.com>
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C4CD_WjtkwgwXjeakAarBMThVg8ThveU
X-Proofpoint-ORIG-GUID: C4CD_WjtkwgwXjeakAarBMThVg8ThveU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX3FBSaOuU5kH+
 n6yQNeLeymdYwcCd23JleHAySi/mssw0HVIFXc0rr9j/XCrx9z3AzdbBy3/QKQT5AkM89ax/S6b
 /cqqhQnr+dPWBiqTjR0ZNtRdBaz19whgOnqvGS1Gg4RAUAIXnUwGddm11NixTgN3xH51hJp8AmG
 Rz4i/+d6h2ppeIxJ4Cm4NcKxGtK7KyPxwF8Izck71aSB16xpdR9ihBDT3Kb6aI/iTbPbP30VtcI
 VNDzejavCAUKVVGnIzHTxkzsSZz07cBTUdcRawmrb/mZ1ShA8SPyEC91UEstDthLR28e05gFdul
 zoXsVf2viDk0myBR4amkygMrhLlm6OB9WGcpDpP4vkg4m35ciW2uZQ6JSFulk+50jrVX6fAUnsv
 VANGgkbp+GpTRrysGFmMCVORImCMQabmWfzyAUuK1kaGEomvZ0qF83fLT58DjhaBmALA91lPqd7
 ME2QoVPUdbgyHKNm7cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfXye/YkHRsji4J
 q1LADzhLQs7m6iBbpEnf0TGO8hKbGG/PNdlSTutcbl49pA3q9VJl2FQkyh9pLAwiukVdgFzBatX
 HxAAiJVBzDD/6NmrO6w7P9HFFI1xgBQ=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a85a90f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Cml0np4gJbHuCS8qjCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100

On 8/4/26 1:03 PM, Jie Luo wrote:
> 
> 
> On 8/3/2026 5:10 PM, Stanislaw Pal wrote:
>>> The CMN PLL AHB/SYS clocks will remain enabled as long as a downstream
>>> consumer of the CMN PLL clocks is active — this behaviour was confirmed
>>> experimentally on the IPQ9574 platform as example.
>> That is exactly the mechanism - and it is exactly what IPQ5018 does not
>> have. On IPQ9574 the nsscc node consumes the CMN PLL outputs in DT:
>>
>>   ipq9574.dtsi:
>>     nsscc: clock-controller@39b00000 {
>>         clocks = <&xo_board_clk>,
>>                  <&cmn_pll NSS_1200MHZ_CLK>,
>>                  <&cmn_pll PPE_353MHZ_CLK>, ...
>>
>> so the device link holds the supplier active, which is what your
>> insmod/devmem experiment shows.
>>
>> On IPQ5018 there is no such consumer: nothing in ipq5018.dtsi references
>> any cmn_pll output clock - the only occurrences of the phandle are the
>> provider node itself and its own assigned-clocks. The actual users of
>> the CMN outputs on this SoC (the internal GE PHY and the uniphy blocks)
>> take them directly in hardware, with no DT linkage, so no device link
>> ever holds the provider active. A few ms after probe the autosuspend
>> gates the AHB/SYS clocks, and the box dies on the next bus access -
>> which is the measured behaviour the patch description quotes.
> 
> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
> continue to operate correctly at the fixed rates even when the AHB
> and SYS clocks are disabled. Therefore, once the CMN PLL module is
> loaded, its output clocks are expected to operate at the correct
> frequencies.

Linux sees there's no consumers for the clocks the CMN PLL provides
and gates them, subsequently also gating the PLL itself as all of
its children become offline.

I can't find the docs that would show me what IPs consume this block,
could you please help out here Jie?

Konrad
