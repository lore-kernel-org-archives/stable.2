Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794692075;
	b=dVrcsP/YCq1dK5icBAP3fb8qTJ5QQEhiFxQsNvdz2Nm+M0WDxYZL5v02UbBtAklGudPu
	 dDjoihR6Rm0kDnk1ogVIB10D1MuuRRzMKD6n44wtH5qDAKciQQBEBzoVPZ0nXV05hOnpS
	 mbrwssIr3m2qaZgp7ikQyQ5vKItH3hkWkdKeKm/L7aDOHoJDaEbzox9SiWLmq2gjFqNL1
	 BjV2OS0aXjMDCSCrhh45vSNjnBy+12X70PN/Pa8odu9nnzvFknVa9QQuIRM4urVDU0wTQ
	 sp9HBwhRqlGMiIKkFkJQBveBqmx01ubpeGbTyKPOrtVBODliZeFUWEyaxNexNYlRTaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kvjCl4OBZk4Wa0QQkFjE81mROj9QDUjvtEEd3ZQZGB0=;
	b=q91DpZMgi0slg2jPNq+0WrmISKWvS1QCwvLKFt+Swrn83VAWgMRHPpkM22mqJG2mdWIO
	 lESWZbXNipiR5pzqGaLHSo44dxIYBLoJlznDvOt6NBgAsvOjc/KgHkC7SbnPF+jFOu5RV
	 6hc/mmTc4n9oLgRPVsQfsKZkpAKOqusf78r6QEyyYxc7J2OlKNm7jHH43zEXmjLSoeEA/
	 DKljdpUXz1/PYbzlkacPXrE3va49zdobMjek41ki+mfvo4d+6yiTv/R51KfOkhVnZJo4F
	 YVsVUq3gYSPUQlPcdYWO0zOc9e0eHhbrkrUOqVi98mxZLAN9YKY4NHYR8uhe/4nlO6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DItjYzqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86938606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DItjYzqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D301F000C7;
	Sat, 14 Nov 2026 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794692075;
	bh=kvjCl4OBZk4Wa0QQkFjE81mROj9QDUjvtEEd3ZQZGB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DItjYzqaShRjco7vpMygOaeGcmIoy21gXykA2H0C2UI/zobODpreO1NewpS6/Sqb9
	 Tp6fbTIGxRdYZzm+ZztZW5bSJuHnH5Z1DAd+mLreFN+ln+YtADyHgSUZ8od6x9skWk
	 QRDEmahkFjxBsEetV2xy9NAGnBdB550nun1DAXj1KIjAppNO88TM+icTcFKunDxyaa
	 QIMUZAZIOBOa4nf+wn4RR2RBmaBdDx6DhlKbpyVZACrwFfGHNIWO9uj2kGy5Awg4VO
	 zZ9A/GoHgEH0Mg3ElxjVE876MWTFPvS+g3cfhyxlXYNPh4kEvfnYfu/mJ/eDwCbKSg
	 3OFIae0x2a0+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Zhe <lizhe.67@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm/hugetlb: fix mremap move length truncation
Date: Sat, 14 Nov 2026 16:34:30 -0500
Message-ID: <20261114213405.501279-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114213405.501279-1-sashal@kernel.org>
References: <20261109201650-failed-6.1-dfb190302d2b@kernel.org>
 <20261114213405.501279-1-sashal@kernel.org>
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

From: Li Zhe <lizhe.67@bytedance.com>

[ Upstream commit dfb190302d2b4af86c6ae48af0d3b09f28b35460 ]

Patch series "mm/hugetlb: fix mremap bugs", v3.

This series fixes a few hugetlb mremap bugs.

Patch 1 fixes the return type of move_hugetlb_page_tables(), so large
hugetlb moves cannot be truncated when reported back to the generic
mremap code.

Patch 2 disables hugetlb PMD sharing for UFFD missing mode, so
UFFDIO_POISON markers cannot become visible through shared PMD page
tables.

Patch 3 fixes the recursive i_mmap_rwsem deadlock in the hugetlb mremap
path by avoiding the destination PMD sharing allocation path while the
mapping lock is already held for write.

This patch (of 3):

move_hugetlb_page_tables() returns the number of bytes moved, but
its return type is int while the generic move_page_tables() path uses
unsigned long lengths.

A hugetlb mremap() move length above INT_MAX can therefore be
misreported to copy_vma_and_data(). The out-of-range conversion to int
is implementation-defined; on common 64-bit builds, for example, a
4 GiB move can be reported as zero, making the caller treat the move as
a failure and use the wrong length for rollback.

Return unsigned long from move_hugetlb_page_tables(), matching
move_page_tables() and preserving the full byte count.

Link: https://lore.kernel.org/20261022034543.51226-1-lizhe.67@bytedance.com
Link: https://lore.kernel.org/20261022034543.51226-2-lizhe.67@bytedance.com
Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h | 15 ++++++---------
 mm/hugetlb.c            |  7 +++----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a9f175cda955c..86262b82ef8ad 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,10 +137,9 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
-int move_hugetlb_page_tables(struct vm_area_struct *vma,
-			     struct vm_area_struct *new_vma,
-			     unsigned long old_addr, unsigned long new_addr,
-			     unsigned long len);
+unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
@@ -296,11 +295,9 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 	return 0;
 }
 
-static inline int move_hugetlb_page_tables(struct vm_area_struct *vma,
-					   struct vm_area_struct *new_vma,
-					   unsigned long old_addr,
-					   unsigned long new_addr,
-					   unsigned long len)
+static inline unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 459116c744a5a..a833a736c6ce9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5304,10 +5304,9 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	spin_unlock(dst_ptl);
 }
 
-int move_hugetlb_page_tables(struct vm_area_struct *vma,
-			     struct vm_area_struct *new_vma,
-			     unsigned long old_addr, unsigned long new_addr,
-			     unsigned long len)
+unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping = vma->vm_file->f_mapping;
-- 
2.53.0

