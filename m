Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA7377AB0;
	Mon, 28 Sep 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618736; cv=none; b=U8mDeeiucuORwtjnb8gSw182eNwMoYx31yPXtrJd3trSKSPqjNkC6CT/j012zrvKlGcPCvIOvhGIx1vY416Ey4WlBe9EJmsYZggkYjdBTIzlibc6EidIb5K6DmvOL4PNdra48c04jIknEQqabdUGq7qBRRqPdHdFRELzKv2nSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618736; c=relaxed/simple;
	bh=xoeJAooqo6eyYC44E8plqAqJ5e+ZAQ8RP867w0GjCrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aTHzqROqGJe6hf+bASFsQwl3AhYIHnV3fEnYrLsC6kz/v4+8VxYhvtXF4iEnVF8OO+YGGuPuaQJXiXMxNBlk40Dzl9aGSP+dIdtO6KW8rS/dJ2JJelrfIHNVU6kscuhmAMOSzEzybqoiOpnpVOES310SWDE7AC1jOlEfdzMDRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uyeZRByb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/LKUWtiB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uyeZRByb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/LKUWtiB"
Date: Mon, 28 Sep 2026 18:05:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790618731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQp/dsDY9xdfki1VVv84pJTQtS9vVcVFiQxPxF9QwnQ=;
	b=uyeZRByb0mySxrqXE/hj9ecGekKBVDQbgSzbaEEx1OdibNTkdUODIzU84vlgd/mO0bOzIt
	8AhgJrKctsPu7k2DfprT5gKWbz8Mskond8l8eliuz54UbQy32Y9xoKIhr5KizpMsLht+VF
	xMpP4H3TrPFhhKoIeOdqk+LWq83SiKVod3W51GjEE4RmjXv4gqs1RDo4dmFmUPV0AbXCol
	P7tRA2jytb7GjROKxGBWc83/NIJQajLVRQOeupkOcj8qNBYcKLTjw403EkI8BNE5FJCm29
	mzOLqxtITojpcfm13goSHPEiPVX8ZFTRZm8LxxfOlPKDn5Gm3Bmo1+QwbTi5cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790618731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQp/dsDY9xdfki1VVv84pJTQtS9vVcVFiQxPxF9QwnQ=;
	b=/LKUWtiBDfAbhuOIaS3ndwjGHEFQzRktvkm1UAfRgmVql+dzlyEaMVQXUjO80t/mJW+6y6
	m39xBdSCxAyY5kBw==
From: "tip-bot2 for Mikhail Gavrilov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Drop unnecessary PMD page copy when freeing
Cc: Pedro Falcato <pfalcato@suse.de>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923223116.20090-1-mikhail.v.gavrilov@gmail.com>
References: <20260923223116.20090-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179061872963.3910103.1639499464111114642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e3ee38c1bc0b11a8d3e63dce7050759b61864286
Gitweb:        https://git.kernel.org/tip/e3ee38c1bc0b11a8d3e63dce7050759b618=
64286
Author:        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
AuthorDate:    Thu, 24 Sep 2026 03:31:16 +05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 28 Sep 2026 08:08:16 -07:00

x86/mm: Drop unnecessary PMD page copy when freeing

On a box with a discrete GPU, lockdep reports a possible deadlock as
soon as kswapd shrinks the TTM page pool. The immediate cause is an
x86 commit that added an mmap_read_lock() to kernel page protection
munging code.

The huge vmap code holds the same lock over a GFP_KERNEL allocation,
which is a no-no now that reclaim can take it. That allocation is in a
page table *free* path and ends up being for dubious purposes[1].
Basically, it tries to avoid hardware setting Accessed=3D1 in page table
entries that are unreachable by the hardware, a non-issue.

Remove the PMD copy. Detach the original PMD page at the PUD, flush
the mid-level caches, and free the PTE tables straight from the
detached PMD page. With no allocation left, the locking issue is gone.

