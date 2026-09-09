Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733730648C;
	Wed,  9 Sep 2026 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932584; cv=none; b=TgEYOlwk5jH4ldE8xe6o0I/NeTHLpJqSKxK9+xZYb1CXwqpDMUfL5K0BLGacJQ/RTGoV9wnWdZUkVk9MvgbpmrooKYMJT2TxImcgXTPTQWywk9nsSykk+/21Ayh9u8wt8pit0aJ9LKFafWgj4a1oSeFNU9UuUMRis7QfSZiyzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932584; c=relaxed/simple;
	bh=rr3hEOzS6wNnpn7JbL58jpSP0MguAL6pqxYWDazAArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eukbSKdykPWDjYAPNgo4magJyySavRycQ4NYJar/xqtpmS4yNW2NnFzFHdPoptXLNBeBMTF/fIrVvREKFbSaLswJBSWYkGQjwXIEwbBKwBe9XTgQpk3aMgcUpNv/ue2meqbGMz52PWD4GiWlbdxRF2HBgY/z6Ld82i9+2lRRv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGuqOTOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGuqOTOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F831F00A3E;
	Wed,  9 Sep 2026 05:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932582;
	bh=zf7x3TbXalEJF2sMMhkyWdw4YMTc1v08MJk4nc1HYGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGuqOTOkY5Ye+gQ2NavGARPwZJ4AviIjC/FUBAtdyx8hiD0jg6U4jIL2RQLlRmRFg
	 q/KOQgrFtvPOAA4KUc3JsWjwbQFwomgGq2FbM0DdkUbrUQNtmjOsrKxo/4KmpRiOi7
	 fHV/W2yB2gpxXH6wnPfksr+AhGx9GxD1Z+rgdT53uB6FxTa1nltLq9pY0aEOOu7uMH
	 DB8TqOzDXvjBrToV+XztpWPy4iXIThX5OlWgriTH2N/0qFT3wiDsb4RRyZRMj2sQs/
	 Sx9xtn+/zYEzfvEfRJMSCXAiDJfAGCub2nR+m+q93FpZXsxNfRBSmFbCNRIfwuQVye
	 mHjTKZ6kjKX+A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 22:42:54 -0700
Message-ID: <20260909054255.253652-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090853-handoff-bootlace-9e07@gregkh>
References: <2026090853-handoff-bootlace-9e07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can race when multiple kdamonds are being used.  The problem from the
race is doubtful, but the gain from the optimization is also doubtful.
Simply drop the optimization in favor of code simplicity.

The user impact is doubtfully trivial.  After all, this kind of
interference can happen only by intentional user setup.  Even if it
happens, it will be rare, and the consequence is degradation of the
best-effort monitoring results.  No critical consequences like kernel
panic or memory corruption happen.

The race was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
Fixes: a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f23f0aa62b2f32c2b12f95959fc4603ef81678b2)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 7bc8d79c7fa07..d1d047f494aed 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -120,7 +120,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return !result->accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+static bool damon_pa_young(unsigned long paddr)
 {
 	struct folio *folio;
 	struct page *page = damon_get_page(PHYS_PFN(paddr));
@@ -161,29 +161,16 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	folio_put(folio);
 
 out:
-	*page_sz = result.page_sz;
 	return result.accessed;
 }
 
 static void __damon_pa_check_access(struct damon_region *r)
 {
-	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
-		if (last_accessed)
-			r->nr_accesses++;
-		return;
-	}
+	bool accessed;
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
-	if (last_accessed)
+	accessed = damon_pa_young(r->sampling_addr);
+	if (accessed)
 		r->nr_accesses++;
-
-	last_addr = r->sampling_addr;
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
-- 
2.47.3

