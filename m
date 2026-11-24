Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534898;
	b=f3LfThtdUniI9gMAkesuaXBMMFEmc/713jdmAdkxbJZx2sUvXkafgI12uxOkG9Veo4MN
	 0iuJydsMaqeZiOz30bmv3ethYd6BvmeJMuKaOrND3hJEFoGeSwQLCoC4Apsr+XVjCM2kY
	 EnRHTVY6xYIQ44oRQryBGaO0bSkjB9zCRLGYQptwJlqEzFqX6j0JlsBFnvVg0edMdbU/o
	 7Nn79TaR6UjPfjW4dbZKABggopu330TaFNOEzMkTJK7mIIZM2le/oyShRAUL1igrWGbZ9
	 vH/EPSVeEFqHSU90a+RYTCriIPAJs92ZsuQ+wpx17aCAq1AXHNiBqF+oQtE1DchnX6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534898;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZXZ3hF4cHmeSShuvk04PCbS5UAZf0vpHvrt3AUqfM/o=;
	b=r+ZzdLqquwJUnwg2NTfP+awtQmOgutFHa6glENnhyYq6111M0UObWHQH6ohCCXSlJaXF
	 7mPushk+NrnnJwEdWCbpm3D/pBkPMKck82HT0D5m4Cd1pAR9Tx/kwObUyuBChjBR8yG3X
	 iUyTwupKub7Ew65ODXvZ/69MF4oDaoOnHP6SXEpRDG7Bg3BCs2KlzeuYCy2iTPwRPf9aB
	 0RBqHZDrzyHUFfvoyEbQesx3qdIROhnZ+OcghJANnybfCWhNQNyTgWHcjcSlqqz7fgTAQ
	 I1PNk3MD9Cgi2W0or8mLAoDSQ92grWcrN1y8rxdQ0Gsy/PHx0VXF6j8HV42EpBauWkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pK9nAQcE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pK9nAQcE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913A31F000D2;
	Tue, 24 Nov 2026 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534898;
	bh=ZXZ3hF4cHmeSShuvk04PCbS5UAZf0vpHvrt3AUqfM/o=;
	h=Subject:To:Cc:From:Date;
	b=pK9nAQcEaIddEA4G6VOVc/yHFJz5w6V0CHVhEXt2YldRoFMWb0x2+gVijh6FuWE8K
	 muyAC+TewRsH5CKEsI/vUHdsd9YDu+m/usOwrfgpZHzKj6Fso3ghcsk2VSkhhYg5gZ
	 Eo5NHQdMDtOQHkFjuqXBbTKKc4l6hjCOk0iKbpIo=
Subject: FAILED: patch "[PATCH] mm/hugetlb: retry the pool walk when the zonelist is rebuilt" failed to apply to 7.3-stable tree
To: gourry@gourry.net,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:41:58 +0100
Message-ID: <2026112458-poise-swapping-02b1@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9f6674f842bbceda8326cf4e494af5ad3a5a05e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112458-poise-swapping-02b1@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f6674f842bbceda8326cf4e494af5ad3a5a05e6 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 31 Oct 2026 22:13:37 -0400
Subject: [PATCH] mm/hugetlb: retry the pool walk when the zonelist is rebuilt

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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da5d04edf7c1..b8a4fc2a996c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
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
@@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
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
@@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f54e1eeb7bc1..98c17ee12207 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4409,15 +4409,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
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
@@ -4432,14 +4424,6 @@ static unsigned int zonelist_iter_sample(void)
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
index e238ee91ed24..10a40ead6c00 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/nodemask.h>
+#include <linux/seqlock.h>
 #include <linux/types.h>
 
 #define ALLOC_DEFAULT		0
@@ -265,6 +266,24 @@ extern void zone_pcp_disable(struct zone *zone);
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

