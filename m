Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436D3E557E
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581120; cv=none; b=HMyXVhw9mfL6zyZJ0z6CLfZUTmRpEqHJ0sSUo7AzFbhV4DzOdYom5csW1vbwrdKejj3it1x58gbBic7Ar/xOD6O68MVgGaJbQpuZ6k/NvLyRIIMsCfS5r5t93l7Mr85LgpIEfzK93iW2MnHWP6SP+Zcg+caYeJnBDZz5s1ncVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581120; c=relaxed/simple;
	bh=kWJhYDl3jetLmITi55DG/GvSenKYpJfWpILC/vdyQBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEJ34tn7XBYQF1B7H2kwTD5yzv3MHpWL7Wn6Ewa1nDWfXz66kmxu0HHCBNUz/wdPoO/hWOLgrD1cD3Z/s9aHEjVMMcetV5uG+AVPxmFEBOOG3qJx8gUaRLekc4wruiQ0n5bTC95q86DTCzCtsVVRZMR5SaCGmE+rKxxTNWUYYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXg/vA/o; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXg/vA/o"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e2db5e8e4so50417366b.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791581117; x=1792185917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goRPK8xuz85F03Irn6Df02hbC5JG5Cr/Su8Nqvv+Oxc=;
        b=JXg/vA/ot0d7B6sRJ5P6Vt8OGDIIyPCgRFh5PlOnT4Md4wm+5FON9vN0gMZc+KHx28
         BZsBk61FZm6SKnPrmiC0WA2TWp2avPUv4SNSpW+m7VpeVJGJ+XUhLnsAGT0V3EdoGenx
         yOhysHA6qiUs+ZT4YKtSweCy1CI0CjnW35WnVMnVsm46tA5HZiP/+N3nKm1zDe8ciZlL
         m30IK37INUBMkrGHb/vs3bn3kYsz5aReUOGAB2vY9zPp5T747dGc89u4U7TSvl4BeOlm
         j8MqUSlI/fS/v3zC+e41Kn0YLOg43sFcWdCtfCblHJ93EUJs9jtZDOV625M+XRXYqjxO
         edEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581117; x=1792185917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=goRPK8xuz85F03Irn6Df02hbC5JG5Cr/Su8Nqvv+Oxc=;
        b=RN8kfdt72JqMN+ndwTUmgirkThkpdL/KgCQXTfsioet4wLJg1Q31o056TYfJk/gyuq
         JFGlzXsG17wprXPXE+TyovS7RbCLA/0KQnVnLCx+dWuu1h1cYZSNe9KF14pAGI3Vmteb
         MwYBeEiBr0omnjaLAw9nJfj0MESOGsZd4Qje2OJNQ6RpLTUPhEseQLQW1sxGHuiQ77Jv
         ZTD6H++Lo3Xn9HkCtJKpLS8OfOa84xqmm8fTF8cmhlw980afRa5mXhk8mr+1ooZqg3Nm
         zbNt8rPp/ZWwu4dptlnRSVDB8vgh8GPOWRL4cYsqVGkPumK0kQ2qvL4HNIshhTEzC0xG
         azXQ==
X-Forwarded-Encrypted: i=1; AKwUvBz52+cuBU8Zhy12LZY0lJftdMbxODMwBk4si0FVzLtQ+2G0Z3srhwnwPp0JbmPwNSKDEYdztac=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/Gsi/t+5atRbkCr1sk1pdk2Z3h13A+BQdfqNaMJ2BwoW+5gMg
	BQ0Lj7+QBSnrrw8gvQ/dcDdV2R3wTgTi7jNdWsgpygzQAxNPgVegp/UiAL9LpYCC
X-Gm-Gg: AYBFou1TwHjvefxhGSxNN8zCGpRA511/lhs29Y7DG/0f23jcETP5ZilKnZMpIj8BtUd
	J9NWnqPdsThbi38yFJTV7Mg6EuRtUkvbgOLpQdvS8R/LcqHrCCNLpiEQYkSqllVXqr9HYV0B2MV
	JEZaza+V9SDvqJemiU4LaDw2iDggTQzovLyKD/zbtg9LT2FS7Xj8KR3sV+rCt7SnKrR6kkJ4DAx
	eP230lXH/Kojqwi5Ozp6PnbcPn40ZJc+JRWL46SrTgAVr66HUtsvs3XU25AuYHzfTWO/EGys4Os
	kDfN3CDl+53VKS6U3ey7+G4HORGI0aStZi5gD7TcZ67vHPjzK8vaTXVYXyw7PV6kH+0y/glCGGQ
	dkBcaXvVo7K7QqDAVCWmve55+B0CvDSeLdznS5gRMnBwndzBbVxLy1mDa72pi1qwM53zahqIAsq
	gEbdQShPDtznOYeI9g543V3z6j3hkUmY6SDMLrTQDEzb/DnblSdEjHfyGgWFmqOHFhCyZYymLtV
	bZJweXM/UUduu1firclMydQrzLNeOZrhP7myVQL
X-Received: by 2002:a05:6938:e084:10b0:c31:c767:ae08 with SMTP id a640c23a62f3a-c31c767b038mr166831166b.0.1791581116707;
        Fri, 09 Oct 2026 14:25:16 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae42sm149079966b.15.2026.10.09.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:25:16 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
Date: Fri,  9 Oct 2026 23:19:36 +0200
Message-ID: <20261009212501.971158-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009212501.971158-1-linmag7@gmail.com>
References: <20261009212501.971158-1-linmag7@gmail.com>
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

Change ipi_flush_tlb_mm() and ipi_flush_icache_page() to test current->mm,
like ipi_flush_tlb_page(). A CPU that only retains the mm lazily then
clears its own slot through flush_tlb_other(), rather than publishing a
new ASN on every IPI. Once these historical slots are gone, the shortcut
is available again if mm_users remains at most one and no other CPU has
taken or kept a context. An explicit kthread_use_mm() borrower has
current->mm set and still receives the invalidate it needs.

Together with the preceding patch, dropping these clearing loops leaves
every runtime write to mm->context[] targeting the writing CPU's own slot,
so the array becomes a lockless publication of which CPUs may be using the
mm, with a single writer per slot. Mark the two stores that are now
observed from other CPUs; flush_tlb_other() already uses WRITE_ONCE().
The uniprocessor flush_icache_user_page() is left alone, as nothing reads
another CPU's slot there, and init_new_context() runs before the mm is
shared.

Order the slot reads after the page-table changes with smp_mb(). On the
publishing CPU, the store in ev5_switch_mm() precedes the scheduler's
post-switch barrier in finish_lock_switch(). Also issue smp_mb() after
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
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h |  2 +-
 arch/alpha/kernel/smp.c              | 52 ++++++++++++++--------------
 arch/alpha/mm/fault.c                |  4 ++-
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index e5a5737506db..f8a42f42a5dc 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -158,7 +158,7 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	mmc = next_mm->context[cpu];
 	if ((mmc ^ asn) & ~HARDWARE_ASN_MASK) {
 		mmc = __get_new_mm_context(next_mm, cpu);
-		next_mm->context[cpu] = mmc;
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
-- 
2.43.0

