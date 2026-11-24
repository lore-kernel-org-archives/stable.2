Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554701;
	b=c2PYsOAvuRjpW3Nv/dgOjqyVb76IYsAstVurSOhmK1wlyVaxpTkFcxZfM9DRMBuyPN/U
	 Rj2+r6ZTnAuXwkSt0kl58HNlbp7WbXbN2rl7VGJtZHo2T+foGIw/yGB+w0ei7I2k3wOxj
	 bgyweNcxBUHTmjZcIqlsnzKThzeBBgGse15m/8KnAZhC9V9IX9rq433WB6nBYMC0XvyP2
	 DkUrq098ZLEaRg8G+swnyK7cL7+anv2j0f5AEF2Nvwd3vIxpUqVjoOHl9GDI4vYUHGrKh
	 i/8RfEstREARKvtMIDQA/AxJZMlEBQrUTWehyEacTyNNdytBvH7bwfIx1Uyj5o16AYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kHgrs1fDqGG3Oo8XEs7ixeT1LTVzrf/0eBuVOCVxGr0=;
	b=kNS0O/k7c7cCUl0rM69KwQrX7JXo3LPNaOv4QmOWsnP4L39plXoshosUj+FQemXtbANJ
	 aWg/u12wTrYqzhxNchmyJIN58DGxKAbwB7XN91SD6WJgPjNyNQSi/dj1LHaizirQ2sj57
	 UK2IPvyagxGqB9xUJFnCBlgaQ1bTSH7i4SL9OmoUIdOhc3G5FKpeFaSTpPod1+sDbPG50
	 lKDqzuC4ircA7XnC1K44pdOa+dfDB17+IS60UaYnboGElEj26YCYEM1M7kUnjzs+Bdq93
	 9p6KdBjQbQVHqw1XpX3n/beJF4VSdo1Qtdo64WDQ80JTFVLTbThE6jW13hmS2AUfXCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olU+SWW4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olU+SWW4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF61F000C6;
	Tue, 24 Nov 2026 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554701;
	bh=kHgrs1fDqGG3Oo8XEs7ixeT1LTVzrf/0eBuVOCVxGr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olU+SWW4uBq9ZR+zhkpTgaZT6MhHF6DYxi+63IyisuHSN3etWeDyVFK9xMKdGUj5m
	 2RFTU7+LnQ7ZCkbQDy0gOrrKfqTfIJs3/3j6kl4FlCRxO4bQD/1uVd2bIDvGEEhXUz
	 C4p4qI/GplFjfI/ojT6EdTXE9IuiXeVDkA7Trm0XKSDsX7G5XTldosW/uMLQGHbEe2
	 LjDRzdDxzzmR1HYu4cSAegiSmDOGO8D6WY32SbMXukieGv8Mcm0FIP6zs26jL1v9dZ
	 VnyjAKx7YoAHCUgNMuSe14AaD1ilG9ENUXod1pZ7zoWTEaBbdwec1PihRBd4JT/LC9
	 l3LRPXywgoqwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 16:11:39 -0500
Message-ID: <20261124211125.2802662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-baboon-aliens-a6db@gregkh>
References: <2026112410-baboon-aliens-a6db@gregkh>
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

From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>

[ Upstream commit 2122887b04f3f2d76daa80055c2c273926032fa0 ]

Whenever the flags of a pageblock are read or written, a kernel with
CONFIG_DEBUG_VM makes sure that the pfn lies within the zone of the page.
Unlike bad_range(), that check reads zone->zone_start_pfn and
zone->spanned_pages without zone->span_seqlock.

Memory hotplug changes the two fields one after the other. If the lower
end of a zone moves, the zone seems to end before its last pages in
between. A page of that part which is freed at that moment, on another
CPU, ends in

  page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
  kernel BUG at mm/page_alloc.c:372!
   free_unref_folios+0x55e/0xed0
   folios_put_refs+0x2b5/0x530

An attempt has been made [1] to fix this with the span seqlock check.
But that can trigger all sorts of problems in restricted contexts, as
noted by sashiko [2].

Since this is just a sanity debug check and anything with BUG_ON is
frowned upon anyway, just remove it altogether.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/all/20261027-pgalloc-ai-hotfixes-v1-9-9c7d1aca801e@kernel.org/ [1]
Link: https://lore.kernel.org/all/sashiko-outbox-188081@kernel.org/ [2]
Fixes: 86051ca5eaf5 ("mm: fix usemap initialization")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103-pgalloc-ai-hotfixes-v2-5-e0d2890ab74f@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Retargeted the zone-span assertion removal from get_pfnblock_bitmap_bitidx() to set_pfnblock_flags_mask(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9aadaf6e91b6..10904842c459e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -433,8 +433,6 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
-
 	mask <<= bitidx;
 	flags <<= bitidx;
 
-- 
2.53.0

