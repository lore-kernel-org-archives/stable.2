Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551909;
	b=h0xiya3XvAtqBlNgXrjbYlJGWxeMHlZzsh6aivQ/plNPj1GgQDhEJDtQtILvHWUtIJbY
	 NKh6w6ai606nGgq72nGpwWVS9rhQfElu45Ygnv/LKZj+c5FWmMoYOwAWiA6ng3yL01KIA
	 1n+gH0Pn8/OX/a/ajzDblcVvBZx5zRdVi7bmZw92zG6cvnIbVIiGGDg20wvSUiPM/i5Zw
	 d+0gvs41PU8/FVdEz99ISlByilTjE49c6gvgf6bTsI1b8ARP5AH1204vlsFUrQQgzWlN1
	 9WP3846KG69ALDkwPB65CZJlO1lKAyP3+nGuBpkBLEsvHINPDmJ+wdjjfKRSwSDBH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wczeGVI1DK4+SSIg8ACaVhh7f3JlM2V2YyCg2pxrwFo=;
	b=DlH4zlrO03UJDbzGy+EzPfjsFLCJWPIXNQ0Zw+l7jWW1iWJWAp9W/+IQLFLSO3GUmqL+
	 AjpyZH3nJVof/5+5YMTIwmTxpXtMS8Tt+sNJF4ocRoqQ94IWR5Ak5ZWa2sVmsPlLWqzif
	 GeTB48079XWQQMKOcGIHeT2HKMsGYHo3U9hM1rlYcPQJ/vIXlqXfsnYFvV+Bpswayehq9
	 NOPnEZywopdNAPqKKJshDvc9G/fy/3HM1NWJhhXcNORqBrjplD6eIQ3O08ZenUOhZL+Dk
	 n9Horn/vN13oEjqlekGhjIYOxji/i5cv+mV9ktNV6qoVg+NPvNZowCw5AHtauMwcliQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLhPNRwy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCF606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLhPNRwy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851C11F000C4;
	Tue, 24 Nov 2026 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551909;
	bh=wczeGVI1DK4+SSIg8ACaVhh7f3JlM2V2YyCg2pxrwFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLhPNRwyZO5Q9G2dL7iR1CqEhik54Pp04r/pQJXwBkjnYzrAmxoqQTjK5eMUtWG/K
	 JDOI9S32ttc53CATZDJEb5r4rzoPpGsWH6YEQQdg2TKGRGdsORbo8NFc7Z9SD05nRi
	 jkzshV0Uifr+KHtFDUzpKDzfTbjcRgrcJl2ZRCZqZdAphqOfohRP5jW+xlvCC+imsX
	 +FrxK+SJKVdnSPt3eJ3IeX/0Hkypqz0Hawr86poRwGooT2lR6zPyfa93iJ1nImVZ9v
	 MSEOnaAf+hT9NHdAHUdfqz8nRd8sB8eMxxeZeyOHGgZhBM4PGhWDLZQkjNwtlBE9yE
	 CtzdFM4NQdX/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mm/page_alloc: keep the pagesets of an empty zone
Date: Tue, 24 Nov 2026 15:25:05 -0500
Message-ID: <20261124202449.2582372-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124202449.2582372-1-sashal@kernel.org>
References: <2026112445-kimono-cavity-bc8a@gregkh>
 <20261124202449.2582372-1-sashal@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 7bfcf81b1cb469bc016fa8e07939c0924b9ff8db ]

When the last memory of a zone goes offline, zone_pcp_reset() frees
zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for those
who found the zone populated and still use the two pointers. They take
neither the memory hotplug lock nor any other lock which offline_pages()
holds, and some of them can sleep:

  CPU0 vmstat_update()                CPU1 offline_pages()
  refresh_cpu_vm_stats()
    for_each_populated_zone(zone)
      pcp = zone->per_cpu_pageset
      cond_resched()
                                      adjust_present_page_count()
                                      zone_pcp_reset(zone)
                                        free_percpu(zone->per_cpu_pageset)
      decay_pcp_high(zone, pcp)
      __this_cpu_write(pcp->expire, 0)

The same goes for drain_all_pages(NULL), which takes pcp->lock, for
zone_pcp_update(), show_free_areas() and the readers and writers of the
zonestats. If the per-cpu memory has got a new owner in the meantime, it
is corrupted.

The pagesets are only freed because setup_zone_pageset() would otherwise
leak them when the zone gets memory again. Keep them instead and let
setup_zone_pageset() and zone_pcp_init() use them again, like it is done
with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
have been calculated for a zone without memory by the
init_per_zone_wmark_min() of offline_pages(), which is what
setup_zone_pageset() would come up with as well.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261101021340.2251928-3-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2679420c73a0e..a3257e7408087 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7096,6 +7096,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -7147,6 +7151,10 @@ void __init setup_per_cpu_pageset(void)
 
 static __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* This initialization only needs to be done once */
+	if (zone->per_cpu_pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -9473,6 +9481,12 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * The zone has become empty. Its pagesets and zonestats are not freed: nothing
+ * keeps somebody who found the zone populated, such as refresh_cpu_vm_stats()
+ * or drain_all_pages(), from still using them. They are used again when the
+ * zone gets memory again.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -9483,12 +9497,6 @@ void zone_pcp_reset(struct zone *zone)
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->per_cpu_pageset);
-		zone->per_cpu_pageset = &boot_pageset;
-		if (zone->per_cpu_zonestats != &boot_zonestats) {
-			free_percpu(zone->per_cpu_zonestats);
-			zone->per_cpu_zonestats = &boot_zonestats;
-		}
 	}
 }
 
-- 
2.53.0

