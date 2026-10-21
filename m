Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594267;
	b=CI8XQgfZiDjhC6tfGkzioGEVK+hqjx5ijKdmpn/s1/XHivXnsc27ksLcAw7Nw4tRCDRO
	 g758Rr/fAanx7ar3BUFdWKuyRyekyot0g4CHWYgyw+AizcvxvFfgNlBXMZKONLW0MNwSh
	 lwDQabBkvkVWWstjUhszsw2ZXsUjrHUt41jaKJ3ai5/+pedA5gbvXG279OTBN7omD6Q94
	 48oI60dRZ8Utp4+LWKloXG8U1G9ejEdGGAnJ4ME4nMNqLW3jd9ZGTlmamd9QhB8RIGl0+
	 jyHmQbqXHyLof5RX/niO5M36AB7J+bhyYQH2FJJ3G7VqMyTTVhBRywhdHPL00yxZhLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594267;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Tf2truVF0HJWt5aQe6XENxvc3Zf7LhrdjDkpDzoeZ2c=;
	b=ofVOZ/whw29WewAGoNvfE2HOh6WMjabbl6ZdHnpLKq8Sh4TaS++YP5hT27ay4AEXwrF2
	 BtLqzd44C0TtTpTa1kNXfJ9W4x5w3HJSpl4nuu6ThJLonEwUFfWYLKjnW3Fum8K9PwJeZ
	 YQQTI8k31/JucDVHzIHzjT7nkiNFENftDdnm5159jQwEr1K8QyBKOp7T+nCiXom45qfQi
	 s6G6cguSz6U/9IDvscRfhsDuQtyQbjzckF8TMq401/+Flk1JW0UhB/jsG/NXEqWmShCvd
	 gx1dJuotWkxkRS+DZmIawH1AUuoI7pwiC6S6mzyFOBEjF73FxKjzhn76uw7Mt9bgXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QmCIJP73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55490606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QmCIJP73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76E61F000C1;
	Wed, 21 Oct 2026 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594267;
	bh=Tf2truVF0HJWt5aQe6XENxvc3Zf7LhrdjDkpDzoeZ2c=;
	h=Subject:To:Cc:From:Date;
	b=QmCIJP733+dcXGHyBfE95p5A8DL2Lkm3o7/5prKwIPIwouRgdM226hLbNGnff5+6A
	 nfprRlUB+WLcPdZcqCYAD85hnXdBvGiq4A9YvplyUHqKliMQO2LtyKXj3n59UDeBfe
	 M6flwtOUa6rDpwEYTgcf9VlTBBDl9KGXNtZunNGg=
Subject: FAILED: patch "[PATCH] perf: Track the perf mlock gift separately" failed to apply to 6.6-stable tree
To: ljs@kernel.org,ameer.hamza@truenas.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:43:18 +0200
Message-ID: <2026102118-chip-silicon-40c5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 78436f3882fb8d848c823bf8cf754988202c5ca5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102118-chip-silicon-40c5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78436f3882fb8d848c823bf8cf754988202c5ca5 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 3 Oct 2026 17:29:07 +0100
Subject: [PATCH] perf: Track the perf mlock gift separately

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
Link: https://patch.msgid.link/20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org

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
index 7846d70be57f..8b69d50fcbcb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7059,7 +7059,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_mlock);
 		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
@@ -7242,11 +7242,11 @@ static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra,
 	/* Increase the limit linearly with more CPUs */
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
@@ -7254,7 +7254,7 @@ static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra,
 
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
+		 * charge perf_mlock until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
 		 */
 		*extra = user_locked - user_lock_limit;
@@ -7272,7 +7272,7 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 {
 	struct user_struct *user = current_user();
 
-	atomic_long_add(user_extra, &user->locked_vm);
+	atomic_long_add(user_extra, &user->perf_mlock);
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
@@ -7281,7 +7281,7 @@ static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *
 	struct user_struct *user = rb->mmap_user;
 
 	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
-			&user->locked_vm);
+			&user->perf_mlock);
 	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
 }
 

