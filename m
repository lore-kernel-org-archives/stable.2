Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772901;
	b=E+4dym49HziLTO9XUEW+tTvApRmy5DdfVxYHEu5JlF4gX8hhoSj5y5LY+UchqJZxJQKi
	 z1fht7Jszlj9bo9zSvfHkpbjRuBKwjAOlewnsV8wF19y6wF5n/g1mhO0kgHlmKfnnvC+S
	 AeGEx33JrVgJ4pBCSMBIs5EM83ZsBDt52awCrNK6GJfMfJwumH3jtb+FTUn8AcF1XPEHL
	 PFAKJ6IuTDTE+u1HgsYx2C/VhgKXZ4+oJE2+TYLMNUV+8dydMco/WqpXOXfUSd1l6lHlv
	 chqSh9kPQtb+iyq84fnMJ8jQsS9QTUEKma46X/sZ2Jju/8blcZjys5qfwGbVzznyd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772901;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ab35YM3lnptTqwtYOc9MLi1LtF4BDA/SuR6VP3OwrRw=;
	b=c1Jy42IBtix6X09Tu2yERQY7pVToj07iFey1eI3ypKiVxGUPYDaL959XAWw4jvYcs5vT
	 GfdZETNnIyq0NuBMYVFWNJ1V1uxfiIzdD21L2T5GQWXUVAM799FLH6EMcmE9roO3I0oPP
	 GxmDAZGQK1o+rEaWVbbPLCyOYXoGy1iG1vFvROTq7q+Tyr1fvRLslvVV7jc0owhqoVcNU
	 XzGEP4NXqbwI768Ozjc+FXB+p5HIWhcu8VrJGWUNFvRMLqitHmus8SR5pG+JFcH7ljb2j
	 KoWF41AkWwmIh5Vrx9WQovLGWv6x7zskRiP9MKa+PNXMW5arnU/P37dB1Wx2Etkyj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fZjyaOow;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5oSXALr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8340606A32A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8340606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fZjyaOow;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5oSXALr
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GlO23759296
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ab35YM3lnptTqwtYOc9MLi1LtF4BDA/SuR6VP3OwrRw=; b=fZjyaOowGea9OJ+y
	GAEOqSDBMxGhKNfGZx7uZPHCGvgTGF7cYDktJ+48vi0QJ7n71fVLFWEaKm9b+J36
	eT8sSyaaZRkpnhur2FlvWo8rHMP7Eox8SSN3kHpbE9FxDWHIcCoeiLe9jV5HiEme
	3lywV8yDlxISOy4jsX/okmkRd79yf67B7IYkYTeeJBB0wInDq/jl9kw3yppHYZgu
	7uxSXwLFc+rfsFryUSRXbQV0ITAgQLapuEO3ftV2qg05zibPwYGSBacn9q4x87UV
	OXMzaeEAz/vZ6cF0QsbYIhFUh2BVyh8Qx3zbTtVI7shX8BkTH4/blmAOlp/Gkkhg
	U5LfyA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6rsjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:48:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f040c6e0ceso73764165ad.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795772899; x=1796377699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ab35YM3lnptTqwtYOc9MLi1LtF4BDA/SuR6VP3OwrRw=;
        b=C5oSXALre9byhG3JOjtRwFsImfkdKz+YfBXja4OhHljw9Sy/3w1onxdywOe/IRCqvW
         pCBCwuBb8GW0mBXYjj4S3mwOTfrll0/BScDexAXBHR1vETIpsZXAZXkpuqDmQo67Jmq6
         kQZFxZoKeeYe/2CossTflYtiQ3u/rDYjgr6Y7SeYckUd1fqu/dSdbSyldFQBLK6CFddi
         +mmEGt3VRzurMegvOrqsnwqiAzLQ0rPGdFCUwQfS99bFn/O9AkvdkcRz73G96gxQ5bmd
         oYSqxK8LgYANIBHkkUxqqs+8yv7vgLhMy9+7H8vAP6Y7vv1/mv5odsRN+Ktu9+SuSryr
         1Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772899; x=1796377699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ab35YM3lnptTqwtYOc9MLi1LtF4BDA/SuR6VP3OwrRw=;
        b=yYv1xKhGNjw0jZDlrZnfakmGJS1zx2sB08q+uFCuDbTRfYKgBDZG2R0aj2LVRKu9n5
         6+q4R9R9CEah9nAacqjJIoA7qzcnn9OuoUrorMrO20blQ0mM/Ms3TharwN98dNE7CWYB
         tJUKRWENrGmEFnG1ULgz2AoNPY4aKIJlLCUevH6k/2wNObSM2pXAHxw+HfOtfE4JO5zt
         ecwOb/Aq98JsscPLdJl+JNQ+Ie+ity/2PP04oPy4lN5l38MxiTyJ5t17xsj0PsjGbn9J
         IwyngGQFvl+h3vjWUgNTy6L7D0jPSz/woEDPu6rsyM03JvZ/nE4fx1e22iYt9D+uB60O
         k6WA==
X-Forwarded-Encrypted: i=1; AL+hErF1PR1mM38J2I7ami00XXQJUG1fiaJosI2iJBhAoLHtklgINj4fs8A0ammxJotK+L3AqZvSO+4=@vger.kernel.org
X-Gm-Message-State: APuU4Z90J/72DQz827hOipiQfHp1cIq5tQT0qA6KAxbQHkDkh1mq5aJj
	Ngt6QUBf5MZspmKsVdPFgQ0rrs9WwtlatJv/e1i/ljcAhcqzua/3sJGqgkvnqTlzR4+5IOUZsWH
	Ka4RBFyGF6MvfLDYBPUGa737jJEg8FOI3mHkIH1TPFfAd/uxVp0H7FKPNfPg=
