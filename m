Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973624;
	b=c5LsFXUhnjsoWOSguzT1HN56Yg7osnmp4l03AeLxbQP3vZQh9etP4ToE0CDhzDcffMMa
	 gY0CaCuLdvA8evO7F0COxiFMTYf/nhHldckv6YldFm8fE8afGNUTidqoxMg/Qh93fLP7H
	 8vUxmf11XMWnfTZiLCUJ/3xQzboxeeE2l8J6hNNIXGaTvh3+9+p6IfH6GFM27qhRzMHQ3
	 tcHpdrSYK6rlcJ0n7mhExh07M9uZK+deejOfMspdzYWxJCE0YqKyOUFxdN/kKAek50A30
	 9Je9355YaZa+3JEfPuwaHrosNku2v6DuBz5B8Rh587zCQa0g1dcSteoisu8iNF/A/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2Ai7n3pDdwUbIiJ4tomxXG+jXZ3hpinNuCxepmbZ9d0=;
	b=zavAW8VqS4FKs1lWsJMEOi6FOVIPdDjxsvLUHgRSSMbojZjmVo6p9wecm2rzS4td3aL0
	 6G8Cb5k+js+soIZTJnaOFaWrkPVHnx/xReEk7kYmP1xNhZx5u22AiyeClVcD7m18Ru942
	 r4cxUCSs31iKwMSHjxV2TgmQA228dJppVAudUk1x69lby5EJjYwaLtWmyzsRdFvtilTk9
	 XaU4UbDhIrjicYsSCdF6PE+H7jPFxA7zAbwYK/V1l+tGVmq3atxVaA3cwrTHNyNNJgDv9
	 B0nWzgnvvTLdbqEIskktgzdbQA2E5EVIU4l+Fb6VwZyf/EKyffne66mIBOyQaf2xDjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H+SbPECN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ccCSGVBm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCD606EEA1
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FFCD606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H+SbPECN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ccCSGVBm
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoXda557992
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 14:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Ai7n3pDdwUbIiJ4tomxXG+jXZ3hpinNuCxepmbZ9d0=; b=H+SbPECNOpwmfu43
	GTubb2x9N6kbMqotjHZnl4cLrY8WKUYnEeaflSLieXh7wSJ4c8Cnc/VFJ3F/NOJN
	PIS3V9fI936Kz46FuzyHaiujnCHjQqCH0jPVb60PCiBp7jZtju0bIPneDmTiTo8S
	ESYICZjYkRAO83wefjkg6VYdIxc3rfRB4CnVntjKUYsTH+cm4+gOZvOczIBPie8r
	VQ8X5BPuIpKflANXdgsY4YZdNBzxGdM3f/uv49OcdRBhdP2v3xaPZtSbwhEBELIV
	BEfrSocUlwFgGrWgB0Be9yx1Lw0HydYABtQlgwgnQGp56b3ebMR23LCUvbxZSs3X
	rm6PDA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pau1gy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 14:00:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so711513b3a.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973621; x=1794578421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Ai7n3pDdwUbIiJ4tomxXG+jXZ3hpinNuCxepmbZ9d0=;
        b=ccCSGVBmUv6e094RJophlM8CaHnLwQvUHTrS1MmBfzkWN4D1jkuGiYdBf2DuE3YtjM
         yWZKM/k0FmZNjkp7kihTPzRoJlpSqz5bni/OTU6K9YMakT+5KuouPSiRoIIL+57lEi5J
         CXmqoxj2by4OdRWjpeIwMQybiaan1j1Zn02LuzvX+Q+/BXlXf/CbQpWTBvbz2UBpvT3y
         /4tCBiQ4D6MGdV0G9h3ObSeruSUtII1bZrUj3b/aHTQD0fubxEvATmPTzUVjVj+ADZ4N
         OOBZnNPi2yw1p91yXF2tjdJS6gNbK2BNSA2fT5NlLrKfSIpCiEXrjr5dpg5/1B33wwkZ
         GHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973621; x=1794578421;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ai7n3pDdwUbIiJ4tomxXG+jXZ3hpinNuCxepmbZ9d0=;
        b=vECQIDv+ZdCADCcOj+8jfmB8kD0M5JQw5z1uc5EZlA5ZnUGOqx0rEcY3AG8Sm+5xKD
         RwBi/xg5i8kP53lkyI4FV7CU0AXkmtdqdVQgKWQQTKdfgpzahlNH80ur7WATkmycmo2O
         TYLsQ7hepl10vBlRGIXZj5fR0Id8TfP5+sM8UssHEV4HHLZNLFmeSEoUUhKR4Bl03WgB
         c8njJ/Qv/uVjOCcmRGxOwBnPyzVqur/7cjfOls82agE5OF732Qn5VVcnp6JnRTSdFWWK
         t4Yk3u73TSI/6GvdoFYNkiTp+PEIwM/IZ57FfJUwuk6TTfxUIwxsA9j1UYMHlgaqUOZ2
         bm0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3lKR5IaM0LQpTwwxt4AjbumTzZgKSggG4uqaqHmo0YkSMKyQAKHErs8Z0th1gIs6WFXgqyPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W3Lv4JpcxLC4nUE69lcj/IwHD5Z9OhCtiDhAjGTomhQHJD5Dc
	TU7aaLOEX2mD2zold18Gj4Fe4pktr0wrYSaHveyKmEUsJtHlOWvcA3b13IW+IRNHwMPquzCVwnl
	XNiN43FumwFYqQlwbmp5m0whFNd7IAVD5CKYxRUGE+A+FA3Ad1ynJjXqRlgs=
