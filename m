Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439756;
	b=yNWdNGX5ugB0PsfTb6wUGaj5h6TV1T+OFoYjFFPEb9POCfw140obe7LA8ejmuKF0NuiX
	 U96wyMF1I5SW0OX5PHajKQUrPem8Z0iZeG/kveoYVzcSmZXGSQM90Q0i/lLEL6mJog8cy
	 l85ylXd5fQcFyVPRGmtRzijaxOFKSZqTlnDxw5ePjDwQVNjpT5gfUsEKjlVIolYHgT3hA
	 MP3OXHtgWh9u/4h7eQoZyJvnCy2/p+qil/APNXXXKpRikXPuUvKBePI/VrsimY4Q3ex7l
	 FPsRC2nvSemwSGDzUvT8xgU4zzK8lbG36tlJ2jpCzejsDIl0c3SrkABeQO5Mor6lmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439756;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PCXji8t2YghBn8zNO97WnfB06mhFIwWKCiaxVt0zvRk=;
	b=LvAZFMw5Vyf9ESsuXXwUGAoba6jc584y0aZkhCmjWnmeM2LhYF0xvNNU1jKj8Ig+YiK6
	 LbF9c3h/W44F86sWF8koLCHMNpo7IgjG3Vfm1+jl74ZCcb7VqSAZqR5IipnxAOYKEhq5y
	 zGMFVoQPDXznVUOPnWnw+sZ4pQNJnLYKDbX919Lr9LbUJ7okV10vN4pw+fCWhA1aPYgxC
	 RD8/uPYcjvZfnPkWN8npxYdy6tb4xuxrzK0A0uaNsR0IDjMhE4/lyrbbJ+YFtMuc2VHJ0
	 PWbw0Jru2e2wrg9HqoSnD75LyYQgp3xxVLRsSfytS//UwZjtWR+xjkBJOpfXCd61eMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5e53RJF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC06606A331;
	Sat, 31 Oct 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5e53RJF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6831F0093A;
	Sat, 31 Oct 2026 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439755;
	bh=PCXji8t2YghBn8zNO97WnfB06mhFIwWKCiaxVt0zvRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z5e53RJFYXZm94nrWWOWfz98i5n0k7Vq1mlTIUq5K8+xJc8k6dpaYYzSZsF4CgBGh
	 v4KYqINsYG9kt2cDdfKy0eTyGyYpv6J5W5NiuEPWdzqHf88nGhb0V60FfXxzWiLdX3
	 QmdhnZrltq4DP3/sy1XSUvGTC8FipG5eXCbz9AOB+hjr5+MIg4VzYpuGk4ssaJpufB
	 TQO0s/RKG+JX4ALqjZDzvmreezhmYOe5sHjpVmP0tZoPQLouAFH7bKEQyTb3phuSOY
	 jUGQIHVgorDoKoHm4liePBrx/LWneHktnw6p09RxrbfVYcoo6un0Z7fj/dn2+TFapn
	 MVKDKVJ5kogzA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:38 +0100
Subject: [PATCH v3 09/47] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-fixes_core-v3-9-d6437171ecc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=david@kernel.org;
 h=from:subject:message-id; bh=glmREPecf3Soxf23A8cAtJsaeHFT2ex5UzHoQI9g+28=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk8TXHrRW3j5ImPXqRM2+EWeLvBgOzKltzWl/Yf1J
 /Wu2evmdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARpheMDFNaAhtDhL1kNO1c
 dGdue3/ixn6rTU5ud9Ss+l5+3C7szsbwk7Fgs0P+Td/7KsFuhndbzDKmPefPbc5Li/3Itfb6dNY
 p3AA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

page_vma_mapped_walk() can return non-present device-exclusive entries,
but folio_referenced_one() passes them to PTE young-bit accessors that
require present PTEs.

We must neither call clear_flush_young_ptes_notify() nor
folio_pte_batch() with non-present entries. For example, clearing the
young bit on non-present PTEs can corrupt the entry: on arm64
PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
entry into an ordinary swap entry.

folio_pte_batch() will VM_WARN_ON_FOLIO.

Apply the same approach as the previous fixes to e.g., damon_ptep_mkold():
treat these entries as old from the CPU's perspective and obtain their
young state through the MMU notifier.

Skip PTE batching and MGLRU look-around for non-present entries, and
don't modify non-present PTEs.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc28..0faef46806e5c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -924,6 +924,7 @@ static bool folio_referenced_one(struct folio *folio,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int ptes = 0, referenced = 0;
 	unsigned int nr;
+	pte_t pteval;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
@@ -968,10 +969,12 @@ static bool folio_referenced_one(struct folio *folio,
 			return false;
 		}
 
-		if (pvmw.pte && folio_test_large(folio)) {
+		if (pvmw.pte)
+			pteval = ptep_get(pvmw.pte);
+
+		if (pvmw.pte && pte_present(pteval) && folio_test_large(folio)) {
 			const unsigned long end_addr = pmd_addr_end(address, vma->vm_end);
 			const unsigned int max_nr = (end_addr - address) >> PAGE_SHIFT;
-			pte_t pteval = ptep_get(pvmw.pte);
 
 			nr = folio_pte_batch(folio, pvmw.pte, pteval, max_nr);
 		}
@@ -981,11 +984,23 @@ static bool folio_referenced_one(struct folio *folio,
 		 * are. —they could be on active/inactive lists or on MGLRU. So the
 		 * simplest approach is to disable this look-around optimization.
 		 */
-		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte) {
+		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte &&
+		    pte_present(pteval)) {
 			if (lru_gen_look_around(&pvmw, nr))
 				referenced++;
 		} else if (pvmw.pte) {
-			if (clear_flush_young_ptes_notify(vma, address, pvmw.pte, nr))
+			bool young = false;
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			if (pte_present(pteval))
+				young = clear_flush_young_ptes(vma, address, pvmw.pte, nr);
+			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
+								address + nr * PAGE_SIZE);
+			if (young)
 				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,

-- 
2.43.0

