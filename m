Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D83C3438
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464071; cv=none; b=IE7DFDz10Q3kh8chUKau6e4+vBkyM7qyFA6iPOt6RGooEU6RZ/mAlJHO5qrK1qSkRY1HeWFDS9C0dwGBV736Ce6HQ85OdKI32a3vuBoAZPcUCG3lmG/V7o0tvhM5cp5MJPxaSaEdIFiBZwCfILArL2vRmihxfSFgIDgOH+Zzf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464071; c=relaxed/simple;
	bh=rehoQlsh2hRdZmW9Mrg12yyBqxDpPRFDZpXLr5wHsKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3/DG17nwzlk9GY/MnDoAlCqVLNmSg7+Youig6QeetSKuazDnfL2ku/gB37OJoDJGXk0Q6F8LXBsMTpIdrHlZsVYwfMqaaZ3RKlhcUYDzlt4Vau7N0yzK1j+TnR9QXfUWMEgfPOQ0gcQXgdYNLoR5MUNXq3eqnZxJGPMSBG8j5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Za06XWNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HPSyXuaz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Za06XWNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HPSyXuaz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXKgD1091751
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=; b=Za06XWNPqZCopiIe
	F9sUW3/3yD2dBhRQQXwTymI3Fw+/6o5RCNDEEwn1Ypc6vxYmztIWrPccyxHIHWLa
	MjATD/NMWZBv9C+JfMtatjJpaQbMyGB+EeQVieWPq/Ep6t1dK4/UiazcTZCvpIUc
	l3H7Bnx9Mm8Dfw2NHkWT+YY25lJsrfzNwaijWO4rDfKbplAkbM27b53R6EsX9xjZ
	2smKlDL3tQijjST8fwp+LkGPdCBC7UnY0ZHFfKPkchXgUeI4F5bxSgS7ym9WfBom
	4b88U5R576oUZ3aLfKeTc+LszVpxdqrzEYdpGN8qXpxRB2dKyG7diU7/rQXROjzH
	BjO8Cw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049ertjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:01:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d122bbc621so2062775ad.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786464060; x=1787068860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=;
        b=HPSyXuazf0kzu7TkTqHaOMq8EhmUp7bAMtzomAZ94fz0Y4rS3LlHwhnXDAP/bFBceZ
         8L3CTi/riAkdfImtIFgSDWacjhuLmaxSA22hGGXVrVMxWnj0MbXVB/OIpaWHsJsLUmXM
         C5j1vUtj2lz4yukq25AwI7WmijHYERZRN/sshrvcaDGrLWGkmJBZQHJUVXuAVNRU0YAP
         6zWdLlf4BgVON/BhurG9uyP5/WwgBKCjaa/e7xI3KMaMWcPwx3ua1KxWjBckpUVJkHnp
         AeVLpvPOanwB5JnPo+TjMVfC1rPKzmenZQBq5GTcW3UcbCqOL/J975HhoEsgIEfJXFLh
         j64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464060; x=1787068860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=;
        b=iXqGLDeYnTyQpan0eHM0hRw5LONvkbIsatnzBdkqRtw90c1ZwmTehYGkYrPqHueHLo
         tBOr5bwpjrDC11Cwd3ZpRt4H9f96ZjkqcuB9SYRHcDUpOrxShQd0AbqZ/GwctBnP6HuL
         sCx7mGqKfSi6Gvo+rT5cwLdEfTTArUIPL5mfFH9uf+TzrLYdkKwOs0hpVQovz0Cn9vJP
         Cx5vxD2TYhF9+NQF/E+WSfbYtCpQIUHF2gHgv3hViTr89Slv+PuaEK6NQCVnqz71gMcn
         1FsAf50TxC70dT842mCmLlq8GOnomN3kBBU3ejfs/ZqDZe5dSanegqsqKdfpIuE52bD7
         mvxg==
X-Forwarded-Encrypted: i=1; AHgh+RrKXxF/0ppa8EfiKmHkGXxUT59RWtcDQa2qraghYd7mf5vZK0OG5E75zIEzUPuOx42d7rV/T9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsux7BbEXzVW85YkWv7U/NPH2iskSXDS4BYn0PrxaCfELtZka
	Nhs1ufDh08WBrJz7pl2gbAKV189jZ0y19SM+OTa3mbjZrkg04YcxFYjiuEUlfbnnxgwKOEcHR45
	cXBFLk5yNHJd4C2G9KWTjIAzipWo/TLpwubC0aUYRYJJu+C7di247TMNtaQQ=
