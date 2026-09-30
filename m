Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103C1B808
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729049; cv=none; b=FaOf0FVzZcsxbxQB7RUpKLdRKLaf6YkyDJigbjBiIZyLeFXOGZQN4QfvbMgzKkYkBGNYlVjHupv6Hv6XtB50lAse0e7/7QTjPrMYjly5GN3bXIxJ1A7nuvdFbWBriXoZXDIag10Y7lT1ZxSJY3ks2qvMQob6EQdTN8YJmHXYu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729049; c=relaxed/simple;
	bh=vsFAkCcXMsghEqgQoEij3tP+3xlJPZbUVp9Iy/buR7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnJJATiXRgLMRvskSBemxGicN/a+AXLkXsDLt1glI1aB+ueBHYHwxmKCBesc2he7s9QTmQVNxiY+FbalaEFVzRs3/BXdtxKkbnykyEcqYuG8Jb27iNWEw9UIJLBQNImHuZc372iZLA608uH4ptTsUIU+ag++yLLebLy+AHhs86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoA1cHhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoA1cHhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95C01F00898;
	Wed, 30 Sep 2026 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729047;
	bh=usjxYFSQ7Zn/KBi5fOShLY+eyVsq/cdMn7CALSbxj6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoA1cHhrehvFfZgvUt/pTmuu10G4XJEyPPU1dc310OcmhQQG6hR7ufmkVeVFYuH7q
	 uEWz7nq98SLKX6IeLoQHWULBojAVJJ+Sqe0D0NcgDKUvUky0AsSxpW6yE9iNTmkwcQ
	 sJcsMSYWEUZlfzp6Gl0xXfaCUrenZtelDC+9QiQj5imqjTTQ43YWH2boPgDn19HNjH
	 zN3bDzJnQDIMwHeBRT7c4lR39zItBFgh274hlDmctFwidSrIocCw3kKnZH/SeXPjJ3
	 C7dN6+ybS8T/9A5/rG9YgERzq8uu/p6xVLGy7WkA8Dgq54o1/s6RKpgQfdGF9qPtPf
	 vnJLyHZ3avtGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 20:44:04 -0400
Message-ID: <20260930004404.2953402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930004404.2953402-1-sashal@kernel.org>
References: <2026092905-mystified-upstart-3f7b@gregkh>
 <20260930004404.2953402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit a363c62a653cc8b3e21da9545fa4e028ef50f9c3 ]

dissolve_free_hugetlb_folio() doesn't check
hstate_is_gigantic_no_runtime(h) though remove_hugetlb_folio()/
update_and_free_hugetlb_folio() silently bail for such folios, so it frees
a still-listed folio and, on vmemmap restore failure, the
add_hugetlb_folio() rollback corrupts the free list.

Link: https://lore.kernel.org/20260823044118.1097121-2-xialonglong2025@163.com
Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Codex:gpt-5.6-sol
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f4b296c3f6d3b..a7ceac999a3fa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1975,6 +1975,15 @@ int dissolve_free_huge_page(struct page *page)
 		struct hstate *h = page_hstate(head);
 		bool adjust_surplus = false;
 
+		/*
+		 * remove_hugetlb_folio()/update_and_free_hugetlb_folio() bail
+		 * for gigantic hstates without runtime support, so dissolving one
+		 * here would leave it on the free list and, on vmemmap restore
+		 * failure, the add_hugetlb_folio() rollback corrupts that list.
+		 */
+		if (hstate_is_gigantic_no_runtime(h))
+			goto out;
+
 		if (!available_huge_pages(h))
 			goto out;
 
-- 
2.53.0

