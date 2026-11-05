Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884938;
	b=LFmjyVbDQRqTaC8i0EIpIdlKrSSBbJPKSwj6OdCgQa0BXHBsJINZ0+25loG0lUIXEyMc
	 u527ebVJg/JBsPaIkOK9x/AakFM/NCMyA5nkbfT4GJlUfWulW469+n6ShohBzPZQZc/HI
	 7MLjDd7LD723JMI9FveN8/mi0CGar7HP9Db95NXY5TDq7rQY5SBliiV6Y+sdmMqLvEnNG
	 GB6Xo5/5E6WCVfqRlHNGPEf6RZaR3Q9cw3n2xsBUMBNFwGCxHq3SIHXtwXXwMo+ayLZnz
	 W8EeIRsy2ip3zHsQi0pjy+JEBlghvSgdo9eK5NfkmD5CwKEod3jvRFSGCV5AueuZXVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884938;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=91cocnvbnRx/Qd0v1/HIoCOgWqd88dCvl8Ny4tBzk7g=;
	b=Mcip1JhqhRq2UMV1TKirc5kmLzrtkg8Fd2G9DEdCCWmWaUxpXyZBVUA6Xp+QxqhPccdI
	 /1SfcfmzcUxeSeWWIfuUk5dpuFx98TencAbDSRT6MUU+rck6zI4xulKstbHsrlqVUhK18
	 FFFb/DIoS2BaXM7zYswTIfYy90KRQdXQgvJvd4yMGwBo71pENzQ5/SnBbviyW9aEGyhqf
	 E0Uf+3pOLPYRRqd2JMkzsYD4lbY0usI+YSVO34SPrCT/0fKUabOqkw4o6rDeES/Nt3O8F
	 fQ2YZzY8B0uS4Ggcv2v3VM5op34nr3WNLsctZsQGRz/3w/rv1ZXhW/GkuLgYbWqjH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mmGzna8v;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC384606A31B;
	Thu,  5 Nov 2026 13:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC384606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mmGzna8v
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FFE14BF;
	Thu,  5 Nov 2026 05:22:13 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6D793F628;
	Thu,  5 Nov 2026 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793884936; bh=+W7MkRN3y0Siq1SPNCSQc2zsdzeTttb4/pbDc0HDnOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mmGzna8vUpyln9pniytA2fMQQRkZhERHFia3oXzCViH3+y16S7HayPvSajkWdGEHX
	 f7kTANr4sLyUrlYnmKGaPlP9kHhT2PtwdaY7la9Q1GZ83UBB/L4xS7V4XmmN/NaHWW
	 PcQL0p+r9gdH4O22nfckzMIMPKpSSPAaaQLgu070=
Message-ID: <f3d2b82b-81bc-433d-8589-2fc88822e342@arm.com>
Date: Thu, 5 Nov 2026 13:22:12 +0000
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
Subject: Re: [PATCH] cpufreq: CPPC: Set CPPC Enable register in cpu_init
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 benc@redhat.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, stable@vger.kernel.org
References: <20261105123244.3132560-1-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261105123244.3132560-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 12:32, Sumit Gupta wrote:
> As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
>   "If supported by the platform, OSPM writes a one to this register
>    to enable CPPC on this processor. If not implemented, OSPM assumes
>    the platform always has CPPC enabled."
> 
> The driver never writes this register. Call cppc_set_enable() at the
> start of cppc_cpufreq_cpu_init(). Errors are logged but not fatal, as
> the register is optional.
> 
> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> Cc: stable@vger.kernel.org # v6.16+
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

So apparently Nvidia GB10 has and needs this
(I guess it doesn't hurt putting this into the
commit message)
amd-pstate sets it so all good.

> ---
> Sending this separately from the autonomous mode boot parameter series
> where it was patch 1/2, as it is an independent bug fix.
> v5 of the series:
>  https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
> 
>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 957fa7775260..b8f4399b6e0b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -679,6 +679,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	caps = &cpu_data->perf_caps;
>  	policy->driver_data = cpu_data;
>  
> +	/*
> +	 * Enable CPPC. The Enable register is optional - some platforms
> +	 * may not support it.
> +	 */
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret);
> +

Any reason to not fail here?

>  	/*
>  	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>  	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)


... also I guess we need to set_enable(false) on
other failures?

It should be okay to do this only for policy->cpu AFAICS
but I guess we do need to also reenable on resume.
