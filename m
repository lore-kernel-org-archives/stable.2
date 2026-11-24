Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561233;
	b=mATamP34dNs854BfekO6ksWfevZmtCIG+xIC2bKAOfxdmwSx4zmalB2tmm3247kEw7lE
	 +CIo+vZ6Mi6oKDPJ+0j79RZuSzz/+UbhqAcxU35UMIVBu9sFiQ6rS9mn/E05OXaA5Xzra
	 cNereZA2Q/0HbgvbpxstxhhpSZEceO3nILpWx+zn5aE9obfrKDafTkD4wkNOxK1pCyayF
	 oNvE4Aso2Q9IOTVMoFu7JkWLknkaCqhy17bWFX2J1MYAMYmEH3i21gF7HtYwBG4dqOyn7
	 nKjUL2yqoAdjmA/H+hnqc+YLRUIZLDjBOOeElJzYXnebhQmfoCPL5tUov4vduIMRhCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=egZpRIJ3CenJsuiXDwEVnt8llV8FlE4C3210sohCtYU=;
	b=oRtkb7gcFMIgtxmxcWvmLlTYKCcn1/WlXjNFQjjjGlVq1kowmGACqHMsFFm0yLuXz3qa
	 tixoN+tZkRP6NkYpujje+MHqibdiBCm0PRxmmwyui7Z2lBQfV+aURlWZOo5+RZSdHJPVi
	 I2wDih9KiYnscEJwcC9JqQNRe/CqHUCTKk7P5xGKudLtGKzeGeNV8zpKssoPcmpvcWCm5
	 eMkTFZtRCueDNuGSniPyTIE0JfXaxE5cek8k7/eg2naJeDXoJYCr+uwbV/YrH6p2QzKYy
	 V0tNgbZ5tYGuKtjoUucosWWfem78DXkpdiVXZbrhMWpZkkU9TJqQJxF7p/NAmINbumg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iX0C5vZz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8668606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iX0C5vZz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B011F000C6;
	Tue, 24 Nov 2026 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561233;
	bh=egZpRIJ3CenJsuiXDwEVnt8llV8FlE4C3210sohCtYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iX0C5vZz/pirauSwfUeDnK2qip6bGZgTUBAdtU+2g2EJWCX9AX7nXKVx4W8dnled2
	 9GPVDW/gkIwvirLobo55TW9x3zLPBWQHMmQHA2IwubK3fLvDsM+lRJxQ7DAiWIQa1y
	 2o1J3usSLLlVd6wJS0zvjZp8PVrsm1cPl5r0oQ830ttwqNV2kmh9tPkF92t631ZT12
	 5BIKBpEvrJQf3qRaNYITS+swJyA6qUKdrNKMdioeDRkOKOoUUxUL1GexaDb3cqudJE
	 C7/sVmMxNbqIyVrbkLn85Hxgq2bGjAKJoND2JtbtERAxUojsYOer0GYTaDKPSbD6s3
	 QBHrRqSh7joJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 18:00:31 -0500
Message-ID: <20261124225956.3164553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112401-sherry-landmine-7e43@gregkh>
References: <2026112401-sherry-landmine-7e43@gregkh>
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
[ sashal: Helpers moved into mm/internal.h since there is no page_alloc.h, and the hugetlb change was applied to dequeue_huge_page_nodemask() using struct page instead of folio. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/internal.h   | 19 +++++++++++++++++++
 mm/page_alloc.c | 18 +-----------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a4d70b5ad9a70..8ebe60e6257ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1109,19 +1109,25 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
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
@@ -1136,7 +1142,8 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 		if (page)
 			return page;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/internal.h b/mm/internal.h
index 85b9faf74eca2..672a958f27755 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/seqlock.h>
 #include <linux/tracepoint-defs.h>
 
 /*
@@ -701,4 +702,22 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
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
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..72c159547b356 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4630,23 +4630,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
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

