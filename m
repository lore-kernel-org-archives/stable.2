Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794029387;
	b=hNRpL+Gz36Jcff+vk7BKAGkbGxSkWnigLI2ZgJcNkH5HH7OMaGzBRgyq6KVZ2OIJIlOx
	 1xePYx49utDwrOwYx2r6mhjkrk0ZX/e3eabRPe7+E49rkFRN0EWqt4otftaRrIEmhN3Lq
	 Y1XP0yZKTsOR+f0fxFPGEdLE19AcZsFuSvo+MvV8GlZxoLk54dHzOBsj7AmK2dISdu3ib
	 2ymATlJPPKS15zliAmN9gNYl8Vj/bpCecl6TNHGCL5Q2XPN8rWQexWiDoQ8VEThYHLnH4
	 XYXQygkko2cCUV0QhLw089jupdMvJFR4RKUC0e9rl9ZWOCjUdRnpitaiEzRcfu/VWXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794029387;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=mld7kjkRbHaOrbf5kuHU3Y7anGgqjs03ezIpptqfNZ8=;
	b=4ihvd5raynej2gfUqrNerxywVKm5Vv2d+0Utktq2Rbf7gppltZnksQQc9a7u4AQeKRc2
	 8n6m2o/9VIE7sb9LpHfJWoUS5toR8LCyCGkm0KTCFVa4MoDOX28wdw1V4lasGx/4aqcA8
	 skZKBwp+pqDzAaobLyhbyx3PCwTGi2Aw0eILM0ZkI/uo8/7WA9pdZNobKz7ZCJSo+1aBR
	 NUzN8AYhGBUrPVf/26sPys/yFsZbIT17+CXG4EXIuWU1P8hieCrHKbp1SpJcr3rCiE4k1
	 lm4UYwlBFJrFvivjGPquPqsPVwL6DIwntoiLYM98cteFvkqNrAka35HwT9JGNxzcoHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Qn9Sm9By;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE225606D81E;
	Sat,  7 Nov 2026 05:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE225606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Qn9Sm9By
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 92ECA160297;
	Sat,  7 Nov 2026 05:29:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D5BB820028;
	Sat,  7 Nov 2026 05:29:29 +0000 (UTC)
Date: Sat, 7 Nov 2026 00:29:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
Message-ID: <20261107002927.3cbad7ff@fedora>
In-Reply-To: <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
	<20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D5BB820028
X-Stat-Signature: gfqbz1cxxp9kkah8phjo3oydi9owe8xk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lmIEtPfC8g+PJJzjbhI1/k4URfSupTxc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mld7kjkRbHaOrbf5kuHU3Y7anGgqjs03ezIpptqfNZ8=; b=Qn9Sm9By+8LQ1gl5vPbqzh1am/KGiw4g9XC4J8hRGZhtBhrgi8a6uAlAKWEHY2GTuz+ecmsb8uFLijexcA4tZ6XoHLX1Vf1yzQuRDeTWvRh5f5Od68/TQxlkcHTzYe0kqvudI8+oFgRozN19sP+ne+bOl55N2xB2jCS4btTW1RA=
X-HE-Tag: 1794029369-923082
X-HE-Meta: U2FsdGVkX19jmckBHz2NQ7nIP+uMgyu/7nZb8Opx/+1rtGvWri2KbF8ZAyg6tQe9tq1pvpMN+gEJvU4gM9Uw0hl5zkfVnFXwnuLgXQ1dcEcInCOfY5J48Jhc2JdWWPTk5RPjV6szp0+TTQRGxKpacCSd7vQqSuRyCiZvxybkIlYB7I1NJQqpBpWbRjpn6xnAVDQ0QjbxZrmEm0BhUHs0HlGPGZKIfbzLQL1t+dmFxfQ30QjJYKo3xydd5su4jEqNLBu+UO8hL2dfbcg3SnXzaou92Pl6tnvkFVm3J1Zg0z4TdBH5eKxJyPFC31xrlH9RsgMCNwrogfk5+ye7fsQFLWy2RUEcJk+lg6H3UsTEHurfFJmiZmdjGO6tohwRjHJAVu9MyxsXKtyQxVcGL/tsmTigDbXzkUUs7IgHJXrt/lxhlk/eVntnoRJQvXLLuoEaZIK+F7e3O5ZjymGy76InyQ==

On Fri,  6 Nov 2026 18:59:27 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The top waiter of an rt_mutex spins while the owner runs,
> rtmutex_spin_on_owner(), and does not stop when it is woken: its timeout
> and a signal find it running, set it TASK_RUNNING, and the spin goes on
> until the owner leaves its CPU or the waiter's own CPU has to
> reschedule. A PI futex owner is a user task that may run as long as it
> likes. On v7.4-rc1, in 8-CPU VMs, behind an owner spinning in userspace,
> a 1ms pthread_mutex_timedlock() returns ETIMEDOUT 126ms to 631ms late on
> average, 1.4s at most, a SIGUSR1 is handled up to 1.9s late, and a
> waiter killed with SIGKILL is reaped 0.5s late on average. With
> PREEMPT_RT the wound of a ww_mutex is missed the same way: two contexts
> in an ABBA on two CPUs at SCHED_FIFO spin on each other, and the older
> one gets its second lock after 96ms on average, 0.95s at most.
> 

The above is very verbose. Are you starting to use AI? ;-)

> Stop spinning once the waiter is woken, where the sleep the spin stands
> in for would end: rt_mutex_slowlock_block() then sees the timeout, the
> signal or the wound, as after schedule(). An rtlock waiter is woken out
> of TASK_RTLOCK_WAIT by the lock handover alone, and spins as before.

OK, because its state is set to TASK_RUNNING the schedule_rtlock() will
simply return.

> 
> With this patch the 1ms waits end after 1.01ms on average, a signal is
> handled within 0.3ms (1.4ms with PREEMPT_RT), and the ww_mutex ABBA
> resolves in 12us to 33us; a contended PI mutex keeps its throughput.
> The futex_lock_pi_inherit and test-ww_mutex cases added later in this
> series catch both.
> 
> Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
> Cc: stable@vger.kernel.org
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

So the task enters here with its state non-running, even for
rt_spin_locks, and you break out of the spin if something woke it up.
Breaking out of the spin with the state as TASK_RUNNING just makes it
reanalyze the situation and for rt_spin_locks it will put itself back
to RTLOCK_WAIT and spin again, if the owner hasn't left the CPU.

Makes sense.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


>  		    !data_race(rt_mutex_waiter_is_top_waiter(lock, waiter))) {
>  			res = false;
>  			break;

