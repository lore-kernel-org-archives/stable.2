Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560485;
	b=1czJWi/vP2O8AQ08OaYGcQJzLPDOOhTvgvuvvKdhxKT15TfKuXcNfzhVynQYa3VGVu7V
	 v7P2ZqZbaEIK0YGCt8NRpEcfLi0Rm3CYnI0dzQKjMZA0PCMQIYBJa8dXwuSlWO0tMM1sd
	 Y4xZg4LcCsaBm3v+vLGe9RZnPTdZpfBTjPr6FyQwVmrfCifnFP4aiYNZt5CWyy8UU6CdX
	 q0aHFD6BF5A/pwVGmMgoxfAzVW0mq1FZRkWjV2MXPOGFE3NqY8kbJ2OQmY7xhutHU01Ef
	 kVqrjp93QfwNU0gkDjL9n7iC2B7QzQZlTkScjSCuJFsnKryYl1EwKot7bQl289s1+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=seAT7my4zBoNsyaBn1Kf6H9akZuh9OuzKaTISNXvFGo=;
	b=UmSdQ0gX2GoXJKE/zIVWvzp3rkWH7DwizTpF4s3MD0tYPSMlWG4jvEP+08BSwMJVCmvu
	 ldeg4Yw2JJ6YpLuiTEE3oxqeuCLVgT1GPdPGtnAIT5ZUJFc4IeomcpqK4jd+jrHHbZS9t
	 UIbXFf1DapH+8k0YMj8Jo9+d6XRkLbdI6c7ExVbRth0WRv+9jyaVZiSJVfQJlV3EQVCX/
	 O5qvBaN2EgfRDBP+o2X1tg5Km4/74iCOTaK/UxI+6GB04p79jQoZom2rNsZIdilYWq8wY
	 4RVkY4F8UmjokUsAJhJ0fs8KVsaJsgM2Au2nGq/weCIIvj2jo3RbJXHzlQ3iXhDyVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjRxx2zz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RJiH9B8R;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF16606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF16606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjRxx2zz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RJiH9B8R
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8UwGZ3619871
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	seAT7my4zBoNsyaBn1Kf6H9akZuh9OuzKaTISNXvFGo=; b=GjRxx2zzEQLexuuo
	Z9nToIwO8/DYKT36+GMWBDteintULDGewNe8IqEmlsMehvxaZwIGxzHn1iuajpND
	9xKiws+LJqijJIUeve2odwNZmpfMiDp78qcd8DrI3Hxqn4+h52qBzqQg9SYvQMS/
	Dd2Ea4uaYoNtshrfTiwZnoKn0w1GWEiWL5xRZJRqyWsutn+R5NwJMkbLv3axYGov
	wkoRvhBzKhwjfzo1jXmNvKRgWUsHhdPMh/5Xw7B1T0rQQKqtQPxqpuq0xbQ7esH8
	SUAXadoHIJyWXNXYOwiK2X79TuH8f+xStWHQv6t8oJfaiqjRvr3ykALzpCcArEkg
	rFWFVw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvja8nta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:01:24 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-990758837bdso8862241.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794560484; x=1795165284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seAT7my4zBoNsyaBn1Kf6H9akZuh9OuzKaTISNXvFGo=;
        b=RJiH9B8R2CmXW4PICI1xoEE2Jh9N7K+7SGJfVNkS5R9D1pEgbYkyBgpS01RKHeYx84
         gu04OUUAyDGlmuXnGggAczpkCGguRNAxmdx77qf6BmypNy5dIbrsdawT+35ftvjS8BJY
         uUkecyJ3Y5kGj7/TpCSG6waU6X8sbNfxYB1Tzkshi5TqJ/94hd+tfbtqmTd4HtHwOT8i
         h0ycY5Pps+Rdz46U/k2Q1XDQwLJU3fvdEkNSdPl+qPNwjsSHZSvMDkfJXnoOqKc11c6u
         N4xSdY0oTzxEeVthDqgCm4q16ossmwgSMrOPvOO5hDfbBASYmfCbxKQXTRdFnfMvIazY
         DEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560484; x=1795165284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seAT7my4zBoNsyaBn1Kf6H9akZuh9OuzKaTISNXvFGo=;
        b=k2NgnhWBkm+jZe4AKpJ19Dr807K9s0bEeeSKZdCY14qDroep2SMQjuoKEu1cD8LGU2
         zO2W6QY4nCbmnMUqRbTbSN+OB6UDT3PBuLCGyKQwi8JDFQjTHJiO/aYTuJbH6iH8Tr/7
         qaA5nXMLNl9olWOMKd6BKW5uJbUhhMEsBb5IiZRrULdBaIWgs7Pb7YK8jy/oKFxsxief
         AHLhMpy/DaFKnhNJwj4AvSxbM+2+e45BRtxq1wD4R4nRxHeKWIQnNswGElm1UtrbI4dB
         AYp4Zx0neKjAtwj4Ea6AoENLoKmg8wyI4tZYIkjxO+6vlvnhbvmfW7XC9ow/YhvFz4D1
         0UVA==
