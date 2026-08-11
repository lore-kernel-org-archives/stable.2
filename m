Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A83BD24A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463817; cv=none; b=l1HhOFjbqABI8R56fMPYYv3R5eluZqEtO282K2MLvFVmJaftMZQMIOx1i0C0sKMxGXS/EMOvVjiqDCV6oAD5gMcFbYZKolkOUpXOTYUhRsY7cPiDaAE0apuGPzORW0uiIsZZ1uNf0yLD3fYJmDmV+oMMIC7TDCm0X0Wn3FkkdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463817; c=relaxed/simple;
	bh=gR20aVHHdNNlZ7jePZMWsNtnoXNWpfKzZwiuOpo80jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSVwAH1vbxGZfH5a8/i3vIF3Zlbxha1c4KvMUVDZrEO5NDUahk8IjamLmzuzB77i41qOxqLp+gVFGfOGJzNCgiT+tDgcn6u2SQ+GWJmlOgDNJSTISaEAVFNmsAd5g1DzMpN75ZAVUsRtksVT73fzEoaIs8AwhpqqzeRc+dwlhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZwKG8Tq5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZHbXiKkx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwKG8Tq5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZHbXiKkx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWjIR1090650
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NWx5wQiFNSaNvgfeLEooxmOF1j+J8p0cFgG5R5h1z48=; b=ZwKG8Tq57c/E3VCr
	LlkDKeIoxXAGpvibamQBFQ53x01w56qpMw2ssikYTZzNIEZoU2HD/GvuHNRdcz/p
	5qpYxOEibkMKtw1bOYMgoH16HvDEdU3AoLXh5WkIuhuVlNEn8EGI3YiXXD7MYLhM
	2wrvEu41v+9Mr+V61jEjLwpVWP2SAccO2x+LVsig+xWHsNeQjfl6FSn/ohsF+Lw8
	DZUtACqaLoTxhAR8CfxbsbdrzpaFGbp37C8B/Lj+T9CDcdt8X/Cd7llJbV0IflUH
	ZUB3iQ6qO7RarLkIqPB9/rfZdQco4QOAHiOqEgrFfe2Lhj3ATIFEY8ZFUisSG2Y1
	RmGqpQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049ert1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:56:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so1478955ad.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786463813; x=1787068613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWx5wQiFNSaNvgfeLEooxmOF1j+J8p0cFgG5R5h1z48=;
        b=ZHbXiKkxljOaGRuOYf9/ybUI/Hr7lFKLlXOCX7Hm7Oh4/gyHgXs86vlAMUDsSJzzmT
         m8MlUzchm6Q/HmWYcc86dKjvx/LllKmO6T7RY8D9U+ytpfCZ7KbV5cBCCFxVOUH9cMCD
         m15b/aLggDC201HP0avMVkyg2j7CV61CvgVBZLLsUUv/ayy2DaoxhnsftUvJtQLVlwrm
         kYPnKDUawvD4IFcWwdWYW/IETnDb5Y77LI3Vc94sGdBrwUuTnnBQZF6Y1dq52E2tntIu
         RFGtX8nb7yNiGjo6liZ9hcJElOTmX/dIGNbgN+cEd2D5PCMnIp+UOrkwnuzDaZTmQ44c
         IFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463813; x=1787068613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWx5wQiFNSaNvgfeLEooxmOF1j+J8p0cFgG5R5h1z48=;
        b=mksCAg9+5oHZfNnlnMQhSmV63lFChyENolHi3rNrDqqUcC9u+zdp1VeMreTUVCwUz8
         qj05SDOIJS2WBJjgHkze+uO6dOI/vbsBvfgNgbwOCfwpeCPAAcfXx70n6h2DT+l7MYDT
         dvo3XGaqnMcGnHXVAVgJRICedUWALRGof+sXXy6G9Cpw7UI1HquAUsHOaJMWPJ+fp3Yx
         njdfNPXQjqzfr3wdwY6fbg2T/6Obn34d35xYMzbdSQzVUoo0Dos9n2R2WO0asD8VWscE
         IPJI96F5kMB1aiAfkVVcqcRDnqLuv6LKoF8Sr2fDu7UN/pMiIy9jevrNyvhLnYVcy8fG
         yFdA==
X-Forwarded-Encrypted: i=1; AHgh+RpAhZ/qRpXNY4vxK/dcmLBFfk4EyQsZXH8xiwJbc7U7IsavGFo4EXFhrulXZxCvdzuM6a7XztQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu97V934ffNQPNf3rzfeatbLDM5WbN85O4zmqA4xboUf2cd/ey
	vh3TOsUXt8p3k/uqiwJEkRV4lB0GZ68Ii+a4mfWtyQOciimc4+3enGXcsgKcoFzisLV5MYjops7
	9zqHPNIMxx6JE8WrAPr7UUqVft2RUXQnNii0VJW9DFpAON85hKcxAfc5jSlI=
