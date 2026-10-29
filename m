Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306305;
	b=lj3ij2skI7iPvJnD5BqBg92TO3SMo6o8ujWGMLNZL7vWjELd63F7LKBJsq9uGnzXPkP2
	 k3qpTA095xpyGGXgqPb/+4jqqr8e1/HkH5OTixYt1hgmPFhIhDPdCmV9jUakMA+KOLBrU
	 PP3cQE5HvpaDTUtlSwmTnteyAw0kd7eACnBKqjAzS2t0pGJRMPUopq6wiUO6hV7e4Osr9
	 H0gdjqVHuupHfyHWNWf/kArfGxWPaP+GTEpz2Q6sSa2wKNwT+q4DExkSLzJZmeC/nx5TF
	 42gGvHaIcJ4Um1gc/i1EUyPEKpCgpsPBXIpUsA3cffGQkKynzawCsBIk0fnLh2Bgpng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306305;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5LChJhAJsDDfexlAYHKUAVHUVDc3GJJuoMEB5JjLFT0=;
	b=Slvs+UT1aSHkiJR+qTewiwFiswL5bypOnWuwaEu8WGBnkjbwG/HMFikXivYQ3pXDXP22
	 DlcLntyA4Mat2v3lbHp7cDi5ldrVyVi+cJK2CR8hcUGSiSWTgp5qv2gD7KnWNARv9TqyV
	 0n3sGrUf5dBT4lvcOb4a17LtdWL+0tQ7fd3epnObdck+r4EKyGHLZOMpADDPax87IEpLM
	 1eU/bwri/P28g+/SGvpPn1Xm+c6RjWclbFi+PxIExsCaPJM1LkDKIMmNzj64gbHxewIvb
	 y/mqa4SW+H/w7dvu8L9YGJaknjYhgy3Zhhd3xwD/vxbWP4zyRz7YnhvIyP3Ew2hcs8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiymOOf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76E606A31A;
	Thu, 29 Oct 2026 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiymOOf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB90B1F031E1;
	Thu, 29 Oct 2026 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306305;
	bh=5LChJhAJsDDfexlAYHKUAVHUVDc3GJJuoMEB5JjLFT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EiymOOf1SFIZR07XNBmBtHsUG0/cxXyG65vmryJObOllY9qU0p8fGOUCf9T0+Blo4
	 iuWy5eRyHj0IegzchsZXQD5nozYmCXJ5q1tsWQ0Pc/FYEqnMkThdZp+/zgPF7cbvsw
	 4fT9qHtqSTab/Az1DiexmECSM1KXraeGktomLCs5OoqCWztAfj2WpEt+lSYnm9DMEc
	 kaWnMTeNameuxW6FWQesNXBe1C5PlKeVObJRyok+DLAT6FKviiUGSnCw8Kf7bALfL/
	 R4xYIxQLXDB/0dNyiXHgI14izBnV0Cj3NTEMEO6yOvFAYKUjGO1r6sZe2UYAavVeFq
	 3n5M6kwtAAStw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:15 +0100
Subject: [PATCH v2 20/47] mm/gup: fix clearing folios in memfd_pin_folios()
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
Message-Id: <20261029-fixes_core-v2-20-a64ce7f83abb@kernel.org>
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
 Samiullah Khawaja <skhawaja@google.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=david@kernel.org;
 h=from:subject:message-id; bh=a21vFMarzFqHDX4BmPSywjRcawxjg3B/znX9a9fmuWg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21b4iudU8XlwJNx/Lt78dXMqeZrmIou3DJ7uVzhx
 wTzd0U8HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkxUZGhsOfD82yeXHR80KQ
 up/Hmckh/E+sHj0KWM/QuapkQcoXNj1GhhvSVyfdzJlY0VR7+vnOucwCMvL2SZ9a07fNPzllOps
 DIzMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

memfd_pin_folios() pins folios obtained directly from the page cache
without checking whether they are uptodate. However, shmem fallocate()
can leave newly allocated folios uncleared and not uptodate. Callers
such as udmabuf can then expose uninitialized memory to userspace.

Clear non-uptodate folios and mark them uptodate under the folio lock
before returning them to the caller.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description and comment ]
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f809361227e7..cc4fa18783ce 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3527,6 +3527,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 					goto err;
 				}
 
+				/*
+				 * fallocate() can leave folios in the
+				 * page cache that were never cleared.
+				 */
+				if (!folio_test_uptodate(folio)) {
+					folio_lock(folio);
+					if (!folio_test_uptodate(folio)) {
+						folio_zero_range(folio, 0, folio_size(folio));
+						flush_dcache_folio(folio);
+						folio_mark_uptodate(folio);
+					}
+					folio_unlock(folio);
+				}
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 

-- 
2.43.0

