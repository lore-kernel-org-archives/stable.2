Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B881ACD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563809; cv=none; b=J4AkU/WtEOOW9gXVeOWhojYVY1MRbVeJgUedbjX9miXH+HPvnYUZaM6Qw19wMFgJ4zvczEAdINTEkvbIn/4pxBXKGu/2iUlCRq3RDGWHPx36eN+CD9ULonQK/KJx7TwXGyV9obonjQqatsAJtFD78IujX5kDNjRvNXN2v9pqeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563809; c=relaxed/simple;
	bh=mp1cYCqbvfJALgCzLnvRN0dxdui+lVigVvJITXo9b+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndxs6OF/fHgnhD32iIihymKQMksUp6pQbkY69mYwKc2yXfe31vCfnaI0NFWdpBiRr6JWoY8uolmUrR+EhIm6w84EV8f1iw1nogxSm71VneVOYtKkcQaBnGVjBeSqeX6+7/x7wxSniLnPKfhiRWRGsIJMRy3//6YfgjQ/QeoEWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU8Q6IMg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU8Q6IMg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84eb992a881so2217252b3a.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563807; x=1788168607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Ip1jEqtN/coAyik2SQv7pRhr7t2Z+l9dqjS0wG+sk=;
        b=PU8Q6IMgIkY3+wz/Mq/nUkOO/RbNJdh7bjNnbHHTbhuX7VeDCzpgSL2Re8g5AX5Fk1
         SY/mDQebhSuoyOp9N8GL5xEXXuOCNuVNi+U+hCt6ye+iWUdQRvfJHcs1c0baioM47TTs
         xE6UUg5yR5NNpTz7c/TVaaKQ1nvXXFBLJ9dO+TatcKmTyqDB10vZbDR1flhp7vNJU2K1
         KBM+mYZ4Kei2YkYw3BY82j9Ajv9DW7Epu5mAFvNsLtqEv6UyVOO6t7WJKGmQU5O5I84x
         sXxg7JHzHUrgzEB0VX3ic+oLJNnha41nm9lgj5rBT61m6rmObpxNcnhLrhe77MZZgjtN
         oC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563807; x=1788168607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Ip1jEqtN/coAyik2SQv7pRhr7t2Z+l9dqjS0wG+sk=;
        b=iNVvfqkMDtcf8T7qqfkbj+4K4IjkFRHIOUtc9s0pfDWdHzxp4IooZBM7bJ9MwkwQkg
         cbYhgL2GZy70UZs4eUEhSZiKIaBm3IcMKi+YEwIgC98mBaAavDIUSJCOJzjdCxVjGGTv
         7hFVWl23OWIuUe11f3UNjbiqWdNbOndX3oqpItlJtq3zG5J8QTNYQuMl7RaLxQQzSsL9
         pkAcRcMm87O2FmjX4jbJH0S2evYaDd9Ax9f3T6q+hx4bv6djyXs83VbPwHe3tksmQDyn
         GWdyZOTTrebSwuxXd/vqcPO0risRCIrr2dv5KR6b01LW3IjmiI20NwTWJFW5sVxdJdhH
         rtxw==
X-Forwarded-Encrypted: i=1; AHgh+RrFPFV7LyeC44EhFUdSkqUcWfryCX0JeGodea+7rjIeWO324KeS0+DBIYG7Jn3Q9xZth0lZqUw=@vger.kernel.org
X-Gm-Message-State: AFuF++kQDeYgoxcoLfJi9YlSu7k9lB6ZnhTjRCEZr5MUzS04VZMslrmH
	K3Fy0nOVWsOnfH8F1xb2XJnj3hvzRXEReKlkEpT3wWrcd5tcdjptxHct
X-Gm-Gg: AR+sD13GIawwhTZNPkx/acH12oPM/3LY75wk/hVsEKpyb3YP8zuOhRNvIeGgbW2vIe2
	W0yBk0wlkrLZ1CbQcdnJ0Or0jCsJJmGF/baKHjOxfCyIZ2Kr8eDm/0E5K5s9A3KCAlfZ2xEbyOR
	Po53v2ekkbiFICnP3AZDbcsmKev89fK7Q1u2ufeRbJa2UMqnT5F7uIlZAKjj4KlRK8g17/BL5Gd
	0Zk82k5WQ54GeE4FEKSTbeM4pTJgfR7VAKW4s60aADK+Ius3+yY2ZYNMWVR3wH/n3Kwsetr+Z9H
	W3XfG4SA/trUsgvWMu/4IjC6IgKsAdO6bvjZlZ3KFHrjlzH4ZyP9dsYtkkuXDxTrnLesy9dQmc1
	L85A6a+YbiZ8DkXXqZcWHbO3JWrU2UYtcERH0vTXTvlvjEGJ3dBGUGtKKY3uK4ztfQhCLokKkH9
	d2FfbDnrQd86Mk+PoCNfHRNhZTNzh9/fotfNLgla83mjACXbxP+FTnAbIQlIXoce5kFeW7nWHpE
	zc=
X-Received: by 2002:a05:6300:14d:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3cd2fd4d873mr48989218637.1.1787563807262;
        Mon, 24 Aug 2026 02:30:07 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60035sm845226a12.22.2026.08.24.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:30:06 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Mon, 24 Aug 2026 17:29:33 +0800
Message-ID: <20260824092935.73892-2-vernon2gm@gmail.com>
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

When the swap entries found exceed max_ptes_swap, the loop is left via
break with folio still holding the xarray value that encodes the swap
entry, not valid folio pointer.

That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
plain pointer arithmetic, so the trace event merely prints bogus
scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
dereferencing the tiny encoded integer and oopsing khugepaged whenever
the trace event is enabled.

So when folio is the swap entry value, simply set pfn to -1, just like
exhausted scan naturally.

And the folio_put() has maybe dropped the last reference of folio. The
trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
so using the folio_pfn() before dropping the reference, closing
use-after-free window.

Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 5a48c5406cce..7b526528f85b 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 
 TRACE_EVENT(mm_khugepaged_scan_file,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
 		 int present, int swap, int result),
 
-	TP_ARGS(mm, folio, file, present, swap, result),
+	TP_ARGS(mm, pfn, file, present, swap, result),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
+		__entry->pfn = pfn;
 		__assign_str(filename);
 		__entry->present = present;
 		__entry->swap = swap;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79effd3f3da4..00337405c0e0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned long pfn;
 
 	present = 0;
 	swap = 0;
@@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			continue;
 		}
 
+		pfn = folio_pfn(folio);
 		if (is_pmd_order(folio_order(folio))) {
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
 			/*
@@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
+				      file, present, swap, result);
 	return result;
 }
 
-- 
2.53.0

