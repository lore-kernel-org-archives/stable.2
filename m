Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554553;
	b=vMUeM0MIA6xtE8CkxcfrNgukf7qGd7gNWk9krf8CPQCvQ0TfpBTOHBxgCcZ7SQrbys6H
	 6i4Cz0LcJpyEhiF+YJQTJKbhThohVsvIrb+J5ZvQgTVkuDyqLS1El/sDqVEbuo0GwdMI1
	 bzMAX0RZLt93oLq6YMhpxhOJkoFSR3d2ipo++VSFIumAEARBWQxgNCDp4bRZlSdpX3qT8
	 sdu8Hw0Jr0npvK54FJocY17LVrs4doPtByZ8nbic4VpfZOvEhB8EmU6R6vuJ+BbuqyyU8
	 a9ynp1gxGawJ1scojBGLJ+O6jW7KhE0xpfiC0zCtI3mLTWbcLkvJVH9rZInzw15ot4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MQhzeHdb6rG7TWO/0j8tbHOFmSkEGn9pGfv3qkl5UTk=;
	b=f18nBv7lGfGwKKz5ejmokAE+ULazAocAddi4rVkZxcouXkgxHlQU8oeSHLdB2V6iixk9
	 +9btTCd/nEv/BFn5AIcP2FFehK+WGhfmnwIPHlJ7RchKbHdX9vTWdpgOud8FfiW+x8Y0+
	 t/utERj6XaUrWXN4sqnFZ6KJWfdEwz2bWP+kT6Efc1E9EKIKHQmemNRs89tQk38BxSneL
	 80/3JOIeZHvS9j0HMdJFX4e6HzU7lsG7bw9eX3kKFoHBuRVRQ6qtNUpfJi2TnlKca1oj4
	 w+fnfMwPDex5Gzp6/N5STtQdeMW5sAzLaQaP4Tp1Ws2pyT1MplXL0xe7UpM1KB/Zoeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUbZw8gE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA5606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUbZw8gE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9191F000CF;
	Tue, 24 Nov 2026 21:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554552;
	bh=MQhzeHdb6rG7TWO/0j8tbHOFmSkEGn9pGfv3qkl5UTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUbZw8gEWFE0oIlG8fh984WJ2ttbIpuVIV+Ux+8yG4rz4QIRqcnTIKWWEToZvBkoN
	 xrW812XB+404V6Ucm5HVgnKpvFLCVR6R0gc1k1CE1/knbKsudUq8NEnNhFET455Ok2
	 MgEH/Tosc3bn9ClrhVRhaTJuD84aADXqZnexy58MMIz1S6xzTEmQqQWUbOiVsnnYh1
	 BB/d7R8dAB7cKAEGQ2HaJK2Jn9J6fkdYIxgs7fH6ZclgJOFqTLTZzMqJB4cVAUXs15
	 6SYrZjk70hf+DvOqYGvSOTZDTSqtHqoMk6Mp0G9KoKkWJrl8VXC7LjiFqhm4J5IQ3f
	 yMilMQnZeCuSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 16:09:10 -0500
Message-ID: <20261124210904.2758812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112458-poise-swapping-02b1@gregkh>
References: <2026112458-poise-swapping-02b1@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261124210614.2758423-1-sashal@kernel.org>

 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c | 18 +-----------------
 mm/page_alloc.h | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 82963b9977b45..4d184378b89a7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1285,11 +1285,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
 							int nid, nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
 	if (nid == NUMA_NO_NODE)
@@ -1298,10 +1298,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1316,7 +1322,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc02971867220..b006cc8217a6a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4433,15 +4433,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
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
+DEFINE_SEQLOCK(zonelist_update_seq);
 
 /*
  * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
@@ -4456,14 +4448,6 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqretry(&zonelist_update_seq, seq);
-
-	return 0;
-}
-
 /* Perform direct synchronous page reclaim */
 static unsigned long
 __perform_reclaim(gfp_t gfp_mask, unsigned int order,
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index a9b72cb9520e1..2ae37ffdb623f 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/nodemask.h>
+#include <linux/seqlock.h>
 #include <linux/types.h>
 
 #define ALLOC_DEFAULT		0
@@ -267,6 +268,24 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
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
+	return 0;
+}
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.53.0

