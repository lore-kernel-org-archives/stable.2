Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012811;
	b=ErJ6fwKLnF5+LvqvGo+bn1RYtnGtEcHrl7CFGEJgBIosPcOZBHvZaA/kBVZgAblXPO70
	 RDRSwUgwkwJqCOdV/LOCf1XqfaGkW7grb2oblm6q8EPe59giNuoaiC9rMw2y9V8YgNWZX
	 iE7ApLDzv3dZzqvrVL3cm+30nYsJoiQBFzhUw2AxLHp34GeJFRyItfaZ3rdzDhcWXug53
	 SdYRASxeatczc1d4m1YMmn5Jf/8wO4KVwpuZhtTmaHFIl9F7esjWhRlhuwhuW7VdswPOM
	 f8vnqsG8v/PthqbV+eKCiSbp+C3QX5fiG9XF1CLCwXo8a0cVHalgdScPMHuXPnDB+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012811;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=o9zNTrCs5ck/1o3RCSKW2VT8r4JHp1JK8lZkVLfXYGM=;
	b=FxGpITM7f95gI1IZpRGteJ1bPTlopq/JmKF1O3aN9Z32ft6wE6EQ2Qpf7OEf5+ss8TKU
	 tclY+Xpiyds+lvCZzKF2eO5TlXPMIhZM1riJWtfPba551g+N+dOujI0wXerYY/P0FZJcD
	 6TcQ3S+NuJi3gIVu+yMKIkFVluZm8YWHdeSyvt3XCGwRMd78gAJXp30rzjDBhfUQsAA4g
	 QSa3wKkKi8tkYTxuQo6/Ax1WZO7g40uhtDdjmQYp+/yhZTeVPLgx+WD7UHqpFOEYLNk/n
	 rWLPABYybvQDqoipGkFbd88bAGkY9rV9ldobPF1MhUxzMUuFGU42HGG7a/7AEYXfsIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Hxw+3jK2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="z9dCV9/L";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F037606A32A;
	Wed, 18 Nov 2026 14:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F037606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Hxw+3jK2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z9dCV9/L
Date: Wed, 18 Nov 2026 15:40:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795012808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9zNTrCs5ck/1o3RCSKW2VT8r4JHp1JK8lZkVLfXYGM=;
	b=Hxw+3jK2/k2u2O3CKhECYZkMY5C1OWMxtlf2QBhY6TDkaiBTw/BnRslwUxpFzhIB1rghqZ
	WdaV6Uf9hkBrTfUT6WGqE/dBgr6kYlg4JiQP/B1PwvwdMba0KkcIEoHm5rrzqbp0upS/eJ
	wxNqxqAtwuzD+FH1xcFk95zTAayGVcrWLldXfqqCGz07hyzl5zHbb71alV63C603+tIDux
	t27jM1+cUPvsucTEGHEm547VFvbiztOoR5XieLR8tztrq0JROaNCEKxU3mg+K86jSgLfSi
	Mt/4YpWDMf9kA1gtBLw/JIxE5vhCS+QFkEWYwcSpDshD1JdfsrhcI5UwN0IxsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795012808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9zNTrCs5ck/1o3RCSKW2VT8r4JHp1JK8lZkVLfXYGM=;
	b=z9dCV9/LLwfZ/WJUCNkWRDcS94wXIj2YymCvzLINZIqZYOT8lnxmLGaPjBAiDrErtDdc5i
	TDvDcearZiD+nhDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] locking/rtmutex: Initialize the ww_mutex context
 of a waiter
Message-ID: <20261118144006.ms1fvDv1@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>
 <20261116135857.5t9HGji5@linutronix.de>
 <de727dc6-cd11-4a7e-a853-aecd895685a9@efficios.com>
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
In-Reply-To: <de727dc6-cd11-4a7e-a853-aecd895685a9@efficios.com>

On 2026-11-16 13:37:09 [-0500], Mathieu Desnoyers wrote:
> Hi Sebastian,
Hi Mathieu,