X-Forwarded-Encrypted: i=1; AL+hErH4J/o9cOzZTaW7ftvyZQPpxUH8t7m9eqovSY5y/eI4e4jhT+KPv+PbPgpXce7B0YLhyeOLoGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+2SdikyC1/HWDhgvF0Tl+fbmWeq+jaGUXzZ8dusH+k34wRsrJ
	igFKIag7BfhyYnTDpbHN4bIrWa6NYt66vOHYn/5jQb+E1OFHSZp7aupVsG09Gaotb4ntPBw/+Wn
	IVsNJRv2uYhHznhmUCAzmRLEPMsyE56YZ+38TbtRTPdSkMR8Nw+BNQdfO52Q=
X-Gm-Gg: AYBFou0UD6JMCnQzflsz9gAq6njyOCpzZ55HKgeMXA3iZ2H5zqDxBvnjP2EaCD5M8KE
	uMke39W1vU5QtxugZ+6a9kUqbm+ojR2wCVuVf6ECAFdaR8t8IWkYfvwXc81gIxXNuOo7NVY5tQ+
	0Uvu+vt8EUQLCh5oA4vIxeuNM+JP6SrjFmZRSQUvvQBhMaZ59Mue+dlu6z30dYa30zEOjM8yNH2
	Tpyn+D1A+/oEiYIsDtkG9T5XAiABXK2prUNRSbRJtr0cGPi6O4H57VELVubzr3SmFVcqFE2nDmM
	Ic7M8nM7K33NYOBoTn9pOPmy4gZ85WeSWzmmZi1uSpybTwAIUHiYc/RTCvTaNKNM3APJgCkwGPM
	jn2BTZTxq89ywrEuZ5pxUx/DYWcHdZ+jje1klm3T9GJpHINpemlI1SvbXoKzzGIIw2Skd7po=
X-Received: by 2002:a05:6102:834d:20b0:7c3:99a3:314e with SMTP id ada2fe7eead31-7d64d120edfmr536445137.0.1794560483708;
        Fri, 13 Nov 2026 01:01:23 -0800 (PST)
X-Received: by 2002:a05:6102:834d:20b0:7c3:99a3:314e with SMTP id ada2fe7eead31-7d64d120edfmr536426137.0.1794560483235;
        Fri, 13 Nov 2026 01:01:23 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b5606sm698390a12.2.2026.11.13.01.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:01:22 -0800 (PST)
Message-ID: <79ac053a-3235-4da0-87da-ebd8da01e4a4@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:01:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc-qcom: Reserve ISLAND1 ways on SM8750
To: yzddmr6@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261111-sm8750-llcc-island1-v1-1-64055702ca3f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111-sm8750-llcc-island1-v1-1-64055702ca3f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mn3Q67sFqLpUv86tYZfLnJvW-t52nRAB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNSBTYWx0ZWRfX4QcvJ8xVaFm7
 wo0fNLjUQbvUmXaiI+Qqy9oQevxmv2PlNsSGlj7REQiZBjGjg/QA0O0tOnbEHvmeIZAyz/MXC5+
 cVWGIr7IvhvDvRSrqt4nShcYdwWcJ2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNSBTYWx0ZWRfX/OXn5mU3BJ6n
 gPVjhOeOX983mrP7wxE2y0p7JAuavp4ZjLSeVOFYYcKZ8F6hhRdqKdcMbYGR+/yO4XGv3nuW7s4
 fCrGhI+rZZ5/ND2uu0FT3pd0xBPvMX5ECQm7Igu2p3N0a3INPaqpos0Rmw1VchHPwVq6ocamDvU
 psN992RXRoKBq08AHptbWWWBFjOOlCsZojX2f4pL8242BaWRxX6UjW98isC23JYzC9Cyt4xv9Ux
 lMyyCvxe0GZydfpZiMsrP5Bw4ui8Ic0MffKWoXwjv/VT6v44MY/tegcZdpXGdcjjBXiPPjNpV1V
 0PRf7m1B3aaCimpJSYwFVRp9EsdmTeMeSsYv/8m6nCPn7JnU9jhm4OPK0Q7/mxR2yQG8oBZBEu8
 ZT6RzInCq11qswr0DR9kWJ4XJav5Af15mcbt2Gm2Ssete+WtO8wBvHjwW8YHxHk190RQx4P0KHU
 X0nvqDmgVfJOVIg4vtw==
X-Proofpoint-ORIG-GUID: mn3Q67sFqLpUv86tYZfLnJvW-t52nRAB
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af6d1e4 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=th7kVB1SI1JMAOI46x0A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130035

On 11/11/26 8:21 AM, yzddMr6 via B4 Relay wrote:
> From: yzddMr6 <yzddmr6@gmail.com>
> 
> The SM8750 table gives the island slice (LLCC_ISLAND1, SCID 12) its way
> mask 0x7fffffff as bonus ways and reserves none. Bonus ways are only
> allocated when no other slice has reserved them, while reserved ways
> belong to the slice alone. The first posting of the SM8750 support [1]
> had these ways reserved, as the downstream table shipped for this SoC
> still has them (res_ways = 0x7fffffff, no bonus ways). They became bonus
> ways when v2 converted the table to designated initializers, and v3,
> which refreshed the table, kept them.

Turns out there's way more things wrong with this table. I'll send
a patch.

Konrad
