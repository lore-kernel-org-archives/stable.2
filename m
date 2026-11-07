Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048664;
	b=Dg+jVXt6U7Xjq2ngCTRtQUpU33ayPfMEAgW5JiG6M/McdpB5VE1CgXpeg+4Fn6y0XNvC
	 /IQvBydx4H0eBRzk8p2mIDgvrW+u/ckIL2Wnuci4zTWy55gvpl8RkolcCSFg6aLLiRo/K
	 8w3jr8lnxHOfB2kZTgzMaw9TujmrCIUUm30lUK51wm+8vzmJh6aqIDUp5EuLe9IZFWspq
	 1rw0jKe1g6T4Zr9+mNsegK/GMelfdZmSoWf1AeAg9P9Qv51rTWuR7bsng/1Awpt7fCphy
	 HV014IfKwFK/D0uxb352HAm1Z3Y32GZ+71Uc5rIgp15D2NkLw6mYhUKfJDskyYrnM1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WG/E+PI6UR/jRvlns7t4+KleWTXq/8/hlDpN4Kn7VTI=;
	b=pqZWznRs9fY9pTk0W4S6CmjvfzXhC5q4OTCgNdfblcFBQ+AFXPFU84cvZUxHjN1MbBgg
	 7Ov3x7sqxR4Uc56RZ2aikpGlhC+2ZdyfZvCppRsJFYWufbyNvauhPi6u7gmtWqy+vmsw5
	 AyCZDZ2yJoqCL4sciZ+8efIHIuAP4ES9odYktOSfxi/1zvfaKDoAzjX8xEcRoGMS7cvSY
	 Z2ELO+UedkPStFfOAeS3BHa5PvQ5mmcToftSLGE+NZsGmT5kE/Sx903iJ2JbBo34XrnOF
	 lIbUwKJl6Nroj+y0BpPX/C21rPmkk0a3RdEQ8LXH5S/0nKAyHo3EU325/Xj789uSBCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZF37BYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BA606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZF37BYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9787E1F0089F;
	Sat,  7 Nov 2026 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048664;
	bh=WG/E+PI6UR/jRvlns7t4+KleWTXq/8/hlDpN4Kn7VTI=;
	h=From:To:Cc:Subject:Date;
	b=FZF37BYN5EM74McqgO7Ju3Zq09k9pCoMCkwpvbRcyqCuWO/oqvcUsQRcEbDfjGsn4
	 1Es+tE97uPm3UcMQiScXrz8AwNEGf84wAB/9VT2EEbOx/3UhZAdOyU/Y47DeZsltSY
	 GEoTQo90W6yBc6z1dR7P+1uLY3BMfuWJRzIL0bP5aB19MIz7X+YZ0VFKVFbsj4A/nE
	 djDZGOBVfKtSY/VX8G5+Sv86GflZC7Q9yo2sSq+tHYXmEy0aodl3fuQxHZFKGBw0yf
	 Y1f9YJo1fhBhbb3jJTiQLDxaWAvgRNp5ZuBSE6fOnKyq5k5YppMkEhYa2/plikPIrL
	 9E5qfGuDkkmwg==
From: Sasha Levin <sashal@kernel.org>
To: linmag7@gmail.com,
	mattst88@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:02 -0500
Message-ID: <20261107055102-failed-6.1-fe221b7b2d3e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fe221b7b2d3ecd042dd391f74ff6a6fdeb7c2038
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055102-failed-6.1-fe221b7b2d3e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fe221b7b2d3ecd042dd391f74ff6a6fdeb7c2038 Mon Sep 17 00:00:00 2001
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 16:33:11 +0200
Subject: [PATCH] alpha: do not skip TLB shootdown IPIs for kthread-borrowed
 mms

flush_tlb_mm(), flush_tlb_page() and flush_icache_user_page() skip the
shootdown IPI when mm_users <= 1, on the assumption that no other CPU can
be running the mm. A task that borrows an mm through kthread_use_mm()
takes mmgrab() rather than mmget(), so it never appears in mm_users, and
kthread_use_mm() may be handed an mm that is already the caller's
active_mm and loaded on that CPU. Such a CPU was not only left without
an IPI, its mm->context[cpu] was cleared from under it.

mm->context[cpu] is already the record of which CPUs hold an ASN for the
mm. Test it rather than clearing it: take the shortcut only when no
other CPU has one, and otherwise fall through to the IPI, which
invalidates those CPUs properly. A CPU that merely ran the mm in the
past also holds a context and now costs an IPI, which errs in the safe
direction.

