Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591F1C84AB
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771206; cv=none; b=o3OYOE/XjDYIXYrY0TdabAxNN6yy7C+BsiYbbgmQ4NV+OJmNorFqZj+tautienfSZ+ziTlXEmwlg4PRzQS2mvLLg4zw0dz+xP04ahqp0dXKMcm5cRW2oXv6thSSHxXp1OyUcKoASe5QgyaR5S6LB8PnpJP95BLRdCima9txl1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771206; c=relaxed/simple;
	bh=2r1RF881LYsHVlBEr4htWYzA6gwwa9pnKcUsZN5CSdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDfns9Rk0yKoSuoMjXh87wGNZncwOCwVaCxFfu2QeAyFB0UxuVCbx61zoyuwkVuUWSu+V3tqsx/0cidouYkvICMhL86ady1a7h3qvq/B7P1XrcevZ/tpWd4yAADk7AKMvbjSrPwarYm47Pp/gNO2srYr42noHZ5n9N/yUpUqj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpppSY+S; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpppSY+S"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d53197d8b5so9824765ad.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786771204; x=1787376004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yDUp3cp/r1Pc+NMXZTiNUemFBBGGof6Vn7/JKGoQAI=;
        b=XpppSY+SwcweMS6++TdSfy0vRvVfPfk0bqIKbTf/VMyuacUDz4eTB4IavWfpjq85EV
         99mHD2Fl1z5AgAOdSPhHygGPoKPvK0c6q73PYKLVkyz3YXRzsVafzxuhp4FA8SWiyYq7
         Hzg+nRSPEn/l/I1ndlvUFAMzo+HDiupEeBia6mGI1u+GNbsUUGDDL4uddU/SuxY0geWd
         MWsmIsQA955yk2Y1Ycy8XQa0n8s0lt812q2GortHv5oS2G6D6E8Xtri9SQ/utIG5tueH
         zD/HKj98BB625OMle7i6vgix19ZlyBeHVTiUlR08VbuhLywbTirrs7OZbEAsqVr/HC4G
         06/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786771204; x=1787376004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/yDUp3cp/r1Pc+NMXZTiNUemFBBGGof6Vn7/JKGoQAI=;
        b=HnTqENwbDmYC4RPyAjnDZdRU99MaAk70nLnsQlP0LvAnR0Xl/H07vECaiGhiQANeSp
         7+REllbWeGnuyLKYSdL9iI+PHN4aQp9OXEO/+QkdgYXyyKSTcAKWZWe8M08meI/SISfy
         10lS1Ygz9UO1XZT4glkwZcDo/0sfHgIuF/0i5Zpasw8r+ur1zuAGCs62FKOw5BVqwFQg
         u0GXU73accC/Xuk4kGCcZbqBqCLNFoBWjEM00R0W8ET56OOpundb130+5pcPAsod19qm
         htj3AW9HX8PTKfgqzI+xhOHT44gpkQAoQ/w5J/Tapek8WLrsJWFjDfip3PDSPh5dIAiQ
         CAxA==
X-Forwarded-Encrypted: i=1; AHgh+RoyfyMWXmWW2HKzkBa1zQCsYxrEXtjvF0soaIBe+dIB3Afa05PgSmSQWDmOP5gkrgdH4zJOkVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesxHxx9INdb1K2QJU6dytMzF94LATkzYzAYutWhJxrQjIKwvE
	hGeoJfDyQCKC+WTX8jID3JuWDfr7ZoIoPiS/gVmA4qoaQyLFAAoK1pmF
X-Gm-Gg: AR+sD121Yb2wowQAzNVrbuN947C2Q0Gxl7Hy0y4ep+DEJ1MbfZWn3iRX+jPn3vZRZLe
	b9/zlaizQH5KfVikgiXh2I47OzWObm7yE7PgEkFfAikRzF4/ePloeFrOEYW6y0B+W9oOEtM9I57
	H5Q3in+iLoR11UYHm05o7xzm7o3ScGUiYCiIXUYLJE63400/JLG1mwd2/40i6c/koqSMyzVCUbh
	uBxU9vb0V0Aed9kerQFhVrRgOeq4A4URoJSOhtwKeZLg28O5HX8w7RpoeN5eYNE3po1tYoNWBgP
	U1Vo38S1DJmlA4uJb80friJZDd1lZGwxfs6uY5v0BuUbkNK/4gxXlEyrXR8h6ETZ05u+NyaDjPn
	wCbNCwuUpskOaKmy5sj3i2SeLLMUU40GuAAXlg5zqcBHXBNav4WZ2rwzKw24bjqjqwE0ek/FopU
	rupSyICcZMV4LPxOlwKsM4hEohJFn4bxSpsWUKJsFqf7lOeEotmJTufTEyJvKaojBdbSa2ga52s
	/PgNmvZWSg=
X-Received: by 2002:a17:90b:1dcc:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-3933b77c874mr13623090a91.3.1786771203820;
        Fri, 14 Aug 2026 22:20:03 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96c7fcsm5269702a91.3.2026.08.14.22.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 22:20:03 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Sat, 15 Aug 2026 13:19:22 +0800
Message-ID: <20260815051924.194810-2-vernon2gm@gmail.com>
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
 include/trace/events/huge_memory.h |  6 +++---
 mm/khugepaged.c                    | 14 +++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 291fae364c62..d3572d4ef453 100644
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
index 617bca76db49..e7830761d3a2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned long pfn;
 
 	present = 0;
 	swap = 0;
@@ -2720,27 +2721,23 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			 * PMD-sized THP implies that we can only try
 			 * retracting the PTE table.
 			 */
-			folio_put(folio);
 			break;
 		}
 
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-			folio_put(folio);
 			break;
 		}
 		cc->node_load[node]++;
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
-			folio_put(folio);
 			break;
 		}
 
 		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
-			folio_put(folio);
 			break;
 		}
 
@@ -2759,7 +2756,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			cond_resched_rcu();
 		}
 	}
+	if (!folio || xa_is_value(folio)) {
+		pfn = -1;
+	} else {
+		pfn = folio_pfn(folio);
+		folio_put(folio);
+	}
 	rcu_read_unlock();
+
 	if (result == SCAN_PTE_MAPPED_HUGEPAGE)
 		cc->progress++;
 	else
@@ -2774,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
 	return result;
 }
 
-- 
2.53.0

