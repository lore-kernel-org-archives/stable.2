Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273412;
	b=zCT26G10AxRLC1hxhemJqE9rzTAZQ+tF/eHGHT06Rf0CH/p6dp9N+OeBy3nX/jlBEltf
	 nWxgq8JAyaXrzR+fJqosE5AyK/ZoXbiAk2y0r4Dc13qKZaS+A5ygr+M8xKHGq76Y6QDHT
	 5dIKB5/0avlDw7dwlZPg/Ps+vM/1/ZDwt3/CKfLQ+l3VwZ+RduKLUqz0NulOMn7qvPQx9
	 SgZtbu7gQ1Tk6OwKVOp3p4+pqbi7tUK7RyKLAWAZGza6o+eHn3GEfXt1tDk5hXklAPVvd
	 /cFVPsX/4L82bOl5oVM2om1xsYfWE6Y+OW9WVLO9MSfK8l8Gky22IoZixsRVgdoU8AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+M5QON0drYCV2Veq4sMb9tV4DT/5WmBEbDI9PAk8VmY=;
	b=lCxr8oU6RP7F0kbZBzw9KLXfYX0T+Vr76XRiWOl4IzVudV2XkW9uUex32D+ED9B+dzpj
	 t9k6mTWu6hT8ohsk5wULZoRwYNhQxsMfZbCsI/0OfUxS6/7L8DiUFv2cuOaiHhEAQPqzH
	 MxAdu9tnSYDvA5Pb8Pwrf+KBKj/BtfJupo3QQlbBCLU6fVgOJYJzvcFlTwZo8gBmJRzzf
	 oHKe/Qlyny9QaUI1mRctjFmjxTRG9F1+NO6MuGOEdz3ZLRERHpX93XiGZ1p5snDUnpUKR
	 2f8uRoMLAIngvUctPmP9ejFnKKNB4vUru4l4mXwFn+x85uUvaKu/ETJkT2sKhiXciiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd7eApWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd7eApWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF551F0089F;
	Tue, 10 Nov 2026 01:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273412;
	bh=+M5QON0drYCV2Veq4sMb9tV4DT/5WmBEbDI9PAk8VmY=;
	h=From:To:Cc:Subject:Date;
	b=Dd7eApWD97ra9wepNHJ7QRAc2iLHBaxG6cFq5Xapbyp6tLhVvm8SIpXSV8F9Jv7qR
	 BZjDMVFyLXiw+qSDEr5BG40hljG6e6hUTjhHSBwzi1BaiW8oypeMh5oU/gp3ITVes3
	 vE7DQyEqgzuCEmdrkWBMtReui1udx6bZ5ebzdaz7sKsYMjesyEgFXv7cpvzPYXrAWl
	 uZIN8wK3Kt6D2a1TPIB4GnVjX02aC+05gBE2WE9NS4XEvKsNOYyKbXuqG9dWbUixf+
	 TkDz4DE2wERY87eK6jtrvS36hi4rvmXPDxKmO/kT5T2K8H6vWs99OxlEqLgvbO83Up
	 OtiTFSOJElF3g==
From: Sasha Levin <sashal@kernel.org>
To: lizhe.67@bytedance.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterx@redhat.com,
	rppt@kernel.org,
	azpijr@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix mremap move length truncation" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:50 -0500
Message-ID: <20261109201650-failed-6.1-dfb190302d2b@kernel.org>
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
git cherry-pick -x dfb190302d2b4af86c6ae48af0d3b09f28b35460
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201650-failed-6.1-dfb190302d2b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dfb190302d2b4af86c6ae48af0d3b09f28b35460 Mon Sep 17 00:00:00 2001
From: Li Zhe <lizhe.67@bytedance.com>
Date: Thu, 22 Oct 2026 11:45:41 +0800
Subject: [PATCH] mm/hugetlb: fix mremap move length truncation

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
---
 include/linux/hugetlb.h | 15 ++++++---------
 mm/hugetlb.c            |  7 +++----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5029c72418631..58f755e70e966 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -121,10 +121,9 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
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
 void unmap_hugepage_range(struct vm_area_struct *,
@@ -338,11 +337,9 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
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
index da5d04edf7c10..506729ebaee75 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5195,10 +5195,9 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
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