X-Gm-Gg: AYBFou0yNRpgD7G+/cgK5n/sOwxf+Lysl0aM0gngozKHHJZP2vE6N7S71cdbs4hIU0S
	BmPPi9degi/4yaGbl5DRT1428ykDakQfm8xo/tAf4qYx6nCEy9mBhmgo8Rc8tqhfPua63EQ+8mR
	UarHXnWPZAegkx8CnQl+x+xC2NlHS7/k8nu0yhzsRvEwAo26yNWsAMme1IwViPYRt4IdCY/MKFF
	G44HFn5qOJ7eRY4Kix5nH5D7z3xsqrT0lUUH+wfcxu1pSt/4fAcYAqpMDzr9nxWdYC3cbJIvxUz
	wjCipXh6Cx+kpPzx+ShoYQv8EAsS6bz2wpMeowOOZmonsoySPiX2IZ+G5O3tULEGYsQCwUYaCPc
	wm+BaT9ykX8tfwP6OHt7TjoqJ06TsRf116YjP9TBSvBy0etBF2SpT6h1QXpFShZZAojuzcua1HX
	2kIMv7HvncqBg6GsePQ0fgGhhYZTWLyb7Po68rz4RjyiE=
X-Received: by 2002:a05:6a00:140b:b0:8a0:3336:4b45 with SMTP id d2e1a72fcca58-8b37aa9f637mr2578287b3a.12.1793973620882;
        Fri, 06 Nov 2026 06:00:20 -0800 (PST)
X-Received: by 2002:a05:6a00:140b:b0:8a0:3336:4b45 with SMTP id d2e1a72fcca58-8b37aa9f637mr2578235b3a.12.1793973620214;
        Fri, 06 Nov 2026 06:00:20 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35a4ad602sm613258b3a.49.2026.11.06.06.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:00:19 -0800 (PST)
Message-ID: <396aa96d-98f0-47fe-a4a7-b01376efd7ac@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 22:00:14 +0800
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
Subject: Re: [PATCH v2] cpufreq: Only cache resolved frequency in
 cpufreq_driver_resolve_freq()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, vincent.donnefort@arm.com,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0gkRC53e+==9xBZh=ZFTkgU5v=fwNCgJCRTdKoxcOFhng@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gkRC53e+==9xBZh=ZFTkgU5v=fwNCgJCRTdKoxcOFhng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX+AmndifkPGwl
 BzwLkHzTyaFSHeqs+oHYUlYaZIJtuqScw4maKFYMDsM26raE2TULACeDvkYVqN4VzX6ae3cgsvl
 V/q3T6JdV3FcKPgGI2SFudk8e5ld5SZ6P+1E1lezAWqzuitffpmbTjrfB0scnahdtnXKUjj8vBm
 wOWwpOLrBYbi4s9k41s3BP6w9ePsV29Mfq7lKCE09bihigYLQ/ykOGKWLWOStzU8dgL2MiLjgld
 PsxmcAEb1rb77+Jp8v3TF7P8hi10A6lZXWdxHA+QuVGjk2XDOavWyMOGBL8fu7+P0KlEi+/S3Ub
 l1oP1GxIyHjjelj4oRNKfvo6Zx567T5lAAdvNOZv9Z73dBsxCNoCU5r8bxYl9wEU3p1oiucHTFY
 fcN4bUX6xZoQ4PgGzwukUN39F47CYqGdhzZAlJoDcYcim2TYPmiF6s5Z2kjsjbyaUpYyfOqlNsi
 hrhtNCSA2gPaomPW6XA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX2d7lo8nVg9To
 5MkNqDl9Pm4ptCB8BOS+UKVtt1BBXyXlUqVgMHsUP6Q2S6pmjhIfrTUf1aJUHstZdfkzBYGnzu1
 2FyBjEDSwXj2FrSO5/qdeyQ9a9mhBPk=
