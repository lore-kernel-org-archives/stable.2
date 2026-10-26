Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057505;
	b=J9U5pTCoZD7miQQYUaNx5XxOHlNpeMFIGq9EhNaNrnQlUrWLFVAmVaOogcm9Lv4kSpKn
	 8bwtx0SBheQ3gJc6VfyeuNKq9Skbuse3Iz97mh1pE9YwqhBJ4cDOIS1LX05HQ7wBgHe0E
	 QYX3aJ4955QVuLpIPuKTG0HHvqVav/Y2Uf+kdkzzZVJKmtUS23qadTyT6UlsS2XSvLfFv
	 tOz9NOtGzf99vIy2r8QJJRkn6zXR2tWHwU8FLLnZ1CuzQK+9P2c0EaxHJaJbtS73ej3VE
	 2k3vZW69XUYXkESkv5ZThhxqmZu4Pq8COkpw8MTXhH4WRj5i8vsLGT6gkEQNs06jxMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057505;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JOZA/d3RnlEXnMB1S+vtRBXnoN845YtQMJ+bQJINkeg=;
	b=sOWdGnuQeORTVJhsGJ113sfp2yH+IJMW22PzaFSrnGIb58pmh8OI35flgFI5LMVPeSid
	 E9oDz3WtvEoNCHPCnCClfeZ8K7m/Sub7D+UmTih9z6XKJHHq6gXoO2e87+meZJX3GhwOr
	 fMbwHjPXsKNZFSUizDMQKPYrr3rRRgT2oQsRatwgWlvuoD8NY9hL5ajfv0qlsS8pllrWe
	 eIAxlkk+p/otf/UomCBJuJ5fu/1RIalBsk/qtGpTHks1kQp18LPZcaDjqz9zrzCVFIT+p
	 rW8bJ0czHvGcHB5bARHlnGH507c4bAfehgbBvBazlpI9Ls6JN5IZ8WsOdhVQLuEWttA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox2i2FSH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AB606A31D;
	Mon, 26 Oct 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox2i2FSH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76E1F01825;
	Mon, 26 Oct 2026 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057504;
	bh=JOZA/d3RnlEXnMB1S+vtRBXnoN845YtQMJ+bQJINkeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ox2i2FSHOypqrcZwgXnwxa5pmucASOgMRL5vDYqMTASHl2rf75YW3wQoVrkuPIuIi
	 qWBaawkuI8mbHfObP4rg08odrulxxwWOwc2kIfSbm6V7kYxzS7kix5XDxbFQgiI57R
	 vd/KGBmW9fqjr2ojLTHGLQyXB6fpiqHp4DCbdpXJvJtGtlMg8tu48HAXtQUxYfibsT
	 JsLarU2SHDjaAj8xnSGSrXvbdAGQU1FoX1lIooc+b6p0m+NHqmvpSisMO7dcd3rVVw
	 AUARD/nIWCCPO2WzwdlkLwUwJeQDZtBN2zbbbs27Pi0cCpSRpugWYDmuEeJDHrz0qE
	 2Nr+Rh3Vvxf7Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:18:04 +0100
Subject: [PATCH 44/46] mm/cma: don't release CMA pages still in use
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
Message-Id: <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=david@kernel.org;
 h=from:subject:message-id; bh=nx05kHs+vYnlpcYo2GO368aldzvpDGoDSteIsZANA+4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu359h9zUpMrRK7P9OThHTp6//rRVNZj6uMbl9Wn3v9
 c5EY4H9HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzk7RKG/1EXTeqmP/GzifCZ
 ePbvbCfeC7W/VWUvTCi5K3vki/Mam/cM/ytneLn+m+4vm8X6VsRtVrGe72WWIDPnlSqnFA5NmLY
 kmAMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Rik van Riel <riel@surriel.com>

When a driver calls dma_free_contiguous() before quiescing DMA, the
page might still have a reference from the device.
put_page_testzero() there returns false, WARN fires, but the code proceeds
to free_contig_frozen_range() putting a live page onto buddy and clearing
the bitmap. A subsequent allocation can hand the same PFN to a new
owner while the original holder still references it.

A concurrent put_page() that drops the last reference between the
testzero loop and free_contig_frozen_range() can double-queue the page
via page->lru, corrupting buddy lists.

Avoid the corruption by not freeing a CMA region if any of the
pages inside are still in use.

Make it explicit in the warning that the driver allowed a leak.

While at it, use page_ref_freeze() to make the semantics clearer and
switch to pr_warn_ratelimited().

Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
Cc: stable@vger.kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Link: https://patch.msgid.link/20260811132045.5f114772@fangorn
[ david: use page_ref_freeze() + pr_warn_ratelimited() ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/cma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261da..871f95c9ae9f0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -1020,7 +1020,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 		 unsigned long count)
 {
 	struct cma_memrange *cmr;
-	unsigned long ret = 0;
+	unsigned long leaked = 0;
 	unsigned long i, pfn;
 
 	cmr = find_cma_memrange(cma, pages, count);
@@ -1029,9 +1029,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	pfn = page_to_pfn(pages);
 	for (i = 0; i < count; i++, pfn++)
-		ret += !put_page_testzero(pfn_to_page(pfn));
+		leaked += !page_ref_freeze(pfn_to_page(pfn), 1);
 
-	WARN(ret, "%lu pages are still in use!\n", ret);
+	if (leaked) {
+		pr_warn_ratelimited("%lu pages are still in use, not freeing CMA region!\n",
+				   leaked);
+		return true;
+	}
 
 	__cma_release_frozen(cma, cmr, pages, count);
 

-- 
2.43.0

