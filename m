Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306261;
	b=lfBjp/SL/so427xZ/tcOvIwnuvGrs9I+ByAIbNW9Y6UpofkJPrRB3xd4jlZdjXLm4b10
	 VMTEHoWNO+XpGXH2AWfsiNnYp7Vi6KNPI/vuABTK9KuObOQuV8fQqdYHHNOSWDeS6SsOh
	 jp3W+X8TDUw5baGnmK11cj5+5lLAXgprwexM1b6KLgmQl775vz5RDVI/q1LiQIjv0y9e8
	 EhWe8MNMc3n8FtHZIfY9BmjzBL8hMWBGqZPh60xnbvMTMsMXVqEx4lI/ulXsBJh/HqpM/
	 EB/p5k2yXluy5I/WtILrgrizslljPKv5ruVCqg/LtVqtLmxKRzyte6tLkquWBG+ZtGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306261;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JkKpOpVy4nNTHYLS6i5ceIs+WZNAThsPIEqAOiy3hwo=;
	b=pTiB/1g4BtizC9fKIMOAOQmcovLPIg3wo5mlfOzUbeP2QIC09ua2wj8oy64d+++t0QpT
	 UIADC8KqednGNUUr+2WquIH0DfqXf6Wv/oYNrGan3/gWRZ5DpMQ6YbhhXzYun4J+2fdRp
	 kokWaCPcEwj7i8jYWMBPfusOUc7aftDryxks4aBgLD12yeUoetFSLeYLNBeoLqN8AvamF
	 pnNg98G9JRHbiDxTzMWgQhGZRcx/nJykAVPxC/NocYk9QvwNmIyL+deZGmht50IIVgYn3
	 K0K7Gqi3XMJesiB48JCyy64TqXurNDUJFKhw0FdVJbWQkGCB9ofILmINR0VuCaGvDyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9IpVMZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40819606A321;
	Thu, 29 Oct 2026 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9IpVMZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234EE1F01825;
	Thu, 29 Oct 2026 20:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306261;
	bh=JkKpOpVy4nNTHYLS6i5ceIs+WZNAThsPIEqAOiy3hwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h9IpVMZXhE9Hn2ObjyXapG1VQ5Spd0s63yzi81dMPuivmY4xxxMaIhVJalbhQK3l/
	 pPic2KzleKT4LwVF9PdrT5Vfz+/2baBkDRwIcP/Oc6mI+rZId/hxzlKNyi/dTsIW0k
	 4mKSwQ+v7UsXIjr4p2jofqTscsM+BlLhL4mhqUDnKfM+awKQy0TDW/2GkayYcoE1od
	 2Kr1F/zEK9k3bRpeABQdrlGXkzrF18Cmys1v5Ugm1MiHJ6dStoKQzKVMlfjIZLee8H
	 WXkxH2wVlVVoqDBPYUj9HIm+ZDRGRuy5E5n3ZOa1Ax+81CZKB2cvAF3QmuDHKdINHl
	 0wl3DQs6BOgnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:12 +0100
Subject: [PATCH v2 17/47] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
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
Message-Id: <20261029-fixes_core-v2-17-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=david@kernel.org;
 h=from:subject:message-id; bh=te5lCngEDLVmEXnC8RjOJPUhL4oSTpvZoR4pTc9h1QU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer20z2uc41Uxnho7Oqu/K//7Mr3HR43XYu/PymyVfn
 1cf+F+yt6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJVO9g+Ctrv2H+tKAkAT7/
 q8x6Z+YmCZ3KKxV6c8G7YMJ/v0ut3esZ/hl3mvNIPGmK/3lux+cqZ9WrXDy1/822Srj+m/7+uZf
 PKj4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
bits to the folio. A shmem read fault can map a clean folio writable, so
a later store only dirties the PTE. Losing that dirty bit allows reclaim
to discard modified data.

The assumption that regular files are read-only is also obsolete since
commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
for writable files"). In any case, transferring PTE dirty bits to the folio
when removing mappings (and while the folio is still mapped) is the right
thing to do.

Use get_and_clear_ptes() to collect the dirty bits and mark the folio
dirty before unmapping it. Update the comment.

This was reproduced with shmem using MADV_COLLAPSE followed by
MADV_PAGEOUT.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment; simplify description; cover file-thp as well ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 04d9bb21ff52..dd17c3dae800 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		/*
 		 * Must clear entry, or a racing truncate may re-remove it.
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
-		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		clear_ptes(mm, addr, pte, nr_batch_ptes);
+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);
+		if (pte_dirty(ptent))
+			folio_mark_dirty(folio);
 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
 		nr_mapped_ptes += nr_batch_ptes;
 	}

-- 
2.43.0

