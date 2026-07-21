Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2343849F;
	Tue, 21 Jul 2026 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620515; cv=none; b=pG58AVBQyr3fYAN7UHJ5Vq3x0N6oGN9YDn64+Irlrq8egg0j5OVAxato5lq9iqBq4llIFrk8lOjo/fd0bOUcd0vqC/R8EsfPcQEaEaInOJBwyVQpEFHBPZQSJrlxGRdtKs0jDru4igSBVbibSQiwBU/jo2/lZFE1tkkNuSc3R9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620515; c=relaxed/simple;
	bh=aXk5FmK+bvqFiumDZjWwP0Ma45DgCw3NdhhJM01AFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry2rkOTVG9zmy10rKbJW1IOV6VbslZ2NOgjy8brdGhudl5SXOIphD2Oj3mKaGEvXsTBfsemIKJJTTfPipBW3gXhfZfoYWF3mnwb8vMtMfwzitdrdoScbPyEWks8JV6TOeccIG7a+L0zVRm9AUnadzUCK5JQu+C9SdJk3tCipwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEcMi55r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEcMi55r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CABB1F00A3A;
	Tue, 21 Jul 2026 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620514;
	bh=BVfgm0xC115uBaQmqio50UdqDv74qrMywulQ/rq6+/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEcMi55ro+KVNzsTRji/XC3zEGUW7CEqrE5H0FOwIsSFjKovTNxeVS3Cvrk9YRMeR
	 COSfUr/wdrHRfpgmR111FNpm1VX+HH9LpVwPM2ZNuJaXXuzmH52xQxH3WsJoOpRAKn
	 VObEBFO3/cGNIlZviP7Uvt8ItFYnXPN7MtDno9qHtiSWtTv6oR8DjRyFuWtOhejrwx
	 +JCwUuXSGvucUP0SVdNLwUTi81GVF+DQutgwaYQSfAiTy0kwe+0EWqg2e7tZT5QRyj
	 UCjmHSzHvg7ocBhQ4SDQlgepFj4DkGgOrMU6EFmYGfSnw5JRMfcOqeZlAW4enCH3Go
	 QnSWQd9CampAw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [STABLE v5.10 2/2] locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
Date: Tue, 21 Jul 2026 08:54:54 +0100
Message-ID: <20260721075459.1970132-2-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075459.1970132-1-lee@kernel.org>
References: <20260721075459.1970132-1-lee@kernel.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4afda3a1da02129568a3a2f1898aa13e6763bcba)
[Lee: Backported to linux-5.10.y from linux-6.1.y]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/locking/rtmutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2ab2d6cce004..9cfe7f0aa04e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1074,6 +1074,9 @@ static void remove_waiter(struct rt_mutex *lock,
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	raw_spin_lock(&waiter_task->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	waiter_task->pi_blocked_on = NULL;
@@ -1803,7 +1806,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-- 
2.55.0.229.g6434b31f56-goog

