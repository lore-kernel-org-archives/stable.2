Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE79337699
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145285; cv=none; b=QRAiYDRoNIO/wGAITgNLKNfHxYigIfqjQgapkT9xTNSiMW7Rhaa2LYVwVZ3YZe8qNIDraH7iFxSPHdu4F2f+WfL+FATPtVgon0KvKUBO+KjNjCqiAhCsNFx5w+hn2FwKABS/An1BR/oHwRqr/0oenieOXQKHACIEUcB65rzml2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145285; c=relaxed/simple;
	bh=RCr3nOUng3cORR5flGuZas6z0ULDaAO+wDQhBJjNv4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljic9duY5+Ua2KvWLXqFnXGNeHPwLp7XVAAuVNf52jsN9X1/1PrT/q4rRgcUUyXx/a6cVjE9M4EIWrTHH6t99iZpOBv3BPA5tBwaBnmUoLWgkaOWBI47MHOcUKCm2ED/xakY7GrjPmNlFcTyDNZXZq5BJcUXPsEWRc0BmGoVZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZKRvwen; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2A2tgkY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZKRvwen";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2A2tgkY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0CNa901360
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SKFqy4Xe1zWA3eV617cMxEXyAiEWPIbn6jwL4vyO1S0=; b=YZKRvwenfTL4WI2Y
	kt9PJpIan3gvYc2ryiUf+zX8AxYJifYD51XlRT/nff34kDjBilJ0iiYIJ2TYmylV
	BCtfvOQI5LB90K+ubk7/56C+EGNUWztkQCbf3CTImK3CyaPw5haFEGNiLo7GrDBF
	cMCZIrLvJznqOJ9fvYh6D0OL/xMH6jNWgX+F4/Xgez+noSHIMEfwWJGHrHEJm6GU
	cfqn/KKR8Dn2PWDV4JKUSkgRKxshg+7q1oN8oOi5St0ozD1lOGbAxKHjJN7v1WIr
	AKLipN1e0s3ebEuycROgdR3ngSTFf/WhBQxyxylSM+f9TXg9FVMQqRxLV3WC2ubs
	2x1fpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpuabf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:14:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ddb567146so741531cf.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787145279; x=1787750079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKFqy4Xe1zWA3eV617cMxEXyAiEWPIbn6jwL4vyO1S0=;
        b=U2A2tgkYruPhrqibRdY26qPDb8eo1i+HGji13aRomGXMgk7OobFrMLiJqQMJMMYOzQ
         tIPg+IcAKANqLyivLlAppN/r82PDguzOneeS3f+enNFnc7KC3HVAzQVjhnpTYEbMZlSG
         vZTuDVemng2VM6+7DmgojRvBS2NvaoFihstFkIspKjfMyvoIdICbN5jFUU51pkjkRaU7
         Zuq5etFCFEg74ZhyXszFpmZObAn9VarR7rWKXsRvy26PsTel0MtnXRBAiWHLg0fDEvaM
         9ohqh+87FH49usroJY5UHXKw/CwflEkCuhSc3fqafghRQd3fDqur44No4+3f5CjiifUW
         C3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145279; x=1787750079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SKFqy4Xe1zWA3eV617cMxEXyAiEWPIbn6jwL4vyO1S0=;
        b=d82BTUV+y0/z95foALKFDlOvtUlkfUoDggrlISvoFbTA12G+mXxCnfYZ2TfIPgL6fX
         CfcFhXkEBhdHIzatocrKVokTzKnvvAnHqRJXg6y6xtSXkf8iiZ5D19umk251dAeD7uJi
         WcoNmwHVesLrrde98ioSnXyfB/SuQyKonobxpXNUN0ykPZXg/MVEDTPdRyHQ8n9qtXK3
         8y9PPzWfyWrMH+UZY9YHx4DsbCkc8ZlvJtRsucv6aXWL4AM6X+GiyO79TTqw2ksXaCkV
         IJ6pHLIPcCkHpIIdL8d7RFL73KkkGKs9A0lv4Spcz3AgfMeDAKzF5bDILIFtGitPWFLm
         52Xw==
X-Forwarded-Encrypted: i=1; AHgh+RoEIckDi4n15205FR4gbexNAsEU77Rs2Jf/dpWrT0WoCV9JQp3/3Q/MRaw/FP4CAGjJ9CBYoSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBTz3iqiA19Pi8veEyNjMd4Q2yZ0b5N6o+bcRJ3+QcHTKktBp
	BagIwrgDrgYC6Sd4YMmfUKmiL5KflRVmo2BC3A1ms8rVG79gn3F9Mfr9hZF4O1HVsVEIzfC08uV
	JaDbu9R9tFru9xcjBFLS0CuhbW3MOoARCUWqoGhtX/iYpfhcZj3VVVthPqjU=
