Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF53EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726634; cv=none; b=sCRbDFU4TvDRgW94HjnAuoQnIacHwNaeCvRm4GNcse2UukMPyzT/YPc6lvnD4rFuY00mP84R2bkVI1AemyObGQd3JeuUF8422bL1h5uKhXQMFqClDCRdD1OmfoyqH8D27lTe0VO6uT/4mzt3/vkACPA9icRnlnd7TRiAIdfDNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726634; c=relaxed/simple;
	bh=wsVLShcvnkBN2NAIaQsrgXfFdOxOgkqDnAIl7odBmQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzgKYos77IzqzDXBerQK2geO01IsE3NnFb7z/MqtRGiNqGsaaIUfk+oVy2JYltt903Ek06kFcEs8C6nBlFqb63xcvgYH674lqALEEiClks7YKQacFe10Wt5bP8vMnG7Ve33uwkpf6rStFEHJM7aU9Ctuqk+z46rah6kqYUQ7ZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onG905Hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onG905Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D1C1F000FF;
	Wed, 30 Sep 2026 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726632;
	bh=w1Icg6PZ77o3nEHITFpBF9kzKFXQ+w8eVXCdvwoI1sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onG905Hf//YDdlkR4k76j4Luj1xOczXqapyxlhUuZ+FD+v8jy21g/8nRNbIK7P9zG
	 V7UtWw+WvK1SBNjTxB/j+OKG0/I+fBlR+YZtIRDg57ZYE04a8AZMV2H5Jlebeu7Nl0
	 c6civoX60y0epW9sRuzGxM8DiApbDeTBJy9lm3kKKmf+eth4lEnXzLuP62260rum7s
	 EqO8vfAp4LltS8/3Ui27nqVEi0HMKebhT1JRFMFdzgQHgWRJUA0qUr7SyR8aWZcL0r
	 f62XdZoBt8I8qlqZqkLjDENEOqtReiV6+5XRtxxaExqu2lACJFQraxl+TOHeL/NZWu
	 h48RO04OQNIog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaewook You <jaewook376@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/hugetlb: preserve mremap address delta when skipping page tables
Date: Tue, 29 Sep 2026 20:03:50 -0400
Message-ID: <20260930000350.2861257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092917-grant-absurd-64d4@gregkh>
References: <2026092917-grant-absurd-64d4@gregkh>
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
[ Adjusted context to retain huge_pte_offset() instead of hugetlb_walk(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bfcb936084e85..a44a6602659cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5278,18 +5278,21 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		const unsigned long offset_to_last_entry =
+			(old_addr | last_addr_mask) - old_addr;
+
 		src_pte = huge_pte_offset(mm, old_addr, sz);
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

