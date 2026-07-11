Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC83CF210;
	Sat, 11 Jul 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793062; cv=none; b=PmGSHd4lcCSWXukQDLxZDokPB2/5O6xPf6XUENyCZstl89zs/vj8zajV8F3iwgYnze7qVzSMKdbQ+y/xQT2Gy1UFVBkk8huJn3+qovvb8uEUbKI27YErTk/tqlbfzg0SmaiuIuGAOwrSkKTfdMo4fgBJRhdYQlRinAB8qpJrg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793062; c=relaxed/simple;
	bh=5ScejZ7WR20mP7M32rQjyj8bSoc3hvLkckL0qcqy7ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQTIpp2ZqMqdgOq2JD/6Y5VjyWzj4LpHC5MTmX434b78olBVf4DTR7K2rfdnAfLmSfORxWfWsy2PjZ4WINkFeoX0UzXa/cIs7ANkKA0nmaIR4CjYi/FAc+R3S1LbE3gT2TktF6Wt7DWGT0nUWqh7FBZxxxDDpn5aZJ2teSfWNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MulPV6Al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MulPV6Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E7F1F00A3F;
	Sat, 11 Jul 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793061;
	bh=MTFa+hpzXfcfyF1zP3rvNz2Fhu2Cffg36gE6sioOaYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MulPV6Al7PdRkuMvExn0i9dIE8w1T9TdjXcHiU7mSLmr/ml12UAOwG/CZB/qATXyf
	 md+aw7JdFjco/wyrSPmUgbVnYVIWdagWPMgaEfYZH7g00f7zpaGKkeqC0yN5cBsRPy
	 gyiux1YnfWFwgb27qLWugO7JiIiU1fafzNMWASxfjhqEibw1QHZ0Y852PNflQhjisA
	 SizWI8fULFQ71nSX7XRNxjg5h6laM3HKdaG9E/i4esoKomDjNXO8/7KP2qAutjSFZx
	 64lvCUtBI4imnyFEDZUkaGEGvdN+oPYnCL3wVMgmxqeiRhPXxWmFw8SilDe3O2WfBn
	 eKOttvdn0SAOQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Sat, 11 Jul 2026 11:04:07 -0700
Message-ID: <20260711180409.82093-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711180409.82093-1-sj@kernel.org>
References: <20260711180409.82093-1-sj@kernel.org>
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
