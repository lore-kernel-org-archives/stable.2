Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5B442B3D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229341; cv=none; b=YTitny2NJamYi7DZyh0nS67FnorLKSCPaqcMIK6jEliGXB0/7UboJLeX12ZRzsS9I7fyPzaBGQlSV/qt8ijIiXJrBeRAxfoA1dVNESSrC0+X0P6GB1p+hMam5eMBV+1nKf23g/KFa5M4LRLljOx0x5OCFVMjvGXiuFNIeznoYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229341; c=relaxed/simple;
	bh=zLJG/f14PS8IWMmKFHbSudOFvttrq1FN6y5gEITIHpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUA8ve5tX23P/9u/Jsd2I8PXBR6S27/xW84rsBsnvrRwgZEBFfQNDjnaW1By0AkUKUia8AaNXg38raE/c2vP6GOdKMYaOlA1/giG6MblmKS3jnfExqeaLXYTDLobaA1R2CnWOgza8ajlto+Qta0V9SaCLdL/lUvtFnjHnXwxG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCOjQ2Yz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PA0Po746; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCOjQ2Yz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PA0Po746"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6eYVS2161122
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=; b=WCOjQ2Yz+ctme2+G
	930MCKEQixYauFh2behIj4WORi+WRFrD3VgbG1s99Kr2Pwb/PBdfapRnmaVz7gdm
	ZrL++AdweLK1nyEN26K6779di+4MSP/UI3+YYyXFsKPu4xj5VhFER/AkCmLhYu9L
	UteIYKBg1uaPrldwpi6HNrkkUo0ozmKui9U9NWI5IQj0qr2ja7aIBgt2zkbz+0xJ
	e9wi9+3PRSo8PLHwZtx0+MG9D3OxdHMMU+KmjbMYzwz3/qDNcUnF1g5FxyO7qKhb
	zCCOFv/O5H512wkqgknQuP0eWbVnlPjhmAZrulvz9OUZfLDz7CRs/nMdkkqS3qlS
	3qzz4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7s90v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:35:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84857446424so3863838b3a.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787229338; x=1787834138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=;
        b=PA0Po746V9ydMk1cYNPRnsAxf5UPB5dF7C1FPnC3d8xDPBSQXez9Utg9NaKpKWiHjk
         gkeTEk3SwGu1XvCgniEgtZ0k0r32Ju1NOL8TjSa98mMearhRkQAgkxyrr3zbSD3YU+vK
         ouyDbMzy+A21WvMYwBrorLi3BR+NBwVQylKqved/P/uT97UviiGjbPIj8N26i+l8Sg88
         M4yOypcod/gGBNvHP+jlo66azQfW6LmKV1r1TLgVmV6nNl0ktlgXtcuWcZL729JHHDhC
         WeIJ9VB7j7LCFZcbkTR0uNJ0D64fVqhcsiaIKtm6X5/Nu5zQrj9KsF+ZOQNOYJohr62W
         pCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229338; x=1787834138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=;
        b=gzoBDtPGsMllumnJJ9BWGbBgG4SIFa3GRCsiKHUzMBzjdYzKs5VzoHKZioUG7W/RzO
         lgSUTRgkM6/CG5/8UqJ8zb0rdPGvIeJvjgcyGUMx0XqzRCbayjJRUMr8lVVrKPo9DmXF
         v4eABf6QsUqpFoBx3uiYoRWaUftPzJ5bmBYSW2BAZCAamJ2Udpj9vu4TLP22VWZ3kBvA
         JgNWoKY5UfvdpSOfuqiBvaaS0PQyJklHVcCWRdGM4gpUsBbitpjZ1VJ+G5LPAApTveAo
         4YkjnOKho177FDNHpXwLxTL6Mf5UftIV8VQ3LXw5LbFK80afRSOT5prNXfc/NFBTBhdk
         EbUg==
X-Forwarded-Encrypted: i=1; AHgh+RrgZQBZpBr9MK0Fi9AJgnqXv99APk1GwoRKlAQ7NLIIAD+Mt/c4PycDRqf6TwuPbTDlr1WQdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCT+g9pq8SVopnZnGAcDHX42JUMTcccL5TlZHEm/7BKSJhU609
	ZAX16i6NyTGmAe7u/RWDr7Lgjxi/sD5jDHvKIxW1ZxQTYcVvHavgQaaQ49dxb4DjXJWQMdd8g11
	zfcE5Qd8AfbFXy2shif12BnqzOVx3+BLbnxYMzvc2/xeTm5gbpwaK+VT0cED+S3BlNydN+Q==
X-Gm-Gg: AR+sD10xkVtd6G8LiYcTkJRHvyozBjFGf3OmMWaEWxa8tWh+yv2ZR8kHeGj+RUii4Oa
	T95HrSW2m8SGG0oarC6Q7Td3zX0uL5dbCmuxwBufCN5r3lZSA3QO9psqKoDL42ECHHh9wwiVYGq
	jh38AoqRk3iWPgq9jXw2NWfqoWAaqvslmD/uE2CwOQkryTnp2BTjxMbNOdbjdaicMgJZX85VV5o
	OVAFL1hNY++mWSATOOeF/IEQixkqjpU/r1/NIrNumVkfPU8nRD5B2w3jiBymSPFb038eg3JdJIc
	pHbiqqnyhRUrRAa2n4uJA2P8NZnSOH0zmgzOskjTivpiqJ5IuNBlW291pkUzF+FBQVUcRf3eOXa
	5jeBolgzhyDrDc6AmGyAFsML0umCFT0JEfl5THTFVnJSyOR0tfmvbVzFTamotsyZY2FAYp8Aa
