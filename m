Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047947;
	b=f4qLpdidiqXyraYkYGO63ha116SONaoImjBZirD99ms5dwwvTlUx5stQxNbKsGSVRckM
	 REFN1tx2DNekgTuiKgEUTWYmC2fhja3MXAA+PUGXACoUqq6gzfcBmAJgEfK/gg6InTkMS
	 rPKqZtTX8fl1liFPt4pI/ijtAdD06y31DTCCtbD317kK2pwrFOcldfbEMwXJJKYlbEqf/
	 4B3ZITPcG3qGHm1Oq9PsKXwEKVkDp+1YzjZIdfVhuaw4+3vgrmRKON01eArKJdEfgoFjZ
	 xGLkEAtvopUtjgvx30Fe5aJqnvHodFMWhV5a/tWz9lUIhtSQhx6sxuf+NqXYpUWOBGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=edcOzBz5HIEC4dPdZ39e81BKB7o8Cleq+69kdlhyvTo=;
	b=OK78arA4PQzH7s64KtgcPCrNZDN/oNpXIRpkjdbPVy19Vj4sDAo/qeub+V0nnQYQR4De
	 UtOPZ9bcvszLvaIrAdu9zIlPPRX7JMX4c3QmXvwpRO8faDvskJGsnBywggDIpB4c71xoh
	 pM9/WKmyaKXk1uvKWMZ0xgxZ7TkfFMOKJYIcdWJCmPXC7PLM3PCKcFI9+Nt+QqEmevd53
	 whzNl7XhlQ0GlcD4rvl7sLL0nxrDaYC6uzONOD1EEh8U5pMZdAdzEwd+SXpe/GO5+QO9g
	 +BT2tQsxIvzQzLrdGvm6G+ak9uLReqiVOnWedoKNtrSO6m192qmWdoLHzFufvy0QC3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfswgZR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfswgZR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E51F0089F;
	Sat,  7 Nov 2026 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047947;
	bh=edcOzBz5HIEC4dPdZ39e81BKB7o8Cleq+69kdlhyvTo=;
	h=From:To:Cc:Subject:Date;
	b=MfswgZR3+hUK6NhuwTGrfSGw5QrTdR0d6paBSrb2u3O8MO9le3CKA+r2OxtuuS7QL
	 T45vYBWYgFLnk3h3Mr4Fb6eU/L8FCssNqE93aK9KG6KrgG0b9jgEqCi/p/wVKxnqLP
	 3USVMbJp0V9gh7EHKaxmbQp3psvH6lMCgjqUKw7ZxZw6VQpe5y9Rolc2bAkb4hgT5N
	 jgy9C9YE7jqmoUwj/eeKZ9q6OkKq2Sl2/DZrQO48F73cQbrFvrOAVjDLxEpbWThZwg
	 5lehhzTK/q+2e19jzyPt19cBjuEGgkYcwl2TGshWPfKu/DX7Eq58RftuiklaIdYVQT
	 M3tbrEmkrtD8g==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:05 -0500
Message-ID: <20261107053904-failed-6.6-1a2993227e8a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1a2993227e8a27fc4cdea305bbdae82d290bc885
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053904-failed-6.6-1a2993227e8a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1a2993227e8a27fc4cdea305bbdae82d290bc885 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Thu, 15 Oct 2026 18:15:49 -0700
Subject: [PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs

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
---
 mm/page_vma_mapped.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8408aee7571b5..e6b6170c2f4f7 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -265,28 +265,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				softleaf_t entry;
 
 				if (!(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
+					goto next_pmd;
 				entry = softleaf_from_pmd(pmde);
 				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			} else if (pmd_is_device_private_entry(pmde)) {
 				softleaf_t entry;
 
 				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
+					goto next_pmd;
 				entry = softleaf_from_pmd(pmde);
 				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			} else if (!pmd_present(pmde)) {
-				return not_found(pvmw);
+				goto next_pmd;
 			}
 			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
+					goto next_pmd;
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
-					return not_found(pvmw);
+					goto next_pmd;
 				return true;
 			}
 			/* THP/device-private pmd was split under us: handle on pte level */
@@ -299,8 +299,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			    (pvmw->nr_pages >= HPAGE_PMD_NR))
 				sync_with_folio_pmd_zap(mm, pvmw->pmd);
 
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
@@ -343,6 +342,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			pvmw->ptl = ptl;
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




