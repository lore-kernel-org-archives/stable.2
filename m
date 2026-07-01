Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F13B7778
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904332; cv=none; b=XV04UKXLk9h89X0E5MBc11UW5S9vIKPZgxcdlMAMOOw41bsotBVfJaPlwf4+DEpMQRKAKvmRhEXdmKfx11Xuzpc/6JoHdp91vC/v+ZHdmbDVgqmJIlIC/RxE0G1JhCJGXOF5qJjlQz7b04cFhxUdSdJ5nx8QNtjPQGYL4/as2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904332; c=relaxed/simple;
	bh=sHKyxBAXP+64IaiR9M93nhNYksJ/qP+JBSbX6tLP3sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3/zCOwQxBUeJ5iDteObnD7W3AztQQ7KK2Lcjy4PWviut/sElgdukw5GW5yyRB4/BIVReiA8vp3Kw+t8D/htwZgPf+NHjSukxFntTQxE6gdXzvJ/RW7iwGROsgOFeLsaC9v1E9Qexv7pXOQeg4P2f1H8TTYBYkvcHDp3NAKfUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bF1dlqWy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQ3c8Z+A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bF1dlqWy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQ3c8Z+A"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8Rr9761248
	for <stable@vger.kernel.org>; Wed, 1 Jul 2026 11:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VX0pngcjZ1Ha/IfFO5ZSf47UTey90yV9N2eI2uJkFb8=; b=bF1dlqWyy7jetzrs
	lApLdtyT1LjJnNRxOXwdRjZpol1XeO4NzKWuRaPsX1XQ1MqAnC2V1+pg/jZ6mw1B
	WJ4ZMNyLzYfbEkzgXKXn/SIHbIC0I7MjN/Cd1+3lPut2e4ojPEhgI+CH1u4Zww0t
	aUntANuozYhY9xqfj5DSc7dFOdB99e+52WnoFhMEKeL2gsw4O4Wuit1tsADC9Qjd
	ufPTWMO0n6cse++z9yqef3vGY8vIBbxfCmR7xgmWtVVBXKeHcJASQNmn4iVtPImo
	Q34IjSAINE2b8ExJ3ous5JgC7y5U1ANCydSVGgaIU9Zfv7TMf7BpSNkAXDfW/czw
	kz9jBA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw3qtf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Jul 2026 11:12:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e8e83314abso1867596d6.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782904330; x=1783509130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VX0pngcjZ1Ha/IfFO5ZSf47UTey90yV9N2eI2uJkFb8=;
        b=hQ3c8Z+AvMr+opJ+MzQMYybEygZJWOdjY9E1BzZm8OY/K3zDqOGdEoCPGwlSUBcYub
         Bis2jKkNAaBQhX8+p8jHP7Dzf5dRNe++rNNTxYGvqqx5aukkJKjQwPuthPSaDQ2A+AJ4
         gAgslGL1BfpRDUpPFEiau7u7VKrriT88MufYzIaMONW+dbAiQlq/1Y8IZQo8ylM6LT1j
         thJvQIjULYxy0gV4u8TDI9anXllTkR+luBCwCFJY3gupnRY3oJZT9f6GNt0fJqtG04kn
         RoJO0j1mR+fMKGXyEHq1WAJEOnUYxSH3Rq3fquKyfo9rwigpHlD0yTuQwPVGLIdRH9Pk
         BlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904330; x=1783509130;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VX0pngcjZ1Ha/IfFO5ZSf47UTey90yV9N2eI2uJkFb8=;
        b=XpIljEjzhvKFZV1GKycoo2kjJHbmIhmmAbKADDmc9ZxemhpB0Iw/VitpF1h9ys3zlr
         RP94a/NlVxogy0+81cv93JfN/r36gfgEGef8kiOlXIunSIReRZHDYTvMCmcQZCB+nP7s
         eTHWo1utb3sHMJJBOkzl/qQuc05/upA8a5/ib72M9QvRpMxQVstxCSAbCq2g2G0hcQ6Y
         glCHZtXSUMuky2rn5rIfqa0GITMzC+wFa+gj4GxtEE368aXWtHkWPsdPfOHrf2HVcoIL
         3aboZLwek6Wr98rmrZ/1CTtSJ9+5b54+2MqEaYdMLb0hvvZ7TnRSvR9q69LzH2ljJ3wB
         R3jQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sIJ4sAuXGgClSaobNK0psgYwg0nvzDvl9rqbUCwULWEg7YuaJoGUL2lCKMdnGoYG9UUlJaAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzumXo/+t685XU/6Ig+dfPISIn5RPahVtMwhFWJZu1l0yrdiXQ
	DAowNm8pPcVYTg8ydS+cmv6vsQ/nKcrLyhSy03Vey8b3m/nF0UD9GzL9Zb6zPKWEzDNwrXin7gi
	uoD7+bx5JJmF60fvU75H0XjHbJYI5u0fY35PszjB7xrd2AHqDlVAZ/GOGXZQ=
