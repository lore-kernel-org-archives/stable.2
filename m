Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534560;
	b=haEwsPRcHV25VRtdEgfvmRfFFt5izaQciJDONFgFaaKZq8f9OR4enHno6qzsSlsTejuE
	 yAr8lQUkuAB+c8lGEdmG8tT/kvGxEZekOtXafH4eBZAjp3fbNTHbma5izTmnLseFXat6U
	 9NGx+3eKmPKOH+kMus3G3VWAKe5Ao8mMu5z4phDAgkQgp6NwI0euLDYt8zMiZE37xCBcx
	 5UXMadYrjIA+43vOhC8WNgeN7gttuEYBjQ5ZB4PifuwcPzyoJjfEZrHeaFSROBavRu0yK
	 96tzQZXnGu95VU6Btvxao7PvDpy8lLIyDJ1vBEp9m1ZGAalrdSveV3rl7QUSRR4eL+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534560;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A6V2JwCOj+0RssqSlfBNT698dfMCswQXAEPDTkyDhiY=;
	b=5CYtYhr9uA9v1AXpOdJmAHAP13FHAIKillkw8SVl3w4a3kel50sYailEt4hJBfvXIyf9
	 lgPScM9TEELfxzJgzp5HN+CrjYIGTdJAx/pX53uyj5p+QKfUXmVe2QcCLYio8Tzw4SJpn
	 wG+r6osx5c/f7hQg3eb+/ph8Mmf/ucSzgtEegd/FpZUpYSVoFnlBwghh/1jRXRY6MuPYX
	 LMbyRJze97+WyRnYoNmJcmIViccPAJlHkZtcxjqx4foyo/IRF5rK29/86IP+jukqNxxg6
	 lKjLk8M27RQFj8vQCBy76t/a9+C7vEU33jPisN7l7KZg/hS7jaj33/7zSvyS6ni2SGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yt3psuft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358B606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yt3psuft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA31F000C4;
	Tue, 24 Nov 2026 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534560;
	bh=A6V2JwCOj+0RssqSlfBNT698dfMCswQXAEPDTkyDhiY=;
	h=Subject:To:Cc:From:Date;
	b=yt3psuftiVibqIKEow35QB7OhZSbMfPZOCz4heHUl1kV6DlTH+2yN4mRA3PcYPSoR
	 lJSKeC9zJrHGqLqjXoY1/065yEZUdbx3hPquVLqLZkQm4ZVeIgiNdhWBP9R/9EIJXS
	 /mpOYxroHfv9pmCQjPLkpIljmJd6jBune/RQjndY=
Subject: FAILED: patch "[PATCH] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone" failed to apply to 6.6-stable tree
To: josef@toxicpanda.com,david@kernel.org,gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:36:20 +0100
Message-ID: <2026112420-diligence-gift-dd3f@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6c48b3ab4ee435c41c3395d31e8ec3dbccc3478c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112420-diligence-gift-dd3f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

