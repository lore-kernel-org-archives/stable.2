Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4335F5FB
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323407; cv=none; b=pN/uTZpyn2s5WBVSqD1UgIDwmw2rnW+5TwhD+/z8kT3z16uSbStl94l/7dQ3JWwOv1UZKITUZB8W8C585U7D9qm+Wuli+h2UaP9z32MHNSDV3kQEtljJTJAedeXXkpHxPurszw+A+X0bczEca5As6Q+iXjKVwRwGA+FDZP8R0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323407; c=relaxed/simple;
	bh=mdgPcZlJL3HWscq7fjKdXipWCBSy4NPqNPPDd1WmTxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH6k1luP93l7/NmaQIY3XBm0olx9aSWlh9Jdgtl0e9Usl6gUgv74Kmv0VzFhFncoQZ9lxhBLr9o24ib+dQ6PhQLMtlgV5f/IV7u4jGLTpsvBcaJFIuWPBXWEPR39U5zlgxIqjuMhwAMexzHrNHOZPO7x6ExxS2zkrGmG+XghTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kylzrvcP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kylzrvcP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d032846c95so6594285ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788323405; x=1788928205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loEECbV+1/PD6+b04t7A4hFCdkNgi7Lwbp3peMcWJ+A=;
        b=kylzrvcPW8My5uGhAq8czS7VAOEfT8rkcQe94tAojm3tHSRNYNryv6HN4D3qIN+WWK
         w6Dnb8dUN35NtcaUQy350VObn+ygPV8wP5ug6Qawvk8SLLDrQovJdAvr6mslghmzitoP
         rt8iSVzjiWBakSYlLVSA+P0jMLGSzHYFquAvs60MR8LNb3Xspa8orIjnD4eNNrVwXz65
         Ze5oqM4LPHNL5iAWhb6kMSBrRWCsYr3qtiwnF1//7nX2ovn4rD6pWgJjatQC+kIMeCfb
         T7Oz2JeUucqB85AuTM2OVMJzRqWRT0IDnvoWgd+9wDQTyO8k6OAL1Kp557nikhFGJSEj
         NlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323405; x=1788928205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loEECbV+1/PD6+b04t7A4hFCdkNgi7Lwbp3peMcWJ+A=;
        b=Ufv/B864pTfb04pp0504K3LeIZu/Lo3cJixjdwnD/atd3sAIbkpyGu2BImSpdZ9D/d
         OFVYmQZFpEdh/6HCjqlIVU+8bKAu5mM3kvqbJOScMdfX8t2DYDiyDJ8LfEgf2kjfYOdl
         VjxK1dYK91T06G/sHz3qbcnKiakkYzEPyurPZemdo33QpXOz67XqocX7+4160wyWAUqr
         7FaN2BjUAjQ3azHXAqvVGByj8lX92Ig8aiu5Ia0cCazH523O3H903k0KAEM2m1grQ7bB
         PfnOZaOmnvFT53qtpekU/jLM1SpHeF19jle8a3QxTn14BObMdMmUs9G8563xYsZbLd8T
         7N3g==
X-Forwarded-Encrypted: i=1; AKwUvBy7bxC0dM7uMDksLmt50l6lbS+M3A501F2AIUWVHVHiGmmQdF/zL1kHdPHzfe+56iGJd/a+3KU=@vger.kernel.org
X-Gm-Message-State: AFuF++nYMoHiCSpyJQ9ic9TC1Iy894peE4BGGtZK230dTSakSpa1onAn
	RMUnHTYstqOBq7dRWSLAVvLqZ043IN5ONV3lwZy4wYOVPPJ8AcYWxPRwLckpak0Kf6k=
X-Gm-Gg: AYBFou1wqXC2mOxBj4B9UbbuUYVpc7NK/QNzlaP4QEkG7qDmW/pgHEugk9T31lkrG4R
	LA3jBtyAMyyO87y8hLi58O2ZDdPTFkeBMBRKQmYrcqUlUCiy23mPkhNlXKnJm+2X1/cAz5TLuKk
	eAwtOFN4KgUS/T7OVv2jKCVi2yJonfeVA6f3n9QRSYZg5KBROLUiUKkuUEr1t4vhefRD98Sqh2z
	5bazXfwihJMkNLk0c0UHiv0WF6epHV9szCNdj/tYcpN+pGHctFVKpuTs6Es6FcSTrsIWwLp7V98
	rKUZLdpko06QpXugePURg323zu+w8G+4xtyYlC+udsZaS3psjM6Eqk2OCqklOwxx2ZcfdXCSvoI
	nzoZqx0gz5ebtVy6x8MvN+UIAk0bpZEve17siNXLK5xx0v8fN7E26OhbrD443Afi8qTf7ZIB4+i
	6qku65vTbjar57EleZCwZHKvYDoCwS2aDxhL4S/bcI56XOm/RHV8KvzSg9LBZWUo4=
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr2465215ad.3.1788323404935;
        Tue, 01 Sep 2026 21:30:04 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c6aa4sm2617066eec.5.2026.09.01.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:30:03 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:00:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: zero-initialize policy cpumask before sysfs
 publication
Message-ID: <apemScUaVXUn8sR6@vireshk-B250M-D3H>
References: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>

On 01-09-26, 22:36, Zhongqiu Han wrote:
> cpufreq_policy_alloc() allocates policy->cpus with alloc_cpumask_var(),
> i.e. without __GFP_ZERO, unlike the sibling related_cpus and real_cpus
> masks. With CONFIG_CPUMASK_OFFSTACK=y the mask is a separate
> kmalloc_node() allocation, so its bitmap holds whatever the slab allocator
> left behind:
> 
>   cpufreq_online()
>     cpufreq_policy_alloc()
>       alloc_cpumask_var(&policy->cpus)    /* bitmap is uninitialized */
>       kobject_init_and_add()              /* policy%u/ appears in sysfs */
>     cpufreq_policy_online()
>       cpumask_copy(policy->cpus, cpumask_of(cpu))  /* first valid value */
> 
> This leaves a window in which the sysfs attributes are already reachable
> while policy->cpus is still garbage. show()/store() gate on
> policy_is_inactive(), i.e. cpumask_empty(policy->cpus), so a non-zero
> bitmap makes them run the attribute callbacks on a policy that is not
> initialized yet.
> 
> Fix this by using zalloc_cpumask_var() for policy->cpus.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
> This patch is based on https://lore.kernel.org/all/83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com/
> 
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d0df986fa3d..3b1b2ed86cc3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1249,7 +1249,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	if (!policy)
>  		return NULL;
>  
> -	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
>  		goto err_free_policy;
>  
>  	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
