Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551924;
	b=wH1tnRtcf6tqIJf2szT2FFjxU0X7CegWBakHHasegF8i9g/lSv0KYlAqhNxpIUJWT/JI
	 LsNrVBJTzt6fr8pDG4YiFQZ+RstcLr/qdmoLIB2Ozlq1oJxVa2mzTAc50Har/5r8ysa2o
	 LrZLLES8cQtTQPaK9syMiIjFym7bJ+3oFfvXKUWFkKELMBFGueu894TrI3OXpLsWvJyCU
	 sBQqgg9Tv5jav86q36hK1KJh6mO2N8auIHhxOzLDNY9bnkI1/6Z/wUhuaxv6Q0OmbHQcw
	 X4JcwMEqU375cpTgEWOc3uTeV/Od9PYWzX78rIC/VHnFZdKPNdJVmVVpEm4BasIr3YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nETtC1uzCtaB0VB0DBLZInUOHEh/gjIE+RllwKVAMM4=;
	b=PkHQn7QetKTzRL1Yhyxg/H6X9evil4g1cYZNWE/+JTdYP5/1cGbh92gvRWgZLWYfZvh5
	 4TdwxIQe3+PJfJ5rkIGoCfSqDnhAVK9jB5zOoA7v96gs9ojMWskkzHKOaL0/tPvfl3NH5
	 4frlF95RSsdyM3K/284/Lhco4T1KUg2BKHflIj4MSXYMsd5s1I9kvrpyA3DzrWT4fi7c9
	 CHgHAjkQz5Lu21iz6ghccjgRwWmx3DrsxseP9M1s7jMxoMR6hh1nZzC71uXYQdwesGSqh
	 DDiHwJisJU/nFXRT+VzwwgSnl15iJCken2gqrPx247klpZLGsMYl+HFhCDRvwE9N+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARmvTKx5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CFE606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARmvTKx5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3201C1F000CF;
	Tue, 24 Nov 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551923;
	bh=nETtC1uzCtaB0VB0DBLZInUOHEh/gjIE+RllwKVAMM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARmvTKx5PyNTB6x6VO5txSSZ6coIJrFhAttVK4/1EASxfHpviM7MNZuT3/huxNDPL
	 kJsqTL3QAhZGOKt4xhmA2bKb400ozlVhv0Mf1WjP0e0ZvWGI1Rs1+uf8tYUI9ENSql
	 ElNgDi2E5jZVqR7fvjy16iZnAe570aAXfQY79y5yhLiLRxnyff/ixmylwh+Qq2Xy+E
	 uazc/PlLwBpW+PgLMPlukQXkIBAp54Ah4Z8pl0PCB958aFPm+FOOlukeYwFXsP159B
	 8jzWjhRmEQSw0C2S0An+Zsru3eLA1+SHR6DbkSdrCPawU/EXPe+O20wrphIaVX5H6S
	 /I/OD5VgMpj0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 15:25:22 -0500
Message-ID: <20261124202452.2588099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112436-anthem-overfill-0e2d@gregkh>
References: <2026112436-anthem-overfill-0e2d@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit da0d7a895e9021dc2cffa90fb6fafd8b9379e544 ]

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.
alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
and nodemask, then loads the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
caller can get a range from another node.  Gigantic pages are kept out
of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
non-migrateable gigantic pages from movable zones").

Check zonelist_update_seq before using each zone, and restart the walk
if it changed, as the hugetlb pool walk does.  Check again before
escalating to the pass that may migrate hugetlb pages, so a pass a
rebuild cut short is redone rather than escalated.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
{2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
and neither with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-11-gourry@gourry.net
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Ported the zonelist-retry fix to alloc_contig_pages(), adding a retry: label and placing the final recheck before return NULL, since the HugeTLB escalation logic is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50cb81d42b1c0..0c7aaf7c068f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6415,13 +6415,20 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 				int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
 
+retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -6445,6 +6452,9 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
+	/* Redo a pass that a rebuild cut short. */
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	return NULL;
 }
 #endif /* CONFIG_CONTIG_ALLOC */
-- 
2.53.0

