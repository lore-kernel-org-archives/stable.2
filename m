Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559931;
	b=roqyLTNtYDvRN2HtHLHhnLQvkLqYbMriX4edUoUtry/8/t35OfEX4xv/BPM7bbee+ehL
	 m4bp6aOHfgl+9LYuGvPQqQ16ByD7kWyJjNaP196wGuJ4tkKrXlxvCO8NKkuiTDBvCFAXK
	 G8Z6DpsF/5MQJC4HDywKtSHzgRDIZ52aLo5RJ27Kh2TWon2D74dJ1jSCuxBrRn0Ekrbgz
	 kS6JZ3U650SGUkElw7iw318jtR/hED5Q+CHp7JJgqHJbYNcAqYUwY1XIzDZ4ovRDW1C/c
	 un7zAhbPRTC5W6cdRvYxKgDca1qXVsjmYfb//hnBs+DmG6yO3auKwpgPQJ62RVKIpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=74tuOUf836SFTGfzYA2is1WU/KodokpbervD3IUe1vg=;
	b=QbTgJapsjHwyBP6PK+OlSVzwJyGAx0mpvyIOaK358/CNlgvsILTewMDJ1jskSqyB+5+X
	 IMbzu0okRw7GyliSs/svEyQCxlSjT72PO7jX05KClHX5z9Oz5SIa/CKaEdMt2MjhlKyNO
	 cDL5hakMzk2iRbpoWKyJS2o631oLOqkHROIMiVcl1RUQ16bI6aFDpSMNDd2jIiWp/rPIE
	 QJ3NLsFEjxn1U59wDg7n8jh0kl0hYB2iX2q5b+Zfm7iVK4foogm3aXrHS0+MRlZkShfKO
	 BQiFqOyXsjV9Yxp6jLnG8FoaVVg68B8jfqVzgVNNDr/81TXel8xtpzeeGjB60jw65JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxAOmouM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxAOmouM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8905E1F000C0;
	Tue, 24 Nov 2026 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559931;
	bh=74tuOUf836SFTGfzYA2is1WU/KodokpbervD3IUe1vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UxAOmouM0lAfmrenNQXWGpVqn7vVaiY6oxFB1A2dvKDRSgJzPTtOVxGRL+rU0s6e5
	 sCMnppihRiIPjEbkbkzkhQIScx0Ks409oCCPlD1AdrWWTfuIp+7GZbW8an0sSmy7tH
	 zGmDpY9Xx7rme5IdHVqwrytIN2SMxOrcZkKWkagq1J5JnliaTshvQ8ZdMbbdCgy8nw
	 9LywoAoKR5nlQoHHRHlJTcuL7czoiklPrIl4s5NHAJmM+deTihGxtApbekRi3gNyZ3
	 6UbHTf78M8zw6WMne/J99ZNJrImifDZVngeOe4TV05MEIKDO4f7kuA06AG7kBEaX+S
	 bwtOEqmwPs1aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 17:38:49 -0500
Message-ID: <20261124222702.2939329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112400-amuck-absolute-bcc7@gregkh>
References: <2026112400-amuck-absolute-bcc7@gregkh>
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
[ sashal: Moved the zonelist seqlock helpers into mm/internal.h since there is no mm/page_alloc.h, adjusted context for missing zonelist_iter_sample() and the NUMA_NO_NODE fixup, and kept return seq;. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/internal.h   | 19 +++++++++++++++++++
 mm/page_alloc.c | 18 +-----------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cfbc1776f452c..3ae64e32328dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1362,19 +1362,25 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
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
@@ -1389,7 +1395,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/internal.h b/mm/internal.h
index 7e7102969f3a0..3f21ca42c8ec1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
+#include <linux/seqlock.h>
 #include <linux/tracepoint-defs.h>
 
 struct folio_batch;
@@ -518,6 +519,24 @@ extern void zone_pcp_disable(struct zone *zone);
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
+	return seq;
+}
+
 extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50cb81d42b1c0..b0d40e4aa14f0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3650,23 +3650,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
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