X-Gm-Gg: AZFdTZfYGKNNGCJo9rM+3eis5MFErKmTC6IgVGS4xaM96t2FXLpzudTZvoTxVKoKpwy
	farsfctuCSB7/myK3vcJPd19/dT6v7HvkepP5zQllYf8LF5EvM2t4AW+eW72D2qs2semCud8tCy
	gM/K3pSvvwkUCL+LqwUYmpg74btKEH0G49wyzQ0hN5FT9isDx6sqrVjSZj3Pfgu1r7YZpcFTPld
	rwLpWTU/P+ia2o3Jc14cRxa+VtMjmBKtU2GcYFp9A0TP4WcKlWHWuVDxj+v10a4XT8Mtz6X3ha5
	7LmbbOQWW5cBjkJQ0/3S9tgL1b7P3dqjv3IIRF3nZdBHuxy0VIVG9Z5L+aD6guxddUvfSd6yrhV
	NireYEw+H1Q01XT3MwHgCVxhVeFaM8tWv+AUdwSUDZhWFa0ZHtlB54rALw5/a05VQFYW7HIu0+R
	2gcFnCPruNwvQWaBbns62tF5XbWSFjWy8Xk8D9Bw3Kq5uInUOc4Uj6ip/MWYKu0JIOaOQDhsleI
	DI6
X-Received: by 2002:a17:903:94b:b0:2f0:3618:f170 with SMTP id d9443c01a7336-2f03f1acb10mr233462855ad.66.1795772898761;
        Fri, 27 Nov 2026 01:48:18 -0800 (PST)
X-Received: by 2002:a17:903:94b:b0:2f0:3618:f170 with SMTP id d9443c01a7336-2f03f1acb10mr233462675ad.66.1795772898346;
        Fri, 27 Nov 2026 01:48:18 -0800 (PST)
Received: from [10.149.108.218] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dbe86sm117153235ad.32.2026.11.27.01.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:48:18 -0800 (PST)
Message-ID: <7a77f62b-7ea3-43e3-963b-e01b86e14e62@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:18:13 +0530
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
Subject: Re: [PATCH 1/4] remoteproc: qcom: Fix bounds check in adsp_da_to_va()
To: Atul Akella <atul.akella@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, sibi.sankar@oss.qualcomm.com,
        quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106184312.100-1-atul.akella@gmail.com>
 <20261106184312.100-2-atul.akella@gmail.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20261106184312.100-2-atul.akella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WFc2AXkhw8ztOuiYALea_KSV97EN63vY
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b0951e3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E4ycadI1TCjYcBWHacUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX0mxJR+fep3xy
 Me1De2czxFLa/a81kPUjgMIH71SKb0fD6yVeSXNH4qV2E8XtifV7lJYsozF7eFxCtmgGMUnsBqC
 QAmpCNd0ggWfWlbvtDnmW/ZBNB1jRk4=
X-Proofpoint-GUID: WFc2AXkhw8ztOuiYALea_KSV97EN63vY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX3d1CfbRFohvE
 pUZZUX8xaQAigM25CrNVEvN6lI1fjwM9OdNSXsIJlapRICEwvdBfqU+/5ZM19EQvY+B4LrCR/iZ
 QnygN3qURCfdYzprqE+zOBaZ1K1K39GJF9rWJK8Fxd3aF4UTwl1NrOY3ccSZ8aeTGHajpqRWAiQ
 1wRSnUZlCpBDAry0Zeuw++ehNLre/i/d1KI7GhTtu2oBZtHaHIzc6ty85J0K0OeY15C8PBOGllb
 j4mkRPmdZu0q8ZNJJH1o5AyrrFcEk75j9fqBZ2QjC3uGGbgmfpMIl0QcWSQFT7cQTSFB38J7I1J
 AuD6RSJCS9/dgec/Dy6qWB1YfAIf3PnVVVBB/IlxtfRhHNZPBWU7YDiZyp1Jha+UUCU6WMwyFb3
 PdWbrCntqjBhGBHD27HsZRnJ9dBOhsa6/BWwhqeTHX3oakeLxDk9o/Yu4uOOFMGGnQIqS9it213
 U+yyezZRvAnGnJ+KKOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270038



On 11/7/2026 12:13 AM, Atul Akella wrote:
> offset is calculated as da - adsp->mem_reloc and stored in a
> 32 bit signed int, while da and adsp->mem_reloc are both u64.
> For a sufficiently small da, the 64bit difference is truncated
> into the 32 bit int, bypassing the offset < 0 underflow check
> with a small positive value. Additionally, offset + len >
> adsp->mem_size can itself overflow when offset and len are both
> large, providing a second bypass.
> 
> da and len come from firmware's ELF program headers via
> rproc_da_to_va(), and the result is used by the ELF loader
> to write firmware segments, so a malformed firmware image can
> cause writes outside the carveout.
> 
> Rewrite the bounds check entirely in u64 arithmetic. Reject
> underflow before computing offset (da < adsp->mem_reloc).
> Replace the addition based overflow check with a
> subtraction based one (len > adsp->mem_size - offset) so no
> intermediate sum can wrap.
> 
> Fixes: dc160e449122 ("remoteproc: qcom: Introduce Non-PAS ADSP PIL driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Atul Akella <atul.akella@gmail.com>
> ---
Looks good to me.

Reviewed-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Thanks,
Gopikrishna
