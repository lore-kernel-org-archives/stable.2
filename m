Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552268;
	b=C+OwWjxPQeOIq8ro+OiDUQ5asDPi/wWyjS1QLEukUJpWxeD5vxk5R5YZj5v2Tr8SXx79
	 iq+9NdFTVxge3A1WBv5sjtu7LcJk2I3U+UUwghBQ3OoGjbba8SVUadoqOAo77vYHDS1Ia
	 0EnPPTDVZbh3Kh61k09Cw3r+ywvw6S0ynfE5uMeuNrwvYze6BLFbgz0M405NAToS1r+Pe
	 7LvxMtDyF2MtKEsNlA4/W5KZpoClGPRPyy0DLEbcaC84EC7rgt/6kry5itP+S4kT5jm2l
	 FJb5VhlKsB12M/3rXf+GNydnyQoII45DVSonLAZmHqLUH1NZ25Mk5YNFzTDWYo/u3zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S4RUuq05scsdeJoe4hEDc8nXSdNRqZxYLVe+Ip6skhs=;
	b=Rul3LqrW/1ZL4iM8hMw4ycUWfIYHLtc7iaaUFnNCCLeGM/eNNI+eQumIBLEJjBy5lmD9
	 TvERh3Fb1aoSVA5JCd9ZjGKY8QHZRLjXI5fP6pl+ykb5A9ZXzh4MMcz2KgdfAD2KRMCLZ
	 UWVeBgLx6Srz3NsQZTdYGPJBY2lo2/zk+lsRR7r5rJ1prqz3/ab44XAoEwyaV2geNCbDZ
	 Scl1uBfehdkjVGs+MUhNtRV3/Gqafuawk7wJlmkc++pEDNpy2ont+oj558ko8bKuC1YN2
	 kgRCTQqwJB2enkV/2L+YcfUiwkcP2KqAK4xd1hcH6OzAvcrAtfojGw5zAoAP875vWaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=De9oO3QL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCB606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=De9oO3QL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B372B1F000D0;
	Tue, 24 Nov 2026 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552267;
	bh=S4RUuq05scsdeJoe4hEDc8nXSdNRqZxYLVe+Ip6skhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=De9oO3QL3QyFf+p4GQ3PZ3EnsL3csrgJXIVXq3I2JwPw5Lr79lvLDuNiVdI1Rsa2O
	 4HbMaep+cjCAebZ6QSkx+20lX3MsLQ+3OO0m1bH2HPfx9SXa3e0stn66e0kyzZ3/6T
	 8wnNmZQ60gWuE1FarXcOMcu2Iie8NjScpa86ALgXVy8a293maC4GrxfWvvLsG4KYOf
	 yGom0GSzk9phLFyb4Fpp0aQDdoGxvh+CGL5SUOCWJwLD+iX/Xqa6y61pzmsmFr9WwL
	 P4yRcj7Be1CRvm25dDgB5Fk8r/ahP+CAv2fG2Wy+eCaEibEj9P6sDvThMt9OIr2kLR
	 exqQitqrYNbiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/page_alloc: keep the pagesets of an empty zone
Date: Tue, 24 Nov 2026 15:31:05 -0500
Message-ID: <20261124203043.2608027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112448-coke-coming-a4ad@gregkh>
References: <2026112448-coke-coming-a4ad@gregkh>
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
[ sashal: Adapted to the older pageset layout by using zone->pageset and dropping the separate zonestats handling, which doesn't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb0614988479a..5af52b935a17f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6563,6 +6563,11 @@ static void __meminit zone_pageset_init(struct zone *zone, int cpu)
 void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
+
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->pageset != &boot_pageset)
+		return;
+
 	zone->pageset = alloc_percpu(struct per_cpu_pageset);
 	for_each_possible_cpu(cpu)
 		zone_pageset_init(zone, cpu);
@@ -6602,6 +6607,10 @@ void __init setup_per_cpu_pageset(void)
 
 static __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* This initialization only needs to be done once */
+	if (zone->pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -8870,6 +8879,12 @@ void __meminit zone_pcp_update(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * The zone has become empty. Its pagesets are not freed: nothing keeps
+ * somebody who found the zone populated, such as refresh_cpu_vm_stats() or
+ * drain_all_pages(), from still using them. They are used again when the zone
+ * gets memory again.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	unsigned long flags;
@@ -8883,8 +8898,6 @@ void zone_pcp_reset(struct zone *zone)
 			pset = per_cpu_ptr(zone->pageset, cpu);
 			drain_zonestat(zone, pset);
 		}
-		free_percpu(zone->pageset);
-		zone->pageset = &boot_pageset;
 	}
 	local_irq_restore(flags);
 }
-- 
2.53.0

