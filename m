Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193085;
	b=TV/5Hxs4eBNP69a6C4xx+pL1JKwKMSyJElkYbmkoRoG2EsXf+5zIDY8j7hkl0za2eD3n
	 tnBowvvBHT2H9S1YrvavdC0tsoRRBOFD306hfPeeMqNW3iZQ25e/MRsc21yPbSmwOBiKS
	 td4bPR3vzSg5TDeP7niaJMQN0FpRz5x+5g4BkNQijw3v34d3Y8ANgKUnvTsxWwLzd2qAj
	 5tlhS8ZurkIt0pevZ4yImxgDyXE43dk2WJfdUSbrKYQjue/4Sd7O4U1sZWZiOsNmfAtk4
	 SNx+AO2hJA0GraRQg9rpn1mmlo6S66IRkgqL+6CYuaJTKrgzsts8hsVQT/0Th3AtF8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NyEZvQChmpUEviU3rY8DmvUGfLadj5H8ux0zdPUq4io=;
	b=iy7qjKxPhh4HMfhXZRWkbCqwLJPSZ2qiGyKy8bu16XbUQYmy34n0BLdZf9gkuUKisIBr
	 pNp6/4D2JUHjkwhpiFpDQYd9K7ONZN1Ngkq2Bvwxg2x5ZbGgorpzE2SqF/1eycp/zTAMp
	 V9XT4vsBVALi0BuK3q2/Tjq6izD6Y/Uomid6HYUC9IXKR8sckJtdjdyq1+FdpENwEntIR
	 gmJAh019LCoUezxz5LGavGXrVn/Y/9cgNmXPNpnBwZqeLZn92v+vABLI619KLjUKSL6YJ
	 iGlTRAdmsjoY6ktWaMLgAqdFK3RBZESel2qsUHUIMtJz5w4gP24fIKW6HcKyTzANOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A4KU+Ndr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="JDs/SelQ";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAA606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BAA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A4KU+Ndr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JDs/SelQ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBeB341053585
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NyEZvQChmpUEviU3rY8DmvUGfLadj5H8ux0zdPUq4io=; b=A4KU+NdrY5SWcHMH
	AXdRRFZ8KYnGZdgJm/3Ak9itR5CUTDWPK7Q/T5779I1OfCGJoUIQUutrJYU5ChC+
	xGw/OOvy2MtG8ehXdN5ARNhAYnDqxXV5ZgAz2oFacTqj4tGv+98RKqwnCsaPeNwM
	+1dnkwpZ4pa13I4k/BXc2MpknB//bSGRZ28XcVB8pKolM8BlaBm+HD7Z3mNPIGhH
	MA7H7GFMI0/NrJ1uxcMlrKsQsWYm4xajrF8xO9IQC54zpDWm1Gvz8D8mUy3mPsRU
	5Lv97QuJDyCuI3JE0rb2H8EabK0/Vz9mMycAdTKQ3QgsYnAiNKJ21c86UONjMwHr
	4IeOrw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhw9h7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:11:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eabddbb650so35021e0c.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793193083; x=1793797883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyEZvQChmpUEviU3rY8DmvUGfLadj5H8ux0zdPUq4io=;
        b=JDs/SelQPxnsIF6VYKq/R2bGxs7amcNTNX2a26zG3WU3oGFGe0VUZI/g7OfsYDRKxg
         mdkeMt3IMkpPWZvAcQCmIMAgaZg2E7a8Gxw5Rg/2vCG3z+bQKpK8WerDRaMgwU/FvXzO
         wAWM/SY9oYIiwiH5a76mbPqE4jhHonShuKdxIvZjaCsgPkbmVAvoPqGlBNwgPbAgyXS4
         U/7LfEh3A4iPW9jLG3f5qDD/9gWGoNEnD4KrSJBUKCqllLNjqUvBt0EfINcz/ywgutG9
         4dh6NnJXAD9wp7kkk3KT9LZ718wKq6AVdG6zKdkpxttcZjnf7mKrXqZUYu2lzsQ4dSgC
         lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193083; x=1793797883;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyEZvQChmpUEviU3rY8DmvUGfLadj5H8ux0zdPUq4io=;
        b=MnI8xEbeHIHzM4ep1kCD6DyjlEEWD8r+Tr/xgMKEZqbXIhHQQ3WHBcNbK16HT+joxF
         oQhbGk784730sKOiYPIuVpVevMa7RcZsQ/7LBSqHx1HQbmsXzBpT9I86n3D5Jd/0lGCD
         PpI+oachKxEuIZWu2nfFdCwEMMrUGPEpfmQtNewuywasD5zncDZmZMCP3yQXLoo8yn68
         sJdytC61F7pH95hfQZGinLtRq0HEudGXg6Cr3Dwv7YzEWx+xzjqKsjh8rvlqeSIiRcKH
         q5KBezbz+lWD4oHG2vQa/Yc56DmWaPwvKY9zSle8Zy/U57rz17af8/GJWpw+xZil1rny
         VHVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfJ4eqd98dGpf9DJMkczcHt8bTXelIJRuo6XPrJiikgq2cKhgvcE/LoORd/YRoxVVh3M1w2vE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdIruWbXjX4g3YD6VXhTGQgSuPYv/hGcC9a9sNO7jflatjr9YD
	AYlZc39ZWE4L601+m0YvvtEPvg/0Cd91SzTz+Rt9gS/hrGigtgDD0UUeusRHF3NyXDNh1fJt9Rj
	/KJ2iEALAmnxmqxtkgjtS33hzMAR+tpBudK08LIzEhiUXcrZsCZqdFuxw6crUvgRVR80=
