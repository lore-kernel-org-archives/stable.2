Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA5377A9E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556765; cv=none; b=pD8TVsA1/VHhkKKGDS4a3LMAC6f4mSH7wsjFvGNVDFXH3PpiaSi0nEy3kjuKU0vRHRXdvs7B8orQ05+vxPF5+Ln0FNLJC+IKeZYa0OtIOcR8tafreNrBW4KVzMbjDzq/JsoQiCePW+o1hZbzkaOqpyl9mjonEwFAWCRqOP8Ov28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556765; c=relaxed/simple;
	bh=nk1Fl85AwLsyujcFprh5cdau31/9RiURmNkcfy4b2Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXohkviEs+vEh5eAF9u9A2DP7YzwWGpPZjLgDPKZ8XrSau4zqG92OayiQE5qsUaVlAHSqopFPONKX0nV4UOfu4Ese+uYlxXjdG7DROlsGgLt/3lJifMvyddrKlgGFmzv1CODHAImPhWObyVLYSuu4dM2BGF9dYPpG6nyGJVKWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fICjw5Fq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JY7dH+vt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fICjw5Fq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JY7dH+vt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CGprlW4028692
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 17:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=; b=fICjw5Fq00vBYH4W
	JrS/qUZTzH/X32ppo5i4WDq2vS6JekO+X/ppz4ABtdKnKVfPTEc4wuolfRxSZJt+
	CGBJelw6oJ5/ws8qDI8k/KJV8j/EBq6F0z7JYpTGxpIV+sShx7IStRDf9kg+dryo
	Nx1eqCu6KPZpk0/JhIdDcLXQX+T5Jo1NuVJ0WpbBLMBQdKqXGvdcnYpBidpdKCLW
	kDAy/jVnrtcAJ2NU78D+GR0qUEd7PzGVq0DZtjUkDklsHJm0adepZat4Cooqr7rO
	sCJPSmGSREt5lBqGVEFQ83GIDMV54AllJW5Ut1ZjIY6LPPKhpxkBZ+uABJr1DNHy
	uSNDTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts0jhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 17:46:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc86a9ef97so24821755ad.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786556763; x=1787161563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=;
        b=JY7dH+vtge7IyvRIo10iGDLuaEusEgXeXfq30CHJsSrUSXeq/8AnZ9yGMuRtg5OE0k
         Z2I0Q4TVteAZbLQ3REFRuCPH3Nkz7yFIt83aL+RC2k8KsrGUb8ZFPRTwGkcEO+miFYqE
         +Jx3F2P855uy4L8olChFdotLGBP7gsp3nxX95EQBlUYk5Ltr76Au/Q0sTnb/CngcXSuA
         mISLuOuBhAgOC0A7+xKQlmWovsafYdBrGrn6OA7HzKgQyE3LgkPtQnhY5/3Wy7FZ6ccg
         3oz+hthDTfxzOinZ4EbUlDgmByy1NwpTluHb/1n3kH8QYGVdBZs4Mfs/nLLIHrUt4GOH
         N8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556763; x=1787161563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=;
        b=nFoHXrgS+YRbMH/3OJFA3MZxdbIjwhoz2wuo6LuXH+Ct/u99s46Tn2pLEN6ArxWYDP
         OSWlySeqxVMrtXWYR2UpIxVPk9WOoqTOPQ4dxP9noYqdB9/L22Eo6iJ4Ztri9PmRHrM+
         d61KZJUtsED3SlA+5jj/YXg67r/cwY9upCn0P0w5j2NOtIEbTXTeJ8IoPVV69Azly5M/
         PIXKIwuRhAeugKg2C/V75Nv+Z1NJnpH9X5p9WTcR0W21a8Adizf4VyPOUk1n+u748cB9
         jFzVTekQqz/3UzEPofXLKvlsQMQG1TdzMa10MZvRl7wcY93tuUMRE5NQbJ/HDNzNjijk
         kU7Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+4bNkQuOTf3VONToc/XUNo1U1cm+TgTmEW4oBOjrZ79vyWlmEoUmFdjXuWxpI4lhht+e9Vm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8e3i3qoqa4Be24MPjTJlpBygkvpZXs1aviqdYznZfJJbXCKkH
	MfIHDLitZdY/5adPK5CDlFuN4TT3jnJaVPMSbo3VdUUYOvwKgpdxKDRt8rjQUK813TsGQsdTA9g
	vY+6Jo6z3wtzQykLtFLeOFDfj9dj5fMv2A4ocynGkWpgL7/9SYNMd+GJ5gubzPSffIeM=
