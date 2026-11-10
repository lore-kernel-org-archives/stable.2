Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351866;
	b=kjzsd7lqbHPxxNT8Az9U+U7RS+oScpA2Zv5xpwNr9F90A9dJCrNjzurUEi/np02RbIiR
	 h3aYEHAJYr+HXvYXx+AGuUN8h0WKYg+LkLK+Qpl/f/GR1amMjKiSWr0YaWoMW1HCUdHVT
	 aG8CWLCoaMrymEZRQweLFcnD4NhTfm+OO8tcQ7HDDskDU0PNC2VJpFM50Vcz2nfWkH7JA
	 eLjPo8nqS9mUOlYfHuwPdn9U1ArxosaH3THleGgNox0TyDsREEd8vZQ7MDntieo4XQMUg
	 VFaZAbS7VsSF2fJoqgVnEYah2KLky5GsOCSisRNXaTavVSNZC4Qr9xq84O+yGy2eamg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ptbrXyjXjn9ybewZ72JuSBgD9Xkgj7iYAbI+rx4WeLM=;
	b=zSuPmqRrcKIaL3MPO9wl/DsoKT3RUUuhKfZeIjpzfYtrJvjZQKQ9x2aOXt9Fzr26s8Kh
	 HP73q8eHuC68ERGF60+eyXNAApUNtwvm18IRRv8DGHt3UJxipUninL0+6qoT/cn7rkD5l
	 QKDH5Ebyq7S2zWJD+GN4q7V1CT9utJYVC5nm6NJcj8VBRsoOFSYZUEHuyJLYHW2gZuVGZ
	 fDjeucug6oPXWuejejEAMtxgvizm+U2Eue00QGJ/dTyQbYTLLeWKFpWeMKLld1gNeH9rG
	 zEH2n+x4pl4zTCj1KH5UYx696Kiy0AkMxLm0pY91scdbb/ypv2AoqizLMOkBf96Z08Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDLcMZu2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDLcMZu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F41D1F0093C;
	Tue, 10 Nov 2026 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351866;
	bh=ptbrXyjXjn9ybewZ72JuSBgD9Xkgj7iYAbI+rx4WeLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDLcMZu2CBq7qx60kUT9HTr7OWAWwqC75wECD2mA+G5W6/XuiADzQR6smjUBqyRXw
	 /Of4yvmCKHT03VAyXWTdbyMuU/e0abCIu00BEshgEObxtqKlI3fkSoMTPa6G8t17U/
	 X+h3tqbYIBGiRbdar0ykxFJ13kNoBN0fO9GWJogTvA3AGoDLybhV24ojTWfoO36TV7
	 dioh8l/1FajBLtxavwQr5X972yFeIW5OXYjMNLd/hncCdFC2iKt+XsS9yxcJQE0Tel
	 mfsKppSM4oMma8ilZGsbHClTJX8H3fyRVoPbHuC9Vyxq+qiRLpjC2V3LZvwMpyY1jH
	 PwyKz73eq8RNw==
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
Subject: [PATCH 6.1.y] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Tue, 10 Nov 2026 18:04:23 -0500
Message-ID: <20261110230356.8288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055439-failed-6.1-246c8cc33438@kernel.org>
References: <20261107055439-failed-6.1-246c8cc33438@kernel.org>
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
[ sashal: Retained pmd_young(orig_pmd) without the !pageout guard because the corresponding reclaim optimization is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b271cc1b48edb..5640bacba5384 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -379,10 +379,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

