Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690104AE120
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441735; cv=none; b=dwFCRS4KrhZ3mMDchj+Z2Swdyh+F0XFR+tAunJlAuHxdya9kjOTlbNyEfB/rgJ/ZJ0sJ3pwoWw9nDOfFa1lGbjKO60zCwfWcwabej7U/557i8T3OX8UfxM3pBbHDWJWSrPJd2hSFAsFesVf79w+GHfNZbECMbyGp9Mqd7zEqxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441735; c=relaxed/simple;
	bh=j4uTZUo+uYR5vMdqlLMHmmh/MInxo1hjPIgXMf1amGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVCqyIYFmE0a49s9qF+6keJs/cUeovREY9Ubkwv5Vm3IRa/nLyd75iZ/i7Jbl5dQP4RmCxGlb6VdCXNzXUyK3WM9wBrNzbCi3+d4xH3FaqY9eygcWqxI7Ly51vJrMt1c4vxI8hhJHVt0ypbBZokYBk15eWkKmqxg2uJB+MDdRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoFXIfPt; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoFXIfPt"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j4uTZUo+uYR5vMdqlLMHmmh/MInxo1hjPIgXMf1amGM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788441717; v=1; x=1789046517;
 b=QoFXIfPtKfBRiqW/yfCTmlyIbPIwn/gWXaEf3B/eMKBKmT8y2CYjx2tD5VhuVeBDdPBSum8g
 rCpuReIzmSfbH8O67eOcKeVevir3zvXPeB0a2d7rSu6PZYRpOg4ovq+kpCJm4jOjQQiGi8RDSeX
 7hi4I783cVZcp8svDoDYN3Zg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0f1f8dcc7f935278;
	Thu, 03 Sep 2026 13:21:57 +0000
X-Mizu-Trace-ID: 0f1f8dcc7f935278
X-Migadu-Flow: FLOW_OUT
Message-ID: <047c7f3f-4a8d-47b1-a940-cc4535c3495f@linux.dev>
Date: Thu, 3 Sep 2026 21:21:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] cgroup/cpuset: Fix misplaced DL migration reset
To: Karl Mehltretter <kmehltretter@gmail.com>, stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901131335.15553-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Guopeng Zhang <guopeng.zhang@linux.dev>
In-Reply-To: <20260901131335.15553-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/1 21:13, Karl Mehltretter 写道:
> Mainline commit 4a39eda5fdd8 ("cgroup/cpuset: Reset DL migration state
> on can_attach() failure") puts the common error cleanup in
> cpuset_can_attach().  The 6.1.y backport instead placed that hunk at
> cpuset_can_fork()'s similarly named out_unlock label, while removing
> cpuset_can_attach()'s two existing targeted resets.
> 
> If cpuset_can_attach() fails after accounting a SCHED_DEADLINE task,
> cgroup_migrate_execute() does not call cpuset_cancel_attach() for the
> failing subsystem.  The temporary migration fields remain set, and a
> later successful migration can consume the stale state and corrupt
> deadline-task and pending-bandwidth accounting.
> 
> Move the reset to cpuset_can_attach()'s common error exit.  It is not
> needed in cpuset_can_fork(), which never accumulates migration DL state.
> 
> Fixes: f8a8358832f3 ("cgroup/cpuset: Reset DL migration state on can_attach() failure")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Applies to Linux 6.1.186 and 6.1.187-rc1.
> 
> A controlled QEMU A/B on 6.1.186 forced an attach error after accounting a
> real SCHED_DEADLINE task.  The affected kernel returned with
> nr_migrate_dl_tasks=1 and sum_migrate_dl_bw=104857; both fields were zero
> with this patch.
> 
> The equivalent 6.6.y correction is submitted separately.
> 
>  kernel/cgroup/cpuset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 681b52f6aae5b..7123bb020a242 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2600,6 +2600,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	 */
>  	cs->attach_in_progress++;
>  out_unlock:
> +	if (ret)
> +		reset_migrate_dl_data(cs);
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }
> @@ -3405,8 +3407,6 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
>  	cs->attach_in_progress++;
>  
>  out_unlock:
> -	if (ret)
> -		reset_migrate_dl_data(cs);
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }

Acked-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
