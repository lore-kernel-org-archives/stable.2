Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107612;
	b=MEV5xvJqZqrscOfKWR5po1hdINR/p70nUHpnO+5x3+s7skrLhXNvn01ZjSe4S7r3V+nU
	 gk5qrK8KeMkE0ckwnh2UWLPV8Mhjz/bqORbU+72Jdxks+LdFZjEy1gv7kYPdwBuzp1/Um
	 iCR6+PLqDSPuPty8WpPi3qPp6a1YOobsK7snxZolAePC2DhV9d3QX45dh3RhTXnRiALGe
	 /hfuFHjKxmjHNY8rNknEfmuVexePc1LJv3XeZ1WUfIBDcM1fwZJjkwCfz6cyQMQhMSC8H
	 AsAeaU6vL1JXigKDmpgyk4rXEipMft6G1y6+koadnQNpCntc/4I2xErt2WV+IXgX/XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107612;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lqw+TfDddRRG6oehvVdMMbadresy6pl8QAbpbcWHAzw=;
	b=cugY1LF3ALkZl+6DV+jZmhqkrTh6H7LtVOfvK7X2ASRk9y7R2Kr5UZH66XiWzj7HIcbT
	 0YvKqai09MX+3G2z8aiTc0obg9WxloVyaplmi13NxU3C33J3/QGok3ofOzRHyqx/50F9I
	 N2edOMpNzlI4YbWAimKQvsRwrB7aiGxMdCZHYv/FIQsa74SAz6W3sXtzAJrrFOJPMd6Cc
	 oaUYGsqsjgiAO6p2L4CsLQhIytFIb6vwr/bLT31jWNBdoJy11V42lHQBzjaQEMiMYoOyW
	 Mjpp7FhTBbjUEmmXkXI1+5vmGrONsxk+1j3UKZE3cSUYCkxOxa+3xMertubH1nRv0qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.12
Received: from mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE2606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46FE2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bVchNI6MPrPq2ISgrQi9jHRX7+8yy0AAnhLVZeK+Z7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793107603; v=1; x=1793712403;
 b=v1qf0Ngn9OHSgT9zQUDtoO3QxMfR++VGO24HB3b4ODQIcAcXUm2XGZOUKA1yVmU9Hcm14L96
 MjR9ufZ0k12bRgmrywuOKIJ8mpxD+9b3GHMbmNdxTjpd4+wl9qhM87V/z0bOLwE6UoQiGNRZB/V
 o9DQb4k0PF76ae4CrDU+6kC8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 21122a2229b38990;
	Tue, 27 Oct 2026 13:26:43 +0000
X-Mizu-Trace-ID: 21122a2229b38990
X-Migadu-Flow: FLOW_OUT
Message-ID: <823d68e9-dda1-4458-94d9-fe4872832d7c@linux.dev>
Date: Tue, 27 Oct 2026 21:26:33 +0800
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
Cc: cui.tao@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 penguin-kernel@I-love.SAKURA.ne.jp, tj@kernel.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't miss processes whose leader has
 exited in OOM scans
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, akpm@linux-foundation.org
References: <20261026120248.2188024-1-zhanxusheng1024@gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261026120248.2188024-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Xusheng,

在 2026/10/26 20:02, Zhan Xusheng 写道:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> mem_cgroup_scan_tasks() walks with CSS_TASK_ITER_PROCS, so it sees only
> thread group leaders, plus a dying leader that still has live threads.
> Moving a process whose leader has exited, by writing its PID to
> cgroup.procs, moves the live threads but leaves the leader behind, as
> cgroup_migrate_add_task() skips exiting tasks.
> 
> The destination's OOM killer then cannot see the process.  If it is
> alone there, every attempt ends with "Out of memory and no killable
> processes..." and the charge is retried indefinitely, and
> memory.oom.group kills nothing; otherwise another process is killed in
> its place.  The source's OOM killer still finds the leader, reaches the
> moved threads' mm through find_lock_task_mm(), and kills a process that
> has left the memcg.
> 
> Walk all tasks and take one per thread group: the leader, or the first
> live thread once the leader is exiting.  Skip exiting threads, which may
> belong to a group that has moved out.
> 
> Tested in a VM with memory.max=64M: in each case above the process using
> the memory is now killed, and a process whose exited leader was not
> moved, or whose leader is alive, is killed as before, with and without
> memory.oom.group.
> 

Tested on next-20261026 (x86_64 KVM guest, cgroup v2, 48M memory.max
on the destination group). Without the patch the worker thread stays
alive and the OOM scan keeps printing "Out of memory and no killable
processes..." (2887 oom, 0 oom_kill in one minute). With the patch
the worker is killed right away. A live leader and an exited leader
that was not moved away are still killed as before.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>
Tested-by: Tao Cui <cuitao@kylinos.cn>

Thanks,
Tao

> Fixes: f168a9a54ec3 ("mm: memcontrol: use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  mm/memcontrol.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4d00748c8a5b..8823c549b6af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1427,6 +1427,36 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>  						dead_memcg);
>  }
>  
> +/*
> + * Take one task per thread group: the leader, or the first live thread once
> + * the leader is exiting, since migrating the group leaves an exiting leader
> + * behind.  Exiting threads are skipped, as one left behind may belong to a
> + * group that has moved out.
> + */
> +static bool mem_cgroup_scan_skip(struct task_struct *task)
> +{
> +	struct task_struct *leader = task->group_leader;
> +	struct task_struct *t;
> +	bool skip = true;
> +
> +	if (READ_ONCE(task->flags) & PF_EXITING)
> +		return true;
> +	if (task == leader)
> +		return false;
> +	if (!(READ_ONCE(leader->flags) & PF_EXITING))
> +		return true;
> +
> +	rcu_read_lock();
> +	for_each_thread(leader, t) {
> +		if (!(READ_ONCE(t->flags) & PF_EXITING)) {
> +			skip = t != task;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return skip;
> +}
> +
>  /**
>   * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
>   * @memcg: hierarchy root
> @@ -1452,9 +1482,10 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		struct css_task_iter it;
>  		struct task_struct *task;
>  
> -		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> +		css_task_iter_start(&iter->css, 0, &it);
>  		while (!ret && (task = css_task_iter_next(&it))) {
> -			ret = fn(task, arg);
> +			if (!mem_cgroup_scan_skip(task))
> +				ret = fn(task, arg);
>  			/* Avoid potential softlockup warning */
>  			cond_resched();
>  		}
> 
> base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a

