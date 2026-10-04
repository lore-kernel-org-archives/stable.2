Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB1134CCF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109083; cv=none; b=Mjo/Oaqm32Zfag7vTo/G5Hi8/wNItofjl44WWSqgR/swz0+B/NUHZ/jC8Z9+QM8J98xwBnJehUsPULzy4AeU50uLFYExwkFIu0UtFt3Tlfuta4/Uaq0WnIL0F892nonI66NViXN3OphNEqfb9bp0914NRiaTLVWaMRiDo5plUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109083; c=relaxed/simple;
	bh=b/LgGm1EOGBpbW7tHj00rQQUXX2xeB3sLsMHhL7OH7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzsTx8nFvkf6Nq/ogRD8jg8X0T2yVyD4blC2gPJka6wWGl8Nbue9yaY8TWgW/hNM8+mEPyEQIlubmVvPfnXZ0xQENUb1wsEMUKjLNNNiK+CGiLyIkPNcq4/nb1DKQ/ah/iapQltyob0XboPChfkXgz98cwl67RoA85FWWRyGSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKT/5Cxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKT/5Cxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D614D1F00893;
	Sun,  4 Oct 2026 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109082;
	bh=codrfXEhc8e/x8ZLZ/rHvM5nx0Ny6Ju3hSp03gtfa80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKT/5Cxa5If3JocY9b7O+x5VcYQeYdRPKSD07MbDzPZH5DIlMmOmPQyEsoSU2geMe
	 rGqPoZ4WGd24x2RFkt4q8RxAr6YGGraYsWIIoKZPTJkadqzna3i9NpdXZxqKz8KM8W
	 h1ZuiugXdVQOg8qtIHBrkBVQ3WOm0fJZg2GjyXOnZnM9bNkm9Z4n4hovboNoCXQm2i
	 K2KI0zpBNynK1pAK4ZyKaVxGkoNAytGM1AP9b5gXfxkKZYhskKqJ52n20GBw9nYkPO
	 d3UKcGVrJB1VXtxHKJjqCt2Wn/uEFFvnhsn0KU1HOvw2x0C9+hmlVSvKUvoCzr6X3A
	 ZlxEjSqKxXk2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm: shmem: remove __shmem_huge_global_enabled()
Date: Sun,  4 Oct 2026 06:17:54 -0400
Message-ID: <20261004101724.1697042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100338-roundworm-goatskin-a51b@gregkh>
References: <2026100338-roundworm-goatskin-a51b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 4a9a27fdf7bfd29013491aea45e3512988cc5876 ]

Remove __shmem_huge_global_enabled() since it as only one caller, and
remove repeated check of VM_NOHUGEPAGE/MMF_DISABLE_THP as they are checked
in shmem_allowable_huge_orders(), also remove unnecessary vma parameter.

Link: https://lkml.kernel.org/r/20241017141457.1169092-2-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 72c3d682c165 ("mm: shmem: ignore sysfs configs for shmem forced collapse")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 51a0f94e6d9fe..e760dc2d7d41e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -559,17 +559,15 @@ static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					loff_t write_end, bool shmem_huge_force,
-					struct vm_area_struct *vma,
-					unsigned long vm_flags)
+static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+				      loff_t write_end, bool shmem_huge_force,
+				      unsigned long vm_flags)
 {
-	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
 	loff_t i_size;
 
-	if (!S_ISREG(inode->i_mode))
+	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
 		return false;
-	if (mm && ((vm_flags & VM_NOHUGEPAGE) || test_bit(MMF_DISABLE_THP, &mm->flags)))
+	if (!S_ISREG(inode->i_mode))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
@@ -587,7 +585,7 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 			return true;
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
-		if (mm && (vm_flags & VM_HUGEPAGE))
+		if (vm_flags & VM_HUGEPAGE)
 			return true;
 		fallthrough;
 	default:
@@ -595,17 +593,6 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 	}
 }
 
-static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-		   loff_t write_end, bool shmem_huge_force,
-		   struct vm_area_struct *vma, unsigned long vm_flags)
-{
-	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
-		return false;
-
-	return __shmem_huge_global_enabled(inode, index, write_end,
-					   shmem_huge_force, vma, vm_flags);
-}
-
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
@@ -783,8 +770,8 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 }
 
 static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-		loff_t write_end, bool shmem_huge_force,
-		struct vm_area_struct *vma, unsigned long vm_flags)
+				      loff_t write_end, bool shmem_huge_force,
+				      unsigned long vm_flags)
 {
 	return false;
 }
@@ -1224,7 +1211,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(idmap, request_mask, inode, stat);
 
-	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+	if (shmem_huge_global_enabled(inode, 0, 0, false, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1725,7 +1712,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 		return 0;
 
 	global_huge = shmem_huge_global_enabled(inode, index, write_end,
-					shmem_huge_force, vma, vm_flags);
+						shmem_huge_force, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
 		/*
 		 * For tmpfs, we now only support PMD sized THP if huge page
-- 
2.53.0

