Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552942;
	b=nNC8LNAI6DphODNPvZhHj7Av6FyrC5i6hCwEjzYFKJQbd8YaU5SN7lH7tCiz7vd6O5px
	 kJii4co9hYAkYhaW/aeShbikJORJDVPd9IpWDnUyLg49jZF2AdrviCVVyzTKkKhCW6mfw
	 uAvdtB8E5/jckZx/In8yRdiUCI3V8jVqiyKk083EJdn4CpBtpqvArDK+1ddx9nEt+ic/I
	 r/sD3W6a1m328LfPBFse7O9iAovwCw9TOczVgZ+BJ5sAs7jtOyft/v3PyKEsIWDsEqtUP
	 qlI2dpPKzZ2++9UiY+vaSwy8X/Sg7wU0TQ8QISuLjmJWdU1E+Gf0liB+MtKKj0z7zJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VUSPphQu9sh2ZMlytLnNygL6R6G6J+z7O+/PhhjF8AQ=;
	b=DCwFkrKpfmYZzZ2dLepLprQK8q2bI2u/bwtxhnWBFhotpngRXjcPBc/KNLrYoDDeaSCc
	 zh85e3VVYZ2jm9cpHHLPYNM3OEQSmz6qo3z6Xrrq13i+faCPEwIbX7G8E9gHy/U7GrBtg
	 t3T6fejjKYKTdqI1ixFEYAl2ZJdudzqJvUVY0e3CsttmKw203oXBq4mjvUdA0+jT61+Gj
	 L++s5CCEYUwCSL2qKgTgbQtKaQRUcpXl3Af5BquzYYRB2+E4bUd5JhwY/T0KiXEUYzakQ
	 6x/1ey1S7ogbIZYpHiqeVcF1gU07f5TxYshlw06LPpUkVJ7rI1o8WHmMbhNMDbXKIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=georcv9s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1EA606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=georcv9s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A91F000C0;
	Tue, 24 Nov 2026 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552942;
	bh=VUSPphQu9sh2ZMlytLnNygL6R6G6J+z7O+/PhhjF8AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=georcv9s+94nCV+MIaEETjivNCYcABCfqJVqD4RtPYcgUmInPtjRkH8AlvIyi83ie
	 MKXtzNsvPOHfEtW2g0xq7jsR3JMgADAdo5wXlQozMRVnDkt8dQ3UGwC8JIfz2Q1Pxd
	 4Rybg9MzJIhJ7aHbFIJy+f7pFSjxDlk14YGzqEB6Rqr/wKI/Y0roYlebVPODVakXWd
	 BDOBYoDB6zM7O84qv5y24N1GlS3XPL0N9bPre0YNugZeKTIZ2D4Rx6+3O/KQwoUlVN
	 jPpmFA2KcdVmQjZmhpsRytjldP8LYIke6kyn7APnKvoh1cs8EZsS9V+Li1x/yCw3Oo
	 kyjfNVQuolx9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 15:42:20 -0500
Message-ID: <20261124204036.2608507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112437-action-disregard-a0f7@gregkh>
References: <2026112437-action-disregard-a0f7@gregkh>
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
[ sashal: Backported to the older alloc_contig_pages() function, since the frozen-pages variant doesn't exist here, and the retry label and check were placed at the end of the function with no hugetlb escalation path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..c421d83b9448f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9479,13 +9479,20 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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
@@ -9509,6 +9516,9 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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

