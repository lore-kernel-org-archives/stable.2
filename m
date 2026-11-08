Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167514;
	b=VtJ7KETII5s01b9SMkq3PX91C1gjOf6NZwpn7PwJElseF2ixiDcgFVw3L2Rqa8GC/CSi
	 dakARKeq/1PZO0AWIK6tAlKRnzPGfRcsZ3lcauuYxmvHlIPyiZnq95e/GcEvT8hbqXIbT
	 nuca9zg9s7aIdmPSCzhUPMcxTavZhx/gCVYmarLTm52W2gq5sfbczOcdG0wdnHC5H/ZHb
	 qehfk+duxaEpq1Pk+Of48nAfF2m9g2L2GG2tn14uGvrULBmGn6v1fOV7mUVrC3Pkeq4Ex
	 prs7Edh2XxcCyIuh0zik7ZyLsda9Ohu8HHzog9RZs5AivagxNIMGJbDuT0/KhKJK5oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WPf2icVK/e9KPEuHFkG431PIxwdSKi/zxFeSHw01Gc8=;
	b=Ubc2ty4VrGWHi/jEdqWYNczQJE88IQYjOhZC516ca1pqVKLcmUdkLRLnwRxaWmS78D5u
	 Agn9BluZShnVd4iZqa9JWT6NzB/vF8aFodidUFK4cgINA72L+Kx+sGBymK9VHH9RFgnGz
	 8nDuQ1I5lU0Shik/t8urCMHQp8AlobCoQTIxNmgpIbGqdBHykzQpCVDjvSybkiGcUjSNZ
	 jdmkQDz+1K72lExnLv+9huLl+UxHn47N+2Vzd4YuQhfFRQCImCme6qFvNm/UC5BL77TBH
	 qbkJcclkGiJCifQCBZkSjSpmCuTuydiyHWee6ASj6s/9ozomy0dqBZr1URnToxykSpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeyY2b0U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BC606A332;
	Sun,  8 Nov 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeyY2b0U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E021B1F008A3;
	Sun,  8 Nov 2026 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167514;
	bh=WPf2icVK/e9KPEuHFkG431PIxwdSKi/zxFeSHw01Gc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aeyY2b0U+pVvzfaEu7crV5Q638Y6kIWS973xwV4XFRmGvJloYgfALxwwnftPYNWAz
	 d8EGZM2evKBPjgNjn+aTz898OjjvLMz4E4arzIekSwelFlp+F85rrR5bQjgO8xz2WU
	 VpJwSR6o8QzW3XZRNuzZ6aM7S0t4z4tfj1noDvDNZ9gClfV1oV+3VnVWQCNXwlzNTL
	 PmZp/8LSUaHpTFdX4jBqrovLJyIdObNTZJB4o4kFCi/jzVFA3IK77vOJYz0iRHthlw
	 fLcS/12S41EFbZzTGYkspxL+zkyDiQKRkvhMD2mF3cVIpua/bpcJHokGTdr0NO5wUI
	 qC1tPjt1wMLSg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 2/5] mm/damon/paddr: respect folio end for DAMOS actions except STAT
Date: Sun,  8 Nov 2026 11:51:41 -0800
Message-ID: <20261108195145.115792-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108195145.115792-1-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few functions for applying DAMOS actions including pageout, lru_[de]prio
and migrate_{hot,cold} in DAMON physical address space operation set
(paddr) collect folios of the given region by getting the folios of
region-internal addresses.  Then, those functions apply the action to the
collected folios at once.  The collection starts from the region start
address and advances the address by the size of the folio of the address
until it goes out of the region.  If the start address is in the middle of
a large folio, and if the next folios are small, some of the next folios
could be skipped.  Fix the issue by advancing the address to exactly the
start address of the next folio.

The user impact is that DAMOS action is applied to less than expected
amount of memory.  Given the best effort nature of DAMON, it is no big
problem, but it is clearly a bug that is better to be fixed.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260901131850.98037-4-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio even for tail pages")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 6.15.x
(cherry picked from commit 1613ac9edf385c35f171a25610e2706a7e6afad6)
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a6b1de97b1e8a..6bac269cd679e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -273,7 +273,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -306,7 +306,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -483,7 +483,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
-- 
2.47.3
