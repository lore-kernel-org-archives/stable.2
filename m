Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415442900A;
	Sat,  3 Oct 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032215; cv=none; b=SgdVBidNsgqRXwjuC5hKjDjagMasR3y/rT8qJrd68vsjFZQNm/Jv6iTq+bo+XkxkgVB2AWh+WL3ewRMZn8d8pkrb7F4GWGSlWQ+bgt0YB/6ARmXCs+oj7tb8nSbAoQdCZI9nXdnZ+o3uIXFfQVvfj8vaxJ/9qmHzRYyS96PqqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032215; c=relaxed/simple;
	bh=mQmwLLWMpP49fgkvpOE5FMyX0Zz2z3YkwDa7C0xfDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXcmEOX61J6deNLodi9ytSkZP9NmONl+5Ttst3+Gt9OZUSMrdDKS6ZRyaj3pW35/2nS/M2Wil3tX9s/HKa4baxsDFuPA4x23UaWIkDBCBRqHf2yctbey+JO5p2FuylCcwOB1DjFGKchEYjXWaqHqPC6nrvIbVvSbzxzKP6wSvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=YrDmKIAL; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="YrDmKIAL"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791032206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9hY50QGcoitZ+sT5yT4aRtRd56Iz0IeV2VLERILCs8=;
	b=YrDmKIAL/pE2DrcWrAUeOFg160LC6eWK/9DRf8RSfn1tOP6SJLYsRrS4rCBaeijf2tO9/t
	kyJgu/awY1VJV2BBe2IPHKrmkkhUaFi0sXMvn6eJ+Pua11wKl8ZurYjefJSnVtaU38eOzd
	XTi4e9FHbcrRV9Mi1XJXqUfNwNnLBh8=
To: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] sparc64: keep flushing the old TSB while tsb_grow() switches CPUs
Date: Sat,  3 Oct 2026 14:56:25 +0200
Message-ID: <20261003125627.3419702-4-stian@itx.no>
In-Reply-To: <20261003125627.3419702-1-stian@itx.no>
References: <20261003125627.3419702-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsb_grow() publishes the new TSB in mm->context and only then makes the
other CPUs switch to it through smp_tsb_sync().  Until a CPU has run
tsb_sync() its MMU still looks up the old TSB, while flush_tsb_user()
and flush_tsb_user_page() only touch the new one.  An entry invalidated
in that window survives in the old TSB and is loaded into the TLB
again: a writable entry for a page that has since been unmapped, or a
read-only entry that keeps faulting.  Under a 256-thread compile load
on a SPARC M7 about 15% of the faults that reach the spurious-fault
path hit this window.

Record the old TSB in the context until smp_tsb_sync() has returned,
flush it as well, and make a second grow of the same TSB wait for the
first to finish so the record is not overwritten while CPUs may still
use it.

Fixes: bd40791e1d28 ("[SPARC64]: Dynamically grow TSB in response to RSS growth")
Cc: stable@vger.kernel.org
Link: https://github.com/sparclinux/issues/issues/108
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/mmu_64.h        |   5 +++++
 arch/sparc/mm/tsb.c                    |  80 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -115,6 +115,11 @@
 	bool			adi;
 	tag_storage_desc_t	*tag_store;
 	spinlock_t		tag_lock;
+	/* TSB being replaced by tsb_grow(), still used by CPUs that
+	 * have not run tsb_sync() yet.
+	 */
+	struct tsb		*tsb_old[MM_NUM_TSBS];
+	unsigned long		tsb_old_nentries[MM_NUM_TSBS];
 } mm_context_t;
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -135,6 +135,20 @@
 			__flush_huge_tsb_one(tb, PAGE_SHIFT, base, nentries,
 					     tb->hugepage_shift);
 #endif
+		if (mm->context.tsb_old[MM_TSB_BASE]) {
+			base = (unsigned long) mm->context.tsb_old[MM_TSB_BASE];
+			nentries = mm->context.tsb_old_nentries[MM_TSB_BASE];
+			if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+				base = __pa(base);
+			if (tb->hugepage_shift == PAGE_SHIFT)
+				__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
+#if defined(CONFIG_HUGETLB_PAGE)
+			else
+				__flush_huge_tsb_one(tb, PAGE_SHIFT, base,
+						     nentries,
+						     tb->hugepage_shift);
+#endif
+		}
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
@@ -144,6 +158,14 @@
 			base = __pa(base);
 		__flush_huge_tsb_one(tb, REAL_HPAGE_SHIFT, base, nentries,
 				     tb->hugepage_shift);
