Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350834;
	b=nAcHZWwjiUaxuD9FSyuUdDglEJmfj/ZjmK7Zedd1jicEOB0He42QiC+6BKpNxBhUPHxC
	 j4nzhgd+BH1FOA4NxC63dLpk4Qc5ajDxbnFLsfQvhRKJI2vwqmCQ7LIlh0ySoA0+E5Com
	 MoNBeCW/adTSbUL2LsTEawYVXeNe4uw54Uj9Bdtyvwh7jfN+n48mLwpUN+1ojPnUAzM4t
	 zO9Lw+T949yczkOW3fFNB9TxYgpkh26aLw0/tR+uDO6hRR1zndBHzYNN8+4C3hmt4qV1v
	 FTyXJCki0D1gYzyNJXz9l/wNWT5hVQhzBDTT6FTFpHQ1hrno+kKD5uv2tILD4NAhg6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zWzERcXx19jQFlRJzHBmIdKsZ87oY2HndjwKvsnilsU=;
	b=mo/W+uNkU0JhREicfYnVIN0PaxX6qoIZ9fwfe5FkCn+6t/NR59I8rRwspfUmrlbsnggL
	 Y4scF3WYKYt5tkPoxl9Op2fO/iE5qKoPbdjN+kWCQJ2ROTvLMHYX4yiBHZF815bqk/YIX
	 dgJgwHMX2KK91zKe8N26YDtSuWAiqEFoqXNByPg5MWxtlxJtRr0ENDXJX95yj6JM+GFVy
	 u0JpNifBLfL2HSUtefH4Gbq3sqE76YnQI6MpG8FKKUZm1QtLH3XpdTHE/y/vsPOFS6pes
	 hGI0dgNC3M6l8seRJ5lIhBcwZgr5eTNTwDTMO4hX4z5lI9r00iZksLd2HSb5kBgI9KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9Ed1GoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B4606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9Ed1GoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69781F00A06;
	Tue, 10 Nov 2026 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350833;
	bh=zWzERcXx19jQFlRJzHBmIdKsZ87oY2HndjwKvsnilsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9Ed1GoN9eS1BCLDsGoZRexHtz4ITZq2F3td0BYJPqblh1pT57zSe09X2THPTPQ+g
	 9NpxyVkFbDhWdjcIDW7WbZ2ivzMHVEMv7TOvPYOPZEfgeWjJ7gbzG7i0UdzjY2vl8i
	 1Fv7OvVbmbBVzme5b8eybt2uBq99WSWSla4+sjvFDgzSx8KM7bcVgGNhOPjDBADEcT
	 VUPGcUDjKq55goFy73Pi8KrmLp/iuutV1UdmGvjqbkvDsy6N76oXDQ0P8wwJ81FUbo
	 BXBHoVdA/N5aoLXBnk9JiTa6/odArPVXA3+4hVdvdtnURFDgrS41SG84izZJ+/S6Qp
	 qUskspzuDykUw==
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
Subject: [PATCH 6.6.y 2/2] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Tue, 10 Nov 2026 17:47:09 -0500
Message-ID: <20261110224525.4066997-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110224525.4066997-1-sashal@kernel.org>
References: <20261107053858-failed-6.6-246c8cc33438@kernel.org>
 <20261110224525.4066997-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 7d3a9c4b993f0..d9f55db95a9b1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -404,10 +404,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.53.0

