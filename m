Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F732F25F3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452117; cv=none; b=X2dwW9PmlFIIL/AOIPqXeA7i9lJ0X1OBSrDs55sx892lQOFyb5NV7YBpVUH6emr0+8AkslQxji6kc0oVPQcY2vGf/Ipgw1iwFlYIg1r/LgQ2CRTiO+fbzI6QCBWSYVDbnOCTbv4reWczZxTGK9M1oR/eZEQGZAwqK79bCEOW6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452117; c=relaxed/simple;
	bh=VPIKZN43hVd/gv75GOW2hcsf58m/SGcocwt5Q6C6e7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVhHyiAYx1CW1/0xfzpSaSUfY6aGvieGoUHDW+2kpu4SgmBbM3UyKs082/5AZ/Tce6YCjgHT/FJEHOKamFScsKNcr6ihX+3XwsYZH0WxGLYbU7QYT0hgNc2RuZc7lIuwYCoM6danhqGGJnGiWoATFUr8t691gJmVOY6hALzTRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Op1qx4ll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=buEJ1jgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Op1qx4ll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="buEJ1jgN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRERL4058358
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=; b=Op1qx4llBGa4qUTT
	M9Z4GksSKWD37UY4QWfNrhuEAjkZY8aDHipoDv1aB+oY25XrERohsznQyyV6r9Km
	n023hD3c9EAgrE2dsC8P5DYlNhRAyTwARy8oRPOlJBMsH5nc9Jfdcf90GstNM1bU
	er9DgtroyorWSGpx6143oglDlI7w/ZGlf+dY+4r62lE/nL0UDHPaKFe8o2t1eKr8
	jkt39jNVbFjSxOnJynyQEBwbqEl0qwh+69p0c5vxplB+6ijKt6yyZX0gF7N/hj4c
	lcCmNXFe+CwDEH3OPgBny57QhtpWjVWCEIw2HP5ahhHh34htr6HuJWdfNXLSIKmu
	dWNDOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7c3sp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so5010704a91.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452115; x=1787056915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=;
        b=buEJ1jgN+d1tWvovHW5uXDagOxloGza8PRX0uIN9I6bz+F9wwFJULxjHQWZkxNRqcI
         AmHJ0wIolFqD/D+UO+4hVDsyePhFxIzKRC0zuuN7V7jzMs3o9ETgp6ttmlNMDHi50lcX
         bX57ThbMYN+NeM5K6QPDzUzm9GbearaxgpNi8e7flxIbd5sVwZd5zBBYOAs7vQBL+AGv
         ATgl79nVeta0TjsvOVVjuBYSKH2FoteAv7zlSXsLlCuIbFHYC3BJypoFvXOvsQGvLG4l
         aeuQqUzdlrH8UTpqIjUZ6dtAvIsLicZ7ydJ1WLHOc80ayIrRB4UegjThSDRXn5hXVSDO
         K0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452115; x=1787056915;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=;
        b=Ih8gM7IbCEYG3kfRzBCVD6HSyB+wdZMbje5FbHt0i8HwPqTvPnlSm5iTs+BQkEPM6U
         D9d9KMOQXB0v23LYMYwc/SoIO3/SWRqg5sP/NN2LqPn5gwygHsA3e2wCgJZ+D1ERir1h
         TbPGDwdB12RXo24vslYWl/RRXpYIVJsTwHNenc0KeMXGGFylnJmwtdbRE7gBw+YauVcP
         jdt5bfCFkYQpC/qFnRCLkVEyH6ORysU71sazZswrt49i3y2bZyv/Tb2gb79TW21e+k9q
         LCFO3mtI8Q9mvSQf17R6n92IPgtnFFVmQ7bEIq+t/7xggIOvGIg5SdywlIqxHyZgpGMB
         wRuA==
X-Forwarded-Encrypted: i=1; AHgh+RppKOh6iDQX++p9bwGn5Ri+XiVLyMaUw85I3qkVYoo2yxtCAm1r/l7b+2phhNsoJqw0seNVJWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GpMZPOKYmPTMd7piSGE/74aNPKj3YVjvY5Ll9YAJ9oh4CrFJ
	8PH3LD+1YCUsKw/ZXXq/j4uEqveY90h+j9I+j7S4J2md6dSDb7kBCKbaifr8OcxA2s/UETM5rRa
	6DbfhFXHuujKbBwnd07b8vYbFzyzPrk7KXX0IYJdo61DMbGdC2S38b84ldZE=