X-Gm-Gg: AfdE7ck2OS23RyJt+3aomATo1gPz/uzwx4KsKhfVyKiltQu4HdMo7VN3pz/ETayWcGy
	jh4QY/7y3ZRoy/Os4NkNhjwSEVGCN9UmUiBpe/cvhaMQKqfIPJsVNRLPdWNQk/2MXwpNc59okBf
	Q7GDA2ArNUYL8VZxTT4v507o6y7I4dE4JSJIKIeVFGVakXrjWSNSxEqtPhAmc36HWeUpBvCEs57
	pFfMrkDdhcagI4kQELoL8BlyoyMr0Zy0pbLn5oBmMNViVsktY1bO6L8bIfO2qIU8QV/opHa+wfs
	UCkZfN2ploSHpJnBr4bll8XrwVxPgPvX5Hddq77EBW+xdWcFzdc5NQmHCpWsKXM/kOdHIm/cZqm
	3FXNXfBfOZRfxdD44jPGZFvOo0ivRcoK4/GU=
X-Received: by 2002:a05:620a:4143:b0:92e:519a:7c06 with SMTP id af79cd13be357-92e785379femr93365085a.8.1782904329419;
        Wed, 01 Jul 2026 04:12:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4143:b0:92e:519a:7c06 with SMTP id af79cd13be357-92e785379femr93359885a.8.1782904328767;
        Wed, 01 Jul 2026 04:12:08 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12891785f2sm257626966b.61.2026.07.01.04.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:12:08 -0700 (PDT)
Message-ID: <75858d5f-edb9-40a8-a4c7-a40cec09b6a7@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:12:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate
 firmware size
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44f60a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q7hu8fOgrWGrelQ5SqEA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: V7z3chLd-YSGoGcyPwNe7Qu7Bjw5qjfR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfXx7rVw/HuFC22
 04s8HO2b2l/sR+9cbe0z/VcHYJbFzP8CVA2cpRMEoYwy6zW7d2Lv36WeDjfWrcUWg2h0VzhOFe5
 KmfK5kPDITWbcUabTfKfXZ+FQ/tBhoE=
X-Proofpoint-GUID: V7z3chLd-YSGoGcyPwNe7Qu7Bjw5qjfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfX2II5EJFjR0QP
 9+tP+49sOoF6cLXLd2jeqnOPdoLbjGTswECX5fWeIvUoxSu2C1R9ZJrDuh3gLK0w8sTKAwOSMry
 iNsF8F8Yz3P/ivNpttaRyKWsl2PQIweXMIV5l7uSAQOUF6oIhPqNJQrvBtNrd2lgWo4QVPK4pQL
 HjSX7ax+u/+5ma2Y9XsszGwivCUqncP8h7MaFs71zZGvETKJCfTN2cd3YJxOLJXwM2874AW522f
 mLDl/Ys2y5IYVpMSOFqqU3iTGG0Zg+nrDe7zl0nHUQHSJBv5EOK6FHQrJhjMwqoPuV+zF8Ks+vK
 SU14d0RrUc5lWwRz9DBE1FoxpP37x/KejcxPf8Zsb483VGwz5XiQzES1LUD2xb2Unqz3TznaMZA
 X87MIu7CgzJBT/H5GdSifYbRGCI6i7LeKaiE6y5EhJejkJL7opnt8/IpJeW3JzgsVGNT6ZvabNG
 wtnPS8LGDw6RBrhKVkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010117

On 7/1/26 6:21 AM, Viken Dadhaniya wrote:
> The hardcoded MAX_GENI_CFG_RAMn_CNT limit is not accurate for all SoCs:
> some targets have less CFG RAM than the constant implies, while others
> like QCS615 need more entries than the old limit of 455 allowed, causing
> valid firmware to be rejected at load time.
> 
> Rather than hardcoding a constant, read PROG_RAM_DEPTH from SE_HW_PARAM_2
> at runtime to get the actual CFG RAM depth of the hardware instance and
> use that as the upper bound for firmware size validation.
> 
> Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

[...]

>  			dev_err(dev,
> -				"Firmware size (%u) exceeds max allowed RAMn count (%u)\n",
> -				fw_size, MAX_GENI_CFG_RAMn_CNT);
> +				"Firmware size (%u) exceeds HW PROG_RAM_DEPTH (%u)\n",

I would just say 'exceeds RAM size (%u)'

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
