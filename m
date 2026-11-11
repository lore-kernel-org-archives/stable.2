Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411625;
	b=Pp7GQwrYtNy4RQA+hANhBu8eHUnX9LVebW8I8Ze80l1Vf300A1IuJNMbiUUTKrQqivrw
	 7YJ8gMlLQiEL5ITXzB7boYyscpIoA5Rls2L3ZMWrVnvnfeb/CpuY/C8pz2qXeEq9beB3O
	 wHcKdndymZW02yjjvl7aj7EN2r9w0DGq8+5n+cbXMvMOr+iW5aqCxBKaZzvgiOT16XOQi
	 c3Ol59Li++mYE5wtEWlfXp6xpamno73QKEHl54Xkh+bD2ENegxkvZg85fy35W69GLME5R
	 HJK0/pgRhbEjE2/YXfTxwr/UNLigjIFm3cTO3ZroC4UkRer7ehHXBvkb0HUfIkwXX5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nCzbB91QEhjFISS00a0bZHToSF8xWISo9CZPjpkuZCA=;
	b=zSX+4lVpn1er5EGMnRrHwfFjp+tUX8OwFc0iNG2/TppZkeQx+ZWCr5cgNiwWXqbhafGv
	 dCH6iBYOMCwNsF5VxvQcKost8xaHagJ/GwfMrEEW0UWhz+yU5U1l7wD6d3c78yGoywDme
	 hh+vdGa3g1K1LCZ/FjjMYkSi/nMHwWY1Td4LDeS6trnt9fBjpnHbZYYsf883kKCEMGlcZ
	 Dvj9FycmDea7pcDe5ojBV4Ft+07NbAophkrUEKVuokHwrHZ5bAw8xCIEKfnEWi+1kKMSS
	 wHW2WaRHvO3zH3NJZ9vEQmsItjN8lTRL7eDYxXjx2bQXiY6ltJbMfV/hcjxaY7UlwyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/pg5Ows";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6760A260C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/pg5Ows
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A540D1F00A0F;
	Wed, 11 Nov 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411624;
	bh=nCzbB91QEhjFISS00a0bZHToSF8xWISo9CZPjpkuZCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/pg5OwsEAjbDow0LzevjdVobx6VdhWIhgZeG0QkxAIvsE3zgZC1UYifceOuWS3vp
	 kXjZvXXRhaShBHEWJk4b82z3kH/ioPRNDfMR/OBHADed+sNKLNFdf9hqOKj1wMlD2k
	 KQsC5pSROaNcTwfzx2PbYlvsurpblpWemPLAHnj80vmfQuUMLK5dp2lfXIkG4+aZUL
	 /Nnqv12VCTlPwz2x89MI/RdM6Sld9DZHUc56hZrjvMvzBcmj2iQVI7FP8hvrPpy22g
	 YOb7Bd2Vt3HyQpw84y5O7gzA1W47SGEjInR155XGtWVXs8E1Ny0agZsQx+IBxDGAaW
	 Hh3aj3LQ7lQow==
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
Subject: [PATCH 5.10.y] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Wed, 11 Nov 2026 10:40:22 -0500
Message-ID: <20261111154001.2714628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062846-failed-5.10-1a2993227e8a@kernel.org>
References: <20261107062846-failed-5.10-1a2993227e8a@kernel.org>
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
[ sashal: Adapted the changes to the page-based PMD walker with combined nonpresent and migration checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 610ebbee787cc..5130e2ae2f576 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -219,9 +219,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
@@ -229,11 +229,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
+					goto next_pmd;
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
 				    migration_entry_to_page(entry) != page)
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			/* THP pmd was split under us: handle on pte level */
@@ -251,8 +251,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw))
 			goto next_pte;
@@ -286,6 +285,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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

