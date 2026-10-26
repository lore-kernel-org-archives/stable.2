Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056957;
	b=hi5Plz2nU3teu1/zXpw6TTpkGtdD3R3yEkyxl7JE6tBhU7rDVeFTtn4CBFyd/Z7hYG6I
	 Ed8xOqdQLzJOwTKBhGi9afbwPEUIqzrblx5ZE8OHnGrc+1b3uKNe0LUVFXXaphC/GXq/h
	 gsD47stu6fQSAtj3bJ51+7I6qnG4s45WKHVOvvpbbNAq7S8xu3JZEPSCaEkNjEjADpAlm
	 O4njdChy/TahZY5sm7W93geUrMgDmNDCewiV4V9HvuLrJR0MGXcvMYGtBsrvNUE3hPpwr
	 KMtZJtAIqCIaHdiFUfihTseMjOsrFOBvfrHj2HICk0tpscO8GADM5HAeLDlgFJPIjrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056957;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9PONecBNGwAC37JtDon9HRvZi6sk21qH9zGaaJ3qYwM=;
	b=e5R374AiSvy9jbcofSaQffNGQ7j3ltyfm/KMayQGCdvtzKGpOo2VmOd64uyQqy0UomXg
	 3CKgkehTeNMsdGqN/eFRb+vP0Fp6qArNFRqhEs3417gVW6sCTE23QOK9LfhZcab8XVxMZ
	 Xwy1BWx1oYc5JsoKXdl2u+pDXkMYi/sZ9YOCDboU+t0Ag8F+KMT12bcFgG2K6Z1gpp1Ly
	 ckYKN+p1zkHcFpKUBOIzdvyUe0FTPzKrCf2z/bK2A4jvWbT4hy2A2chtW6gwyYgLI85uu
	 S+CHCkxlGu02grMTkUU+N899/76rRRjwQbWouobb4DB4e2IBM5CSE/FRCIUncQai6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVvbRksS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E24606A323;
	Mon, 26 Oct 2026 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVvbRksS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E7D1F01825;
	Mon, 26 Oct 2026 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056956;
	bh=9PONecBNGwAC37JtDon9HRvZi6sk21qH9zGaaJ3qYwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PVvbRksSFwPLqVK97JfuGRK/yyQ7vgKqfwNLBuwg7tRyER/6D481w8uhIlExbvJlF
	 3Bu3BiC6oN4wuYX83Y+otwZqJERUGRe1XFi0KZ7UsLHZ/O4mJV3ZcTn/vc9WZT9EJX
	 wPLTosWMrpja6FYcetEEULvCUUTsRwH1Wx4GCZRVT5tvL3HyQE+itWahkkZ0Dz60Ct
	 XlR6V2Yu3twGvjCbCxFmeWQT5axPeMCrXg6qf9ZLt0Dkzq7EMrgWGUq4VcoD45xmNI
	 0JiJEmKhSJUPzB+HtPGHZQbcS0lXuOgWw7vLR2o9H5MUKaVvozkgATVGIROQa8biF8
	 hMVaFTFvhIV7Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:35 +0100
Subject: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
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
Message-Id: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=david@kernel.org;
 h=from:subject:message-id; bh=tUVUPC0JtoDS0vcvc31VLhuGDhArP2SMJJKTyHtlpxc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu359SPM9j88bSt686WqQe8L9xbvg+r1Tw8tRHcz37n
 s7RmJFY1FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE5jcx/BU29ki5fl+GO4jN
 wXS6x7vf0VKJzI6z82R5Fk6a9kRS25nhv2NW248SjrK9fx+kGgX4OdfM0y+eYzZ9l+uy4BN7Is4
 9ZAAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
page table, and takes the PMD lock and the PTE lock to remove it.

In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
page table. The pmd_same() check is supposed to handle this, but it is
only done with CONFIG_SPLIT_PTE_PTLOCKS.

Fix it by performing the check unconditionally.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: adjust description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b71d010b2aff..f53c50507c83d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2013,12 +2013,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
-		if (ptl != pml) {
+		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
-			if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
-				flush_tlb_mm(mm);
-				goto unlock;
-			}
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			flush_tlb_mm(mm);
+			goto unlock;
 		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);

-- 
2.43.0

