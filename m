Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534776;
	b=k/AjhV7XGi0TN5ehMt36QVBciP2scgA4Uxi7gHYwyHpx9XnCZ90JSZg/HCDf9Kvq+NWW
	 LlpHthsA9EUDpaYjYpaG8L/TOlp7AdgLrYhMrDcVSXJdDlx9X90QuBDmtH36I8ZrtA4Cn
	 w2klU/pqlc9FW76jmgE3f0/Y6XmBVfSWR3vTuqsJrjSYmflL+mYfoTYoidf9KykifzA1v
	 9BJ4s91eyqIGFuungEExx0GWwUl7YO4IMoyHdCrSt+b0AB3cBkFb5YsPmI0g24/6yYNWL
	 VGKA6TD/k6674ZYgifwro8d3Bp6E4/EV0IB8SPcJ16rhBwMw9m87bNKw1zERyA7n3PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534776;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rsZz2IkW18YqFuNDdj2sHCy1F3uqyy7be/NVtovrymw=;
	b=DN5KZr+sEL71KwHvTc6enG7EBLYFtt0k/aXkZ4v6O7nJPuSjfoMKnd6iimVdKwe1hF/H
	 zPCllfAAkYc1oFGmTfsjNUkpZFgueC6uNlcTI52S3TlFKP7WHOKqoUVx9IWlxRiyXKZfa
	 9dGaAQHksnpgSYNDAS1G1hnc3LYjlEUIEeti7ph0+wrsDeuyMeGrtiIclXDllONofuOXh
	 38pOcx6g9hH54V1YYF6ApzgCDo+LOpJHA+4mTduvBu7pqcgFBmMaKjfv95/zx370SLGVG
	 tJ5do76kV9+rzR0UVUeDd+UtSHNbnK+lo4+KiREsakapJ/WuXFAqRX3C0DM7JBxaJRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mDDsfnVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC11606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mDDsfnVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C71F000D1;
	Tue, 24 Nov 2026 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534775;
	bh=rsZz2IkW18YqFuNDdj2sHCy1F3uqyy7be/NVtovrymw=;
	h=Subject:To:Cc:From:Date;
	b=mDDsfnVTwm7fyr/FaOt8K2JURdaFWM0VfxiXUzcZqYpQfzjW0myViYnTDJNn06Z9k
	 E1EP34TphnWCBq0FDWozrNsAGw8dghmuqOGA7Yh762H3WGTARcD1IDYBTlDOwT55BB
	 TeGOkrMqeVFam0L2540ODsfw4l5BdMxpb9IytGGQ=
Subject: FAILED: patch "[PATCH] mm/page_alloc: keep the pagesets of an empty zone" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,david@kernel.org,gourry@gourry.net,hannes@cmpxchg.org,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:39:48 +0100
Message-ID: <2026112448-coke-coming-a4ad@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7bfcf81b1cb469bc016fa8e07939c0924b9ff8db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112448-coke-coming-a4ad@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

