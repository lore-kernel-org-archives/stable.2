Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830796;
	b=d/Fg6d9+V4LqSE5WwtBBgtfjJcUl44fno3crXgwfooOSdEbCzTICoI8WmFYMem0EsMPq
	 hq3lG5JPB3CC3i+5cyveHLHKzI1Hn/0euTqYWeEsZrXpiYlZR10R700BzhsL+GYD8+cOP
	 C5OkwMDzSc1YhB1BQFBeFFMaBfdEmcWfPgPgrjmPLJTzMAKY3i/rTj4stoTzglDFiUj+a
	 2M0i+wqfqtxsOy4Yso7PerP7X33qcSUqbvt9xwKO2RGHv9t3apZVf90x0DJq77rbD4+vE
	 mIGGzx96aldGlDJBrimL5t7NSe52MDdHXbmGbhZVj4pBHbkdlFHXDluqCJzEk3vUqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830796;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=T4cXPrqj81Ucb72VXdIFNTaxp/wk0OtZR7R5VTuYxYY=;
	b=uOTgVD4EDa1OhsUJBsgvntyyUwFXqpQ9IxSSaXR9JAMNqvLpftM+vfXXwIqFLh5+K+uW
	 6oLbp+5wLgfXkW0HISQ4d6MSRLU1JlcIMtwUMFOyfJTgPXBfyiu/tw4uHJzEcl3yEynmo
	 sJ7z+NJPrEf0jPeTAKvst0bbDtkKOmNRrIbOQdbaQE1V7IclJG3Prow8bcJRWwtXcMBrv
	 Ufpl8tfcUHgpx0WAwi//hKHT/w6zk/mOgKkERl4bpt0z18mgOMqwTpqdibye2Tv5jZIhT
	 4dPo6NUnC/MHJk1INUjqJ+Bf8g68GiowhvDLwXeijMFLrDG8y4VFXG3f0WxvrhXLx9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3m+OjYrW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wNcfRNKZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DD606A323;
	Mon, 16 Nov 2026 12:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3m+OjYrW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wNcfRNKZ
Date: Mon, 16 Nov 2026 13:06:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794830788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4cXPrqj81Ucb72VXdIFNTaxp/wk0OtZR7R5VTuYxYY=;
	b=3m+OjYrWft4KY16w8GQHMzH4MH1TNiMvwlhGajt1rlWXUAQUXB2jxK9Iw7yZmynogVvWFv
	6mIkylsd0pcj+tuf2T1DCHREJS0iz/wGVnum0W90eetLxQX2G2SBlFzamTxViFttO5aIux
	I0KNA4x9cJg7dqk2oTW7GQClKjg9P+eU9bX1bMNLeOP66DSazWqxq2naiSZxTvRjx8iLBt
	wWNiRfl3SRJjjCzE5U7gDHH5LY0ncboSiEXaUJEuwiZ/pS/RRsR37POMkCF70ae+QqyfYj
	G/ku27UmX9xAuh/aKGDpDES3FO/goJP28GZAEBCoFUOt3u4GxiRjnL0ez5m5DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794830788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4cXPrqj81Ucb72VXdIFNTaxp/wk0OtZR7R5VTuYxYY=;
	b=wNcfRNKZRbytuOW16rs0WkPZyl4vs/fayRuD3CCR5g/KeEbx7xitTbzR8Txed5eRM8ll+H
	NFt9v7ViUYkst0Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
Message-ID: <20261116120626.JVHxeSTu@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>

On 2026-11-08 09:13:43 [-0500], Mathieu Desnoyers wrote:
> Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/locking/rtmutex.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 5a9534c715b8..323973be2074 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1516,9 +1516,13 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>  		 *  - current is not longer the top waiter
>  		 *  - current is requested to reschedule (redundant
>  		 *    for CONFIG_PREEMPT_RCU=y)
> +		 *  - current is woken, by its timeout, a signal or
> +		 *    whatever else would end the sleep the spin
> +		 *    stands in for
>  		 *  - the VCPU on which owner runs is preempted
>  		 */
>  		if (!owner_on_cpu(owner) || need_resched() ||
> +		    task_is_running(current) ||

Wouldn't it make sense to return true in this case so it can re-evaluate
the situation for timeout/ signal rather than visit the scheduler for no
reason?
Also, wouldn't it make sense to restrict this to
rt_mutex_slowlock_block() (and maybe there to the !TASK_UNINTERRUPTIBLE
case but this might result in too much code) rather than have it also
available rtlock_slowlock_locked() where it makes no difference?
That file is included so having rtlock_slowlock_locked() pass an
argument would remove that branch from code generation.

>  		    !data_race(rt_mutex_waiter_is_top_waiter(lock, waiter))) {
>  			res = false;
>  			break;

Sebastian
