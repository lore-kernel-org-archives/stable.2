Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352582;
	b=Wu0a7YddUdxWe4BQ8yVniKcm+G/gVsdLCU7xn/FkRZwa7uNPvRz828jEZPXt3A8sldBf
	 ETDyiUSssfHamks9/yXcP532Fbtfoj8h6tMLHEx2tEovaUI8WWIro4pI4yJ/q32upcHKd
	 0AkJxvgN68EGgYS91HRzEqgl8CSJPNOorPWrE3VWfVJM1fjukO7LepVRvhhp9drSs2c/Y
	 KaDh77EV0O6r5DwrhFqO6dK2Uc+nGTIXdVxPn1OYuAbhDyuTNMfqAdZf0jI8r6ERF6Jos
	 jGNJmzmJrmEcgbjkxyY/BMTp+av+jdJmWJbicRIfB8PZhM679o8O12OrqWMHtR18jlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352582;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7WZ6GgebBSZw+KH5U75Tle8HwjkyXjZ30DxWw9ZUVPs=;
	b=1QCGmdsFEEhlv5Br8m7pxRrHAFzI8bRlZQTpvHlXtw9Ha2AEySh+8+gXyWt1n2fvwgj+
	 sL+SWnLAifZrHbes1iiDETpaVI0tbNhkXGXuNQIKpsLofoXND7glLnKIEyXMJ41Sld+eR
	 D8XQvzWfg4Y5j1+HzhPNT5SdRnxqq7E6iuzJ6x6u41qzAXVn4XnPe+c8+mBOQEzxSX0xm
	 /aR51nkah/6m9hRnwm8VftjmuiUHl++7MnyKc1Ye7wXtPVYLfO0Oad6BJNyVAbPb37Qd3
	 7nL0RU69RWrLGiwLRN5K5Ji6f1cEb47/xuNRJiiu9EVXCXhq6uzE8absT20DUCwdamw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5tSti0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA59606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5tSti0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A191F0093C;
	Tue, 10 Nov 2026 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352581;
	bh=7WZ6GgebBSZw+KH5U75Tle8HwjkyXjZ30DxWw9ZUVPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5tSti0K/EFJiMWOGnxA7qwCdi3oeEKhUq7rBxZniW9keMsEaUUeqxMdOIE0gOzoG
	 YzQfjmgy4wXABNOx42dZlzBwCQ4i+E31HO+WF9ZdFvSgwpAU2csMHSEKWJlTro8fFF
	 5/5Rwl2BSQR2XS3vQ71RQ1c48RBONB9rv+87LDefe/+b+X/KGP+rNxTgeLo1Mavr+9
	 NGID8qGMPpAH1kuMd6F5J163bw6Bd7i/DrFknnXFNPYalGuKV/NC6K2sEZaoXIGZSL
	 nY0qvzzW3zZCwJaeVwHHJbLHYxTZ8cwT5HJu671fKm7sn5HGtoWqC2mKiK8tFE6s3l
	 LafWh9iIHONFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samarth Narang <samarth.colleges@gmail.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Tue, 10 Nov 2026 18:16:18 -0500
Message-ID: <20261110231348.99755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062842-failed-5.10-246c8cc33438@kernel.org>
References: <20261107062842-failed-5.10-246c8cc33438@kernel.org>
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

From: Pedro Falcato <pfalcato@suse.de>

[ Upstream commit 246c8cc33438a71c28f9b86baa492d9a0a130316 ]

As-is, madvise_cold_or_pageout_pte_range() discards the hardware young bit
by invalidating the PMD, doing pmd_mkold() and subsequently writing to the
pmd again.  However, it does so in a racy manner, looking at a
possibly-stale snapshot.  It's entirely possible that a write elsewhere
set the hardware D bit, which this logic now loses.

Fix it by using pmdp_test_and_clear_young().  This is an atomic
modification of the PMD entry, and thus safe against any possible racing
writes.  As a (nice) side-effect, this elides one non-required TLB flush
in pmdp_invalidate().

This bug can interact with the swapping system in complicated ways,
leading to data loss.  For instance, if a folio is marked lazyfree, but
was later read from, and then MADV_COLD'd while racing a write to that
same THP, dropping the dirty bit may lead to data loss as
reclaim/MADV_PAGEOUT drops the "clean" anon folio:

T0                                T1
================================================================
MADV_FREE(thp)			|
  folio marked lazyfree		|
read(thp)			|
  PMD marked young by hardware	|
				| MADV_COLD(thp)
write(thp)			|   if (pmd_young(pmd)) {
  PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
MADV_PAGEOUT/reclaim		|
  dirty bit may or may not be   |
  set				|
    reclaim/pageout may drop    |
    the folio			|

Link: https://lore.kernel.org/20261013191719.95502-1-pfalcato@suse.de
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context because the pmd_young() check lacks the !pageout guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8b6ed35c1d265..ad33cdbf27a88 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -361,10 +361,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.53.0