X-Gm-Gg: AR+sD11GnpzZBi1cp4F4XyXyodDWnFqKWfIhFOqCxtBdqDds+Fgf2yEL5UL/e9SplEC
	Cs/VAnfdRBx91Goz1QjmVeTCULhqQVynFmQJ4WGrM4ADebQCEFu8T8OvOWPvLqEUbic8+LUzv1d
	fseRegjILuFCcr8lDq7GND6IDyC4VBR5dfzvd1ZiBFsI1NWezh66NoHIfr3t32/cWOch9URAGYJ
	bf7W022f8MKw1+upGjsWh0InIONuLeYytMaNSKmjrcbI7i9oujLUCgjSN1Jd6STyj1coF9iz8GO
	+B7S+Vn/TQPbxIqOs4lGvt2WOFpFv3ySkUEFv3axp2oLJ++p66TVnzKIhuRXtimNpVRTcl0qwn8
	kCQ6YWbPR9bj9iW8L7OlK/CwPh2rpoGB5LgjsRfKd2TLF
X-Received: by 2002:a17:903:32c9:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d317789dfcmr45912065ad.3.1786464058697;
        Tue, 11 Aug 2026 09:00:58 -0700 (PDT)
X-Received: by 2002:a17:903:32c9:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d317789dfcmr45910705ad.3.1786464057921;
        Tue, 11 Aug 2026 09:00:57 -0700 (PDT)
Received: from [192.168.1.9] ([122.164.84.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0f42sm10409145ad.14.2026.08.11.09.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:00:56 -0700 (PDT)
Message-ID: <a6ceafd7-fb2d-4fcf-9a75-832c40affc2b@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 21:30:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
 <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3C0Wju0k1AfJmu826aqasJFcBjY5g-c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX6HA9gJJk7sUt
 mfI42sBIRGoZFF0CZoNdkpCOIaMUJ1Cy+EA6VDXUSJB+r7/qrEzKkuf3cyUQmLKeG2XrtRvhyjj
 nEx2Cl8NKCGOhIYFg/99Q5gkN68chcA=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7b4740 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=0/lRlipvHLU+ZVN6ZkkSUA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RGlg5H6Z-dMNcyaZwW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX4IxUv0cVuAjg
 jiEwscdJgLAm+FG+vMqmOT59/sTnktWRO3AAMsuyGNdHcm5oAh4cYVYGsrb0Pp3qVvOtPbu2829
 VwgiF1YmP0CbmV3Jc7qTiYYRpkefN++UIz9OwFwuixDFSO+t2hfd0lSR054JZPKu8316vGTIfrE
 xFUjyS5Xm9pT5ToZhSe4z9iY7h7WNCE4V23SzxHS3/Yy1yno614HImdsN1IoZiXiuWh2ZNQkXr1
 PFwALmBv40FGdv5a18vV4aS6+X0fCOBgQOj8H34agT49//6wSgU9lZS/zLoL/OzrWvHUXE7I3ce
 u24IfFch+4uCB/FGvvFhDf/ASAVcJQfI2pGXt0HOz18xPwKWojlSAGjGIlRhnrMXWOaaXdpVjci
 MXCMfSVDm4ekKrySoAf7cbVuoxzjuQ==
X-Proofpoint-GUID: Y3C0Wju0k1AfJmu826aqasJFcBjY5g-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608110133


On 8/11/2026 6:11 PM, Mukesh Savaliya wrote:
>
>
> On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
>> To meet the specification requirement in the standard-mode bus 
>> frequency,
>> update the SCL counters as recommended by the design team.
>>
> Patches shows that you are adding frequency table for standard and 
> fast, for patch#1, and all three modes for patch#2. Please, Correct 
> accordingly.

Nope. Only for standard freq in patch #1. For FAST mode, it is just a 
stray space removal.

>> Also, SCL counters for the FW based SEs are different. Identify if the
>> SE is mini-core or firmware based and chose the appropriate counter
>> values.
>>
> Little better, select frequency parameters based on SE is is RTL core 
> or FW based core.

Ack.

>
>> Signed-off-by: Kathiravan Thirumoorthy 
>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Kathiravan Thirumoorthy (2):
>>        i2c: qcom-geni: update frequency table to fix timing parameters
>>        i2c: qcom-geni: Add I2C frequency table for firmware-based SEs
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 27 +++++++++++++++++++--------
>>   include/linux/soc/qcom/geni-se.h   |  1 +
>>   2 files changed, 20 insertions(+), 8 deletions(-)
>> ---
>> base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
>> change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
>>
>> Best regards,
>> -- 
>> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>
>
