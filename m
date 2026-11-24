Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560907;
	b=0/sBM80A5sj3th7DuBVQufYbJ8QItAfb0vcXiW0UnI5VZSLCfxGELrJE8ezZ+7dIwxY1
	 M58T67WRu5yvOZoN4Nr89WGAbmeURs3JgIpws+thYRgyB4I5h67yYHD6sG3MMwKfDSyxC
	 faxYH9Ft4WljXAjoKV/inRK5b/nz9l04mKLdB7Hz6/TBgDciK4UfF4TM4gn03WTjPCmaE
	 DI8t/PeS381OyovaNzjEUwSsUlyom9qLKB1mVMLizmT+nc+gp1Bx3vaLRt7ffEDwOfVll
	 fK2S4LtxvJWhhv1iov5K7H15D1/U+/9G2FHFApp+VbpWw/S1QWa0xlGEKRqKNZLoqSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B1/Cqp65t4KpyQYiFFprcCUsT/emI6pCwzCPIpeaY4A=;
	b=PPaQoSYbOj6qS1jCRvx+bPoDqg/7M833pndYPvGVbpk4mM9Zd12bcvR9Pcoc4+l4dD5I
	 1PGPsvi8Ctq9odgITzGnzqwzQju/oZY8wzRjxQRiOkNy+2QP1z+NRlLymOQQ/mzxMVKkG
	 JCRTkcZBkFXGhnM3wzlaUO10oITc1Hqd0t+/4pBtnX/WlXjD+i3W+v9bVoNZfEUbDfoqh
	 NUtbkGg1KzO76289yh4K0CDNwskR0SNrQAdS9GUv/7gTGbe5eplaK/K0ZNGaMlg7Besfp
	 W/LSPX3iEDqWo4wcsvS1cFiZ7uuIJiHcY0QuMPMa+EuvhiZCHSaA4V7BsRxuyq1ON8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RW9Kj0/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAE606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RW9Kj0/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706C1F000CA;
	Tue, 24 Nov 2026 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560906;
	bh=B1/Cqp65t4KpyQYiFFprcCUsT/emI6pCwzCPIpeaY4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RW9Kj0/JIEGlWRzeObbTUgNYxxEzqQlj20TyfnvTtyuPM+DU5uu5+rrufRHMkXhBL
	 V+jSBTGahynVU5+vV+3fvIwEfCk2J1krF0WfZan/l7IPZZDNKG0nD15Kv4holYT6mZ
	 cmTZafE6E7NGomsxxzfh8ZxfQJzIWPEn1bQ/GhPF6FzpjJ0rzfVzVzwvr/JYjvGwW1
	 t7H3tAHo6eSitr7bvY864zWKRtS48GNf2/anYYa129Y3N8VPHfNsQs28rQ2Y9bY41k
	 vAmlKTc/Ge5Had2RNs51KbYdXKW2P9U+RVKCEVEymqwQyPgLcELaFsCqDBhXppcWma
	 wsCHG/Y8pUEZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 17:55:04 -0500
Message-ID: <20261124225437.3115786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112411-legume-maturely-0dba@gregkh>
References: <2026112411-legume-maturely-0dba@gregkh>
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
[ sashal: Adapted the zone_spans_pfn() check removal to its location in set_pfnblock_flags_mask(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..013dc3a6dd939 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -623,8 +623,6 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
-
 	mask <<= bitidx;
 	flags <<= bitidx;
 
-- 
2.53.0

