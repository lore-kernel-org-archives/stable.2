Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561238;
	b=a6jlXKA/vJia5j/PqU3dAcYgUEE/YrjNZL+VeQ2X/6Loi1qzyOc23CDvA53ABa4GAFpP
	 4NQ/heQgA2vF1xFIF+tzcli34zdWKkwVdjdHl8UyGyXK98mmOTcon8+0o0h85Qf6x8PNK
	 DLhF3h6eO3K4WDELQSW9rrviUY/dV2iqvYwPTY5DidGHPDEv70hnBeANXEauu/v6LoPAP
	 G79xDAuK6CxFEcWntGqmcOflD9oeZXSW3SsJJvI6EgpeJR2+kbwkesm2pEyYxgzI8ksBF
	 gDHq7cUaSX06LN5aOqXN94KbY4Nlgj6fkGHSN48W2eo8DwcAEQj5aUZnEsd/s11Tx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fds+beVwaQDs9ELvlw9Bv8TCQx86xgq3AYZ3lxwQntM=;
	b=ACIhUX1AA6RwWYFh2r+okWYaNsIsfsVFGAG4VY6SK8u3LBecKTD+bLsnZtzlgaJ4HD5I
	 Aq7JqoeWpOI9aYn3ZSNiAP0OLNAC2jIIs/cJcAeglLwkqQyOfZsXR1/2AujCPonbYvLex
	 aCb8Q5DcyI2kGJ1RWo+/phN3/lMsCVSsXzvQ6EWX6zeZu0/yTyysH+WKRP4p+xcN6Kn52
	 WEn23HLceeqzeCrBIgq3+V2d7GeX/501zpmddVjZrnGxtrcClm3JKvuZgOjSk9UUAF9Bl
	 gJ1Cp8PEs+urYSuEBN0ZA/o9B6OHnz+11O1Z/DGM0cPyuMi6QHE/aycBolE4u7ewmUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/wkVvvJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A0606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/wkVvvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2720A1F000CF;
	Tue, 24 Nov 2026 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561237;
	bh=fds+beVwaQDs9ELvlw9Bv8TCQx86xgq3AYZ3lxwQntM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/wkVvvJqL2FiS/E5QayG0Spw/X1EzeEAVevda9avxqtg7zITpFKfFRNeJ3CSv/k6
	 hlQynuveZW/KcUW37gB0T5WhpKz3QzXw34+NKYqS4IaoDZlneWj38VixkiNPFiVY/1
	 TvrgL9XDIkoTPBylCUVrjCo0beIKOg2r9CBPhu9I+dl1zWl6RlUnqj0byLOTNSXL/f
	 MjsZUW16tNlj0GFVui+DK/o/azlNgwsgVZrzwkhkSWERQcR+9JELAVaW564wQug7A1
	 4ZwvtVSWG1jS02Be0x0Wo7CgITEF2UmTUuXeqW47norCpV/hqpsY7TvoVoUbaL2wi9
	 63QAB/wyVBXsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 18:00:35 -0500
Message-ID: <20261124230014.3174030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112412-purple-unkempt-64a7@gregkh>
References: <2026112412-purple-unkempt-64a7@gregkh>
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
[ sashal: Retargeted the zone_spans_pfn() hunk from get_pfnblock_bitmap_bitidx() to set_pfnblock_flags_mask(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb0614988479a..7d763b443e7ec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -558,8 +558,6 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
-
 	mask <<= bitidx;
 	flags <<= bitidx;
 
-- 
2.53.0

