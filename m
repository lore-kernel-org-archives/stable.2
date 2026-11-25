Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646135;
	b=SYnDKhUcxuTypmHdGlOeRE2HF05GCE+r61mHfbQtkpfblRYuEPbTXB5fzIG/3x5Mp7/5
	 Rd5XkW87J7Jr4s9AOujXcUnapd6WIhTDIJIyetfnTaKdAn3zX8Nu6uYihd+PknBHlolmr
	 mzcOsBD4XRJ8fNluMUPJdTsHiu7RYe2atz8wplzAwHscJeRT+SscVVluJkplDZyfHk6DO
	 4ntbLepR0362S+DTNGjCVXtif35Hw01J6S0rnOaguhdU1bP5yKpeSX3o3NvlS4bV1ezkF
	 IU5+iHKQRaXw+SXOsVPT+oh+v7/phxPyZj6GGctM0y3P/VoZ2zr3276F8tp9dMIiOLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646135;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/X9EnMBb1EpL9DRptGLIFWJ8P5QIzwUUyryHlQqYQoE=;
	b=US+2CcTCrrsIMCS3Za8AUxxbGHHNpE7Rc/sJPLEOZL00uDanYkIoca5ix0eHCydLy2j2
	 ZhS7xHBTngNXg4cVBlf2ddnoJu7VIvuX9LFXzeruJWyFBymqx1OyYFzTV4V/6M0u5up9P
	 b7NV56sFLB13yq4vU4gj+jw1lyoXNZHi6BUWGNvRKdpyfIgSnNeJpjcOxQm4euy/tUJ6r
	 cc3DJK/oSwKhqXliMKJJcUAdUht2rUgKmt1n7XYbWws+lEhAyZRfdqNtFQqCChTsNmeZ4
	 idex3sgl/zoqe+sfhFv52oPKJBNisYWVulQwMJENW5L1st94M50zzpAK7w1PYehFsrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaSW6y+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62E606A321;
	Wed, 25 Nov 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaSW6y+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F9E1F000EB;
	Wed, 25 Nov 2026 22:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646134;
	bh=/X9EnMBb1EpL9DRptGLIFWJ8P5QIzwUUyryHlQqYQoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LaSW6y+e/DzXfPl86UGKdoQPv9ftcRE1mSP6BQi2mTPKSfOzGzG5UKB0kjB1xLF3K
	 X5Z9gc+1vRMEyWO3ipTaFE/9r7jRJTQT+zdYCM7yGMmMHs/0/tGpDc8WHY144pLAeW
	 cf+e9mPaJdVobJqlLRXe/xexriXSyw9YprFEWKznN9vGLwDqqLvT2BWje5FMauRun0
	 CsymNizBrf9nYxFare6A9yymIDcTa+Cw1DrGLon+DPGQioOKDFmH7YhgLm/8ZlhPpD
	 Z9RkXImdGSDRgcRIq4qT0RB3IU1cDMGK1mPyLcI8NMCQnfxZR7Co9kI1hkS0qG7mlo
	 wjqJJ5BVwvEvw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:06 +0100
Subject: [PATCH 08/21] hugetlbfs: recheck the vma range after the lock wait
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
Message-Id: <20261125-hugetlb_fixes_2-v1-8-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507; i=david@kernel.org;
 h=from:subject:message-id; bh=rw8ESenx8D20BApyF+9LorlGrtKZwWBIIKOWjIuUihM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1TW1krnXZg7+9hUgZ8sKi19nDUTWMu21RzfPoN3W
 9L64hiPjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZi8I2R4XmsbGub1+WExQVB
 S4Jyt8a+fGclrCG9z8E68covtWNCfxkZpnye+OjPuw1cixY87LavL+6TKRVl/u93avbRTRxnppx
 UYgEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A hole punch or a truncation of a hugetlb file that races with a split
of a shared vma can lead to a use-after-free read of a page table, and
to an MMU notifier range with end <= start, which trips a WARN_ON_ONCE()
in KVM.

hugetlb_unmap_file_folio() computes the address of the folio in a vma
and walks the page tables to unmap the folio. As free_pgtables() unlinks
a vma from the rmap tree before it frees its page tables, i_mmap_rwsem
does not protect page tables outside of the vma, so walking them can
result in a use-after-free read.

The rmap tree walk guarantees that a found vma spans our folio. However,
when we have to fall back to locking the vma lock first and drop the
i_mmap_rwsem, we don't check whether that is still the case after we
acquired the vma lock and the i_mmap_rwsem. The following is then
possible:

    hugetlb_unmap_file_folio()          __split_vma(), new_below == 0
    ==========================          =============================
    hugetlb_vma_trylock_write() fails
    i_mmap_unlock_write()
    down_write(&vma_lock->rw_sema)
                                        vma_prepare()
                                          i_mmap_lock_write()
                                        vma->vm_end = addr
                                        vma_complete()
                                          i_mmap_unlock_write()
    i_mmap_lock_write()
    vma_lock->vma is not NULL
    vma_offset_start() >= vma->vm_end
    vma_offset_end() == vma->vm_end
    hugetlb_vma_maps_pfn(vma, v_start)
    unmap_hugepage_range(vma, v_start, v_end)

Similarly, a split with new_below == 1, where the vma keeps the upper
part and vm_start and vm_pgoff move up, or shrinking the vma with
mremap() can leave the vma not covering our folio.

Let's fix it by checking whether the possibly split vma still spans our
folio. Add a VM_WARN_ON_ONCE() to highlight the problem that was
previously missed.

This has medium urgency, as this is triggerable by unprivileged users.

Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5437a55d14f1c..0b96fdc3ad9d8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -442,10 +442,11 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		i_mmap_lock_write(mapping);
 
 		vma = vma_lock->vma;
-		if (!vma) {
+		if (!vma || vma_start_pgoff(vma) >= end || vma_end_pgoff(vma) <= start) {
 			/*
-			 * If lock is no longer attached to vma, then just
-			 * unlock, drop our reference and retry looking for
+			 * If the lock is no longer attached to this vma, or if
+			 * the vma changed and no longer covers the folio, then
+			 * just unlock, drop our reference and retry looking for
 			 * other vmas.
 			 */
 			up_write(&vma_lock->rw_sema);
@@ -459,6 +460,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		 */
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
+		VM_WARN_ON_ONCE(v_start >= v_end);
 		if (hugetlb_vma_maps_pfn(vma, v_start, pfn))
 			unmap_hugepage_range(vma, v_start, v_end, NULL,
 					     ZAP_FLAG_DROP_MARKER);

-- 
2.56.1

