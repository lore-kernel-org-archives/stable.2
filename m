Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722629;
	b=XC5YoY1IQuUo+R+5RtfpfoUnfNNEjy8HJ98LZggRtq7F93ojroc5C9Bnp/K/WgMGLAPd
	 HjyOIcThyZrHX30UkfX/JiZXMb+OqT603qDfLrAb4rKHZczeIdhoXX03dgROb7o72xbzY
	 ksOndRWky41NWA6BmWWTdAb5wEbun5s36Jh7RQzzKdEwasy/jeFxyJ9EpULNE3C4sgGET
	 6sYAIh11S/ppEK5VgBw/gXpRo6EAoo5tGmqofIKjkctbYji2c5my1x8OzibZtNKQxrqlc
	 VBozhqKcScFH7wPd5EtdbEPmyvzvNNm5eZVJdGe6oT8GKlkpznPGGBXx8sf9itYychw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722629;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=UUj+WYRrtKqRc0bHp5Em9fn4QwszF0JuIC3a+tX6dko=;
	b=MlAti/QlNT1HsVLAg4GLXJWVImIL0Sgmx4qdU//0LCcYlgu0fgz+2qN8Fgp+uWYrmSlG
	 9qN9q9erm9ikfBM9Ik2z6xHTwKHyn5BZoQYih//d+YqLoks2Sof7LzvBWSHdmUcNrjKSA
	 qHF/MhZlaiR101SAt4x6z/e36/4gWB7GOHb+NUOCZ39GjJSZU5KX8OT9Vt4dH0s0lTy2b
	 9C9pCBKXo+pW61BIHN5Gv+64F9EF+vlVUf7sSiT3AfD0JN2WdduBLjgpBNessrHZ+/VzL
	 Qg6eJScQTSD88MBcymmtxyi7BKX2wAkRV26AesaMCOsXvvb6koHIAQh4wOjXZN6nfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dtfmw5F4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB481606EEAC;
	Tue,  3 Nov 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dtfmw5F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F9D1F000C1;
	Tue,  3 Nov 2026 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722628;
	bh=UUj+WYRrtKqRc0bHp5Em9fn4QwszF0JuIC3a+tX6dko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dtfmw5F46EBtVX4RINKR8bLG5H6cahQ8oMuNQSM6n6RgZxHNtjgpgXwIwCGDzi8lL
	 oNkBZ8Xc3XBYqSOT2v6irYHNzeJilJu5T+9fFqJ0aVgFdpwre5eQTzDHfPhV1oPlPE
	 LAMseIWhVNEZeEhE0xEoEn0XBklANMf5GcdG5Kv+8kuOl4ho0lw7BBgvunKtOo/XBj
	 YlUKG/yQfxaot/ENBQxehVQ1eBM/LxcOl6RDwQGKfseS/DGVFmaPlwt9lbx7Uj38RV
	 z54pE8cGD6zP7dEkdwW8YFmdb2Uh7sFo7nCHNGigtAjaoVJhXkxQlbDnOVFE0bh2IV
	 G2nzs9kNqsWsQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 03 Nov 2026 17:16:50 +0100
Subject: [PATCH v2 4/5] mm/memory_hotplug: resize zones under their seqlock
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
Message-Id: <20261103-pgalloc-ai-hotfixes-v2-4-e0d2890ab74f@kernel.org>
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
being outside of the zone triggers VM_BUG_ON_PAGE().

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
index 0ab9a6e09222..b9f02bc6ed0d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -461,6 +461,22 @@ static unsigned long find_biggest_section_pfn(struct zone *zone,
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
@@ -475,13 +491,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 */
 		pfn = find_smallest_section_pfn(zone, end_pfn,
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
@@ -492,11 +505,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		pfn = find_biggest_section_pfn(zone, zone->zone_start_pfn,
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
 
@@ -684,12 +696,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
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

