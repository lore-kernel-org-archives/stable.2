Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886181;
	b=sUEc6M7gYyoAkf9Q1aCnSelKamZuhAMctMGi60EAnZnBZbe1B0Z3qlZd6hOOGp97W47u
	 pzYRfE5RLYWwKO7bYWCH3dBBP45HcDVSPdQkvR8I9W4UaJxztPnYoA7B2IhSeg0RxwcjN
	 Bg+OwsMGbjDFzwEShH/f9UDLD2AqNU3Sqhgd1bUuqQQ7Hv09ICC5n4oIjADaf+5Gr3tqU
	 +27aNEZhNUId+SxTDXT5PS8ExSrotXv8h14M2ZqVMp0ngXsS6spFXrNkyOm+h608giF+z
	 cF16LYrq27H1ReHLQS1fQ0E6uYNvYCUvCIyzli8eDqCpoBIXfgJx4AUM9l+jX3DSbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886181;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nWevZ3ThDWlydByTI5fxg16Hkk6bEjEPehkf0fOtV6A=;
	b=g05Rby/kbcdPao0DTVSMHgYQuylOhu+4+q4dWQ+IvQ4jDqjElA5NafIf+6Ifc8lypypR
	 6E2UlTsBbqGdvnp9FEivKreH60qWF8gWkEBXJBcfb36BR53oog6+VuWqUoYjOoVfk+dzS
	 eJiqzdVctto7AZQRCEj1jphHru+GJrAD9s6AJbn4OsB8bniPj5IumZB3uWV9J5PHaU7af
	 3uGj7eGRRWPHgrT7obn3uC1PQUzQMFlxUNgSfMgmVlCsPilIU9BY3ItKsEqnQN8dTvgXg
	 ticoss/uvQncYGNZ7E/040NdmQ+NzId0apR8qV5d8MSE3txhOXFJXrJ3kWGoGLd8kzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HOsuc8sX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fEEV3bJm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25771606A338
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25771606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HOsuc8sX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fEEV3bJm
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tQeA406602
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nWevZ3ThDWlydByTI5fxg16Hkk6bEjEPehkf0fOtV6A=; b=HOsuc8sXS1m9C9HM
	16ZuIwGkMx+n+33zDbXpYL44rLxtyqfsepeAo1ucrEfM+UKi9Yz8kyIIQBE4wXJT
	WSIdOSqlVBeS8jk/YOdBLT7lXsZMzhtmdUU261HvbmqEAkW8l6a83L3lwSLMAtdU
	aB1CBIkgL6KPsmtYtV0Cf6oGmJr4CXnqDyQIkZYoEq08ftVDhGrUEhQagg9WnzFR
	sl88aG0e4vEhMWfLHz9l3HsWl3/4gSu17wQLAxWd6Yn3mYmxmeS7wpwYMfsO526k
	LU1fKdHfOp5WvkTJhuu1/+yMPD6x+HCy03Bq47MbYBA8HxNjOM90X/k2/MnOnX98
	rSz8cQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v1u73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:43:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf3f829b3so17196985ad.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793886180; x=1794490980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nWevZ3ThDWlydByTI5fxg16Hkk6bEjEPehkf0fOtV6A=;
        b=fEEV3bJmACcXMBro7dYIpK6JTsJv5URcg9VpK2LQXffVprgmDmSPE1wWtrv2kuputm
         FM/P39ub5OEKHBZv4eNERREU8EdbuFlF8XuJYzXSQdMJlS37aJeoDDnd3niMckfzyDT0
         OKdk45V//howp+xqXMYrWnSL0lbqd/L6Fe4GMdYAG6qnKyGISRbVJPk7HxJeVxQWGK72
         eYr1X2fSGKs6iDByZ2cFz3KU75cqb2sSsKPql67eGYwMhFndo7/iTikTmRBUi/HAneSS
         4MSMNkLbaz0Ba58/ZP5190aHXuyKQQH4J+RFb1p4pdtrjkI4GmBWY1OKfMl64iW7EJjB
         hTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886180; x=1794490980;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWevZ3ThDWlydByTI5fxg16Hkk6bEjEPehkf0fOtV6A=;
        b=MqZ0XCHcmCA/4i1A9cKhlr9cE+2mDIrGocjguIecwiJ1ntv3DnxhQqqqBcV13N8ffi
         ffs5z7DVNu2J7WAgUaI1BNR8JytHg6bzWUOQeEmmOKAUU0SPxRs+pgMozs9fjodj1Ipo
         f9kBUPS8naTbj2hBCOZGSyjLX4X662tWGwQDQgskx8ZcOBe9S7IB87bI9ZHKNS8+ufEd
         QzyFO/7z+Zs+SlTL7x7TrQezlklK9mw1UpO1Sxs43qdDzVBIGrkfUoMvX1XL6OiZPSra
         Oizr4+Grq+NUuTlboo0U1YafT889mKcJUIx/O2TGOXQwh/vjGFh4WHcJj7rHc4DLH/aK
         v0KA==
