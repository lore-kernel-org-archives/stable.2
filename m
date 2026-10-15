Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C84E36D4;
	Thu, 15 Oct 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080490; cv=none; b=BYHcT8JUO8u6I22DJEND9inFP9fzsyod+dZw9Rr6NRdL8iQTG/Vjt1G+r+GZfrz0lsjJEhFJ9nchrVWZf9Xa1kWk+o3OqjQiqDB9IYUNK0ND9HLQQSGzxF9RwAC7zO1IuELjeVCdhhQVnzdAYBlYwiRKJ3NxzrtsUvonAc4XnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080490; c=relaxed/simple;
	bh=pd8piu74erQ8CNcdss8byYglOMa7t3YIsmTvGDewOgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cf1HidtxkODEAXKKB9WkiOJ9iJvosfCfBB5EI4Gty3etTe9xP/knblaS0aI5g/SSzVtSlUh1iUGCx2nWMiEOwzY3ScB7rhFjFZSVSgYFA91FxZb51D4z3FHXLJKwjhqJWKCjb9VWSSuMsnLVl/4RxE5UG15SF3YUbytgoHR3tVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm+O5AmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm+O5AmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8501F000C5;
	Thu, 15 Oct 2026 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080474;
	bh=hsz2YjjiO+P2ROIu2oZfmqjDi2l2nCSLg69aGUFa1mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cm+O5AmU3+2HUnIWPW+K5lqQV6/iRQx3usBeKCR48KaC+rtCYPWmPlrMDaLMS9tAl
	 7ZJX3LoxWpIjCYuBMNCIXsEz5Ss0/GdLn/HOWp7F85A6rKb6536sfeNed6QQhz2xgQ
	 PEy2Ox9WpLGbw2yum4YwlFV9aFOEBU9p4PsqYDKTLhFwUpRDKDTJuqc1o47vLvNAKJ
	 5cePllUTfjFEKrU2gsBLghsjDHYaTxxp9swMtAH4wbrKx7PCGULylcAfdqfCrPOQtU
	 SsrYrT3TB+LkKzbFGcEbbSMDbc/W8of7dHR6vx8Q/bFvvm8wL26H3dH7DlaXiikSla
	 /3ZZT7SduGiPA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:11 +0200
Subject: [PATCH 05/10] mm/hugetlb: don't clear the resv_map of a VMA whose
 lock is held
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-5-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3065; i=david@kernel.org;
 h=from:subject:message-id; bh=QfDlqL7/jpqfjCmtJhEUh7eM+GYniW1rEDmE4ZrUJCw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DI++Fr1cdRHjsSZOXdrwiccSar79aBi253CmXpd7
 h9v25uydZSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRummMDOt61ujPPKOgM/Vn
 d+kX3T+K/clxImwrkvgmWvj1Z2fwlTH8z8o/dbmX5ZFvRfHLrbbxp28/tL5ztjV0/sacyjcv1A2
 KeQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

Since commit bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private
VMAs") the lock of a private hugetlb VMA that owns a reservation is the
rw_sema of its resv_map.  The hugetlb_vma_*lock*() helpers find it through
vma->vm_private_data, anew for every lock and every unlock.

At the end of mremap() the old VMA has to let go of the resv_map, which
now belongs to the new VMA: clear_vma_resv_huge_pages() stores NULL into
vm_private_data.  mremap() holds mmap_lock for writing and has write
locked the VMA, which keeps away everybody who comes through the mm.  It
does not keep away those who find the VMA through the file.  For hole
punch and truncation hugetlb_vmdelete_list() does

	hugetlb_vma_trylock_write(vma);		locks resv_map->rw_sema
	unmap_hugepage_range(vma, ...);
						vm_private_data = NULL
	hugetlb_vma_unlock_write(vma);		no resv_map: does nothing

and the rw_sema stays write locked for ever:

  WARNING: lock held when returning to user space!
  mremap_punch/116 is leaving the kernel with locks still held!
  locks held by mremap_punch/116: 1, last CPU#1:
   #0: (&resv_map->rw_sema){+.+.}-{4:4}, at:
                                       hugetlb_vmdelete_list+0x46/0x160

The next fault in the new VMA sleeps in hugetlb_vma_lock_read(),
uninterruptibly, and it holds its entry of hugetlb_fault_mutex_table[].
That table is global, so a fault of any other process on a page that
hashes to the same entry sleeps uninterruptibly as well.

All those who take the lock of a private VMA without taking the mmap/vma
lock are affected: rmap walks. So hold i_mmap_rwsem around the clearing
of the resv_map.

No change of behaviour, other than that mremap() of a hugetlb VMA takes
i_mmap_rwsem once more.

Original fix generated by an LLM and sent in private by Josef.

Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: avoid local variable, move and refine comment, description cleanups+simplifications ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 86fafd0782987..f8ad2efd472cb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7467,6 +7467,15 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
  */
 void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 {
-	if (is_vm_hugetlb_page(vma))
-		clear_vma_resv_huge_pages(vma);
+	if (!is_vm_hugetlb_page(vma))
+		return;
+
+	/*
+	 * Rmap walks might still find this VMA and take the lock
+	 * inside the reservation map for __vma_private_lock(). Don't clear
+	 * the reservation map while that is possible.
+	 */
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	clear_vma_resv_huge_pages(vma);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }

-- 
2.43.0

