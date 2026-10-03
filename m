Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF747F787;
	Sat,  3 Oct 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044974; cv=none; b=NZDsPNQW/MJJJJW8HPJVkB9gYBvTFDEmNRvFuGqBenGKIfQGXnc+hduyYpu+Y/3bVEddIPHg3bLLD+GcKsOUtLU0Cr5WmexxWjPNczLY3XjJ5qj0xPdTN9FQu+wnOm9Sy7MjheOor95xqu1TEVn2XKAQzDXK0j6RC7zY5XmwCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044974; c=relaxed/simple;
	bh=FZoeveIxfPmCGR3CWh0q9bKGayisvvWvxTpf7kneCr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LVWXbsXNooU5q4x4j9qJNnM/D4ENEcMy0PgWIiwK9JZd7GmAG6gr29KmNpFT8pGf1hychCroyBmdl/plCRXM2b3N/yQKyXm91/La38e2kITeCmoidJ+f4TpZbyaFAnfJHcCN0CjNijTQWKRI305W3vpA1t0zqHUZ4wldmX8JmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcwMLUVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcwMLUVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7AD1F0089B;
	Sat,  3 Oct 2026 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791044971;
	bh=70QXKPQZm0PKLtEKZNQ8whITCMvzzbdpub1y+w3DfPM=;
	h=From:Date:Subject:To:Cc;
	b=IcwMLUVrubQh06EoRlIn//1YwSFTLlhmOgzkDPVKtf7ZBWj/XnF1iVPU6BmlYC5gD
	 zKnIIc+3ndGSkJxOrvxC1M0xAx8NhJ4U4TAty8QnFnRA3GqBdL4NfpuQL2UtkggwBk
	 iB98wKExQ60rZiRBHJqu9lExkdJUK64mKTHXodIIxtUNnoTJQZAknjCLir868nl8RI
	 WYpVYfq7QVGjq5bnMUH7PH9OBWd+Ctm6wRuHGziHy4MM9tNLvu40MFM5flgjwK5ivR
	 12Gr+VTrld7qVFqfkiOMwuKnp3m+uEMc/GVqGEnCajmIwCImtXCrj/ac4bg2u8Ql2W
	 sDYKa479NI4oA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 03 Oct 2026 17:29:07 +0100
Subject: [PATCH] perf/core: track the perf mlock gift separately
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsEsKvpKdEhda6k0FCIQ/550n
 IGZBJECU4SpShDo4cjeFWjqCvS+uo2QTWGQQvaNEC3eFCyeXh9k8LnQ8osjrcPYCamVMlDCO1D
 R/3Recv4A+2VGuWQAAAA=
X-Change-ID: 20261003-perf-locked-vm-fix-8ea78402cbbd
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
 regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>, 
 Alexander Motin <alexander.motin@truenas.com>, 
 Ameer Hamza <ameer.hamza@truenas.com>, 
 "Caleb St. John" <caleb.stjohn@truenas.com>, ljs@kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5477; i=ljs@kernel.org;
 h=from:subject:message-id; bh=FZoeveIxfPmCGR3CWh0q9bKGayisvvWvxTpf7kneCr0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIO6qZ07uhIXpFy7s9x9uv/LObtfPmSa3/qK9fN1vXfn
 oT8v2twq6OUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATqclg+MMxY/WayPs2IVYJ
 WS0xKzj2FS2Ne6p/sKeJOfBq8r8uPgZGhqvyRptzF3y1rpl4odPLd4WcZYu/1VqzT1Y7HpTUB78
 s5gUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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
Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
Closes: https://lore.kernel.org/20261002175651.811343-1-ameer.hamza@truenas.com
Cc: stable@vger.kernel.org
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
index 634d2ccbab82..a7da42f13d14 100644
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
 

---
base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
change-id: 20261003-perf-locked-vm-fix-8ea78402cbbd

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

