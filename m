Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC1352009
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905393; cv=none; b=LuxmZwvFCnE9WFJfwvHiUc2CahHNg+PFwDCxCDMdFtTmQpGO0JWkj2JAD6iMOolEhkd4WleuHFRmQQG34e4quniDBQbVh7kj3BQkZDy4gWYX0dPlWmn1EFxX5YkDv7HHostpxqDTfyV1+MDS5pvTI9htrvGiaopXCI6j6fzJNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905393; c=relaxed/simple;
	bh=KgdKlDFUiUTqm01bao1Yw3v1dGJE7B1VENQi1CGuzeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpfcrvnYRC2IXkuG3EZT+W9BBtQpiCSsaERzSWNk2tkJcGFIB0HZEgZHAyiha6bJpQghwKW34x0rgxDzd2wGfRy9p/TZpf2cFLrqHU1nHz8K0NZc76aIT8s+9P3fR3SvmWiI75bt1mefJ2UBWbaUCoaWANSoKf4XqfqFT8Mf+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAc0kSwV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=anB/7oBC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAc0kSwV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anB/7oBC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PWEn2808320
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 07:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XedEyF+YcWLWUROV1EIv09BrhpY3xilBgA1jX1UONlM=; b=dAc0kSwVY0WYwsdA
	4bwxDd6F/RhRzXke7WinialL4qoVFhlKqw/VpcsqETJLJpPVuMo0kvnCuQIn7n8q
	MB83TNYVthk/iyHCr4Xknnla0DrhmEfMuziJh6MblufaFAe2Q6PtA+xShh8kTenm
	mlYamFvAzYZp+slMXvZXqdpZ+ZjKFYj4qUgJBGiD8U/xEhdNm4NTHkeSSfgUb7Ct
	G9M+61sWoPcldDirD/HsNKyADfti3IHuO17WTD5Y+MM9VeV5+qjonXfwN9uErigV
	MsIqKrdAbRrWaZZJH0p6ntuB6YV9lYAdCg6MI0zN270hvVRgucAj3dLX9GBRqxbt
	drsbnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6pd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 07:56:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915ccc2d4d2so32650085a.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780905389; x=1781510189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XedEyF+YcWLWUROV1EIv09BrhpY3xilBgA1jX1UONlM=;
        b=anB/7oBCqmHPi7DLNV02R/+sMDUHPzhQ5zhERjy87LoI5fSfiknR7Sz5+johm9TBzg
         Ai81vtsmSaL5Oeo811O0uB9d5pq/xrSKMRmjlMls19rA7HaBNlnbIe1Y3cdu7f6sS/kh
         3ADZsuQaUO3f8KiltHJXO0oY+6iGMLg2c0uiTNlyNhcUqAjsxZZAYP9FsHhdpXhWVrug
         +TfyVVwGirjY8YQZeagnR0TYRmlsHB2DGwFgvv9W9Xa9zKW7olPLhZSknojrnXqTyd57
         Ao4pLCJZUmv8hfb9NU0RJGu1eJdVQ/1RvHrPRkKXWGSz99x0js4UvKsAfQ5SP+hNLc4J
         Lm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905389; x=1781510189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XedEyF+YcWLWUROV1EIv09BrhpY3xilBgA1jX1UONlM=;
        b=qnumFiExtKQSWtp9uopdoiV5aFe4Y96OgD7e9Ns7Aom5pUPrPy03Fz4OZU9BJUnPWj
         WRyP0lENKVzsNMlG6KQlIdE4DWRHJ0q7WNz6HJAqMEVjFsJ6YHm8H2vta7s5RuUOVxBi
         fkIfoqLPo3QOuhF6yPqPBQVQS+pRrlxSJf2umqQOwnELg6sEOIgTY62Wy2veBYb5ucSl
         Y9834lyo9ve+0R9rhV1cygCPoP8x10WX5PZj04JdJTRaJvQhMMLICG3K6IUQVLSfiyMH
         SFo0nZ5ufeqXDY8vdib01EGIF5BLLulbpEW6BkIswh5DrdVFLJpglYg9h6dx+1sQ1ZhK
         Lp7A==
