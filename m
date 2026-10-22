Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659876;
	b=U1gWuwSyIXU3++KAQbIqGSW58mwTzeetXxvCM8AZnl/Q8eURod10ELZaijaGgxk9QTFe
	 i1NR5f1vQkUwXlwvqtBssxFkh8LhhpaB17+BmTJnX8OrYpIy7UCuhGS+YDbTpGYg/HPVN
	 ymfm91UmRuR0Iwm78NzrmF8WP8NBc82qkgkbeV1V/FXlLP4B4iyEBqYB+1RLrycylqbHc
	 00jufYMpHzEobU6aTxlrmvwiMMWz+fB1zFsqeuwssnQNIW20iLO4ceNSWGLqKTWE12+pA
	 2It6ygupv9ImQcQKxS2wb25CC9m93gnyAcDm/8pw7oNqKLfBzjvdozqZRCG2Vf2CF9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659876;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gnkS9k+2/tXEDPTycA0vOUMBxxhav/Et+SuLMPjpzJQ=;
	b=sJBt4DnHC0iQgjIUHrrMoblRGsPd3SuXndgcIMYLWOfzKOFn7lN1A4a/If8vqwVqXdJI
	 34aaNePEERHF5FOI8DmlCVT7YmcjyJ7TVQh9fYMLACVSh6dEwvyE+o0KqhWhZVKaqnogq
	 xh3sZ1XZkbN107OUkYfb5H1Dq8E0UAvFNCb8LMXrifPSfQaHlg+Uzow6fnJngKsor4Pt7
	 vEKUDEOZw4+H+Dr41TGwD+F8LX+o1o5ZVeknlsiq3Ym7BQ+iWR7Eew1pXz1AID5OUo72m
	 o3jr8DSenUvtGL485QhuQ+UXMt3V7I2E5KuurDkXbg1MHTP2E/wS+DaPeQUD9TDCQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwdV+474;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B12sLeHX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C2606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwdV+474;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B12sLeHX
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M703nQ3076607
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gnkS9k+2/tXEDPTycA0vOUMBxxhav/Et+SuLMPjpzJQ=; b=iwdV+474yLO5p50S
	vwhffizSEih/hIHI0dZ3QJGTkQPu3Pab9WOI4nahgE1oE2+USj2yzz61VZlc8u6I
	IzEcH93XSHV7M81IWVRGfLoFN64HyJMzByJ5I12MzYh4jAP14/PHX2J8c8vlFxOb
	KQ9ipcIJvarE9FHwREmHE88evVwamVvQ9i3VoqwAqpTqtyrN7jLZDDdmqby2AJdP
	7ExLBMF3XMWGLagjG5dtqZvwSAt67oUJouFWiKOK1K1QKTdBE7rlgXtJtvcIvtBg
	7Ki5oDD3DVd2A+N1/w4I9JVzvo2/5DK8QqPsHyP7FeVbecNnTkEPbznSAbVFjgxc
	70TDfA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a1kam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a04d1cb2so3809256d6.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792659874; x=1793264674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnkS9k+2/tXEDPTycA0vOUMBxxhav/Et+SuLMPjpzJQ=;
        b=B12sLeHXgtj84/PgsM9tkJGsm+B6aUNnFdQW6v7Us5vDnpjY0VbgvLSJv8qpgJTZqO
         V4rEdGYKIxIdIXJhXtXeJlAvY+jDNetQ4z6jbzlFi4AqdXg0BNgSqhWFZ9nBvffF9l+A
         FOQY9Qzo/p+7/ibaSaheTzEHJSA8vP7ofV7wQnwlO+ktKNpVJfJaUEiOetaW4uO1M1qV
         zUIze8mRQ/J/jehy/kJ0OG86yYRpNh6EGkRuEZrnytewlka2oAAC34NqbPRWW1R9Q2QK
         frMC2mNXA2Y+Aj3yUGA9iLBwZ3RrB8d/Z0rcChCm7XD9T8DJySLyJ/ToX5fEaeL2oSXv
         uDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659874; x=1793264674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnkS9k+2/tXEDPTycA0vOUMBxxhav/Et+SuLMPjpzJQ=;
        b=GTgzM4JR7VInXRABc4Psn6PdECeuY74nRXn8MGdCAHatCeoruuTTKav4fI7+M66sus
         qtTSLxll9unSqoCg2b7BsICyxcQQnpG15B++g8AbfWytfMbsLyI2GnYKWHUAkgpiD7l0
         WNePzqWMq215r5WF7ByTO0f3bNbiMvqrXYT5hdAzdytQMAIdgSzEDEbOF8CWibV7arAi
         piXGiP98zAWP1/dr2epipwVFrC6Nl4Nipx3kjrvGdHMz5FUiFgZZK+doasoTLfpMB7TY
         1au4o6jZellQOji+aLDBjx1mIqVSSSULuv5p9AYWNK3OaMmeYAHkYWWJYJn8+5RDXvf3
         Y94Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAScNjNWRoksUzuswjCh8p4VpJXUmoZ58lF2K2SFpkgms4BSUIWGgjDZ+0Jy8AORSTesL2idI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeWsWOftoWx8O8PcO47LYdOzfMWxlVKehhE15GBQ75QzNrX7mC
	zgA+KenXtNhem2Z7HVjrAgffsV1zWaaV722K2HX/tYDKrqLoSuw7DMl/QEdWIuQRl2ziZ4iGMpB
	3fvVMFIEAHO50rbqAUsMy0/LiQaRZyFVBX5mXm9SIZ/G/GbA4s3prg+o4kEk=
