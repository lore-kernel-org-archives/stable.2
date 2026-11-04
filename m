Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821020;
	b=Ssj979BkdMoZPFne84DgjUNfOtYtwTSJOTNufuZk/VgbERNNczgyCPjVTWgUO6xvdAkG
	 3gu2MOOwz0dx/C9mIe0mbwWVxaW0AVx1nyp+1ffNgif71ywJHWF3mdvcQxOnnJZrlrHkv
	 xrC5/wTIXVoUhEkxVwpY8GC5QPzqxU6UIhF1sQNxFIPAOkpeTdhBRhuCPLeMyxKmJ3AjL
	 5DiGZMcrhMb6uLH1O8yFmbB3NQTbgl38LrXA4VsJE+K/Le2nOs+5rMWXWG/F2Flp9vC+7
	 pl5ykVxi0VsjFa1L3GGZO7FbN5ELwV7SjYqeNuHtmoF6FhhQJG3c3pvWUrsGVX5swWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=To/xl9v7xcWup0Loez0F4lUXpRo5jhRHVz/le/5qwK0=;
	b=KMnNlXOYRE4849uUsgeBlFWbo+Nik3lTsgdw4UpKpRGu37vVosYulplEJrviB4XRY/zw
	 qWNLHcZgY/5IiiJ5SNhLU2IBV/wRUwnpHix7nBb8S5blFj2XFLZzFaOXC0FFMJ/6vVlg1
	 wpv+TIo1E70W8vqtBR0nPZWmrJdF4smtD+S6HhxDcO29af0REStMkb83hy5q4QzNLe2IC
	 F+I3bSYiyHBFKEU9APuRoSXnKDN5h8Yj1SCjm8t19JJplCDcuQlWfG4Sa+80IBR7N+0nu
	 bSkCn6q3V5wbFU2M/WCtj7j+nPQ49xqroF+0cTrHDpEnqjuMxg1xqRunzuSfkY1FDIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4HFMy8H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD6606FAD8
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4HFMy8H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80DD1F00919;
	Wed,  4 Nov 2026 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821019;
	bh=To/xl9v7xcWup0Loez0F4lUXpRo5jhRHVz/le/5qwK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4HFMy8HAvcpXUJ7VJeohH7pl+71v31z8B5Diz83ynGvCxY2X9Cppj/xPofKoVjfX
	 AwjAhzY1eIpr4pBOxMB3bdoM3pWwbjKkawE9qSpo64Bm8+uRU9vTDgcPRVSPLgjVLV
	 nLyXtOp5Gu05TWaaapA7mslgxOpz4/+C4LCV4QsiPGFHSd1iwBA4XVdWBGmx5g5LJR
	 XQ5WJWnUFtri01SOZzbcFCO/ZgEG8vH/PNzdfEqdsJjDBxIa54UTzbfD/cL/C+hjBr
	 0045rpNwK/7McUpGao6Phlj+nqZ1UacsTpjq3ZPJExoGdKQEff9AnNgHvvpTAv3tj2
	 0z5Qwy2d4aNgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/hugetlb: fix use-after-free of a new anon folio
Date: Wed,  4 Nov 2026 14:36:56 -0500
Message-ID: <20261104193644.3973734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-showroom-renewed-cc95@gregkh>
References: <2026110457-showroom-renewed-cc95@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 824cc56bf43c714319992bad3558803cac6e77c0 ]

For a fault in a private mapping with nothing in the page cache,
hugetlb_no_page() allocates a folio, locks it and maps it.  The folio has
one reference, which belongs to the page table entry from then on.  After
dropping the page table lock the function still sets the migratable flag
of the folio and unlocks it.

Whoever zaps the entry in between frees the folio.  The fault holds the
fault mutex and the lock of the vma.  MADV_DONTNEED and the first unmap of
a hole punch, hugetlb_vmdelete_list(), do not take the fault mutex, and a
private vma only has a lock if it owns a reservation map: not with
MAP_NORESERVE, and not in the child after fork().

Then the flag is set in, and folio_unlock() is called on, a folio that is
free or has a new owner.  A surplus page goes back to the page allocator
while it is locked:

  BUG: Bad page state in process init  pfn:108e00
  flags: 0x200000000000059(locked|uptodate|dirty|head|node=0|zone=2)
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set

A page of the pool can be given to the next user, of any file, who locks
it and loses the lock to the late folio_unlock():

  kernel BUG at mm/filemap.c:1532!
   hugetlb_no_page+0x111b/0x23e0
   hugetlb_fault+0x3a9/0x14a0

An unprivileged process is enough: threads that write to a MAP_PRIVATE |
MAP_NORESERVE hugetlb mapping, threads that call MADV_DONTNEED on it, and
one that takes the freed pages for another file.

Until commit 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more
pmd sharing synchronization") the fault held i_mmap_rwsem for reading,
which everybody who zaps takes for writing.  The lock that commit
bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs") gave
to private vmas closed the window again, but only for those with a
reservation map.

Be done with the folio before the page table lock is dropped, as
hugetlb_wp() is with its copy.  The function already unlocks page cache
folios under that lock.

Original fix generated by an LLM and sent in private by Josef.

[david@kernel.org: simplify+move comment]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-2-42796911043b@kernel.org
Fixes: 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted locking to use local ptl in place of vmf->ptl while retaining unconditional folio_unlock(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 985c39edb7ea3..30e2531cc8568 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6041,8 +6041,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
 	}
 
-	spin_unlock(ptl);
-
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
 	 * found in the pagecache may not have hugetlb_migratable if they have
@@ -6052,6 +6050,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		folio_set_hugetlb_migratable(folio);
 
 	folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(ptl);
 out:
 	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.53.0