X-Gm-Gg: AR+sD12/Y/75f6bZ7d5zpZLpwlHk4oCmahwukX2CwwKtU1l7h+aqjfXDRG7jV6YPIW5
	9CxOnJsppteD2Q8bu9biZL8u+kxOj7wy1Oazh4otwYW+/6F3ixRpP/B06tLnjUmiBhxKCmeW7sE
	eiF9pOxMc6w7tylLPOMN/wG5peQZPKY7SHF4bOYTjpSrkcUFeDgP1v+Ee2CZFShsbSzDU6mkbpp
	AMtBQE2XCpSKSLVtNa31K0W5AtrNvZgjcHY+lkgah00/rNZwamyWqBnSupU8floOiR2nrSJDKxk
	lsgsCLJ0+ojY3m/aS0fNCvfneACKukOkxseuOFhs8eH6ZfKxRaAqZJh3iV6ViYolGHzaBu4U0c+
	SFfvwaACdDZ2fnCvXDviWT43BOVV7hrz9YEOus2WRINEvR08czq9boplg6FQpf3EdwUlgtwcE
X-Received: by 2002:a17:90b:5483:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-392ec3a9001mr3689018a91.8.1786452114398;
        Tue, 11 Aug 2026 05:41:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5483:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-392ec3a9001mr3688945a91.8.1786452113801;
        Tue, 11 Aug 2026 05:41:53 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:973e:782a:16ef:897c:10dd? ([2401:4900:1cb5:973e:782a:16ef:897c:10dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5381dd3sm4097263a91.16.2026.08.11.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:41:53 -0700 (PDT)
Message-ID: <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:11:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7b1893 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NFv0j6h37eyNFR9rI2wA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: YrIqVypQ_a47fwH7uepdPiU03gtOgdx3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX8FRJw4yfLeQD
 Xgmn/hqkFKPHXLk+3YwyXNVoanVlrg7+gG6W59gmMPR4C4YR8wenDCOqk+OOY8e+eCb8InuZNIy
 K++4DEVtDXsiEj9UEnGuTjsn4A1KirK7DMxqqM+O3NXUQKOeJde4i8VKoR0111zjdh5blYChDgY
 Y8t130xyiIH4qyXmDqKHRJIaF3emtNPFqtyh1AgW1FYXEK/EPIAv7apmRORei6QW3QOt1Q4AngF
 PWf9uILQuTFuZgonqzyDbCrJ9NCQtX2k2KCpmAvdqG8qZFAVUwONLwe3QqjUc//JOxFKFWEy4wN
 jw4ka0UmE9h1e5UJdfIZ/EyIdrSMJa/Ffa4r9PtZ0xqK9k7TmrijKOMOaQO9nr0oSRhJcNk3Z3D
 15ChNjfoHl/0MrjxcaqDNt0W442A0H/XIGstazVcUI9KXN8nwkZyIbMnbtPJkno3MEJHAJljMO6
 gy1Gio8xCXxAajRwyxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX4br1AwBet4mk
 jIBh/+brc0lHE6ywLRF9AAQ4Ridax1uJ81Z0ja8abmLMQnQWCN9OSPIBiAf0m3D27rgi6XmEflb
 DJ2lfezi49AiUT7/EbcWE/EA3jw59EI=
X-Proofpoint-GUID: YrIqVypQ_a47fwH7uepdPiU03gtOgdx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110106



On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
> To meet the specification requirement in the standard-mode bus frequency,
> update the SCL counters as recommended by the design team.
> 
Patches shows that you are adding frequency table for standard and fast, 
for patch#1, and all three modes for patch#2. Please, Correct accordingly.
> Also, SCL counters for the FW based SEs are different. Identify if the
> SE is mini-core or firmware based and chose the appropriate counter
> values.
> 
Little better, select frequency parameters based on SE is is RTL core or 
FW based core.

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Kathiravan Thirumoorthy (2):
>        i2c: qcom-geni: update frequency table to fix timing parameters
>        i2c: qcom-geni: Add I2C frequency table for firmware-based SEs
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 27 +++++++++++++++++++--------
>   include/linux/soc/qcom/geni-se.h   |  1 +
>   2 files changed, 20 insertions(+), 8 deletions(-)
> ---
> base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
> change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
> 
> Best regards,
> --
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> 