Change ipi_flush_tlb_mm(), ipi_flush_icache_page() and the migration
callback ipi_flush_mm_and_page() to test current->mm, like
ipi_flush_tlb_page(). A CPU that only retains the mm lazily then clears
its own slot through flush_tlb_other(), rather than publishing a new ASN
on every IPI or migration rendezvous. The migration callback still does
its per-VA tbi() afterwards. Returning to the mm allocates a fresh ASN
through ev5_switch_mm(), or through the direct-load path when
kthread_use_mm() switches current's mm.

Once these historical slots are gone, the shortcut is available again
if mm_users remains at most one and no other CPU has taken or kept a
context. An explicit kthread_use_mm() borrower has current->mm set and
still receives the invalidate it needs.

The caller-side tests in flush_tlb_mm() and flush_icache_user_page()
remain current->active_mm. A kernel thread that flushes its lazily held
mm can therefore publish its own context slot. Those branches also
perform the shortcut check, which excludes the calling CPU's slot, so
leave them unchanged. This is distinct from a remote lazy CPU keeping
its slot populated through repeated callbacks.

Together with the preceding patch, dropping these clearing loops leaves
every runtime write to mm->context[] targeting the writing CPU's own slot,
so the array becomes a lockless publication of which CPUs may be using the
mm, with a single writer per slot. Mark the two stores that are now
observed from other CPUs; flush_tlb_other() already uses WRITE_ONCE().
The uniprocessor flush_icache_user_page() is left alone, as nothing reads
another CPU's slot there, and init_new_context() runs before the mm is
shared.

Order the slot reads after the page-table changes with smp_mb(). On the
publishing CPU, the store in ev5_switch_mm() precedes the mb() in Alpha's
arch_spin_unlock(), when finish_lock_switch() drops the rq lock. This
relies on Alpha's unlock implementation, not a generic scheduler promise
of a full barrier on unlock; document that reliance at the store. Also
issue smp_mb() after publishing in __load_new_mm_context(), before loading
and using the mm.

This covers every caller, including check_mmu_context(), which can
publish a replacement after finish_lock_switch() has already run.

This requires the preceding removal of remote slot clearing from
migrate_flush_tlb_page(). It also requires the stale-TLB series to set
need_new_asn on both the reused and newly allocated ASN paths. Otherwise
an IPI between finish_lock_switch() and check_mmu_context() can zero a
new slot while asn_lock is set, and the task can return to user space
with a live ASN that the shortcut cannot see.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org> # 53ab52cfe5ce: alpha: load the MMU context when switch_mm() switches the current task
Cc: <stable@vger.kernel.org> # 01df8f401888: alpha: run check_mmu_context() from finish_arch_post_lock_switch()
Cc: <stable@vger.kernel.org> # ef43cfc28c42: alpha: only use a targeted tbi() when the target mm is really current
Cc: <stable@vger.kernel.org> # 738cf8f7a78f: alpha: invalidate the local context in flush_tlb_page()
Cc: <stable@vger.kernel.org> # 62c92086f30e: alpha: fix the local TLB invalidate in flush_tlb_page()
Cc: <stable@vger.kernel.org> # 3faee097b939: alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Cc: <stable@vger.kernel.org> # b2c3b654bb64: alpha: invalidate the local context in flush_tlb_mm()
Cc: <stable@vger.kernel.org> # f19ae6f51a38: alpha: invalidate the local context in flush_icache_user_page()
Cc: <stable@vger.kernel.org> # 471e7f9c890b: alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20261010144621.974850-3-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h |  7 +++-
 arch/alpha/kernel/smp.c              | 52 ++++++++++++++--------------
 arch/alpha/mm/fault.c                |  4 ++-
 arch/alpha/mm/tlbflush.c             |  2 +-
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index f41d7c73fdd64..09f356934b90a 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -159,7 +159,12 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	mmc = next_mm->context[cpu];
 	if ((mmc ^ asn) & ~HARDWARE_ASN_MASK) {
 		mmc = __get_new_mm_context(next_mm, cpu);
-		next_mm->context[cpu] = mmc;
+		/*
+		 * Ordered before any user access through the mm by the
+		 * mb() in arch_spin_unlock(), when finish_lock_switch()
+		 * drops the rq lock.
+		 */
+		WRITE_ONCE(next_mm->context[cpu], mmc);
 	}
 #ifdef CONFIG_SMP
 	/* A deferred shootdown can also invalidate a newly allocated ASN. */
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index e21bc3920bece..11768aa292a48 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -625,12 +625,30 @@ static void
 ipi_flush_tlb_mm(void *x)
 {
 	struct mm_struct *mm = x;
-	if (mm == current->active_mm && !asn_locked())
+	if (mm == current->mm && !asn_locked())
 		flush_tlb_current(mm);
 	else
 		flush_tlb_other(mm);
 }
 
