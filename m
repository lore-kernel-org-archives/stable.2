Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145961A4F3C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557378; cv=none; b=phKytkpJHXUbaYY/LVV+4+S5ygIqqiOoODn551RAIjlxdsGDB9En9Kn272lFoGqEKmKUDte3luyN9PmiKrAeoN+y8lYX8UHKwFG3A0lusFELTOHsixxCAk8vrzdhpuYYzC4WcMOtfJw/C6IjA/dcYaaPh+Ab8Z2CL4ZpXteMY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557378; c=relaxed/simple;
	bh=8V2mluWJn6X8XmtvexWW1oiO+HXwusXaa2LeiZp6dpg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RVhm/RHTAwQBkzHMj3si1GC6gTEol/eRLHv7TpwWDK4+/PtlBhF18A6f8NHvuDobhN9RYmh5Sejoj0Y35i3Dtv7wSZrua/bmorMXHMQSRiLKc33Sc2cVCdVve0CHaE4RIl+iC7GiR5mm4lPuKAWnycdLEBPy7Uss7Y37QWhmF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OakEb2E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OakEb2E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A24D1F000E9;
	Mon, 20 Jul 2026 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557377;
	bh=3hLPDaRy8xIGv+/kfJns/bIX7X3wFK8MaU174rviEZU=;
	h=Subject:To:Cc:From:Date;
	b=OakEb2E/fc7Oju7DbwKOE5qGuaNRscq9Heg6WWceS3Xxp5D57cQ2QqywD2tSF8LCR
	 Q1/3h2qtcf8pUJnUA8rZaGnuBG+K0/+9PZ6GU6gIDlJxshhQn9uHauuWrkvsW5AoUf
	 gDn6QNXnknXAvt/zJKyEuhNd/DyxmQta0Iju3qN8=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch" failed to apply to 6.1-stable tree
To: kartikey406@gmail.com,akpm@linux-foundation.org,almasrymina@google.com,david@kernel.org,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:22:40 +0200
Message-ID: <2026072040-skydiver-kinfolk-aff1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 15807d0ddde37407af72859426b654f3d1972b00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072040-skydiver-kinfolk-aff1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15807d0ddde37407af72859426b654f3d1972b00 Mon Sep 17 00:00:00 2001
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 28 Mar 2026 12:25:34 +0530
Subject: [PATCH] mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch

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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4b80b167cc9c..bcc657abbe35 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2859,6 +2859,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
+	struct hugetlb_cgroup *h_cg_rsvd = NULL;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
 	idx = hstate_index(h);
@@ -2909,7 +2910,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	if (map_chg) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
-			idx, pages_per_huge_page(h), &h_cg);
+			idx, pages_per_huge_page(h), &h_cg_rsvd);
 		if (ret)
 			goto out_subpool_put;
 	}
@@ -2951,7 +2952,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	if (map_chg) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, folio);
+						  h_cg_rsvd, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
@@ -3003,7 +3004,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_uncharge_cgroup_reservation:
 	if (map_chg)
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
-						    h_cg);
+						    h_cg_rsvd);
 out_subpool_put:
 	/*
 	 * put page to subpool iff the quota of subpool's rsv_hpages is used

