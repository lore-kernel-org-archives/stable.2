Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884278;
	b=lTvaowqJ3hUq2ThPIsXyDj5bUbngzGRgZhDl1YlRcXc+CCxkns8MTlqhoXVj7Yc6Dx2R
	 4g0Bn7/boOcQF3nvRhLE4q1IoXF/nz/IFS4nzn6iIM2Vtpr9dpvmwXEGw0gxeNDJxVNsV
	 6Dd6AiXQ5iCcXnwh6IL7xgyYTWwOwYv63mAVAXBHcQdkRsHgYLZ3DVsCbVqJNo62FiXH2
	 NRYCdTNj6Z+abFxP1uk8FraIrxDl7zt+8gVyMtimAJriAZAID8ezWT0WkfvYM7Mtaj9yZ
	 Em1QJMbJWlcCZ69SdziBBGvKGHzlYnCap3dazLlEJeZJTO+krpT/tYKpat8Tbr2BdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884278;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=O+uAOf22ku0nBzO5a3bnCrNp2btg27dwJZHDk2t3+oc=;
	b=waUJsQdr8+ace3zwgswwP3orfcFRtNfsGChElLwMu2Vxr9d60RJFv+uPB9hggptji+Y1
	 ziT51AAY+D9yVCzPBYQmE3T7o17WSVGGcXw2j0bUhZzlJ1yxtUSeYN8gQvhUqNqK+SHfJ
	 mJyFUGlvbpPZwHE30LvFHrwUR9LihZh0p7QD8ML9fnxLNCBXUgyTxxVVkM1qSQ7Zhr2gu
	 tEN1ISutz7oBsK8A/A93rRDsHEGkgdPZGbDxK4DhAeGpA3X1BkXQxPeE4zrdvtoB9gcQa
	 6dbn4tx5CpUYdmkUvHXFnsbpym4tnHLnGcRmULRCHbd14EgcD5bO+5ZtTqETjL/3+bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6DY1Waz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232F606D815;
	Thu,  5 Nov 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6DY1Waz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BFA1F00A1B;
	Thu,  5 Nov 2026 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884278;
	bh=O+uAOf22ku0nBzO5a3bnCrNp2btg27dwJZHDk2t3+oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C6DY1WazDreIp0tqngL8J96ms2jUv/PGhhduU/iK8a4K4yiFtHbCImq5yDnpJSB/i
	 MfT83/xUbBuNgTPO+k6ECz01TEg9sNUG1vuGIMo+eDHmOGuSyK/iXBga1oxUJvU6aU
	 UleLYrBcEjbSEdPFjdvQZRHBf0w+ObpAzE/dWNnyZlxsEfa1E2GGa23gAVJlVV3E2C
	 gukdedk+fcJrHXpCAgX66uTS9c7Ioybk9NhVkXaGy0WzWE98E7/aHLlU95nZJV9z19
	 Oqc96TL3rSJh9YcyeeyatdylmcGOyB3tpTtGz6gvzdl2DJExwADPbM5H/dn42p891Z
	 1EkqpbCJAaDaw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 14:10:14 +0100
Subject: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
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
Message-Id: <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
In-Reply-To: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=david@kernel.org;
 h=from:subject:message-id; bh=IBF3fb4To5eP04NbeBZ/jj0H6jfX9PmTFRUfnhgVDek=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeNFhOiqkz3PLwi9bq1D/7fq4JYkqqbdslJTwlJHeTN
 +MK/mNNHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEN4aR4YGas5mNyg05jdwp
 L5pmXlDsVHMPbzDdvbWu5rHw8ek3kxj+6X9Yrf89V7Sg1lXs6jzOC3F8x1TtJ+29GvphkYnibr/
 ZPAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's replace our existing safety check by the new
folio_ref_count_over_limit() check in fast and slow GUP before acquiring
additional references or pins.

Keep it simple and use the check for all folio types.

Drop the WARN_ON_ONCE(), because apparently these things can currently
happen with large pagecache folios.

Keep the zero-refcount rejection if the refcount is 0.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2ab42fc6834e5..db9db6b2a4662 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 
 retry:
 	folio = page_folio(page);
-	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
+	if (unlikely(folio_ref_count_over_limit(folio)))
 		return NULL;
 	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
@@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 int __must_check try_grab_folio(struct folio *folio, int refs,
 				unsigned int flags)
 {
-	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
+	if ((flags & (FOLL_GET | FOLL_PIN)) &&
+	    unlikely(folio_ref_count_over_limit(folio)))
+		return -ENOMEM;
+
+	if (WARN_ON_ONCE(!folio_ref_count(folio)))
 		return -ENOMEM;
 
 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
@@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
 				struct folio *folio = page_folio(page);
 
 				/*
-				 * Since we already hold refcount on the
-				 * large folio, this should never fail.
+				 * Grabbing more references can fail once we
+				 * hit folio refcount limits.
 				 */
 				if (try_grab_folio(folio, page_increm - 1,
 						   gup_flags)) {

-- 
2.43.0

