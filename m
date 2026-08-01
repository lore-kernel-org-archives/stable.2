Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C93B5F5D;
	Sat,  1 Aug 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605767; cv=none; b=VeswkmxhXc3jpiMOvbQEyH9R00SnYh/daW9h7ZKLo9uF9RKhjEWvLdmxIzC7kzHvhssAqMRCS6V/beymK6bT6WC2FfZyhHpBRfKRG6wkVnVfoHp1f771lbtqx7JXCkc07X3TXYtUUbpY561mQL3akJx4i0lx541hP23uDWYsvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605767; c=relaxed/simple;
	bh=MjjB5G5ZYPHAN6OhRBUuLe8e8C+NqQJVFFYrSfVVLuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5tSobJ0yAanePmhsUj6VShQD9ejjby0H70Rg0QDYDy41lBOWyVUNA0GQtW968sN/SFCa+twe1qHWUDBf72ojeEPAH/Lumgqm4yHJwIds8Ja4F2cZHVV7khPNPuUWhOUgpbT4OwsK6wn7zSbd3DDIebXWx/vc0m+pZiiTsp8Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXIkgE/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXIkgE/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC44B1F00ACA;
	Sat,  1 Aug 2026 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605766;
	bh=3oTPCb+uFC9gTUspvXroRLy6myVSMRGtc9G75nT2wA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXIkgE/Phl2spAH+TaSyI40fQBmMzX+oWb52mHp0kJwWim/1mkUMIhuNY3V/tcF4T
	 3lrnLEjOjMIzN+DEJCrxS63rvxgnAFvnp+czaAxMnIlaBlnsVyP/s48I/+TVepo2ih
	 xkyv+OJGUoj3WRZgbkWJE/4YcaadqkZE1OO0VSaQUliAUFiLnT9kLzXJVgr3E6yOlr
	 CK+624jhDvtzDVMHTTEPAjynRHIBdZ8e3R+uH3ZxhjcIEOwZsMZOaLXDV9Z4485Fje
	 L2VHQaKUn0NUwhwQT+le12y4kzL7auhIjShTi37pPhVGiVmA52INz2J2p4NYhCtGbY
	 dWlU81TwvsVzQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/9] mm/damon/vaddr: respect folio end for DAMOS_STAT
Date: Sat,  1 Aug 2026 10:35:48 -0700
Message-ID: <20260801173554.94710-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801173554.94710-1-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For applying DAMOS_STAT action to a region, DAMON virtual address space
operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
filters to folios of addresses of the region in the pmd.  It starts from
the walking address and advances the address by the size of the folio of
the address until it goes out of the pmd or the region.

Let's suppose it is for the first pmd of the region, and the region
start address is in the middle of a large folio.  Also, the next folios
are small.  Then, some of the next folios could be skipped.  Fix the
issue by advancing the address to exactly the start address of the next
folio.

The user impact is that the DAMOS_STAT-based page level monitoring
results become inaccurate.  Since the page level monitoring is supposed
to provide relatively high precision, this is definitely a problem.  It
is arguably not critical since it is only monitoring quality
degradation.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org

Fixes: 63f39737d1e3 ("mm/damon/vaddr: support stat-purpose DAMOS filters")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65b..035cd509f6b58 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -831,6 +831,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return 0;
 
 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		unsigned long page_idx;
+
 		nr = 1;
 		ptent = ptep_get(pte);
 
@@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
 			*sz_filter_passed += folio_size(folio);
-		nr = folio_nr_pages(folio);
+		page_idx = folio_page_idx(folio, pte_page(*pte));
+		nr = folio_nr_pages(folio) - page_idx;
 		s->last_applied = folio;
 	}
 	pte_unmap_unlock(start_pte, ptl);
-- 
2.47.3
