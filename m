Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056976;
	b=IBtIswblLqiHhC+AmlW74GGFWsBgxu/woBc9uel/o4uzfxjvOheIMxa5qNwu85qMZfFo
	 MrJ+6yd6x0M54N9nFX2cb59jhWcoyxXyz9jO3n7tqXHs/fZ5O1rd5ZfkoyPhkrvcPAte0
	 ub1zTe6TzqSTUN5nZSPNzXQ1OqIhjB9+IYmuaSS9CnVqRAHg+OL+DOae2ei1FTvPhqTSO
	 cXPiNBrxlSjpaAh7xDOIaZ9kb8TnHo6FGLg9YF4bBQ/yyGeyMwrQOuChBCwdD7c2ojoip
	 FQG0iF+c6pto2Y8PVaKkvOredfxIVEvYk1g5kqDU5M9AzFRj0hH9GsYRtxu0oK+1cgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056976;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=reZzVNI4A/Jr+bC2MZiSR78czx3ygjp7lEPtfND7Hn0=;
	b=RgGEuOwgL00QLGELjWdIJbRjz4M0K/WKRr+WS8s5trqoTtzil3WfA9+3if5TmA1ovU0c
	 MvOjA49yXs1h1wGJesXaVu+RtBtQpnFVtKbp6erJ6UmAQqc7iQ1w1d8LHSKYTDlAdAIHw
	 mgzynq7WkOkPrXGgdh4p9lql2NPAye1cnf+Y08XMNbl7oTtkYnr86EW/1Za+nIPXOxUeG
	 u8/j06Tjn953+FoFi09+RkAypyvXmTJ+JpyPCNNyZdm0V8mbHUV8jz4h8pOUGmoK6ISki
	 NjtJZqCx3m3YmBcincaA/HVoM3fek6IE9euW2/xvL+2OHs9l9Zdu5S7i8I2I5ki6O+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGGzr8wX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685B606A31A;
	Mon, 26 Oct 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGGzr8wX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9C51F031E2;
	Mon, 26 Oct 2026 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056975;
	bh=reZzVNI4A/Jr+bC2MZiSR78czx3ygjp7lEPtfND7Hn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UGGzr8wX/g8GZ9SFIoq0C/I/5mPwnV0HghDWeu54SifXDSCR3TUH+tv2sLf3to4FV
	 eVjgLWM6JQTJZxq4p+d2XJnK3hUtgQuaXKEBOKZatmZEPp4KRCWWT55wBWLeUY68Q8
	 QLsAcUK0QMIYVDDvOrVcya/a8ucdM9+JAS2CrnIlQ/7WYoPaq5bRdoEmbG3Cw8+KUL
	 uctg3F9yHVCoCzUZdwGTxIKFVGrBf1WFQEHil89WvsvfUWekxvcRYZxhg7pAwfCjKR
	 MwWIYTVXeIBgtLxWDHeCJy4ZFqIYoKtQG/g3wUqOoc4TIl8CUacM1aW5rMSHpr1J8M
	 JO5QoXq6LztMA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:36 +0100
Subject: [PATCH 16/46] mm/khugepaged: fix PMD table lock leak in
 try_collapse_pte_mapped_thp()
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
Message-Id: <20261027-fixes_core-v1-16-6f74bec9a5bb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=david@kernel.org;
 h=from:subject:message-id; bh=UXoBnlCMAf+wGbJLfiFGKUQg+DKe15pWriilK/O7tD8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/6Qa9JT8qTS+xv1eW+fONpAS8+8S9fd+4wL3NK8
 d2Xf/y2d5SyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRsimMDPvDCy7yrdKY/OJO
 s3D01Ye377da50sqHgh1qIq22/Z5mxPD/4B9cToayy4/KGz/dKT3bIbO+7Jlz7S2dVz7J2UVLlv
 0iwEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
takes the PMD table lock before it maps the page table for the second time.
If that (pte_offset_map_rw_nolock) fails, because the page table vanished
in the meantime due to concurrent page table reclaim, it leaves through
the abort label, where the PMD table lock is unlocked if it differs from
PTE table lock.

In case the PMD table lock and the PTE table lock match, which is the
case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
failed, we miss to unlock the PMD table.

To fix it, forget the PTE table lock when we unmap+unlock the PTE table.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f53c50507c83d..04d9bb21ff524 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1904,7 +1904,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 
 	result = SCAN_FAIL;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
-	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+	if (!start_pte)
 		goto drop_folio;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
@@ -1935,6 +1935,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
+	ptl = NULL;
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				haddr, haddr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1952,7 +1953,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		pml = pmd_lock(mm, pmd);
 
 	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
-	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+	if (!start_pte)
 		goto abort;
 	if (!pml)
 		spin_lock(ptl);

-- 
2.43.0