X-Gm-Gg: AYBFou2okBIfT9+Lf5U01Z+XToZsCu7NNrrUfdhEwBCUDd22oTRsJYM6a1dA6tT4RCz
	rhrek7WjgVDwgt526hjuEUeMGrK+q5SZZVFeIlqmGMSN+pnfY/NXR4kO/7M7x42b6gAgFLZclSd
	QHeXPo76dU/6CzRxF62A0fjzUAjNIajeu+gNDfXiQfBGfRw20YDcwls5ZqvTkuyHlXu+Txz6vVk
	xCcnq6UFHCA9DUIKtqPEDGz6RuCyos++pU0klfquj0nJ6Hw+NnfIU2RB2k+2UslO21nBz/q5zsc
	jrsAWNS8w2NvKVEUXaPNJY8EgGl5ykFaCBztinXR/C9PXefnYKDYpQjmSosWWoOnuFdrMBPhXcx
	lMrBnBsqgvSHGjJ6hNN5/HJSyCRIVNknixYs+4VHjWkNTT+KWXJ1bDf8ptfee9rToWIqv13M=
X-Received: by 2002:a05:6122:698:b0:5ea:cc1d:173e with SMTP id 71dfb90a1353d-5ec4caa5fd2mr840686e0c.1.1793193082914;
        Wed, 28 Oct 2026 06:11:22 -0700 (PDT)
X-Received: by 2002:a05:6122:698:b0:5ea:cc1d:173e with SMTP id 71dfb90a1353d-5ec4caa5fd2mr840624e0c.1.1793193082038;
        Wed, 28 Oct 2026 06:11:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7ac041sm596435066b.82.2026.10.28.06.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 06:11:21 -0700 (PDT)
Message-ID: <cebc3404-1f9b-49d8-b459-0e31d648d989@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 14:11:19 +0100
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
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix proxy regulator array
 overflow
To: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Luca Weiss
 <luca@lucaweiss.eu>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?=
 <matti.lehtimaki@gmail.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261027-b4-q6v5_mss_proxy_regs-v1-1-6c5557e42462@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-b4-q6v5_mss_proxy_regs-v1-1-6c5557e42462@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lzjIcjp07h_njtJ0LUEtaMHk4xzuhK7W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MiBTYWx0ZWRfX1s9W/30lOTyQ
 ZeTp2hRGx8ueRjS96IeKDzSUOWK+aJpQAkGWN/EYqDpUE4CUScyLv9JsP47x5TDaQlPcsr3KAMD
 UCEGva1BOCVpnrhQayvGBUUQ4wE1xis=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae1f47b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lYDSAuwiKccqTb-b3IIA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: lzjIcjp07h_njtJ0LUEtaMHk4xzuhK7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MiBTYWx0ZWRfX9nDBX9C8+VZE
 n7V3PcZElsB4UnZeWYV0LdHRpHL2El+2O30TwIrEe6hA2SC+OvMPSKZKQChZEUYzW4FhVRNq8cm
 J+tuhIwh9BWZ2mPEFt5CQEDxvov12xZZsjoK5u/1h+4go/UfOSFHl2pNUSbpaI8kl3knZkkSwtC
 wMFr/4oyWJPdu/ZniXz8TcFP7IxT3qGFlDFCBgVVEoBGvNp/iQoAR6Q6TsASHMLnUg2vZ3ezwEJ
 ehA5Huxfe5KOEfkVuYNI2bKheH/W73VWgPEsI2StlFSycOUFPV9yj1Nc8qlkNvHl0Mvnswbzmo4
 SiF3TYZF3kPxRHUTd29nZWtg60f6dMm+ZW+1j3P/WzDKnv1Vyc1aYLK8MO7L0ZmR7WmmGjWdiF3
 PJXg5Zv6L2OS7dbxnqxIxNlCn+sLjrkqb7gKu9bJcNDJ4twzJDW3U57P8+l/I0WGQfPOlaiCtZ0
 ZzwRXzP8HzOjADac1Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280052

On 10/27/26 1:01 PM, Anup Vishwakarma wrote:
> The proxy supply tables of msm8974, msm8226 and msm8926 list two
> regulators (pll and mx), but proxy_regs[] has room for one. The second
> entry written by q6v5_regulator_init() lands in fallback_proxy_regs[0].
> 
> On msm8974 with a device tree that has no cx power domain, the
> fallback table then overwrites that entry with cx, so mx is never
> enabled and cx is enabled twice.
> 
> Make proxy_regs[] large enough for the largest proxy supply table.
> 
> Fixes: 4641840341f3 ("remoteproc: qcom_q6v5_mss: Handle platforms with one power domain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
