Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD1423A72;
	Fri, 16 Oct 2026 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137342; cv=none; b=FRNDR8lpST0S7c0NoRXcVULjIZebgyvc27JDEC7wEIf2i6x1lv6XjDXRnlwb13fmCgMMn39KTmW5zpmZDF67giYSVdkZtlCwC50vcOmor0dFe0gkmpcRC6qSInHSN6fImBmlgjl8iWkD+q8LJPIjX/aP3+xDby+dDM9Hmy62sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137342; c=relaxed/simple;
	bh=jeTa1WMw9Xg9wE8dfbqzKvv8wfhtrqE8K1meC++ZrwU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gFgVZTFfsiks8Onz7vH0TunFHT0Vl5W4KoSZbg9IYx3oVrOqc+ke9jeJapHZ4+3v8RGhmcueY5nniRioZLJOJeMvt9xYueSWpT2CCWx+Bino5XK5LfZIRcGLQB+Dhq9R5zKGSpvv23f6/FYzfVEs14E7vV4YuqYE7bheO0osmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXgcC+oj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JH7FXyPg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXgcC+oj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JH7FXyPg"
Date: Fri, 16 Oct 2026 07:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792137337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfgxfawd34JYw3SDE3kZ8EExRk822nKQHkRcFUq4JSs=;
	b=tXgcC+ojE0lA216bzA+G11Pg9vijTdRq36DbpqtGCinFgO82Aex7sG+A4HOhoHTCIhGhOG
	v/GFJeVBsf4zdoa1it0cRso58pJJmKjtj9iY8dSu8QcIZ9YrnUI5si6cxamTApELRSdz00
	oidNF6xbMFU6Hq0/ah3sJ2cxJvvwxXGNn3KJaTKh59UGws66+tVociKJcueYvj/P3m3Qaq
	scc61wxXxky+T6VLqMLT3rfcJ6HLncDroBa+gGFOXvB+FO6XzCqI73p0/Pf2M0CbXNfj+r
	mXdrrE4x8dAe/F3yVyv0hDgmaj4uRMdPX+8URGJLXPlRykyz4w3ARqXJSlpqmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792137337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfgxfawd34JYw3SDE3kZ8EExRk822nKQHkRcFUq4JSs=;
	b=JH7FXyPg/jjjLZLSanLcCg2knhMnZya2TYiND64Hu7rV4GOdg3QI6NLb3A2r+Vd2fw8BIK
	v9qc9ranEsuJTVBA==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Track the perf mlock gift separately
Cc: Ameer Hamza <ameer.hamza@truenas.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179213733594.2666988.15815189695227726657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     78436f3882fb8d848c823bf8cf754988202c5ca5
Gitweb:        https://git.kernel.org/tip/78436f3882fb8d848c823bf8cf754988202=
c5ca5
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Sat, 03 Oct 2026 17:29:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Oct 2026 09:49:01 +02:00

perf: Track the perf mlock gift separately

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
Closes: https://lore.kernel.org/20261002175651.811343-1-ameer.hamza@truenas.c=
om
Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@=
kernel.org
---
 include/linux/sched/user.h |  8 +++++---
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 8d7e552..ec262b6 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -23,11 +23,13 @@ struct user_struct {
 	struct hlist_node uidhash_node;
 	kuid_t uid;
=20
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
index 7846d70..8b69d50 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7059,7 +7059,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
=20
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked=
_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_m=
lock);
 		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
=20
 		/* this has to be the last one */
@@ -7242,11 +7242,11 @@ static bool perf_mmap_calc_limits(struct vm_area_stru=
ct *vma, long *user_extra,=20
 	/* Increase the limit linearly with more CPUs */
 	user_lock_limit *=3D num_online_cpus();
=20
-	user_locked =3D atomic_long_read(&user->locked_vm);
+	user_locked =3D atomic_long_read(&user->perf_mlock);
=20
 	/*
 	 * sysctl_perf_event_mlock may have changed, so that
-	 *     user->locked_vm > user_lock_limit
+	 *     user->perf_mlock > user_lock_limit
 	 */
 	if (user_locked > user_lock_limit)
 		user_locked =3D user_lock_limit;
@@ -7254,7 +7254,7 @@ static bool perf_mmap_calc_limits(struct vm_area_struct=
 *vma, long *user_extra,=20
=20
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
+		 * charge perf_mlock until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
 		 */
 		*extra =3D user_locked - user_lock_limit;
@@ -7272,7 +7272,7 @@ static void perf_mmap_account(struct vm_area_struct *vm=
a, long user_extra, long=20
 {
 	struct user_struct *user =3D current_user();
=20
-	atomic_long_add(user_extra, &user->locked_vm);
+	atomic_long_add(user_extra, &user->perf_mlock);
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
=20
@@ -7281,7 +7281,7 @@ static void perf_mmap_unaccount(struct vm_area_struct *=
vma, struct perf_buffer *
 	struct user_struct *user =3D rb->mmap_user;
=20
 	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
-			&user->locked_vm);
+			&user->perf_mlock);
 	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
 }
=20
