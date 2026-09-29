Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83A552950
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707988; cv=none; b=nJ9djiAY/b5pXg4AL5kf0Hs3xLQNJVRKNzVlQ126GoYZ8IwRZoBYeFqnyiETFHr6vOs0/hA+qdAreGIPNJ3BePhYRjnlE5bg9933XZN7fQofmPY8jyU63PAerOlNaJIg+88NYbmH7wukRJDvKF0IahgZQ6iqggkyRqZZ0306USY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707988; c=relaxed/simple;
	bh=8JVac3cp08CwTm0sCTRSYUbiAslclXHE401+Wx7rYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQVmIGWoP1VjQHwVGUvsJkRXIEYjaME9NbiwEaN70od/FU26Fe20y1fB3eevL4K4i+b5p3ASTv1Ca0Q4ymOHaMlgaq6ts4/8aIRuxJxobke4KYexJqYvNb6ZXlI9zjZ3ntX+03Jj7dXSlQwikGpNbPtAHhb4R2NkT1yvoRUV52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNd/bkfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNd/bkfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74621F000FF;
	Tue, 29 Sep 2026 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707986;
	bh=X/2M6MCYlMwTGx7xyPdknPBO7WLb9bm2VQXIwyq9q1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNd/bkfhDwPohGdjFKf7UyNNvTu9ST768hHrXhSmv5LgcGFpZYlkp+DUODsJLOcnq
	 hq2bw4xrEnO+TaxkIzefmAT0kZzgkrf9QzlmqiBlg1XCOgCZpu725Bj3+GPCS2Uyfz
	 dOv9A7p823a3GZcJNJ6QhsO6J+FrAhPAaTtzvGLO0D+4pZnTYNwLLC2qWwrxdID9Id
	 MN3hdb2U8QGlWp0uQxGr3Qf9XfEbtT/1YpvoZzq2FMwJDnBp73/zMMIPHv7+a9162G
	 qcnplPsyvuOI30DycA4gzC3NLPhslpNNsBXIz68t01fA8jNSySAZzT/eezYVIPvssB
	 ek/JgUgj7ix4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Tue, 29 Sep 2026 14:53:04 -0400
Message-ID: <20260929185304.538930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-coeditor-case-5bbe@gregkh>
References: <2026092930-coeditor-case-5bbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SJ Park <sj@kernel.org>

[ Upstream commit 39c0ceedd54557bdc1542de08d22b2ed33e534e4 ]

damon_hugetlb_mkold() reads the page table entry into a local variable,
unsets the accessed bit in the variable, and updates the page table entry
with the updated variable value.  If hardware updates the same page table
entry in parallel, the hw updates could be lost.  For example,
hardware-updated dirty bits might be lost.

Avoid the parallel updates by clearing the page table entry when reading
it together, using huge_ptep_get_and_clear().  If a parallel write to the
memory is made after the clearing, the hw will see the page table entry is
cleared, trigger page fault and wait until it is handled.  The page fault
handling will wait for damon_hugetlb_mkold() due to the page table lock.

Because hugetlbfs is an in-memory file system and hugetlb pages cannot be
reclaimed, no critical issue is expected to my best knowledge.  But
definitely this is a nasty bug that should be fixed sooner rather than
later.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260907170358.100168-1-sj@kernel.org
Link: https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org [1]
Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.17.x
[ preserved CONFIG_MMU_NOTIFIER guards because this branch lacks the mmu_notifier_clear_young() fallback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/vaddr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c74b3fd1d227a..0a9812eb1047b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -347,6 +347,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 
 	if (pte_young(entry)) {
 		referenced = true;
+		entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
 		entry = pte_mkold(entry);
 		set_huge_pte_at(mm, addr, pte, entry, psize);
 	}
-- 
2.53.0

