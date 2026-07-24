Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F142A160
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891098; cv=none; b=t4p9Xg3Mkzf99/ZkwUi6qyPHpEseQHH/PQ3RK7smTYOSxv7lCmRkrfOdmoZWGhy9odnqR9Drazm8RjMy5012gQFdYgLUgHjXX4LDTTGW+G9IvANFB73usj0nxa2wTCkW6mO+yB569jgBmZ/CBiAvRXIFt1/fdGqd7aeFZnNyhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891098; c=relaxed/simple;
	bh=IAVJz/a6UQd25KugYecHQ4fiJPFojDokUXY41K+jlVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7Sxz4IrGGaMv8TBkoBvbCR9aoRqB48jEQmENl4o/L9t6ArnCe3fmUIdVxgNA4JE0OCcatZwez0PtCSyoMMTDs+RCHNb6g1X4QXKdmJ0UftEYKYwUBzlB6zhWjX9L9Qp3xk9Vg/npMjKNtkGPIB/AmJIjun4gJ0Pcrfg2QLU4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/LVJQhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/LVJQhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0401F02828;
	Fri, 24 Jul 2026 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784891095;
	bh=3UJNZSYLIJQcwSEZ85YSFQafxQcItdIpWYqrUxCMKlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/LVJQhMkyDUvfnjfKelfZFmNQ1/NhNPV+uexuCzI6g80JkaoVeLcOxEn7C0Z88hd
	 +Xjxlz2O9Wynk43By25A0amGJuTlu7GjggF63+9NbXOGIksz2orVum6q7TAezKifZy
	 e7pJ5QFLoFeiP2x+CWCh7GAdj5F99lO10OVZIEMb2MSr1QfzZmWuuzrZnldK3+/BOz
	 1MO17kuhA77BXXqFmPQR25R5D36M9oZNDguo3iZS+3igcG8+ZyT3PDAnbM+fiOVWYx
	 3mLL97qBEKzsVzsAV1b6oLnxDRXDBuL+sVHZjZgDv4ZxyNKpqdcSnajmqCKAsjUmzC
	 GiJRChEfxIgrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+226c1f947186f8fef796@syzkaller.appspotmail.com,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch
Date: Fri, 24 Jul 2026 07:00:52 -0400
Message-ID: <20260724110052.3984407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-endowment-unfazed-086d@gregkh>
References: <2026072039-endowment-unfazed-086d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 15807d0ddde37407af72859426b654f3d1972b00 ]

In alloc_hugetlb_folio(), a single h_cg pointer is used for both the rsvd
and non-rsvd hugetlb cgroup charges.  When map_chg is set,
hugetlb_cgroup_charge_cgroup_rsvd() stores the charged cgroup in h_cg, but
the immediately following hugetlb_cgroup_charge_cgroup() overwrites h_cg
with the non-rsvd cgroup pointer.

As a result, hugetlb_cgroup_commit_charge_rsvd() stores the wrong
(non-rsvd) cgroup pointer into the folio's rsvd slot.

When the folio is later freed, free_huge_folio() unconditionally calls
both hugetlb_cgroup_uncharge_folio() and
hugetlb_cgroup_uncharge_folio_rsvd().  The rsvd uncharge reads back the
wrong cgroup from the folio and decrements a counter that was never
charged for that cgroup, causing a page_counter underflow:

  page_counter underflow: -512 nr_pages=512
  WARNING: mm/page_counter.c:61 at page_counter_cancel

Fix this by introducing a separate h_cg_rsvd pointer exclusively for the
rsvd charge path, keeping the rsvd and non-rsvd charges fully independent
through their charge, commit, and error uncharge paths.

Link: https://lore.kernel.org/20260328065534.346053-1-kartikey406@gmail.com
Fixes: 08cf9faf7558 ("hugetlb_cgroup: support noreserve mappings")
Reported-by: syzbot+226c1f947186f8fef796@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=226c1f947186f8fef796
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mina Almasry <almasrymina@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 17865215fda795..90faa4fd2ca272 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2976,6 +2976,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	long gbl_chg;
 	int memcg_charge_ret, ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
+	struct hugetlb_cgroup *h_cg_rsvd = NULL;
 	struct mem_cgroup *memcg;
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
@@ -3019,7 +3020,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	deferred_reserve = map_chg || avoid_reserve;
 	if (deferred_reserve) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
-			idx, pages_per_huge_page(h), &h_cg);
+			idx, pages_per_huge_page(h), &h_cg_rsvd);
 		if (ret)
 			goto out_subpool_put;
 	}
@@ -3056,7 +3057,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	if (deferred_reserve) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, folio);
+						  h_cg_rsvd, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
@@ -3097,7 +3098,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_uncharge_cgroup_reservation:
 	if (deferred_reserve)
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
-						    h_cg);
+						    h_cg_rsvd);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
-- 
2.53.0

