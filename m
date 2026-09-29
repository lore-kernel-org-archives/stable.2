Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C137F006
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707964; cv=none; b=qGXDrccsOzrC2vzxQrDft+4y3Z0jNAvGSiAiLeV1j5Eqf0FqTdnAQiEHWLC5b+sO7dZ63BzhBOwkN9/Y9ff4Yt5RXktVR2SSd7/UHGvGxoGTYLwmDSBlQUxaR+deh37ovSygL5tDBTZZgFbcYdQxNem+PpgncUn1bFH8z/9ywl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707964; c=relaxed/simple;
	bh=GYdH8iRSrJ8NRqJr4I99jTcQ1VbfG8CUAY4D3vSOEAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qP4kbgsht2W9C/T5143KLH1VuuShp7TGRw3gPyQrMlGs9aZweyk9CAmXX/ND/e5ubCAxlTWaZcXdTTHYmo9cPQk92Qt1qJARW/WBS3/x7jJMlygyX4ye3MnhtD4SPPhpGU9kXLObXTOx2PhWRYDY5SueXPtCaumAMf3RwcWVrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7wD8Osn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7wD8Osn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A01F000FF;
	Tue, 29 Sep 2026 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707963;
	bh=rrJ5YY0eyMZcam0IdWKftPqJR3CXuAX+4a5KLInIBD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7wD8Osn7/KG9jcPm0bmhg7s5HqQkW7XMDDFkN2FnVyR9Nsj19+xu8h0Bf94IbuSO
	 RmblBqLpDn9kY7JPGlwoVxVv0LGzxKjfU0HwNYvOLCezIwmVIfkp39MLk0Ad48YzLM
	 eQ4Jf+LYG5W/oSC1rVtQF09nwaAyO4FGlsdz3uI0YiS+aqxvcMWr9qErlm2cksjaeV
	 3IohBUx0Ae0tOvSvhSNLgsXOq39RNmVi9OTlqMBKvdJR6Wf1ghB4XWwzEF4eeVbenv
	 1ABud1a/RLKkDO8A7a5kwmZ/3iofw6tRKqZvp2Y+E7VnvXwwIqybbGek5wbeJFg1nE
	 tXT80in+/WvFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaewook You <jaewook376@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/hugetlb: preserve mremap address delta when skipping page tables
Date: Tue, 29 Sep 2026 14:52:40 -0400
Message-ID: <20260929185240.537737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092917-starlit-overlord-5819@gregkh>
References: <2026092917-starlit-overlord-5819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaewook You <jaewook376@gmail.com>

[ Upstream commit 9bdad082d44bdcf93716973dcba6be77e8a06e7b ]

move_hugetlb_page_tables() optimizes mremap() by advancing to the last
entry in the page table when the source page table does not exist, either
initially or after unsharing a PMD table.  The common loop increment then
steps to the first entry in the next page table.

However, the code advances both the source and destination addresses to
the last entries in their respective page tables, which is wrong.  The
destination address must be advanced only by the same amount as the source
address.

If the source and destination offsets within their page tables differ, the
destination address can be advanced too far, causing follow-up issues.
Fix this by advancing the destination address by the source advance
distance.

With a reproducer, we were able to trigger a kernel panic on x86-64.  With
this fix in place, we can no longer reproduce the issue.

Link: https://lore.kernel.org/20260914132352.472-1-jaewook376@gmail.com
Fixes: e95a9851787b ("hugetlb: skip to end of PT page mapping when pte not present")
Fixes: 4ddb4d91b82f ("hugetlb: do not update address in huge_pmd_unshare")
Signed-off-by: Jaewook You <jaewook376@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd8752a5356b7..ffaf1ffbe885d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5295,18 +5295,21 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		const unsigned long offset_to_last_entry =
+			(old_addr | last_addr_mask) - old_addr;
+
 		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr += offset_to_last_entry;
+			new_addr += offset_to_last_entry;
 			continue;
 		}
 		if (huge_pte_none(huge_ptep_get(src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr += offset_to_last_entry;
+			new_addr += offset_to_last_entry;
 			continue;
 		}
 
-- 
2.53.0

