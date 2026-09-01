Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179923AB498
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268065; cv=none; b=E4ZD4KUrsqb6ZrYQ7Xwya737szRLzBwsk0E/CAPJCeF72awyJOrMS+UePzZGOUC2T3gi4zR4Gdah5dGYN/7dTolbSf+mIhmsy76LgVMplXAJ/nzi2uhZWaji4FfkTWCKOkZiHbb+c91hrp4eb4OWq5V5jUfqG/2b0HiiBBdrUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268065; c=relaxed/simple;
	bh=ACq8O6kTrFDyWuzB9wUnBK2bCVmEEPua6raZFlQp/mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn8B+7eSibV1TX1nxhlred0Do+XrD5GYJ5Bgiar3ZNVulBVUOrGCpoJFd41PX+mVwP+02LDIctz0p0VIlHb4HHAsVsuMbJKDCZx5L8ToqRrQDgmK/bgQy1blbX2vJ1+NZTvP4OWku9Ydz8onlfvmaO+243ZvaAGOH040KdmYo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PW5BiVvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4NKclyy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PW5BiVvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4NKclyy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJdHs1713071
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 13:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=; b=PW5BiVvApoKbw9DK
	6y42INfOHSiEO8MVV8KcajnkDGwMGKy26Jufms5NF6j6VyWxpEmR8PAY6Fk4sO0i
	9ENz5JuYYIR9XMvFXbzSHyUyJj+JYH+tpraWuO9No2lmpA2dh+XwqwjJcyHpYjjU
	HcjTMLgdC7ynLTzeqavkj4Mn0cLhNCMc48zUFPNW/ng/Tg7t9o/BWXWAYzboYjD1
	oKN53pjUCKz9FhXITLa3lLD8C/1hKsJ7URnw2n0XgkDTR6SBT0+iSkGi1AFVTSpZ
	IQso4AHA3qMNb44hJfw5YrhK8deC+SpeEUlfxZQwqXpB7UEXb6GTKlktjjDHYZup
	N3uOwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxan8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:07:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso6743677a91.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788268062; x=1788872862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=;
        b=N4NKclyycAy4ULLvlJORdnoMTb0xIRs7B4II/pRb4usBtZbOg9P3EsoDj2nB+yL3ik
         +3+f2TX1ZvlDEuGwagseFZqf62sfnXgzrGWhOfo7KWBUuQvPb/KcSKBEdXaJWR/3OBI6
         fE73FwqEkwwr/jAoXYwP03eIv2kHVduGmWsGKjl+Zkeh89sY6QdXNffLoZYQhZ47fsrs
         7UEvBt9QVfIyb7D2aDSs22C5cSsBwPI7fzeEm/gtoFIxpVUxtToMr4Z7seaM4zQhE8if
         eybzU4I3P+kk4cjYt4zeEkB5akF7Gcfh2SNOjvpiCS6+abVq/wwWCfHxWMQIlXjjL/gi
         V+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268062; x=1788872862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=;
        b=J6tdOBUZS0c0FZYelqXQEUgzadh8TVTG1KmYpo/Wpgeoq6tNjHpW1o/K7GROL5qZu6
         zEwlFBMqZzyEepzsfpDyBYP8WI2VfRcWQAD0QfdvAOcjqbRTqKoN+v4KFnmjjaETMtGe
         a1WrNHPWe85jfjbi/dmDK9+4ZF9VH+IPksAHyy4kYe016sASJA62yGv5SP073Ab7vqzn
         hD7b+S5tRa+LtuvLSikpHjwen51xwJOaXdSAXEX7gmHjjSwMnUWhCMe55Mx/m6ZtY2O0
         T0Tt2iJmCMMWq09JpkGUvr+QgXaQwmCbVB8VPi1vPsuiw3FEPqzTb63Y9nO3cDLbcA/b
         Jn1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxO/2G5WPTIoSIisz140XlvAj9K2Cwx2SmhqB9ULS7EO/Tu4J+nE4BGotCd9L1x0Kk9qmYaJtA=@vger.kernel.org
X-Gm-Message-State: AFuF++kyGIby49kjwyRqPo0emlFDoBpiHWrNJPZxKB6Uk7wWZGEZV9Zb
	8EKaMywLsNtbkXBJEcgWxQYHjnuV9ZK+cGPVe4bsTQLYSufkO1OJRvRy6rdOUHFkHGRGSFubmKs
	D9AUxYMlMzvKgFOrFSRsJmq4Hn+HpFlrIN7JVZr6bvnJHl2IPKqlUFMFqyfY=