X-Gm-Gg: AYBFou0cnopbGUADyhDCYkKiI3dpuVNoPA28n37KdrQIpMr2j0du8KaO7DW+6WcWRsB
	a3lWITu2AphqI5ZdW0fCLJcNwaOFEsd8kZUWHG4oOsTUVTs6uwVhFn1bJ9CjwDJeNaIvWok2ezy
	KSS6qPFeWIgDLuf038WddxJhgNDvAsbG31xhjyDqSaQv/BVNienFWDkrnm4Ul2/jmPWiMX+NdRz
	7Xp9UYUAdIV88BJ6OTRLsw6dkLO66Kzr5OaO3VEmbkAC4VUCrQ/y0q4K0YDQzjgQbhFQBA9OxR0
	0IjYpU/4J93qnMglCH/mpVHhJJnPQ1lSecSwR/+KhPxKoW3oru+dwfeIVDsy+OLMu8SgU1TyLRr
	2HScmFKAPwF+pNsq26kCmsg==
X-Received: by 2002:a05:620a:6844:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f57fb9f56mr903739585a.5.1792659874151;
        Thu, 22 Oct 2026 02:04:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6844:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f57fb9f56mr903737385a.5.1792659873706;
        Thu, 22 Oct 2026 02:04:33 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a1f29aesm85858766b.11.2026.10.22.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:04:32 -0700 (PDT)
Message-ID: <97c2268a-0cff-440c-8e21-f19a809ad377@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:04:30 +0200
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
Subject: Re: [PATCH v11 1/2] crypto: qce - Only register algos if the user
 really wants it
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King
 <linux@armlinux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Birk Skyum <birk.skyum@pm.me>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
References: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
 <20261022-qce-fixes-broken-label-v11-1-0d33c34fd0c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-qce-fixes-broken-label-v11-1-0d33c34fd0c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfXyXNHWEnSOlIc
 UP8b7zwbeqqUaX5pax9A3JVkQ1hBByO5toc/+SUbHK7nSq5LO1Ko720GxFfDW6IPsSuIs3I5jh9
 A0yXbgXoSHaHOlvkmf791fSkKYIiBjlbXc12/VikUcSipb9Y/1WRebgpy6VTvF0qLN0SnoGQMit
 HUrybm/URlmoBjDuugDzHYg7XBko1IBCsr/hzMvjnQjNONVEWDqtZ1/GWfaJQPw0nwZ93pVVAqu
 Yo1hD/NdSR9hCki5kQc4l+H3/e3fK3OLWfA+ltETNHYmtrWuxp8/lOxjwMFS375E3SEkqZKb3nt
 Lo0UhnKZp1mrCRGQzZbh2Sf4hFEP/2vmK6vJ9JzYtzYE6RMe32HnA4g7X82EVJ8vznNWDGmdtJO
 yaV5p/bPw6gxd6XQgtShD5L4iLlD6yK+4QP68w41G1ne8PB7P62p7qa87dBiBuuGgZkL6D2bIot
 /EPyt5Uubzz4TFzbZqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX+ZqwL+kY1dLz
 +Nuegaroh43PkOuPP5ktmxTa4tXyZMyMRtzHoisk7sJCPCw9RytIsuzzxi1pzUYlzJiOfE5Lh/Q
 nRbhV7+86gYhO5o0LdYD9BtHRaZhaRM=
X-Proofpoint-GUID: EEabZK79Dcv3_aByTlDIag9on2lxiwW6
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ad9d1a3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LeLJCEefvvVT7qkYm4wA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: EEabZK79Dcv3_aByTlDIag9on2lxiwW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036

On 10/22/26 10:57 AM, Bartosz Golaszewski wrote:
> This driver's crypto algorithms still have a few issues that need
> addressing which don't currently trigger any self-test failures. For
> that reason: don't register the algorithms unless the user really wants
> it.
> 
> Add a module parameter to the QCE driver that by default causes the
> driver to *not* register the crypto algorithms. It will only be one if
> the user explicitly passes the do_register_algos argument as true.
> 
> The power-management part of the driver is kept as is to allow scaling
> down of interconnects gating of clocks by runtime PM.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Tested-by: Birk Skyum <birk.skyum@pm.me> # X1E80100, Lenovo Yoga Slim 7x
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
