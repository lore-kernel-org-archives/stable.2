Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841918;
	b=ZcEtbfYfQ00Cjp3O2kGHngNxfcuSuQbsyOd9mWNlXk1xBA6xN2d9FLx2yYvR7KQ/h3ag
	 F4PgilueNhq920cT5OxbHn31klDigN3KBQfS9f9EdHK5tlTr2gsR4TvISsNCMk4ZhR4dK
	 eYvZSJavFpz5l7uKrTlf9+AMYsi9JvFbw3AKIGhYOCz6i97vghKZnuJk140M++LVdqP3P
	 SGdtjbF5ezMiHlRoAtz7FKpZzKzeKPAV8NmpBEukr9tXpbXgop+zgBaTO38JonlawB3O8
	 xZ9FNJn0u7hnkZo2/rI0M2UxkYtHOV21cbxFExHICXSucRFRvf2B12uA8ge7b+fx4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841918;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VlX7WUHLBZ/OUMWzIsDa5b5t8PdZohitloqSDlm9m9Q=;
	b=fWYEpChfIANTsHv/Fk1KblJIX2tVmrliRYZZ+mFf91zd8eRqAwbY6T9dZ4wlRSLaIGHo
	 p5w2uE0OCcm8k38oq2Md2w1+iw+Hgkq8I1yzNh7WzHYPlbSX1HrCtq2giO/WiM/ioZHA/
	 JHYLyhzKIjjRoh6+I2NqX7UW1+Qvyy+zqjjECFW4XLWH42ZdKHYsnelYWDi9KiLS1MPwO
	 bjVqtFClr2GTXcxuK71WbBWUwgSu1uBRpSsANcuM6XcJNAEaTkQn8vpxhVTZMleojmvr0
	 NSw9G5mOvHY0Q8oExssUZFFyEu7Y9wqRdNkHzMcL9Nkbnl9BDBJ7vNCG01/2IcUhGAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=li7wfgxY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xwiyMdKG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4140606A32F;
	Mon, 16 Nov 2026 15:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4140606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=li7wfgxY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xwiyMdKG
Date: Mon, 16 Nov 2026 16:11:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794841914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX7WUHLBZ/OUMWzIsDa5b5t8PdZohitloqSDlm9m9Q=;
	b=li7wfgxYK8Uai28nPco5e2ZWbk1YX/5fvms4VtDUZIXhhu35p6Z6dkhpwMupz2n6X2ANmg
	Opl3aGnnI8teNd1DmajnwVkr3/xOPQxfAj1l2LDfTh5qe6Mjr6JiSF+oFAUK/mkuxN+mfu
	TmATvjOe1JMlTqoaq6QzSYud+e9IX5LxNCwAoX78fevT1hl8ROI4h5bAO4RD80FkR9I1IK
	slwDOIf1UnBqz1x0d+pWPFG8JSHgSRkeIC6joI9tj4+IE397Vca/vGwwokLli79kmcjuF0
	KxZaCQTx40mjBBk5jRWaDXbxSNYWzUK0geDZ9DXAEj0LXyzz+cWvgcwMrsa3yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794841914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX7WUHLBZ/OUMWzIsDa5b5t8PdZohitloqSDlm9m9Q=;
	b=xwiyMdKGlSp+YZdYqJrIN7cPphQ1SWFMH75o/AaoPRELOj7qzPA7DU0Uk61oKijXTgiEJ9
	osVOCssW4EfDdfCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/5] locking/rtmutex: Clone the sort keys in
 rt_mutex_enqueue_pi()
Message-ID: <20261116151152.vDbnofKe@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-4-mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108141347.1525532-4-mathieu.desnoyers@efficios.com>

On 2026-11-08 09:13:45 [-0500], Mathieu Desnoyers wrote:
> An rt_mutex waiter has two copies of its sort keys. waiter->tree sorts
> the waiters of its lock. waiter->pi_tree sorts the pi_waiters of the
> lock owner. Only the top waiter of each lock is in pi_waiters.
> 
> When the priority of a waiter changes, the chain walk updates
> waiter->tree. It copies waiter->tree to waiter->pi_tree for the top
> waiter only. A waiter that is not the top waiter keeps its old pi_tree
> keys.
> 
> Such a waiter can become the top waiter later. remove_waiter() does this
> when the top waiter leaves. try_to_take_rt_mutex() does it when the lock
> changes owner. Both put the new top waiter in pi_waiters without a new
> copy. So pi_waiters sorts it by a priority it no longer has. The owner
> then inherits from the wrong waiter, at that waiter's current priority.
> 
> In this example, O is the owner, a SCHED_OTHER task. L1 and L2 are two
> rt_mutexes. W1, W2 and W3 are waiters. Their SCHED_FIFO priority is
> under their name. T is any other task. It changes the priority of W2:
> 
>   T                         O                W1                            W2           W3
>                                              FIFO 80                       FIFO 70      FIFO 50
> 
>                             locks L1, L2
>                                                                                         blocks on L2
>                                              blocks on L1 (timed)
>                                                                            blocks on L1
>   sched_setscheduler(W2)
>     W2 now at FIFO 10
>     rt_mutex_adjust_pi(W2)
>       W2->tree: FIFO 10
>       W2 not top: no copy
>       W2->pi_tree: FIFO 70
>                                              <timeout>
>                                              remove_waiter()
>                                                rt_mutex_enqueue_pi(O, W2)
>                                                  W2 sorted as FIFO 70,
>                                                  ahead of W3
>                                                rt_mutex_adjust_prio(O)
>                                                  O inherits W2's FIFO 10
>                             runs at FIFO 10                                             still waits
> 
> The owner runs at SCHED_FIFO 10 while a SCHED_FIFO 50 task waits for
> it. This needs no race. Each step can come long after the one before.
> 
> Fix this by copying the keys in rt_mutex_enqueue_pi(). All callers hold
> the wait_lock and the owner's pi_lock, as waiter_clone_prio() requires.
> Remove the three copies the callers made.
> 
> With this patch, the owner runs at SCHED_FIFO 50. The
> futex_lock_pi_inherit selftest added later in this series tests this
> case (promoted_waiter).
> 
> Fixes: f7853c342418 ("locking/rtmutex: Fix task->pi_waiters integrity")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

For this case, we miss one waiter_clone_prio() in remove_waiter(). Given
how this is used, I don't see nothing wrong with moving before it is
actually used. It might otherwise race in task_blocks_on_rt_mutex()
since the pi-lock is dropped. I somehow assumed the adjust-prio will fix
this.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
