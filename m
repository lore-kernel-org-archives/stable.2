Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591F3D1A81
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707636; cv=none; b=dYb4BQ8neOqduLsRoBSW8tiS8+9zBCHdIYWAosknGdQ3Nxvn+YWsDJR5mbwxYN5tpVkHy+mNMK/5v2+s6uSaXMqrEUELTzD2/IcLhToZuwfRfGODs1qw7ZDy8YDOf1TJgr6hnaBr+StnkNmW2keV+PI1Db8fC66Fy1ivGJsg+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707636; c=relaxed/simple;
	bh=GsdNpu38ZAtx85vnpXhGYdSKrjToQG6bSs4Mrb/8+R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VG7guJ0mzs7YJPtAvfE/c+I/RMvKXUoWkzgBlvccJ9zJckPxoitnLEo+ixzSNEVLivoK0QZoOy2G6tUakgAKUfPewsh6uihtKC/DC5hIzsw68yI2jmbNV553NJoWWXqqqgQqyJI1uTTXNK8MAv0bSyLBN/ZQhe7yuSIarPS4WjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Je3mxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Je3mxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155801F000FF;
	Tue, 29 Sep 2026 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707634;
	bh=ZuEn6kXEb4VrnQ0fS4vH5Zsg+mEdTFlC3baSRVt4nuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4Je3mxzM/q7y4BuSfRKzTJf6nddwSKjeW3E9M+I3Rc2coJzvImXsJDeKu4BT0fza
	 3JURNUH1d3q1SkoPYNtPXcSi1RujHYnm0ynqCFtEyQUBVQlZgRwW0LRpx7gQCbFgFO
	 8fXXGLVt8KtO/w+3B9nH9HotmqERau1/lbAJ2eLVrJseU2ylVvA27oHAqnnhlV9rv7
	 VlzSkkHgPZ1C1y8YNJSoQd6HnLl9T7R5mKcR/u/IG7AH38sPEBPZ1DnIqfb5up2SJf
	 GIv+UqoU1B0lUHe3qE1Gf4a5jer7gMZZj+QUcRjyMw/R3w9T7jqLP9CkvxE4lG5g++
	 eh+Jt3wR/2JFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Tue, 29 Sep 2026 14:47:12 -0400
Message-ID: <20260929184712.523120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-reversal-glaring-71e8@gregkh>
References: <2026092930-reversal-glaring-71e8@gregkh>
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
index 089ee23e07de7..963a098af9ecd 100644
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

