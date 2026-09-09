Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037732741B6;
	Wed,  9 Sep 2026 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932215; cv=none; b=Dy85TEU7INZFo9srUHEfUnC5wHsPt0hSWmNsiSMCcDY6EGorKOG7Z42LbbYCNufxQrPryKdHQaKbsU/g9nx8iOBmaJ0l1OlBuflR9KoCglOaWEgjkcr3+EoYqZpq/b5GzI8KEGcFgU61Nw2cOIlc7SYfEs27Hn9/PYaDghJmfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932215; c=relaxed/simple;
	bh=meZYhDMHSLUpipB4xXq7Qe/qjIDCkvPfEJqyVUAQLpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO2zQtyDWlrdgAnh3LCWPW56ocly9TzDjZ2lZhmtGiRL6Ui8qFzepdfnlnqtIqMsD72MVFxmwtFm8RkRmOHZ0ADo5GKvXR1JgCJb2sOq7PDaBcoOtK7HhV0a72RD0ndELIfqmlfH8Kl5gU6xZegOhZKC+dKYzD2wUrbOS0nuHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbkJ+Cmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbkJ+Cmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739FB1F00A3A;
	Wed,  9 Sep 2026 05:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932213;
	bh=2AOm50bQMj9mYuDoY76KPZ5AVhLteU2u0QZmZc9Q+6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbkJ+Cmc9jpu0kh3LuECJVI1w8ARWl5iEkBdohI9GVrZMnCEjlj/TrXAKqK2lFlJL
	 r3isNHskrazV1hcTIT96XWkVi88c5FnldkccX+F8v/8sqH+AQ+hkOxVyjhTi5OvH8K
	 4Ejk10bDdGm5IOv/S8vBMvZdWEIkF6175dM+8pLY8eeUrujiDOu8tasMaRvHIIhl4u
	 Ykjk8cE76E3vORYd6EdZFqQssO6IAkRR661NS25OF6Y6sb7C0o5K3tRnPNrTbO+kh6
	 RLwmaJrRFNsMESOKJbWGXjv6O3OzHHifXPsKoHvRbKI7U+k3Zj0GV33zD7yEdmtb0t
	 A8I1iFeVpqu8A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 22:36:46 -0700
Message-ID: <20260909053646.245843-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090852-morally-preview-efa5@gregkh>
References: <2026090852-morally-preview-efa5@gregkh>
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
index d4a4d51750f5f..a6b1de97b1e8a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -148,7 +148,7 @@ static bool damon_folio_young(struct folio *folio)
 	return accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(unsigned long paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -157,7 +157,6 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 		return false;
 
 	accessed = damon_folio_young(folio);
-	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
 }
@@ -165,21 +164,10 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 static void __damon_pa_check_access(struct damon_region *r,
 		struct damon_attrs *attrs)
 {
-	static unsigned long last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
-		damon_update_region_access_rate(r, last_accessed, attrs);
-		return;
-	}
-
-	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed, attrs);
+	bool accessed;
 
-	last_addr = r->sampling_addr;
+	accessed = damon_pa_young(r->sampling_addr);
+	damon_update_region_access_rate(r, accessed, attrs);
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
-- 
2.47.3

