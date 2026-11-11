Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419915;
	b=XgMDnSlFOAqa+xHD6QTnPn76fN9Ne4UuyPg7HZP1ilBr9GMwpV2rAIt5G/Nc3TosFR2i
	 6eFuzv2DQvzU28Fs9Ug12JPRJ+86fXtp9Wbn+WTKFIKIfo1MQxnsv4xfOhVllxJYetEEI
	 TCHnSOk8j7vX6MeLeTgNuvYPR3AyM5MqG67EcaJUdroMepax3odXyZsmMTViF5Y2/IQSq
	 PmErDUv14PJMN590gmFXSeOv8Nt4k+rQ38UUYeMlz8rKZ+MD5V77DicfdHuub4YYEwVGX
	 SsPwHOVVNW95N6CWB5nbV+n+x3cbW7UOuCjBYeypGHuZ3522hLGB/D23Q3IX8RHw/sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0AT16HpCenv9V5s/DWiwuIRpV3ZuP5YVzN8/m3WI64E=;
	b=0KT9N5P1jwanuI7V8hCplWao0fYK/Eo7gnyCcOv+psTagK/FeJNFxFhTm4PaUGj88BOO
	 2zUjz0qpHp/TQhsxf/WpdFiYLNA4mIu3xXG/a1WZJ2xSwkfkgUALxOUs4i5ac3SUPlB1X
	 1PSO6zEJPI3VIV+BjpjspuDW2tx7V/zQZWUtc9NVJF875iauHlD0N+A5cP1eqm95idSDI
	 lO/c6KjPCB6EF5CqGcPuTN+8O2crfd84PjJ/bYNEAWkpbwKvo4BdU+iQYk+Z+g2/3cG2X
	 UXfb1OB5wAZit6oi4oPQzINrehwYW+STNih2BdZeGpeuiFuHR0Y+xcOveNFsU8W7BCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfQBMvwJ;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02233606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02233606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfQBMvwJ
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4682977f9aso440760766b.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419913; x=1795024713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AT16HpCenv9V5s/DWiwuIRpV3ZuP5YVzN8/m3WI64E=;
        b=rfQBMvwJG1+xG12ND5VK0UmgIJJGBdrsl9M1zEO4iXIg3lgEb4sS7hwJRCIhXOfNI2
         diaVyPvG6QcwHM+VJ+GMCytpYu5ufzERoijcfV6BmmxWkgbJ50Od7jyhgWHQMtO9hWff
         HeB0Q6MCD5CwHmoWn4+Es60Zlajzk03pfXFt7gbj0rR6vtS5i2E51OzNLIweTojBGvVo
         Ke9ojgJ412bdegUfIHc3rDhvfsrP04pIq4vei2QCKrM+leVl6cFIXYCEpVgIs2IYR/Uz
         dwC6h4XCjY7XS1OdQT2V6SkN9DJdNSzBPh4m9MqU8C5C7n+AgUQZrI1BTmEcG1wjsY0R
         DVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419913; x=1795024713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0AT16HpCenv9V5s/DWiwuIRpV3ZuP5YVzN8/m3WI64E=;
        b=ZqTbE6f0Xv9mN0lzbQvpI40PoXbvK0KOtMIjo+N/OUFSRYdmbxzHbt8rPYsAIIaigz
         s3vmt3HUZl5bJRE2meW0UkPqmYkD58qBY6BilIdB5BV8cXhNXFiaMUYdro343QY3BC66
         3Ld2vqYM2vsGwHzIH3TUPdxY48frdSGQKvdkxBTOgujyvZd4haBMcqJzfMhKnv7EcC8l
         n0Mxh22sjpgPlACiaScLTshXGexaxgNYme7VxKG74RQhpQw1FGRfQj0YXl2Gzay98Etr
         8jasl5FGkmBRvErSTeEdoPlI3RR3OpCezZS8LW5vTDYG1Zm0nuf/QBVtVWKuBAk38lK5
         p55Q==
X-Gm-Message-State: APuU4Z9WA49wp2Oib9dAx5eopbdgdW2f2cfEBrNQpSyWjEYRG+IwU6e2
	pkK70SgNicBsKB6PFQv7YQ0hiceehi/7j0ibPRopuQympEx9fE5cP19+i0kbJQUXXeg=
