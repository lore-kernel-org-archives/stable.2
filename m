Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440178;
	b=BBIN/M9O0lnGceHI/j0cxAs8ZxW95eYlTsu4MCSiP/bRxtNLdrNnOtmBxVJsPpefC6sJ
	 7NOxGBnZmrDYJI2onjsGzb+/iqdZZ+iFiOpCadBep5NuN0wueT84fqo/k77hcMyZ2JVtQ
	 Ia4mc82auJyzyDvkuwqxJsV9iGVgiycGmF5EXAAhDzUsQrg1Xvdnjuii70fazdjdX+zmA
	 k9KWrC3S6pEKnMWwyd+RaT+mWEi4o1QaRbWgZL3xKCpqpn/ccisjEv+7PxOOioQPUPCYO
	 o5ltuhH7jHxln0Osxa0Mp6zRcK2aclGYzklJP1NcyDwhMK1waUsbnLs7Zff7OS56L/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440178;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rOWqT7E2jlZnxV1djpCyvfyOt0ij9uMBqoxxut+BDGs=;
	b=RVblew6y3cHfWZzw2HXzqHPIVRsk94fP5SD9IREsjROV8bkS7quQa+eaXQ35m9ilNdAy
	 CcKR5BFn2zp+YEEvWloXkL7G4/5rP1NXPRl/Zy61Q/iJoIj1+/bBmXPIvJgh8hWzaQNSy
	 SpQz4RPqJ/VYCZHmHNtO03CPi/906TrwmgC9odtslF46iwXuXXcgVhecoVa/7sGE0d6mM
	 vkdSIt/+IcFEX7a6VrBu4TwE868Kitf1jhLEq9JVLWIWoQgo6H1M0BCwaK0aoWHQyrQMF
	 hL/1mL25mdfadPO097I+sEYGLMdzA+HsmoNZVf7knzNufeD+LlaDQ82WSDlvLMpqHBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgiUPxnW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E2606A31D;
	Sat, 31 Oct 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgiUPxnW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C9D1F0093A;
	Sat, 31 Oct 2026 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440177;
	bh=rOWqT7E2jlZnxV1djpCyvfyOt0ij9uMBqoxxut+BDGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bgiUPxnWgw20xW52DyS0zumdr+ezcjL1UDtOGrrrSl0ltBejFbx3s0f7UEhNUGBRq
	 4Gk9HL+8iT02eUm7kFNBMfO9XgUqgsmpIpqN/3bNIWZwlrzDpRrQF2M1VbSW2UfENF
	 Nk62ddSQEeHgNduuIYayvJTjaUUDHE/9XYk9nNQq4h/i8CXq3qE6ylbND93mcepYkk
	 3WpICKfXn+oWmej7+8dRsQRZ0qZwW0ulhCnMnoxYXPypDFjuEal2dEgFD3cp/3BT3M
	 2msoIqABxVPyNKMtiV0kztNaK6WXA4nZU8iM6jKsV6h3pZQ6RAGXpo8tJuEZgJCPlV
	 c6eWTlW26+AEw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:05 +0100
Subject: [PATCH v3 36/47] mm: fix unmap_mapping_range() beyond 4 GiB on
 32-bit
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
Message-Id: <20261031-fixes_core-v3-36-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=david@kernel.org;
 h=from:subject:message-id; bh=qTyO6PBC45dn95yUMdB1b+shzP6oCOwzkg60jjakQ/M=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+KfyDbbTVRv5KnceWdpztENVQydOPb3K8d9Qu92
 HOY1dOro5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkc2cvIsD7h9Y0t79LnMCiJ
 dbY2rKjkW9Gq+VXYqIGRNdX/3N9f2xkZZn5+o713W1Pd94+hp13vtK5XbHxQ+bEr8jyvQVaObYM
 7HwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

Commit 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
made holebegin and holelen unsigned before they are shifted, by casting
them to pgoff_t. That is an unsigned long: on a 32-bit kernel the cast
cuts off the upper half of the two loff_t values, so a hole which begins
at 4 GiB or beyond is taken for one in the first 4 GiB of the file.

truncate_pagecache() passes the new size of the file and asks for private
COWed pages to be unmapped as well. If a file of 6 GiB is truncated to
5 GiB, everything from 1 GiB on is unmapped, and what a process has
written to a private mapping of the range between 1 GiB and 5 GiB is
lost: it reads the contents of the file again.

Where the range has an end, the wrong range is unmapped instead of the
right one. The page cache copes with that, as it unmaps every folio that
it removes. The callers which only have unmap_mapping_range() to get
rid of user mappings do not, for example drm_vma_node_unmap(), whose fake
offsets reach beyond 4 GiB on 32-bit, and revoke_iomem() with physical
addresses of more than 32 bits.

Cast to u64 instead. Nothing changes for 64-bit kernels.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ae8d567bc6ba3..732b8f926de6a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4649,8 +4649,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
-	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (u64)holebegin >> PAGE_SHIFT;
+	pgoff_t hlen = ((u64)holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {

-- 
2.43.0

