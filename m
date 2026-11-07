Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048883;
	b=D4WH6vCT00xFwBlLznn7hWEUQH6vxDL4JfNNntC4dxUhPW3K8YuzIGnL7YYbo+FA1hEm
	 zl6yuT4nJzrwdbm+sIUlLkcSzcwkMgds7KKpPYcSbJFHsKp5pSRKOfV1bUr7BTJvZiiZA
	 YSYD9kQbbPda6WFwp3VWSWsU4tSukX5Kk2eAKTEtxr6Cf+75GEuH8aiM87sNJqiX9hxen
	 GJabHPiDWb9Yb/toFf5Eh3ftn6VpWaRolqGU+SGJNOjC3vCKzhYnVSCC7JpkeQxzZp48P
	 dVf5PpcmPHxvocWzQWXsBivXhOAkC+2LQxj+NrjKZzgcTslw+Yy8OjT8v+9wsLVlGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y0MUG64r0sdJ8yMCQpyRwA4VVzusmXh5w7zwgqjoJrY=;
	b=ZgHh8OabcV5vjXeCBFrJ4eVYFy1dvs+dzHVRgczJ7YCzddKtUxn8ChJNA90LnQFK9C63
	 hYNTTYW7xQXoO+wYYGczo9q/NPU5LyEG1HL9TwxxQ43Z2n//nm+yekLIW8vXhbBRk9AAT
	 dT/9OAPMMvSp0LC2o0iKFR/V4K9/eKsrLkOuxpMUpOmQrbKEiBpKPlm0ZCZQnGUJfbShJ
	 EX3NMOHtsqxUx63M6X7pBlw+rYJDk2iuYPdPizrjQT8uL3j+r0a8s7e1oPAQsuZobx9z8
	 hzK8H919klOfw3bJUS8Uy2defqkl8S4L1AFh2aIMDnmH0Pv3C/DicKZLJ/Gv0rak8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fps/v7Wq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fps/v7Wq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475B51F0089F;
	Sat,  7 Nov 2026 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048882;
	bh=y0MUG64r0sdJ8yMCQpyRwA4VVzusmXh5w7zwgqjoJrY=;
	h=From:To:Cc:Subject:Date;
	b=Fps/v7WqVx9zHLha3ckvBW/qALLni2uvMApjlWqHOVr3+C4fjrGjH4JOiFvPK/6E2
	 +N4tIw9aQNJmU8nkrk+X1AY9mNKF4KX1QCvCUjBTJvFfOHwKuotiPHnkvfJnXiLzBC
	 BhE6FVlH/sSal1i8Le6gzpNJsmCAw9SPba3B4egehtnoBvdxPBVPHBxez4ZxaUGDZw
	 YTjexSjbZ4QxiJWsJ+SCE7L2sFIcp1f3oT+LwJwaFI/bZzewJm3tSFvE5I8JuPUCuU
	 p6QdONnxxvCWWVSFh5X3L/n0GcYWSZ8gJa/5p/qhJqS4zrUd5DCgqwpwDpko7u89e+
	 AbvkIHuO30L0w==
From: Sasha Levin <sashal@kernel.org>
To: pfalcato@suse.de,
	akpm@linux-foundation.org,
	samarth.colleges@gmail.com,
	gourry@gourry.net,
	ziy@nvidia.com,
	ljs@kernel.org,
	david@kernel.org,
	sj@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:40 -0500
Message-ID: <20261107055439-failed-6.1-246c8cc33438@kernel.org>
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
git cherry-pick -x 246c8cc33438a71c28f9b86baa492d9a0a130316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055439-failed-6.1-246c8cc33438@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 246c8cc33438a71c28f9b86baa492d9a0a130316 Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Tue, 13 Oct 2026 20:17:19 +0100
Subject: [PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD

As-is, madvise_cold_or_pageout_pte_range() discards the hardware young bit
by invalidating the PMD, doing pmd_mkold() and subsequently writing to the
pmd again.  However, it does so in a racy manner, looking at a
possibly-stale snapshot.  It's entirely possible that a write elsewhere
set the hardware D bit, which this logic now loses.

Fix it by using pmdp_test_and_clear_young().  This is an atomic
modification of the PMD entry, and thus safe against any possible racing
writes.  As a (nice) side-effect, this elides one non-required TLB flush
in pmdp_invalidate().

This bug can interact with the swapping system in complicated ways,
leading to data loss.  For instance, if a folio is marked lazyfree, but
was later read from, and then MADV_COLD'd while racing a write to that
same THP, dropping the dirty bit may lead to data loss as
reclaim/MADV_PAGEOUT drops the "clean" anon folio:

T0                                T1
================================================================
MADV_FREE(thp)			|
  folio marked lazyfree		|
read(thp)			|
  PMD marked young by hardware	|
				| MADV_COLD(thp)
write(thp)			|   if (pmd_young(pmd)) {
  PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
MADV_PAGEOUT/reclaim		|
  dirty bit may or may not be   |
  set				|
    reclaim/pageout may drop    |
    the folio			|

Link: https://lore.kernel.org/20261013191719.95502-1-pfalcato@suse.de
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8702b082a02d8..75b409e97dbf2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -430,10 +430,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.53.0




