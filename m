Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722622;
	b=5R5SvtEnHWwCgLq//Czr3qQ9NJtaPIkirWcz2aFFlrC4BDiDBZrmSOYHw09CpocBfqS/
	 tk0iHlxdeKsnHEXr4EMkC7z9bmSgYIbD6teMQaNVW3t4LJZKNO71Kc/xD1LPf6q3BAeb6
	 5yeFpXGK4XOyJHLittK+K/ANvXCSA2XXnWGnBhK8UiZVe5j2zvtrxJgMnifCn0GQuU1TM
	 kz+0VikTD1Rr91JX8rLB7bg0P1PumwIsY1bEHsWHbWIR+ILfQ67MOzKxbupksskY898RF
	 aiCEKJe6O8YiyBXwmB8gWLIdUZgkVsjKK6x1FLIrLUbh+kD55I7U2U/HB0vqEyT8MCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722622;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=30qAFA6CCzSksl7jqcRR+D8NveKerXteOKC7Yb7cCqk=;
	b=ZupuNmgmdCogDsOrCbhGLAQxWsUau8gjfbA79QTitj3lzPLm8osHyJZbi4fnWe9+Ljfn
	 /K6QCr9p/+GDbnqYd/Gh+5KZFEJskjnI6AuhSJROb9hXSDgud2HQ6LgELi3yrDpZsDnc5
	 4Sse8QlE04PxZNJ5vqax02Np9qTI0xyCS/SDqTGOZ7eOulDaX6Q8qjgBK6kC0cmxU1UjO
	 00NlxW2ZZ1GRo5Cd83JcZHVSeJtKCTuXuIDYpxvntoRmMNJTyunVVgijBkqaLS1JSd1Fs
	 AkOJWgaEDjHUEYOAtGhuIrl8TCCwRO2+3IQPgIHWwnX3G9zPyKxtaFFF1UZSUbGAVkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmV43mOz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B76606EE87;
	Tue,  3 Nov 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmV43mOz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBE21F0093A;
	Tue,  3 Nov 2026 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722621;
	bh=30qAFA6CCzSksl7jqcRR+D8NveKerXteOKC7Yb7cCqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HmV43mOzSIYW7Fqzzpqz0hvDqDm1I7mTGmAhF+mOU6G/sV9c35CEfISlK2ItOEFZd
	 WOMktGf0v3XfLMGqV9cgWx97bu0HWn/qgbMbte2d+vi8wEeNrJpwLGYcvhmZZI3ZOf
	 jMBZ4kISM5YzUrGPkNb8ATGwQ4Y/BDN8by9X0l+NL6XwH/rxYd3YJKsY1TVMQbAccK
	 lgHYRTnm19YRWIRjT7g1F2nGjhvitI2NyfFXS4ZC1gehsPXJ+bC06xyR38sfKIwXNt
	 GGZCRMa1i3FpZf9/ReFYE5Q8HrpJZ86OC/kxgaeyyDM7S+iYlmOUlkOrrqAC0TogcJ
	 5ZTISNxEJEpPg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 03 Nov 2026 17:16:48 +0100
Subject: [PATCH v2 2/5] mm: page_frag: refill the cache for large fragments
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
Message-Id: <20261103-pgalloc-ai-hotfixes-v2-2-e0d2890ab74f@kernel.org>
References: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
In-Reply-To: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org, 
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