X-Gm-Gg: AR+sD10K51D0ZopAJtt1CUAwZKBfMiKhup6venSpqUffHp+kxLznYKO8fNhYxEehoaA
	cJjWCfjt8WnIBaueUdcRnAA8eXDNRMJGK9fjxhfze2S2PH4GCEJVNm59QLD68eSOpw/PIdrzAq5
	w4axGg1LtyO3bTgqMoSnd2pH44N3DYnaeA0UgzbD/IiPFm6oNpk52wua5PARBMvTCQIWWxeXlCP
	Z55ZToagW3PLWZ6TM6FbXfOxuFA0/RDcvbu5MW4GN+ou19HlijqxgMxcH70pxvS8zQYUa+1TDQL
	yN9JsJ+HeI7FnHYfnMSh1OrFqFcUgatbmWZOCZTSDz4y4H0CDpEMQXREOnNVQSp5ZvZIeYDLQrI
	8mnl1dGAguFQBSxfTrM+LWvmz
X-Received: by 2002:a05:622a:588:b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52dd579195emr30916301cf.2.1787145278949;
        Wed, 19 Aug 2026 06:14:38 -0700 (PDT)
X-Received: by 2002:a05:622a:588:b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52dd579195emr30915831cf.2.1787145278493;
        Wed, 19 Aug 2026 06:14:38 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c277ba8sm70288366b.56.2026.08.19.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 06:14:37 -0700 (PDT)
Message-ID: <3b924a67-a229-4836-abc9-0985e3e10d4d@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 15:14:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: geni-se: Fix write to read-only firmware
 buffer
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vVmf9Kywq_uXqSpyykXbwqp_GkCEVvrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX5HK4oVMEqrDk
 MwRYuj2iGg8L8oTNKulg0FNa4R/HrPuoL4/unoRVHMeT4xFbnfOJcVvClYrXeWpe3KldjSKT5pD
 3L4uCYIRowDDELkjJy5cR8yAXGhS+fwJwkFOELY4YeYmgwxK3QbXmeDEtroAa88RV5x9kVdBoYU
 12/mmAtkTrt8VO3iufN5kA4wdonwrS2IQOHpYfGp/n38+Ud8560PkNFEC3ZRXyImZEfJSrgQY4Z
 bEQ9pWYOTmlCS1zGdiL03N01HMa/SnhGQIFiQqcTDl7+7MqyEhsTM/Rv5wmeOkQnIEpxKvKqs9x
 QWzU5CDYIoQSIaCUGg7mmkLuIwREcXcQmPEZ4WYa+hy/c7a5lbsRyfnRtJwU37EEnkcUQhXWS8t
 C2Fmgw0RGPQ0jk+vnQotpEt4T81pIx33ALOwXyK+5QmPlItN4lxe0DOzP4ucJC4wzwSXmUKjPWh
 fcMBfY/QVJ45zsZSfvw==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85ac40 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=nqMQGrT_VeaHhdO9ox0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: vVmf9Kywq_uXqSpyykXbwqp_GkCEVvrN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX1xAytlavKkoc
 Xk2hCPDQWR1nR7BEuV4mwinSwMDMW1NFwC8DuLRc2ERXRMeDSzFCBkZvvP2HzVG51QewOO1X/Gp
 QqOiZwxqdo10Jg1PwXikfXgSQmR7atY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190103

On 8/19/26 12:14 PM, Viken Dadhaniya wrote:
> geni_find_protocol_fw() casts fw->data to a non-const struct se_fw_hdr
> pointer and writes back a rounded-up fw_size value:
> 
>         sefw->fw_size_in_items = cpu_to_le16(fw_size);
> 
> The firmware subsystem maps the firmware blob read-only. Writing through
> the cast pointer causes a level-3 permission fault on AArch64 and
> crashes the kernel during driver probe.

Bug 1

> Remove the write-back. fw_size is u16, so incrementing 0xffff wraps
> to 0, letting the bounds check pass for an unchecked size; widen it to
> u32. The bounds check used the unrounded fw_size, so a segment with an
> odd word count can pass validation but trigger an out-of-bounds read
> during the copy;

Bug 2

> round up before computing fw_end. The caller re-reads
> fw_size_in_items directly, bypassing the validated value; propagate it
> via a new fw_size_out parameter.

Bug 3

> While at it, fix serial_protocol being compared with le32_to_cpu();
> the field is __le16, which would cause the protocol match to always
> fail on big-endian.

Bug 4

Please split this up

Konrad