X-Gm-Gg: AYBFou0/pwcRmiH6Ay8pJmUDNMXTg0N/i9j4IYdZwU1AAbDcPHDepqAWpnA5lfvwlQu
	dPQ5F61gLs6gB1+UA0DZtFhEUsY/xe1NL4vo90oLVNAE0JvHSd7VCf1nbtbDX4/o6OKtQQ/ZrIY
	W+gyFJKt6cf+7CONJyBOEX1wRsdu0E2/gdRxsbgO6fO8Delg+vSGPhGlnfdKBvsl0qwV7gTdLOe
	3iLdNQF1Q2KlpiqUoOr+igo0lmY+WiYO7wok8MLub56ejSw0wvWoiAhGfNqKEQ92m5Qo9bo1s1b
	QcNXJt5TgRSwB95wtJLYYuQB+6c72vfTe5mhKU2u0H5lxfaWUDHMVVx7xweTnuujKcG73gqB1jO
	DExOHAgGK1DZkgVjSZY9ZmlB869/8CUtTMUthVeCkRub+TEWrdPr2c3eFCCjngvM5x0pWlTOO4F
	0TGfkY3BZja3Se5pZl+wM9IwYj+dcMOg0AdPPGKtyjpFClQ5T0Bv4A8vrfeqsZwMbEW7Y6Sugz0
	UZYhWRQBtqcnd5Qj6VVSeu9teF6QFHKc2lYeKv0aA0Rrjv+fCMYGJl/LaEJX4XjKRDWJ17ZuvQ7
	RnrLmm4x7RDxBKa2+qfSfPUU228wq13ROyWv34AZ9LnCApvj/NIXLPys0cmBjTN0Ipbj3pk=
X-Received: by 2002:a17:907:9447:b0:c3f:dce3:20d5 with SMTP id a640c23a62f3a-c5066b155f9mr269975066b.22.1794419913013;
        Wed, 11 Nov 2026 09:58:33 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a591485sm255131266b.32.2026.11.11.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:58:32 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 6.1.y] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
Date: Wed, 11 Nov 2026 18:58:09 +0100
Message-ID: <20261111175819.1156018-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107055102-failed-6.1-fe221b7b2d3e@kernel.org>
References: <20261107055102-failed-6.1-fe221b7b2d3e@kernel.org>
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

[ Upstream commit fe221b7b2d3ecd042dd391f74ff6a6fdeb7c2038 ]

Keep the older 6.1.y callback argument cast.  The Alpha migration
callback is present here, so that hunk is retained.  The prerequisite
which stops clearing remote MMU contexts is already in the 6.1.y base;
the remaining stale-TLB prerequisites are in the current stable queue.

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
(cherry picked from commit fe221b7b2d3ecd042dd391f74ff6a6fdeb7c2038)
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h |  7 +++-
 arch/alpha/kernel/smp.c              | 52 ++++++++++++++--------------
 arch/alpha/mm/fault.c                |  4 ++-
 arch/alpha/mm/tlbflush.c             |  2 +-
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 14f85e7e8838..723dc3821c42 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -160,7 +160,12 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
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
index afa4b990f922..530825b0fa8e 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -629,12 +629,30 @@ static void
 ipi_flush_tlb_mm(void *x)
 {
 	struct mm_struct *mm = (struct mm_struct *) x;
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
@@ -642,14 +660,8 @@ flush_tlb_mm(struct mm_struct *mm)
 
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
@@ -694,14 +706,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
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
@@ -732,7 +738,7 @@ static void
 ipi_flush_icache_page(void *x)
 {
 	struct mm_struct *mm = (struct mm_struct *) x;
-	if (mm == current->active_mm && !asn_locked())
+	if (mm == current->mm && !asn_locked())
 		__load_new_mm_context(mm);
 	else
 		flush_tlb_other(mm);
@@ -751,14 +757,8 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 
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
index 1179b7df4af9..de5e04dd8893 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -45,7 +45,9 @@ __load_new_mm_context(struct mm_struct *next_mm)
 	struct pcb_struct *pcb;
 
 	mmc = __get_new_mm_context(next_mm, smp_processor_id());
-	next_mm->context[smp_processor_id()] = mmc;
+	WRITE_ONCE(next_mm->context[smp_processor_id()], mmc);
+	/* Publish the context before this CPU can access the mm. */
+	smp_mb();
 
 	pcb = &current_thread_info()->pcb;
 	pcb->asn = mmc & HARDWARE_ASN_MASK;
diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
index 239c72b8a741..a2aef90e6234 100644
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
