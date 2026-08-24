Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAC3F328F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563817; cv=none; b=b7gwpE8iWtXZzvG2v8rF9nvMbh5LpYMvQS1DqBBARcfbSnuXoSP23zwqbVsiO1QEspu1r7ZSPBJxoc6L/pJaFeZwdoC06DgRoTEXYPGV7jGh5f4Zh4mt+AwLUAQhQ5yopEegYez/DWt87giTTY4os2SHe6iIUC304dYvcbFa0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563817; c=relaxed/simple;
	bh=F20+2pN27w1wV106mm78Uqa6vlea/vNu7ZZQw84xAlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maXrCbjbuXoPjfdjKwkVdJ+WxVpRAvI8fuEpP4oCWiDEM2QWn1J0yGAPzMb/zKyqQTqi0r+bkGUiJaw51c94lKehJZ6qnip9zqfAq3JJrykivdxLDr5w/+TLw5DlngsCPGT6ZqizTAhNRcrLDz7NAfFrpXWlQvTVXZPoG77miFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqRyKLCh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqRyKLCh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso3253515b3a.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563816; x=1788168616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2yr3XBcdQ3LShy8RFIN2zpBH4EW/xdxEP6silOD6LRY=;
        b=DqRyKLChYlUPPg64B613vYeFBRbdIE6dwLXT2GYtxdNkks5tSmLRq1lrifcBDsU5ot
         3odVw32vII3qBuL+OnvQ5q7h1PywTFup26L/iYNPjKXrzJEGxCwErX7GYF0C530aMoV7
         Wsw4ZJQXr9PKcq1dGkoboSj/ghie4YzmulifREMDKWubLCxO4aabAKT67IdCvTa0jQOL
         KP/gy1iDbyTdBzDg3GGHnpFIfYW2XwVEOgUV1MD+LZQItJse1TIjQNik6ACjpETfLS87
         zyM7wH1Rz0wAgKUE0/xtgEIrOLWY7y+C7S9DzgDb80eOSJphPN+6fE9pg62YN3cUzIWJ
         1K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563816; x=1788168616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2yr3XBcdQ3LShy8RFIN2zpBH4EW/xdxEP6silOD6LRY=;
        b=UJMTRFkLSYChdQDToaKG0C7b8Q8GNZHNaEcCnE+KktG3zBOhf2B1hXtxLF0FHvcYZs
         Kne9yfcJU9wjTIGRfpRzMu3rxCD3oXAEQJ32I/91JoD+Col7CeoD8zl5V1FQ5CaTtQrI
         78gc00Uhd54dHuPibfBfDzJDMZJJjfUq2eaE/Ius+D9h9j2QFSpiOAsp2Tz+TBt8+hC2
         I/6nWVfHWKVU5S2LxBSffPPWue1rzaScqSEnrM2rfvwajWByIFJHhR+ZEYgx8uZACJGw
         5OYCb/L499FPgMFcNUAevK9h1VWTyu3bBs6K80kq2/Kgajz+TuBdkTAwUy5OWdzkFjdL
         MUlg==
X-Forwarded-Encrypted: i=1; AHgh+RpwXGN6dOhvJKwvk4pbIEKk4Y0ma4vPq2q+Jg/VhCYJhkA7rdwYB9daS/TE6gBATxMfn2WJKpg=@vger.kernel.org
X-Gm-Message-State: AFuF++mW60zaLTQUl/RBeszcYQfwaKam80xAqMb2c1JPB55hY+lJ7UNL
	VQoshJO0d7v/V5+zBzIO6pJ9t+wLe25fSGU+2VtH9dmkIF6Vn1lA+R3b
X-Gm-Gg: AR+sD11OdcgrrDRXTizvDp+UHCKVSK0jKqGkWYOQMXgHYehHbQiwqQ1oUBVyqXAdAoK
	44OGBFZ11b+HE0BUpmtmUbCJr32iZ49FlqdldlxVLBUbl5+eFekhHU3KRdPoHw0uLVk/GNoPUBO
	iq6t4FOx3dGn8X/FaIt+paBEeaeqIuQ5Vl75D6ISUVa+d8XxUF8wVPpRJrIFoWk71lThRZPAaTa
	hMxVAphwtRjWhs+mAkvFnkHyV/6rRNsIDqy9XhZcten5jVlogPnZiFS3Wi8UWCpf4/nX2RQfk4R
	Ecw9RAXvhV5igozLsHbUqdLQqra1kATxSKzEnVqUE6zgfkZYJ8pp0GFCUzKkWMtiwyBAWAn06sr
	yjFJGH6Z9aUCcdXRLkvMurRDPFpXmWfENabY19poBgcR1TwJpCK0QlsJb4yW5LQwJlurgVswk5h
	WUSAGdvaamjBSBz+P5D8hplz8dwtWjt4axRHR4d5/54oZJJyXHle0uZdx8wt7lVgIVEFZttSUd+
	WHdEmGXf1XLQOtzu0HwHHBihw==
X-Received: by 2002:a05:6a21:a93:b0:3c3:a140:9392 with SMTP id adf61e73a8af0-3cd4b6850aemr34704553637.0.1787563815848;
        Mon, 24 Aug 2026 02:30:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60035sm845226a12.22.2026.08.24.02.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:30:15 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mm: khugepaged: fix folio is used after folio_put/unlock()
Date: Mon, 24 Aug 2026 17:29:35 +0800
Message-ID: <20260824092935.73892-4-vernon2gm@gmail.com>
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
index fa828967e1fb..5fb4d92cfd84 100644
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
index 4e0fca5942dd..24347f1a94ae 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2254,6 +2254,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
+	unsigned long new_pfn = -1;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -2633,6 +2634,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	retract_page_tables(mapping, start);
 	if (cc && !cc->is_khugepaged)
 		result = SCAN_PTE_MAPPED_HUGEPAGE;
+	new_pfn = folio_pfn(new_folio);
 	folio_unlock(new_folio);
 
 	/*
@@ -2671,12 +2673,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
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

