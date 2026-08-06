Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC93D88EC
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997083; cv=none; b=H4ZM7l1PDnc3kh8tZ8KeVEO4JGnFfIox3sf1WQhNJk8KcMxcaF1TRAjn2QJK2kgAT8vzGRAC1mm+1wUs7HD8Zn+0Ff6N7mHDdHcXjbcQ/9TrY18ZFRxSPvVhcsfMEKuzVlwt/ia+BZkLa8N5t3s8Qd6UnmDgwEH4ZH0MPXXHrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997083; c=relaxed/simple;
	bh=WOuEJhvl2qrZtKj8atfAzb7IYB3fO5C9klrW+kllfPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PavQ2xKiHxvc0vuMC4ZiCtcMfOSEgxGFCnYbFUHmY8fPQfuNWnR9XoEzjNk8PM3de3r5VAMz3i7LRuEMx2C7mDQtjBxEnj3NL4FFuZQhWatpYUZ4gZV4zGuteqhcNKKJIj0awu1se6APx6pNsRrUj6IErnEWxtKyiRl3aWyEo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJdBvNuj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UmicLcDL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJdBvNuj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmicLcDL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NataW731377
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 06:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=; b=ZJdBvNujW1YPC9SP
	TeNgu5issziDmsY+bgXEto/Xd/gOoKEj3Q0T8IFTF9Xq5fi/2khpomO78t56wTaS
	jfDh2GmJ50iSQS3U1EooboYEUL/XR2wv0grPCXUYWE5MKuH2GKQsIVMmEZDhtR+t
	fyS5VO8Iepm1gl+Qkl0UcMEOZ3DoPySsWTOmlDm0cehJmw+rmNHtSpwSQbTrHYEe
	tAGL2w8ypOYwzNLFjoS1chFUKWUTx3PtwWnsaK6VsbTy05rYmxCDaWxdVyVjKr7I
	dWySKX93xR/7yxaWhBofRyyuUeCJYsFoaFjbQkXq/a2yedIJhC6T9dJeBe1WMWbK
	1/Skvw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk3wvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:18:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e04598adeso1602018b3a.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785997080; x=1786601880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=;
        b=UmicLcDLIZ4bbrNujKbNfHyushpkT6pa5xFv27xkIzbYR2w3AYX3xq/xQjj/Kb49d7
         /rslK2BWvRtQOkbcYLsL71RtspdaETXn2C5yPz74tN+vRcjgf4/gvj4FbEqkfTvtLoBt
         SU5Xy/hs/NV9Q0WPgTdv+VRdvRtaTVsSbizyn+T5B50BZ/EC3EHodohy0QScvO0FfujA
         0g69AL+HObGHzgWRmIjo8OZa3kCubu2d4Wh2757YyBhvHxE5GCpe4mn62mEqBpr7Tnjx
         oAl+Smpfw/2ObR4nm8HI7g7CepPzqGy3994EGfQG+UTD4Cy3vQN8FkpqA4i/HQIHD/he
         XUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997080; x=1786601880;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=;
        b=mazBskG5R0o6s4m3bkHhNDJrZl143n61DA8rLUr+7qzAQqvFSjfB2O5tLToXHzRMpP
         H5/mz9h2Us9WolMx4olUCtf5EZv2w75zkBFpXtTtDmrUpW+UzA2DTGjVH8b2C34xtQdG
         B5ascEh2N6E/F5mbAR5aA99i8vP2ODarNfy3//lvG38AmI7E4aDvWUbbR2RoUaWi/u5j
         FuCWvAmyF7dKFanPK+VvBgAKUCmwUjsuRHCwwMDJPnfUUOq+LwQ+vhY37CWETW9OUvjN
         exSh8UEFClV9AWmQEVe85olffQnr1RtdWp2p3wRZ9OZf1BmQoqEOPw9MMAbNMzefC1yP
         f+nA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1MedhP7YvFjNAU69pYJfJ4AkdYtdvQdkSKWpv7s2TJmv4tMGQzH8YeQqjb8irqoyc7CWLW1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSSj537SzSgW2UyoAM+FdeWUvvYGrPwx8gw/RIZfXphuAQtl4
	IPiA9wGk/qxEBP3vYFcQ1IGsR7y73YTpz/ezYd0FEDBdionu/ghe4e1iQXvcZ2CDQaC4DUqpZBV
	QtIoolTrNMu1edgWbAhhZjXWiZXWkq3UTvSsv/NtDhKefGn/CNiw5yfc/6Zk=
X-Gm-Gg: AR+sD11umRSYHYhSuHjxJ+v/ze358nQpS9RgAddVcKhY3Qp6ARM4K3VtShGFieNQNvb
	CxQcdfPpWws9jnSkILXrTCFkZDwb+X0dreewZjcEmZMHGJG5rUg+5KQbp02EmRyIUMt6zoIKGTj
	7NolQSsO7H+K09w9DWs1XIZUn70e0ETS5Om/TBEvbtWw28xq3WLh+1JSInvciSw8Y2I4BGYds3S
	Y92rOGmNleiNQyB8+KUIbZ1weyU4pXzx5c0knZi2gea647opNlv49mwN3RNoxIHqtpx5KEup1jK
	mkUEClIv+n7Y/Vbe82r42X70ReOr0E9EZbv8hhR8t2QSfh3x+hUQGDi6CKzy/nY7znyg7qkkjul
	I/qM2xbxXKk12VEoRVlSDnzQyEL39LWPVsHvLs0Xr02SXdb+HLF+n55/AW5OHWozNsAE1b6An