Lockdep splat/analysis:

  WARNING: possible circular locking dependency detected
  7.3.0-rc3-f6e7b42bf05b+ #183 Tainted: G     U
  ------------------------------------------------------
  kswapd0/269 is trying to acquire lock:
  ((init_mm).mmap_lock){++++}-{4:4}, at: change_page_attr_set_clr+0x29a/0x4a0
  but task is already holding lock:
  (pool_shrink_rwsem){.+.+}-{4:4}, at: ttm_pool_shrink+0xb2/0x330 [ttm]
  Chain exists of:
    (init_mm).mmap_lock --> fs_reclaim --> pool_shrink_rwsem

The cycle is built from three edges:

  1) pool_shrink_rwsem -> (init_mm).mmap_lock

     The TTM shrinker restores the caching attribute of every page it
     frees, while holding pool_shrink_rwsem:

       ttm_pool_shrink()
       -> ttm_pool_dispose_list()
       -> ttm_pool_free_page()
       -> set_pages_wb()
       -> change_page_attr_set_clr()   [ init_mm mmap read lock ]

  2) fs_reclaim -> pool_shrink_rwsem

     The same shrinker, called from reclaim.

  3) (init_mm).mmap_lock -> fs_reclaim

     ioremap() installing a huge PUD mapping over an existing PMD table:

       ioremap_page_range()
       -> vmap_range_noflush()
       -> vmap_try_huge_pud()          [ init_mm mmap read lock ]
       -> pud_free_pmd_page()
       -> __get_free_page(GFP_KERNEL)  [ enters reclaim ]

[ dhansen: Lots of changelog munging/trimming and merged comments from my
	   version of the fix. ]

Fixes: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute chan=
ges to avoid UAF")
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Link: https://lore.kernel.org/20260916062222.27347-1-mikhail.v.gavrilov@gmail=
.com
Link: https://lore.kernel.org/all/e11449f0-d9ad-4d1b-ab21-2be7d71fe335@intel.=
com/ [1]
Link: https://patch.msgid.link/20260923223116.20090-1-mikhail.v.gavrilov@gmai=
l.com
Cc: stable@vger.kernel.org
---
 arch/x86/mm/pgtable.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index cb03f5a..4a105f2 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -705,47 +705,37 @@ int pmd_clear_huge(pmd_t *pmd)
 }
=20
 #ifdef CONFIG_X86_64
-/**
- * pud_free_pmd_page - Clear PUD entry and free PMD page
- * @pud: Pointer to a PUD
- * @addr: Virtual address associated with PUD
- *
- * Context: The PUD range has been unmapped and TLB purged.
- * Return: 1 if clearing the entry succeeded. 0 otherwise.
- *
- * NOTE: Callers must allow a single page allocation.
+/*
+ * Given a PUD poitner, detach and free the pointed-to
+ * PMD page and any PTE page children. The entire range
+ * under the PUD must not have any valid translations
+ * and the TLB must have already been flushed.
  */
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	pmd_t *pmd, *pmd_sv;
 	struct ptdesc *pt;
+	pmd_t *pmd;
 	int i;
=20
 	pmd =3D pud_pgtable(*pud);
-	pmd_sv =3D (pmd_t *)__get_free_page(GFP_KERNEL);
-	if (!pmd_sv)
-		return 0;
-
-	for (i =3D 0; i < PTRS_PER_PMD; i++) {
-		pmd_sv[i] =3D pmd[i];
-		if (!pmd_none(pmd[i]))
-			pmd_clear(&pmd[i]);
-	}
=20
+	/* Detach the PMD page: */
 	pud_clear(pud);
=20
-	/* INVLPG to clear all paging-structure caches */
+	/*
+	 * PMD and all its descendents are unreachable
+	 * via normal page walks. Make them unreachable
+	 * in cached mid-level walks too:
+	 */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
=20
 	for (i =3D 0; i < PTRS_PER_PMD; i++) {
-		if (!pmd_none(pmd_sv[i])) {
-			pt =3D page_ptdesc(pmd_page(pmd_sv[i]));
+		if (!pmd_none(pmd[i])) {
+			pt =3D page_ptdesc(pmd_page(pmd[i]));
 			pagetable_dtor_free(pt);
 		}
 	}
=20
-	free_page((unsigned long)pmd_sv);
-
 	pmd_free(&init_mm, pmd);
=20
 	return 1;
