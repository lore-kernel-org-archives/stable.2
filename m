Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550711;
	b=E0CRqU3C2Ss8hbU4hQUYd+tDbEnO5kRQf5tNNns1YtdTIm3cz4XDjUN+QZgvSqx5Mxgy
	 OpPIrcV0a1jo69FW8QCZ4+G9pIIFrq+9wjTvB/XNxpkpa22C1kF5Q+gUcLOXCgGH2RhQY
	 MxVPDV+UgviS2foW+JC4KdpIfJM50z2Kdo6T1JA+KNRr8tI9xpadtMMjNatrpqs9rdJfV
	 g7c40/x4VbxomNtICrlm4Iego+uZ2A3okwMGWnZLNqiTKLQXcnK+YRStoxHkz6El0msHx
	 4KdbZKOk/ttvOSBbQG9+T5XeV1VI59HvhEvoU9jfh3OJukmUk64xLXhb4cpbyD0FKTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550711;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Iee/PfzPgnDnguWLtiyx4rPx2P1n0IhYpp+nC26m2fA=;
	b=AIWhShpjeZ0CmS5GYazCVMUjcimBpEjCZ76NahUdPHVh+bNZcni9K8ly+MsnfMVWGOkq
	 4IWY4SN937znkYTM70bPFpi4vb7fHrQUe9i+oM6ncnItqQ0saTRw7Xk72SmChikVwWeWx
	 fsp7mGwsQd7Jsh5Mu+skMwG58EGQYhIkgtKb+u2vfHiUBVt0vMduBEgVRYFsrzu7A7V1s
	 Ua4LPHP+EP1ejtc55tl3x6i7Z/Bc1gIRI9JFrI+qIAwBJJLp9unG8MJ76G0x2xYJW/OKx
	 wFtJrjbtX7NU4NvEfA/28XeECbbVRegskJIgyWXchEFcKYP+e7wBesxDp5/F2uIvzCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZW7H3XT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C5606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZW7H3XT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2450B1F000D0;
	Tue, 24 Nov 2026 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550711;
	bh=Iee/PfzPgnDnguWLtiyx4rPx2P1n0IhYpp+nC26m2fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZW7H3XTZ/yF8fxWfLSDnV+Qeyvi3n4yYAdgEcUgj/8ipNd9OY1frOGTqowbT6id+
	 9paYPH0eWjbxV6LJcabYfM8dIQSU9f0OrRKKG7HFmAgrcKenQoVJQUe6IW9jGcINK7
	 LVQVogjHNaCazW5dNqcG4Spt/dcWKCa4kgpU60tLH9AumQp5PcNNdDziUd5RBVfcxB
	 hS7JQSP9yIuPcbXjcO3HNk6zBhVL9aKn6+KF/dhnWqxiDS5mPENYVJsLSwyTjx6p8F
	 hlJTYs+TLlr4KXYkkmcX2pvr+t/+ieGYWp6KFVdgaZn2FMjEr2WBk8vetgTwtP/rRz
	 e5vvelzhPYY2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Tue, 24 Nov 2026 15:05:06 -0500
Message-ID: <20261124200341.2541828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112422-swimsuit-outhouse-c2d6@gregkh>
References: <2026112422-swimsuit-outhouse-c2d6@gregkh>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 6c48b3ab4ee435c41c3395d31e8ec3dbccc3478c ]

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
[ sashal: Replaced the TP_fast_assign lines that used zoneref->zone and zoneref->zone_idx with the new zone-based ones, since this tree lacks the zonelist_node_idx() and zonelist_zone_idx() helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index b799f3bcba823..008c62cc078b1 100644
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
-		__entry->node = zone_to_nid(zoneref->zone);
-		__entry->zone_idx = zoneref->zone_idx;
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb0614988479a..294ff057821f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4573,7 +4573,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			/*
-- 
2.53.0