X-Received: by 2002:a05:6a00:12d0:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84f2e006b31mr12828623b3a.19.1785997080013;
        Wed, 05 Aug 2026 23:18:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d0:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84f2e006b31mr12828302b3a.19.1785997074774;
        Wed, 05 Aug 2026 23:17:54 -0700 (PDT)
Received: from [10.133.33.183] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b2688sm664295b3a.22.2026.08.05.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 23:17:54 -0700 (PDT)
Message-ID: <4606a5b1-dc38-4af0-8244-0b84d5bc4322@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 14:17:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Fix rate limit overflow
To: Hui Su <sh_def@163.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260805143942.805176-1-sh_def@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260805143942.805176-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5dR11aU_FzNm90HpWuMtDc1HbQ8tB_v_
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a742718 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=baNAD00l4KdnJNx0rl8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA0NiBTYWx0ZWRfXwO3vJGfPE0UC
 UrJWi8819g06u08S8iESUB4gBFtYzN9ccRcf6TwSlMXTZOPfO5e7M0I61Ry2d8I2IItE9cE9+US
 8Vks24qU9xYdKRVjDnK7/AVBHM0w/pH9TI3bf9xmKHaycFg7/ThWusSjWv6M5CooxO5wR+pQdS9
 dAHXDHbYhLIiCVODUbXS4Q8nAMpgKTNcBe1lsva4mKQpz4IM37HjUBvHDMJPLASdtfEZ4ob/q6q
 tJC4Mhgbvgw+0al6NGMPJDY47gSR8/cz2yPpSzWVUqmEb6W62tKs3/kVKT85RO1bL7nnuBRNJlu
 5OkFJlO4qYr1uzaf1LWgUK0WL5ee6HDn+HE+DGgywbn2BIz5vCMfwI42SyJMGOc+ellS/XW4m8l
 2WAM/nG2MK+ThXBEbZ5Htgf/2+Zy2uY3jfEifTgyVOtamfK25YuM5DqJXEInIIptxMXiPublw9F
 l/lvY2zIFaczl4WK8tA==
X-Proofpoint-GUID: 5dR11aU_FzNm90HpWuMtDc1HbQ8tB_v_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA0NiBTYWx0ZWRfX6kyYlx61tj/K
 DvGr4xlAYpHHi5YYEnGAhr0pkJ7JQNo/fNL2bxVjguU+J6P1diu1Vip2uErrU0CNiTeHTQ6WeYs
 fEO1eNZTXOKdEEy5xt/P9Unq7QcM+Cw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060046

On 8/5/2026 10:39 PM, Hui Su wrote:
> rate_limit_us is unsigned int. On 32-bit systems, multiplying it by
> NSEC_PER_USEC is therefore carried out in 32-bit arithmetic before

The real issue is that NSEC_PER_USEC is a long, which is only 32 bits on
32-bit systems. By contrast, unsigned int is 32 bits on both 32-bit and
64-bit platforms.

> the result is assigned to freq_update_delay_ns.
> 
> For example, writing 4294968 to rate_limit_us wraps the delay from
> 4294968000 ns to 704 ns. This makes schedutil update far more often
> than configured.
> 
> Add sugov_update_rate_limit_us() to widen the value to u64 before
> converting units. Use it when updating the tunable through sysfs and
> when starting the governor, so both paths set the same valid delay.
> 
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
> Signed-off-by: Hui Su <sh_def@163.com>
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index dff4ee04694c2b90301ed0fa158a509a3423cee1..8bf7a2c34b9f200d8f5776205ea2a7f495e04e69 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>   
>   /************************ Governor internals ***********************/
>   
> +static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
> +{
> +	sg_policy->freq_update_delay_ns =
> +		(u64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;

Small nit: better to use (s64) to match the type of
freq_update_delay_ns.

Besides, sashiko report one torn read issue,
https://sashiko.dev/#/patchset/20260805143942.805176-1-sh_def%40163.com

On 32-bit systems, the torn-read mechanism itself is pre-existing and
not introduced by this patch. However, this patch does change
its impact: the main difference is that, prior to this patch, the upper
32 bits were effectively always zero. After this change, a previously
written large value(In practice, configuring rate_limit_us to a
very large value, especially one exceeding 4,294,968 us (about 4.29
seconds), is neither reasonable nor common.) may leave non zero upper 32
bits, allowing sugov_should_update_freq() to theoretically observe a
mixed value (old upper 32 bits + new lower 32 bits) and temporarily
treat freq_update_delay_ns as much larger than intended. This could
cause one frequency update to be skipped, but since
cpufreq_update_util() runs in a hot path, the next invocation would be
expected to observe the correct value. Using atomic64 or a lock on this
hot path would be more costly than it's worth. Based on that, I think we
can keep this torn read as is. Please correct me if anyone disagrees.

With the commit log updated,

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> +}
> +
>   static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>   {
>   	s64 delta_ns;
> @@ -606,7 +612,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>   	tunables->rate_limit_us = rate_limit_us;
>   
>   	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
> -		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
> +		sugov_update_rate_limit_us(sg_policy);
>   
>   	return count;
>   }
> @@ -848,7 +854,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>   	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
>   	unsigned int cpu;
>   
> -	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
> +	sugov_update_rate_limit_us(sg_policy);
>   	sg_policy->last_freq_update_time	= 0;
>   	sg_policy->next_freq			= 0;
>   	sg_policy->work_in_progress		= false;


-- 
Thx and BRs,
Zhongqiu Han
