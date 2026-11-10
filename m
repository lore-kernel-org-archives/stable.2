Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352245;
	b=Tp8SJqXouxkma2M32xrlE8W6NebuHaF9oTfjAE6v43SDL3FH6xKYhaN0zUIRxYDz+9L5
	 qJo2BJcA/UH10e5DN5KX+LKy1wMkrlDfeLz0wsaGeDKZnNus+sDNEsgoFCUmVGN7svQfr
	 Oa4NxbjzwZ+xXoZPfWTehNgKi1n2VZQf+U7JZxP1Z0duPPb0yvlMJ0Rv4y+6KfDDxgQo/
	 ibqT9QkgIL+WjNHH3zEWyQtdHD0WOO9csG9E8jEZDDaE/Qxjs9Pk+P0ldS9tjw32co3VE
	 7pmzNakFH7sHnLgQ/eUY7O/mrdYa4mhC0+VcRoWetWIApkA20f9vqRRUL9WaXgq98DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ok3n3s1PieUsRKr4lKqMJm3zdz4Lx3ky2IaLFteFDMc=;
	b=nQ0W690XDwoSnPfIarzgbjCUR/rVnSglP98XCc3VmKvqiKjySQAvJY5GxpqfkBNNZBYH
	 67SFh4WPwnJYSmvYyQnPpY0tzz2Mj6rQ8roOBff7wmlNjFBUyHGBNZJJg1tHR4O/s6oH0
	 faUX9NSv8b0A3N6g6hnDuyXKGtfQMy3nMyVs4mhGB3HiaPoCtSlcjPkdSoUVcwyVplkQF
	 dFTqRI1IsxTCS+yNP43U2c7el8wtCWTW6xLE2EA1bGfLkhG+pVDCr5cC79bCkQmuYe2uR
	 DK1iNO1pdNMDWs5zjCWfz5HYG0KUS4JpyQVv2kTZBlTY5R+scHdio1nZsXy8GGt6LZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuXy3QEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E7606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuXy3QEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8AE1F0093C;
	Tue, 10 Nov 2026 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352244;
	bh=ok3n3s1PieUsRKr4lKqMJm3zdz4Lx3ky2IaLFteFDMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RuXy3QEhGaYpSF47QE2JnMH1OIzvD4LH4Kicy8Rfgwba6iHhy3RdBwFR4fhoRajoi
	 ZY6RQHX2ouQSHInIm/1aHgDanJeCBMDezBjllaIEFb2GTDcBT+gGkIYboG3dd/dQxh
	 byXWK3i3m8oXCDMtK2Ji6XdHqw6YV0Tm5VrYcbVjuRuWuCfKP0S3zsv8kcBGLpFKJc
	 ibzkXsppP5FqfIpupOyAwOwTeBOO3Pn+gZ4bWMXmw98yppi08ywvXBVZhU7FhYiPA2
	 J/u7s92HEvmSHvDSL8ePGTjQ2YeyIlX28L51tFVIwGQJpWnXd/MpxDk9+bm0jMDpIg
	 o5wIUju4T9lfg==
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
Subject: [PATCH 5.15.y] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Tue, 10 Nov 2026 18:10:41 -0500
Message-ID: <20261110231006.82713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061139-failed-5.15-246c8cc33438@kernel.org>
References: <20261107061139-failed-5.15-246c8cc33438@kernel.org>
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
[ sashal: adjusted context for the pmd_young() check without the !pageout guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 367220e1fe52a..3079da08c19de 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -363,10 +363,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

