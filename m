Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695907;
	b=ReuRH5K+JW93+5gDsX2EjwfCUL1OIEriYicvnF21TOM+9jpqQG0hivXiI+340zyeGGyG
	 aczTzVfVWFPFJmKOkOd5yBlgvyO2oD03oTd+GH0FdVd3cA6T597C91IPrwIBn/ZGgIlta
	 fC2LeVL/3+mWopQh0DSE3xRlSqOZmYb9IhfKMtACXuR7A1E3ay/YyN11eu3MQQFMSwyIY
	 BRtqjXDx6yZn+s7HP/kBDzTrw2qdbFNq/XYXSg3bJj00y3pglamULMk526TBsL9MOziRT
	 sMqV8YJeaZFUVZkuac9MhB+gl4YA9H4cVKVddg8JsJNj/HOLL+13sJTZYi0kuZFhX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695907;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XCvvirDHMt/mDpBHlLgw3Uz9ts0ZYOeL2ziEuOb6lFk=;
	b=afUhCvuxx3YjJQ96RXIq6VKo4Fb76BEJIQyO/sZRLXBuZphELRa+HQQ1l2LgwA3shNuK
	 9wg3A/OnEfimnEAoBSk2+TU8h2QaeRkDLGLi0mZcFhmXXbU9P5IKmxiLp68lz7ZzjnVfR
	 kD/i57jQKFeZv11mbHAsRAAUsmfEyIjbdf3W6PFRCfmABO94B63BZkwCTrdfcbw9cSigO
	 mXIQTQ6cLvRbj0zkWxPIi8/NUBQKFQJqSn6/+GwTvlFNvUfdmh5+5zHqwETWzKXRvP9b9
	 qu5LITm2GxwuzNBdvTfHSDbGxtMWO1Qmc9rDPwBE8ayfUhlR/BszQ0qEKpRLZMk/11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=byxHh5Vy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icnUUpfH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E13606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E13606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=byxHh5Vy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icnUUpfH
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A38Alad1431391
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 08:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCvvirDHMt/mDpBHlLgw3Uz9ts0ZYOeL2ziEuOb6lFk=; b=byxHh5Vy7u4l6tdm
	r2fWyET6aQ5qcLf9L8IUjEpsXuKh+j7nZnBzXyTG+pq++GXSyOEyRWQa3xpsUKka
	N2NawuvEwE6BkavTJSvrGD9vZGmRc6QwRHwGFBw2WZDFXs1xAFWw0OWwmsdFZnZx
	YaHRbLxGz2pDx4XVq2zMVy9RdczTCL4VP2XfoLItXsE0HW+uy0LCbfU1fP1VE1pO
	2KTXD6MNaBczeSwpq+MFT4x2ow1MxHrnOHU/rLQJi9GlbB0fFwdO/T1Hvy++WRnp
	h/Ur3wDMqwpRMyPBVGTz/1r6oMXLm9PyqT59OzgjqKk06dRdE2QiW+z4weassp0U
	427d2A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0872un7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:51:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c84695584so11748266d6.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793695905; x=1794300705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCvvirDHMt/mDpBHlLgw3Uz9ts0ZYOeL2ziEuOb6lFk=;
        b=icnUUpfHj3tneN4gWWIHjLf+8cdd51I0tiAI/3t0liFDhr/sa6HGw75Ty47QavM/th
         /Ntw1CDoyH3T3sxXuqsD/KhU2YU2FULHKacktTucOLuSui+TyBeh4287e8UqaZSJh0U7
         ixx1NjcSFnD0TpYpUFaiN2VMgyifEMivoiIHKUDxKf2MocXXHfhqw+9zmEK2jBXODjaM
         GKtbNvAPZ9swB8SWjDtIXQq4C+cHFAG2fyAiGzY8EcXNs11LphcF9z9NyhuLvBf222fV
         8qeBYTTNVm1XXHAVNXS+x78OPo0/Fpe7ql43463cYD9VRmYw4IStvZWXRDpwRgU8FLzN
         E+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695905; x=1794300705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCvvirDHMt/mDpBHlLgw3Uz9ts0ZYOeL2ziEuOb6lFk=;
        b=tWGDJTsJpBVOOq+tijxq70CDGo6NQw/OCpflT4CatTFhC/TUwIF0TCGTQrlyPmSmDJ
         uCmif0JPIqHHPeXlJOQq2ksNGs96oBUPZaBbbtnvspVrE6ByrEoy4Czw2EFLkuCwhOI2
         fshkWPUn+LaHnxoEUC6fdhnNu/nG2WnCI10zRIvfJ127kbIASDyHtitCWIzOI47XSs+w
         h0mWDvkjWBy7NcqReIk4PSPQwH+JLplig3omiPngdQjh/oTlTgmky0yV2E54tAAf0b6d
         1gR5WP7Vw94uysCait7q483hkVu4JnkJuokMKEoG6lsOKzJpCBO41wz3mf2CJ7/rvo71
         m6sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwB0lX3Hmjosca6ThavK8zzPa7rsZb0vYiP88JA//fMCYDEA226iHh4tb4ggSUCn6UFWEd6Rec=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ITDt+glLVipeMDkWKtydFS5ai31Xha/Ou/SIYwDL6DhIwVidH
	elPIKu/hm8kuJfVOyvFH6ow8yMRbHmpvpsy5LACnCpbyeoERtP7ePoVgWTcUVLlKs9fuLvg92vA
	x4ABW4faSmJO+LC8ZwDjhbbFh+JvwRR916Mkv+ZlE+UJvL+h7+8aKbFvvpV5IG/b3CNU=
