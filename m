Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011559;
	b=aRKFlGO1SWNw7vTxIVQydQRA29kxgEcPSziQTdRPO/wtLz5l6FKG5fd015m4xOe1luEu
	 xuFBE6cedvWOsUWueUvhYrgeh61ByRqPYyK0CNEvrrX5Zet2DxC7CtEdSrVD+R8Y1y45D
	 8HHcVzE6K9krO7gSLd2HuPU2ua+xUgLJeWS0L8LJfU1twDlIVTgUq+4BgkhnI0+qPRvVH
	 5LRAwsVHkCOIxLzq4oklFnC5VqFPokbjngUrP8fchTKkQ6opK8EIAD/eavhaeIE24tHqb
	 20o9BSSqlcoV+n1ybF8PZhW2mc4eQ8mFmBhSjOS3eKEUk/YfiF+svzWNycA1eLVEz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011559;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zbdD5k4B9DfkzEZ4l0LezO5e3pMM3lFI5PIFhVZWqIA=;
	b=d9Q7bfCJrAQqCQLC+D6DFphJ86JmsYFERym7FY3+AoSGQGUBvnRJ4ZwIjuNOXg+aW2B5
	 /1rD1KLYjIPJKK9GRly7E/5BvYkXi2U4YctKdprgWSPF2q9fV/xoAxXe6BlGnPVIZ5tKt
	 a+qJgjXPmlvjBAwUdjBIKsC4infFtJyAC5N23+vvOE/0+xtvuNVN+tRkbEKh/BjfVNZly
	 bdQ3zrf8Prf8qFoc/ctF5t3+RTjkQ+shJDz2TdT+yw6tQeQXblO/6S5NbjLl9/9eYn8zY
	 ljG5uB+1332TaiC3joT2njfvV0u1H99gEQ3OmIbh8Ser7xGAA/3fLYbhN9e53WFEAlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HaPB73ae;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="J/+PeD2K";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BD60A2607;
	Wed, 18 Nov 2026 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67BD60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HaPB73ae;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=J/+PeD2K
Date: Wed, 18 Nov 2026 15:19:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795011554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbdD5k4B9DfkzEZ4l0LezO5e3pMM3lFI5PIFhVZWqIA=;
	b=HaPB73aesmI5wih2mJ2wmV9PggxBZuH/BnpX3232vUPYDqJwtSvHqtd25ZGPVMcadA51oY
	jWD7IZxKpGSbbtbLVl87VozAp/380lZKWtRn5pWgH90Z/X64a7XJ+sH8CHvYNj9/uv0ZhK
	lYf64HImTAJNr+pGx7ZiPgkvqUUC6chXbpYJjYCSQHshrjkqVV18ljY6OvCa+p9jnOie39
	+MqDGwddK4XW4OfzPyQ/a05tjOzAtJ6toab+bak7DY/NqQnVNWhj3QaKOBuXMXni0AHc5l
	qM/tpcIOTvqaqVrMV0fcWlL4KqgiKQBiPIIWbO6rDxyDfTBYHCAqee1NHu4Rrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795011554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbdD5k4B9DfkzEZ4l0LezO5e3pMM3lFI5PIFhVZWqIA=;
	b=J/+PeD2KdqzHUWQI3j/Gbit3l8+so2t/F5vm0JiG8rycbto4YjC84Zb/iJPE2moWETo+Et
	iZmCUoRwY81kwqAQ==
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
Message-ID: <20261118141912.GnOg6YYM@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>
 <20261116120626.JVHxeSTu@linutronix.de>
 <83330898-b6de-469c-ac20-7367c1eb4f0e@efficios.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <83330898-b6de-469c-ac20-7367c1eb4f0e@efficios.com>

On 2026-11-16 13:36:39 [-0500], Mathieu Desnoyers wrote:
> Hi Sebastian,
Hi,

=E2=80=A6
> I kept the check for TASK_UNINTERRUPTIBLE on the rt_mutex side. A
> ww_mutex wound also wakes an uninterruptible waiter, and the ABBA case
> of patch 5 needs the spin to stop there.

Not sure what is related to. I don't see this in this patch.
TASK_UNINTERRUPTIBLE vs TASK_INTERRUPTIBLE would make a difference for
signals here.

