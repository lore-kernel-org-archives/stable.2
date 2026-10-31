Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440146;
	b=xtPQAXkL29eg2AvrWdq4TJnOztDnUaiJXkWDtn2zj++XQFNaEpRqCZZrULdhBxPYLLYd
	 EvpCry1A+9qeng7ZvV1vaQCdUhMZLVU6JJbOkMvAznqYeUbzR5J3nPXOGRc13heHOfCAe
	 rh9+U1KSjUjmQRtfdLG4ZqVYX7If/z3ZW5hpyTex/MfiguBdZh+i4VEv7s5Ovzs2Uqb6I
	 9LeLT5ssGKAYk1s7zGtzzNMGlfloOuJc3qk/VZMCv8jDyBDNPmBPPUld0PBke78JRibE5
	 vl+zL9J7C7hkQjmkN5kMR3X1o5MxF9j/Z9mbXpAvKlzHE1ZgUEcuMRkOiIgZ+tOPlFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440146;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IjXGxdI21GHlefNuc9d8WG3Gh6i1uecgZnNzYjBLxQA=;
	b=JqOoJ+eH0J5VJ+gnQ3OaspY9skoNaVpTjRGgOQn127grZo5v6doBpl4Ghk9JvLoh78E5
	 Aqfid+IaDi/eUC8HMvC2ZQ8fpfHIhLjCNDsoRybiAkweyYgwv6VLgwukuYYPpqHNBX8KD
	 UwCN3vpxqQlHnRkCad+ckl1bEXXCG4b3haUgYIu7WwmZTby8NaEgPW0U9Y+wXz59nDqPA
	 cI1dhc2aTLDfBRrrbW8BSmCafzU9Nk4C6qu/g/VWWcI5Cj4TZgBHURqAIFUhPp0XJOTvv
	 ss48SUD/aFKF9+e+0EfEOv4ARngqGFjyhFsYxmVKzE2OApXGo+I72Azg59pb1VOnJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxe+k77k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882D606A31A;
	Sat, 31 Oct 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxe+k77k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB06D1F00A16;
	Sat, 31 Oct 2026 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440145;
	bh=IjXGxdI21GHlefNuc9d8WG3Gh6i1uecgZnNzYjBLxQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vxe+k77kJPuUdVyhCbp6hqSL5tOVmFwh62QnvvZPRanJVeYjVeqJffbeRNnz6bi7Z
	 vJdeaHpjumIsgJdILQnTJEu7H7EbVbRZsqoXiAagi4mHoe3X/P3hsSEdpjEbruGdEl
	 fkie4Ik9xJ4scAW7TEs2sD0XZmJ98VuYgSZwI9KITCZBowq0dQUQCaY6WDXIIIhDSW
	 mlGHw7ibBWgm3xwzwaCOM78EU02kSve6SOeLgYiVL3f8yUrfXWbUbskMw2cilY0ust
	 QFg4g9JR0agefCjXswUnCs6aQu3t7FyolU+jzLtrz4mmumfSsW66hGPLXxSJJBbO+9
	 RX+PAGn7J9Qnw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:03 +0100
Subject: [PATCH v3 34/47] mm/madvise: fix data loss from MADV_FREE on a KSM
 page
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
Message-Id: <20261031-fixes_core-v3-34-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=david@kernel.org;
 h=from:subject:message-id; bh=1jHBM4yk7cItfizVmqJa87+gzav2ElPv67Z1UsegsEg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs9coxvHyH1z9s7VefczZtw+fkhp40ypL1M2bLLxy
 Cx3fSHF2VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEZmkz/C/0dhFjdz3d/179
 gLK7z3f2pa9y9xzsbsid1zQ1c8LEyp+MDHPUY16u7ZrSKTKz6UJziCPDjl/K/z5zx+p/sKx6+vj
 GE04A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf2..a16e3cb256b7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its

-- 
2.43.0