+/* True if a CPU other than this one holds an ASN for MM.  */
+static bool
+mm_context_elsewhere(struct mm_struct *mm)
+{
+	int cpu, this_cpu = smp_processor_id();
+
+	/* Pairs with the barrier the publishing CPU issues before using MM.  */
+	smp_mb();
+
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+		if (READ_ONCE(mm->context[cpu]))
+			return true;
+	}
+	return false;
+}
+
 void
 flush_tlb_mm(struct mm_struct *mm)
 {
@@ -638,14 +656,8 @@ flush_tlb_mm(struct mm_struct *mm)
 
 	if (mm == current->active_mm) {
 		flush_tlb_current(mm);
-		if (atomic_read(&mm->mm_users) <= 1) {
-			int cpu, this_cpu = smp_processor_id();
-			for (cpu = 0; cpu < NR_CPUS; cpu++) {
-				if (!cpu_online(cpu) || cpu == this_cpu)
-					continue;
-				if (mm->context[cpu])
-					mm->context[cpu] = 0;
-			}
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    !mm_context_elsewhere(mm)) {
 			preempt_enable();
 			return;
 		}
@@ -690,14 +702,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	/* As in ipi_flush_tlb_page(): a targeted tbi() needs MM current.  */
 	if (mm == current->mm) {
 		flush_tlb_current_page(mm, vma, addr);
-		if (atomic_read(&mm->mm_users) <= 1) {
-			int cpu, this_cpu = smp_processor_id();
-			for (cpu = 0; cpu < NR_CPUS; cpu++) {
-				if (!cpu_online(cpu) || cpu == this_cpu)
-					continue;
-				if (mm->context[cpu])
-					mm->context[cpu] = 0;
-			}
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    !mm_context_elsewhere(mm)) {
 			preempt_enable();
 			return;
 		}
@@ -728,7 +734,7 @@ static void
 ipi_flush_icache_page(void *x)
 {
 	struct mm_struct *mm = (struct mm_struct *) x;
-	if (mm == current->active_mm && !asn_locked())
+	if (mm == current->mm && !asn_locked())
 		__load_new_mm_context(mm);
 	else
 		flush_tlb_other(mm);
@@ -747,14 +753,8 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 
 	if (mm == current->active_mm) {
 		__load_new_mm_context(mm);
-		if (atomic_read(&mm->mm_users) <= 1) {
-			int cpu, this_cpu = smp_processor_id();
-			for (cpu = 0; cpu < NR_CPUS; cpu++) {
-				if (!cpu_online(cpu) || cpu == this_cpu)
-					continue;
-				if (mm->context[cpu])
-					mm->context[cpu] = 0;
-			}
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    !mm_context_elsewhere(mm)) {
 			preempt_enable();
 			return;
 		}
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 24408b53197c1..63a24afa7a155 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -70,7 +70,9 @@ __load_new_mm_context(struct mm_struct *next_mm)
 	struct pcb_struct *pcb;
 
 	mmc = __get_new_mm_context(next_mm, smp_processor_id());
-	next_mm->context[smp_processor_id()] = mmc;
+	WRITE_ONCE(next_mm->context[smp_processor_id()], mmc);
+	/* Publish the context before this CPU can access the mm. */
+	smp_mb();
 
 	pcb = &current_thread_info()->pcb;
 	pcb->asn = mmc & HARDWARE_ASN_MASK;
diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
index 239c72b8a7412..a2aef90e6234b 100644
--- a/arch/alpha/mm/tlbflush.c
+++ b/arch/alpha/mm/tlbflush.c
@@ -66,7 +66,7 @@ static void ipi_flush_mm_and_page(void *x)
 	struct tlb_mm_and_addr *d = x;
 
 	/* Part 1: mm context side (Alpha uses ASN/context as a key mechanism). */
-	if (d->mm == current->active_mm && !asn_locked())
+	if (d->mm == current->mm && !asn_locked())
 		__load_new_mm_context(d->mm);
 	else
 		flush_tlb_other(d->mm);
-- 
2.53.0




