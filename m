Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAC331ED5;
	Thu,  6 Aug 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038605; cv=none; b=fGLY+lL9KJclqIV8hm51iAx454f+OOpfv0ObVZyXB+VccWlcmjNUnKj2+KOaOe8NvZYpyIhE9vZoSXdcbbncW1OqABzxC7GtRSncTe0JwFecjgCllUu9GkAGcQALPLtlRmAI/J/cDoA9nhmb0O1RutfUmK/xGaa4Lv0iVioTv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038605; c=relaxed/simple;
	bh=K5TS9p1V85xSaxcVRdFEL/ek6Wi6MMXDivsDAD8zqPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVzJbOsBT+RHVPbiXXp+g3+Pnx5dl1wl04xSRJ5lXJLWFAP7xo97IJBkwGwgORvKGXLdd065DUopHYsSqidu/s88UYLk9erDEX5DBmDaMjS352/3gCE/3v79tRuNOBub0xCijO8jdOs7V1rEbeNzXtxshwM+OAV42L68DhKzmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0SKGg3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0SKGg3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F401F00A3D;
	Thu,  6 Aug 2026 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038598;
	bh=8QNE6YXYBYXU/XVt72XtvA5dqvkg+0izTHUaBOdsur4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0SKGg3Dgt9fkNbLEQsiVg6k1DsSMWXpkHu1EypkRbYgUUcNn+a1gf7Jun5ppzIii
	 EdEh4AQbRqMZyj4+VIXu0w3N6decfDNQbCf9Jr0fifo3qhMVYVqHWlAy0T2PmMvwH5
	 DzG1fQMKXbDiLkwjDQjGQPTHc9wLIiOAsxE3GUBIt7aqkUEYIxGF1iszxwxBKOrsRr
	 OlFya9KKB9ilpu0TJUi1RI7B8T2FuHlI3H2wW6MHH6Ondys4L8tzmfp2CG85OLPHfA
	 26LNtMpfAlH06ULqn0zEVwbkRouUTX/2Zc0kf4F8FyRw6k4LPuhZlJl7g64474mAX6
	 HdbwiC2NAfAeg==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Simon Liebold <simonlie@amazon.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] sched/wake_q: Add helper to call wake_up_q after unlock with preemption disabled
Date: Thu,  6 Aug 2026 13:49:42 -0400
Message-ID: <20260806131004.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806093259.2778358-3-simonlie@amazon.de>
References: <20260806093259.2778358-1-simonlie@amazon.de> <20260806093259.2778358-3-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 09:32:59AM +0000, Simon Liebold wrote:
> [ Upstream commit abfdccd6af2b071951633e57d6322c46a1ea791f ]
>
> A common pattern seen when wake_qs are used to defer a wakeup
> until after a lock is released is something like:
>   preempt_disable();
>   raw_spin_unlock(lock);
>   wake_up_q(wake_q);
>   preempt_enable();
>
> So create some raw_spin_unlock*_wake() helper functions to clean
> this up.

Both patches apply cleanly to 6.12.y and are byte-identical to their
upstream counterparts, so mechanically there is nothing wrong here. But
the rationale in the cover letter does not hold up:

> Even though it looks like a refactor, it adds an if (wake_q), gating the
> wake queue drain.

That "if (wake_q)" is a NULL pointer check, not an "is the queue empty"
check. On 6.12.y every call site of the new helpers passes the address of
an on-stack DEFINE_WAKE_Q - __mutex_unlock_slowpath() and
task_blocks_on_rt_mutex() both pass &wake_q unconditionally - so it is
never false, and the preempt_disable() plus wake_up_q() drain stays
exactly as unconditional as it is today. The only site that can pass NULL
is rt_mutex_slowlock_block() via rt_mutex_wait_proxy_lock(), and that
already carries the identical guard in 6.12.y from the 4a0779145781
("locking/rtmutex: Make sure we wake anything on the wake_q when we
release the lock->wait_lock") backport.

Patch 1/2 additionally converts mutex::wait_lock to irqsave/irqrestore,
which adds a small cost to the slow path rather than removing one. And
the unconditional drain in the plain mutex release path arrived with
894d1b3db41c ("locking/mutex: Remove wakeups from under
mutex::wait_lock") in v6.12.95, not with 4a0779145781 in v6.12.96.

Also note that "wake_q is only ever populated on the ww_mutex path" is
not right either: __mutex_unlock_slowpath() does wake_q_add() for the
ordinary contended waiter.

Neither commit has a Fixes: or Cc: stable tag and both are proxy-exec
prep/cleanup work, so before I queue them for 6.12.y I would like to see
before/after fio numbers with each patch applied separately, so we know
which change actually recovers the throughput you measured.

-- 
Thanks,
Sasha
