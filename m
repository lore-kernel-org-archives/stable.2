Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236796;
	b=XXRtZ8xEgyIGTAgXsQJ8+3i4CGYtjK0u/zg5EgqiB+T8KmV3Uy85vALjy+ShuUBvf8X/
	 HRHNdROVAbK9qXoU3wN387DytLbNsdYs37b5oa+pxv6zONzXGNaA16ZPxXVXL9RrF6zKm
	 8KhlXMIsF4MwXP2aq/V8+Jx0VhfpWqrF1KKsludjachb82i21bn21t535y5FC5s1QxWds
	 N4UCeZhpIW7utYKGxWu+4bn4kx5naqtRwEgcjYZ0MX46340Dt1o+ofKxKvQ6jV0nTROkn
	 19Q9ghAoommRcmuzufnYIb14QcyHOSMsKF3aSkjuqc4PAEQy911ioKBsbhgJmHaCZcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236796;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
	b=XM5Ox79p0jzvOy4eMnKzmt6UdTUG9hMOX+kc+tXrrJ31wXRSWRiQBUd8wy7GQICV9JPI
	 XDEzUZ7z8Ry3bMLcDtrHnspzJ00hpugrLsloNMBsuxegQsRUCv16B0kAmeeYHjIwqKgmO
	 ht0KCSNqMveNFR4HUfl9T9NGCoPzCjuD9zhgsM5rdOY8+GjNttv+2bQZv4+iwqgFbY5dp
	 HM/PxQus/ifulrFKwMD3Lmk0v/QG6YK4MLidlZAqlW34GdLyh10m+1nE7zqt4qddItycK
	 rQCHcSSYBCQ2gSdLj9AA6IxwJpmB0HMmcxP66pBRJrFYzMmO4BGIdls2cLWfGz6OBxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZtTOxdY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FdOXzUdH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA2606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42AA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZtTOxdY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FdOXzUdH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794236795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
	b=CZtTOxdYiOV06/b4G9u/MJS1T/tHIenPkm4Tye5dseKzbgTce6+wQKECgWb4H0RmG347ZN
	0+QZIRkyslHJemUDm5tbRxNnzXPa9YjyNCYwV7uXxk9BjPd5ifS4Sh4NC0m44RUcyzVk9V
	LirEs6UCZcoV6J7nX0TDqAU3dhTjrE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-gb6PTVUJPuOy28BUObrcog-1; Mon, 09 Nov 2026 10:06:34 -0500
X-MC-Unique: gb6PTVUJPuOy28BUObrcog-1
X-Mimecast-MFC-AGG-ID: gb6PTVUJPuOy28BUObrcog_1794236793
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4925ef75fc4so877201f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794236793; x=1794841593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
        b=FdOXzUdHTQ6m3VUupSZeds4Qvuoru5NQq+B1VZI4v8UFPfBc2l1Rf427Es0mpPgGJk
         hU5ltrbUU03C/TwDtePz/2TxtmQcnxpylNQF9yAI/bjaJJ83tOkj+Hhso8ZT0/qxhnGT
         eTLTuldmOzmlD65WMbhJReUkPa5q1Pnl7iKQ+L8uQjRbnrOq+fAvLxvg49JRpzRvgUx2
         EcTjLS/vuqUS+9vxXxE37fU+zLYERcoqPD211UtMwlUdMnnjU6x6KpQ8rCjLfNqxQYUO
         AFiwXeZ/YqRcT+xUmXzUzgXlSEtUfNJ1etw1JYFpc20qdlJJFR8KvV8Nt4Cbed0xhjhB
         pn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236793; x=1794841593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
        b=kCjR2GeFU5EyhcXeafCvtWypCytmvEY7UB6+ObKP0FIgd4FLOZLBQIwZ1GbkcFyMdD
         ECDom10/PmqW8EA2OiwUdAT32RPfvkDh6+9Qj/oEpAQXxTXGfcT++9g5GAH47608RAtS
         K/yL9Kb0KxQPyWsYVMhTJf89h9fvnMYfgx9ZER4lCRLT2PLA04ykiViMoXf9lUC9/kr4
         8Qe7EII8cCODE7WAxbf/Jd3uVE3QcswSG59XZeWcU+LkuH5rUKQPvcYIT9/xpRViOQPV
         D9cbXIY2gbvhzLmEUnDUvGB27E+qiCoE2eblYYJoM64+MkL+hXQNTzrn8mcSdkaXmRo0
         LwOA==
X-Forwarded-Encrypted: i=1; AL+hErEIhzrLHRET51QankJo0iG8MFHfs24+bgGUmmkO9BdECASWuy2jja0VSXoqfyuz3vgTUQhxmVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FYuhiJExrDmsaKHRQfRkvzgMIeK9vrRqyHhYh7fCz3aDrEUwp
	y4HSBYL/cDDlsfrZJBnMzw42MyhR2su7vkcdNB1HKpBBV2h523jcKcNzMEZi+fHDMSTgsdyG2Yi
	fRJuj63B7/4BPpxT7qJb4uTaH7U47oYv8m0CPbnwiaXK8SO3Nx/FNZTaGZQ==
