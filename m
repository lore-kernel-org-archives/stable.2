Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049029;
	b=vXSiPahPXUuPsK9PgM+P3furhzgxqnlF2oUrWk5oE11IAf3BeaTx+iA2QY/e7nOAD9Qk
	 yx8+WZVBpOuCEk9YDp3SKMdCMs6gwjVA+8xyp8KtkXchaE2PUxE+YyPLZMeG7jyewre+H
	 ny90Hp0WGnZawyyByJ6wBpEyjxxOhmJcQPk0UvHctExKQxAmAl7uC8BuR1KKiayoCYd1Q
	 H90Is/eiy4d2ipDSGKxJu0D1y8K8KD3xyj2XZdlR269Z/xZZXXV2TbuvO8OL68nnamJEN
	 1F8DNnhOhhCqCAc5as9pHxjKxgbC0eMNWe1rWNL8QcLxXVBJUXwUTYPHRV5szx9t3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049029;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JdwdSsgCSRZo7XC3ucq5IHGTcHkTS0sHmKyRiIdO+98=;
	b=FyWadQpY8AdWsas6XtMDRHR74QdK7V/DMc8nVPa76QLrGajXnp4DAYQZuddECttugVLD
	 zzfijqiMn0s5+6VNza+D4+RLdPy8nW9SB5S7+iiqNtORSwKf24W6oftiXczI3dvc33tu8
	 /ozJehAipVLmLkqzX/EX0l4ptAV0MYp2C5aKd7YqbBKQ+tntdefm7SyZDDw4JiFUgEXX3
	 KWo+7GRC9PoHCddJO0Yv5C3zsqwjtTnXHqSJ5anywXbS3bGkZEdOG46I9DHeZPyMXZIfr
	 GvnoXjsZAa6ujvHBEDGwm2NTaJ+8cJ8Ryi7UOX5S6Dde4+HcNa+u0iF89ufrC6qt2yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i3orLZz+;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1A606A32C;
	Sat,  7 Nov 2026 10:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA1A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i3orLZz+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JdwdSsgCSRZo7XC3ucq5IHGTcHkTS0sHmKyRiIdO+98=; b=i3orLZz+oxIMB9zxIuJhvl5HX+
	qRbdwgGb2ToUtKRkoRdmpfyceggoxLYexALNnOJYjDSohCuWePEW4EIWgSbpeLbIeNKAHvmjjndv/
	akakHjCExX/uijFm6fwkY8cRAvSnoRbZWxo0u7XmCpTLg30zMhkrIuMGL213fGm7e1GLENCuwq6cH
	AdHSjikigHShJTKnNhDSAoiloRn36rymX3iKTEhI5ydbqIS6XrUzRyZLRHuSwgCurjZDAzNDlqkDW
	u1/gU0PzlTGAqB0Qf1FIoGmD/Zx+D46qJWTP+J8MH3SGtGeK7zqRpcZI7GnpijE1xLKOZwHnB8Efr
	+ZpXg4Dw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe6a-0000000GtoW-48ZW;
	Sat, 07 Nov 2026 10:57:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B6CB300339; Sat, 07 Nov 2026 11:57:04 +0100 (CET)
Date: Sat, 7 Nov 2026 11:57:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: tglx@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
	will@kernel.org, boqun@kernel.org, longman@redhat.com,
	rostedt@goodmis.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/5] locking/rtmutex: Clone a waiter's sort keys as it
 enters pi_waiters
Message-ID: <20261107105704.GB2668564@noisy.programming.kicks-ass.net>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-4-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261106235931.1478800-4-mathieu.desnoyers@efficios.com>

On Fri, Nov 06, 2026 at 06:59:29PM -0500, Mathieu Desnoyers wrote:

snip unreadable changelog

> Fixes: f7853c342418 ("locking/rtmutex: Fix task->pi_waiters integrity")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/locking/rtmutex.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 323973be2074..e89f0f0e604b 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -512,11 +512,19 @@ static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_
>  	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
>  }
>  
> +/*
> + * Enqueue @waiter in the pi_waiters of @task, its lock's owner, with the
> + * sort keys of its lock tree copy, current under the wait_lock held here:
> + * the chain walk updates the tree copy of a waiter that is not the top
> + * waiter of its lock, and does not clone it, so a copy cloned before would
> + * enter @task's pi_waiters with the keys of a priority it no longer has.
> + */

Oh gawd, Mathieu, can you please tell your AI thing to never write a
Changelog or comment? This is again unreadable soup.

>  static __always_inline void
>  rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
>  {
>  	lockdep_assert_held(&task->pi_lock);
>  
> +	waiter_clone_prio(waiter, task);
>  	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
>  }
>  
> @@ -1005,7 +1013,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
>  		 * and adjust the priority of the owner.
>  		 */
>  		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
> -		waiter_clone_prio(waiter, task);
>  		rt_mutex_enqueue_pi(task, waiter);
>  		rt_mutex_adjust_prio(lock, task);
>  
> @@ -1022,7 +1029,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
>  		 */
>  		rt_mutex_dequeue_pi(task, waiter);
>  		waiter = rt_mutex_top_waiter(lock);
> -		waiter_clone_prio(waiter, task);
>  		rt_mutex_enqueue_pi(task, waiter);
>  		rt_mutex_adjust_prio(lock, task);
>  	} else {
> @@ -1243,7 +1249,6 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>  	waiter->task = task;
>  	waiter->lock = lock;
>  	waiter_update_prio(waiter, task);
> -	waiter_clone_prio(waiter, task);

Reverse engineering the problem leads me to think this is the problem
spot. Because this is the one site that is not immediately followed by
rt_mutex_enqueue_pi().

I'm thinking there's race due to dropping pi_lock between this copy and
the subsequent enqueue?

>  
>  	/* Get the top priority waiter on the lock */
>  	if (rt_mutex_has_waiters(lock))
> -- 
> 2.47.3
> 
