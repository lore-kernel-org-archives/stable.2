Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B74248DC
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725059; cv=none; b=EonjWpUOv1LlQMG+8RpE7US2iqzTH2InWe2Pv4vERYa6sjq2J8El3RyF4KKO0SIE0lBEU+MoPpvfw0RWE39lOJA67O9AafUU0tb1+Yjznvbfi937yir3/QeNYHYXD6EyVaZXA2co+VB059MLP2AuyYJ4cYnN05jxVzU8dFq6yI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725059; c=relaxed/simple;
	bh=kExQn+/9t5FfC0EyYnz3yE5hxNU8JGWxnmNHyd72amM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=As08Oxqab1BkFaYeeZ/ybCyJx34LsnJHbxwIKH/uSe4TaYuKf9rQHzBA8iNLjBRf8uRRA5cv8Hx4Bsi9HKnwPcPx5ccvlrDIt0oD8XKYQAN5j1f1SJRaZ5+uDvCf44sA6ExFkSy+NOsjo5xqu6iVc5WzbeAB4pD/EfNKku6Vk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIXhRvBF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIXhRvBF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d032846c95so8333985ad.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791725058; x=1792329858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oNkZjunzzMVyG3EOfIOytuskDXyogdyyjCDaj7C0Eg=;
        b=EIXhRvBFvyiR0tu+tI1LVb4X1AhZPPbIOWeMUbT+JwsMTDdKNVdwDj9GYBRz8LcbdH
         VY0SKQS9KWrbuuiA82RLaON1cu6CILD41wmTH53N729nBCfcfWp3S4G5fpyKUxpT3I95
         weiUsw+yel4+4eucyYk6GQB6mQCyduM6wHWg8QrpivV/QLlUcXOp8JcH+YD2aJL8gzJ4
         cP9AV6VKexNn0O1E4Jo8XgafwRANDemQXtEf1xO624kUgpIT/boFGm16u7seGGr/SqwM
         XN+59OKtMQm19SlQ8voBg7+sUaC1YmzWdrMc6Z76MLlhS8NKksRoG5oy+z/468cCnKod
         oFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791725058; x=1792329858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oNkZjunzzMVyG3EOfIOytuskDXyogdyyjCDaj7C0Eg=;
        b=xukGYtBj6aCYx1oYpI5T9GFJ6bhZKOJb2SzqCo93frBeT5Pmh7h2K10expmZTEoUfQ
         loYCnZJYj6K6AUOrY2qASO8iNzvtCkPEMVI5JuRuC2LLxwN9C/UDC98pFPHRWs0VAT6D
         BzzOfLRXb1ExqbdD33iEEvJi9OY2HY9X7K1sTxK1q/wmj29cP7Ztnx1DOGXUEDQB1Guf
         R/h7yftzvVTu8IKdzeoSK8Jb9aXR5ilSHf6eX0eUn65Mz3AIwRw6SNtDYfdXBdJG9nfZ
         OYYxF/5gSAF/NzD9x809U9nW3t8nM+jHUBqJFoMpL1/Ni7j1a5f8+/BQUFcQtdeL9biK
         y19g==
X-Forwarded-Encrypted: i=1; AKwUvBxZflWyIVs7VNMNRbRAYAAuT4hnqlqmnL1NA9AIiGqxwU02g4NZPE+n8L2GbSswVAjo2V/gbsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCIKYYz19hmFsG9YhBhbPDVdyWb2cBmPN9yW+rS07VejE4iQI+
	W9MrDCwHZDHfL9B198c376v6RgAysRh7SxVvw3LAuVWEiqfj033TMNZw
