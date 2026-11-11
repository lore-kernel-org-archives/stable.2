Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411047;
	b=zyo7WrWjjVjdZNpcyUZEYpynFNcwEOXXfN15C3s09tXijhPAWMdfbhGwblFEuizPBfNI
	 0AJpk/VOe+kPHRlsp9ORu+fBkiCd7pb+Kk5Ox2GAX3qhr4Slslkfx0PiApWRCTibnncKo
	 x7SQFCiCJ/9pEh21JiYVJ2KyWKqSPo6cDY1/qMsVUGGjSpe28dXhs0TLzNVE4/U9Wevrx
	 vT4Qo9cg6WUiE/p0cp7N6IVjWoyct+EONjLvF+3EtVjuyx+GZDrY94c8/cyZD2mquHPv9
	 SUpWGjg6M5juqmi7a7fwBBveNdUF1hcupkasJgfoV+LgEB4KGvG0eUQCcn6h/ZcV43A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oh0EMdAhesLwEjUQbkNfNH27+MPo1lgv6Y8X1Ijaoxw=;
	b=RgD3dhWcqL3T3K6uSw14qw5i7TkJ2VQ31G+mlNYrqCVxOLh4nqXToT91WBXqzLn1sAC/
	 9lHeSuPxMypvk4e5+AHvCOFCPVXAPRox0srEXFhOpZxaFTMMOghgcuenpV+pFTmJs7ymy
	 ig0OeOscUFouHnN8tT98QPyNqCLru8bfJ2grfUTkcA6ennO3c+1LNd0fy6qN/LsnTbDfJ
	 54iZfniMWMPt6fBtVKFGfbB/dJ9VcJkjJhEKY0z+Gg6q41UQ438+jedX1641s+SH7duu5
	 K6mD0wrZmOXDFWQK4jgvu0PPveMSKIyshc+V6HX+gsc06LHGgpv0xWmk4oXM0Uab3CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlCv2xkW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2B606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlCv2xkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA981F00A05;
	Wed, 11 Nov 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411046;
	bh=oh0EMdAhesLwEjUQbkNfNH27+MPo1lgv6Y8X1Ijaoxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlCv2xkW5NX19u16/2nhgJPwutW52a/ah3kK0pxuBsPYtTpS/zWQpmqF5Jp8URk5U
	 4pqMxzFw/8uoPMe8CDSdKnAjb6jbxsEIZGKG60e3M9idNfIAnE938yRlLN/JS605XW
	 aZgaZXh8l8eVQ+UAsgmXOmF3S/EEZlrBX1nChPpAOVqryYzojcnexodyR+1MwI3emj
	 TUswvunla09s8w7fvvJyRD8cPhwnjlP7J32tpq5tzbqquX8nvNMq64BI4Y7f0U4FpE
	 OhVTC4fGhUTJyuqV49BJgLSxj+8RNQoTheLS7stAGq+pE7iDQyaw1Bad7y8jGnMjvG
	 Fp0KxKZUfGBjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Wed, 11 Nov 2026 10:30:44 -0500
Message-ID: <20261111153021.2650966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061143-failed-5.15-1a2993227e8a@kernel.org>
References: <20261107061143-failed-5.15-1a2993227e8a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 1a2993227e8a27fc4cdea305bbdae82d290bc885 ]

A PTE-mapped large folio can straddle PMD boundaries after an unaligned
mremap().  If the first part is discarded and replaced with an unrelated
huge PMD, page_vma_mapped_walk() stops instead of looking for the rest of
the folio in subsequent PMDs.

This also affects migration entries.  A walk that stops at an unrelated
huge PMD can leave migration PTEs behind when migration or an anonymous
folio split restores the mappings.  Those entries do not hold mapping
references and can outlive the source folio.

This issue can lead to memory corruption and I have a reproducer for
it.

Skip the current PMD rather than ending the walk on a flag or PFN
mismatch.  Do the same if the PMD became nonpresent before the locked
recheck.  Release the PMD lock, clear the per-PMD state and advance with
step_forward(), so the existing range limit controls termination.  This
covers present, migration and device-private huge PMDs while preserving
the matching-PMD and split-to-PTE paths.

Link: https://lore.kernel.org/20261016011549.61146-1-kylebot@openai.com
Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>
[ sashal: used existing page-pointer comparisons in place of upstream PFN-range checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b3310817910..ea4eaece8c887 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -223,9 +223,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			pmde = *pvmw->pmd;
 			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
+					goto next_pmd;
 				if (pmd_page(pmde) != page)
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			if (!pmd_present(pmde)) {
@@ -233,11 +233,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
+					goto next_pmd;
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
 				    pfn_swap_entry_to_page(entry) != page)
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			/* THP pmd was split under us: handle on pte level */
@@ -255,8 +255,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw))
 			goto next_pte;
@@ -290,6 +289,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			spin_lock(pvmw->ptl);
 		}
 		goto this_pte;
+next_pmd:
+		/*
+		 * A large folio can be PTE-mapped across PMDs, so a
+		 * nonmatching PMD does not end the walk.
+		 */
+		if (pvmw->ptl) {
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		}
+		pvmw->pmd = NULL;
+		step_forward(pvmw, PMD_SIZE);
 	} while (pvmw->address < end);
 
 	return false;
-- 
2.53.0

