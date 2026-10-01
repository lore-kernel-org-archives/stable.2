Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3B3B83E0
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871359; cv=none; b=pXji3HAXK0IpRLp9XIIz+NUfVZWihQJqClfTw9/WOWNrsKf4wjvDItbB+0TZO3FlUhDBTX1jYH9OsR+EFTuvbGK5IWaqm9BBBs03EpC3pzr9tZRrAqRbWcJczo3FqZL4zZ3PBRxhfk91upmElelo8HKGFWHZE2WdnWGCqHcYicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871359; c=relaxed/simple;
	bh=uqVWGQCfo6Yf0kkabKm2EtxgVf2o8pjULxFa3NT5B+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esGTL34f+gmlM026sx/thX3fzyLRwXJGdmkugCEypYcN5zdatZD+kQRuX9FvAOZ9BckZ1ZrM03D7qyusHkgD0Hh5TJHPXZVOmswH6zpCKvh/3i610dTsHuGEsxiaPLP5lq4pburioPd1tlzbCzLx0XhSwFdrrgsqxo4h3/JFk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pT4KVaBJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LX5tpIkQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pT4KVaBJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LX5tpIkQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691Fsc5Y2686757
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 16:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ekpOIEshdfoL/KvLAu8ZlpZV9Rt5VrpqptUJ/oZGIKU=; b=pT4KVaBJ8HaBb2az
	SGM8bpJj3fGjPC+RoGJO9ZV1KyrZoG96lYe0ZxMgP+xAsEFmCbb8nHy94TJOxOSl
	edFLmE+EGHYDKpVs3oCk2yxb/+wCeVEmwnjQGwH6acC7fCSWPkpzYYOItXex0WQL
	ALoc97O0suq1+eDC8831z7TT34nX9oX/6Zw5HkLf3+A9KdXsrcwT18SfYkT2r90x
	4c2u0a4EoSgfH7AnG2THlYM8T8/12ZGLm6gHuSXhKpJlSF74JfAVtEwxk7vpT6Fi
	H3izDBOdHX814bNZa14kDyd8LQZ3T+PlmmFTPlH/IXDhzZqDw1zxQ9iqSUOYJCCZ
	UWA9zw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a86uy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:15:56 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c65b0280a2so170135e0c.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790871356; x=1791476156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekpOIEshdfoL/KvLAu8ZlpZV9Rt5VrpqptUJ/oZGIKU=;
        b=LX5tpIkQ0YvoGxlnQubxOsMc/9J7GfuT+UUvq8+5NedQHZNROEcRwgnXVLWPOfCPP7
         Kk1wE92LDtQNI079lNOU7gIE4cqoS5f0586dv9TeSs15pkpwCO+J7BnL5wAQISphelAv
         PBOUbe37uHgY136jw4twpdLFKsvreNtaJR/uF3aUAJtWU/v8O1XCd2eY3o/wlvxkQqCn
         vUkJg7hh4jClcbzub9Y6xMdDGf0LsC80JNvcl4qOExILDFlJUKjOaHWWKVusIaV5Af1g
         NiMxOPSHf0TjNYlBELpxJ07M+eZeIp0YBhG5saNTBq2dXfWJCmM3p8QxoshzkFRbsKn2
         gw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871356; x=1791476156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekpOIEshdfoL/KvLAu8ZlpZV9Rt5VrpqptUJ/oZGIKU=;
        b=ocPCThCy1U6Gwd7NQD3KknevfRJRiNIOzBZst/H6lcHOkgEmUfd1gxo7p20ubLJ8C5
         6QlRvVuCnMOVUZXPXI6X9n9XXpUbZN7eNl6sNy/wgNkfusml4bH4dU5Av3oJT3Ot2iND
         oLWwImpupisefl3qiLC7APoUJ0BiskjyXqsPnbqBVPp6UcWRQlJOPfbEavKJlamMSwVd
         f+X+P2kjxwBT++OBvQ/HW0wSpqtKLZG7wrrMvKdojxS+XDZ2JgQilTJ+EhSs+Rbad7Uj
         0nUmPze6M4gGSle9n7lXNAU94nbzi1bffbIWfQUTMKfXUw/+kUxq+3s2USRjUUvhb3Uf
         EeTA==
X-Forwarded-Encrypted: i=1; AKwUvBwwt4iixTVTLZmt/atS1JVCugu5rM+sHR5k4nENW6UeXvRG0V41VVngifdFgqu8C+uwDmH+p5Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2K8I7ylp9YTVu3cK8Vj3+IWzi8d/0sdZUBWMEn6rlqrmUUiSg
	wAPWbbHDbxgcr74K/OLEZQtfNMyemui3c8c6er3ke9DYDrej7UNQMZEJetOZupbfAyf7I6WutQy
	3d+gdAqjc2YUjCHBpVEbc14Rda7Y7nZYsVQi7Y3eSk37H+oyl4tvdH/vQj88=
