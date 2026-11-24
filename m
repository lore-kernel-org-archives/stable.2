Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534765;
	b=fJFmirhwe+S4yGG5HLcZqdcNQVTVnBU0wLc1Dq3aZ9kewOK6OeJQGwEzRP0J2Ys06JJV
	 J0mavrxffvxDuEb/ZmuLpADlu2MOjmPJuBqzqW7H2dwE4Aijx+aJRstEwBudN8zBlRgTF
	 sbgrsIjfyH3oi4vQaSNEFHPow8BxqN6i4rU5jTeeI+TopJvZsV343qbAM20Y0j0+KVClr
	 kgbLy38nF2+i2idbYvPtM16lAUoUx54b/e36SXczIYShPQYrQQiUl9NzL8wa27t9MOW7+
	 IidIGY2HOSI8VPrqcVS0RxjMSN+ss96bDKuvNQX2VNXznmOaLI8zvOhpFDygxU+wPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534765;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=soYGbERiba/uMKr6Z793i+eFi06gh2VpYCaSfdNNOc8=;
	b=jRAB8I4YlkNz/JE29suO6E2ENHl6Bvg3cvXN35nbiWT7qkotTFvmWzJHOYAAGg2QGdTw
	 uWk1bWGwMqKRDrLtWxQjUII07/+8f+XrzESGGm1jmpPMTaQn8Dd2IFnEvPiuU6TZAkFpA
	 6Z9QUOnk6WS1UoidrojqMlg1pfWN0LcflTG0DENOXm6CXD7UBbr/hvt2bGT4eeWkEQzpJ
	 bk9fwQdkxxAgt5fR57Lo2Uq4K4DdGsVfi1lnUjarMfvUWfiFZgVkc6pUEx08Z6IJAW+6D
	 CDmxCfDNmp8uH5dHJfPE48c0iZKk/oxgaRUL/UZtmIQXn6oDn8sdJ4yXEYblKnZg74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UVLL3sZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49014606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UVLL3sZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA9C1F000D8;
	Tue, 24 Nov 2026 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534764;
	bh=soYGbERiba/uMKr6Z793i+eFi06gh2VpYCaSfdNNOc8=;
	h=Subject:To:Cc:From:Date;
	b=UVLL3sZ3LUNURkLJFBX6+/itHVMWj6avgDV3cIJse7DxHALAQD6hsv1CzEozm6k1v
	 zI31v7Pgw8/i+kRiDHF4504+pQySFJguzWHty46AsaJwneyeuUmV0OhDIc+hshAX/i
	 2a/mtxyj/+jKiRhrQfDF5tJrpbz3PSeV3t/3zn/Y=
Subject: FAILED: patch "[PATCH] mm/page_alloc: keep the pagesets of an empty zone" failed to apply to 5.15-stable tree
To: josef@toxicpanda.com,david@kernel.org,gourry@gourry.net,hannes@cmpxchg.org,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:39:45 +0100
Message-ID: <2026112445-kimono-cavity-bc8a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7bfcf81b1cb469bc016fa8e07939c0924b9ff8db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112445-kimono-cavity-bc8a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bfcf81b1cb469bc016fa8e07939c0924b9ff8db Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 22:13:30 -0400
Subject: [PATCH] mm/page_alloc: keep the pagesets of an empty zone

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

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f1048168c90c..20bfd11c5851 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
 
 __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* This initialization only needs to be done once */
+	if (zone->per_cpu_pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -7680,6 +7688,12 @@ void zone_pcp_enable(struct zone *zone)
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
@@ -7690,12 +7704,6 @@ void zone_pcp_reset(struct zone *zone)
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
 

