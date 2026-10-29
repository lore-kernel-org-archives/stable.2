Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306217;
	b=5i0oEPFeJ0ercMb5b+EBimYHRfVIMnb0tSGtJUlK/VleTpBG4iWm7Os7CGGCjSJP6T/1
	 qwDknJwnBVuP6hTR5w0tg89bXJSwlj6u+IwUBPI5dBAMw2M3QKOGNRiAlrbR1iMp0OkXf
	 0oqKTwNxHIV7/jY/Q8q4Gbl4GFZgk98Bd/nIus0tuGkwZmpgwcbBjw7Xo6b9SeaEjZzpn
	 MtbbV8rL1tQ363bhkxJzkx2yVS61e81tJfgZxiIQsnvMlUn6lSNw7m7GqkoRWZu7dHX8F
	 LSQaXBWTpu+fhQLiyG3J+ppjqczaYmvN3REoxz8/1qD73ZhfAGJqxoi9saOokEnIoAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306217;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=39sO4eVWOAhWIFY7dwmw5wDLBZR1O1Wkdyg2pyVIaSw=;
	b=cybTkaxjpRO/Lt6ygiMagtHK4sFUS/Omqa1a2nvQ2bkfyENzXpGBTXHjXsQKBq4NIyoR
	 UllgkOklJHMQ9oTMPShmX1TCyO6CS+QDtGZjbBREq1QUtaXsND8R/iIFBIzCjGBQqekLl
	 iaXPvw+LOscDIMLP8oBYoOFN4zZbvrkmrOQsIW1c4sxKq6PMhGRvGEmL+5GgNIfsl1IDE
	 BplWblBwBisWYVVbfESYk01+2T+KCW8aN5/GOjhDyDRGQThbcuOI7wfZx5O8zcrnnPN6S
	 akYldFBUg/TcyEohPzezfN3QR7h87e/0zCL7uixmxxoOg23Hp2jhG5H0RjxMwFQB8Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hLIyzFr/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969C606A335;
	Thu, 29 Oct 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLIyzFr/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E0E1F01828;
	Thu, 29 Oct 2026 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306217;
	bh=39sO4eVWOAhWIFY7dwmw5wDLBZR1O1Wkdyg2pyVIaSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hLIyzFr/V/VvcGfnmQExxQg7IIwVIxjs2CWLB1sCab5pSvGmM4huLIGWjFbTIQt/g
	 LvIjs//slU9Pq4A2SJLgO204tjYJlgMOO2JybMj7kVGc2TG/vohe/X3Zz7FeCoRLRc
	 nrf/oQie/gYaRI5uDKW3ey8ucpkNlAPAQfa6wQ9bTo3VzjDmA6sP4x+IV/OttkAqd3
	 JyWct3e8oJ1K9D8M52trvZOLS6s+qHpCPGamQ5HJ5Fz9lHdo495ySJkjCRlFWivA2z
	 btGsxZgoULfAhGK6RKAeYV19UJkhbRKtCZuqzEA68xNrUH7XyrReQRSJ+prYoLs7a3
	 fqpJE+V6bRCdQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:09 +0100
Subject: [PATCH v2 14/47] mm/huge_memory: fix zapping migration entries for
 device-private THPs
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
Message-Id: <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=david@kernel.org;
 h=from:subject:message-id; bh=I7I0jhaFoDQ+nBqhpxvpT0b9yhPeTYbK2Z2XhTeg/TA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21bu2tt8uaHDhHRMpPkLUTW16ivZ94sK3hdWn5lQ
 8L31aqJHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkghUjw3rfBSFaX+RXSHif
 D2cU2Dqz50GT77tKx0VZSuXaaz3ahRj+KTklP/0QL6kglxAToL0i5/q5rtPBtyrT2i1fVd2MMHv
 HAQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A PMD migration entry can refer to a device-private folio.
zap_huge_pmd_folio() checks the folio type instead of the entry type,
so it treats such a migration entry as a device-private entry.

Installing the migration entry already removed the reverse mapping and
dropped the mapping reference. Zapping it must not repeat those
operations. Concurrent MADV_DONTNEED during migration back to system
memory can trigger this.

Check the PMD entry type using pmd_is_device_private_entry().

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d65c4f576f9..c5aa0a0a407c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2493,7 +2493,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 		pmd_t pmdval, struct folio *folio, bool is_present)
 {
-	const bool is_device_private = folio_is_device_private(folio);
+	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);
 
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);

-- 
2.43.0

