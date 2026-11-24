Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543177;
	b=p9cTpXrHwQCsB3uN5JxnOQKky9OOYEFiBxeknCAHRHCLPd2oYW8q52k9B15Mypsh/ufM
	 vUTKamuaSf0TPx9HEio6UkBTZDMb+of65gVY4L77zUzFEfUg/b6LK5faUjRNveOnzNeyx
	 r82foRyf4QeZ2AGpwJyuVb0Q/tRnelyKXtHbi1z3BkimhhB2EqGwPFHiE7PqUt07cur8k
	 iN+5j7Gvh2W5swlbbkH+NsHKoYje+dvFWA+HH/zCCZUqFLiH04IDUGSKmS6CamYTTdZ7r
	 JI2NQF/Df1yaA4luLoNBHvur9K64m2x2abDrmMYplDZdm0XSDS4wbqoUpgKFV+OR8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4BfOdrLISYMmmS9szw+wBbP6qZGTsZ1lTAObslJcsg0=;
	b=Yhw8DPwIgOJd9IV1pKrDnhSUPdBhLYzJ7wRRa766L+xMt8Era1Vs+A8acYk79shdfcz/
	 jeNXOjhuzjNSC/AJSfX9oYWjSx+/NvbbYszOyRvMBzsSSkL6cXwLySDiU31X+vlUcuo01
	 M9Q7M+jXMf5KSSasKydG/9IZCy6No7z9Aq1NkenDC7JQKsdVQap5lfvpzYa/XkZUvX2g/
	 7NTVbNq0MIcH1mUgsnEvNElkve5oOQAzcwUNyWbgNbff8CNK0/AOohN/OOJ7ABsyhD2Xi
	 S7i4OH2DSeQg0YxWCrU2Zoa+o2udXKD8pOe9j1untTP5ZaGjaWo8RUd2TCd3VPkoDig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNhjdlNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BB606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNhjdlNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8D1F0156F;
	Tue, 24 Nov 2026 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543176;
	bh=4BfOdrLISYMmmS9szw+wBbP6qZGTsZ1lTAObslJcsg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNhjdlNv2Ob9oOhKeteK/EJ88xO9N9j+xe6HOS+qjNrtfAIoY0BfywMklQuYb6/lq
	 rkUlupT3AlnwscJ2nVckZumMawrm5zjFTMbEvJ1VL1jEsmpEtRZdIK1kF4cfRMdEB/
	 TWk/nszcG5C86MApKgqVjq07qdkCigEneSiBznMHAoSBT6NGows9v7s8GqPHxpqVAg
	 XY5+ZL/5iI0Ku7bvX9zIzQnHAiE610Q0hfvW7OVX4O9SV/pWEQanYrPM/Pa9x/lscK
	 cWtV4Bb1ngEDh1NTPEtyrdL/g2ZTLbpvECKdpbNNCli82UXg4rp8LQiaijwNhUnu94
	 Fn8GGAOsdV1ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Tue, 24 Nov 2026 12:59:33 -0500
Message-ID: <20261124175924.2153167-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124175924.2153167-1-sashal@kernel.org>
References: <2026112420-diligence-gift-dd3f@gregkh>
 <20261124175924.2153167-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 8c834a0d22817..008c62cc078b1 100644
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
index a9f36007f6778..f9321e1197f9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3894,7 +3894,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;
-- 
2.53.0