X-Gm-Gg: AR+sD10Oq0WFwFBhTbKDxBBSPpNcQzZ3EPkvYOxbjHN4qha9gBpi5lGpC5IxwY2HH1a
	CuVDVh1LmKjsXxd6kWaWdTTv0DdoUFzljN4Mn6Q8x/v0uhb++5d6hmk2FLPx8nyqLnU2FSPc6dt
	6msHzByFhuIzOd95+PznJ+fHqJHhZ0J/lFMIB7Ofscl/UizsQmDhVrMiOYQrhKell+DV1D92+zY
	zD/xWFfT3rXRWaUG+M8L5oc343WPSkeekvwshYvDhjcALBplhqJ9MbieqllljWjLucHpWnGPvk4
	w0ojOGeIhswM6gsKCLIPhsEg3UlrqQvzTaB4NtGSu9qtaUdGNnRaDBGNxNoj0ueUz05V3lUGiHS
	CQdgsgC0XFAEq1OkvMiI+2wHOpswXHnX/BG8=
X-Received: by 2002:a17:903:292:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d3456637e3mr88725165ad.20.1786556763181;
        Wed, 12 Aug 2026 10:46:03 -0700 (PDT)
X-Received: by 2002:a17:903:292:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d3456637e3mr88724295ad.20.1786556762588;
        Wed, 12 Aug 2026 10:46:02 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.230.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c49ce11sm79005ad.67.2026.08.12.10.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 10:46:02 -0700 (PDT)
Message-ID: <eef12701-e916-4c4a-9dc2-2b6836e7cf59@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:15:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bLrZ3MdIqwEcWg3XtDyvULi6ixOsSi3-
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7cb15b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hsRoOqe6K9Dtf6G3Ghy1+w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EdN727LykUWWqtJ7AlwA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: bLrZ3MdIqwEcWg3XtDyvULi6ixOsSi3-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX6v+WQ9xUkB8d
 5yGXArnHD9SdszphfL4Ooz5uVZFu/l9w3pyOLglSb1Ket+wnl8PRMTsFE4NIgjxqDrtISpg/nVe
 6i5kGugYHq0+7fVme4xXiuIGtTmHa+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfXwXYAm8YJ/M7T
 RuwyXASbGhV6TPAxbgSR6ESAHGdCBotYFaprvMGr7ANGQjZP3qWduFnlERa75Wvn5bXzMZDooQC
 lnVeptwMm9y9j0AMzVsNEkf6dbZIDoPfTP1oCA2cCEzWdckilygHjhFfgC/S/NhHNRQbgvT5T3R
 jIUtlndKN5OR2zCqVI7mh73QN9iHpFQK9+GS6EydjGp4rYCWmYTobR4edA27aleS2VVpLEr5UU4
 58+wL9IzjuCheqe3FxkwzxzxG6AejTpcJLgN/iByOPSfu1kSLp8i7onDK7fGXCb/JCQaeu568YG
 w+UZxI3clJDIFSmbh+lk2LWnjUKQOls0tUkxIag3YoTzRVxAugEFvBF3UwcQfNmiNecHJ9FILUj
 o7jVBEQiaMTt9s278X9qlQLPk2KLhpjRlbItiPV9NoLXV9u+kR6jJNRePr/FvMCUAdAM6N9w8kU
 4d0HV7GiaZf20nw37dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120142



On 8/12/2026 2:00 PM, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
> HW design team.
> 
> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