X-Gm-Gg: AYBFou1bu1HbRsuU8x6wFyjyVud2RuyjVVx43Ay+5b37KvItVA4rrJxQiyOxWvyG61W
	0PCMhZH3wqRKYQPX/JLiK+eAZmoDRyCORy1CaHqb/M+0lUWcnwvCu9Phg0mUYkEmMpBqVz9Tf3c
	h/Bof/R+43Fn9tOlelCyNkgRGB+LkDYRJInlhnSbnfJB1QG31SnnM62HO6chaBxvkYDHn/AMoaS
	ZHZp0MyLt2J8s5QTyBoBGDyNVm9TcQ/OirAp2gf7a8NaX7q7Q+3wjtHfxNSFy63Wjja/NaMim02
	4oQX7uEPsVq0h5IPN9cH7Cv/iZ59nlrtALkPdgJjidLYLzhFwNFl0hjj5RML+jE/Q3uOdpICntW
	sAsrJ5/9kgNUlwoLATDLl4TjAd+XMOE/bdpDZdIHer2Vrbv2MpNTjQawqKlQv+Kgc1N/04Q==
X-Received: by 2002:a05:6214:3f91:b0:91c:6e94:3b52 with SMTP id 6a1803df08f44-91ca47af0f3mr285847396d6.0.1793695905234;
        Tue, 03 Nov 2026 00:51:45 -0800 (PST)
X-Received: by 2002:a05:6214:3f91:b0:91c:6e94:3b52 with SMTP id 6a1803df08f44-91ca47af0f3mr285847046d6.0.1793695904509;
        Tue, 03 Nov 2026 00:51:44 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec16997esm66447766b.79.2026.11.03.00.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:51:43 -0800 (PST)
Message-ID: <47cc93a6-7816-428c-9c6e-43d689b459fa@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 09:51:41 +0100
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
Subject: Re: [PATCH 1/2] firmware: qcom: pas-tee: Always initialize resource
 table output size
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXzRW2UnJWsKQ/
 L598EDyMXy+QvfAqNlQ6eECUJ0/ci5mVlyQVi7o4DiF85elQ6Z34hzJsczTupNxMgzr0Sxvu+x4
 DpTYvhC3zDUfZZeYrZuUU5BGl3t9ImI=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9a0a1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_Sw2Lv-1HmNiuYeRDNQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXyxI6Rzt5EJvo
 53hPli7IiGYd3n4VofdBj0gR4l0hwCmY4pMiPaEDsyx7+9LWa7oDJAv1jtnXD9Fkdm+7ARpbm3A
 HACB2UXLJhClkG+VEg11nMJP7Jg8u686bVLo95q9jHpwLsqD/D248hBepsQ+C7BF7+nS9FSaB5F
 CxlVyAue4B6OR93vbozXCKDVxQbezWSlsGgejbRDA3YpCn8M873v+8JiV0JxXhdSxmhhRILInTv
 h1Lf911oat+nXi1OP3HRjyASqwcubveM5wfgs6p5SEBgms3amKvlLtqFtGUsSFnJyakgXq2TskW
 FXx9VQF4iOAocwI+hpl0HeHbXXO4HgWIqganO+luBnLvHEZV0eO065qTBA3kzHdNJ3ddEChfyGR
 g48wozife5In1TXmHQ4bpij1UiRfE3zxmgSwwjVTbMaMmA8TL1MHdhvNz2cApSpbQVqtrdda4eg
 Zy3QFnY6b7Dz9coXCfg==
X-Proofpoint-ORIG-GUID: 2N-TkWpazMkOdI-T-tU4TXoCt06c62XL
X-Proofpoint-GUID: 2N-TkWpazMkOdI-T-tU4TXoCt06c62XL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030035

On 11/2/26 4:01 PM, Krzysztof Kozlowski wrote:
> qcom_pas_tee_get_rsc_table() sets the "output_rt_size" only when the first
> TEE invocation reports a size smaller than the input table, or when the
> second invocation returns a non-zero size.  If the TEE reports a size
> bigger or equal to the input size on the first call, but then returns
> size of 0 on the second call, the function returns NULL (no table) and
> leaves "output_rt_size" output parameter untouched.
> 
> Caller of qcom_pas_tee_get_rsc_table() treats NULL as success, thus
> uninitialized "output_rt_size" output argument could in theory lead to
> out-of-bounds accesses further.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-bb15726c-4185-460a-a5f0-f779d5ee144a
> Fixes: b6f7978da0c4 ("firmware: qcom: Add a PAS TEE service")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
