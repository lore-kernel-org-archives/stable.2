Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE1383C84
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643590; cv=none; b=gx7g6llo1RRcUN4tyM/gsVSGZBN7UC6QaWEs/qj1MIdAGElheYhQhhRVSoAWndnqx+ddx7ouWb696dFrdXSRkWWNAiYP/CQw+GVS3Zo1PBkA5N3FBjck8oh1e+rVyecgRszr3apXy8h5tdOmeTMt4MGzr/0hd4iJ+9k25mwgk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643590; c=relaxed/simple;
	bh=u36p8Qyx0nPKavY7M4gB7jej3y+CQzljKWevE2Wr4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKp0Ke5RZiDvZcFJmac4jx2qt/1O+7HvNQ8G0AMM1bwbsCYC6h3yXoz4VTpo7pG5Pq1thMgwP2D5V5uV/shPS4PX4Wt60uG+aMGKdPVAhbxo165RBXIV9hCfrBOarMd95LRrHW6n60F13iqyFmy05c3gvFRcm3kVIGzZSc06uNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8JfMzjl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8JfMzjl"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afb0d2a586so1125325a12.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791643587; x=1792248387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wO1f3xuv0K+57q0XhGwwYjSiZ9yQpNcC/c9QnqLyCFI=;
        b=K8JfMzjl4hrGvbOEL8eTNVzmjok0dKFzJ5RU6/nv4ga7B0YwilcqGBBs/vaJL2KpZw
         oKBFjJ2no9uqIVPhJBPqS7T+yxGcu/VQVLa74eul1VaGDrDZq+MXlWJvlzOphpPfTCyO
         C9+VXCgSif3Oo3w97m3bDlMm8FgoUe6C1B+A20f0ed4/OS+8wRXu/ZydOjXNLScP8bZi
         GZVih5OTAorKA9RsY3Pd124/1yfvNsUDBbsJ5poYMeL83BdzXH+9eT8tWWm8vVETgVP6
         4QqZTaEiKIF9vqY9zHG87GK2Ylaz3Xrx0AXPFrE6pfDYNqfJqwX4OgBrw6ZAVSXBBout
         75eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791643587; x=1792248387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wO1f3xuv0K+57q0XhGwwYjSiZ9yQpNcC/c9QnqLyCFI=;
        b=xEI/aVBP3fno79ZnQsQXZ9PQ8DOXsx4fKkmNC+YiFRj8ksmhVwpeNuKnNSOQV3+2tr
         RmF4/xzJGwGvKHr+faIYrhoiUnke6q3C8T0Rvec/tjf9mKKSOeklCtlfr09vGVOI/yTc
         ArgrGyXvhVkZWDZ9mj6emtZ9WLUHueBjtU/2/7iYv+jUbB5jgiY21wgp2CSv9Eu7Xbak
         Oqiw435d3vh3SBxO0/TVsqMtZYbub7mXfK9+aLo+OhY89wH+XoTRA8Tkm3rI52QNjzrt
         zMq8+It/Lum+FXU/U5JbEFV6Hc8+4G+W/vfbM3lYXQH4oUjYTe0CeC42jHBKKUu88rg4
         alBg==
X-Forwarded-Encrypted: i=1; AKwUvByD+SuNwkmyrQL+mFTn5VixX+QUbzehc9otQlXaiWubvwJ7Qqr95PoIYTgC1uTbUd//gLcc2RI=@vger.kernel.org
X-Gm-Message-State: AFq9FYITJ7IFtl6Ec/zdbo0ItBKjh3snC8KxtRujt8qrenTwlboiMhH9
	MGX4lWZeQemF7WCUkacoWjY4idh94UaMt/iR/ksV4O+NeuGnoIuJB2vIUQqhDbII
X-Gm-Gg: AYBFou3NqzUR0MErWzk/l27A9Lv0Z51cneRfYejUtAJmX0Em7//T9aWlcfP2OR0OcrQ
	1Mk3D9VPYIJTU43v4xpNsLFap4l2PR9BNi9pKP7yDeL3ijum7ipgR/nUo7f9AXvz8Be7u6tr3IL
	2o7OjVPIygfU+skSxiW4y9PKHDcK1SAYOx8TE5syAURjZGOZDgfwKJ+/XyWBTnYNakPODGEJ4pu
	QSXUz8W+4H5bhXjGtNfe1d4hKgFtXAbNDpf08ZS0LrQ6V0OnNFnXa2VD//iJVNxLUuFAeq9p9q/
	5gLa7NgGWx1+61WQRlFtzRl/NBQfQHmIYi3JBcyjb3NfOpzz0QpRHiDezB/iEKwbwji6WAeaH3u
	xVqDSw/uCL1URbcWJ9xBM1noH9amFNHj58/SzBNwTF9AKOQZvmOBXjCnCHEdqwieUBvsdF/ratB
	w4sBfbVrpIa2reIA9u96lrcj22sIeWuqMB13uKMkPuH6JuOIRs7sgmqiIT2U5TDXjeZUbb/nU1u
	anSWWTmViu3TUxxhIvZs8NLg0/VA1RwqADqkIrB
X-Received: by 2002:a17:907:3d0b:b0:c31:7495:e5b with SMTP id a640c23a62f3a-c31a9feb26amr528677766b.10.1791643587152;
        Sat, 10 Oct 2026 07:46:27 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9767227sm247286566b.11.2026.10.10.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:46:26 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
Date: Sat, 10 Oct 2026 16:33:11 +0200
Message-ID: <20261010144621.974850-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010144621.974850-1-linmag7@gmail.com>
References: <20261010144621.974850-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
of a full barrier on unlock; document that reliance at the store.
Also issue smp_mb() after
publishing in __load_new_mm_context(), before loading and using the mm.
This covers every caller, including check_mmu_context(), which can
publish a replacement after finish_lock_switch() has already run.

This requires the preceding removal of remote slot clearing from
migrate_flush_tlb_page(). It also requires the stale-TLB series to set
need_new_asn on both the reused and newly allocated ASN paths. Otherwise
an IPI between finish_lock_switch() and check_mmu_context() can zero a
new slot while asn_lock is set, and the task can return to user space
with a live ASN that the shortcut cannot see.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h |  7 +++-
 arch/alpha/kernel/smp.c              | 52 ++++++++++++++--------------
 arch/alpha/mm/fault.c                |  4 ++-
 arch/alpha/mm/tlbflush.c             |  2 +-
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index e5a5737506db..46b9b82f3895 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -158,7 +158,12 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	mmc = next_mm->context[cpu];
 	if ((mmc ^ asn) & ~HARDWARE_ASN_MASK) {
 		mmc = __get_new_mm_context(next_mm, cpu);
-		next_mm->context[cpu] = mmc;
+		/*
+		 * Ordered before any use of the mm by the mb() in
+		 * arch_spin_unlock(), when finish_lock_switch() drops
+		 * the rq lock.
+		 */
+		WRITE_ONCE(next_mm->context[cpu], mmc);
 	}
 #ifdef CONFIG_SMP
 	/* A deferred shootdown can also invalidate a newly allocated ASN. */
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index e21bc3920bec..11768aa292a4 100644
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
index dfe427d93072..5b62bdeabe2a 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -69,7 +69,9 @@ __load_new_mm_context(struct mm_struct *next_mm)
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
-- 
2.43.0

