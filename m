Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3A2DB7BF
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113360; cv=none; b=Q8+FYr4HbxuXhFhNfvwzCQW657ICRwCnfyGP72xI7zF6RR4lwPmIQv3OmDtPl14DzEtlnOIzeRlfOY75/u409U9dr8/Hk65AyCoz/9B6aFAll2DW8g4td0Kt5nTiknLJF8oHiyEoRqjjy4QtsQTc/kOQCvvr1kGzsXqhrdxC+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113360; c=relaxed/simple;
	bh=9VAJj7cYZ380+pNqLiYIjT2WUQyqSLCyrHJH/HMmkLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZxyW717K1W6DXFoAmlv2fL1+OPlrb7ntx4ncT1m0x3Ee+A0fdaj5/XpWkPlu6fmdogxIPN/V9GeUYnYvPWtFysirQbAkT806PDNgJAFrbN4ZjAUHuwk/BdyFS6c4AFUsGbCB8b02K7QGs2QAHs+vDCFMIhN0cdf0AW2msJDXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EAPBPvPO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EAPBPvPO"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-825b40f8a26so2874293a34.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792113356; x=1792718156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NehW30zqnjXf2BZQWCFKMsNatcoAA2i6XIIUsdpRco=;
        b=EAPBPvPOekpK8Iln5SdDepOa9mPsiKmVKqIOD8Kj9bBpptcdAjgP9N/7wBus8Z27/G
         +ItyZrRQCZkH1TO3wn9cqB7zGHG7HWp1CFG9iGu3JEIVS73wWH6lYJ9tWwKT11S2s6Jm
         jBnB4v/Kb1foK/mRB13c/+wIeeed5Gq6vzZpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113356; x=1792718156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NehW30zqnjXf2BZQWCFKMsNatcoAA2i6XIIUsdpRco=;
        b=t0SIuXVr4Sk74gLXaD3EPy7OCXwa9bd5XHZLLzu/sgXFgN19mqDl8PrAYVaGUJIFhu
         h/B0T+K/WmUSqVdvmzmOHGLPS/KErULG4fIQ7NC18mqND60ymQTeMaQ9OCCqKyuCsNLi
         z9ulZmK6usC9vcNMeNflLQFXyE/BhGQU3BjrlUVI3KRNgNRc7h9eU8amVVnHUAbIrtUK
         ln/N1ZxEi2B/jd0JdAV4OMHZbeIvKrN3DIPGpz3G4uA8hvNrb/m2uOPkXYaX7O7glkDo
         ZUY9QjyphwmmsWJznyFpcA8cTHM6pOLg7CiSwdbty7vUlJrQGIwUegluqYnUEYezILwD
         xcfQ==
X-Forwarded-Encrypted: i=1; AKwUvByLwsjK1H5xPO6qkaALLC6IXqrzxoQuAGXwl/KNMsyjvA2sZKLJsrUVfLi6BPiANlQmUlrPsGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXgCcRBIuSke003icVKEo0Ks2QA9XEduRvp4y0mWLmqRdKXdGf
	rhQopnhmzduziHc5R01KBYRFOitvsYjOWVlu2tFYcr7fjYovMzFrgfsazYZlZCIvjxw=
X-Gm-Gg: AYBFou03GVbqnWzLNuLFs71sj3KHxkt13RYGTi8TALLlQ15N779DkZM+ZcYX5O7ppGP
	wFR5pS+3Vz8EwSqIUngkMzQlF/aUetxwlrvos8czjgli/sQFERCmomRmUHpAexf3aPeOIy4LD0u
	ut0YIzh7Dx23ePWWLUdwoxCJmD53HsFtzNDgbGlkkwOzsZGORFDuI0cpo3G8ESn3frbKlYWhfg3
	U8K+freVN8mMuZhUQW7xgcez0dnQpZwHh15x+DjmiHvDJcM65LzUVj+axRy8BYHGL8ptRX6CM1/
	/WElrKzOxptfJ2KlWVy/IOGhLH7/amI6fpSh5pHzMAQ7sRdLC5CsIkYdimkgUTndycZG5mvzyd5
	StGsJgm358d3RSEZB3SrvZ7ijns/r66kaAmhLy6f9QV0sVS7RWo4MivF612nGGyN0wyugIrXAno
	sTGG4HOgOfV8jAQjnkqEC2Yo9q+RtuHgoLhIdNkI/WfLGtAiIQB59xQI+mMtspYN5C65Acrr2hX
	FSrE52/QHbdEisH30RNpMplyZhLfiSej6kIrbCmXzzM565K9rxwpwX9kxu2sclU9gD/wn8uA2s=
X-Received: by 2002:a05:6830:67d6:b0:829:9992:2106 with SMTP id 46e09a7af769-830984475fcmr20639981a34.22.1792113356354;
        Thu, 15 Oct 2026 18:15:56 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a01f56sm547197a34.7.2026.10.15.18.15.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 18:15:56 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs
Date: Thu, 15 Oct 2026 18:15:49 -0700
Message-ID: <20261016011549.61146-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PTE-mapped large folio can straddle PMD boundaries after an unaligned
mremap().  If the first part is discarded and replaced with an unrelated
huge PMD, page_vma_mapped_walk() stops instead of looking for the rest
of the folio in subsequent PMDs.

This also affects migration entries.  A walk that stops at an unrelated
huge PMD can leave migration PTEs behind when migration or an anonymous
folio split restores the mappings.  Those entries do not hold mapping
references and can outlive the source folio.

Skip the current PMD rather than ending the walk on a flag or PFN
mismatch.  Do the same if the PMD became nonpresent before the locked
recheck.  Release the PMD lock, clear the per-PMD state and advance with
step_forward(), so the existing range limit controls termination.
This covers present, migration and device-private huge PMDs while
preserving the matching-PMD and split-to-PTE paths.

Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 mm/page_vma_mapped.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 4e964545e5e8..67c8039e9d28 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -258,28 +258,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
@@ -292,8 +292,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			    (pvmw->nr_pages >= HPAGE_PMD_NR))
 				sync_with_folio_pmd_zap(mm, pvmw->pmd);
 
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+			goto next_pmd;
 		}
 		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
@@ -336,6 +335,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
2.55.0.openai.911.g06873a30d2f3