X-Gm-Gg: AYBFou3llyV5hwLuGcP7mBKVVy3f+BwgpO8LBRa+tXvKEFD8LpuQ//PXzqEY3qdReqC
	tNUe0qHa95XKurgg23wSI5HNPFTGpT8ILeGikoFSkDVHo94BrHSHGWO6dK8uO36/K41eCvhuy8p
	VoF0eC1TrqbP3rrB+lYcP8ypoqCyf3KM5dZXklx/S+q4BuYCg8fvQj2lRrukbSByAlcFFNEgIhO
	J+xySUtWveC1yaXsvYlY4s7WYiD+r9R3CEzjo3a/xkq4r45eVyNk8n349IdMHEwIc3qZGRWXoiC
	f1bB30GeElp6XiHxcwmv8VEpk66K5eQsqCFPHqaDgQ4Vg1fSJua+lEqCUJ0iVXzssNuiRdW5klO
	gE1FW0PyUNiRd+pzD/WgYqMB72ugIM9DrGcUwA1vXYDvmGwURmdwRRm7CT95sjkfXy7RXZT932r
	NW4WGJYUcRzJlP3CFNWMDgITzx3kiQQKXKAWCD3qeim1haBg89eCC3wVCivcpb8MvqeBuQ1IV/7
	LVWHJZFYvNWt6pnWxixB5mgFcsVLdeC1x2aOAzE6DkgVr1mAZPJ2Riy
X-Received: by 2002:a17:90a:d2c7:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3ab3a33da74mr6165030a91.1.1791725057957;
        Sun, 11 Oct 2026 06:24:17 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab396620e2sm7595259a91.3.2026.10.11.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:24:17 -0700 (PDT)
From: samarth.colleges@gmail.com
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org
Cc: vbabka@kernel.org,
	jannh@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's THP path
Date: Sun, 11 Oct 2026 06:22:27 -0700
Message-ID: <20261011132227.413217-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samarth Narang <samarth.colleges@gmail.com>

For a young, PMD-mapped THP, madvise_cold_or_pageout_pte_range() handles
MADV_COLD by reading orig_pmd = *pmd, calling pmdp_invalidate(),
discarding its return value, and writing back pmd_mkold(orig_pmd):

	if (!pageout && pmd_young(orig_pmd)) {
		pmdp_invalidate(vma, addr, pmd);
		orig_pmd = pmd_mkold(orig_pmd);
		set_pmd_at(mm, addr, pmd, orig_pmd);
		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
	}

pmdp_invalidate() atomically clears the present bit and returns the PMD
as it was in the page table at that instant.  A store from another CPU
that lands after orig_pmd is read but before the invalidate sets the
hardware dirty bit in the live entry.  Because the written-back value is
derived from the stale orig_pmd, that dirty bit is erased.

If the THP had been marked lazyfree (MADV_FREE), reclaim later finds a
clean PMD and a clean folio and discards it rather than swapping it out
(__discard_anon_folio_pmd_locked()).  The store is then silently lost: a
subsequent read returns stale/zero data, although the MADV_FREE contract
is that a write after the advice call cancels the free.

pmdp_invalidate() returns the pre-invalidate entry precisely so callers
can carry the accessed/dirty bits hardware may have set concurrently
(d52605d7cb30).  change_huge_pmd() and set_pmd_migration_entry()
(8a8683ad9ba4) already do this; the MADV_COLD path does not.  Rebuild
orig_pmd from the returned entry.

Reproduced unprivileged on x86-64: a 2 MiB anon THP is marked MADV_FREE,
then MADV_COLD races a store from another CPU, then MADV_PAGEOUT; the
stored byte reads back zero.  On current mainline built and booted under
KVM, the race lost 131 of 8000 stores before this patch and 0 of 8000
after; a store-before-COLD control and a MADV_NORMAL control lose none.

Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Cc: stable@vger.kernel.org
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 mm/madvise.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -426,8 +426,14 @@
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
+			/*
+			 * Rebuild from the entry pmdp_invalidate() exchanged
+			 * out, not from orig_pmd: hardware may have set the
+			 * dirty bit since orig_pmd was read, and a MADV_FREE'd
+			 * (lazyfree) THP whose dirty bit is lost is discarded
+			 * by reclaim, silently dropping the store.
+			 */
+			orig_pmd = pmd_mkold(pmdp_invalidate(vma, addr, pmd));
 
 			set_pmd_at(mm, addr, pmd, orig_pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-- 
2.40.0
