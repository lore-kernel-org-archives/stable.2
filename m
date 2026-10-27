Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116005;
	b=SSTsoai2etBcIsbI1JIIIOdHWRJwOhTDV2x/ojthewTRKw3ASa8S/fGMvrZUw2N7GR3z
	 cq9tU6i3192b3cpBUOD0Md+bl1ARuwEmzW2ycLyN/qMewQY/TkpmXmi1xcvBeLLOX9rtk
	 mfLKbkq0AEjFqDOqFtXQ0znCjR4bUW/gXA9PvBQStlht4SDfbnuRVaiPrFIObzQJHXV/r
	 GKOATeUrfYow4F9MgGmtDzSG8hd0+3tmXCi7DIefs8+YZIjcM4EoVK+uH4GqVusRGFQvf
	 /HmX12ETRvq+XBWauYln/GO3AdFXvS3FDlPJ2qgO8Y3T6wY39clbTFSKIPihvcqv9nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116005;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=30qAFA6CCzSksl7jqcRR+D8NveKerXteOKC7Yb7cCqk=;
	b=RWwlAaKNIzCCQnkpgpRprZl3ZzQ5mu0kHjZ0XBUobDeSfdheQ7RAbCAdrV48WhKIze/d
	 LSHA3pUoYCocCLIM7tgm2kani/Kk1Q9Q1lKCjDdoHRdqZwpvJg6fz4A+3b8jyfflkrBJn
	 NuYsaCa/o5ulRtW+qujdEUULRlSu+y444QAnbhZG1yD2e9XrkPSnPq0OA+Qk5aVcil+H0
	 gJ2v8abfU7xVM4zq6kAb7xDAbzwIvZ3ioa3nrRk9VETN9Gs47/ZNGBXDZMLAz+ZgzRR4N
	 JaVDsMFZM9AuYs/i+mPRBRFCwm4tJPel6x8vtLO3fhxMUpgPvbXNj92TrOq3kF5rn6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E12ZfgfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FB606A329;
	Tue, 27 Oct 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E12ZfgfY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F31F01825;
	Tue, 27 Oct 2026 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116005;
	bh=30qAFA6CCzSksl7jqcRR+D8NveKerXteOKC7Yb7cCqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E12ZfgfY9ynMlsq27sp3+JPTml03yPMJtxySRvItV0bZeT/oBcKyDuGbdDrwJ7G/g
	 /3yTyW3G2KdkQEkm7nATNIpbNf5GGLbUPJ2hlys+9e3n/nP3DQogyfyN/8Ine0Wg8K
	 eTKj345nI26OzTolIvYj2lP0WeVmQMqVWvW7ZfSUBpJewvOxP/DmoDKYrpm8oYLaIt
	 UjUZ+njZG2AOdpBIw79hu+wj6ia6FcGeNNRRRfdbGVMBlP8eaQyw/Je33Fa2uHH12E
	 mANIpIC1zrp6cBBxBwtI4LvzIfFQmKD8Qq9zHZSgOZhdrvfPBJjWQL40tSdbjEoznl
	 zEA2ZqWTrwzRg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:29 +0100
Subject: [PATCH 3/9] mm: page_frag: refill the cache for large fragments
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
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-3-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

A fragment which is larger than PAGE_SIZE can only be served from the
32K page of a page_frag_cache. If memory is low and the cache had to fall
back to a single page, __page_frag_alloc_align() returns NULL and keeps
that page.

Since the offset counts up, this check comes first and is made whenever
the fragment does not fit behind nc->offset, no matter how big the page
of the cache is. So the cache is never refilled on behalf of a large
fragment: with fragsz = 10000 the first three allocations succeed, the
fourth one and all the following ones fail although memory is plentiful.
nc->offset does not move either, so this lasts until smaller fragments
have used up the rest of the page, which never happens if the cache has
no other user.

The nfp driver allocates its receive buffers with napi_alloc_frag() and
netdev_alloc_frag(). They are larger than a page with a jumbo MTU.

Only give up if the fragment does not fit into the page at all, which is
what the comment describes. The fourth allocation in the scenario above
with a 32k page will thus now proceed to refill the cache.

Fixes: 8218f62c9c9b ("mm: page_frag: use initial zero offset for page_frag_alloc_align()")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
[vbabka@kernel.org: make the comment more obvious]
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_frag_cache.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index e63efe78b7d4..8914437ddc51 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -119,15 +119,20 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
 	if (unlikely(offset + fragsz > size)) {
-		if (unlikely(fragsz > PAGE_SIZE)) {
+		if (unlikely(fragsz > size)) {
 			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
+			 * The caller is trying to allocate a fragment that's
+			 * larger than the whole cache page.
+			 *
+			 * Either fragsz is larger than PAGE_FRAG_CACHE_MAX_SIZE
+			 * so this cannot ever succeed.
+			 *
+			 * Or the refill has fallen back to order-0 due to a low
+			 * memory condition. Then we don't want to release the
+			 * cache page to attempt a new large-size refill because
+			 * it could make memory pressure worse.
+			 *
+			 * So in both cases we simply return NULL here.
 			 */
 			return NULL;
 		}

-- 
2.56.0

