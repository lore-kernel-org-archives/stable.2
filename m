Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549535;
	b=TwGFiCYkZ1v4wCGr+HNj+wsnA7JtActGSZxAruoCKW969fx0XodEDe4oMjrWwlm9WiK0
	 wl9YF74lnEW4PaXvYqWNzESHcWmRWIqFnvyrryk940exaj+vn+JkzaKeAUXmBIpjlmeCi
	 +PS6Mt1HRgeChyy7bLVWHgbv96FCehujpB98ZwMKKW11OjiaT1pBTdOshfe3IW1lB4fG2
	 IegZCmU+fdbR+7TSHX0L4QlurvWNzukzr+44d6jJW1iIkFgbRpUnmYUz0JJyH1usjPBva
	 mmi+i2BLwXBvyGGCLkFhsx8xy2qg/ILjr3o404T4qQ2GsgqMjOKgJOb9BnQwIXj+5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w52jrSjzV1zpaNiK504K+J1jf+MWiB9MI4m7AG71/+U=;
	b=t4x1u0jG4xjyy3/97xc0KDFWpJnAm5/RF8juBdtZaD6wvybwOrDTA7rB6DEw4V45hZBY
	 aX1xAmo8pp8/0TJ9HaRtSe5P+ZlTIC1eXu4sSGmsVCvtShszxOscpbsPG9gGubjsI/Pkp
	 kYEhB8pHYrdu97792W0PF2qim2ELflBf00H4sGpn9HkcfiCIjsluStaHaZPbQNC8JH9Gw
	 XFDTajGuDTH2nhbfuE7ckKcQgLNLzK1KZ2faEGN1G4fRqrUpQjtzDyQs1EJibMkM0bih9
	 6zqIRBEjQmHyA7C9x2hWjAounyyIJLH9tj+H1VnCoSTwPUZX28KRqHqf9LaCkTSYY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cg89Mv74;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD58606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cg89Mv74
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060391F000EC;
	Tue, 24 Nov 2026 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549534;
	bh=w52jrSjzV1zpaNiK504K+J1jf+MWiB9MI4m7AG71/+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cg89Mv74hjesdpF7md6CEWAAMrMWTAOpUyRWi09stuzk5VkvGYG3dexSPdl4vm6Og
	 2zJyoOB2AWJP5nCXwH52SHEEMS8Q45xjHZV3yXxVp4aTpbL/ToJ9vKgvng5U5v/rzq
	 YoDDo64Td8ZnTEH63303t9gBqR+/eB4s4W68/qTCRO9aGvzAc/YL8iuLtC6CKk6Clf
	 ZOb8fAO20e3Yu4gC8pYbeYP5dAZc9VmnOET1is6U8tKKo3bWJzjPdWwOL0Pwk/I2TH
	 ak1/fDoeGInPekJqyLqJEsvI+L1WdAxzxruXHq2lo74LcloD9Ibxua3fsIKaogV09K
	 K9SA1rK+9KKiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Tue, 24 Nov 2026 14:45:28 -0500
Message-ID: <20261124194508.2505154-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124194508.2505154-1-sashal@kernel.org>
References: <2026112421-resolved-agreement-533c@gregkh>
 <20261124194508.2505154-1-sashal@kernel.org>
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
index 135d4419d041b..dec556ed12fa6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4874,7 +4874,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
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

