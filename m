Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560935;
	b=mz6ueaOHYOdIwezhwb1psORheHjjJotIMBYyrK1VybbJVM0kDqoWpEIC5P4qNj3rtNet
	 JmCgVq2WAG0m+thfwf71/sUR7R/7DGyCwPRaSx3t5WmERESu+mJtVPXdjfIDAt/GTNzCC
	 gjRYFhgiZqIVbUoTPBFS9lmuTuZcEd6ODJtKuUUixJrOfey88ELnkRTIEEF11s7Ata1Cx
	 nmx3iR6mDteph4a2Q0dAZEgJLvoFRV6LmY5locDSHBo0K8vWWfd9L/Iy23iQlpr9g/aji
	 ONIZDNrnjxkLAHXjMab5JCxYRVyFg50NTjlF+FtlF4S8osDHJLsSoChfhJlD3tDT1/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xjnhU4XqnoPrSSInmlTA3nciVVu3/TjnJCmjrI0Lq9s=;
	b=YRTDjZM+ZPQJLP3nmJtPc8teOpP7Rwts5tovT86bpkO96JwfqCwQkhDg8as+BG1twB91
	 BbPMVAgouy4Hz+gAtlgNX4G2lW00hSsxR9+K40o+xB15ZbOPMQyDCL8gu2Ew1MLAh/8kR
	 funm5RAS/xRbiIcvFUnsyNOYa7CF9ToLuQrD2G3bVOhNwDPaDITBrwcjbp9w5Xb1qgsEy
	 x17tMyIcerGTr1Fai4YB5QaD493R/wYLB/KyxlPpWik3YTsM1VEm0PzHmc7L5+mt9yh6o
	 6CHXsgunCXcXHvHDe8M/Q+K0uGc7CBMoudIkC60fF7O3oqXA+X3vg0hbjO+EIGmTH2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gI2BF5Lr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D031606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gI2BF5Lr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B19B1F000D0;
	Tue, 24 Nov 2026 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560934;
	bh=xjnhU4XqnoPrSSInmlTA3nciVVu3/TjnJCmjrI0Lq9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gI2BF5LrPN4NBNph2DR5isj1rXRMSdM3bf3lRVxWLNlJWZl18EDusmcgfEPm1msTW
	 ayCNSMoKfrTfJxkdwWHnPh4P49gQV/h7L8H4fuEz6LzQStHMxojOHytJf4x4HMO90e
	 z0qrvKei8NW4EgQRSdtG9lw9HBujFH3/fnya+os9q91R6FkDeYpn1O3sPX/V/nwFzq
	 fDzzdAzaEOPwlLooSsFwGjN7I1usL0E3TOB5PHE9doAj8D/y5A8TrncuXcWdZATU3t
	 yEmfzCq2H4hC+gifuBnasZC7nGWT5zStN8US+stL3jbOaHPVEMgG7D1Znu3hzDybO3
	 Lc8XAooESYb3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 17:55:32 -0500
Message-ID: <20261124225441.3116409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112400-travel-cobbler-35de@gregkh>
References: <2026112400-travel-cobbler-35de@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit 9f6674f842bbceda8326cf4e494af5ad3a5a05e6 ]

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.  dequeue_hugetlb_folio_nodemask()
approves a slot by its node, then loads the zone from it, so a hugetlb
fault bound to one node can take a pool page from another:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone, and on the way out
with nothing found, and restart the walk if it changed.  Checking before
the dequeue leaves nothing to put back.  Reset the last-tried node on
restart, so it is not skipped.

With kprobes holding the walk across the online, a fault bound to node 2
took a node 1 page in 3 of 3 runs, and a node 2 page in 3 of 3 with this
change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261101021340.2251928-10-gourry@gourry.net
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Adapted to the older tree: folio-based dequeue code became struct page, and the zonelist seqlock helpers moved into mm/internal.h (not page_alloc.h), with check_retry_zonelist() returning seq. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/internal.h   | 19 +++++++++++++++++++
 mm/page_alloc.c | 18 +-----------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a0372189a23d4..fdd23db12875e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1361,19 +1361,25 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
 		nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct page *page;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1388,7 +1394,8 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 		if (page)
 			return page;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/internal.h b/mm/internal.h
index a94aae7f6c8df..0e586201b0fb7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/seqlock.h>
 #include <linux/tracepoint-defs.h>
 
 struct folio_batch;
@@ -404,6 +405,24 @@ extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 
+extern seqlock_t zonelist_update_seq;
+
+static inline unsigned int zonelist_iter_begin(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqbegin(&zonelist_update_seq);
+
+	return 0;
+}
+
+static inline unsigned int check_retry_zonelist(unsigned int seq)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqretry(&zonelist_update_seq, seq);
+
+	return seq;
+}
+
 extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..5e3d9f5ba4bc4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4799,23 +4799,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  * retries the allocation if zonelist changes. Writer side is protected by the
  * embedded spin_lock.
  */
-static DEFINE_SEQLOCK(zonelist_update_seq);
-
-static unsigned int zonelist_iter_begin(void)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqbegin(&zonelist_update_seq);
-
-	return 0;
-}
-
-static unsigned int check_retry_zonelist(unsigned int seq)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqretry(&zonelist_update_seq, seq);
-
-	return seq;
-}
+DEFINE_SEQLOCK(zonelist_update_seq);
 
 /* Perform direct synchronous page reclaim */
 static unsigned long
-- 
2.53.0

