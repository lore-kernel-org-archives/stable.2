Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A114552930
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955951; cv=none; b=Bv0+F4i8+aRjBdIPMbI5+aiUWjuO+GHXO+v/9QkD6kwJK8UQPXn0puxaW0DcT901fRqYIueWxKSylnXfiqGFZvkFfUjlPovh77zK+IwJTKsgnAh5CxIVFqzoND+KvoDaQEOMZuZRAre3boJoTZJ2zrQ+H6uQZ0Hyq2dPoYZ1ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955951; c=relaxed/simple;
	bh=Np7c5aBXs40Izu6BhIoBcwK6jKTo21Aj+MxYQLBZy98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTjPQz1cXVmqtGfNDhW3SPltbJQEZsAfpEXwEKRx8ZgjmUFDCfgF42q3sG32ltQ13DweAGpPOZzrH6TSd9LLeA263UNBViehRbr18nNH27lvT6CQwX8zF3AJ8MyjD/UfBEpI4/DwgAOcUYwRb904QKXjbk0DTfmewMCHqJLWBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7M4UGz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IWirkZ3y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7M4UGz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IWirkZ3y"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUCu02019456
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 12:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qdXJHKg9yw3m3xvjN/96iKJOr0TVN9REc8Mom5izEBY=; b=C7M4UGz4QFPthV4l
	yS18nJkdeOLTVx7y2IPax42+mmc3Hn3N/vFtUzCkfsi4g1TpYRnWBjn79I4SjjQK
	CA+Rw5WK+OM4fY4WM6PCNzUVoloKqk2tP/5xDCRp6ybEy8RN1hIESUbo7h+YUSYa
	eopKOdWSgbvf0JWgYg+XXlzknNWdemqgqnpNS6F8UeGZocMSdLYSuCrdP7yv28rW
	8ymbtsktpmFoMPySPTcJfEMtX8cMWgueiHcnznBzOxiq15yVKy2ludY050OcmJHi
	5zslGt6qMPC07koi2QMGURnRkAxmGcgaS+GjXKSC2hf2F0NbXtKPztONVv5f7Gwd
	H3gpAw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62x894w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:12:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e8d3a2d3fso11763976d6.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788955948; x=1789560748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdXJHKg9yw3m3xvjN/96iKJOr0TVN9REc8Mom5izEBY=;
        b=IWirkZ3yI9EI68EWCLeqmB4c+t7Khg8mud5Yo4kEwsT5zLYoq6JjGcIIevzpTIq1wm
         zI6TmknUbMT+OBRNX9Ax5KoG3jbOYhjrVQX6DAuJ7+/WzfIhWXcEe7imF4P632mXoYdZ
         9jl7wKHaNd4LrVI76pLAlCAYEw1c0y4/KUoQT9+HOWlyJUSkZ6/oaNmD/Q1r8V9NNPW3
         PAgg51TXmAhCgEwWeZXOceIM7YG5mAOBofTNAFLCwzyLkOJ/eWqFZTqMv97KbRSrZAJZ
         NYQ2IIb2ct56rJlvVJulDdeOgs1oqYyPP5J315VQkqjBYqr50x46shO1FVKq1L5EcduE
         jXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955948; x=1789560748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdXJHKg9yw3m3xvjN/96iKJOr0TVN9REc8Mom5izEBY=;
        b=nd1AvN+cTCZjepXt03AGS7udnoYd5gmCfgCIEsXDPpITZclADkvHHbqoJkJ6+U95xt
         vp3s2gvF+eUEtjehJumwDzxIHwrNw71PUaU8amyb8Aarz84/rTgzCUl5AFSgNDkTTQQz
         5trr8kU+FESJZTfDAODsY/FN4mZ73vJm9ubjYqCd/KnyrzAk3R6UUpJQcoVhMSSmEieP
         v27Hi9PciJ0T3bTAUFdJGwKON7+2UtAHEhvYpj4IMEaYBKtRe9rKJEennN2gQcYUdv4f
         yTdFu78HyI2hg/3u1l6P3gcXyDODGo9r0/Rqv9FfTlnQdb7Wwnv8fpN+9TXSpXA7pnXU
         oQxg==
X-Forwarded-Encrypted: i=1; AKwUvByp7hdQrZTt4zw9BHrbZBMAZUn8ZXtiTEBA3ENTWfQLI7l5q/+zR6ovh9Hb/j/UI5468UllU5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++ka7lvtaRgdFgouiMA8AidwhBE1p3tHENYaVDWatEtwiGHcvNlc
	0H5QcLIkqz5nTGXDkihWJgYQBnLMvEVVeI2L8jB2hF2xyxIEMgfcojWrmFda5SF5kyTNrLodkDR
	/mVWI3vUwVd8rH6VoSvjnVXijvJ0RQYpKuC3v1rJzyblcgRZkdgwWN46nnpc=
X-Gm-Gg: AYBFou3YhdTIdl17oOWr3jYDHAmIkgaFhZgZEJynSzyZ4HIR51/RMjDU7HcK+pKF71+
	HGLb+01zsQ779aiC/YHuhDTwu5QrPUKpf1m8tgc/z8yooUAiibYXZfuclHcmm7qruLkbwZVs8zr
	D+toTl1dsZTvEv03MyDiM1WFUS+PoVXBoyvv3EJogR2h1CKbubYu8NClNODydoRqpWnlD2py3JH
	jMVDg+I/8XzsIhGPaPw8Srd4v4Df8lG7Q+M8yC9G+FF38mBUL0K4ozZQne2JOpbXELx/IAfTjhW
	zoEUQ+ymgZh6f/AfJPNhW1Xw2ZpwxBUUmA36oY9PQbA4pDwpHyNQkRLUPngbgDZRhkGk99ZVzgF
	QAYFW0ajUBNoUaZlUYZvxxQ==
