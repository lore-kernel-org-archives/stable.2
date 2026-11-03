Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722633;
	b=hE4QW2GQfrW/vafuN5JlBhu1vMPpDhfOF98D+5L9MdSfH2tnPCQnTdjfBVEdpvxRuV+t
	 830AKgud/tWCvKIqzQvw1L51Dj+KoD/mvJSCW3pnJurNnj/pTfCoBYgYBhhKbg7wQ//+5
	 hS9C1didcWQVaSva0y6NUq+XhypDn+yLMblT6Ghl/n5ouW3znfcO0I1javreOmyJwsX/O
	 STDHZK4wPpSpeWXCDCZ9sd48zkeG8/7Mclq6t0JO1ShKQ003S7yI2RTyaoeNYZKFolUPc
	 hy5Ki6FqLtP32Rnm6bdKG47nhXla/ZQIIRwLy10O1aT+63nyiseviFrDcZ6NloWBQfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722633;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=FMZMvZpZdtJea8xxGpJL71ybZyZNgDny+0BeBBkUktE=;
	b=ZYARtSVVKicyV9NzJpBRhEBkAUJMbcCRth5Y3+v+lZg0d4zPN8rwUctSDUX6k8w3GFhi
	 W4dCmtarCRO8GyAgRc90z1QOMb39XvSiHuzPTCWCQxkD97kVcCQngx3lp2bzU6ajB9GFv
	 ZzyMkqoPO2bNCZYjhA8fizAkUtnGwE5V94pAr/2iehWBZiJTou99SDjoyc98HcWoj6uEw
	 nhy30Jk9YjHAdeNND1LiYYXVsR0Kk+kizzO4p9Dq2oH3idZNkMzRY8CkdeDAvfD6LphfI
	 Jyj0zH+ajqsYDwpbsmC3tZ5W+2tk7TTZQyxcgQk09PGgAE57VQIFM6YVOVB/PhGdElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tdms6Q4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68649606A32D;
	Tue,  3 Nov 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tdms6Q4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5081F00919;
	Tue,  3 Nov 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722632;
	bh=FMZMvZpZdtJea8xxGpJL71ybZyZNgDny+0BeBBkUktE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tdms6Q4UWHlY9evtVY26SY666VGRVDiqz6LOSvJc2XVieo0g+lhSmUBzTmQK0fXOd
	 fs8FcsZXidCPiB/D47lmDgTEmthu55EQ0+xL56qqscDdUNxWCa93gezbvp9vf75HvF
	 HkNBU/0CnHTwEJpCZIyk5tdQjzaya3iUdUungReDLqKAuhBSqcrxk/7b7zbO/BBZSS
	 7n4Lv5ORNf/E884FHGRmdnjAlQpXXBRgEczHwZT9DMJ08BHBaBZs1OncwCXzIlMckR
	 hBHQT0JXJ9eIpkJYyVXE6M3ofBob9vMk+lNYjZmX7PsWxu3R4WaZ6bF+GWGsOiqeDD
	 fhTKu5jfv4cxQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 03 Nov 2026 17:16:51 +0100
Subject: [PATCH v2 5/5] mm/page_alloc: remove the zone_spans_pfn() check
 from get_pfnblock_bitmap_bitidx()
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
Message-Id: <20261103-pgalloc-ai-hotfixes-v2-5-e0d2890ab74f@kernel.org>
References: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
In-Reply-To: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 41fd80c0c762..3a7b9b533368 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -370,7 +370,6 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
 	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	*bitidx = pfn_to_bitidx(page, pfn);

-- 
2.56.0

