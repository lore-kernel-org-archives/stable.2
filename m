Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AA352031
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563813; cv=none; b=CZDAlHg81FOnQ4E+x7/Ms5hfi7aeV8bA71K8ProHcR4fZHSOYZfTEC9xtdhjRoii5DIDoe4QS9YbV6aSxSBncnx4BcsekYuNZ5w3lSnYzSpLypfzJByAklDYzhXqmdL2bFbGyGiKekafUvtuWy5dzvyGZImHAUsoffBxy6Ti64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563813; c=relaxed/simple;
	bh=FWng7qCEjeGMPDD7slzOVT3h3y67g/hV8NYocXvUfeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iooVBi0daB8TG7z0woVFOIiwYd2hZRWhLNcAyv/lAFUc3HjKNjN4Y5dlkNSzETrxG5dXIR4tJXXJ/G7uW3ZXriYoH6oW62du6PQ1HGfJS/qtTqZyV40rLtVgamIo0x5ZLDM4+aonpen4VnW+1SiR9nVSFPWm6sQXT4OhNHI54Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdKebhmj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdKebhmj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1469c1b83so4279780a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563812; x=1788168612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNTnRdSFN4Auzxi1H+B0QKsOJrKfL6HrsAGQ1BLbnH4=;
        b=jdKebhmjF+EZbpbcxUG+XsYQtmPolZMxqHvZwKQuynNLP7OHkziyeHKJxiZN/6SFCH
         DC0F9JejSL+iepeLZuPclmG6Oqrgsxp/jXWR8XFNav/V0UBxctPbSbRplkms6mDsJ+fL
         1z9n87y5bzt4QZ2mbVA/FKwGO4XrHs6O2FsC1uBemZ+bkTMn41P481KacAjr0ApnGTZ5
         YEDH9uk3ecFppr164jQ8Xk0aGgnmda84BD/bz+WzwkO1MPquIuqXkliMOpRod+ZZHcjt
         AZTLVFfGTjBzBYjQb71sqhA7RHkVwm7y64JPSqNAOpc1w8fk+MG/cN8+BMrnUf44B5ed
         LFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563812; x=1788168612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nNTnRdSFN4Auzxi1H+B0QKsOJrKfL6HrsAGQ1BLbnH4=;
        b=lfptgljpgHdxXYUqjBvTeCySZTRU4mWdHst6axnt9CjR7dPVvXFz+0wztX5m5ugh4r
         9uBkho/buMnpkCNlTHyiXnATVbsozOpULI5wYVca/xhQqIrj6mJ0dLhXxZUWNOk58f/d
         h8J2wZIFTbd9gpnesEVCTCo/or8vsrUCZgeAbeqXDdE9Q7jXplwD5BS+3GJmInE0EfO5
         fiRZZ7P6cO3zYfA/pn+YcLcj2+MdtM85PqNDXYf4H3zJNqwtDYtbouiC6w4ZonAMtLjz
         0NExPQSw2lqXWggEHeK+X5wHtIZBJhlXKzSfP91f5a9TFS53VkkVSi7tmRoCy+pUCtDF
         XCog==
X-Forwarded-Encrypted: i=1; AHgh+RrITkP/ztF2Zbe4pRDMX0t4tcb75K7ZMcMCczWzbV6PBF728Yb0wgI3oih7nRyJ07tUmfwaQik=@vger.kernel.org
X-Gm-Message-State: AFuF++k/yIXNNtSVWztZvEKd+c5cDlGKmjTSx/iLwalXMEYjvJzMdq8o
	M6b7m0wAN053MMD32aeLXQSytccxN3kWSOZKZmJv65q+gE6TZAYfLGIC
X-Gm-Gg: AR+sD10kUkx8s2oOHRou8rHLQixT+emZEY/HD0vX3/IKhZ4BBgRNMkI3GHi4DP+pgPZ
	7TlsHfWQQ1+Jcyenl+SF+kJr1bzTic5HxjoO39Gkxo13GpR9D5ovim9L1H4m0YaW8ryRUxIaKir
	EYgVdAUuaI3rUcu70sieRPy8SxJFtj1zoRLMcdr5v3JOpCcIShxvHSph5fCTk9Z+aR+oELCDZdg
	GUMetxP6y/JPoHBBLdI4pOkdtWXBe2vThy3mvPHJ2W/k1gYyUARvnea35ykG9hyYDXSq1II5sa1
	4IicGiKNbGDB8zN2KR1qpGAMDIcEeB9NrfjCwcvP3IAsSAVwz138DbstJRF8ZhBAZwlFnIYwlV3
	D95S1lEdZs7T3UYqzTe1brzC4DUVtEy0NRQX+8nb8CAI32BR+7F1Yq8x1Nkp7M3PW1Kl5BkL0Xk
	C5eay3KZ0dNmRLl3n/rVGa3fXAAtPPFn2+6MelFcdBCxyiPLC5LBDc0O5MENRgzbf8lABVIDfnb
	gw=
X-Received: by 2002:a05:6a20:94c9:b0:3cc:8344:1213 with SMTP id adf61e73a8af0-3cd2fe7a37cmr43381415637.8.1787563811608;
        Mon, 24 Aug 2026 02:30:11 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60035sm845226a12.22.2026.08.24.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:30:11 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	zokeefe@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v3 2/3] mm: khugepaged: fix folio is used after pte_unmap_unlock()
Date: Mon, 24 Aug 2026 17:29:34 +0800
Message-ID: <20260824092935.73892-3-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824092935.73892-1-vernon2gm@gmail.com>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

After the page table lock has dropped, the folio can be freed
concurrently. The trace_mm_khugepaged_scan_pmd() is left with
a dangling folio pointer.

So using the folio_pfn() before dropping the page table lock,
closing use-after-free window.

Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 7b526528f85b..fa828967e1fb 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -55,10 +55,10 @@ SCAN_STATUS
 
 TRACE_EVENT(mm_khugepaged_scan_pmd,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
 		 int referenced, int none_or_zero, int status, int unmapped),
 
-	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
+	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
+		__entry->pfn = pfn;
 		__entry->referenced = referenced;
 		__entry->none_or_zero = none_or_zero;
 		__entry->status = status;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 00337405c0e0..4e0fca5942dd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1618,6 +1618,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 	enum scan_result result = SCAN_FAIL;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
+	unsigned long pfn = -1;
 	unsigned long addr;
 	unsigned long enabled_orders;
 	spinlock_t *ptl;
@@ -1780,6 +1781,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		result = SCAN_SUCCEED;
 	}
 out_unmap:
+	if (folio)
+		pfn = folio_pfn(folio);
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
 		/* collapse_huge_page() expects the lock to be dropped before calling */
@@ -1790,7 +1793,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		*lock_dropped = true;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, pfn, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.53.0