X-Gm-Gg: AYBFou0auov47Y8B5R0+r1Hpl82obIWUoBE8DYrfO3Dh/wswq0LvexuTsV9vMfBuoik
	ZoBAjkYlu9cq2+xCWHHtvzHrZX59hzTtf3eKtr9yWt9WV64Tbv58+4bhuqGlJhcxQDMtX9bVUQT
	V8+ZOHSxO578sVZxvKibDiueJyJcAQ4sp/yUjfnfY6cKTlfN9yNmDVxjnZWUVxTbmz8/RcB+VTF
	MCGAEwfgveMxYm6VIlqQxZLeW5gEZXeSU1ZY4Iaccxcp42+Gjbd4DV18LmnqhQpCL/4Tg7Tepzn
	FkcGl2kvIuOGoculLNHtDY6OycxLnLgp3BYrxDcaj2jFfP52/OGqaD+70JCQV5zx7v+ZAVs88Vl
	1pSWX/Oxdz3A3vIEY00x3j/zzIRCBn0AbykkBZJzVF4+fsdgQtnfOLQRlK+sHfu8cU8tpt8ue7e
	FeDw==
X-Received: by 2002:a05:6000:2212:b0:48e:5071:420 with SMTP id ffacd0b85a97d-49586743510mr7911116f8f.2.1794236792629;
        Mon, 09 Nov 2026 07:06:32 -0800 (PST)
X-Received: by 2002:a05:6000:2212:b0:48e:5071:420 with SMTP id ffacd0b85a97d-49586743510mr7911029f8f.2.1794236792118;
        Mon, 09 Nov 2026 07:06:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm10850687f8f.47.2026.11.09.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:06:30 -0800 (PST)
Date: Mon, 9 Nov 2026 16:06:28 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 06/29] sched: Take cpuset_mutex for a deadline policy
 change only with pi
Message-ID: <avHhdDqeMpe7wAay@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-7-mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108185406.1549770-7-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> __sched_setscheduler() takes cpuset_mutex for a change that involves
> SCHED_DEADLINE. On success, it releases it only when pi is set.
> normalize_rt_tasks(), for sysrq-n, is the one caller with pi unset. It
> runs under read_lock(&tasklist_lock). So sysrq-n takes the mutex in
> atomic context for a deadline task, and never releases it. Every later
> change that involves SCHED_DEADLINE then blocks forever.
> 
> Commit 710da3c8ea7d ("sched/core: Prevent race condition between cpuset
> and __sched_setscheduler()") took the cpuset lock only when pi is set.
> normalize_rt_tasks() cannot take it under tasklist_lock. Its changelog
> accepts this: after sysrq-n, the deadline guarantees are gone anyway.
> Commit 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex") then took
> the mutex only for deadline tasks. It replaced the pi test by a policy
> test, and left the release under pi.
> 
> Fix this by taking the mutex for a deadline change only when pi is
> set.
> 
> The policy test reads p->policy before the runqueue lock. It is checked
> again under the lock only when the caller gave no policy. Otherwise,
> the task can enter SCHED_DEADLINE in between. The call then takes it
> out of the class without the mutex. A rebuild of the root domain
> accounting could run at the same time. So check again under the
> runqueue lock, and retry with the mutex.
> 
> sysrq-n on v7.4-rc1, with a deadline task and lockdep on:
> 
>   sysrq: Nice All RT Tasks
>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4356, name: deadline_switch
>   locks held by deadline_switch/4356: 4, last CPU#3:
>    ...
>    #3: ffffffff83006098 (tasklist_lock){.+.+}-{3:3}, at: normalize_rt_tasks+0x34/0x150
> 
> A sched_setattr(SCHED_DEADLINE) after it never returned, in 2 VMs of 2.
> The sysrq_normalize case of deadline_switch_test, added later in this
> series, tests this with DEADLINE_TEST_SYSRQ=1. It passes with this
> series.
> 
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

The change in itself makes sense to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

I only have cosmetic/minor comments below.

>  kernel/sched/syscalls.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 56ce2352e89e..0bc778c12af4 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -561,9 +561,11 @@ int __sched_setscheduler(struct task_struct *p,
>  
>  	/*
>  	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
> -	 * information.
> +	 * information. Do not take cpuset_mutex when pi is unset: the
> +	 * caller is normalize_rt_tasks(), which holds tasklist_lock and
> +	 * cannot sleep.
>  	 */
> -	if (dl_policy(policy) || dl_policy(p->policy)) {
> +	if (pi && (dl_policy(policy) || dl_policy(p->policy))) {
>  		cpuset_locked = true;
>  		cpuset_lock();
>  	}
> @@ -654,6 +656,15 @@ int __sched_setscheduler(struct task_struct *p,
>  		goto recheck;
>  	}
>  
> +	/*
> +	 * The task entered SCHED_DEADLINE after the unlocked read of its
> +	 * policy above, so cpuset_mutex was not taken. Retry with it.
> +	 */
> +	if (pi && !cpuset_locked && task_has_dl_policy(p)) {
> +		task_rq_unlock(rq, p, &rf);
> +		goto recheck;
> +	}
> +

For a cursory read this check and the one above look similar. Can we
maybe have more descriptive comments for them, e.g., for the first

 /*
  * The caller gave no policy (SETPARAM_POLICY): the request was
  * derived from an unlocked read of p->policy above. If the task
  * changed policy since, re-derive the request from scratch, and
  * release cpuset_mutex: the re-derived request re-decides whether
  * it is needed.
  */

and, for the second, that this patch adds

 /*
  * The caller gave an explicit policy, so the request needs no
  * re-derivation (oldpolicy is -1 above). But the decision to
  * take cpuset_mutex used the same unlocked read: the task
  * entered SCHED_DEADLINE since, and the change below would take
  * it out of the class. Retry to take the mutex.
  */

Also, maybe add an unlikely() to the second check as well?

Thanks,
Juri

