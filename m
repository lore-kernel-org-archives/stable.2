Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308320;
	b=Md0D+5VNu6vdlWajliM1A0ehPuaS/MKhpUgB4ysIasyFe089tuyO7EBMED9+gnaT/KAe
	 KmDzVIYIF81VgxETQns6e66qRaWiyvy89aeZ2Sf1Yi2kA3/ndtgPWq+RNbKCbRvM0U41I
	 XSStskJq77BTEczrP66/7fSA/G7DwtD7FVNDnf5PdWC8tZfdWfnRoq7GnxI9988FxEM9R
	 1z/BpkFKOcY8qUvYmdOJJey6/lydF1OMMW/eKsErskWe+zCEtLrMJkureQzNCeUfx1bQy
	 CS0RwR4GdzTBchBhWz02UOFrk0Cj7+1ykUG4BNWU61OPV//RsrJqEy8k77YYvvnZ00w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308320;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oFUa0NTalT8I2v4z+dJNxj/0wWQceUns2tfMcsjj9Ls=;
	b=EpMNtflCvr3cqA6AJvN+FxeBgt1hoZnKtl/S70Am6O7afg/BUx8kmgWQ8FZCjUxzGOt5
	 XQjbj8uVaiW4wXA0Gz4X0TgKMOtFFE8vrnk/QHy1RFDugdj7jG5K8nqzI/P2mxKejn4TR
	 jS5EHApIe+kC1PxDt+0PW+OxDzN51nh5RSG5GL5mAv47FDF4UFNM029F+j+/I5GW87xja
	 QmvvjYiPUiuOylRZ75G1R08p2buyNvxTWrKq3ZBRxOHwR7pdfxN840RvBWMk/fYE+tbR8
	 TBdL5q0R1qC47oEn9aHD5C2ARWlZdqIY2OeqZgohTuQV1oxgNv5XSZwffzKo8gRB5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aSQodJ2n;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4E606A335;
	Tue, 10 Nov 2026 10:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D4E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aSQodJ2n
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A8D1516;
	Tue, 10 Nov 2026 02:58:34 -0800 (PST)
Received: from [10.57.15.53] (unknown [10.57.15.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AA5F3F85F;
	Tue, 10 Nov 2026 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794308317; bh=o6OORrG7IfdhK72XlSREVjFq8oJqpEAcuTcKqxHnmic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aSQodJ2nFurGpy+xIpsDjV11vTFs0fGjvivf195NQHAU5Twb21kaYPTsHdE6NkdMJ
	 HEgc46ycKsZFSiT3c02oVPI5sfP2qzpnR8dsCTaRdAJ5AxOWOko+aNzUvEOuQydApe
	 dPyJUkTvhIy2ECSrhqz83KDFRMS/LQInpboTYFvo=
Message-ID: <09209b48-a469-4bd9-8d43-845f709353ca@arm.com>
Date: Tue, 10 Nov 2026 10:58:28 +0000
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
Subject: Re: [PATCH v2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 jbenc@redhat.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, stable@vger.kernel.org
References: <20261110101246.3665797-1-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261110101246.3665797-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 10:12, Sumit Gupta wrote:
> As per ACPI 6.x s8.4.6.1.4 (CPPC Enable Register):
>   "If supported by the platform, OSPM writes a one to this register
>    to enable CPPC on this processor. If not implemented, OSPM assumes
>    the platform always has CPPC enabled."
> 
> The driver never writes this register. CPPC therefore stays disabled
> on platforms such as NVIDIA GB10 that wait for OSPM to enable it.
> 
> Call cppc_set_enable() in cppc_cpufreq_cpu_init(). Fail init if
> enabling CPPC fails. If init fails after CPPC is enabled, disable it
> again. The register is optional, so -EOPNOTSUPP is not an error.
> 
> This relies on commit ab482f1bac6b ("ACPI: CPPC: Refactor register
> value get and set ABIs") from v6.16. Before it, cppc_set_enable()
> returned -EFAULT instead of -EOPNOTSUPP when the Enable register is
> not implemented. On an older kernel this change would make init fail
> on every platform without the register, so the stable range starts
> at v6.16.
> 
> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> Cc: stable@vger.kernel.org # v6.16+
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> v1 -> v2:
> - Fail init if enabling CPPC fails and disable CPPC again if init
>   fails after enabling it (Christian).
> - Move enable after the policy->shared_type check, so cppc_set_perf()
>   is the only failure after it.
> - Mention NVIDIA GB10 in the commit message (Christian).
> 
> v1: https://lore.kernel.org/lkml/20261105123244.3132560-1-sumitg@nvidia.com/
> 
>  drivers/cpufreq/cppc_cpufreq.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 957fa7775260..b2af24ae5008 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -714,7 +714,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		pr_debug("Unsupported CPU co-ord type: %d\n",
>  			 policy->shared_type);
>  		ret = -EFAULT;
> -		goto out;
> +		goto out_put;
> +	}
> +
> +	/*
> +	 * Enable CPPC. The Enable register is optional - some platforms
> +	 * may not support it.
> +	 */
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		pr_err("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret);
> +		goto out_put;
>  	}
>  
>  	policy->fast_switch_possible = cppc_allow_fast_switch(policy->cpus);
> @@ -742,6 +752,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  
>  out:
> +	cppc_set_enable(cpu, false);
> +out_put:
>  	cppc_cpufreq_put_cpu_data(policy);
>  	return ret;
>  }