X-Received: by 2002:a05:6214:5012:b0:90c:c716:91b5 with SMTP id 6a1803df08f44-910476c940emr268734446d6.2.1788955947909;
        Wed, 09 Sep 2026 05:12:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5012:b0:90c:c716:91b5 with SMTP id 6a1803df08f44-910476c940emr268733556d6.2.1788955947372;
        Wed, 09 Sep 2026 05:12:27 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036902sm752132366b.3.2026.09.09.05.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 05:12:26 -0700 (PDT)
Message-ID: <b58e3f64-1a5c-4db4-a51b-7138fb3609da@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 14:12:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Jie Luo <jie.luo@oss.qualcomm.com>,
        Mieczyslaw Nalewaj
 <namiltd@yahoo.com>,
        Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260730191353.557494-1-kuncy7@gmail.com>
 <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
 <20260803091003.15285-1-kuncy7@gmail.com>
 <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
 <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
 <181944c2-2484-4384-9c91-45cc87f31955@oss.qualcomm.com>
 <8286b42e-0314-477b-ac2e-4b410a97d833@yahoo.com>
 <f8b9192f-fe88-4a8e-86f0-6e2c33ed3f31@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f8b9192f-fe88-4a8e-86f0-6e2c33ed3f31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzNiBTYWx0ZWRfX5Y6D9Sen7thm
 1tYiIQWDkLo2bGIaC+/xvO5yxx66ubZmmhXxnq3u+3PhKWZB5wvvH6eZMgOmhBbfuGXO1dzI7q2
 Oh9DlkW7HgFecI+1QcvF/sQFDLg+qrA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzNiBTYWx0ZWRfXwXxxzzUBTOKV
 o8xXHClg/EadBWbsPY6zXqpAFkQtQxKyzuPkz2VyAyok9BgY1abN9+p//mbv4PrbusMLkwn/iGW
 uUJ0uG5A11K6wMuNKOcybdiAunsCBuzGUjsbgO8I2cXeGiL1xNJ62fACjNNEf6KSkqDcTAvBq1K
 tu+YrK3I93s89xCYEgFXE3HIrOAFwmc5VIVbkDa0ySCxx+JtCxO+zAelvsoF6lKZPePbfyq6BmS
 cABxbYnGLPDrRQReEzM391QXdkLi0zSV8Td22IBUl9xSUtRU3ZQrFnwk/YzKd0lbZfOrKLcgxr5
 iDfwng9e8rKGOX/05qRyZ4z3ax7EwOtNtR5cI9sXVvgP9SP+jqRxWDyPQCpOmSBsLv9S6sdgQoB
 iRhesMUIjOA+X/zMWgRgP4IpMCMcea80toeDJiP6eiy5PRRQmcQeH7R2aZFYUWeU9v06DbpFB4f
 dnj7LJBquq+cVydE8tw==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa14d2c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=W21wEWUqPQRnM_OgY4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: ylKTIhZzB33VUtRQHU6I4LbaCWBmMCgp
X-Proofpoint-GUID: ylKTIhZzB33VUtRQHU6I4LbaCWBmMCgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090136

On 8/24/26 12:28 PM, Jie Luo wrote:
> 
> 
> On 8/22/2026 7:19 PM, Mieczyslaw Nalewaj wrote:
>> On Thu, Aug 20, 2026 at 01:39:52PM +0800, Jie Luo wrote:
>>> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
>>> continue to operate correctly at the fixed rates even when the AHB
>>> and SYS clocks are disabled.
>>
>> The PLL outputs keep running, but the AHB register interface does not.
>> Once autosuspend gates AHB/SYS, any later register access to the CMN
>> block hangs the bus. That is the bug we are fixing.
> 
> As far as I understand, there is no expectation that the CMN PLL
> registers need to be accessed after the CMN PLL driver has finished
> loading on IPQ5018.
> 
> Could we identify which module is blocked after the CMN PLL driver probe
> completes?
> 
>>
>>> On IPQ5018, the CMN PLL provides a 50 MHz output clock that is used as
>>> the reference clock for the connected Ethernet device.
>>
>> Correct, and that consumer is hardwired in silicon — the internal GE
>> PHY and uniphy blocks take proxied this clock without any Linux driver
>> calling clk_get() on it. Therefore no device link exists to keep the
>> provider active, and CCF rightfully gates the bus clocks after probe.
> 
> The UNIPHY block is the consumer of this 50 MHz clock. It divides and
> gates the 50 MHz clock, then routes it to the connected PHY or switch
> on the IPQ5018 platform.

Is it only the UNIPHY consuming the 50 MHz one?

static const struct cmn_pll_fixed_output_clk ipq5018_output_clks[] = {
	CLK_PLL_OUTPUT(IPQ5018_XO_24MHZ_CLK, "xo-24mhz", 24000000UL),
	CLK_PLL_OUTPUT(IPQ5018_SLEEP_32KHZ_CLK, "sleep-32khz", 32000UL),
	CLK_PLL_OUTPUT(IPQ5018_ETH_50MHZ_CLK, "eth-50mhz", 50000000UL),
	{ /* Sentinel */ }
};

What consumes the XO clock? What consumes the sleep clock?

Konrad

