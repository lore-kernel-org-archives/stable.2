Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E43FC5AC;
	Fri, 12 Jun 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284310; cv=none; b=aIIoF1aw07ea25SB7eyPvGxDguFcqI8HlQDh9i0qVvORsP5yoy4s1FpEnDay/Wha491YzIBv2SdCeebqhI0A+TvD+sKSTxaFw/n9ijNJj04Je8EMAaG5plIhIT+8kwE45HORhGGm1BeyAGDGsGvcIS81Oc64+dnsTmhu7r2QLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284310; c=relaxed/simple;
	bh=B8U2SJ40bu19l1Bskx20byRPuGWvv8sRp2tUqOV1an0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjIsQM5mchwH/L/xGxHnjBhmboUdIegbJh8hJN0WckQC/vvWvTTG1yFzdvpZkj4rSQN4ieDx5/S7xKlT9nwdEkm7lgQk2j2Nzi5sCEjWf+K+aH8DS8nfQ+dLOFVdscVMDYzTWKXqmf428nKnG4KvgYhPfgQOwT77SLDNQINLzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Og5VSvJA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Og5VSvJA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748C032FA;
	Fri, 12 Jun 2026 10:11:40 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A787F3FAA1;
	Fri, 12 Jun 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781284305; bh=B8U2SJ40bu19l1Bskx20byRPuGWvv8sRp2tUqOV1an0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Og5VSvJAAlHUGjKrOzD4piBhFGiPI+J5r/NwPCyMSH3gJTspQtQivSq1JH74Z7/eH
	 f7k1bfn4d6+KHKf+m1kvJ0ha6lOeqn20It1hbK7TJSrqkQynn7wQQ8PQYtzm4V0srr
	 AURlD06hsSLGaXiRox4Fc2dDzt+MTNOBGbeEiQhA=
Date: Fri, 12 Jun 2026 18:11:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <aiw9u4BllwZXDH2S@arm.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>

Hi Breno,

Thanks for addressing this long-standing soft lockup problem.

On Fri, Jun 12, 2026 at 08:16:07AM -0700, Breno Leitao wrote:
> +/*
> + * Briefly drop the RCU read lock to reschedule during the task stack scan.
> + * Both cursors are pinned across the gap; return false if either one was
> + * unhashed meanwhile, so the caller stops this round instead of walking a
> + * stale list.
> + */
> +static bool kmemleak_stack_scan_break(struct task_struct *g,
> +				      struct task_struct *p)
> +{
> +	bool can_cont;
> +
> +	get_task_struct(g);
> +	get_task_struct(p);
> +
> +	rcu_read_unlock();
> +	cond_resched();
> +	rcu_read_lock();
> +
> +	can_cont = pid_alive(g) && pid_alive(p);
> +
> +	put_task_struct(p);
> +	put_task_struct(g);
> +
> +	return can_cont;
> +}

While this matches rcu_lock_break(), it looks to me like we rely too
much on the internals of kernel/exit.c. Ideally this function should be
provided as an API alongside for_each_process_thread() so that we only
have the idiom in one place in case something changes in the future.

Yet anther variant below, untested. Basically, it follows the
next_tgid() or task_seq_get_next() approach (we might as well move this
to a separate function to avoid excessive indentation):

	if (kmemleak_stack_scan) {
		struct pid *pid;
		int nr = 1;

		do {
			struct task_struct *p = NULL;

			rcu_read_lock();
			pid = find_ge_pid(nr, &init_pid_ns);
			if (pid) {
				nr = pid_nr(pid) + 1;
				p = pid_task(pid, PIDTYPE_PID);
				if (p)
					get_task_struct(p);
			}
			rcu_read_unlock();

			if (p) {
				void *stack = try_get_task_stack(p);

				if (stack) {
					scan_block(stack, stack + THREAD_SIZE,
							NULL);
					put_task_stack(p);
				}
				put_task_struct(p);
			}
			cond_resched();
		} while (pid);
	}

-- 
Catalin
