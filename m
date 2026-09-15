Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7A4499A4
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456418; cv=none; b=S2T3WG7G/H5lFevSwnMO/biWlkfNaYDDh2QLitDgkpGo0bHtrDcrmd3NKNIRqnPEa+0Wt6BIuqyY82978mj1D8ZyLUjbr7GQWaq8eKfCherh1kNCE+KTW5Snhtrl0iXOmUXw4sMx5+Anf47aAOB1S/vHqvzXmHvFBIZb9Sp1S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456418; c=relaxed/simple;
	bh=VJPiA57oY/5vyoJkrmWgpCXvfp7VtHP7Ct2Mll3e6pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZPhw7SArOX5fBOKpKYmcQg8Gw4byJWUIaKfmHrTw/me+SA/c/mVCXf4rcyeHPhwtbBJpTorwTp8r7VdA5DtEJLmg6TVUGKRSDubosnyJKGr4xTBq8bbYljHWuqRIuujhPfNCNmz0Ex4QeiMU63QIVrwL8SPPrAT8U0kSEAYh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrYP5Coz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrYP5Coz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so31221175e9.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789456414; x=1790061214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=velMxIt+642lquxYVKbrnSVvPRt1SpQzIuYolRQYJw0=;
        b=HrYP5CoznF8vgUi3JCmujnTnNjVljxzsH/hWlebMlSfTOqXBdY2QbsFWdOXlLungB1
         QnE9UaPv1FgVCrMyYpK3xZmJQHtzM6jMGAX7SkXA2efeyQoIH3bHBnYNWyTrW1rtcHro
         +3hk0tgALDfb6giikhzTK71it21pLTngv7N3/UiZp5YTwoVHlSbwzHdOvddOCTgVuQib
         6bGigJxAVd3/qc1ECbVEOvtsgSabxi5s+S6NVLNjvxXS4QjJbVVpM7jsJqPSmF3FhjXM
         aUZ9uadZiNhC02GGM78bDfAzK2hELwQAqAxATZTqCmX3QNORZCYjawO+LUn33D2qDUrC
         8GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456414; x=1790061214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=velMxIt+642lquxYVKbrnSVvPRt1SpQzIuYolRQYJw0=;
        b=S0Eo1wO7F1wper87SbsQuMbp99c5Z158hWt+QzL5x2rke8gPrRPGPk7JAkKS8xIgvA
         bE1ed8JpqTXpMrWGVX4T28m5c/XCX/XfjhTMKoPv1XdbZKCbub+CHQCWOLgaBidugosa
         jgNJkGRrLW52vNrK3Zfuh8nRmNAQTLv8Z2dIDX2a5n6aGNOb/7AfWBzHr7wEiUB5ASl+
         1UsFjZ/0lwLHremk2Ptfoz647DPp1bGUN80QKKC0U6E8ziagfFkP0r9k5ZYnuDaRs5ct
         5GxerOKhLI0+zxpOFmhPdUXANljShEKoUUacKa8NUmZMrPgmgkKJOVxNv4yDFNpJc8LG
         6MRw==
X-Forwarded-Encrypted: i=1; AKwUvBwR2dmKniGcDG51wdaw8BXoWbpKBNTx4ka4vRmtsgi7fbE3hQZpFqJ6rCG0fgG2xWhzQHGRMEE=@vger.kernel.org
X-Gm-Message-State: AFuF++kMzV0OLi7OhcAr/ZymVMdRWt1RlOPkQ/kNhfo7s4dbsFmoqgGo
	7vbu/RYHe01WN81x1glW6RkjXTNprGbYpOF+LW7hdYAWyRS7XFnyP1OS
