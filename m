Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E133624B7;
	Wed,  9 Sep 2026 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932322; cv=none; b=WJQ8CkXxQEN2Wz6x0C8iSRA2jF9dG/kXKXaNalrCbZX+x6M/thLW1quz073GVD94l+nYTlWwXmxnalEL50dMAzWO3hre7FUxt+qxTCTqvdnc3dDUcotWz9PocJtNjqcaTpK6KGR8HGpe8dlY2Ccg5VxkYDPlj3qH1hmQtVw1eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932322; c=relaxed/simple;
	bh=zxDhyvymcuwzAURMsoCw8Wp3wYwU9K1/dYLyI1QwXVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7Fej5nw7MLz+yo/ZjGnOWLNARC9jdM6p/HCffQcKINUJJcGmGJmUzaFS4mYQFE9C/P053cdtWqNto4u95GCPCydp6VyfTiu8FXcxyHV3LD8vdLupG0hGcJAdfQH3SIMZHhMXMqqPU2PrGQ7yNhWI7ciPzMAUrAiaoK5zm50sQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPp7TqrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPp7TqrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3461F00A3A;
	Wed,  9 Sep 2026 05:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932321;
	bh=WWUZDq1zLCHt/fRrrDBcda6tFYXpO6QtbUhmJBGoxKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPp7TqrUDkSRlsibgIUdhU3sCukvCdgPoDDbGjVUavMKZUj2r3SzSTpcuAaowmGGp
	 JfgQJbjtpnVOWI3XYgWtGCikU9kZmIHJ8mTQZHDpfpo7QEZQkgWk59d3b1/jdUDN1n
	 vS99hfktlNue0rjUNBGMH2pTzxOiG802OOZldPtfhhabuDu1kzWR6sTFYJwnxspsZM
	 WwqbNAoQIn3WV0qnScVDv++KYes8tbGYRwffg7jFGKZ6sPCgB3h3Gx9LZD5pkXT/Lr
	 xO0mpYcdVgM9lIj7UrVThXLAp9DQgOw2LbLHLrszPImiRbK05LpalqdYReNYRO5uIi
	 NBxhRWyLsPYxA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 22:38:34 -0700
Message-ID: <20260909053834.248582-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090852-ought-makeover-4182@gregkh>
References: <2026090852-ought-makeover-4182@gregkh>
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
 mm/damon/paddr.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f28cfee8351d3..1854b4bb6bd29 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -67,7 +67,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -76,7 +76,6 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 		return false;
 
 	accessed = damon_folio_young(folio);
-	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
 }
@@ -84,23 +83,12 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 static void __damon_pa_check_access(struct damon_region *r,
 		struct damon_attrs *attrs, unsigned long addr_unit)
 {
-	static phys_addr_t last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
+	bool accessed;
 	phys_addr_t sampling_addr = damon_pa_phys_addr(
 			r->sampling_addr, addr_unit);
 
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
-		damon_update_region_access_rate(r, last_accessed, attrs);
-		return;
-	}
-
-	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed, attrs);
-
-	last_addr = sampling_addr;
+	accessed = damon_pa_young(sampling_addr);
+	damon_update_region_access_rate(r, accessed, attrs);
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
-- 
2.47.3

