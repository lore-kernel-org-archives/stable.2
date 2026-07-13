Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E720438007;
	Mon, 13 Jul 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951129; cv=none; b=E6DXqK+D6L1W86Vak/JeFR8lQq07QMH0Hco5uW/Xwzcz/2Zm5pVCFKMyCbbmUsOyymiW45cTfPVD3wPywqG5+yD6UoyBowuMhz/WKqahK063OJxU+eLCfQKux3/WXf39RCcWOg8Yt7axN9ouEgOe5M4eTC3zver4aSPUJuz0PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951129; c=relaxed/simple;
	bh=5ScejZ7WR20mP7M32rQjyj8bSoc3hvLkckL0qcqy7ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj2uGeA0S8ZDCbZPwbhraYqmxKnJK34LbJSdOPIZrt8Nc8kVZ6lXssvu4aNHRps7IAwS3SFFBVwNYHj0YRGDia2qVR3YShLEfzm5wLfVh6AHise+WyNGCWxg0+7zbAcETBmTSjShM1S+ClAsUFN/i20cnDMdR3BwsqGWii8KEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K198PuNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K198PuNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513471F000E9;
	Mon, 13 Jul 2026 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951127;
	bh=MTFa+hpzXfcfyF1zP3rvNz2Fhu2Cffg36gE6sioOaYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K198PuNm525azO9JOEGv+kYtKZf9GL5saEoMnfwLfy+QoVvf3M61SFFj9Ca/kvdOi
	 VNY6nNIHsGF9lg6m6lqNuukfbHXvnSjaHO9YU6+vcHqg9ZdMcecBXajrDGxgE/s2g4
	 l0Wt/AKMPXEfe93V9qTx55JGD7KTaF8fpcH+sjIBHom4GIVw4m0pnTJMdiz9Tu3W3n
	 gTdjeVBMURLeaBsAeoG7+hfOfpXTA/PkLpa40PYH/h1vpDWwT4A2sPxsSgny4eCYQE
	 iR6FlfA4UqD/vJnw7VcrrLV9Dr82Gl6cOq7kSKZwgg8bJwCf+62WBbXPZgrqMDDbW1
	 rPBXT5uQWgmYA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 4/5] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Mon, 13 Jul 2026 06:58:35 -0700
Message-ID: <20260713135838.32730-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713135838.32730-1-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
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

[1] https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org

Fixes: a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b85f88a7a38f4..e4f98d67461f5 100644
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
 		unsigned long addr_unit)
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
-		damon_update_region_access_rate(r, last_accessed);
-		return;
-	}
-
-	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed);
-
-	last_addr = sampling_addr;
+	accessed = damon_pa_young(sampling_addr);
+	damon_update_region_access_rate(r, accessed);
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
-- 
2.47.3
