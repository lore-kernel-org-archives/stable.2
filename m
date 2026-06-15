Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0043AE193
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552561; cv=none; b=UP3gB5wEjlDtnGFtokyH6arDImW3FKwYPEnnVGBUikXYF2MTriolYCBs8kNE0cRFG6GsXq3RaPho2d+iDWI2TFRbVZH5GF2XPTlZjPsNwqNghz3XBgt+RT2aWbdAMNZUnQzztvfADMURon2R8I6gri3cwwdqTZrZfLMBtFEzvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552561; c=relaxed/simple;
	bh=6EY6dHNugwj19v/skf+xRuBem+7q1FJsNJ0TzgQw07M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmx3XU0MvytiDKJ03016prUvhNHYCFqIfI9R2ypR2nWsmZeHpJPfdCU/CYqrzP1hw447ivPC+VVmIKO+AabcPL/oG6pM8LigrM6S15M1wiS1BHcMqVT9+QPpG00BibjcSBosc7s3UfFpxsm+55M4ryxmJILZOy7pd0EruHStgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG7IGtRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG7IGtRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A9C1F00A3D;
	Mon, 15 Jun 2026 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552560;
	bh=tNPVBI8r8wXoesm9LjwwDbdt86s8NuLupy0hVDpDw2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WG7IGtRYQZ6iXKy4ehgyPIPAohaPSQx1Lc6tXTtTCEkCdwo2HQq0RBvsttDpwGY/E
	 wbC2NHoJ4slWh53ryCSRcIDvMeYpQawOn9Mu/dPRQ2ZmVcfLERqfh5P1gahDd5LsGT
	 XS9C/E2EuL8wKwPfdUT7p3QGlwESg1Rd/aP+eLYL9Oiedr8z+qwbmn3cI1F6fagKep
	 1e0Q/Nr7u8xFCj4Fxrpl+2Zin/PP4eyBcNFH14SXndPYZB4jaO1iRw5DUMb8ynPJU3
	 2p4aS1r0Ijedtqnm6Daik1mvr2LwajgHp7FIvlbsGnDqFaQX3duMDKFQoa8uxuDH2/
	 Y52nyBcW+FlxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] mm/migrate: don't call folio_putback_active_hugetlb() on dst hugetlb folio
Date: Mon, 15 Jun 2026 15:42:34 -0400
Message-ID: <20260615194237.2391157-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615194237.2391157-1-sashal@kernel.org>
References: <2026061514-giblet-unsworn-8735@gregkh>
 <20260615194237.2391157-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit ba23f58de896842028b4b33b95530f08288396fe ]

We replaced a simple put_page() by a putback_active_hugepage() call in
commit 3aaa76e125c1 ("mm: migrate: hugetlb: putback destination hugepage
to active list"), to set the "active" flag on the dst hugetlb folio.

Nowadays, we decoupled the "active" list from the flag, by calling the
flag "migratable".

Calling "putback" on something that wasn't allocated is weird and not
future proof, especially if we might reach that path when migration failed
and we just want to free the freshly allocated hugetlb folio.

Let's simply handle the migratable flag and the active list flag in
move_hugetlb_state(), where we know that allocation succeeded and already
handle the temporary flag; use a simple folio_put() to return our
reference.

Link: https://lkml.kernel.org/r/20250113131611.2554758-4-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 10 ++++++++++
 mm/migrate.c |  8 ++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bde99cd3525784..bac2a00f7dbf08 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7537,6 +7537,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		}
 		spin_unlock_irq(&hugetlb_lock);
 	}
+
+	/*
+	 * Our old page is isolated and has "migratable" cleared until it
+	 * is putback. As migration succeeded, set the new page "migratable"
+	 * and add it to the active list.
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	SetHPageMigratable(newpage);
+	list_move_tail(&newpage->lru, &(page_hstate(newpage))->hugepage_activelist);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 9271f9dbd352a1..328071b861c368 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1460,14 +1460,14 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		list_move_tail(&src->lru, ret);
 
 	/*
-	 * If migration was not successful and there's a freeing callback, use
-	 * it.  Otherwise, put_page() will drop the reference grabbed during
-	 * isolation.
+	 * If migration was not successful and there's a freeing callback,
+	 * return the folio to that special allocator. Otherwise, simply drop
+	 * our additional reference.
 	 */
 	if (put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		putback_active_hugepage(new_hpage);
+		folio_put(dst);
 
 	return rc;
 }
-- 
2.53.0