X-Forwarded-Encrypted: i=1; AFNElJ83Xf1koLMAjuxlQrnEBCUV3KCEtS9QcfP9WTY+JV8TT4EUuxYZmi26uu+2SVfDZDIDkfAInE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8Mzwu4TNvuZ4kja8p/HrkcxQ03GHwPvx12q1+hFOcnQFVSJL
	RVocCxm/g71quqO8ssDqwKPjldvZr4xtYwZISnHOUiPENVs3xlUsCqpCohihv2psMQzLUpAks4K
	xlpZIyRzeqSpr8h7dry6Tcvexxck7m1NwsjyGVQ9PCV4wtNM2OD8+K/DFeic=
X-Gm-Gg: Acq92OHwauOt35g3PCU3+Po7KjqwcjKR5D5dhMrBTmxhMPsnBUQbHu/U4fkRpauDHoD
	/LSItI0DSl9hy127Is8oUMPP3Y+QF9kgP0RTG1j2cerOH3ttPfY8UnMJu+Dsii+CnpHqe8u984s
	MaZgqk3EEYYeUZVsJ5KaEavN0TcPLVKG+TCemCL0jDr6DRyAvKFwuDJMGtvGXX7x307MZqtUdeR
	i1EAfaaQuup5ahRY0RS/oiYRCqGEbPgMP30KhLXADBW2rsjA/+eE3W0p4iFIlqwxrBfFDzbbCld
	u9Xrk4KBDKxNePff3t0Ta1UXgCggaWpPqgmcBvUy7SUXfGo0e+pTfQSAGfk2EVvOdxg8MAPRw7Z
	RNjobqE8hgsV83thdFcl8Zl7nTIp9422MbESa+Qyy6XwXuqoWIq5dqwrL
X-Received: by 2002:a05:620a:40ca:b0:915:83fa:b3d9 with SMTP id af79cd13be357-915a9c21c3emr1311097485a.1.1780905389516;
        Mon, 08 Jun 2026 00:56:29 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:915:83fa:b3d9 with SMTP id af79cd13be357-915a9c21c3emr1311096185a.1.1780905389135;
        Mon, 08 Jun 2026 00:56:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e05199sm803704766b.29.2026.06.08.00.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:56:28 -0700 (PDT)
Message-ID: <79266b8b-1c9a-4d91-a567-1f4934128bf1@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:56:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] crypto: qcom-rng - Enable clock in hwrng case
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Om Prakash Singh
 <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        stable@vger.kernel.org
References: <20260530020332.143058-1-ebiggers@kernel.org>
 <20260530020332.143058-2-ebiggers@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260530020332.143058-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nIziEZKd50WgtixJAmCDTfvUZOFCxeGp
X-Proofpoint-GUID: nIziEZKd50WgtixJAmCDTfvUZOFCxeGp
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a2675ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-B5nq69xhfM--Ug7SGMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3MiBTYWx0ZWRfX44uXstpee3vg
 T61vdMRFxLNrkA3Qk2DqMColZwMpNIxw7TCdralhwtdudVUM82wwUlYGElbEfCjs5j8ZpxYWn5O
 dSWYUTrZHGIgGJgexJb2i4RcN1bNQe6imOby7atRZlRa4dv0PQXnoB1OpHMLFjSK03zkBTZU7II
 s9jIWkg7lVy8AfnSazwsIVPwSKNVpheoDwr51jR7OoHLAcHmTguM8S5PSK3HL14bXq4WhIKAy70
 alpFt7y3mSKBOotdGI3jw71QMKAJZmqKkSk+j1boz260TvqYKONQHrwH6qtTQmOyPjekmMgTe7m
 yCsUG1jO9eAiQ+kZ+jjIIyDGHq1/F2DiCc0oz7eKxGlbM8GQvfbTgwej5B97H+knGBIcScC9xAC
 ejrBpj15UbSWLmLt9wjY3+4OTCHYdL9fvaWHMsHrPlHQFhjFbbodxtaGMxF3phXvpTXEggry2Ya
 saSoEljhggM2sxcOPyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080072

On 5/30/26 4:03 AM, Eric Biggers wrote:
> Fix qcom-rng.c to enable the clock before accessing the hardware.
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
