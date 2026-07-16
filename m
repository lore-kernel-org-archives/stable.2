Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0330F95F;
	Thu, 16 Jul 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204740; cv=none; b=A3yV1+TxjG9ljiWcgVcbkxOV+NVNY/4CIpFwShGBGHMOfhfdW7ctuW9ItYCA4jMXbXpt4lCNftQ02n0GSLTs+QkqIuszizN3LF/zyYjvve8QlfA2YDGzxwm/H5Eh4Oo6ugvIB+wypaId4g8pOaF8b2edFOUGgiGIJyBvji/MU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204740; c=relaxed/simple;
	bh=7D3mEZM8Y5itCOdYNjaIRBivbto40cRIDLjs2IqZBWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFzwJupGrslvDFJRWGuGnoc0kILksg5rkKqrmNAleaCL1sZ8EayzLJg9dpGef2K41ZAhYcXMlkepKO7KS6geEZfQUxPWAel0FiNTaeDTHgPMZD4pqr2fNjJ9ONmXPIMxP2KIDL4Ao+yuEV5k4ARsZNg+HkZmIZDjXNCNO+8zjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nyCIW1He; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nyCIW1He"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C58631476;
	Thu, 16 Jul 2026 05:25:33 -0700 (PDT)
Received: from [10.1.39.63] (e127648.arm.com [10.1.39.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8773F7B4;
	Thu, 16 Jul 2026 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784204738; bh=7D3mEZM8Y5itCOdYNjaIRBivbto40cRIDLjs2IqZBWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nyCIW1He0y/JV3r/g8aBNYA1vZGeAE1KL1FB85gjN0pCFbEILq+XprsPcvvI+JBgT
	 fAwxgWo9SEWH8lCNS5HvvJEWzz+ivwMTdUmEgFzicHf2LkxBD4YLT+mG3wkosK/SXG
	 cc5C4MqKVvHx1Q+J8L0iPSAfs/BDbZyYuEx4p+CA=
Message-ID: <6abab7b9-71cf-47d4-b7dd-def43be935bc@arm.com>
Date: Thu, 16 Jul 2026 13:25:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Publish util hooks only after all
 sg_cpu are initialized
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, liaochang1@huawei.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260716115159.848403-1-zhongqiu.han@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260716115159.848403-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 12:51, Zhongqiu Han wrote:
> Commit 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of
> sg_cpu in single loop") merged the per-CPU initialization and the
> utilization-hook registration into a single loop in sugov_start().
> 
> For a shared cpufreq policy this re-introduces the race originally fixed
> by commit ab2f7cf141aa ("cpufreq: schedutil: Fix sugov_start() versus
> sugov_update_shared() race").
> 
> The scheduler's util path reaches the hook under RCU-sched and never takes
> policy->rwsem, so the rwsem held across sugov_start() cannot serialize the
> two. Once the first CPU's hook is published, sugov_update_shared() may run
> and, via sugov_next_freq_shared(), read/write each sibling sugov_cpu
> (iowait_boost, util, bw_min, ...) concurrently with the memset() still
> initializing them, with no lock common to both sides: the update side holds
> sg_policy->update_lock while the init side holds only policy->rwsem, which
> the scheduler's util path never takes.
> 
> The walk only accesses scalar members, never a pointer like ->sg_policy,
> so it does not crash today; it merely uses stale (or zero on first start)
> values that skew the frequency selection and tracepoints. It is still a
> genuine data race, and a latent crash once any pointer member is
> dereferenced there.
> 
> Restore the two-phase approach: initialize all per-CPU structures first,
> and only then publish the per-CPU utilization update hooks.
> 
> Fixes: 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of sg_cpu in single loop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index dc0835ceee98..6ad080de8644 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -872,8 +872,19 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu = cpu;
>  		sg_cpu->sg_policy = sg_policy;
> +	}
> +
> +	/*
> +	 * Publish the hooks only after all per-CPU data is initialized, so a
> +	 * shared policy's sugov_update_shared() never reads an uninitialized
> +	 * sibling sugov_cpu.
> +	 */
> +	for_each_cpu(cpu, policy->cpus) {
> +		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> +
>  		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
>  	}
> +
>  	return 0;
>  }
>  


Good catch!
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
