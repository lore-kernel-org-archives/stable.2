Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597338;
	b=VAt7+V0/wF2WS02CmODfRV9k08gclGVLLkL4uKRJOcyu0UkzExBPsUx8cNAUwB3QCsYC
	 wT1iNgkv6wRoTnI4ojSuA+jK1ODvj5ZXiDpAEPfkGtLR0Pe7Z2lBIsWLG6v0r8zcBBrrN
	 59BRrdQ3LUGLqNIAfGSc+bIPe6/cATpLhjaq/VX+RoVb+j9AW1b6Y+L0/tuwuSJOJWjRG
	 Ltr9EcIPkc6hnLXxFU3ScnmmXbYbOtedUwRQKsbD+umsb4uwc8PbeY1uRAnV962piQZ65
	 TxrFkuIDDTiLgCOZP7c/nobEvhRd+Y4O4BLRbH6+6G9N7d9/J35WMYZPHJDo6jx6LFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oUXHx/WEQfFmdr7mA6vXbE8EgdVFAMZfaOIHh2S3Hlg=;
	b=2EcstFhT2IwnY3beiup7m1I/lDZjBqshYictw78bLAb3way9WHALNV4OoDpc2eVBfiQm
	 W6dHZk5omxr3Um8oA0BpIBUglxijYLGO0Q/Oj78XE0roRPP8q7TGUKOKxoEnxReDnY7Fi
	 HKNxFahqICqJxAA69YcXDxb7s6BSs371DhRFY/DhyfYGEY9R9K5NqutOuYAfxPh3kSRyG
	 zeiH06xLgSAHShDDJj178RgmRQ+oMgk3Z5rSAgp5ZTrh7NNwbybsAcvLX3cWHCQ3/f09F
	 73qD3sBI3ACxKeDe03wY0DUH5hXdEeNDE+6aniBbq1SaGc+TnTxXJPPxk94abx1SNkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze5XEWRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF80606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze5XEWRO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3F21F000C5;
	Fri, 13 Nov 2026 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597337;
	bh=oUXHx/WEQfFmdr7mA6vXbE8EgdVFAMZfaOIHh2S3Hlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ze5XEWRO5h6ddRlcnmWRvuZJFufSxO7oAod9m99D8HpbICWiYPjRA6qNeoB7TXnVu
	 HLQNEiuVjg9HC763DeTLQdp1Xw8nrb/UxiRjvg9ELDS2SnZSbztsZZQQhME45hJdee
	 TQXurRww7lUp0L3qgiKAz6A2UvB2fUnvP0r0UO06Kb9JAzBWoGoBhj02LwOc8w6VVG
	 R9gLSQtHU3tK/o2NqTcJP7OBZ46SZ8L+54WgsWoyIhGFJvOMWqgvjjYU4/gOsUSL0K
	 yO4b1gi2v2E1+9dvK/OdF3fKTeIzKMqMOsuHncqZOgH1sSXa9BBb47N18iIEZ3Y4DH
	 jhOrUbx+ysdBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <mason@kernel.org>,
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
Subject: [PATCH 6.12.y] mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
Date: Fri, 13 Nov 2026 14:15:34 -0500
Message-ID: <20261113191045.2222415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052555-failed-6.12-d42032c0fe3c@kernel.org>
References: <20261107052555-failed-6.12-d42032c0fe3c@kernel.org>
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

[ Upstream commit d42032c0fe3ca007986c1229128775af0340fbec ]

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

[david: avoid local variable, move and refine comment, description cleanups+simplifications]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-5-42796911043b@kernel.org
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
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
[ sashal: applied the change around the existing clear_vma_resv_huge_pages() call in move_vma() because fixup_hugetlb_reservations() is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index d4666f1ab5939..206ddd250b805 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -806,7 +806,14 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	if (is_vm_hugetlb_page(vma)) {
+		/*
+		 * Rmap walks might still find this VMA and take the lock
+		 * inside the reservation map for __vma_private_lock(). Don't clear
+		 * the reservation map while that is possible.
+		 */
+		i_mmap_lock_write(vma->vm_file->f_mapping);
 		clear_vma_resv_huge_pages(vma);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-- 
2.53.0

