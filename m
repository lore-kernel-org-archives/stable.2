Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598035;
	b=a9j0deMSPDDzjTdIBN/C/Qb3G5KRnIbCY150rQm8uG82V1F/RyK+bJjN4tQTdoEOI1we
	 xyTBzHPCb6t9eHAr94tTSnMCQf5hBT8Z2LeN8A15bFJExCdBIkHNF4FVTAsBPFpA3LMgL
	 WGB4BSk3kAy8ObjybDcn3seC+3wR6l79K6VEhskG9G147ZJ3qvmNqW0UB2dIhxs/WhAso
	 BN0fgj5Kt6yYjDnt32h05aTpPJydxp+zJmPrSLe/717B3pSWuGoHb0P7DBBGeG9DDmXc/
	 5tuDpU7z7+L5Ndu1GG3V9LnHWRcy2OxSObgh6OfBYOHsiRjeYSaeVEGzCS053PNwBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598035;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uLZ2osQJ7uiRUIsiiKGBz+t5qtMtD0O/F6LqjFJrt/0=;
	b=zorn0hD30M55Jfg2LXy7bVF7POFM9L2DIOxze2JH7/VB/FEd0aXxYFkJc3Hzw4W9fHhw
	 8gfXqHMeQFKgQvV03iSgoV5DmnGSYXWf4qqoM25p/orqyNBoEI3+gNNK2RSr8GimPPHCC
	 k05ZdB8NYbiq7MoXRtjCM3uo4G/ImdEE5l8Q6U15iLtxMmPYXoFZV3tN+WbDJsdNg9w/9
	 1tCpwFWNH8QabDUTni/bDyuvRl920e1ICT2X+yCoBOYuMtK6V/HVWfDMrJaBuEVSu8L62
	 EdAQyAo4fRY5tg7P0i/OXHMP7E5Q5Ao3ru/bXgQhZ6abR5rFYP5XX7u5NsaKAEfZMmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SErAX8rK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87361606A333
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SErAX8rK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D31F000C1;
	Wed, 21 Oct 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598035;
	bh=uLZ2osQJ7uiRUIsiiKGBz+t5qtMtD0O/F6LqjFJrt/0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=SErAX8rKAC2aG/oJpFuqjFk8vCvXmsnFjqPye78LQImkM4WJ2k0snXfB20ITl0vAj
	 A0Bs2BEf/7gOcCnKaBGaTKQIjSIoBh2CXbhBN1hMlufwgaGBHvfrqGUh4203VPPNRr
	 7hIdCNG+7yMWX4rhBUrgaNwU/wSnbwzpSm5IId26MFt5fad4N+1/r90oGMAhoRIRMA
	 NG8WAtjBcTZoABrooZBDn0VhGJhAcgWwS4LfrFLKxPMyWmnGogJG1S9OfvNbVwfGe8
	 mmvciMxU1PDmWcn14lhTcY/e4ou4N7+mT1/0IWm03j1Eqf/XBETiY7FZQ/js6vH3uM
	 tM/rk9mVL374A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] perf: Track the perf mlock gift separately
Date: Wed, 21 Oct 2026 16:53:49 +0100
Message-ID: <20261021155349.1698340-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026102117-rethink-jaybird-bd86@gregkh>
References: <2026102117-rethink-jaybird-bd86@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The locked_vm field in struct user_struct was originally introduced by
commit 789f90fcf6b0 ("perf_counter: per user mlock gift") to provide an
mlock-like budget for perf measured against mm->pinned_vm (since 2011).

perf grants each user a 'gift' of perf_event_mlock_kb * online CPUs of
buffer pages which is charged to user->locked_vm without any RLIMIT_MEMLOCK
check.

Only pages beyond the gift are checked against RLIMIT_MEMLOCK, per-mm, via
mm->pinned_vm, which makes it different from the standard mlock() check,
which is per-mm and made against RLIMIT_MEMLOCK.

However, since this was introduced, a number of other components have
utilised this field where a shared resource needed to be limited against
RLIMIT_MEMLOCK.

The other users are currently MSG_ZEROCOPY, io_uring, AF_XDP, iommufd,
s390 KVM zPCI and most recently, secretmem in commit 97d34aa65c29
("mm/secretmem: properly account locked pages").

This field is shared between all of these, but because the gift is not
checked against RLIMIT_MEMLOCK, user->locked_vm alone can exceed it - 16
CPUs * 516 KiB is already more than the default 8 MiB - after which every
other user of the field fails unconditionally.

This was reported by a user who saw secretmem failing while running a
simultaneous perf record.

Resolve the issue by simply giving perf its own field separate from the
rest.

BPF used user->locked_vm up until commit 80ee81e0403c ("bpf: Eliminate
rlimit-based memory accounting infra for bpf maps") which landed in 5.11.

Thus also eliminate the now-defunct ifdef for CONFIG_BPF_SYSCALL for
user->locked_vm.

This issue exists between all of the components which use user->locked_vm
and perf, however secretmem is the first user who has caused a report over
many years and has been backported, so target the fix at that.

Fixes: 97d34aa65c29 ("mm/secretmem: properly account locked pages")
Closes: https://lore.kernel.org/20261002175651.811343-1-ameer.hamza@truenas.com
Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
(cherry picked from commit 78436f3882fb8d848c823bf8cf754988202c5ca5)
[ ljs - Applied to open-coded accounting in perf_mmap()/perf_mmap_close(). ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/sched/user.h |  8 +++++---
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 8d7e5521f7cd..ec262b605437 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -23,11 +23,13 @@ struct user_struct {
 	struct hlist_node uidhash_node;
 	kuid_t uid;
 
-#if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
+#if defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
 	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD) || \
 	defined(CONFIG_SECRETMEM)
-	atomic_long_t locked_vm;
+	atomic_long_t locked_vm;	/* pinned pages charged to RLIMIT_MEMLOCK */
+#endif
+#ifdef CONFIG_PERF_EVENTS
+	atomic_long_t perf_mlock;	/* perf buffer pages within perf_event_mlock_kb */
 #endif
 #ifdef CONFIG_WATCH_QUEUE
 	atomic_t nr_watches;	/* The number of watches this user currently has */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6c9c3bfc0da2..fe93bb9cfad6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6533,7 +6533,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_mlock);
 		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
@@ -6608,7 +6608,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 */
 
 	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
-			&mmap_user->locked_vm);
+			&mmap_user->perf_mlock);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -6768,11 +6768,11 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	 */
 	user_lock_limit *= num_online_cpus();
 
-	user_locked = atomic_long_read(&user->locked_vm);
+	user_locked = atomic_long_read(&user->perf_mlock);
 
 	/*
 	 * sysctl_perf_event_mlock may have changed, so that
-	 *     user->locked_vm > user_lock_limit
+	 *     user->perf_mlock > user_lock_limit
 	 */
 	if (user_locked > user_lock_limit)
 		user_locked = user_lock_limit;
@@ -6780,7 +6780,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
+		 * charge perf_mlock until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
 		 */
 		extra = user_locked - user_lock_limit;
@@ -6832,7 +6832,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 unlock:
 	if (!ret) {
-		atomic_long_add(user_extra, &user->locked_vm);
+		atomic_long_add(user_extra, &user->perf_mlock);
 		atomic64_add(extra, &vma->vm_mm->pinned_vm);
 
 		atomic_inc(&event->mmap_count);
-- 
2.56.0

