Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39811E5B68
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771211; cv=none; b=VMmdbXEkRnxTiI3Xl3lyKJlNSh4LPLG0GFlbUrg27NF3c4sNmUSuPzOUgJTH598qeKb/6xGc+V9tjNXA6RtWu0bWECreGAJ+xFNgFkwcLACwnwjrCoingAnoo0Ex0SkVIDCkEu1LyO+oA6BYV6OfBGmlcmXFsmD3NbnY/kL1YGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771211; c=relaxed/simple;
	bh=pyjg4tQzeWbPwGazrdi1gvyH5AHb8VIEL7W7KMpA1Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPdtdMyiyegasvEyZDx472nTBXuxmIT2kMhUPo0YMrKdAqxRVzHjMgfA+6GJluVYiZ/gff3AhVtzLnHs9SOxZfzhhXyECYJ0AR5VySu2zvaLmunX/GknxbCmEKIhvB8uBtDyfXJceK0J3XKusIfb8vTZc/8u++DUWKUPNeWWcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPM9uKk5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPM9uKk5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2436147a91.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786771209; x=1787376009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LNNcf+87LrqHmKQ3ILDbepTdxy8o+GDR7o/oD8fAmg=;
        b=fPM9uKk5bydwBUFPCbKodcuiLb4a+vBi/4JI/8FWMvGifiAaq7b4I0KAPFcNzzzYD+
         lqx60DIgXhzAf2/cjnuGJzloo/QgQi+J45LS75M+UnuA5d2YauggNrIg3x5ZaM8QQFUF
         0t75/I8afq1Ls8P40Y124a54qTpr7j5EdY+qWTwJ6kGanSL3TvL7U7mAXKPhNidcTZIZ
         /uXV4Jf/2Xr8uswjnMY19Kc0CzGWbNC1K2rW21M6mWhl502ouggfRoYyikFcR7q7EW00
         Qdq4Iofw3cHGxqHitmKKeKnSG7qeHjExRybFrqXV9/yPz5+valtwc5QhJTqcK8Djjkx1
         Nlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786771209; x=1787376009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LNNcf+87LrqHmKQ3ILDbepTdxy8o+GDR7o/oD8fAmg=;
        b=Fj7wAlvpt8mWKAaUh/7NvjkSpom0snOKEdwRu5Psw6rX36BT0FiXgIjZ8niytM0JWM
         DGYH1Sx4EA+JcWDT8fn9T4pF0I7L8JHaPCiJaop0r8TVIx+AgtgWHdJuhahaX9vZIjzW
         VIbi4oGne+YA+Myh50kQ4LBSZsImRbJCI7mOXcMwxlciOoXNk87GLwj9RZrOpqoGQFIP
         V9IwCsfv9CxcoM48c7yOJvlkeEwoSJmoxYZyIEeajsw1WsrQgw1VZkQe6FBJEAzdqmKu
         UevSqwBBpMf2sIJHcR+katsK+WlDFVw1p9VCcTonRakAzj2Si4wexeI1rKPS5cRpZk+u
         Fudg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/uS4NdfBwiwnDvwHqwPOLFcTzAW/qZdwBcA6VRCTGUUMdS9B2+iiVzr9KSAMlORFCy00griY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmVCm/6xGtiHh8KWDs8m4m27mMvlZMzS9fcrn0l6yC1LWRhrV
	87dRzY4BekTk8Pp6QjW+DhD9KhkW865cWTYi5IyaMVFEIIvBvJ0p7Gb8
X-Gm-Gg: AR+sD118WUKsBlOHUOllY3e/Bls30x5xp3D9IT1l68kiGELmW+qPBOeonwz3BABolxP
	EDD40LyEzykBJXOVX65HnC03eIVn+iPS6xP89ryz8gW50v0QHfLURb0lT4ugBDh0C/x6JGfCBpH
	5jR45P1psS2xAcvSDqQEp3QcqKXa7znqv+9Q6YENuDAFiqhNChyJMJJLNwzvPDFutelkRd5Kl5c
	l2Z6ZjBlmx4aGO501bbJL+UmTb77oGSpeWIHDqyHNHWvOito0K4Kgb0OjWlnoMuQFCHU4AqQ8x4
	2cPIDI8tQVyOMgtJJgSblwsJ27BjDpZGzl3tWK7yXNeXz9YluOEeqOQ2zWKHB1UxvQ9GZ5+27GZ
	1sb+uJxurEzN2yU5Pu9dUQyIGJaNTlGQ6kLm/jixE8n4AGGEf7XiifJpFP4FQwiuEdOARlunoBt
	sBYLaxJG1b+C+gNB6WssBl3UAsmYKYPhzR3RYrMa9l6kfXWgiE+moJzeqedQ1C33puirsG8eGx
X-Received: by 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-3933b6d05c3mr13639215a91.4.1786771209186;
        Fri, 14 Aug 2026 22:20:09 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96c7fcsm5269702a91.3.2026.08.14.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 22:20:08 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm: khugepaged: fix folio is used after pte_unmap_unlock()
Date: Sat, 15 Aug 2026 13:19:23 +0800
Message-ID: <20260815051924.194810-3-vernon2gm@gmail.com>
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
 mm/khugepaged.c                    | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index d3572d4ef453..5dc71d292f47 100644
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
index e7830761d3a2..7c8c48577408 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1603,6 +1603,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 	enum scan_result result = SCAN_FAIL;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
+	unsigned long pfn = -1;
 	unsigned long addr;
 	unsigned long enabled_orders;
 	spinlock_t *ptl;
@@ -1778,6 +1779,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		result = SCAN_SUCCEED;
 	}
 out_unmap:
+	pfn = folio ? folio_pfn(folio) : -1;
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
 		/* collapse_huge_page expects the lock to be dropped before calling */
@@ -1788,7 +1790,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
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

