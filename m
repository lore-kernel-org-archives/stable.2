Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489355;
	b=LyXQ2HZqGUIGwKy0wRTR5pzy4lbn5C52wSh1jc3xUmEPJNnSpoDab3W0BXqPT0zaiNIk
	 wpbL28vClELBoGSx9xxwo13j785rNVhoUhzeVzVwrEgepXxGeE5rbXjGatvdMENgoZb2d
	 jWKTnjnYLOjdec3RHtuBqQCW3uPs+LCU52URLO4ryZHVlxXeaLPgOFQe/p4vZlRQslaDR
	 UG4+qncfPX4WZTVAsPW6r0eSPcwJ4T+X97xkl33Md3hDjCC4oHnmMrNz1BiBSkZnaHrse
	 G1vPvcd62vxJaLwRYMjXK9CVoK2Oe8KgrCt8NaEcOfjLlNpPLITTPoMdlMNd31LfjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489355;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lr4OEtUoUXwCXIp40SXa42hGoKPd81OBcx60bQWkmAU=;
	b=HoGwXO3Ou7M7UigGTeQ0AqMrNzPA+iU4se8ByJeAOvvJ5JyRwdt+iDUAx4QceJvg82Bb
	 drcOnJa6LmXMbtOYIxD/ZhBFjJNbYQU+MpSwT6jcCjBR3UcR520pYC+Xgl7e34CrfXhnJ
	 tL4R3fLnBZR0bIGiX0TxfIa3XdbuuedBXnadDJyPq1mOgvo4xcgc37C+DW8RxZ4EdkZ0+
	 y8J8MSdkSE5GEF0WuM+r9xIjfzSzO3YcyEWMdN+MSgftV9exNSMlIHBPJbybUA4b7PdEe
	 FBXlMhkIIBqWCoGaLJnyUDsobvHW4jqmv1HYoaHB650ZZNgK70aG4Vfhe5s1JKe4r3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLxnhfua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37579606A32C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLxnhfua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA931F000C5;
	Tue, 20 Oct 2026 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489354;
	bh=lr4OEtUoUXwCXIp40SXa42hGoKPd81OBcx60bQWkmAU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QLxnhfuaSEmUlTCmDlg2H+oTiid55Z8uuLpcWfd6CGYzdWhFTLVa5FpiXb8pY1sIn
	 SCzhC5z1I+3zKFnFcqeSt4GE/5QcLkKnsQPqVZNhMjo5l/6HX4nEfahIMtiXrUARmX
	 zd3Oz8EBmgtMe1jh42tbazdgHzMBk6NMZFfEB8yyWUtrr1O7Dge4rFYhOwHCP2qm3w
	 o/Osk0sQ+sDhQumxJ2leHmKVLPu+9mZvDiktsDNjFzMFYj1cYKfR93mrCIR1GKqxKE
	 hDCIYbEtr3hAPZPWTR482IAzlGmpHwsMT3Z8ITbwUyJpB5gi9stqcMn4Z3+Y3pulPN
	 uqDhZDx9QBfcg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
Date: Tue, 20 Oct 2026 10:42:30 +0100
Message-ID: <20261020094231.759650-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026092200-parchment-pursuable-481f@gregkh>
References: <2026092200-parchment-pursuable-481f@gregkh>
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

The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
confusingly only control the behaviour of THP in some instances.

They are not applicable to MADV_COLLAPSE operations, nor to DAX mappings.

Long-term, THP is predicated upon compaction being able to obtain large
folios to populate THP ranges.

However, vm_normal_folio() returns NULL for PFN map mappings, thus their
reference count is maintained by the driver, not core mm.

As a consequence, the folios are not subject to reclaim nor compaction, so
are not truly part of the THP mechanism at all.

However, since commit 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
introduced the ability to establish huge PFN maps, they have been subject
to THP tuneables.

This is incorrect - if a huge PFN map is available (defined by
vma->vm_ops->huge_fault being non-NULL for a VM_PFNMAP VMA), then it
should be mapped huge upon fault-in.

Correct this by explicitly checking for this while ensuring that smaps
continues to accurately report THPeligible statistics.

While here, abstract the entire file-backed THP check in
vma_can_map_huge_file(), with sensible separation of logic into helper
functions.

Failing to map huge PFN maps has resulted in significant real-world
performance degradation, see links for details.

