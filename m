Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410281;
	b=gbMA46v7Uo2i/j3lg2rMg6mbZN5K0RELsQQJcGVOpM9YIMj4ClvQXVMTPmVmlgDqnlff
	 0hAADNJTYvBjWli4DKo2frhnLln+5IpHjiYj33dmZVtqTAcJ7HH1UzB3gLBcKfV46SFvz
	 GwA9VdtzdOLnYAaVLNZRJegE5RLE0fNMKIbV+B/hNItMaQoK6cfucNwx3hRVS2SI7zDqQ
	 0W2AI5qXq1biL2mwt+PsnFhz6v6HrUf6JR+IoVSOqKOL65RPbpRUtY0Jvjw0dvpDzgkwF
	 ESWnkbIzJh+RmRrI517tXOk1KonkL2F3t9cjQNkCbqXBL3HSzFT7ajFCU7uhwOVxigg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HvP5D8iwRQvpRdTVuXmg46FR1UPMzbMatfik3JqO/WQ=;
	b=gOJlSfB9W+E+gxCQ+V1qAyRS8kW2n6troD6/hVhNm7Ss5swL+6hJHRcQ+8m/KCFuVV2Y
	 wKxWyqRWF91WL4AdBynZICdZi52xtfk1rC7stQPyV0PSGMLZwWGcsmto/ROlwVklDGHuA
	 12mOEQYwD0CospD2aaAAu/adOqyaBmD3LkY7cEixrGWXKwYQ2tNimoIYvrgPyjnFcx96M
	 Py51HKFkywHD/lVVLP3j7MoB5a/oIDUJPnf73b1l20y1+S3PK3uOleomgGmJio6jFSKvl
	 tlYubMn44PJzM32jDsK6/FOMPLTnQJG9KjgsCu0VUf9N24uOFZ4bYf7AE++NS6vpi7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXe6Zu5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B7606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXe6Zu5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B031F00A05;
	Wed, 11 Nov 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410280;
	bh=HvP5D8iwRQvpRdTVuXmg46FR1UPMzbMatfik3JqO/WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXe6Zu5+0B8dDprvSoEXyAG3urR/haQHD1U6iiG0es1FK+/eEDlb+0XZB+QPSDUOf
	 IDFLNbkTTZOq6BUigda/d9aTLxb1u51soYppHUQjH+3T6GIGD/DDUMGzlNCemGMm8c
	 q/nleQ52UODzycF9WOCyaafsRt2Ze+2qkZqfH26qwGADXKhT0hVK1MT5Sb5bR7qvMq
	 I4FSWxXL6x6jYUZmUJvB2lHeQYhUYx/CNlgXKVscs3ASE46l4q8koJs4/mfP1r4kmz
	 y0FC27zBZT/gzwv07O2Emqr98c3R4lDSR7z3imV7RJAsywWF2m0GciF7/QlrIJEVpx
	 S8gzktNV5hYGg==
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
Subject: [PATCH 6.1.y] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Wed, 11 Nov 2026 10:17:58 -0500
Message-ID: <20261111151738.2633362-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055450-failed-6.1-1a2993227e8a@kernel.org>
References: <20261107055450-failed-6.1-1a2993227e8a@kernel.org>
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
[ sashal: adapted migration PMD checks to use pmd_to_swp_entry() and swp_offset_pfn() instead of softleaf helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_vma_mapped.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 6dfbb975b3e6a..3293fb6191219 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -224,18 +224,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
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
@@ -254,8 +254,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw))
 			goto next_pte;
@@ -289,6 +288,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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

