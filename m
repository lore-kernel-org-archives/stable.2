Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C7482D4;
	Wed,  9 Sep 2026 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931920; cv=none; b=ZTfNGPEO0zl6m6ODfIpj7W9R5bYvCgxZJP0tfwjFwK6BaqXezZqWVPuWERzlUdCCIAa/xN62Fv8Ji7P96wRVnva+pzngY7deMQOO/HTry/N7Lwp2QPBZhCze7iFtL3v8e1Rj6yHdieJzd4JG5kSH/tXfoXcuaayniwRU6+psmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931920; c=relaxed/simple;
	bh=cqdjiDTVIsx6IF8bjeZK+OtT1PMRLkdsl+pm2e3hleI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz2/MEFecRdstNSwd7DW3bsCFLlAm6eyT8W8d0Kpnf4+ixxZfmlyY0P/qVQPImWac57XPClo5bTv/kMYCcJpakOG9dpXblbuJ1XqlXipCUNVr70sjhLA1TKiBCYiYbQzGsZgZPVjr0IkO0AOGUyxzwltEInje3IovtFWhBPF06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2JtgsPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2JtgsPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A65C1F00A3A;
	Wed,  9 Sep 2026 05:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931919;
	bh=QN/fsFMxm8cPo+Tfo2o1aH0Vp6Rc2SCZ8s5U2niKkes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2JtgsPlmHw2EckbC6qdJIaZMsmOdcwlGFDgDJPSfCfMkzfDtI6aTTPK2cBB0KDhy
	 bK4hwYnj5Bc+ChlKLhGPjguWIsJ16MXHvye8tSpHHokSe+ZiTT0twk6k+w4XWfDYEN
	 lYyTFFj3FFOWg0M6wd8JjdfVXkQTA2rc0alwRZlgXsxvec8FecFM7me5m1pFSs5oOr
	 wT+NOd7VapDB9/PQ/Gzb9B79L1djLaa8CDSet9mXvz74rZgYn94zA8b1uY0yI0Q9Ks
	 E9/ICkHJty5zLokeF0zdsdPjWBDz1EajYHPKdFZccS68yKeujBQ1rnTWCSUxyZjmFo
	 dbc/SRUwZ+UxQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.2.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 22:31:51 -0700
Message-ID: <20260909053151.242944-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090851-hulk-tutor-8154@gregkh>
References: <2026090851-hulk-tutor-8154@gregkh>
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
index f7613ce279a24..b3507b1f62499 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -65,7 +65,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -74,7 +74,6 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 		return false;
 
 	accessed = damon_folio_young(folio);
-	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
 }
@@ -82,23 +81,12 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
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

