Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D141DDF1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707573; cv=none; b=b838jTB2yJfUOkzPpNtK5lpeZNdhhkO3nU1W5k47G25MXumu6iPBB/TTpdpxH5KGTZ5KSvE5sUAbm7W8Zqejjho2zA0ZShYEHeEhavGFWGN2oR8v2Ck7wTV6Zl9X3iEeVMXl+CJlSRbNzzs6M0saVY9eAuwuCDP6AORB0j9lGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707573; c=relaxed/simple;
	bh=QYTOuZwLH1x6W7USOpEHQQkx0bm0WifBQRwZLfeyRBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7wGNIaZJ939Z+4aSlNw9A2hW3MoX2Kfanyr85+ruHyGJhH5niPlPqA+N15Fb0aR+JsHrYnXYq5XDwoSrcdIXfQXQwU+qyxMKtZe1oTisYRFs8DZNrPNv4nmbUo5QujvjoDgWnp83TuBRvtame+pVoPWuBFknSz0WyctrhMaKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkO7Pu58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkO7Pu58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E651F000FF;
	Tue, 29 Sep 2026 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707572;
	bh=oLF/f7ekDSbXdX7N5+I/KtUQT4Di+Mf7oQvGLdkAr/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UkO7Pu58/Gz80w5+l7SDx8cxxWSS60EjJZ5c/95X/9pE78DLDPob5t7Pl7EKwJSJ8
	 kTeJBxlDsmkwOdD/Z+RDQAvc5P3Kji28osE3++N6Y7XtdyNqYpshf1N0ZaBmt3eIOs
	 h9PqQ6MwL0y1TG8J1fDpWwWubD4t39Iylit6vim3uS3W6ASg/Nv2dOh4SU/sNH6GOK
	 vxNc1S+qaGhtC+9+YdcRGE31qcI4CMBhMTKBifsZBOibaP5bybY9W+mNFP2jgomsOd
	 EK6YFmIMf6cS5h5mOOVzbUplqgX7kswXjBRC8+mvMDvEh8LGLgQoEANI43vFw1eniu
	 jgl5jRZU0DXQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaewook You <jaewook376@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/hugetlb: preserve mremap address delta when skipping page tables
Date: Tue, 29 Sep 2026 14:46:09 -0400
Message-ID: <20260929184609.521274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092916-rubber-foe-5410@gregkh>
References: <2026092916-rubber-foe-5410@gregkh>
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
index 0d98b591bcd1f..93b76353fddda 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5473,18 +5473,21 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
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
 		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
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