X-Gm-Gg: AR+sD136ELuYNndsx4aHKsm8Xgk6JC+ARTHj9/P7Muz/ydYjUYQU0Kdvs4zWV/12f6W
	SNBE6aKvWkEJOlE65SfGpriBL00Ni+6dI/HYbRd2zZoUZ+Ywk4T/b8FuJkHLl3M9nEfBdLcnnyc
	EMw2E7cPJX8excm/M1dxhridWd5+4wCQP2es5mkJ8cDU7o5OfTZukCs2sE2a4FTviheylobHRBN
	mJxOrbrL/7+VZs87s9uiNGYng83M/pq8lq2l+yW+kknPD96NF0ZZexnnm2JJHcJA6bZ/6JYmBTO
	fvX/hx6IXwqHbwgqrKOMJVZbWSnIxp7fxDvqRrueEtex6qGwyaoyd8EF2by+xf/MTupYzKp4vqh
	z1N00OZCV0L8sGIME2xzkGgRG7a4AuNFqbU8fYBMmbC0H
X-Received: by 2002:a17:902:ecc8:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d317761f7bmr45176565ad.1.1786463812726;
        Tue, 11 Aug 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a17:902:ecc8:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d317761f7bmr45175815ad.1.1786463812092;
        Tue, 11 Aug 2026 08:56:52 -0700 (PDT)
Received: from [192.168.1.9] ([122.164.84.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3160cf975sm10526335ad.48.2026.08.11.08.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 08:56:51 -0700 (PDT)
Message-ID: <208f6a30-603e-4c0e-a7a9-a6e647b95d69@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 21:26:45 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i2c: qcom-geni: update frequency table to fix timing
 parameters
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
 <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
 <8a6581f8-e9e3-4c02-8d26-245c102e7428@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <8a6581f8-e9e3-4c02-8d26-245c102e7428@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX+FhMDQveZKkD
 o4nPqykyQyeqtyun8GnwGZUAKU5NwAlzlApFtQacx5TyEHAKFDrlrzaqG1sx+cQiuJcKoTcm8c4
 mstdzLSVNBzjdoJby3u9MwgvjUwt/FA=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7b4645 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=0/lRlipvHLU+ZVN6ZkkSUA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pous5NoX4yLtaCBAYDcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: smylAk8-_hqFIRqcmIQDVfcK9M2N17UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX31AUrFdwMM7m
 IeSPOxdnpOT5EKUBm7CmK37I6KPDAoISCtC+xVOc5CtOU6zhNjmHZ2AdVez51qELY8CJMEQ589A
 d4ubWby7AJKNYqr0leZ1t9eDTJKCEKolIdgMBeofC0mBpoLPMv8nFIVdxY4RQ1/Zb/Gd4f8WiGv
 8be5ifU7QtjVIg9mE7cQpKlzSHMX8c39us8jK73iCXJg11d1ZI/2qnTlKpzyL3oB/fqindTT6MI
 FHAFeMxpW7KkE3F235x0H8LqKcity7gJShrURV2lNMh6ZJpfleDvXJndDc/X6U+afQFv7fELHi0
 e7p0vHB8Mg/YSxOcUe6aWhRFxJpUbJEqhQn/y0cRgO/y/X7TbntoxxvN5xazp9wrBXZdLMQkYsJ
 7o1ett98bl6opLLJtzWxo8xFFnEbUO3tvws6h2HJR+EDEQ5Vv3LrIH20m7xfGpAX9MqfHk+Jxa6
 DfDXmoJGF+oGwX9b7ew==
X-Proofpoint-GUID: smylAk8-_hqFIRqcmIQDVfcK9M2N17UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110133


On 8/11/2026 6:12 PM, Mukesh Savaliya wrote:
>
>
> On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
>> In IPQ5424, to meet the setup and hold timing requirements in the
>> standard mode, update the frequency table with the values recommended by
> Changes are fore FAST mode too, please update the commit log accordingly.

There are no changes to the FAST mode. As mentioned below, I just 
removed the extra space between values 4 and 3.

>> HW design team.
>>
>> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to 
>> achieve accurate bus rates")
>> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz 
>> serial engine clock")
>> Signed-off-by: Kathiravan Thirumoorthy 
>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 658636c1ee0e..00013b41a6f5 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -188,8 +188,8 @@ static const struct geni_i2c_clk_fld 
>> geni_i2c_clk_map_19p2mhz[] = {
>>     /* source_clock = 32 MHz */
>>   static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>> -    { I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
>> -    { I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
>> +    { I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
>> +    { I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>>       { I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>>       {}
>>   };
>>
>