=E2=80=A6
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Fri, 6 Nov 2026 13:56:54 -0500
> Subject: [PATCH] locking/rtmutex: Stop spinning on the owner when the wai=
ter
>  is woken
>=20
> The top waiter of an rt_mutex sets its sleep state. Then it spins in
> rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
> the waiter back to TASK_RUNNING. The spin loop does not check for this.
>=20
> The rtmutex_spin_on_owner() is just an optimization with the idea that
> if the owner is still running on a CPU, it will likely release it soon.
> If the owner gets preempted or schedules out on its own, the spinning
> will stop and the waiter will sleep. This came from PREEMPT_RT adaptive
> spinning for rt_spin_locks that allowed them to behave more like normal
> spin locks and speed up PREEMPT_RT performance.
>=20
> The problem is that when this was implemented for futex and normal
> mutexes it did not account for timeouts or other mechanisms where
> the owner releasing the lock wasn't the only way for the spinning
> task to exit the mutex acquire. The spinning currently does not
> account for anything else but the lock being released or the owner
> sleeping.
>=20
> The owner of a PI futex is a user task. It can run for a long time.
> With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
> returned up to 1.4s late in testing. The timeout signal or any signal
> to the waiter will not stop it from spinning, and the signal will be
> delayed until it exits the spin.
>=20
> With PREEMPT_RT, two contexts that take two ww_mutexes in opposite
> order spin on each other. The wound that resolves this wakes up the
> younger one, but it keeps spinning. Only something else that needs one
> of the two CPUs stops them. By default, the fair server does it after
> 950ms, to run SCHED_OTHER tasks.
>=20
> Luckily, when the spinning task needs to exit the mutex lock code, its
> state is set to TASK_RUNNING. By having the spin check the spinning
> task's state to see if it switches to running, it can exit the spin
> appropriately.
>=20
> On a wakeup, the spin returns true. The caller then takes the wait lock
> again and checks why it was woken, with no call to the scheduler. Only
> rt_mutex_slowlock_block() asks for the check. An rtlock waiter is made
> running by the lock handoff alone, and the handoff changes the owner,
> which already ends the spin. Sebastian Andrzej Siewior suggested both.

For my taste this is overly verbose. In the spirit of "ain't nobody got
time for that" what about

   rtmutex_spin_on_owner() does not abort spinning if the task state
   returns to TASK_RUNNING. This can happen if the task receives a signal
   or timeout. It will continue to spin on the lock as long as the owner is
   on the CPU and so delaying the processing of the signal or timeout
   condition.
  =20
   This affects PI futex users in general and ww_mutexes users on
   PREEMPT_RT.
  =20
   Stop spinning when the task state changes to TASK_RUNNING. Return true
   to let the caller check condition again instead going to the scheduler.
   Skip this in rtlock_slowlock_locked() which can not be interrupted and
   always needs to acquire the lock.
=20
> Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I agree with the change as-is so
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

but the text here is too verbose.

> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1510,6 +1511,13 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_=
base *lock,
>  		 * the rcu_read_lock() ensures the memory stays valid.
>  		 */
>  		barrier();
> +		/*
> +		 * Stop spinning when current is woken, for example by a
> +		 * timeout or a signal. Return true: the caller checks why,
> +		 * with no call to the scheduler.
> +		 */

		/* If became running, trylock again or abort (signal/
		 * timeout)
		 */

> +		if (check_wakeup && task_is_running(current))
> +			break;
>  		/*
>  		 * Stop spinning when:
>  		 *  - the lock owner has been scheduled out
> @@ -1890,7 +1899,12 @@ static void __sched rtlock_slowlock_locked(struct =
rt_mutex_base *lock,
>  			owner =3D NULL;
>  		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
> -		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner)) {
> +		/*
> +		 * Only the lock handoff makes an rtlock waiter running,
> +		 * and it changes the owner. Any other wakeup goes to
> +		 * saved_state. So the spin need not check for a wakeup.
> +		 */

I would drop this entirely. It says below that the check is for signal/
timeout which is something we don't have here. So I don't think this is
required.

> +		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner, false)) {
>  			lockevent_inc(rtlock_slow_sleep);
>  			schedule_rtlock();
>  		}

Sebastian