+		if (mm->context.tsb_old[MM_TSB_HUGE]) {
+			base = (unsigned long) mm->context.tsb_old[MM_TSB_HUGE];
+			nentries = mm->context.tsb_old_nentries[MM_TSB_HUGE];
+			if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+				base = __pa(base);
+			__flush_huge_tsb_one(tb, REAL_HPAGE_SHIFT, base,
+					     nentries, tb->hugepage_shift);
+		}
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
@@ -169,6 +191,21 @@
 			__flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT,
 						   nentries, hugepage_shift);
 #endif
+		if (mm->context.tsb_old[MM_TSB_BASE]) {
+			base = (unsigned long) mm->context.tsb_old[MM_TSB_BASE];
+			nentries = mm->context.tsb_old_nentries[MM_TSB_BASE];
+			if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+				base = __pa(base);
+			if (hugepage_shift == PAGE_SHIFT)
+				__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT,
+						      nentries);
+#if defined(CONFIG_HUGETLB_PAGE)
+			else
+				__flush_huge_tsb_one_entry(base, vaddr,
+							   PAGE_SHIFT, nentries,
+							   hugepage_shift);
+#endif
+		}
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
@@ -178,6 +215,15 @@
 			base = __pa(base);
 		__flush_huge_tsb_one_entry(base, vaddr, REAL_HPAGE_SHIFT,
 					   nentries, hugepage_shift);
+		if (mm->context.tsb_old[MM_TSB_HUGE]) {
+			base = (unsigned long) mm->context.tsb_old[MM_TSB_HUGE];
+			nentries = mm->context.tsb_old_nentries[MM_TSB_HUGE];
+			if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+				base = __pa(base);
+			__flush_huge_tsb_one_entry(base, vaddr,
+						   REAL_HPAGE_SHIFT, nentries,
+						   hugepage_shift);
+		}
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
@@ -460,17 +506,26 @@
 	 * accessing the old TSB via TLB miss handling.  This is OK
 	 * because those actions are just propagating state from the
 	 * Linux page tables into the TSB, page table mappings are not
-	 * being changed.  If a real fault occurs, the processor will
-	 * synchronize with us when it hits flush_tsb_user(), this is
-	 * also true for the case where vmscan is modifying the page
-	 * tables.  The only thing we need to be careful with is to
-	 * skip any locked TSB entries during copy_tsb().
+	 * being changed.  Processors keep using the old TSB until they
+	 * have run tsb_context_switch(), so the old TSB is recorded in
+	 * tsb_old[] and flushed along with the new one until the
+	 * smp_tsb_sync() below has returned.  The only thing we need
+	 * to be careful with is to skip any locked TSB entries during
+	 * copy_tsb().
 	 *
 	 * When we finish committing to the new TSB, we have to drop
 	 * the lock and ask all other cpus running this address space
 	 * to run tsb_context_switch() to see the new TSB table.
+	 *
+	 * An earlier grow of this TSB may still be waiting for the
+	 * other cpus; its old TSB has to stay recorded until then.
 	 */
 	spin_lock_irqsave(&mm->context.lock, flags);
+	while (mm->context.tsb_old[tsb_index]) {
+		spin_unlock_irqrestore(&mm->context.lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&mm->context.lock, flags);
+	}
 
 	old_tsb = mm->context.tsb_block[tsb_index].tsb;
 	old_cache_index =
@@ -511,6 +566,11 @@
 			PAGE_SHIFT : REAL_HPAGE_SHIFT);
 	}
 
+	if (old_tsb) {
+		mm->context.tsb_old[tsb_index] = old_tsb;
+		mm->context.tsb_old_nentries[tsb_index] =
+			mm->context.tsb_block[tsb_index].tsb_nentries;
+	}
 	mm->context.tsb_block[tsb_index].tsb = new_tsb;
 	setup_tsb_params(mm, tsb_index, new_size);
 
@@ -529,6 +589,12 @@
 		preempt_enable();
 
 		/* Now it is safe to free the old tsb.  */
+		spin_lock_irqsave(&mm->context.lock, flags);
+		if (mm->context.tsb_old[tsb_index] == old_tsb) {
+			mm->context.tsb_old[tsb_index] = NULL;
+			mm->context.tsb_old_nentries[tsb_index] = 0;
+		}
+		spin_unlock_irqrestore(&mm->context.lock, flags);
 		kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
 	}
 }
@@ -566,8 +632,10 @@
 	 * us, so we need to zero out the TSB pointer or else tsb_grow()
 	 * will be confused and think there is an older TSB to free up.
 	 */
-	for (i = 0; i < MM_NUM_TSBS; i++)
+	for (i = 0; i < MM_NUM_TSBS; i++) {
 		mm->context.tsb_block[i].tsb = NULL;
+		mm->context.tsb_old[i] = NULL;
+	}
 
 	/* If this is fork, inherit the parent's TSB size.  We would
 	 * grow it to that size on the first page fault anyways.
