Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613848;
	b=4v19i3SYZx7yVUTu5KgmV2lmBZpXwhdrcUalqpwvMi8tEqi2s0nNJ9PZaP0J2l4PZMK9
	 IYMdCQ+i3fy2yWe5dyZZQ61iUh9fL+HLKvBdZwxlytTK/oF4zx2cHiSwTMME/ZlqOdW3T
	 bsdwLRQtKDgfQeBCDuthdocv9Xz/ta88mahAtdi/j0zTHuRkCmksFuwuX5wj+/WrwRwYQ
	 hNI5LNnKDIZh+tFhnB+kSkgNnJHQ3/wNNNmzu5eJLgqZNQZZwRGiyQi5DQ8o1gjlEqm3/
	 +WTRvjRdFAjBmN1flneyJuiaotBmsRzk9+chXuC4w/zNS5IOJ18pLztO7Kar5yJvkrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=/UiazhXuul/GOq/HbXOMsV+5+7TGJAYatnIj4h4m6vU=;
	b=Vof8TtnufSPwSK8ml+pRXkIz7iMSUtHY8hOV/SpLfgs8yNCAf/Z1WbUYMRgov8G1aNpM
	 Z76CNQ5di4PoPRBGX6Xt8b9y4KTG98yw5LjHJkJedv99kXHv6lJgBYI2E5RIpKLuh03pd
	 5+70i10KZNKReyye4tM4WxJC9SyDzRqyL5jfSzcCb2Ydb/DTC/+C4VsKQAiY6z2qWGaLo
	 I5f/JxyISPk9crCBbhUiW9JwwvYyMz3xJZKvlGT/X1DvD9j+Rw5J+daEy+D7amoSWr71z
	 KwTvx5jN2r2G3PPCCiV4B5t17EG7/E3SYJRFEW2aaf9Uns/YCuPVAwryo293840spag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fOM78T/V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E12606A33F;
	Wed, 25 Nov 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOM78T/V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3731F000C0;
	Wed, 25 Nov 2026 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613848;
	bh=/UiazhXuul/GOq/HbXOMsV+5+7TGJAYatnIj4h4m6vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fOM78T/VNXM8hP/3dC3+SutrTbxB3oFUm7ZM7yRlwxp4YbRElnKM4bV1z25hWzX33
	 Fpb+pKC2WJUoSK1yvmjkK1LFFe7LmZ1WQ2s9c2EgEkrGK2p0iij6teYF/3LSM872fV
	 U+dqn/d1jyu6O4E9x6TPnXDEougVKGKPWGnfm41s8gwhsjp1bec6Z9+dGFzJsQOlpx
	 NlusCnZYc2mSTf1xnLwIXSgZrfzW29QuyRZ3EATmEOOD6L+0ViAeKIBmAJO/8TgJa7
	 fyQqi9ORTYMVDuyBZMtA4tm8qJGS9m4NbsIpg4uq6+ZUaMJp09xNyvqom6CWbx9z7X
	 0RNF+Uq+asFLA==
Date: Wed, 25 Nov 2026 14:37:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Wenwu Hou <hwenwur@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <awbklFE66PIMKFop@localhost.localdomain>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125084600.2306377-1-hwenwur@gmail.com>

Le Wed, Nov 25, 2026 at 04:46:00PM +0800, Wenwu Hou a écrit :
> start_single_kthread() sets the affinity of the kthread it just created
> before waking it up, but kthread_affine_node() overrides that mask on the
> first wake-up. See commit 60ba9c38b931 ("kthread: Comment on the purpose
> and placement of kthread_affine_node() call").
> 
> In round-robin mode, move_to_next_cpu() compares save_cpumask against
> current->cpus_ptr, sees the replaced mask, and switches the tracer to
> MODE_NONE on its very first iteration:
> 
>   hwlat_detector: cpumask changed while in round-robin mode,
>   switching to mode none
> 
> So the tracer no longer migrates across tracing_cpumask. More importantly,
> tracing_cpumask is not honoured at all, and with isolcpus=/nohz_full= the
> thread cannot run on the isolated CPUs it is meant to sample.
> 
> Use kthread_bind_mask() to preserve the initial affinity, including
> isolated CPUs. Clear PF_NO_SETAFFINITY once the single sampler thread
> starts to allow userspace affinity changes and cgroup migration.
> 
> The mask is now computed and validated before kthread_create(), which also
> avoids creating a thread when tracing_cpumask has no online CPU in common:
> cpumask_first() returned nr_cpu_ids there and cpumask_set_cpu() then wrote
> past the end of the mask.
> 
> Tested on a 4-vCPU KVM guest, bit 0 of the mask is CPU 0:
> 
>   mode        mask    before                    after
>   none        0b0101  Cpus_allowed_list: 0-3    0,2
>   round-robin 0b1111  mode -> none, no migrate  migrates 1 2 3 0
>   round-robin 0b0101  mask 0-3, no migrate      migrates 0 2
>   per-cpu     0b0110  2 threads, cpus 1,2      2 threads, cpus 1,2
> 
> Fixes: d1a89197589c4 ("kthread: Default affine kthread to its preferred NUMA node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
> ---
> Changes in v2:
> - Clear PF_NO_SETAFFINITY under current->pi_lock when the single sampler
>   thread starts, preserving userspace affinity changes and cgroup migration.
>   Keep PF_NO_SETAFFINITY set for per-CPU threads.
> - Update the commit message
> 
> v1: https://lore.kernel.org/linux-trace-kernel/20261111020755.1422284-1-hwenwur@gmail.com/
> 
>  kernel/trace/trace_hwlat.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 3fe274b84f1c2..52478ad8030d0 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -353,8 +353,21 @@ static void move_to_next_cpu(void)
>   */
>  static int kthread_fn(void *data)
>  {
> +	unsigned long flags;
>  	u64 interval;
>  
> +	/*
> +	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
> +	 * affinity from being overridden by kthread_affine_node(). Clear it
> +	 * now to allow userspace affinity changes and cgroup migration, but
> +	 * keep per-CPU threads bound to their CPUs.
> +	 */
> +	if (hwlat_data.thread_mode != MODE_PER_CPU) {
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> +		current->flags &= ~PF_NO_SETAFFINITY;
> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);

This is not pretty but moreover, is it a good idea to let the user override
that affinity?

Thanks.

> +	}
> +
>  	while (!kthread_should_stop()) {
>  
>  		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
> @@ -423,15 +436,12 @@ static int start_single_kthread(struct trace_array *tr)
>  	if (kdata->kthread)
>  		goto out_put_cpus;
>  
> -	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
> -	if (IS_ERR(kthread)) {
> -		pr_err(BANNER "could not start sampling thread\n");
> -		cpus_read_unlock();
> -		return -ENOMEM;
> -	}
> -
>  	/* Just pick the first CPU on first iteration */
>  	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
> +	if (cpumask_empty(current_mask)) {
> +		cpus_read_unlock();
> +		return -EINVAL;
> +	}
>  
>  	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
>  		next_cpu = cpumask_first(current_mask);
> @@ -440,7 +450,14 @@ static int start_single_kthread(struct trace_array *tr)
>  
>  	}
>  
> -	set_cpus_allowed_ptr(kthread, current_mask);
> +	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
> +	if (IS_ERR(kthread)) {
> +		pr_err(BANNER "could not start sampling thread\n");
> +		cpus_read_unlock();
> +		return -ENOMEM;
> +	}
> +
> +	kthread_bind_mask(kthread, current_mask);
>  
>  	kdata->kthread = kthread;
>  	wake_up_process(kthread);
> -- 
> 2.43.0
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
