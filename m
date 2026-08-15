Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A221C84AB
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771216; cv=none; b=BTK3yVYX1oJxcRt3mH3krJAqJ6290peOmWjsuTDBLeY8a3XMJHB33mxx5/gSrc3Z3wv/vltLFKlz/0/6NFdXBTEE+6SbQJ2foRYCu5vwXOIgUO7GHRyalScMhFcx0Dt3xXAeXlLHhZRkid/salcBmad1x0pmbnGR0Ap2xy0g/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771216; c=relaxed/simple;
	bh=jfucFgPT6pmFcjHVONsvKl7Ym2miaiPtaKIoa58Whlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwMea95GOskNOeMAkytKGM05bxLBDFRxVt9sINnbhXVOGgYjteAM2l3Y0fo215BUiOYXAX5Cwp0fuF0Hulkd2Dk1Ohvup14IQkJKU55wr5bsXx84ztUvySHFhsWASX75HFwNvSvj1dO8nBReuDuajtky+Omc4s4rcZmKolVw5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK4kvOyZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK4kvOyZ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39266382df6so1476048a91.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786771215; x=1787376015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGLWuLEG0kDSgM2QRoCYSrx2dw3K2Ihdk1BDWCYkYo4=;
        b=AK4kvOyZXbCLRVel34vgjAj8laW0nH+gBSvjbQhawT2FA80pUV7VevN78HTdLAzjcg
         Tj2x+xk3XiYUw3P/59PIe7+3HlCYzEcBfqYygJfmwfLaSVLn9y3+4bIVX0s54i+H+9NL
         0xXewOu8O6jWBE58rBlq8PbAR8/GTFHaCtpRxB3yfeq1SEYvDcg+d8eHPulzu8oXwor8
         2ohm4eRc/N+Cd3gQ3KNYJW6YSTFfst0uSPnWRIxu/qEy2bSlcDlBVfmNquLWXVaBeD7w
         U3AYnFwQqrv/2x4eA0J7D6jynwagxDZmCQcdTFpCnBEvBwnw/Gt43bkUFO0Aq2YGyt+V
         Ibhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786771215; x=1787376015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGLWuLEG0kDSgM2QRoCYSrx2dw3K2Ihdk1BDWCYkYo4=;
        b=lnNydEkTRTR94Lc6QAJ+89xforfIMBlQGOWAgtxHIT5mw0fxRLfzHQUIjqsJ4I9z+D
         mmihiriiz5p3nFprk+eur7uqOZsxQp989TF2w0gwSlEsU4StaGv/i6T9CCCE3C/lMjw4
         Ds7zfiN6kBShtJZc6jtng/knBK/cTVcy0x4CgAwaPy201J3wO8FWVLhMLPBEGU9wsJ7I
         gRSpkmOqJTCsfZ6fQbeUR2wE33mfGImLn+SCGC70JdUJz9rnsrHbwHSjbBZa+y3uyiN/
         ykZYvvnKb+Es6lqh+XLqKlPXNwwU3N6t+S0uU1qpI4oJtcCsyaffFeV044q5Lmzxjim9
         NGvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4N24cQ6FMpu4MBzhQpHp4aBkKFM9XIz54UndXT0uZ2PXCoz+m5qt0iePWkgN4G4trQerYxwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp5qQNJtg7UOFUBseipQOId8cD57KSS79nOIQyUjuEm6T5geu
	HoyR2zVOwuGkkt4i96neqPVq4zpPMozYYMNr2trd4I2JTlBcwNRYmgR9
X-Gm-Gg: AR+sD10qh4gKv3b45LY8i0nSpWBxfy4HKMIYazLFpTC0cgeZ4lHuXBwBUWCOsXYFvOU
	qvnsjaSivdZa0fY3YYfau228OYhGrLiTTruaRVi6CHhX0b3FkRuRXcqk3vDjMq59xiiMCtOTMD4
	a5bb0Pf/kFKNKD2AO+Hxz86DM3jveQh5S4ceWgwdU9UxrMvL0iVsvu8+lE/3PFaEtgvQv7nHzbI
	xtxYUvKfLVYhcHlpRuBkAvD1uvRqyXePQUMiS8j1mVWUb0lMj3IwBj1NhBDNRVva4kY5mQy2zXp
	Yo92k7iF1ecMC0QvNEGyovN1aR216vLQVMeJsqk1t81wnV8a1SKXU8p0DRryjJLUGQS8wvDikUQ
	Ba69Sq9PEMSaPh95tXsR6nSCkdg5QAb+Ck6LxEyZmUik8VJq83CrYPH98gVZUB1tuPa+PlYRwmF
	PzkOP2IGByLP/T3ta2PYBRMSuAuPZynsdCplvPMk5WnWp9PPC+uZDNCbZ+n5HrCpONcecieMdu
X-Received: by 2002:a17:90b:4a8c:b0:381:bc4c:da56 with SMTP id 98e67ed59e1d1-3933b95158dmr10890633a91.19.1786771214559;
        Fri, 14 Aug 2026 22:20:14 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96c7fcsm5269702a91.3.2026.08.14.22.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 22:20:14 -0700 (PDT)
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
	Vernon Yang <yanglincheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm: khugepaged: fix folio is used after folio_put/unlock()
Date: Sat, 15 Aug 2026 13:19:24 +0800
Message-ID: <20260815051924.194810-4-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815051924.194810-1-vernon2gm@gmail.com>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

On the rollback path, folio_put() has already dropped the last reference
of new_folio. On the success path, new_folio is already unlocked and can
be freed concurrently. The trace_mm_khugepaged_collapse_file() is left
with a dangling folio pointer.

So using the folio_pfn() before dropping the reference, closing
use-after-free window.

Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 5dc71d292f47..1b301d4e2dba 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -211,10 +211,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 );
 
 TRACE_EVENT(mm_khugepaged_collapse_file,
-	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
+	TP_PROTO(struct mm_struct *mm, unsigned long new_pfn, pgoff_t index,
 			unsigned long addr, bool is_shmem, struct file *file,
 			int nr, int result),
-	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
+	TP_ARGS(mm, new_pfn, index, addr, is_shmem, file, nr, result),
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__field(unsigned long, hpfn)
@@ -228,7 +228,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
+		__entry->hpfn = new_pfn;
 		__entry->index = index;
 		__entry->addr = addr;
 		__entry->is_shmem = is_shmem;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7c8c48577408..7df0fd2d2fdc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2247,6 +2247,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
+	unsigned long new_pfn = -1;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -2626,6 +2627,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	retract_page_tables(mapping, start);
 	if (cc && !cc->is_khugepaged)
 		result = SCAN_PTE_MAPPED_HUGEPAGE;
+	new_pfn = folio_pfn(new_folio);
 	folio_unlock(new_folio);
 
 	/*
@@ -2664,12 +2666,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	}
 
 	new_folio->mapping = NULL;
+	new_pfn = folio_pfn(new_folio);
 
 	folio_unlock(new_folio);
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 
-- 
2.53.0