X-Proofpoint-GUID: l8v8HEQYs8Jo3YtaPVUzAYEoCbF_zax7
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aeddd76 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KC6K3fDbvlfE3RyZnzgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: l8v8HEQYs8Jo3YtaPVUzAYEoCbF_zax7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060055

On 11/6/2026 1:07 AM, Rafael J. Wysocki (Intel) wrote:
> On Thu, Nov 5, 2026 at 3:04 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
>> policy->cached_resolved_idx so that "a subsequent fast_switch operation
>> can avoid repeating the same lookup", and made cpufreq_set_policy()
>> invalidate the cache instead of filling it. That is, the cached index is
>> only meant to be used by the frequency switch immediately following the
>> resolution that has produced it.
>>
>> However, two other places now access the cache without synchronizing
>> with its other users:
>>
>>   * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq()
>>     in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
>>     resolved index back from the cache before calling ->target_index().
>>     sugov_work() calls it without sg_policy->update_lock, so the scheduler
>>     path (a tick on the policy CPU or a remote update) can overwrite the
>>     index via cpufreq_driver_resolve_freq() meanwhile. This matters when
>>     sugov_hold_freq() discards the lower frequency resolved there, leaving
>>     the CPU below the frequency schedutil has kept for it.
>>
>>    CPU0 (sugov_work())                  CPU0 (tick interrupt)
>>    __cpufreq_driver_target(f_i)
>>      __resolve_freq()
>>        cached_resolved_idx = i
>>                                         sugov_update_single_freq()
>>                                           get_next_freq()
>>                                             cpufreq_driver_resolve_freq(f_k)
>>                                               cached_resolved_idx = k
>>      __target_index(cached_resolved_idx)
>>        ->target_index(policy, k)
>>
>>   * Since commit 151717690694 ("cpufreq: Make policy min/max hard
>>     requirements"), cpufreq_set_policy() updates the cache as a side effect
>>     of __resolve_freq(), which can race with governors switching frequencies
>>     without policy->rwsem (schedutil, ondemand, conservative), and a similar
>>     race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
>>     inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
>>     apple-soc-cpufreq ->fast_switch() read the cached index directly too.
>>
>>    CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
>>    __cpufreq_driver_target(f_i)
>>      __resolve_freq()
>>        cached_resolved_idx = i
>>                                         cpufreq_set_policy()
>>                                           __resolve_freq(min)
>>                                             cached_resolved_idx = j_min
>>      __target_index(cached_resolved_idx)
>>        ->target_index(policy, j_min)
>>
>> In both cases, schedutil does not call the driver again until its
>> selection changes, so the CPU can get stuck at a frequency it has not
>> selected. All drivers implementing ->target_index() are affected.
>>
>> The cache is only consumed by ->fast_switch() right after
>> cpufreq_driver_resolve_freq(), so only update it there and use a local
>> index in __cpufreq_driver_target().
>>
>> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
>> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
>> Cc: stable@vger.kernel.org # 5.14+
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>> ---
>> v1 -> v2:
>> - Initialize idx in __cpufreq_driver_target() to avoid a
>>    -Wmaybe-uninitialized warning with W=2, as reported by Sashiko.
>> - Link to V1: https://lore.kernel.org/all/20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com/
>>
>>   drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 54dde8419bdc..68009918e80a 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>>
>> +/*
>> + * Note that this does not update the cached frequency lookup in @policy,
>> + * because it may be running in parallel with a frequency switch carried out by
>> + * the governor that uses the cached index.  If @resolved_idx is not NULL, the
>> + * index of the resolved frequency in the frequency table is stored in the
>> + * location pointed to by it instead.
>> + */
>>   static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>                                     unsigned int target_freq,
>>                                     unsigned int min, unsigned int max,
>> -                                  unsigned int relation)
>> +                                  unsigned int relation, unsigned int *resolved_idx)
>>   {
>>          unsigned int idx;
>>
>> @@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>                  return target_freq;
>>
>>          idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>> -       policy->cached_resolved_idx = idx;
>> -       policy->cached_target_freq = target_freq;
>> +       if (resolved_idx)
>> +               *resolved_idx = idx;
>>          return policy->freq_table[idx].frequency;
>>   }
>>
>> @@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>>   {
>>          unsigned int min = READ_ONCE(policy->min);
>>          unsigned int max = READ_ONCE(policy->max);
>> +       unsigned int freq, idx;
>>
>>          /*
>>           * If this function runs in parallel with cpufreq_set_policy(), it may
>> @@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>>          if (unlikely(min > max))
>>                  min = max;
>>
>> -       return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
>> +       target_freq = clamp_val(target_freq, min, max);
>> +       freq = __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE,
>> +                             &idx);
>> +
>> +       /*
>> +        * Cache the lookup result for the subsequent ->fast_switch() call, which
>> +        * is the only user of it.
>> +        */
>> +       if (policy->freq_table) {
>> +               policy->cached_resolved_idx = idx;
>> +               policy->cached_target_freq = target_freq;
>> +       }
> 
> The extra clamping of target_freq above the __resolve_freq() call
> above is not nice.

Agreed, it was only there to get the clamped value for
cached_target_freq.

> 
> Also, all of this can be rearranged to avoid passing NULL pointers to
> __resolve_freq().

Right, splitting it into three levels (get_index_and_freq() for the
table lookup, resolve_freq() adding the clamping, and
cpufreq_driver_resolve_freq() as the only one updating the cache)
is much cleaner.

> 
> Moreover, if I'm not mistaken, the direct policy->cached_target_freq
> update in cpufreq_set_policy() needs to be moved to the point where
> the governor has been stopped or it will still be racing with fast
> switching.

You're right, I missed that one. Moving it after stopping the governor
also means the limits-only path no longer resets it, which looks fine
to me because schedutil always calls cpufreq_driver_resolve_freq()
right before fast switching anyway.

> 
> Overall, the attached (untested) patch is what I would do, so please
> let me know if it works for you (sorry for the attachment, but GMail
> isn't good at handling appended patches).

Yes, that looks good to me, thanks!
(If needed, I'd be happy to test it once I'm back from my business trip)

> 
>> +
>> +       return freq;
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>>
>> @@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>>                              unsigned int relation)
>>   {
>>          unsigned int old_target_freq = target_freq;
>> +       unsigned int idx = 0;
>>
>>          if (cpufreq_disabled())
>>                  return -ENODEV;
>>
>>          target_freq = __resolve_freq(policy, target_freq, policy->min,
>> -                                    policy->max, relation);
>> +                                    policy->max, relation, &idx);
>>
>>          pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
>>                  policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>> @@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>>          if (!cpufreq_driver->target_index)
>>                  return -EINVAL;
>>
>> -       return __target_index(policy, policy->cached_resolved_idx);
>> +       return __target_index(policy, idx);
>>   }
>>   EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>>
>> @@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>           * concurrently by cpufreq_driver_resolve_freq() during the update.
>>           */
>>          freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
>> -                             CPUFREQ_RELATION_H);
>> +                             CPUFREQ_RELATION_H, NULL);
>>          if (freq != policy->max) {
>>                  WRITE_ONCE(policy->max, freq);
>>                  policy->update_limits = true;
>>          }
>>
>>          freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
>> -                             CPUFREQ_RELATION_L);
>> +                             CPUFREQ_RELATION_L, NULL);
>>          freq = min(freq, policy->max);
>>          if (freq != policy->min) {
>>                  WRITE_ONCE(policy->min, freq);
>> --
>> 2.43.0
>>


-- 
Thx and BRs,
Zhongqiu Han
