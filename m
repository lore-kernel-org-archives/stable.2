Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545686;
	b=0Dg8Mg/Gf5ghoAMrDkC5AjyoSP8KCUAbJuyuH8+psk8cwbtI25imVX5E0rxzMqMayur/
	 GSSep/VHl3TvMCkzinuY5UgbPjlFEvMlbFHGngHWMxyv9qGU3CMYaQWN6CbF+msZBqNRX
	 SkncXCowFeRGopZkwa7Dt/tmaJ/Mde2W5flL2I3j/88ZcIFSro6su3NHk1nxsyVsVhswt
	 NpvUQgjWVKq9elHYfu4szAvG1DsHl6e5XMWnLGAR1/IOaUIWDQjSfY4UDQvpsTQ5d2KlD
	 ThysLfK2U2HWPHOLGvN2cBmBmme3GmNTs4t3Bajq+MsNUUJDjK/R1BRbPMWqm0KEN+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hl/bX5DuVZchMo6SL6jKXGgpfSjzwnMjbakQZjrbrQM=;
	b=kesu1M6PqvupLl3g6FM2rNSJEWgre2No5+VZx/eMdtpAYR7ylQGAoMOgc6j+gRPcrd0F
	 TjHgYWmoc+tkJOQItQgFeuvNv91xZIhOs1lHz4iZ+5jGZbwlPXGEjfBYsssAurW8GpvG6
	 z1gvEs6tskGpgfjpMs2QqruyiE36eZpT2ik6WqtX61HlJCHIzL3bqektQAws4Y+54fBq1
	 vsIt3KJE2g82fzIg38Y+Y8LFnDrxBix2OsaW8ZmsSLjwmf4PSRL0C8sodpBFpx2jwYp4e
	 nM8z2FkcT2g54rmCCcrpgjfgF+IZClPd+JpkjhfS1xzLDP1bVPT/I6OkuriZ6DRA7vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFTaMFxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C36606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFTaMFxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5461F000D8;
	Tue, 24 Nov 2026 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545686;
	bh=hl/bX5DuVZchMo6SL6jKXGgpfSjzwnMjbakQZjrbrQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFTaMFxtelVPxapnuFKPNOAYW6CuD8o1OIWPIgx3LDXVbjw9/4eIOexpA3svNFUcP
	 UbS1uyZFgXkkUEESGsUUu92M5qayQFn3dPKf+pEaYkEGYxQynfDYah2s43wVOqf3Ay
	 pO4w0+1CVE/z+gxPR72myzwarRCPGGHZlsyxXTK5rLruPmRfDV5zP6CvUS4BtduzMt
	 ZwjXtbhBLy+WKD99OnQA5CEa/pQVQs4HTG8weHJPhHRKHVgr8BwqL43QoyaFnNK7+W
	 +ELM+d6VkCOPEJnhBHCcFgXDVfUXifFAlSpvaFb7GBZU5DfPJ1+Ty2wqdYFMPy23/4
	 1FVc7Vz9oLAlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Tue, 24 Nov 2026 13:41:22 -0500
Message-ID: <20261124184032.2321147-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124184032.2321147-1-sashal@kernel.org>
References: <2026112421-retrace-illusion-ba9a@gregkh>
 <20261124184032.2321147-1-sashal@kernel.org>
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
index 5b5a64db3f3be..1db53951ff585 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5043,7 +5043,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
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

