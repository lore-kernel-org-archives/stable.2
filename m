Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555213;
	b=rZyvW4PlFogTfXIV7/XegbQ+JaQMjfHm3XehWN9j5W6dThvmfyV6bzuaS5nedXPO1RN7
	 Z5WgB4Zjlg58mxicTgLiSpYwaN0OuRlqf8CPg29RTWnei/G/ZJfzrjuA+hbb+oq0Wmb9X
	 nGo/plGZxqaWMs3LpLrkF1bgKuG+S4NtC6aopfWhUtGmQZQzWZxQXtdC59GKfmUk6T2x9
	 WniadKVpqOyr1k/FiXQ5P3TvzpYFZQAoLoJVHjdPLxifEmk2pU1DbLgzmE8EJJQDI6w6y
	 4CHQ+shWP9yw3W+XOxE10ybKNB6P+oSROcH7da3RJiZeadQaxJQCo86fdODn7t41BTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555213;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ckj9LwNy2a/Ej+tzsq+SqRCRrQB7TtiTvm4hn/bQ/Pk=;
	b=dpssW/yLEw5vsaz7CsTTSpOswR190qZWH2F4adNM+aOAasZ2h5TO5kcuiIxOoSmqPAGt
	 dYEe/a9ZJwtMPT3nUvLDMGXicWvFQtr2RZhUpIWKnWHwj4TOEW9poczA5PTVCwII9xl8l
	 w0/rSE8BO11SrxW240pnR7/w7ktb4ufbreRP1WRa+J6BVyT22vb8nZOB45OFQn4LeJGn6
	 UG5hvZsmLDype3dkoIb8xzb0nzjZBd9oyo7QT87Tktb9dIHLZ9XyfEHHKKdypjTPNnjMm
	 8kAIvLq/9epadaWtWUKHlwCmrx4/T4szFiylveai8OoMWmhTgTAgig92oeC7P6L+K4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/oYwO6M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13E606A33A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/oYwO6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9E81F000C0;
	Tue, 24 Nov 2026 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555212;
	bh=ckj9LwNy2a/Ej+tzsq+SqRCRrQB7TtiTvm4hn/bQ/Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/oYwO6MblQz8VPhFQykB3WSnNGoU+H0MngKLQdT8pHEC15OSED15EQszr8PVo/OE
	 auRPF5pTCpMztVR9IPmPvktaM1y/Snk+jStcRozKgFI7fZei7W/x4JqlO4w4VBKtV7
	 gXZlSUCnpO5ycAn+z/yY+QEWpdU6wZ3f9piLtsnIDATxFmr/oisXPqiWPcCIyz6sqN
	 mRBGDekMEJdhxXZevyqtLBocwuV1xnoDzTzT0eEBUItcLvizyLG94Jcta9c6Ve6YVC
	 sSrqornRMBq1nCxKSlg9zDBj7jOS6I5bcX3qGv9j1mZim2QuokhM5SlFG/77kRvgqL
	 oXbKKZ7VrNGjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 16:20:10 -0500
Message-ID: <20261124211933.2912265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112459-salvaging-glaring-8952@gregkh>
References: <2026112459-salvaging-glaring-8952@gregkh>
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
[ sashal: moved the zonelist_update_seq declaration and retry helpers into mm/internal.h (page_alloc.h doesn't exist here), and check_retry_zonelist() returns seq instead of 0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/internal.h   | 19 +++++++++++++++++++
 mm/page_alloc.c | 18 +-----------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 19186b66bbc75..83e81c8d1b2a6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1372,11 +1372,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
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
@@ -1385,10 +1385,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
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
@@ -1403,7 +1409,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/internal.h b/mm/internal.h
index 41a0b79fd71d3..4fd084fe9a7d5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
+#include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
@@ -742,6 +743,24 @@ extern void zone_pcp_disable(struct zone *zone);
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
index e9aadaf6e91b6..45c41ac8710fa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3978,23 +3978,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
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