X-Gm-Gg: AYBFou1jTcpqdIQ3lFO4CCW82vvKLedljps0jFlhDkky6+IMLrl9OErQ0ICxzzsT4NL
	HRPNA+AFXi03vfi8jeyhKwrzEXyf4nnhNGMdiPpOcD0K+lOhKS9OnMzC3wHqcu5geMu790uImZq
	9Btu7KCOuC+6VLzgVvvnsjznOj4NwrSpvfSxr5CIUfsEPI+alsol1wHi5CpSs1XyTN7qgko8H3k
	yUIRAfg8WSgUnfgeEXWhd3ho1BTLrYTSOwZPDzraFx+mbWM8uxgl7vJ69jtWOoKbtAJMVO+hrdQ
	H8GaGgWIDmtrhmaUs+eYibwX18Sok3V9qEO2ZN8CXgEos4X3W7sWT7uE1qcop47RH/m6y/anf7c
	GnnFwgC5WVMnbPMPJFjvHvPVBPYMtYi5sSoJ+q7LSBCoTZM/2J6ncCvFg2aKPsWOLdjXMj2LhUg
	EWL/15xmfcDNjyCk9vxJOoWLXhuHDJ9s0mRUfNQeyhOnN/hiHNvkniIez6zRd4+p5+Aoa6ht2TX
	6lETx87dxzClvwNSkaCFbKWdZzPDpBJqzRyOULzaJ2KlLSA8H6u/mqli8BjWKosXwR9i4YAMcfB
	NHpQbeNex7sNphxE
X-Received: by 2002:a05:600c:4e4a:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49e7a63a784mr80413585e9.3.1789456412284;
        Tue, 15 Sep 2026 00:13:32 -0700 (PDT)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef735cesm42941345e9.6.2026.09.15.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:13:31 -0700 (PDT)
From: Orgad Shaneh <orgads@gmail.com>
To: tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	osalvador@suse.de,
	stable@vger.kernel.org
Subject: [PATCH 2/2] MIPS: mm: do not write a huge TLB entry when the probe misses
Date: Tue, 15 Sep 2026 07:13:25 +0000
Message-ID: <20260915071329.15125-2-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915071329.15125-1-orgads@gmail.com>
References: <20260915071329.15125-1-orgads@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__update_tlb() probes for the 8K pair at the address it is given and,
for a huge pmd, writes the huge entry with tlbwi at the probed index or
with tlbwr when the probe misses. That works only if the caller passes
the faulting address, so that the probe finds the 4K entry the refill
handler loaded for the faulting page and the huge entry replaces it.

update_mmu_cache_pmd() is not called that way. do_set_pmd() has always
passed the huge-aligned address, and since commit ebcfc63d6bca ("mm:
abstract THP allocation") the anonymous THP fault path does too
(map_anon_folio_pmd()). The probe then misses the stale 4K entry, which
sits at the faulting page somewhere else in the 2 MB range, tlbwr adds
a huge entry next to it, and the TLB holds two entries matching the
faulting address. Octeon raises "Machine Check exception - caused by
multiple matching entries in the TLB" on the next refill of that page;
a process on a CN63XX board died this way within a second of start, on
the first anonymous THP of its bss.

Skip the write when the probe misses. The refill and TLBL/TLBS handlers
probe the faulting address themselves and rewrite the stale entry with
the huge one (they also set the software young bit), so the entry is
installed on the next access at the cost of one exception.

Fixes: fd062c847a8c ("MIPS: TLB support for hugetlbfs.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -332,6 +332,19 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	/* this could be a huge page  */
 	if (pmd_leaf(*pmdp)) {
 		unsigned long lo;
+
+		/*
+		 * The probe above only covers the 8K pair at @address, and
+		 * a huge mapping is installed with the huge-aligned address
+		 * while the refill that started the fault left a 4K entry
+		 * for the faulting page elsewhere in the range. Writing the
+		 * huge entry to a random index would leave two entries
+		 * matching the faulting address; leave it to the refill and
+		 * TLBL/TLBS handlers, which probe the faulting address.
+		 */
+		if (idx < 0)
+			goto out;
+
 		write_c0_pagemask(PM_HUGE_MASK);
 		ptep = (pte_t *)pmdp;
 		lo = pte_to_entrylo(pte_val(*ptep));
@@ -339,10 +352,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
 
 		mtc0_tlbw_hazard();
-		if (idx < 0)
-			tlb_write_random();
-		else
-			tlb_write_indexed();
+		tlb_write_indexed();
 		tlbw_use_hazard();
 		write_c0_pagemask(PM_DEFAULT_MASK);
 	} else
@@ -380,6 +390,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 			tlb_write_indexed();
 	}
 	tlbw_use_hazard();
+out:
 	htw_start();
 	flush_micro_tlb_vm(vma);
 
-- 
2.47.0
