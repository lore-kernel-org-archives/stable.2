Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5738D6BD
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896795; cv=none; b=r18ifcu/qNeNczEaq0AXupqw+iyicsF80BEmYsbacYC0yAi3pgYNJoCu8jamXGbn/uH7fQP5GM4OmhxHkPkoSSHrYQQ5XdzA+zIvS2hqJ8yebBaX4lqmiBqisn+RXrqz5UroGg1jDGWAfSHIoDsGLixxZAEHImIr6zYitF213EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896795; c=relaxed/simple;
	bh=fb1Dg6UJ5xV3K13FUqbr+ufWbZWL87oJPMlhvOJgiKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUAko7WsFSISQLzyrcpOHOjjLjzHCbN1B1GfMsdK+KwVOwYv4LNMDBrTkPJJqtrwLRCmqNninlwZi9ir8ArExcE3SFlZnKIAilyiobffdMnHeQkqCPbjHmD08rs849lEdvy638vggrLSLtLXbp4aTTui72COCvruCTsEDzOAFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIXNMYfn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIXNMYfn"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39682983a0fso642983a91.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787896793; x=1788501593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W67g2+Dtuws6uyQi/Oz6Kv22fM7UlvitqiW6NCwEKwg=;
        b=OIXNMYfnmYEh2T4adY6Wvk397NssYgrFi9HjSz43+1w1+GGthJmSlrcow795FqLzv0
         ck8u3AFSxs39PzqFScXkOSix6AHy4FeFOflj9SJqtzVVNgIdTllAq5QlIF17wiaHyveV
         RhKzEwr8yk+0x92rEym/vbgCDcy4owwPbI0d4r4imYc2fxxfsCiIiC9eFOQ4EXwiWmyT
         LOfjOkS8mzhl8j82CZE0armprY2PSJRHAzx4xz+yz8Yzrs3WT9IJCqyFkyOgEiSyfbtt
         y51RciL/N6b4GT/Ibcd5byDQrc55OTOQCwJuVPEjZxfs7R+4kNzTgf2h9Vd4VE3R1xQR
         zP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896793; x=1788501593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W67g2+Dtuws6uyQi/Oz6Kv22fM7UlvitqiW6NCwEKwg=;
        b=ZayO6UxzGVdQBNP1XOVFdxhS1pUVoKZL/Rmsoa6200FZHjylayhwl7VMnKL2DeoRHK
         soPCDzU7hwDt1Dxqd49uVCaB4ODLQ/5S2IVq5gZtrwyhUxFKqFwjKY8GNny5XQpT8gFu
         +eppP1UUPMhPkoiSAr5jvP8u4/TnzUTUv/nnsa6Lp5aDFnNMtDK9+HerhnX48wshtOR1
         sdLDl8m2WcQ8I5SQ8kuabaQ5HQIG71wJoCfPwrgeDyJyRGxLCLsxldhuHzXIBhE6QRor
         utQ7xvSivmY+5H+EITNY1Z70Q5/RoPDQkKh2FZ9eu8833Iu3NMfx/jYBlIkfRmGzR9S1
         kv7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpGuVUrF1uajCLedsNci35ZD2itO8eOu1GFQaWKVQ9MTq7zOrnDoCWRBUEflh4TYCyRvuDApiw=@vger.kernel.org
X-Gm-Message-State: AFuF++lwK5hQNCbApAcog9kE4jb3BI2zVuGTzuY3vddcu411sJIVaXP9
	5h/p105vvNevHpSxSBVd+y83AqasEw8rgD74ZmekYJQlN8LsmYEFsop8
X-Gm-Gg: AR+sD13W/qO/ZqIoLJewHTx3G6GzJHVURQ+fiaTP0e89/ZCH2zW8yO2VubqIJt6HqMZ
	mySAjWQYH2xcDdRUFIbpf/RUYAC5YSvQjdRgERh7FOzb8vDcEBOL5Jw6JcIEKXs2Q176HQgcLZD
	tHRluhQWxDy1/z1js9ieWE0q0QZ/w3o/i5fHXTGT07zNLkFUO6AjF663r9PGVzMxxZkMgmei9rE
	z5MX/1aPke4Vxn958JxvgP001Cwy0vDlEvyHFFSdB3MdAgYVLlz4GES9n2h0w9tzf9cSXjnpMUl
	obQGYxz36PhgBFjXkmhUYOtldG9pL/3hLZSl01uJNR3P2tiCY22j36hHuwn/1aPfPYaVfl8nCvt
	qQyPaDCGgsVqdV2IvDL+rKsvzMGEby9Oz5k09RvCOnOUuIrw0X66EF2VrQyDWZ+wwl0bsM98T6w
	Xch+FTthHjbztZMhgG6xGmGX4N31p5hlTaabtqnNY7gwKJetGO8iVmKP778OUrx2v9XqwMIVgAS
	62I72/1b1K1JQ==
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-396d0de4c19mr9263684a91.6.1787896792757;
        Thu, 27 Aug 2026 22:59:52 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea808csm5826241a91.2.2026.08.27.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:59:52 -0700 (PDT)
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
Subject: [PATCH v4 1/3] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Fri, 28 Aug 2026 13:59:24 +0800
Message-ID: <20260828055926.346744-2-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828055926.346744-1-vernon2gm@gmail.com>
References: <20260828055926.346744-1-vernon2gm@gmail.com>
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

About calling the respective trace_xxx() functions separately on success
and failure, refer to [1].

[1] https://lore.kernel.org/linux-mm/ao6jVbVHLUmuY2UA@gremlin/

Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/trace/events/huge_memory.h |  6 +++---
 mm/khugepaged.c                    | 11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

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
index 75639298efc2..b597a3e68606 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned long failed_pfn = -1;
 
 	present = 0;
 	swap = 0;
@@ -2715,6 +2716,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 
 		if (is_pmd_order(folio_order(folio))) {
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			failed_pfn = folio_pfn(folio);
 			/*
 			 * PMD-sized THP implies that we can only try
 			 * retracting the PTE table.
@@ -2726,6 +2728,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
@@ -2733,12 +2736,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
 
 		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
@@ -2771,9 +2776,13 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		} else {
 			result = collapse_file(mm, addr, file, start, cc);
 		}
+		trace_mm_khugepaged_scan_file(mm, -1, file, present, swap,
+					      SCAN_SUCCEED);
+	} else {
+		trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
+					      swap, result);
 	}
 
-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
 	return result;
 }
 
-- 
2.53.0

