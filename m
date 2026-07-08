Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B98038AC79;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548774; cv=none; b=YJg0DLin3rynuR0nbSJUHR2KyDFyuUfshmES8nFGmgbX2Whdo2uETtFLC+g4UeMffz6F+l31zJVrho0Y8ZCRIGja1vPYjSuP6bEqK7wBv8xkgw1tAOi5LOu2xyV8PaEPTkF1LW8cdk3WOR70e/Jx8cmIG+0QTpGx6CvYDCJrs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548774; c=relaxed/simple;
	bh=nj+rgJC/HXTPwcNbSn5Q7M0LTgytd4Dk2hug7ZsqSBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBrZcTtH/X2VAhcfMj/zqWIjB+AzqDdQEstGtme6ynxHiZbwxjGAe/xn5IZzxTQO220nTU7+Kjj41/1L9kV7h/C+wCwNSLuydcPDM9P3LxWvUQlt5HiSQ4vFF/4nuzGI4JEGS8mWv6jW98SfwZ3pDx7vM88klXd7kYQXUbHXuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRFMA1DN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRFMA1DN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4FC0C2BCC9;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783548773;
	bh=nj+rgJC/HXTPwcNbSn5Q7M0LTgytd4Dk2hug7ZsqSBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QRFMA1DNLbWwQuGfVPuCW6A9wUCNbUBUoFvK5oGQXBSytV7p6oT5evv18q+SbQjp1
	 tE7tg3Q6v0fTw7PxbklRx29qRMuXm58VVHbHi5ktkmUY0Qs9uNLIaJq1DNWOcGpV4n
	 J+lESTmLkWQh/n+z68eNJ8Ktxwb8vxcjjblI/4uKs5cEzo45eYiFGoQWzmioZY4vVq
	 4ZDEMY4Y0bme5UmQDfEG6v8iOFWE3zvoBYzGJqRneaMJ20JVkuxW3WKbTJMjqxlbxR
	 94gotWCbDbGA2MwveqPFAlshgtfkLH6+xYaT3tkHlSnqETT/8fCcT8Wu8qBe01sYpj
	 dQ0xgsHjUPPJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6152C44506;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 08 Jul 2026 15:12:50 -0700
Subject: [PATCH v2 2/5] mm: hugetlb: Fix subpool usage leak on allocation
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com>
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
 Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
 jthoughton@google.com
Cc: vannapurve@google.com, erdemaktas@google.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783548773; l=2183;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=8pgD6+H5WXDhqxeVR1T9DEMEA9n+rne9MvjgkpNJ/6Y=;
 b=tmNC77AlJSVebS5RY5iI4MPVusjxMx2IC/1THhUAM6VizHc2+2UAt3vcvxbqcvzVnISeBK1ur
 Nnldn6syc2gBrP7TLZEdPYvfD1LeleDU15RVNgSoiQOUF80MZtxysjz
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When alloc_hugetlb_folio() fails early (e.g. buddy allocation failure or
hugetlb cgroup charging failure) and gbl_chg == 1 (meaning a reservation
was not used, but a global page was allocated instead), the subpool page
acquired via hugepage_subpool_get_pages() must still be returned.

Currently, the error path out_subpool_put: only calls
hugepage_subpool_put_pages() if !gbl_chg is true. If gbl_chg is 1, it
skips it, permanently leaking the subpool's used_hpages counter.

With the earlier patch to always track used_hpages in the subpool, always
call hugepage_subpool_put_pages() if map_chg is true to consistently
restore the page to the subpool. Only call hugetlb_acct_memory() to adjust
global reservations if gbl_chg == 0 since gbl_chg == 0 indicates a
subpool (and global) reservation was used.

Fixes: a833a693a490e ("mm: hugetlb: fix incorrect fallback for subpool")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ee5e99c1894b9..4093c1c0a4a1d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2852,7 +2852,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long retval, gbl_chg, gbl_reserve;
+	long retval, gbl_chg;
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
@@ -3003,13 +3003,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg_rsvd);
 out_subpool_put:
-	/*
-	 * put page to subpool iff the quota of subpool's rsv_hpages is used
-	 * during hugepage_subpool_get_pages.
-	 */
-	if (map_chg && !gbl_chg) {
-		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
-		hugetlb_acct_memory(h, -gbl_reserve);
+	if (map_chg) {
+		long gbl_reserve = hugepage_subpool_put_pages(spool, 1);
+
+		if (!gbl_chg)
+			hugetlb_acct_memory(h, -gbl_reserve);
 	}
 
 

-- 
2.55.0.795.g602f6c329a-goog