X-Gm-Message-State: APuU4Z8zK/BwGQcrKqmTIwRZi1BGs0L/w92V4eZMpCKeZPOuwLAW4lwj
	lN4H0E8k36y2Zphi0esLrlCybZrDxtphMQgrweWcwLsdgDhNUqicAqGYtjF8UI68gHce1dGpC1o
	hGR42dzxalHXycoC49dZxPDO/Vdn3FpJ6fYdqrZISLauGmNn1WWYZqhJRXKb7EQxYsUk=
X-Gm-Gg: AYBFou0AmSzj7LCDRaOIdXj6gqiSsy2XZI1NGuGPicuYGcunZweyuM7uML2tb3wxy/x
	jWi3f2tVClsaoDAU68JFqCmWuQhMUFqtDfXLEqQijgr9TwOxUg073356RPooyVceqwV+t+BRD3v
	GTrW0ydBah7NUH36kZwvAurQsGkeK1+qzCidvU3wqE3IM1G7kd7D44e1c8N+AyW63eZZJD+QJ2C
	F3o2Rjs4pGkbrIoUrsX0I50T4kvWr3HdvbARqhXk1D5GH+cnn6DWrGGfFJv+BfU7Ch0/lIPgWjs
	g2i283+uN/NTsaLRWbF3pAB20s8BWLNuw9kLqiulyHVqxDd0naZSMz44FOfWx4fbf2rGiUK0fze
	4656zTfnK2mVgKVvTsFJyP96wb5x+AXoVDHRaYoy7lVUPh1C3FJMDl/4JJddGacQfgxruNy0lVC
	dwlFR9yt7t4iEHAqGOP4dj8G4KC+VR0atGDl1V5koKk6/s
X-Received: by 2002:a17:903:1b50:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2eb3644f6b4mr165471885ad.36.1793886179543;
        Thu, 05 Nov 2026 05:42:59 -0800 (PST)
X-Received: by 2002:a17:903:1b50:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2eb3644f6b4mr165471615ad.36.1793886179002;
        Thu, 05 Nov 2026 05:42:59 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0906cad4sm17274025ad.33.2026.11.05.05.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:42:58 -0800 (PST)
Message-ID: <73c2eadb-aedc-45d6-b684-985a92f1cfea@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 21:42:55 +0800
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
Subject: Re: [PATCH] cpufreq: Only cache resolved frequency in
 cpufreq_driver_resolve_freq()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261105133821.1251727-1-zhongqiu.han@oss.qualcomm.com>
Content-Language: en-US
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261105133821.1251727-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXzZhjHYoIuhiM
 YBZCCSUAqFmsOTH7mirIghHq7c+I22oKBp6qoE+esTKi8AjxK9mrXGtqyz2Oi9AdpwdZ8jl5a6M
 gxlzCqKUjr/MHyyNKr6w9e59rO2Cl1U=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec87e4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kzXjIm4Bm6OydN1sEU0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX9roY1pz9sdLv
 ByutgvynnjHsDXHVcfAtLIWu7XcTLotrx3Pm7oD97lhiBtM5jvfFTqpwFrvpjsxY5NaDQKrXuxd
 ihteP6wqa+Xx+uvJJkqlYnAQ7lcecTgrHR766PaiQQzMp3GEPch+jr80N6TPYgTpjZPKjurZvDx
 0OxTl0kdVRc0RHzSnmYN8PTu/nLAygQBGXJ5roq7dp2U1MHGtr8HIPquwvy4p9zf6Askzgfwyde
 j2EBsxl+JMVD4YZ/lbThmX52Z0MVsyc5TdrDU/hpbz5vnMJQIQpxTHJ05Lx6O8k3X3vB/kSvg5+
 PjN8pKd64U76tWqbsHsu/t80pZr0E6JLMJv/bQjWss2abwf/18LPKJ5LpGiMkwnBiwdRVoUOWwN
 COAdAltABaSK16h6sVm1uuXa0OxKLesdXe9DlK6Yos37KNemmG56UW78Da7w3ICtNq623ZthjON
 mf+icWuYBTIMFFAE7ig==
X-Proofpoint-GUID: CkpP0oquMDvQQidY2wkPyoRJVGVUZbn5
X-Proofpoint-ORIG-GUID: CkpP0oquMDvQQidY2wkPyoRJVGVUZbn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050054


Hi Stable Team,

I am so sorry to send the noise by mistake, please ignore.



