Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E201397935;
	Sun,  2 Aug 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688002; cv=none; b=XRxim429C0pozWs3mdTUeZiicZZn7YnyDJ+Yd9ac7hRW7To6dCLbnvsFOhDKix1xWbLBLzrLBJumj4rjCEavl/efIECy+t4XbiH7vh3Pxu0afZfWZ51HAU+OfN2ZJGU873UgLQeAugVmaCIuZvkIQDCcjvHXw32LMjD8Jqbdul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688002; c=relaxed/simple;
	bh=35/yin/QF8t3Kqfg+UAOrsmVX85pqU2Iyl2wuXO5t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6XaYW73kIsTuM1BCb0g/kVGyvr7reyJrXpQbnV8Yh6SwC4qx7V0bE5Q/VoWqVAMsTXE4tHqaGCG/YywPmNdyLB3E8o6/I7DHZg22mGryHih5DTVE3PzT7D5ydVO26S9WJ6wuCD+aQeUJEyeqO0LSKMvhQCExJbYLD+Sl4fwE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHl/VqGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHl/VqGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC21F00A3F;
	Sun,  2 Aug 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688001;
	bh=7ZB1yfEGzN5K33ID0e3bcOFkHhvifJ8hhhrNtAvrugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHl/VqGkYNrEF4AO5DDxQ8DZfWi/AR93VaCva3l+Wy7MW7g4dJuamnqSK2IrNQR3d
	 mk+XX0FUD2ENVKg7Xw6ZxplyfcPHPOKLobCgogY++kAhAgerrD9ne0SefX2YyQ4Dfc
	 8mdlsVJk1k0ABP/qkua8MIV2pQlHi8vaAstL+T6m8ECNCbHoV9f9dPatlqFEU2XpXu
	 ZrmQrbKn8fxtBYcayBzu/pPO6EkhLsVvII8W6evH5M/zMUgtRaFb/1uPpN65lPN+tc
	 M5eK0YF5Bapurtf0gvcKTMe6UupNIEODebDhMu6bGLOyo0h6OllJIFgl1n7Ak0Xx6n
	 0bqbXqYgwZX7Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 3/9] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Sun,  2 Aug 2026 09:26:24 -0700
Message-ID: <20260802162631.90304-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function for applying DAMOS_STAT in DAMON physical address space
operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
folios of the given region.  For that, it gets folios of addresses in
the region.  It starts from the region start address and advances the
address by the size of the folio of the address until it goes out of the
region.  If the start address is in the middle of a large folio, and if
the next folios are small, some of the next folios could be skipped. Fix
the issue by advancing the address to exactly the start address of the
next folio.

The user impact is that the DAMOS_STAT-based page level monitoring
results become inaccurate.  Since the page level monitoring is supposed
to provide relatively high precision, this is definitely a problem.  It
is arguably not critical since it is only monitoring quality
degradation.

Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address range by folio size")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0b..2ab7b3842701e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 
 		if (!damos_pa_filter_out(s, folio))
 			*sz_filter_passed += folio_size(folio) / addr_unit;
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	s->last_applied = folio;
-- 
2.47.3
