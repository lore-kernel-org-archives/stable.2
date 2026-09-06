Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDB1EB1AA;
	Sun,  6 Sep 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788724466; cv=none; b=neVj1V3UB6nsK+VQR8ZTt9G1jovnwvYLu9UT5hJcaydjovuhSGosXnXaAWb7JQVkHRWb3CGE/kD8E8T1VZVL971p3RkOVfeAW5QJcwrtkXza3qvKgsht0bwAXke7aeX/aH2WfM3G4zvtjvUEFKgqlCNtsgGITIpbTSc75Il55B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788724466; c=relaxed/simple;
	bh=7Vo19Jv/D0P0O/AGIhUJ2l5OLLSo/hTAPXZjtSEKi4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vh9nffe23ABejojSiggLc6LE6S1ZOg0bCLlIsI+A60AHK4cym/w2rjh9CRAK5cCjeVy8ZSXO25p44TMPfjpGtmi+o7o/PrW8yeTZC9t2ehIedpGEWc0lnQ+SGhCcdUWxtkmBGD8WtNwmj+bZlM+2JVF4uiK60wwoJKcFJ/OJp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI6qZzFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI6qZzFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A41F00A3A;
	Sun,  6 Sep 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788724464;
	bh=9yZmy0/7ZEMQpd5WklGz4F0Ta/1vxLOno5MJ0SaNnXU=;
	h=From:To:Cc:Subject:Date;
	b=iI6qZzFSi9KxMAntjrQEPk/Gb895LQ8iS6PGcc4F5PZR5fQyWizFUbP03kVEKo+7Y
	 T8ypxTxz/g6NjigLIcpAn88r05G8NR5A/Fh27G/zMPYY9UxbCX0vH8KDTeB4tE6rHW
	 wy1INhYckOTm8oEL2OROZqsCDhQ5CU+uPw3VewpLwvIj6PhVRjLEVVy5jk7tn4PTnV
	 BND0ABP+OCdbuyT0HSnQtO9m8vG+lU4Xe43SAuHOEnrVSDcduQ8m3LKitrIwsBZaXf
	 z9YgHyiF0Qlc8mUWZWudc7epnxJZaOxl9OxzY4OTHmXoZCVrHaol2MsZ36q+GlW1no
	 SwpASLEHHwxRA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Sun,  6 Sep 2026 12:54:15 -0700
Message-ID: <20260906195417.103263-1-sj@kernel.org>
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

base-commit: 99151e55d0d7c8c2b2cfdef93e2504bf2461106a
-- 
2.47.3
