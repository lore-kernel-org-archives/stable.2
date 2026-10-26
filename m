Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057237;
	b=W/MEm7i/7AT2ah5B+aKS7Nt5vM+gHkJ6yzFuBLIu+MHzF/zrKRgs2Y3gzZbvAWC1MI3Y
	 YPIvQs5Twz17ZqXqsE1sOdFynjSougPhYzGID/AgHd/Qcu7XoDxP5o44+o5LlNB1n7A04
	 nnCWtHyuh1EVDjG67+2GZOuLKU0WyuZO2GNwm0gpUHy5Bdat6rOnI8iPTv6xkxQEmsalv
	 OFlBC2FTWG8P+qlGIwNbebi4jNJ0kXhTNZeV9OhyhcWljpWr1dzJG3UpOXUzZ6i1lre//
	 jchQM7LJxwQM9VM7F4dqsu2PX6GW1sxQAaGvChaEbzfw43vnpmC6TuGiRKQDwlNv3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057237;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mTs2GwunrLwQHmmSbQHxry+Q3bjPD02b5DRaizzO8u0=;
	b=cpyeiturCMt73siZKDjeYagZOpIxxUsOvNh5Knz4slLNJ0HTLrjzeeUCYCtMRKUrafhb
	 j+3rbFAZUNUILi2otRI53UeovJmvL1Tpd99HwMgqltOoeEwDyc9ge1KW5OJwPSjerG2Gc
	 q8ZdA5FXMqqRMxtkEBJ0ce/xg7R3vgcUe55tMj29P+xzd1w25kgt15gBAOLm1T7jkiwTb
	 d5kDIh+7tqNExG+1pNtq8+qEBlXDMBhU9LjmQDoKD1G64T3snXh71J9zqUUHzs8PzPZVC
	 51IdvrBOuWw1NYALxABig4regvPcdFFMxyP4dc07gzYNG362P+Y63o/vcFHCc1A3sCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOHFpuhe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F8606A31A;
	Mon, 26 Oct 2026 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOHFpuhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97F21F01829;
	Mon, 26 Oct 2026 23:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057237;
	bh=mTs2GwunrLwQHmmSbQHxry+Q3bjPD02b5DRaizzO8u0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UOHFpuheZQHsTAc56z0KufOjEShFawYMdcpWG4L9/RyqdOhOQsL5R8Sbu7NayWn+S
	 x/mtr1q0KjP/gxenYKzidAb0IIWRucgx7F4GratJpJ9LE1diQSB+4cDmGcUM0DBgil
	 Jt9+/7a4DnuFwWE8xkyYwZthGOGRFbNki1fdHP+qsFHcQufZ9T1f+FQy9fVPQiVR8S
	 iNthWlpixuHd8TTlBW+CAeyS6sUknd0khcSYxQn6KUUfrAs5i3CwFSqpJPZaDW6T0m
	 xLToTVLa+KO7t9J4BS8w0MTMXRtsX51LB9c7gDMrS8glPBDvTxW5BFBXGwiuJrBRsk
	 YBMypIhsGQMoQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:50 +0100
Subject: [PATCH 30/46] mm/mremap: recheck PUDs under the page table lock
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
Message-Id: <20261027-fixes_core-v1-30-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=david@kernel.org;
 h=from:subject:message-id; bh=XqIc47B98euy1xZsTgJLG+HPEvLDbYPwpls8mFrjLko=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/+nuloHL+i7Gzt5riT7MeNJr+acemve9vTq+v+d
 W3MX695oaOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJiL1lZPisIqzaaFonkqp7
 puGr1eKbr55WXg5cXsKUG9A9pzZ8/RqG/66nHXc6y3b+luLN7V/qYqv/hLN04okSz31TJcxn27v
 MYwMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
clear a leaf between the lookup and the move. Holding mmap_lock in write
mode does not prevent this.

If the zap happens before move_page_tables() tests the entry, an empty
PUD can reach move_normal_pud(), where pud_populate() turns it into a
present page table entry. If it happens after the test, move_huge_pud()
can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
warnings on powerpc.

Recheck the source under the page table lock in both helpers. Treat an
empty source in move_normal_pud() as a completed move, and use
__pud_trans_huge_lock() in move_huge_pud().

In the future we should likely have the code lookup a PUD/PMD lockless
once, instead of multiple times, because one of the problematic bits
here is the:

	pud_trans_huge(*old_pud)

Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 16e736c72d9cb..91f0865f6aeea 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -461,14 +461,18 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
-	/* Clear the pud */
 	pud = *old_pud;
+	if (unlikely(pud_none(pud)))
+		goto out_unlock;
+
+	/* Clear the pud */
 	pud_clear(old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
 	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
+out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -503,7 +507,9 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(mm, old_pud);
+	old_ptl = __pud_trans_huge_lock(old_pud, vma);
+	if (unlikely(!old_ptl))
+		return false;
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);

-- 
2.43.0