> > I *think* this is unrelated because the futex caller shouldn't end up
> > here. The __rt_mutex_slowlock() -> rt_mutex_handle_deadlock() should be
> > different for the futex and ww_mutex case.
>=20
> The futex caller does not go through __rt_mutex_slowlock(). It gets to
> the chain walk through the proxy lock:
>=20
>   futex_lock_pi()
>     rt_mutex_init_waiter(&rt_waiter)
>     __rt_mutex_start_proxy_lock()
>       task_blocks_on_rt_mutex(..., RT_MUTEX_FULL_CHAINWALK)
>         rt_mutex_adjust_prio_chain()
>=20
> rt_mutex_adjust_prio_chain() reads waiter->ww_ctx in two places:
>=20
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && waiter->ww_ctx && detect_deadlock)
> 		detect_deadlock =3D false;
> 	[...]
> 		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
> 			ret =3D 0;
>=20
> Both tests are under IS_ENABLED(CONFIG_PREEMPT_RT), not under
> build_ww_mutex(). So the futex build of the chain walk has them too.

Yes, this part. I realised this later=E2=80=A6

> > Is this really the case?
> > You have a lock chain where the ww_mutex and a regular rtmutex interact?
>=20
> No ww_mutex is needed. Two PI futexes are enough. Both waiters come from
> rt_mutex_init_waiter() in futex_lock_pi(), so both hold the 0x11 poison
> in ww_ctx with CONFIG_DEBUG_RT_MUTEXES. The chain walk takes them for
> ww_mutex waiters.
>=20
> The deadlock case of futex_lock_pi_inherit (patch 4) is that ABBA. With
> PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, it fails without this patch: the
> second FUTEX_LOCK_PI blocks. It passes with it.

right. That is an issue.

> > I would argue that the full-chainwalk depends now
> > on a random stack value _and_ __waiter_less() might access the random
> > value if ww_mutex is enqueued and a regular mutex exists in the lock
> > chain.
>=20
> Yes, those are the two effects. I reproduced the first one only. The
> second one is from reading the code, which is why the changelog says
> "would dereference".

The deference _shouldn't_ happen because those two a different. However,
we could have a mix of those two and which point it becomes relevant.

> You are right that the changelog is confusing. It starts with the futex
> symptom, and only then says where the value is read. In the planned next
> version, I would put the mechanism first, with the call path above. Does
> this read better?
>=20
>     rt_mutex_init_waiter() does not set waiter->ww_ctx. Only
 rt_mutex_waiter::ww_ctx please

>     __rt_mutex_slowlock_locked() sets it. So the waiters of PI futexes
>     and rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES. Without

or random garbage which.

>     that option, they keep what was on the stack, unless the compiler
>     zeroes it.
>=20
>     With PREEMPT_RT, ww_mutexes are built on rtmutexes. They can create
>     a cycle in the lock graph legitimately, and the wound/die logic
>     resolves it. So rt_mutex_adjust_prio_chain() turns deadlock
>     detection off when it finds a waiter with a ww_ctx. It also drops
>     the -EDEADLK of a walk that started from such a waiter. Both tests
>     are under IS_ENABLED(CONFIG_PREEMPT_RT), so every build of the chain
>     walk has them.

I would strip that paragraph because *I* think it is more important to
mention the FUTEX case which no longer does proper chainwalk regardless
of PREEMPT_RT. Yes, ww_mutex has=20

>     FUTEX_LOCK_PI gets there with no ww_mutex in the chain:
>=20
>       futex_lock_pi()
>         rt_mutex_init_waiter()
>         __rt_mutex_start_proxy_lock()
>           task_blocks_on_rt_mutex()
>             rt_mutex_adjust_prio_chain()
>=20
>     The chain walk takes its waiters for ww_mutex waiters. With
>     PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, FUTEX_LOCK_PI then reports
>     no deadlock. Two threads that each block on a PI futex the other
>     holds sleep forever. Without PREEMPT_RT, the second one gets
>     EDEADLK. FUTEX_LOCK_PI also blocks on a chain deeper than
>     max_lock_depth, instead of returning EDEADLK.
>=20
>     The ww_mutex build of the chain walk can also requeue such waiters.
>     On two of them with equal priority, __waiter_less() would
>     dereference the poison.

The futex code for PI_LOCK performs a RT_MUTEX_FULL_CHAINWALK during
locking. rt_mutex_adjust_prio_chain() then wrongly assumes that it is a
ww_mutex (due to random garbage in rt_mutex_waiter::ww_ctx) and does not
report a deadlock but expects the caller to handle it.

>     Fix this by clearing waiter->ww_ctx in rt_mutex_init_waiter().
rt_mutex_waiter::ww_ctx

This, Fixes: and=20

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Thanks,
>=20
> Mathieu

Sebastian
