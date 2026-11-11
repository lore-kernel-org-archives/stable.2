Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409844;
	b=vOhm5cAZwmzJL9N4ee6UnLKXQzieCTJNbxdRK741NZ6wvL+V23sFiw7TEBW2z6MHVipA
	 CnQ2wF+Ay7f2hxzMtQ6K9O5X5bBh1sa3xwncWI2R/Yf0/JLd6IFTr3FE6jrZJpt1B2AZM
	 Yj232HLYEmrPH1jSb7WcUSpWTn253Xk0j/pnQE3B5VZpxFcJ5pJ4C6KHtm7OS5v8kc1aZ
	 aun2Nh91SkOMZu//qakwrptLE9FWbwceX/5FR8/BIOdZVCP6zncXT1vXP5mIpG5W2mimL
	 VS+/oFrjZ3+y9HTawxGW92lQV918wBoo71ujGiA02ecOpjqR7t/U5K8ITfAsFf7Eknw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ogUEI5V4RyPou0GJhWmgImaDKCk0E6rnkLYMyuuq6vY=;
	b=EO3BYJ/bItKHzHcRrQ3TQ7xpfdkgVHn70d6h5gClcn9tt3Q1AxKUCfe1aALuI2tv513O
	 ILLKjF0gXaWWvzhJyzT54ByYCbXdZzC274aN545tsmL47YnfQSwXtOcYyzXlERWgNzQeq
	 GPMPh4MypHAYpSJwlxufBcacKZ9KcMIsc5b7Ej4pAJ/x2GN52poymw68YqLij0mngpbI2
	 SJBEFqeQxqWl2u9j4XIIPn/QylZjhNmX8qfFcb6zWmWVgKv9feMd961i8yfO1/6Q9ppAT
	 LLEXh+wErf6NWrFRQUI21QJxtadd4G27y6hobYzQrz/PqF2qfFvu1pC1N1vrF+qJPcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G1uZchA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322660A2624
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1uZchA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9011F00A05;
	Wed, 11 Nov 2026 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409844;
	bh=ogUEI5V4RyPou0GJhWmgImaDKCk0E6rnkLYMyuuq6vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G1uZchA/r0nD7AVBPtb7GIqzTIsexftvNDjhwenKHwi3bgYQ3Y7k4RiPsmaG5rH5g
	 msc+xfNXvmj+UF1uLdTNnFAoy9tkfiI0DuI4XrKARXGehjFgyCnaNiGgSSBth8UAcX
	 JK68YM7j0BUBfQe0QBJGzCKiS8VBCW7HcM0r6yfRRSg0VXsFTOckg8U+Mc7RzoFdB8
	 h2I8wqIYDKus56iSqIcnGkkqz5aXlycGMwgFXP9a/6qIqJZfwOPgGn5jvygQLh8ZfI
	 7Jm8TwrXgSq1vlL7stFvk66f12smHa+RYFhTrzj+Mo0Wfc0jlobiqDVUBLMYeISAdm
	 2XpMjI4+TDUxQ==
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
Subject: [PATCH 6.12.y] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Wed, 11 Nov 2026 10:10:41 -0500
Message-ID: <20261111151026.2606849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052621-failed-6.12-1a2993227e8a@kernel.org>
References: <20261107052621-failed-6.12-1a2993227e8a@kernel.org>
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
[ sashal: adjusted context for swap-entry-based PMD handling and older page-table walking interfaces ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1cc8fd382cd13..67e6a32644bad 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -255,18 +255,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
+					goto next_pmd;
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
 				    !check_pmd(swp_offset_pfn(entry), pvmw))
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
+					goto next_pmd;
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			/* THP pmd was split under us: handle on pte level */
@@ -286,8 +286,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw, &ptl)) {
 			if (!pvmw->pte)
@@ -320,6 +319,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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