X-Gm-Gg: AYBFou3Z4jQCqnWM3HN07WBSsc8aCGnC8X+bUmAv1yVXwdmk8eoZJBeR2e/B4IBTycD
	7xSBDrVeZbKgfsONrqKRqiv7UlCPJQL5dPlTXhanM9XZoowAuhhCmwRzQQhWWorT3O6eyHBhN63
	jmbXVwbGADSfpc3UdD7CAdsni32PQAAjjAgp3opOtUUaAImg9CHpVxxywdvBnrpISA6lNNbhXOV
	+WtLfKp8eBq/9pS1QUZzQHkeyasMlbdBFx/ur9FmaatgddqN8PZ+wfYiqpIb5xwY1rBYuFwEfmG
	JkYsiUPbsvG89GBUjyDiiGrNtz840FY+3kTAGfGV2uVIzb4Vj4HOmuwzeRiedbMoLLWX836fdzb
	Dd0tAR401VHOp3XhWaxpF9w==
X-Received: by 2002:a05:6102:5ccb:b0:7b4:d43b:43d2 with SMTP id ada2fe7eead31-7be729aee46mr1100997137.3.1790871356094;
        Thu, 01 Oct 2026 09:15:56 -0700 (PDT)
X-Received: by 2002:a05:6102:5ccb:b0:7b4:d43b:43d2 with SMTP id ada2fe7eead31-7be729aee46mr1100978137.3.1790871355621;
        Thu, 01 Oct 2026 09:15:55 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d80d5csm183510866b.51.2026.10.01.09.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 09:15:54 -0700 (PDT)
Message-ID: <66d48e1f-7bab-42f3-84db-ce794f2a2a89@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 18:15:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as
 critical
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: Stanislaw Pal <kuncy7@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>,
        Jie Luo <jie.luo@oss.qualcomm.com>, Georg Seema <georgseema@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260918-ipq5018-mark-gpll0_main-critical-v1-1-fbe8f27a0106@gmail.com>
 <e16cf23c-82aa-465b-81b2-6240f4a0f4d9@oss.qualcomm.com>
 <f2ccd6b6-e5a2-4d36-a12c-124638c31280@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f2ccd6b6-e5a2-4d36-a12c-124638c31280@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX9MEa5PYK2X9a
 dgjHz/bmqmIn0YRzvKGgOYUf+5l4+gdwyYwfNfI1FUPoqL0CuEkR5zaOhVqjybGjU3zSsCDKL9q
 Ooa1FWSmYJuJPN3zHxtFikB1TVFczes=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe873c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=qLDurSU9-_G6tQfgrAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: 5bL-88o9RMcrFxPB-gDTBiHLmqXIi3oB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX1WaT3WE04bJ5
 8xC8p+Dkel8xWEbhxI0kZguCxDuYPPQVSzmvdUEUJhyk1/hAs6drG1E5SveHdqlRoCXEfe8PffC
 ejMvfInBflsES5jtKm7kYNpnirCj91+Sijry86OuPhmbeRL8ffDNv96NIV2EOE6tZtj8rhAKXHd
 o6T8qGYqDmA0+xzx2NGB8wxRtzvm+tw+GyY/y8UWjaWuzHI3ibYaKIcdlzbQlfLpa75axTngz0t
 IsshBekAOXUGnYGYzfFHXdvMcri4qPAwSLDPwwKrwwKy3cwMG8Kd13a+s3uk9GNQ83yPcy94VOK
 XA2eavZ8LcnDsQoE6AFOz9vR99eCMv5FJALsKPciweyB/WQFCXw2YWWw+4qW2lxolwsnORGKWFv
 p0jOe5O/oZhs2dL4J7iHezUJIdooMCnBew6OxIcFLifyyr0Dfqb0VQ//an3T+iwy4MobnCd+IFR
 RtmIV2QSBs8hNUKgiGA==
X-Proofpoint-GUID: 5bL-88o9RMcrFxPB-gDTBiHLmqXIi3oB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010064

On 9/24/26 1:33 PM, Gabor Juhos wrote:
> Hi Konrad,
> 
> 2026. 09. 23. 15:32 keltezéssel, Konrad Dybcio írta:
>> On 9/18/26 11:27 AM, Gabor Juhos wrote:
>>> On IPQ5018, the APCS core clock feeds the CPUs. It can use
>>> different clocks as its parent, but during system boot it
>>> utilizes GPLL0.

[...]

>> At a glance, we have the CPUs consuming
>> &apcs_glb APCS_ALIAS0_CORE_CLK
>>
>> which takes XO/GPLL0/A53PLL as parents.
>>
>> GPLL0 is a child of GPLL0_MAIN, so this should never be gated in
>> practice. devlink and probe deferrals should make sure you always
>> get a valid clock handle for the cpufreq driver..
> 
> Yes, the cpufreq driver gets a valid clock handle. However the hang happens
> early, when the 'apcs_alias0_core' clock is not registered yet. So CCF does not
> know that the clock (hence the CPU) is a consumer of GPLL0.

So is that the late_initcall kicking in early, disabling unused
clocks, or is there some other logic that ends up disabling the
GPLL?

Konrad
