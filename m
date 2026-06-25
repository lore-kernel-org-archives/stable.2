Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF936F916
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422907; cv=none; b=EGuDRri5hrLi7iVu122BxSdWHJMO3HcY2z96fkUcqET/1MHNXOtSIEz8alkVL3dhRl5XOaVuxKHO5NKUHFTcLHS9pdxMbEmppau9xkIv/AffpdRLdUccaKVtSquEoZF0C12ydQHL6VL/6fpnnrn1OrHiMibio+paCqfju6B/Kug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422907; c=relaxed/simple;
	bh=zBU9t405Chy2n1XXD9tDen5hcas/BXe/S1edh++kQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyLYF9pr6fg6HjIjJAHKnjqMCtNHLONmkYxAxlfVye0lopCa2kI4qPh+G/Ek1f4OqCDqjhiXZ8GuTTeDXzgUG1hJfHItGIet1a22aosxondZFex0Kar/JyyZfAwKhuTsFO00gt90i6lAWLbJyBIJtH+wh5LlYZv+zSflzkOY0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+8bikdN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+8bikdN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46db3c9a9e0so142746f8f.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782422904; x=1783027704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJUjpU1D0+bsNa5J5MmmoMrwOEGi/vBVmQ8kR01gZEE=;
        b=s+8bikdNUR6JKwyVnP7bp97YLEsSCbC0DrSPsI8Goe69BiAKwakMV0BZ8GyoGjGTwL
         bkmfZafwwQ3At/wAbOpNFsbJyIyb8DdPi6uHoB/3miEAobsV61R7HEjG77KNF3gMhPg+
         izHnxBI8BujN87oWdpOnPhl6+xpyhWiGVdYsMHq9Qowgq0dBtsCk2s00OjAAmBUbQXwV
         LVSwx3sAIRIPAt0xvCHd9/C4lBjpoXztc5um4uv42wP6zyEaNC96JmcXCGXG5mmdIows
         tcw1nS1yapsylXuXhGgQ1IWqNQUnAhss3jUna87zU01aL+lp1KzKFXdmuCcGnotZ+xFv
         Ymzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782422904; x=1783027704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJUjpU1D0+bsNa5J5MmmoMrwOEGi/vBVmQ8kR01gZEE=;
        b=QJZNjaaEPsWvoKZ6qIXZQ1eAy7+vqve2hLbQYtCNaw/uSaxvyPpOdik0ZWD2lXaQXp
         JHF/0hoXtQNNXnD38PBDpmDB/6kRqfvZH/G/6heCbIfvxCdMvhTlSSUH3MvNzeOYCVUD
         pQhmKU0VjE8Qnc6WSKpTFNXk6h80oZfEBOkLRRWnLFwCGhbUdrlWw+BvsK/IbYgfPJFK
         zJGgvlTVXjCqebt1PafqSZOW5zCgjnG84F/l0xhKNO+3uOkp4hsC8JKRfSdM/AehKRr8
         p9p5ojrIqwqO6uH9sfa9ATrJo8WfJe2uWGr44GPTSpo/EL4oFx5+EYVh+XyN+7fhMTF9
         cbNQ==
X-Gm-Message-State: AOJu0Yx/wiuLxTfuRRkUY3PylkF4pcIwvR3VZE7oEdupnVpZvzjShLDG
	j5iymawoBGHOyIiXEh9BUo0PEsmCd5M+irbRO1dgMZYgTAz0A5+WlvHUjgYN1sKbdA==
X-Gm-Gg: AfdE7clAICJe0zg8bjzTUKUvEO5WdrB4z5ZzPVTN8z0ZwbWmuB2KDvRMg4A44/q1OnE
	pDtGzQd9B2qLlspY35WBfMmR2lFVRQ4kebSMHJnSC5YC1jmGwSggAYh36r/CCUn6ayABRTbSwoq
	lsjhis5VJQUTGvJWxJ6hPhGu0mR3eg2oW5UohCgETFUYZm7WnweYxD6uc/HzArBY6KQpNdOgbLK
	/YotwtCkrGXStGu8qKGQTXO/ebEh8Bo7XIafqQp/XL8kgjGhhvQ09jJD83C2HCVT60R7FwS0Aox
	ahbxERYe3DRu8w4MMEoXlVmhx5zNmr0msljUbsYD8vs0z0qbRW3tf4CIBOEN+r2bOTD3VYB6SlQ
	Ptyo6kQJSxQpFgq2FYqATEvYDfZLo69aJmx0A0GhMAtFwlSqHEskWFFZPI1woADO/KC49PPE683
	nXZUu6Ah4xcg8UZU7O9i9XlJTRSfCCCDVUBD62f1rhPYsYInPKtVZ3rJlmAlUQOf3IUPhUQPhD4
	/bUmfW7KMZwc6SrlizTTLbtM5SUsvv+BvwBVGSnvUo=
X-Received: by 2002:a05:6000:46c7:b0:46e:5c5d:b2cc with SMTP id ffacd0b85a97d-46e5c5db779mr3370997f8f.23.1782422903900;
        Thu, 25 Jun 2026 14:28:23 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-94.broadband.mtnet.hr. [92.242.248.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46cf775a4f0sm13209676f8f.17.2026.06.25.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:28:23 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel-mentees@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yu Zhao <yuzhao@google.com>,
	syzbot+03fd9b3f71641f0ebf2d@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH 6.1.y] mm/mglru: skip special VMAs in lru_gen_look_around()
Date: Thu, 25 Jun 2026 23:27:51 +0200
Message-ID: <20260625212751.23612-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit c28ac3c7eb945fee6e20f47d576af68fdff1392a ]

Special VMAs like VM_PFNMAP can contain anon pages from COW.  There isn't
much profit in doing lookaround on them.  Besides, they can trigger the
pte_special() warning in get_pte_pfn().

Skip them in lru_gen_look_around().

Link: https://lkml.kernel.org/r/20231223045647.1566043-1-yuzhao@google.com
Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: syzbot+03fd9b3f71641f0ebf2d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/000000000000f9ff00060d14c256@google.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[fix conflicts with variable declarations and vma pointer usage]
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 mm/vmscan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1f7a90ecc700..f6f8c18dc45f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4622,6 +4622,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	struct lru_gen_mm_walk *walk;
 	int young = 0;
 	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] = {};
+	struct vm_area_struct *vma = pvmw->vma;
 	struct folio *folio = pfn_folio(pvmw->pfn);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
@@ -4635,11 +4636,15 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	if (spin_is_contended(pvmw->ptl))
 		return;
 
+	/* exclude special VMAs containing anon pages from COW */
+	if (vma->vm_flags & VM_SPECIAL)
+		return;
+
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
 
-	start = max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
-	end = min(pvmw->address | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
+	start = max(pvmw->address & PMD_MASK, vma->vm_start);
+	end = min(pvmw->address | ~PMD_MASK, vma->vm_end - 1) + 1;
 
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (pvmw->address - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
@@ -4660,7 +4665,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
 
-		pfn = get_pte_pfn(pte[i], pvmw->vma, addr);
+		pfn = get_pte_pfn(pte[i], vma, addr);
 		if (pfn == -1)
 			continue;
 
@@ -4671,7 +4676,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+		if (!ptep_test_and_clear_young(vma, addr, pte + i))
 			VM_WARN_ON_ONCE(true);
 
 		young++;
-- 
2.54.0

