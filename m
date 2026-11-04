Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824880;
	b=aGo8irUJdZGMQ34thPjIssG9EQRaY9wsSs1wXsvijijLw9srmvYDj1LINnCDoFymsyOA
	 SRbg2pS/XCkEh2ZZNBJ8UGwErfTCKphsqAcztAoh3yMGKa9D77q1Am0u4aFyL+nYh21Ts
	 6yK5cBmqMwPp15xdWCSbo7kz+VJNWMkdiQGUjHTGzFdcWNVsmDLZu8cHXKaHZrcbAZGs+
	 paZmcFSXdoFBoz59MmVuPf+D5N3DnSKfi4mr99+BSA+UrJGSVeTXsG9l+iRXBzDoZQpmd
	 +WONghqUh1uZpA3gizTXJQmiMsOMtqGYtDGVyM6E9JFtixgYq3Xai7nV1DUZ1Hqw8fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824880;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m3piSQtfQuOg8u1CZlEVUJlwdFZ/horJKCFdnF6JPx4=;
	b=zI0P20k29i8Bfg63QbWTf8KhIFmRdf4kqjCBwuI5euRWCjd0Ey/LYGdFI1JPYCWCv/aY
	 c0fd7+w2K3+CjuihKkzemcEvHPZrOz/I3jhpZAMRy12xSnzlev2Va7OLJlzPURHgNgfXS
	 py4pCIgmXtN04I/oCA2m0tA6fHOdYnJyCvNhAk0WkYD9ts0+2y7TM5f/KC9onkhSg5bjJ
	 C3vyquvqpN6QNVO45o+Iyd10Fsqm8DjCaqkrn7ZNqA4RQU5pIht7Ovu2fCLqKi75/Ifnh
	 x58vjbAR6ra8ZFcanD0ShrK3XgQRlCrYuqBV/lJF9ywTnx9teFWTxz/kuR/gA/nSbTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DDBzKqAJ;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D55606AC0C;
	Wed,  4 Nov 2026 20:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D55606AC0C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DDBzKqAJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=m3piSQtfQuOg8u1CZlEVUJlwdFZ/horJKCFdnF6JPx4=; b=DDBzKqAJss7bD2+bm2s
	P43Ux94h7IIe1ucOVYhz/ySnXcvWnMh9XoWdZm8KeW6DY/q73P2mKFhh6N+Ccv3TpXk4XShi5yDgz
	Y2er5iXun3HEJnILlYYWT4SenaR37N99ZrIjsn8ykdiwlkJqVcJ+VXfchpxwcvdia6CkmXLnujaV6
	B+Af3uGmljDQGYvGH0oG5c45wQz4wt4xmiAtWmGa8vAbHVnAXzTH+dVbQuU/uh5L9G2sGPvdI86F7
	6JlWBQi3OTBZk/QzdJ8AnEfyKzyyRCprkGF2Hh5dfyIPXGRyRGiNvV1rtR3vz7dwp272P6Dr1w3o3
	GrfBqrrkkMO03Ow==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xOhjA-0018X2-2O;
	Wed, 04 Nov 2026 21:41:04 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 04 Nov 2026 21:40:57 +0100
Subject: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=py+hRT0j2W1iu9s6HX+poqDtbv0blfBMcY8NUrWKcd0=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq65hdLggzNygo5KJ93r3G6e7Ax8It/B3P0I8J4
 2DyVb7vwnGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCauuYXQAKCRBRlgpH+WFc
 KkO7D/4nfFyvxkBgfdLQmB0YnnwJdSop86K3UxtoZgUM1vbtX2DXJsNtW9nEvRYTiUdPpkyfJWJ
 Zuin+uFVhJ0JVYdpt/UstEVsUeqs5VJ63zT0SQXGJJelixu8VtBEhRFxxT8nJX/R7b5NMeM6aCi
 cr9/Dve6+gKqvSS2TVDW3Kd98uh+MwKAHHGqzTRMhurwnUsxj9/xCtpnOIw3BrGpC1yB321PF2r
 zsr7MCVyUmc4O+P77YDDuNc6jZOh2+YPtkqgMaGdIsvQfX+u8h67SH+1g4h1jPCkTdNfGYJQBGZ
 GKtfplP4Igaoak5QdpyIdg7te9QrD+ddbX6BagGJakPfmFcQrAvOJjktlbByiAVoFVXOVuvg9Z0
 eY3AdCvvjWdB/VDGnWjyFWL9JfDsD2MIfXkSh7TxdKxMBlZLmyPXQVGfHHElY66LoEYIiXG1ztM
 2bYdW8FjQQ0zCDuMPw3VB8Sh5xGCQ8u5wiPexpNfPzbo+z0QcpMgf0BLXrzc9R0rs8ec4+Gh+tl
 aOm12Jl6cTC/aiva3Sqmd1a+VPusSoUssugj4shG6uiHmKd7GelE+oTcNckkN55nZvJqbBpgelB
 kyu23cA32rlq9Biyz9BnUUNhWUbRADxuXjNBqs+nekl1wlbY+0pdrF2Hfuzu6rt+F0IPt1heSL+
 3gvOLpNZWs7rJBg==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads a special PMD without the page table lock and
copies that value to the child. The mmap write lock held by fork does
not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
lock.

The zap visits the parent VMA before the child's, as dup_mmap() links
the child right after the parent in i_mmap. If it clears the parent PMD
after fork has read it, and passes the child before fork copies it, the
child keeps a mapping the driver has revoked, for example:

- vfio-pci: the child reaches the BAR after the device memory was
  disabled or the device was reset, instead of getting SIGBUS;
- panthor: the child maps the pages of an evicted buffer object after
  the driver has released them.

The same branch deposits no page table under the copy. ppc64 in hash
mode keeps the hash slot array of every huge PMD in that table, so the
child dereferences a NULL table on the first hash fault, in
__hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().

Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
from a folio under them, as copy_present_ptes() does with
vm_normal_page(). The zap clears the parent PMD under the same lock, so
either fork finds it none and skips it, or the copy is in place before
the zap reaches the child.

The copy of a PFN mapping then goes through the same tail as a folio:

- it gets a page table where the architecture needs one;
- in a shared mapping it is marked clean in the child, as a PTE is;
- in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
  protected instead of a warning being printed.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e00632edb3856..9cb5f99aba87f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1961,25 +1961,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 	bool writable;
 
-	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-		     !is_huge_zero_pmd(pmd))) {
-		dst_ptl = pmd_lock(dst_mm, dst_pmd);
-		src_ptl = pmd_lockptr(src_mm, src_pmd);
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
-		 */
-		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
-		goto set_pmd;
-	}
-
 	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(dst_mm);
 		if (unlikely(!pgtable))
@@ -2021,7 +2002,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto copy_pmd;
 	}
 
-	src_page = pmd_page(pmd);
+	src_page = vm_normal_page_pmd(src_vma, addr, pmd);
+	if (!src_page)
+		goto copy_pmd;
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 	src_folio = page_folio(src_page);
 
@@ -2061,7 +2044,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 	if (src_vma->vm_flags & VM_SHARED)
 		pmd = pmd_mkclean(pmd);
-set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 

-- 
2.43.0

