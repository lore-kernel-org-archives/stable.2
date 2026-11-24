Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554199;
	b=zpvs0AwzCiGrnnKf+zA334b6b9+ZUjdkbRJn36PrTNQ4RCSHxnvHFbtXNR7IfBtZhiIl
	 aJpHx2pOGmyuUJUfUzUqc2VkAW9K4gJB6H/V0L1B3Ejhd1RTCj2YEAn5Hc6Me99UbnFse
	 Q9U+XTgMTo+3N9CIUJAxJWqxCPSIFdWG1HKNfxZJp8U1IJ1lbJNVIKD0ka3CEQgg9P5k5
	 w4cE84+8NPjUaFRtK97fhX9cfrrtC81r3gpISWhdjthgTRCbHO+qpo+0Zmx2cincjQET8
	 QTlcRi8k7HJZBsC4wlV1wjstHsr/DG6tREPAUIMLjOinF8QA6TwzQOe8OgqZwk9D4Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554199;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P8s/qRNNDjxxOfHjEFCSCQRq6rE0IDpT83tOYMr8/ko=;
	b=0B29gof6ijpeC126qeru//cC8j8UBS7I6DplEhEFhe6NBKV3ysNKmbg1+IScinYKeoSb
	 uqsGHWr8bCK0XPyZtlYArPfPi+v0KvB9+TFCTeSLoIrS8kICH4d7OTkKpW7Sh8SOJRdsx
	 jJEEL8of06IgIlYyk1FNnrrXsJzzushjJttWXdq/2o0GRDYBLOY6kOomAmmPW+ySnw5ha
	 ug53LtktqCyvXN5hIiHViBPpifOWdqlntBfB8yOj7BdOaNGCzOWaqYxsDLrxWA0CJmdjG
	 CWpGcQbZkApHbqa9odFl3mP5yM2p1b0rGWqduvNnGqK2FbTjqPcCHWpG5GZG2fr5e/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKIglAb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F347606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKIglAb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E2B1F000C6;
	Tue, 24 Nov 2026 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554199;
	bh=P8s/qRNNDjxxOfHjEFCSCQRq6rE0IDpT83tOYMr8/ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oKIglAb4axKBIEj3Vebt80Bu39gFtbyL4MbzVLtrPiD/SDwHO2QgK+zk1Lo7iGjiV
	 w2SHkAydkd6EWG+R/dqve7Lffk5fnHzUpz4zfTL9Ov4PSgsqHQ45b8efPham3ojdZY
	 r2HgG8YxhflH53zd4Gnp6sSb0bv/NWviWEyQnvCZum9UGWN/hWd3YoqhTXJziBOycz
	 o3PkLAlFlpggL0xkfM1o4RjG7ha3l5SQaX/6QJuCIL8QGI8CpJqYUENvnvSeheOwkG
	 /WSxGfirUDThust1EJPPliDGt9Zc99ii5RUmZ9C4nxhsarJzxqZJ7eELDZWwcJBEMG
	 /U41CCrZ5U5uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 16:03:17 -0500
Message-ID: <20261124210249.2766164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112437-refutable-mundane-47fa@gregkh>
References: <2026112437-refutable-mundane-47fa@gregkh>
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
[ sashal: adapted to the older alloc_contig_pages() function, adding the retry label and moving the zonelist retry check to the end of the zone loop since there is no hugetlb skip pass. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..38cf6cb4f187b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9393,13 +9393,20 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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
@@ -9423,6 +9430,9 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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