[ziy@nvidia.com: rename some functions]
  Link: https://lore.kernel.org/DL1HIHWYJ7TB.1CY76SJS0V03L@nvidia.com
Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Cedric Le Goater <clg@redhat.com>
Closes: https://lore.kernel.org/linux-mm/20260805055544.1568534-1-clg@redhat.com/
Reported-by: Saravanan D <saravanand@crusoe.ai>
Closes: https://lore.kernel.org/linux-mm/20260821070520.25759-1-saravanand@crusoe.ai/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Saravanan D <saravanand@crusoe.ai>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e384abeb559d10d6505aec053ede9368d81d4c71)
[ ljs - Converted to tva_flags, made file_thp_enabled() const in huge_mm.h
   + other smaller changes. Updated commit msg to reflect. ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        | 79 ++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd34b70dd0cf..10e41e8b1634 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -254,7 +254,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-static inline bool file_thp_enabled(struct vm_area_struct *vma)
+static inline bool file_thp_enabled(const struct vm_area_struct *vma)
 {
 	struct inode *inode;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1a76a21724d4..2a7f42b8ca33 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -86,6 +86,62 @@ unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
 static bool anon_orders_configured __initdata;
 
+static bool vma_file_bypass_thp_tuneables(const struct vm_area_struct *vma,
+		unsigned long tva_flags)
+{
+	const bool has_huge_fault = vma->vm_ops->huge_fault;
+
+	/* MADV_COLLAPSE ignores tuneables. */
+	if (!(tva_flags & TVA_ENFORCE_SYSFS))
+		return true;
+	/* Huge PFN mappings are uncompactable so the policy doesn't apply. */
+	if ((vma->vm_flags & VM_PFNMAP) && has_huge_fault)
+		return true;
+	return false;
+}
+
+static bool vma_file_allow_thp_tuneables(vm_flags_t vm_flags)
+{
+	/* THP=always? */
+	if (hugepage_global_always())
+		return true;
+	/* THP=madvise and marked MADV_HUGEPAGE? */
+	if (hugepage_global_enabled() && (vm_flags & VM_HUGEPAGE))
+		return true;
+	return false;
+}
+
+static bool vma_file_check_thp_tuneables(const struct vm_area_struct *vma,
+		vm_flags_t vm_flags, unsigned long tva_flags)
+{
+	return vma_file_bypass_thp_tuneables(vma, tva_flags) ||
+		vma_file_allow_thp_tuneables(vm_flags);
+}
+
+static bool vma_can_map_huge_file(const struct vm_area_struct *vma,
+		vm_flags_t vm_flags, unsigned long tva_flags)
+{
+	const bool has_huge_fault = vma->vm_ops->huge_fault;
+
+	/*
+	 * Enforce THP collapse requirements as necessary. Anonymous vmas
+	 * were already handled in thp_vma_allowable_orders().
+	 */
+	if (!vma_file_check_thp_tuneables(vma, vm_flags, tva_flags))
+		return false;
+
+	/*
+	 * Trust that ->huge_fault() handlers know what they are doing
+	 * in fault path.
+	 */
+	if (tva_flags & TVA_IN_PF)
+		return has_huge_fault;
+	if ((tva_flags & TVA_SMAPS) && has_huge_fault)
+		return true;
+	/* Only regular file is valid in collapse path. */
+	return file_thp_enabled(vma);
+}
+
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
 					 unsigned long tva_flags,
@@ -158,27 +214,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 						   vma, vma->vm_pgoff, 0,
 						   !enforce_sysfs);
 
-	if (!vma_is_anonymous(vma)) {
-		/*
-		 * Enforce sysfs THP requirements as necessary. Anonymous vmas
-		 * were already handled in thp_vma_allowable_orders().
-		 */
-		if (enforce_sysfs &&
-		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-						    !hugepage_global_always())))
-			return 0;
-
-		/*
-		 * Trust that ->huge_fault() handlers know what they are doing
-		 * in fault path.
-		 */
-		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
-			return orders;
-		/* Only regular file is valid in collapse path */
-		if (((!in_pf || smaps)) && file_thp_enabled(vma))
-			return orders;
-		return 0;
-	}
+	if (!vma_is_anonymous(vma))
+		return vma_can_map_huge_file(vma, vm_flags, tva_flags) ? orders : 0;
 
 	if (vma_is_temporary_stack(vma))
 		return 0;
-- 
2.56.0

