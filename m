Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C484A92C4;
	Thu, 17 Sep 2026 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636673; cv=none; b=PE06Q2188VE+Ay1Ws9s+r9XK0xByiF+gurX5hOfrLkKBUPsdLMzTJQ/xCFQ3a7a+//bl82mE42CxM00Go1paD0KGJOOnoCws5N+Vz5PLYDMQYBC1Y1CAqROvIpzHD8esSgY13XOMLferlcGZX+r8ZWjbjWARz8zYVp1THh8PvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636673; c=relaxed/simple;
	bh=nEYFwInjRPuYzhOfHREsUwY1LGlm++L9mB9utqpJfG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4bF3hrcZ+I6WFQhIVZGm9dyQ5GOumjtuFo8aqhpg6Xy4Xp93QoF4TnPKtyN9wKqcXk4O+pA5N9375kmi77gYSGpwz3pbrGztuHtgrGZN0O2fN5clZPbYRM0j2pLGGuPzeGaZ5t/M1YCrmefl8/1K0PGGrI/sGhPK2TY50jxC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYJTc/1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYJTc/1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BDD1F00898;
	Thu, 17 Sep 2026 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636672;
	bh=VmePqtdvMZ97XNvmYZYeJrcxanSNhpLDtQMBoLeGYMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KYJTc/1taPUsJNANXqvWRASFBKCIwEZrq9dNkVvLRpOzazYulS1jug1h5fejg4D1s
	 25YsW3t8rSLK14fJvO5r6q1bkza9ImBoIyaLrnelvKCC3M2P1f/2MPR+0RZ7VfU06K
	 IghjF9lvlykiSzmZ6SbYSsq2bEOdXS5Eu0d3xQSsCStHeN/tTPumHRA1cPsdCxmGph
	 EFFTKTYMGGlB9KgXttFIhj25DQR0XLZxXk2RHNthO05Z8rc4jUeRijYVQIH6VYbNId
	 9dAHizb4ejr4zoHcKVI8pZhoLUc0s7naT5mb1FGATjEmawJveeTqYuz9wpzJ6gAr33
	 5Mlt6pdCD4teQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:17:29 +0200
Subject: [PATCH v2 2/7] coredump: hold RCU while releasing parked threads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-coredump-fixes-v2-2-f3787fcda051@kernel.org>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
In-Reply-To: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nEYFwInjRPuYzhOfHREsUwY1LGlm++L9mB9utqpJfG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mAy88s7p6wAmXU5O7Y/8FQQaXnp+FZZrO7EW9tui
 12c12Vvd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkW52R4Wvny01GC5TWOuzS
 3PxqZoXPk8tfgrdP23YjyVLU0tDn3C5GhrmVhqtiE//bJ8Xdc5/+Qyvw5P/zFyR/3v2b97daND+
 7mRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

coredump_finish() releases the parked threads by clearing ->task in
their core_thread entry and calling wake_up_process() on each of them.
It does that without holding a reference on the task and without being
inside rcu.

But calling wake_up_process(task) without rcu here isn't safe. A parked
thread doesn't need that wakeup to leave. A spurious wakeup or a
preemption after the store is enough for the task to go away.

So if the coredump client is preempted between the store and
wake_up_process() the thread can exit and be freed in the meantime and
try_to_wake_up() takes pi_lock in freed memory.

Hold rcu across the loop.

Fixes: a94e2d408eae ("coredump: kill mm->core_done")
Cc: stable@vger.kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1fba3fed1a07..5b3f3a1090d7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -598,6 +598,8 @@ static void coredump_finish(enum coredump_state state)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -606,6 +608,7 @@ static void coredump_finish(enum coredump_state state)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}

-- 
2.53.0

