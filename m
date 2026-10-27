Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116009;
	b=IHJ9WubyfEItL3ewp3tZ6j23SgztvzLrNobwxlzjpg7Wm3KQ4MiUoIYLYnyHebe4W90v
	 +5y2DPlMd7pDbpXQ3gHgIVrJO5o6rAP5y5vnmKXMiHWYUz/drPbk4QlBL64YZhI4RTR8B
	 zfae7hAVwWGRu9v0mQmGCMrEvzudHJz2M/yY+58/n9Mp+uklCbkI3LLwM9JHRm157u+Ya
	 McjGKW3q6fe0nFX9h7FPttugIZp+yByF9WAwfL9YvkTfVX2UKP4tTaevlrJeaC9a2IMjA
	 kHojNPWO97at4AzhDvRyYepqtZQ8yWckTzc1w+0rF7nFaiAzYklvZ/EXvjo9wNN9ioA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116009;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1u8lZKxgFZyPpeTOFFRYQ4fgYgjI0MvFics9ypH01DY=;
	b=JOBv8YhDvr2Ga6vP/okNZNxtwkWqLgqZTS+XT6OLsesT6w1QZ8V0lijz+oG+zlkkjFQi
	 8WSA8QRGKMsKIXvm0REJO/zeZqdBOLd5oKFfiNaJsdG4FbE+RzpJ4KlUY1LDIz+KDho2q
	 TnpE4eox5HbkH6YkriXlnpZXE9sgMqXbJPfWThQ2+yw5r4BVDADLq4K7pAOZ0su4uJmiP
	 8xyKoLpCwsQhch3m1uhy8T65KDM8D04dh47lJhgxk/7OUg5tWZcSEMETRu4T7qjzrLuXl
	 BnW8KjhXm/ot4eHzHvSeblXFNFR1AVlVjBpwo/SUIErjvGkQOz3+gpp1FIrLhcvds1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPSY5mcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA9606A33E;
	Tue, 27 Oct 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPSY5mcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6271F031E1;
	Tue, 27 Oct 2026 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116008;
	bh=1u8lZKxgFZyPpeTOFFRYQ4fgYgjI0MvFics9ypH01DY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dPSY5mcsmJ6rtX9SPiO4XwDXHY7n/zmhtkCHeEC3C0NnN/O+8oo37LqtI35rur40l
	 aHy2epuMIF6RqQ7LULRCxz0CP8ZblI4binijgF1tR99odhURt9pZYB+LUhwDhr3PP7
	 E5sqYOdg1rmsyYrtTRx0CnJeOe/ucrxrwkFD26mimA9CjIAkhn/eWHGFgj6H46+DwZ
	 KPdBHRt4OsQMef1KfLUUQlYFvG1/HrqZg99bSh+vOpZqfhdsIrKF9lQ6sjnaj/HmCM
	 XsJH/DRSX3Y7SQs2J0tWUnvTRhDswaqDSsUkac9Qh5rYJvmMcYUU61KJyb+8QCcEqP
	 Io50uxM5SsA2g==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:30 +0100
Subject: [PATCH 4/9] mm/page_alloc: keep the pagesets of an empty zone
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
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-4-9c7d1aca801e@kernel.org>
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
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9a4d3352c037..13211b8caada 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6312,6 +6312,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6404,6 +6408,10 @@ void __init setup_per_cpu_pageset(void)
 
 __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* A node which is added again, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -7684,6 +7692,12 @@ void zone_pcp_enable(struct zone *zone)
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
@@ -7694,12 +7708,6 @@ void zone_pcp_reset(struct zone *zone)
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
2.56.0

