Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116027;
	b=ajYjeUgTXFs49U6A2otpwIqvm8xtW+YkXMZXAEs/WPMMh8XCOL0pDbcYfbbmzpBROL1S
	 fdtu1Vk9Ly/WLbFZRbKBisleFpKKPK/f12/qSPVt++2nc0Dxlipszcum7CgnO8SZBhztC
	 LYqlngz7vTHepXLw8XgaUVeQP5wYWL0WoKIC5CncQWxr2Lhr2GPzE7nm1YoGlmAZ6kcwK
	 d82II8uOr4hSoZu8+62nNIs9yftdqrLUD6v119ctRx9B3fZ0d3b9A5h/P6SBhFr+2pUR+
	 +BgnfSo8tBGhRyWKITl8nk7KwLkIk44rOTEFtQsqf9ajZ6IxPSA5patTvvocm+Hufng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116027;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EBhFJBIXzZKs7ic90QOOI2QxO1Yk2LoprMTQRNyieMQ=;
	b=Capkyxs/rRIScqUMuo+igNC/drMcNKsDg65d0ii+kYf/1aGGpFJZPmEkc5LjoXO3x5KI
	 INvCyoYdsthmd83PXl7bifk5ToaVEqzt9F+byVkr/Wy+DJKIqlmNA+YgQPkmbWtQvDFVe
	 +2RO9osyo6xAIXFnZ10EmuJt6766SjUjKf0rtKVaPBWwa05A6I8i9X9B5Lz7YUpHx8L29
	 FA9mybxAC0qfivj5Fv9A2USe9atINA1s3KvsriACyjMA0yEb8A4JhhO2BPuHxE+w8Y3Tt
	 TVUUE1wkkt4Uh5Yrz57weAdwE6IbD9zbSTEVcmGjcjCgeHEqONNzd30fm6YOQ272zFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOmPHyhy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D040606B80A;
	Tue, 27 Oct 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOmPHyhy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F751F01148;
	Tue, 27 Oct 2026 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116026;
	bh=EBhFJBIXzZKs7ic90QOOI2QxO1Yk2LoprMTQRNyieMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MOmPHyhy410bFWXBSTgsnh2lp8jIVG7tZ4/FRCYWazxrzUPJ/DjI4LUfGghjtOWnN
	 FBQLj4yh04sFykpSdnSXXnNtpHiXHQSEgQ3KdQS384X9n7i+R0czvDWxkmyBmYo3ss
	 ODM/ZwVaIcIdNnonsCCWXV8JAYEEaT1KWRABabFmrpNtXiab5fKRUn+R/4guo+cEes
	 GbxP1iS8Nc/MBtPXHVUTsFGOFjSOaV1s8VNzwsgCsfuf+UIs93+1k1NSN2INFCECDB
	 l5l7d8uDk7C/6810kSXLcZ5VkLTIq0XXorVjjWIaxS4qqy8Bs8ajrvckDyLZMqsc9K
	 mah74uHzq6Emg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:35 +0100
Subject: [PATCH 9/9] mm/page_alloc: check pageblock pfns under span seqlock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-9-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

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

Read the span in a read section of the seqlock.

Fixes: 86051ca5eaf5 ("mm: fix usemap initialization")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8f8885165045..f7bb0d59efc8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -357,6 +357,21 @@ static __always_inline bool is_standalone_pb_bit(enum pageblock_bits pb_bit)
 	return pb_bit >= PB_compact_skip && pb_bit < __NR_PAGEBLOCK_BITS;
 }
 
+/* Memory hotplug can resize the zone while we look at its span */
+static bool __maybe_unused zone_spans_pfn_stable(struct zone *zone,
+						 unsigned long pfn)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = zone_span_seqbegin(zone);
+		ret = zone_spans_pfn(zone, pfn);
+	} while (zone_span_seqretry(zone, seq));
+
+	return ret;
+}
+
 static __always_inline void
 get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 			   unsigned long **bitmap_word, unsigned long *bitidx)
@@ -370,7 +385,7 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
 	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
+	VM_BUG_ON_PAGE(!zone_spans_pfn_stable(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	*bitidx = pfn_to_bitidx(page, pfn);

-- 
2.56.0

