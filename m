Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30722D0629;
	Wed,  9 Sep 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932753; cv=none; b=mDuNtS0IBdaLsiZo6DwpFtF2g3nS8LEssz7LnokCMqBpKTVVzDW9kN5nOJcNl4gnoaJ7Mari9zZwAo10uTv5tBVOaVNrQCOermsiYSUqbjTlpU2X0mnG+YGV1qPgmDGwgfQBufBcuEKqlDa1usrVcvSOVQwPRZRDKQ/6rF/9Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932753; c=relaxed/simple;
	bh=+Ntvqo5VgTjoCjzK4huuP39RIBos8WYYQMCqA86sTRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajW2jIKhDwvoc61ridDemMQMmP5wIXo5bbAEB/KwLDPX+9zpj2TnAIBLMqvrC4XLNEWRkQFOKCzAt0egmxiYlsoTF3EBL435k+prqmVACoUbNd0hYCi9p0QuAN6oPiq1ZccmNk0asOj+xqppkEdwgk1MogWCU9aNDq1YdDTts/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju41xhUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju41xhUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2A1F00A3D;
	Wed,  9 Sep 2026 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932752;
	bh=1zUjylR4pInp4Zxy7zo+b0LliqrTHsojfs2UoY9Fyos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ju41xhUr359Gdqpo8D3+sOGgfmtktMjZWKYlcDZq/HS/PNF74ZS+JyIYl9PURnCil
	 YrrHvKPAmATa1mUWO+2HZrpYdcLHOL1agfnRSDry7/OKA0jEUeDMq6ljo16S3etzOl
	 qoVwdbI1jzjuJUBzeXty00awW7q42zmQZFThrRU3HAcqBRNe1gNOzS4GlMilsROD8k
	 sXjhw+TqSbBWczI65FmvCtTFspUTefkSbnN3+XzQEzkYPkXq3xUHjaKfXEuw6PwDbB
	 YrAtMvP+Ula0BKairZ6xfTRuPBIjXVESjv/7FFQ6WiuTNbpul7p4R5+cVrAPOIZ8Vp
	 P4SyDTJfwVvQw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Tue,  8 Sep 2026 22:45:45 -0700
Message-ID: <20260909054545.256743-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090853-disparity-bazooka-4747@gregkh>
References: <2026090853-disparity-bazooka-4747@gregkh>
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
index 909db25efb35e..fe481ae64f37e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -111,7 +111,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return *accessed == false;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(unsigned long paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed = false;
@@ -143,30 +143,17 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 		folio_unlock(folio);
 
 out:
-	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
 }
 
 static void __damon_pa_check_access(struct damon_region *r)
 {
-	static unsigned long last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
-		if (last_accessed)
-			r->nr_accesses++;
-		return;
-	}
+	bool accessed;
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
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

