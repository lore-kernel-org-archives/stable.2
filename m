Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807920;
	b=gJrMaTJW7BT4hdBUb0My4Zl5VSGlUUp6fS+OZU0bbcyA2fKjJi8Wkxzis2HoAU46cpfd
	 XR2I7MsbkENMv351Ou4jcVIv6Ze5wMvHOO71/bQ3UT8Uje+kDXJFEAGeCHhv32CU8G9zU
	 oCCFgW7qnkNBt4AIFSLseBJl9ihFKmYzGH2pMUKm5hfEUbmKaR69XcwYWR7YS86CkpbL2
	 171VlRzre4wxGaAxiUcTOnhQojb41qwB20xDUB2U9XqDPYwt0lhu8fbYazftxaYsdsDxN
	 A8TSPdh3o5Dv9pw3qMVh9NqGv52Ux/ea7KvwrJsuF32YPDFaz3PvXK1SH6PtfBqF40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eiO+P5DaxsTSDtFr3CfU1wyLbzuQ01DO+6QVNm027iI=;
	b=K4fkho+DjBUJnjkmycsRb8HAj1P60VE3KlXcmwQNQj+rJT/3FgRpiIxxq7XwEAgG3Heb
	 iXGlgdo7T5MmYctDalayunoRrvfcbhV1h40Uy4G7nVq3cL0HWg7g/JyOuHWKIb3trqCS3
	 iWx1GLS71lGJLAHocw+be0ceZNYOWF2l08Kb8DU8lCY6L7sg8X1D4c6Vn7ORg1FIijbnr
	 AKkJNWBsFSsnjC71uhgf8o6A7i92ZOtzuXmq7HL6AMnvnIOYxQ/3y+sWpH2qV9p2dphRq
	 na6GVuLAJb5Z+UGQQWn+g39z/ghnWPwrLLFG3WJjekSm1/dhqXPb3BasvYM+1L83O9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6LyEHFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4CF606D817
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6LyEHFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB41F000C1;
	Wed,  4 Nov 2026 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807919;
	bh=eiO+P5DaxsTSDtFr3CfU1wyLbzuQ01DO+6QVNm027iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6LyEHFdYn3WHBcsw68REHEPb8yptpUDENhz1c31tpQBmsC3ov1J2d7mWV5sj3AN4
	 SBRfFlV7wKbyaZsyFHt9TQF43oqQCCerM4E+IqrrW+pAKyxTYwELoakHDErzD2vuoA
	 /hhlTjnPK0b55B7K1+eCRGaMywTyoX3vEZazdWzYTkM+eIi4Wiw4+9BzMqwkM2bohR
	 ia/9qF/UaOJ4LetYMs8wX7zp1Cp9hoy0TP48xIOdvkSa1t3Xp9dvT+/0WCHo3ECMnh
	 P8mZXfoOlQc9a9ZdF6FQ8K0eURdUnBw7sBZjfOMQWz7b0PZa7jsWZd+DPL4bqw4Fmp
	 BpAmfN/NWUsyQ==
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
Subject: [PATCH 6.12.y 5/5] mm/hugetlb: fix use-after-free of a new anon folio
Date: Wed,  4 Nov 2026 10:58:31 -0500
Message-ID: <20261104155731.3920547-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104155731.3920547-1-sashal@kernel.org>
References: <2026110456-remix-oversold-9ee1@gregkh>
 <20261104155731.3920547-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5196c1a816e38..049726560c1aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6295,8 +6295,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		ret = hugetlb_wp(vmf);
 	}
 
-	spin_unlock(vmf->ptl);
-
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
 	 * found in the pagecache may not have hugetlb_migratable if they have
@@ -6307,6 +6305,12 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 
 	if (folio_locked)
 		folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(vmf->ptl);
 out:
 	hugetlb_vma_unlock_read(vma);
 
-- 
2.53.0