On 11/5/2026 9:38 PM, Zhongqiu Han wrote:
> Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
> policy->cached_resolved_idx so that "a subsequent fast_switch operation
> can avoid repeating the same lookup", and made cpufreq_set_policy()
> invalidate the cache instead of filling it. That is, the cached index is
> only meant to be used by the frequency switch immediately following the
> resolution that has produced it.
> 
> However, two other places now access the cache without synchronizing
> with its other users:
> 
>   * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq()
>     in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
>     resolved index back from the cache before calling ->target_index().
>     sugov_work() calls it without sg_policy->update_lock, so the scheduler
>     path (a tick on the policy CPU or a remote update) can overwrite the
>     index via cpufreq_driver_resolve_freq() meanwhile. This matters when
>     sugov_hold_freq() discards the lower frequency resolved there, leaving
>     the CPU below the frequency schedutil has kept for it.
> 
>    CPU0 (sugov_work())                  CPU0 (tick interrupt)
>    __cpufreq_driver_target(f_i)
>      __resolve_freq()
>        cached_resolved_idx = i
>                                         sugov_update_single_freq()
>                                           get_next_freq()
>                                             cpufreq_driver_resolve_freq(f_k)
>                                               cached_resolved_idx = k
>      __target_index(cached_resolved_idx)
>        ->target_index(policy, k)
> 
>   * Since commit 151717690694 ("cpufreq: Make policy min/max hard
>     requirements"), cpufreq_set_policy() updates the cache as a side effect
>     of __resolve_freq(), which can race with governors switching frequencies
>     without policy->rwsem (schedutil, ondemand, conservative), and a similar
>     race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
>     inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
>     apple-soc-cpufreq ->fast_switch() read the cached index directly too.
> 
>    CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
>    __cpufreq_driver_target(f_i)
>      __resolve_freq()
>        cached_resolved_idx = i
>                                         cpufreq_set_policy()
>                                           __resolve_freq(min)
>                                             cached_resolved_idx = j_min
>      __target_index(cached_resolved_idx)
>        ->target_index(policy, j_min)
> 
> In both cases, schedutil does not call the driver again until its
> selection changes, so the CPU can get stuck at a frequency it has not
> selected. All drivers implementing ->target_index() are affected.
> 
> The cache is only consumed by ->fast_switch() right after
> cpufreq_driver_resolve_freq(), so only update it there and use a local
> index in __cpufreq_driver_target().
> 
> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>   drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..68009918e80a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>   
> +/*
> + * Note that this does not update the cached frequency lookup in @policy,
> + * because it may be running in parallel with a frequency switch carried out by
> + * the governor that uses the cached index.  If @resolved_idx is not NULL, the
> + * index of the resolved frequency in the frequency table is stored in the
> + * location pointed to by it instead.
> + */
>   static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>   				   unsigned int target_freq,
>   				   unsigned int min, unsigned int max,
> -				   unsigned int relation)
> +				   unsigned int relation, unsigned int *resolved_idx)
>   {
>   	unsigned int idx;
>   
> @@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>   		return target_freq;
>   
>   	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
> -	policy->cached_resolved_idx = idx;
> -	policy->cached_target_freq = target_freq;
> +	if (resolved_idx)
> +		*resolved_idx = idx;
>   	return policy->freq_table[idx].frequency;
>   }
>   
> @@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>   {
>   	unsigned int min = READ_ONCE(policy->min);
>   	unsigned int max = READ_ONCE(policy->max);
> +	unsigned int freq, idx;
>   
>   	/*
>   	 * If this function runs in parallel with cpufreq_set_policy(), it may
> @@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>   	if (unlikely(min > max))
>   		min = max;
>   
> -	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
> +	target_freq = clamp_val(target_freq, min, max);
> +	freq = __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE,
> +			      &idx);
> +
> +	/*
> +	 * Cache the lookup result for the subsequent ->fast_switch() call, which
> +	 * is the only user of it.
> +	 */
> +	if (policy->freq_table) {
> +		policy->cached_resolved_idx = idx;
> +		policy->cached_target_freq = target_freq;
> +	}
> +
> +	return freq;
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>   
> @@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   			    unsigned int relation)
>   {
>   	unsigned int old_target_freq = target_freq;
> +	unsigned int idx = 0;
>   
>   	if (cpufreq_disabled())
>   		return -ENODEV;
>   
>   	target_freq = __resolve_freq(policy, target_freq, policy->min,
> -				     policy->max, relation);
> +				     policy->max, relation, &idx);
>   
>   	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
>   		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
> @@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   	if (!cpufreq_driver->target_index)
>   		return -EINVAL;
>   
> -	return __target_index(policy, policy->cached_resolved_idx);
> +	return __target_index(policy, idx);
>   }
>   EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>   
> @@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>   	 */
>   	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
> -			      CPUFREQ_RELATION_H);
> +			      CPUFREQ_RELATION_H, NULL);
>   	if (freq != policy->max) {
>   		WRITE_ONCE(policy->max, freq);
>   		policy->update_limits = true;
>   	}
>   
>   	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
> -			      CPUFREQ_RELATION_L);
> +			      CPUFREQ_RELATION_L, NULL);
>   	freq = min(freq, policy->max);
>   	if (freq != policy->min) {
>   		WRITE_ONCE(policy->min, freq);


-- 
Thx and BRs,
Zhongqiu Han
