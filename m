Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410029;
	b=hzR4lRP5y3Yk/dI6py6k4Lra2E5Z8aq1R5ixm36J1ga/7v/iM6fXHpBPEfscYV1mNtc1
	 9njGrs8ujDiEmP9Bn1Xk5UzeANiGLaSuw8J3pl+CGdP6rkf7SWOrpsnXUvl3FdU8rCZVb
	 w2PYcxKVt9JoSEhMB+kUHsq79MoYKp2egQ36nY5XefL/rN8DXl6BzVPOEPmwdT0aVOlMk
	 jHGjiPjPpQ3dOwYi0A024q0obMy7PlHgyGtDGsKdHh6lYWWp1sgAKK0vSce3QhMSqalAs
	 ris7WQGWthtJnZHnlbBr6ZMQeJI0tckCG7h5oPbkOXFFCdWdvI2xcVwsZT/ejmlCdig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6qJwxRU63re4ZfoPGRp4wvYjHv1QncT8JH8MGj94LOA=;
	b=YqP/EVQVp+pyBEoNtlOUDRWBOChUdFVhFhjWLydl+xY6h/IrBjSLAm9H2xpwqkn6RQmi
	 Iz9YhuWAt+Zx386kfRsvkd/hWEnoTLDVKTzQhyW3EsuvpFdi9cBNbERtIFlAsJCcgG3o4
	 z4k7YFBBzaOLWRZsg0i/G297G85FyFGUE75TT7YuEcJsLG2lExy5JwOGJ0F8rT7hMsgo1
	 Ju5ZjjDaVS7/H3ruExeunbkwoZDe7P+pGNZWQ7CDzXqRn9MDFX7h6k4exBWwpOLUggmyM
	 umEp6i18HYO5r8FhD3RjhY0ItQpyJcaNAFRY7iVRes1Qv/H8LBh39LDMvD29so7RviQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHXWEZcQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCD606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHXWEZcQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72981F00A05;
	Wed, 11 Nov 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410029;
	bh=6qJwxRU63re4ZfoPGRp4wvYjHv1QncT8JH8MGj94LOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHXWEZcQj8Fe4yLaOBml5Ta1W1MhkpuSotA5J0U3ZO4h0cf8tQbWhAttyrnXZmLD7
	 6aVXmIVW3umYk8IE0W70PnZDki5ua83lLFVBstY5hx8ITdWljyy6uDRGcgLIW0a4w1
	 Ln9pzV0SAAEgrVPcS/ocrY2igsAfLS1T0KNkEif38cwGOnTRh1kCwbMlJFonPJZsG2
	 5nfHBHu6wkj95JySrhiCInocp/RLFY4Qbypff/mAVsOFIcnQuchGdBnQuZZ0PW6H//
	 6wyLVVjkJ47ZkA1x62+nPJhjZxsCY0hrexkB/PxSAlwaFOAMx6mP5oaQ7OdTSY/SGQ
	 2bLANBHlAOp9g==
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
Subject: [PATCH 6.6.y] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Wed, 11 Nov 2026 10:13:46 -0500
Message-ID: <20261111151326.2627805-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053904-failed-6.6-1a2993227e8a@kernel.org>
References: <20261107053904-failed-6.6-1a2993227e8a@kernel.org>
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
[ sashal: adapted PMD checks to the existing swap-entry-based migration handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index c7e8ccd1aa06f..70769e270c04d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -254,18 +254,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
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
@@ -284,8 +284,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw, &ptl)) {
 			if (!pvmw->pte)
@@ -318,6 +317,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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

