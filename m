Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554413;
	b=ViQneovvnIQCok3H2usZjbgRj5SwjxVpwRSeL8MqcPcWTLgk5RcHCSs7InnqwSec8/33
	 uEWSQpZ8ocbpNMIEjxUZ9IeC+O5zU3z+Nx6SaeehFxiid0ncHYV4KwJqtXCQJTxJUQ2Kf
	 3F/RpKMjG/pW172HobSvEQCHxelRHmVnafBbomcqfYviF76tKwSXxPiBDZqIu/OmaasdN
	 MKAzTCdJOFAOUcn4QZ8ejfLe02xesMYTYDnueOfEko0y/qt7UGWgUxPqPCbX50ukNtrdM
	 CFErYfnnaMub684vf0toQr7IxVg1uks7yur30pZEIZyzCOZ0A9qqY03c5Xpl/Eq3Z/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=igEDLqJs1lY4ymFYtJbX6m3GzmKEag0pX/sN7r4i0cQ=;
	b=g/yPogFGdMpyHYxd4+ApJw2xaYXcdl3H3+jL0jy/2IzxO0FlGl4+xYWESQvgwPez8zZb
	 ZdRvVd4EF1ehHZ43IqcprZ/9gL01XXMp+F12FD7gSJNI1JHSAKlpprkoUHcKTv1hAAOVx
	 XzfmOir5H0YhgRwtFaqxankD+OGXwj/IB+bzORxJXRDBV0+COP8klFL1peatcYjhTrtKX
	 ZCaW6ib+E562JacXSeqnAPrzs+qa6jQgTHOZoO2t0461RawLonHU9WGllqXEH0/GTBwTN
	 Kx/j/4p4Ymb/xlHEh6Z/u67YiOFGMnqJXHv5kihk720mEqZiFr4T7BZV3G+0f4ajL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFdr6+RY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76F606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFdr6+RY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0041F000D3;
	Tue, 24 Nov 2026 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554412;
	bh=igEDLqJs1lY4ymFYtJbX6m3GzmKEag0pX/sN7r4i0cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFdr6+RY+CF3WMjMrgiI/WXr29htRtMqbVzX1MJ2SHLxIRp+iweCYCPs/nBsXMCdh
	 JvUsNBM333MAiheZndgr9quZgDGZLOnKtNrCEZWh5IcvmFXVJwprTKhtUelUVaVuU+
	 vZwsId5vA/FxYgzu2PT6hT3u/v4q66LrSztVDvQYVAdhvI/mUftJDNrNh8i46Ca7py
	 CVtKM8/HDDpiud93kFrjbdH6riYm4Tp2i8H2xYhXq3ZtbaZ2/gG3vRbug3fKGbzOss
	 rLAqo0/70VugFHFrNFEp9JRqyt8I87f/E8v4p13KXmT29nlV6+6iNAHsXPDkge30JD
	 lmBcWHfnKPV9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 16:06:49 -0500
Message-ID: <20261124210619.2796779-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112438-underwent-easiness-72c6@gregkh>
References: <2026112438-underwent-easiness-72c6@gregkh>
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
[ sashal: adapted the retry logic into the older alloc_contig_pages() function, adding a retry label at the top of the zonelist loop and omitting the skip_hugetlb handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb0614988479a..ed416869a1b59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8811,13 +8811,20 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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
@@ -8841,6 +8848,9 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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

