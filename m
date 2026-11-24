Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534575;
	b=BVWL5sUSeuxKNAgjvGZAH39LekC6rS1Cfhjefx9fXSYQHYHtNXteyav1rMhWVL6Y8bzD
	 It6Zyp9hrn/JAH30N0fILpMhY1BPp+R2dEj5EChWSgZKRQgXW3xCsxyhXXmP9sQGl2NR6
	 LiLSF0sP7AupvVHgPeOVPDdUX+/g96rSuUWKnxd8CAd7N9o3rLjORbkPCVJ3kswGvTFIn
	 eZvHptp+c7qlWuYCONTLEYDFQHPRQBERU7ktfVhf0FrBOV1OAOw1xEagZS6WICK9dc0xJ
	 LHY2cMRwNCAaXnd23Jw4q1ps42Xu0cCDt2p0kq5I+wPnfOREZRGDkqvue1fJHLSeQUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534575;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=viZuXoQt+ROvfw8Edzwp3JM0IwCaNMa43QV51C+bLB4=;
	b=01JdqZTFZIm65XyDtwuB+PCbVyScE1h+4ViJmvXjeTkMaEk0fuiL7ffePIxiOHwmE8ka
	 +LFJhKPdAwO7sXTWNiH5ycPcJVNvzvY5pE+p987k3HRTnVOe9rpP8zGhUEIC9qEkyGKDg
	 /3l4FmUWIfuQ6qET7i0lbgZxz5gYGQyhzNE9GHO/De8vc3QvL/E7PHfssZqWPBPCvpyN9
	 AyUj29HFXY/NSMkopSP0y8ltGeyS+MaUqnFEpoQu4OdDBSCxza3xCkkeYSN2FwgKYEsIH
	 zSkJCA10y9NQ4ESMMAC4ZgE2/MeTVnlluA+sXCqtYk43DqZs/6reKDNqWY9QSCVpe3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VebbXlBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B57606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VebbXlBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EAE1F000C4;
	Tue, 24 Nov 2026 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534574;
	bh=viZuXoQt+ROvfw8Edzwp3JM0IwCaNMa43QV51C+bLB4=;
	h=Subject:To:Cc:From:Date;
	b=VebbXlBJdNFK5mPtfyzWbKNOkfhAq26yxDOz1WY/1syPBUhsWKE77a9QAPEYJHU/Z
	 g01LWcePzDGo6nh+8pVug6x/Toyq4Ssrm9qAItb2kjb1s3Oxn/Zy+czFLX03z3B5VB
	 MdZAS7idEwE1/j+/wiTKZos97eqb/48vOA+aj+tA=
Subject: FAILED: patch "[PATCH] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,david@kernel.org,gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:36:22 +0100
Message-ID: <2026112422-swimsuit-outhouse-c2d6@gregkh>
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
git cherry-pick -x 6c48b3ab4ee435c41c3395d31e8ec3dbccc3478c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112422-swimsuit-outhouse-c2d6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c48b3ab4ee435c41c3395d31e8ec3dbccc3478c Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 22:13:31 -0400
Subject: [PATCH] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone

should_reclaim_retry() walks a zonelist and passes the zoneref pointer
to the reclaim_retry_zone tracepoint, which loads the zone from the
entry again to find the node.

Memory hotplug rebuilds the zonelists in place while allocations are
under way. When a zone in front of the zoneref entry has become empty,
the entries move up, and this one can be the end marker by the time the
tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
zone. Short of that, the event can name another zone than the one its
numbers belong to.

Pass the zone pointer instead of the zoneref pointer.

Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Link: https://patch.msgid.link/20261101021340.2251928-4-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..cbcf6fe4cc61 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -33,7 +33,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -41,7 +41,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zonelist_node_idx(zoneref);
-		__entry->zone_idx = zonelist_zone_idx(zoneref);
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 20bfd11c5851..c09eca21a6b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4670,7 +4670,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;

