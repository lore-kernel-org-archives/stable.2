Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF13DDDA1
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636765; cv=none; b=QsYJcakQsCr0YY3ZOTebq0VVRGqdkseG9KIywihK0S2ALbDe9VQQbS8/N9HyZ5GpNkGfO2yTMYhTOg9Cd5ehebrOIw/F3ucu1HRmJ+xMOd/haxUSycfEX4p/PkLIhGb/n5ihNyMVI1kTdcfyFUym9BtCK9cXykX8P43Gj1ho23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636765; c=relaxed/simple;
	bh=WHhUjdFqclrLy2dVUo0Zh+NR1jvVZIVQfPfXgoP3hSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVmgRqWziQgV2twB1tACC4RRZQkgCANQfogEnmI84GA0JB5Nfi9FtqVm246eBGyH3XKleVDwqGtIp17EgOaN8oHmkMegBDySYkCazwjKlG9Qs+f7LWZ0EDq9dB+tBwds6KFCrXmUSZ++ceMksjuCAYK8EBcOtuo34jOsM7QUUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbb3lfXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbb3lfXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD41F00A3D;
	Tue, 16 Jun 2026 19:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636764;
	bh=3xOhdZQ8cSRd0tyUEbRatZKvxO5tENE1QTNWjC/AbWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbb3lfXbUveyoi0BmrOTJ/GqKpB2bU13HmGtQ9x+hxK0obLNl4WhwhwnQACOcDVsT
	 LL8ha/5Yu21iSdJ2r9QYUpYjjDveFZKljAR4utKt6qlkjsRVSI3m9WKXQqzICHVAK+
	 bPzWOv0PAw5PNKkHN8nnR8aqkMcFpFd6igW7xasWl7rID4PULPB5FBQ+SqTnsc/UtP
	 a/mTSxk1xV9gIjFa6WvLtBZjhyA51CaoUjk0Ir8QUUxM3RXyOaEFonp3SYsTEZjixZ
	 4GAQ8DyBrlOXOoLkb0ROY/JwsN8+FvcoENz5BVq2G/ZGJ7YNK3ZhXYEbKFLD6i2JW6
	 N3QlvIWTLJZOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
Date: Tue, 16 Jun 2026 15:06:01 -0400
Message-ID: <20260616190601.3487860-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616190601.3487860-1-sashal@kernel.org>
References: <2026061513-dating-gaining-4f76@gregkh>
 <20260616190601.3487860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 40a25d59e85b3c8709ac2424d44f65610467871e ]

syzbot triggered the following splat in remove_waiter() via
FUTEX_CMP_REQUEUE_PI:

  KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
   class_raw_spinlock_constructor
   remove_waiter+0x159/0x1200 kernel/locking/rtmutex.c:1561
   rt_mutex_start_proxy_lock+0x103/0x120
   futex_requeue+0x10e4/0x20d0
   __x64_sys_futex+0x34f/0x4d0

task_blocks_on_rt_mutex() does not arm the waiter upon deadlock detection,
leaving waiter->task nil, where 3bfdc63936dd ("rtmutex: Use waiter::task instead
of current in remove_waiter()") made this fatal.

Furthermore, rt_mutex_start_proxy_lock() should not be calling into remove_waiter()
upon a successfully grabbing the rtmutex. 1a1fb985f2e2 ("futex: Handle early deadlock
return correctly"), moved the remove_waiter() out of __rt_mutex_start_proxy_lock()
(where 'ret' was only ever 0 or < 0) into the wrapper. Tighten this check to
account for try_to_take_rt_mutex().

Fixes: 3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Reported-by: syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/69f114ac.050a0220.ac8b.0003.GAE@google.com/
Link: https://patch.msgid.link/20260507112913.1019537-1-dave@stgolabs.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/rtmutex.c     | 3 +++
 kernel/locking/rtmutex_api.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8fdbd293180130..7110ee98391e2b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1550,6 +1550,9 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on = NULL;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 2bc14c049a644c..091b109acdc5ee 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -347,7 +347,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
-- 
2.53.0