X-Gm-Gg: AYBFou3YWBCBQ7MyCq166bKcrcPRdyycygbzoK+UgKzDiHC1bzMn/eAOIFYVE5x1Od5
	Kls8sbvRXKzJwcAgCPOdrON7D66YO+qFImd2NECVF52FuqAx2CZZ+qJBlqlzmmyAJGCH6mU55Ng
	qWZhd4iVWI5n1xYYt+lK2L7Bmgb3/8s9RfjZF1m1i9TOiGe8IhF7Qr8VUuFAwQsrb3A5OVrEFZZ
	VkxkNzIeFe4eIDdRgULnmHqNlAa2ScPLdmB46NczpmkcMPVn5uSnXbOLPLRC3w2PcX1p72abVoJ
	OfIn3zGP7xXLBdxO58fex0A5Ppv4pc5Dwd9jFrkITHpIDvgaVsbxWVKPCpoyfmJf0hg5PLy/Bm+
	AiDuXG/PFHe9btVi3z+hg1hDs+MxP8urAuxwv71znDdz40RAJY+uyBKwptrU9ObBIqvqC40oB
X-Received: by 2002:a17:90b:53d0:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-396d0ec7afemr51415465a91.5.1788268061689;
        Tue, 01 Sep 2026 06:07:41 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-396d0ec7afemr51415272a91.5.1788268060923;
        Tue, 01 Sep 2026 06:07:40 -0700 (PDT)
Received: from [10.133.33.203] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d7759bd1sm6750547a91.3.2026.09.01.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:07:40 -0700 (PDT)
Message-ID: <36d2a431-a1c3-478e-a001-936d25bcb9e1@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 21:07:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: initialize policy rwsem before sysfs
 publication
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>, zhongqiu.han@oss.qualcomm.com
References: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
 <20260901121950.3279176-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260901121950.3279176-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zOEJbd-ssKdXtFz-ROHt1dceuTG2dp_Y
X-Proofpoint-ORIG-GUID: zOEJbd-ssKdXtFz-ROHt1dceuTG2dp_Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfX+5Blf1oNqAGg
 7jidmIOPdOfIX8kydS8VROpuj0ecILcUrxQIWkjI0rP0ALmtnaI0qd8KoKVv/3Np712qU8RWJF4
 OmTb1BTblkm0E4r1tt9RMMCwDxbgrtg=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96ce1e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FxTtqrLrjwncoYGlF1wA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfX3dOFi/VeaeqC
 Dtj3zXHii0QNqt6o0Rp/IFvC+xKFQmVuc8IRL6noyYXNegXWueHRrzZuijBTTq9+jJDeiDPLSYu
 qj8D9eNxiDWTE9NP0Qk/c/CHo1eO6ydp1FDxCeeGfjNAVnP+vKzzS3UCITY6p+max43TUkYSPHg
 Ox86YloGM5xz938PyaeV98LezuVtRCmNLO0tYAjNsYsyYkc0Jj/Q62M+ek/SHgMYX/jZXR+exrv
 4C2+hdckQnikVAAT8wgSDorou5otM6YJNrInGa80gXis7nUzZBc3qz+FhYaaMBom5oV5GhwKrpZ
 TRIrN5H+vx72TN457psOk0WbyzlTJ+ZYUa0hpbbFvRzq/PZTrEp8FZLPFmoV9Ikl0NzDMGQ4cHW
 fbn5pUzWgrW4Npj0pONp97B2yKtz/Vvdvp/TVoxf6faAcg+RJV/1K6b5z0vOxQUTGsKc5Q4WYKL
 exXQ4bcLxL+5slh/OCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010116

On 9/1/2026 8:19 PM, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@seu.edu.cn/

Nit: It points to V1 Link, but should be okay according by https://
docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: Codex:GPT-5

Nit: Sob tag should always be the last tag.


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> ---
> v2:
> - Correct the Fixes tag to the commit that introduced policy kobject publication.
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d0df986f..9efbf5b17 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1258,6 +1258,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
>   		goto err_free_rcpumask;
>   
> +	init_rwsem(&policy->rwsem);
> +
>   	init_completion(&policy->kobj_unregister);
>   	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>   				   cpufreq_global_kobject, "policy%u", cpu);
> @@ -1272,8 +1274,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   		goto err_free_real_cpus;
>   	}
>   
> -	init_rwsem(&policy->rwsem);
> -
>   	freq_constraints_init(&policy->constraints);
>   
>   	policy->nb_min.notifier_call = cpufreq_notifier_min;


-- 
Thx and BRs,
Zhongqiu Han
