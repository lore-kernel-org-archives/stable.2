Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116024;
	b=nua3kEDwP84IXYUg9Ece1qo16TKhnTjEwsglCppK4peuQFQpII1TTJU+gTucXlTZAOti
	 Uux1/kdEP6/y6579rHUYtotY67qmVvsx/ZroxVPKgB5mkvHdhWgiM2RI2ZuMg+hMe1RNU
	 4CXZkix+yJ09HK0Onqyu7Gr2qRF6Vp8yyxvmnucF0rB9m30DGdmcKoTL1+hQZaYnPE63U
	 6hKJzdESuxrvsG/sXP1lTN+PnllzIIRcAJQG84m8+CThvewoVbp+KbFE93i28hC3SiTMp
	 RHVa9E/a0zC0NJz5lr0sI2QsIoss/KTYeRNK30SMbql8A+WeVyVF0yW2GnQQAHmX1lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116024;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=bXoksnxse8Zb0V9rR0p5aiuA2ulCNQ3zxZK0B9A35Fg=;
	b=csrBOaLuZBZNfOZTuo50E45oFtS+AkaxhGWeVClsZYvp1MelOeVovBJDJMNhwXXyfWvx
	 pDixcLRHKLN3bG2O5bMgRkt/uCt0Oh+140K/dOmPNqEs5awLxmznaxkKEhaoujamwBTqy
	 QloGBlWVx4xdYjIccH3iXgn3tBz3L3/8R0DGqXi1oOnsioTa2fbUr5kuMdZUkRMVTf9+p
	 X93EqWnXtxkOW6cIMYxDV3Zy7uDHiOL76pfvayyEE6ItQlvkzt96LM1aM1/NbjdBQ3Mo6
	 FKAlLwMMy4z6dGxu7KJECldGImbsZDM3Qwt4uFd6h07tYPL+q9mFBd6RE0onT/2r8Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX4p6N08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4785606AB47;
	Tue, 27 Oct 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX4p6N08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9561F01317;
	Tue, 27 Oct 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116023;
	bh=bXoksnxse8Zb0V9rR0p5aiuA2ulCNQ3zxZK0B9A35Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kX4p6N08bpxjGgTL+dX0spyc93Z4L1rS8iHe8x5LoLMdu4zSbI2erfdE7VgOaELdD
	 5ptFnYTJArj3GWE9Vf/v04Sg1aWAn08YHiai3NNhnvwvK9zcPyQuH++7i0SH8XZXk1
	 KJMmn3CEDT5IsfeE3PtLjU2qVRqWXD+cYEVrVXgEU6BoW5X5A+n2QnHuto9BFarCtO
	 OPJRLvHCPBpLtnVGvdPVtoC32A3sNlwEMTC/4AqQy7PispMG9CrR1oijmGc5AD8enm
	 c92zR2bCaZxwB4hugQImkw6JUUJSiJoxehCoDqBsxwc2uJ3lJlp4A7yTFQ1CRAyIkK
	 ejxToFnnQihaQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:34 +0100
Subject: [PATCH 8/9] mm/memory_hotplug: resize zones under their seqlock
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
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-8-9c7d1aca801e@kernel.org>
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

With CONFIG_DEBUG_VM the page allocator checks that a page which is
freed, split or allocated lies within its zone. The check reads
zone->zone_start_pfn and zone->spanned_pages under zone->span_seqlock, as
memory hotplug can change the two at any time.

Commit 27cacaad16c5 ("mm,memory_hotplug: drop unneeded locking") removed
the write side, since all resizing is serialized by the hotplug lock. That
leaves the reader without protection. When memory below the start of a
zone goes online, the start is lowered first and the size is raised
afterwards. When the lowest memory of a zone goes offline, the size is
reduced first. In between, the zone seems to end before its last pages. If
one of them goes through the allocator at that moment, it is reported as
being outside of the zone and VM_BUG_ON_PAGE() kills the kernel.

Write the two fields in a write section of the seqlock. Interrupts are
disabled as pages are freed from interrupts, too, and the reader would
wait for the writer which it has interrupted.

Fixes: 27cacaad16c5 ("mm,memory_hotplug: drop unneeded locking")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/memory_hotplug.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e773a7d54165..66f181d98ebd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -467,6 +467,22 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 	return 0;
 }
 
+/*
+ * The page allocator checks pages against the span of their zone while the
+ * zone is resized, see page_outside_zone_boundaries(). It must not see the
+ * new value of one field together with the old value of the other one.
+ */
+static void zone_set_span(struct zone *zone, unsigned long start_pfn,
+			  unsigned long spanned_pages)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&zone->span_seqlock, flags);
+	zone->zone_start_pfn = start_pfn;
+	zone->spanned_pages = spanned_pages;
+	write_sequnlock_irqrestore(&zone->span_seqlock, flags);
+}
+
 static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			     unsigned long end_pfn)
 {
@@ -482,13 +498,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 */
 		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
 						zone_end_pfn(zone));
-		if (pfn) {
-			zone->spanned_pages = zone_end_pfn(zone) - pfn;
-			zone->zone_start_pfn = pfn;
-		} else {
-			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
-		}
+		if (pfn)
+			zone_set_span(zone, pfn, zone_end_pfn(zone) - pfn);
+		else
+			zone_set_span(zone, 0, 0);
 	} else if (zone_end_pfn(zone) == end_pfn) {
 		/*
 		 * If the section is biggest section in the zone, it need
@@ -499,11 +512,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
 					       start_pfn);
 		if (pfn)
-			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
-		else {
-			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
-		}
+			zone_set_span(zone, zone->zone_start_pfn,
+				      pfn - zone->zone_start_pfn + 1);
+		else
+			zone_set_span(zone, 0, 0);
 	}
 }
 
@@ -696,12 +708,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
-	unsigned long old_end_pfn = zone_end_pfn(zone);
+	unsigned long end_pfn = max(start_pfn + nr_pages, zone_end_pfn(zone));
 
-	if (zone_is_empty(zone) || start_pfn < zone->zone_start_pfn)
-		zone->zone_start_pfn = start_pfn;
+	if (!zone_is_empty(zone) && start_pfn > zone->zone_start_pfn)
+		start_pfn = zone->zone_start_pfn;
 
-	zone->spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - zone->zone_start_pfn;
+	zone_set_span(zone, start_pfn, end_pfn - start_pfn);
 }
 
 static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned long start_pfn,

-- 
2.56.0

