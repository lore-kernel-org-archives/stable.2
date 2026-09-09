Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E633F8CA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922723; cv=none; b=T9yMG7l4Sc/p21kKZXys8i8bh/1wnFYfQK5UurGvlpvcinYrtE8vGSHfFKTrFS+g5HvFoGjQsgRHEDt2nu5RM0+TFwuoOKGZyCb9jKMJWMwRTRaslKIKFiM535tmmKk19X7N9KyPkjBVOefvzwPk+uYudvnJx+LYDNITJazAZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922723; c=relaxed/simple;
	bh=x7CnzgkXZPi5Hybsq0SY68kW0PZsH8p9kacRNmwuD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peyR0RmfjtHHNP9eh/s6bzCb7n/BJ8sH/eyga4wMT2h2UPklW/sLQwnA8PeBmExEFk3dxOFuYciVoScUxkph/AZbP5TiDMfNgdbduhHlKGE0IWddVc9uKSJxaVQuW39ixuSo3xoPhADXc/6KyoW+bJzvVsSKx1RBP9AZRPFxDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me7t9B76; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me7t9B76"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so5227620a91.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 19:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922721; x=1789527521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXwn16IKsAcJzLpp2jrqz/yHYVFBEEgFTxz9PHTQzdM=;
        b=me7t9B76b9HvgUWueTRrWOpYn9vzxQgTmYtLIFkFtImwbUUqO1W4Tjv6qwg7D6X/WD
         4h91BXeKz/M440ft/Jyf9XXHlhsY+vu0y85mLoBNl7aNiGapDtUFS77PmuafncekGpzp
         6C/sUtR0xhLD9xo6Q4dtJhMQ5BSoqSwkMXRcTXdOGsEi3JnLbKrh3PvWR+vILwk/Bu29
         EUAXpPCTxXk9Ux5Wyy0zeLGOBT5yvRjxL8dxlgg3bDDgPkfx3K9/R2BtDxMw0HAmtj3O
         6EvIHrK+P2nVs2nDDkka+bByufvl7Z2MuDjdQ9SIaOu5luRNfU1AIWd069Kts4gUjupW
         NR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922721; x=1789527521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXwn16IKsAcJzLpp2jrqz/yHYVFBEEgFTxz9PHTQzdM=;
        b=aGrzH9LHEknx3d7vn+P1SFe1HrkGsR/Us9675XAO8BSgnlQfOZo/DENTD/jgNEvOoL
         HlnS8ByFKcYwNqJCx4rwzFYYbpfARbnJXtEEj2vz/J3GgFk3uf6ANJocbI37i0iEQvkl
         p951kqx3gYsaYxPG/DuvGVic9uDaVQOVlfmNxbCO3SWjFzFeOLlBOhY/bJjHxxAN6EgD
         hB+ka5vSYETyz31GGnh+5G4+RurzqJ49wP6mkqpFFdRnw00WWzQT8sQdwpN1isF9tRYm
         4MtShlatbene5g2F9YWLQ4xZyXQQpwkFmT72UQDmbsr3Ech/yILJAbu3KYJ2pa8iBu4p
         xSoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm/ISeZdxaieZw5xevfjRP1lhfJ2q+QAnxhMNbu6znY1l3GjQdBTRaoAZgL6jAoxv64L2ADTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kCbhktfZtwu+PtZSfgc9U47+n6OFYw699+frugKuBFIwPZuKuT
	gB08p2jztFuHzw2acMFCf6C5xU2F02gNlHQTRFGp8IfFwxoutCynQjo1
X-Gm-Gg: AYBFou2LUN9X51q0eleggdwgZFMOTSPrf3nwaMrKjjxbJePmOgTePyKsR+VqlUdebDa
	dfZvutnVnOJro/N7Yfe3z8hSJIwN1LtalrTcqYzQmjhZn0YEvX0IEchLWDIMLF6qWTK5gFHIbdC
	50+/xusj6glO3+wdzqGe7dMxylzODXNtq8kOl0w4y/4xYdBtyrOmJV2+B71jSd9euBuEwZJVH0Z
	wQqs2AMQerqNrg2V2TiEuuhIwFhT9QKqbx6QlWbGCgSHU6Kc/F0P847Jk0SD7hYzVw8aw6qYBLp
	4zrOr16hV446j7zgYMQE/ZXD+5LQwjVltU6nbHUzHzuEFVwOpx8lsDcPBcEAstJqRjQuw5kcdA/
	geBwjkrCmaEJMpYDapBvocOUQ6HdtnrM89yn4qA0I//dvulb4SQCBufNytX5B/QQv19x8+q7BOE
	TtWdpcMY1T7T2cS3Sm8Mytj6Jq5osF0dMnDiMP3NEoCiT2Fo6HL4qofr41hrs/kR46G9/Vg1cdB
	umQCm/kLKRTTQ==
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr44428583a91.6.1788922721071;
        Tue, 08 Sep 2026 19:58:41 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39451sm35077172a91.7.2026.09.08.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:58:40 -0700 (PDT)
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
Subject: [PATCH v5 3/3] mm: khugepaged: fix folio is used after folio_put/unlock()
Date: Wed,  9 Sep 2026 10:58:03 +0800
Message-ID: <20260909025804.3233645-4-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909025804.3233645-1-vernon2gm@gmail.com>
References: <20260909025804.3233645-1-vernon2gm@gmail.com>
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

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index b352c1330f8e..e13d233b9967 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2260,6 +2260,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
+	unsigned long new_pfn = -1;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -2279,6 +2280,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out;
+	new_pfn = folio_pfn(new_folio);
 
 	mapping_set_update(&xas, mapping);
 
@@ -2682,7 +2684,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 
-- 
2.53.0

