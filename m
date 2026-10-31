Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440037;
	b=BLmZJ7AgyjDpUp0McjIETA2txwewBb9dJJCLPT7xq7DEawclVgU8asWT/tOxM0VyduCZ
	 O3M8nR6/p39FAJWXwAi6TUvdGxQpXF+yzdglr/n39BA1x3fex48YKJsDF3Fce3qy4P2gz
	 2J3RKUPKcm7YGdSxbME/oJql2D6u1OWYD/7u5CNXm3HaTkdQYiBHfmPmm0yEiw/Lc3iWz
	 8X0BYomNsp7J1xJvvqkV9oWEmwsW4ei8EFcF4Py/XjcdU6FbDmBR9H3IvZmhQW23wOu1M
	 3Xhd0LiBmgr4JAbmS5rSIg1i0pbKfPOF8m294V6kvxNB7se+RVXd/N07QPgTQdGoQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440037;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KVrdbHh4TefzyeW1e6RlSzEhzIhMK50yL/X3kkZm6/4=;
	b=4aKuVNPl6xcvYodWyu8/l7mDsK9mT5WlerAi+8Ko2Mja++bqpKyqzvBLfWyFmSTituP7
	 AqkCNDbNF7fUIPhTMI+bjhfX+g+uWvqZ7JP6xS2WjhORDX4dhK6kEa+KTfnu7/5zmY8Y5
	 cTA5uTIK6C1x73JGiq2sNwCHeOB5lrhbpN6r55OFNYpHck25d2KuVUC7G2mBq/yye4rKN
	 jNUcLYR7FIJOZgNPn6rr1ZJFt1G0p1awxUMXsdFPAEHjvM136dfDFG7t5tXXCVCFjnT76
	 c9FpGzzXMh//K6LRMTBGuMPVnHigxDj/5xzDznITvVJbIsNWSMtcBm2wanda1L0ebBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaCWaKaw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA666606A320;
	Sat, 31 Oct 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaCWaKaw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC01F00919;
	Sat, 31 Oct 2026 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440036;
	bh=KVrdbHh4TefzyeW1e6RlSzEhzIhMK50yL/X3kkZm6/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IaCWaKawXOqDcZ22xFCnwg7umYwYJDgAbJNOOK5GTEKGHR4Bx9Acayri7plzIv2dF
	 0xsaLS7xr4ETWZusdZHXrFhdvJbU1AhSTCPEA0QR3Dj1ccFkxelrbwXMWTOnrQQWG3
	 58kyNmdrL4h4kMvLnIkpzCrckrID/LCj0Cf5LWhtYMlVhaHMgI1lgO/M9mXJT3I+oS
	 Z2xhPUc1AK103gnGCePYltjzgbzdLKcT6Hk2CY7ZOOT3q1CY+nRSeutkrRUi7hRWeR
	 F8JX7Cij2PkVFNeFOQbrbxnEdvAY1cKNFIxVfTTwYaHRhB/a7xn+bEQBXPQJM9W6rl
	 g/T9m03kc4kGQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:56 +0100
Subject: [PATCH v3 27/47] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
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
Message-Id: <20261031-fixes_core-v3-27-d6437171ecc3@kernel.org>
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
 SJ Park <sj@kernel.org>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=david@kernel.org;
 h=from:subject:message-id; bh=XMqAbJynrW+dSeh468tky7AqZSEZvUJFOrLi82qkd/w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+Q9csy471kdl/JWJJ57iLLuN+/Dm83vFRrH99oc
 7pyn8zijlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbifp2R4daLlSYBH/m0hd89
 6zgm/f7UvRPHexf3Ppv+3PCr3TX9iQqMDGs2JfTrdpm2nXv/RPP2W62itX1MireabfWCQlf+3vo
 olh8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

__tlb_adjust_range() takes the size of the range which has to be flushed
as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
and pass an unsigned long. Consequently, a range that is 4 GiB or larger
gets truncated, possibly to 0.

On arm64 with hugetlb, a 64k kernel can have 16 GiB hugetlb folios
mapped contiguously at the PMD level and flush them when unmapping, and a
16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
at least these two scenarios are affected.

Fix it by flushing the proper range instead of the truncated one by
properly using "unsigned long" for range_size.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: use two-tab indent, simplify description ]
Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: SJ Park <sj@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a443..3f4a180b48f3c 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -350,8 +350,7 @@ struct mmu_gather {
 void tlb_flush_mmu(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
-				      unsigned long address,
-				      unsigned int range_size)
+		unsigned long address, unsigned long range_size)
 {
 	tlb->start = min(tlb->start, address);
 	tlb->end = max(tlb->end, address + range_size);

-- 
2.43.0

