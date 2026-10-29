Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306202;
	b=d8/7piSsfb4TacxC7qh+zOcwkioSNWqL9z7FMe8lqqlvZdTrcsvEwBFgLxt6QP8aScQF
	 rYuxYwNe3248RSLjUyWsOeHDZdAOw9K4wlnuceRmgu84g7+sCVS9VjP+u8OlSpKRbrluG
	 1A34U9Gf5A7mTg8ekQTVHAmMfUZem7ObZSnhjhx0wvQMqHi69e4dCZgJCpQxdz0oh8mPs
	 b1YmBRhUwxTel4U6gSfbPWNPvuMhnM+P3ltH6j5hA6tZcXLzTUaQYW/e6hDVLITaNNhEu
	 SCRUauNQS8ok6msJF/riXBscgx2DnRjI6dOQcx9jOxoC2fbzgT82gYj4oXGzxtfndBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306202;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q5vK/qK4XuBQrL53cs9TeuLxUrSX2eJpWdLNS5EZvqY=;
	b=SXJOSmgn6Lr6xB1cvpNJEXOMar1NyjKx2yzhqfRuh/DiBiPFGdo6Hctj+kZ2Hw9O9+ie
	 w/lbfsLYk43oYIE/41XNIGy3LqygEU0Avx0PKr4dEy/TJlZfZ/yfWOAqZ1NMFzFtgJSS8
	 cQoIXeiuYA0AmfSKTXiXT3ZY/Trrr6WGd3zhL3uHeQK0+4d/OZc854y+yuZgD/g96MZG4
	 UxNzd1qNKTal7KAHrg68UBpXQ/uo4T+eC+doJidTz790hiI8BH4ZcqAmm98bQj7f44QMK
	 tpJhutAuh+9jsvCxHWpC9QS9VchaL7oTfY0pPIE1yHEmXpRfYcf/O+D+yc+Hdz92hsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn33W2jS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E3606A323;
	Thu, 29 Oct 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn33W2jS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39EF1F01816;
	Thu, 29 Oct 2026 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306202;
	bh=q5vK/qK4XuBQrL53cs9TeuLxUrSX2eJpWdLNS5EZvqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wn33W2jSO7FMd6s0f6J+WahGrG50HQ170ETyv6hs47qSO1TwExsP9mS9I9/sBR3+c
	 7wsvODaM9WxAO5Rc5MJD34QTdFNd4D08AlxQyrVme7gS4+H0uLmPkOVIJZg7RTVfdc
	 zaLgXKXLjTgdZKdtfmg0AFBGu9Ssc9s+ntFiFxRAjCvlss1/LcmLsBYqtdrqVGlRG0
	 9CDMyd4sYfaUFqKRB9NscT9OhnDRrKnXImU+vH5BiOtbyQW/e/5qy85Fn5d/9xx7cr
	 Su1TurTVFKrvkJSSNlOjYBJx5bpNzRnX2gPRMqdkL8WXnfFrlviI2cmvyyjoLIzbjy
	 7x2DRkHzJkQnw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:08 +0100
Subject: [PATCH v2 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
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
Message-Id: <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=david@kernel.org;
 h=from:subject:message-id; bh=whzXA4Qm4HXSA1pqm4tcjWrVcDozZ04CivHfstsAKVQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer221D+SO8q1Sly3O/b/h+7nDEu/kw7iWNp/nM7Vet
 HgP39H4jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTAG6yEMM/UwX358mXle/zSWT1
 C8a7zAkNVfL6do+z7XPyZJFLRnKKDL+YK/rkNSuXzGoxr93d/TuuL1y5+PQNd8e8cyxz3n6uMeQ
 BAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
If this was the last mapping, truncation can skip unmapping the folio
and proceed without waiting for the PMD lock, racing with dirtying.

ifs_set_range_dirty() can oops if MADV_DONTNEED races with
ftruncate() on XFS, when we get the folio set dirty after it was found
to not be mapped anymore.

Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
matching the PTE zap path. This keeps the folio mapped while updating
its state, so truncation must wait for the page table lock.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b31a425c7a3..1d65c4f576f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,10 +2495,6 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	const bool is_device_private = folio_is_device_private(folio);
 
-	/* Present and device private folios are rmappable. */
-	if (is_present || is_device_private)
-		folio_remove_rmap_pmd(folio, &folio->page, vma);
-
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 	} else {
@@ -2512,6 +2508,13 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 			folio_mark_accessed(folio);
 	}
 
+	/*
+	 * Present and device private folios are rmappable. Remove the
+	 * rmap after transferring young+dirty to the folio.
+	 */
+	if (is_present || is_device_private)
+		folio_remove_rmap_pmd(folio, &folio->page, vma);
+
 	/* Device private folios are pinned. */
 	if (is_device_private)
 		folio_put(folio);

-- 
2.43.0