X-Received: by 2002:a05:6a00:4c11:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-851d348dd44mr21853600b3a.0.1787229337929;
        Thu, 20 Aug 2026 05:35:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c11:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-851d348dd44mr21853463b3a.0.1787229337347;
        Thu, 20 Aug 2026 05:35:37 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1556753b7sm1768171a12.16.2026.08.20.05.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 05:35:36 -0700 (PDT)
Message-ID: <49b8a931-f814-45c1-97f4-cbb825dec700@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:35:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with
 per-node
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        Hongliang Wang <wanghongliang@loongson.cn>,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-4-chenhuacai@loongson.cn>
 <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfX47JtkxFA6Bbb
 fZWlGzSPJKk6OF+3jCg2yECu56KoTA4XXvEvmNxASWg6V0VVUBT6aBtQGXS1RSBWlCv6xPFLPFu
 Hh/4w0lK2d5k1op83H89BTESqL0a0w9WmhK7WiCq9IBkyIyvSkL9l01t31j4ThwNhHkLRHLAhlm
 1oIQ+JS8y/uey52Bh14v0GtUN+ITrNaySkJEDnr1KZHPUURCAEakQ/GS6QVhcQt+fIXSuGAJ1+m
 ecaLUsjzaFmmlDarWJAnftYIB13r55bfdACNpwhDo2LkJTESeTK2kFObnfQUzQ2c8EBVDiRJkKk
 uRfvgAVU6bHntlRjOyGI+NeHcWZmjPzK6eXArEd4fZlz7vPQYrrFOB4D13tkWOXog1ytGOgBCQH
 JMAX8OaS6QZV3Odo+nm1O6q8YfrSowElKhUdF+xvEmNp8v4/h4LV/6CXuO/qJuBxzJqb09jHEyP
 suvJ79uZpliLrnRcGrA==
X-Proofpoint-ORIG-GUID: jq27nIFoCopAhaG9yJKycQgwtOgKp6Xh
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86f49a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=LayQR5MyJkDDx0UqswYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfX9KeKRB6Prgb7
 1HxRLdv7Op24CJsXiwqX12jo6mo+3ZIiHLvCWJd10pcWhWSRbMktPUDieU8+wKF1oseiPnEpRv0
 a4+YQzFxTYZ9M6Uo7MpycvrVLbvxYec=
X-Proofpoint-GUID: jq27nIFoCopAhaG9yJKycQgwtOgKp6Xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200093

On 8/20/2026 7:34 PM, Zhongqiu Han wrote:
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
>> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
>> nodes in one package and SMC mailboxes are also per-node. So replace the
>> per-package mutex with per-node one.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/ 
>> loongson3_cpufreq.c
>> index 630f679aa739..e3cd78a5ab18 100644
>> --- a/drivers/cpufreq/loongson3_cpufreq.c
>> +++ b/drivers/cpufreq/loongson3_cpufreq.c
>> @@ -169,7 +169,7 @@ struct loongson3_freq_data {
>>       struct cpufreq_frequency_table table[];
>>   };
>> -static struct mutex cpufreq_mutex[MAX_PACKAGES];
>> +static struct mutex cpufreq_mutex[MAX_NUMNODES];
>>   static struct cpufreq_driver loongson3_cpufreq_driver;
>>   static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>> @@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 
>> info, u32 cmd, u32 val, u32 ext
>>   {
>>       int retries;
>>       unsigned int cpu = raw_smp_processor_id();
>> -    unsigned int package = cpu_data[cpu].package;
>> +    unsigned int nid = cpu_to_node(cpu);

What if NUMA is disabled?

>>       union smc_message msg, last;
>> -    mutex_lock(&cpufreq_mutex[package]);
>> +    mutex_lock(&cpufreq_mutex[nid]);
>>       last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
>>       if (!last.complete) {
>> -        mutex_unlock(&cpufreq_mutex[package]);
>> +        mutex_unlock(&cpufreq_mutex[nid]);
>>           return -EPERM;
>>       }
>> @@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 
>> info, u32 cmd, u32 val, u32 ext
>>       }
>>       if (!msg.complete || msg.cmd != CMD_OK) {
>> -        mutex_unlock(&cpufreq_mutex[package]);
>> +        mutex_unlock(&cpufreq_mutex[nid]);
>>           return -EPERM;
>>       }
>> -    mutex_unlock(&cpufreq_mutex[package]);
>> +    mutex_unlock(&cpufreq_mutex[nid]);
> 
> An optimization independent of this patch: considering to use
> guard(mutex)(xxx.lock)
> 
>>       return msg.val;
>>   }
>> @@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct 
>> platform_device *pdev)
>>   {
>>       int i, ret;
>> -    for (i = 0; i < MAX_PACKAGES; i++) {
>> +    for (i = 0; i < MAX_NUMNODES; i++) {
>>           ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>>           if (ret)
>>               return ret;
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
