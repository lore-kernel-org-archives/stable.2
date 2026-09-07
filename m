Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94F51D506;
	Mon,  7 Sep 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800647; cv=none; b=cpEKmaqOxQlqKteuwVfWBb09RpZvcv2hg9MtJReMoEhBYdPhgK7n1zUfZo2GWtwoB9KHs/OtJyA3Df4Y063Y5ZGYHXLmY2y3toLubOVF81jWfBWimqo1HX2QGLnJVEVe3ImUxxCOBieL+YxtGTfSu+phjxSJWf7zxOESmmN+gJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800647; c=relaxed/simple;
	bh=1nb2Lrl4FkREdUYUC2wFNA9dEf2CCOJ0Ise5FV4ANp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHYR4eU5Sfk/AwV+QdgapXUamanaalbBEtNgJBd9UIgHVwwZR+2GnyeAX8dDBrEAjna4pJ7RMBnZKueUJD6cPg5RAA8EnZbL8Xv5qSS7fpuS9OES5wr0cXZj4qlnNZn5IvKM6FywqWb9YWIbusrVXGJzMFg52GceHmifzVucS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqLQYXbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqLQYXbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C5E1F00A3A;
	Mon,  7 Sep 2026 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788800645;
	bh=EvrEEOMq5Q8SO0XgN8y2BpwwzJurxJLVntxkjNABWa4=;
	h=From:To:Cc:Subject:Date;
	b=AqLQYXbKd70NwZm4KHuilLL0jYtbDLHWAXuIWodIdBdO+1DQQF0PSpDYJcm7udxm9
	 ouQxzYVgqWsk+Epp+RWOmgnbIDgWeXueoWSlgx+b2svEghbgTrrFZSkZnF1r2DsfkN
	 qnkmgUTVwdmgKKE7TnX7amoPNWUmnZMOloJLmO3mzg7J/Y3kL6KghALj9CfGG5t6BJ
	 CzMF+62xCEMOKVKzRHcNFp+6tzsj+qx5wOf5/JUXy8x9P6SuAlmRUnAmUfjjnqHOkX
	 DODaRnJSfCiIKkeo1/+TsOX7rV3mhyRILi33ySH1mMF7KA4j3n9dQB3tyRpIjHYq82
	 G8unYZCFa+0zw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Mon,  7 Sep 2026 10:03:56 -0700
Message-ID: <20260907170358.100168-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_hugetlb_mkold() reads the page table entry into a local variable,
unsets the accessed bit in the variable, and updates the page table
entry with the updated variable value.  If hardware updates the same
page table entry in parallel, the hw updates could be lost.  For
example, hardware-updated dirty bits might be lost.

Avoid the parallel updates by clearing the page table entry when reading
it together, using huge_ptep_get_and_clear().  If a parallel write to
the memory is made after the clearing, the hw will see the page table
entry is cleared, trigger page fault and wait until it is handled.  The
page fault handling will wait for damon_hugetlb_mkold() due to the page
table lock.

Because hugetlbfs is an in-memory file system and hugetlb pages cannot
be reclaimed, no critical issue is expected to my best knowledge.  But
definitely this is a nasty bug that should be fixed sooner rather than
later.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20260906195417.103263-1-sj@kernel.org
- Drop RFC tag.

Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
Cc: <stable@vger.kernel.org> # 5.17.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index f884d3f78f30a..91a0d441c1f94 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -283,22 +283,29 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
+{
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	if (!pte_young(*entry))
+		return false;
+	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
+	*entry = pte_mkold(*entry);
+	set_huge_pte_at(mm, addr, pte, *entry, psize);
+	return true;
+}
+
 static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(mm, addr, pte);
 	struct folio *folio = pfn_folio(pte_pfn(entry));
-	unsigned long psize = huge_page_size(hstate_vma(vma));
 
 	folio_get(folio);
 
-	if (pte_young(entry)) {
-		referenced = true;
-		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry, psize);
-	}
-
+	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
 	if (mmu_notifier_clear_young(mm, addr,
 				     addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;

base-commit: 13eba1898080a8a54c60710322909fb0a4d35e84
-- 
2.47.3
