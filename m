Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9313FEE
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660863; cv=none; b=Q+FobrSVx/88x1lUQE0N19CO2+efGZZ74HxT0bIM2Y+FwmHX/kvkli5cVbL5hByENPYSLc1cn7TXbOxg0DJTtnhyc5RalIGDttaFlG82AUDSiWqdR47vtNii5ig3g03Qajehhm+t6eivBcaivnIec0XqWDwfmtO8r78hRlSPC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660863; c=relaxed/simple;
	bh=w/sB2l7gXJTakhJ0wWIIgmulvqcW/BvVtvS64eq14H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr1V8fJG4CJ8E6gYrGcKYjVfKysIGJMTrPARk09rRPeBFYUQqqK/mO+oWj8O9ATvARAP3rgVx9F12JZAARjlMVRCpUxcPuAjWLeBiBB69pB2QKPuU5oMDxiaAYuPq1J8vDD+Bc2LhmqrP7TV/08aKnmxffYXQ59gnMQAuRtdTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7c8tuh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7c8tuh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6501F000E9;
	Wed, 17 Jun 2026 01:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781660861;
	bh=UyL3MLqsl1QwRb+An2uZnxrWd4KDwtYihrrKlA6XsOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7c8tuh9mRtqXKusvMRVRdbaY279JqivPN7gZF9sFp2u4RRi2IwLciuHF+SSsiWBS
	 +RHa0UjEl2FDFY840NVdeDi85XIpxn0kFKNZ4qYwzI0buEGLw6bPKgCBcKNtnNz91o
	 RluQXdcIpr5jMwRyOrPxxgBrV4TsRNSFXu/gFoxh77q9AsBlevTKpIa7VqeyaGD75A
	 YSZphL+chiGY9Hfu0yCNiWGAU56aBdrLsLp4md6HG2UPuixZPEnwiX4I4X2X2kMxpN
	 W7oHJw+P7lS1P/aDDurLdTBtEMOVkWMMhAKU3VJ3GkkCN4dU1WR9faXuA6FeMFPAFx
	 j8+j8qedXDWPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
Date: Tue, 16 Jun 2026 21:47:39 -0400
Message-ID: <20260617014739.3672034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061516-herbs-green-cf48@gregkh>
References: <2026061516-herbs-green-cf48@gregkh>
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
index def1f8fbc85cda..6df2f674712a47 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1524,6 +1524,9 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on = NULL;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d04459301..06c3db9f6cf1c5 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -344,7 +344,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-- 
2.53.0

