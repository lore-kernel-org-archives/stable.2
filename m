Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A372509EE2
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098347; cv=none; b=ZzeOGPx2zisRbJeTvQf3Nd7JaTFqWk1k94oBXf5G2QjDRwYrYJg91LQxBicGzcCHEXtf5yRCz24ZHK9ffMfZYO930CNT/UADmH4pyIBtEGdI7Oyz6eT5vDzI22eUWf5anhQdPXmS27uFwbcS5T1ZrrkpvGlX+E33vjs3ORbzA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098347; c=relaxed/simple;
	bh=aOCBkB1ohjW/2eEMaXRNHBXwAny3o8OCwYXHqgLf9H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1qPl7IcCcwLObOEjmMTqgB+gZCk2tHS4iKEYS/0Nwjb+eypSxR3Ane/WVyZsuJnEAvRq/ek8Bhz3lCvxk94TrDj8HLJvdneaxZvmUJXp63YZF6Kpn/dDDVZapI3QV2jcEbxiDrG4qPF3TjDwDY4alB3L4cYG0HEhbp69LwPDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EjIbK7Kj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EjIbK7Kj"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a20e9efeso80522286d6.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792098343; x=1792703143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ncaxmlrNNhxOdRmkKnio/byckek+qNzzNxHvBVY91N4=;
        b=EjIbK7Kjpxf2YT3DyE7L4UfEkLVCRY0Qg6K3INUyj/eQFCirmHGP1SuYRpRjFdO/Dv
         V4oAnjnMB1hTl0B4nQQEy9eyWm6o/0wjGFSKL+qVhuxAi2qKrBqPyMeoHBRqXTzROEbw
         tg8vJ7elASquQJyzWDjT7jhXYBtVC5TXIScesmvn6CZ+QGdpLvElRhyLyiyg07MpBcps
         hOq1CjzsIii3AjApiV+IfthHGfy8+TdUZ7ptYfmxKXvlm1YUaYKnU8N7sxHRmicMSyM3
         onLZ66xe3y17rRcC4WA63lfz+gFBPkWfuxpmf8veFfZsppS7zkeneGDuwX5l+IPKaNqx
         6nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792098343; x=1792703143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ncaxmlrNNhxOdRmkKnio/byckek+qNzzNxHvBVY91N4=;
        b=SxTYqHWoyNROC6C6QEmWK8tmf7J12MvEOHfnmOMMIP5o01nshtQ5ekhF6DFKYreEqv
         xoF87g73iWVq6GLVcjTUXus+KM3K6KJULU+gGa8rtOAmWcQFsU/JYR0MVaKe3w4xrzYq
         xUtLmcXSIAWk60OHsqAB4wC8ghbt4uyKq/2OqoTL/Jnc4tl4enFzVEp5Wun43x5njKeq
         FiDm1X+cHK8/+XSOkm/YejqTL24/pIe6zIO98oX8HPBJITEi9tp8sm7vj+CMxOr/tpnr
         iCenmbdKUnBrst6BsjdR7qLXaKR4FyCsbSVHACGplHfC08wIMs01KOD8b9OdpNl8Ltdr
         sOqA==
X-Forwarded-Encrypted: i=1; AKwUvBywUpsOK0mzujyDtV6mUS/At+yoIPeNDb9kihc3OUEjku71AbDIR4Gr21ltb8wbwYDdN33qyZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTOjyYOekpoKWo2zu5rWmXa8QuOyZ+0SOsl+RtJClaCqM/TD7e
	oSOLLwCr9hO9la2Bj3ntxb3vkMVZNUitZnnJQ1D4dxrvGUoMJjnCYY6qkBzHscGvZ8M=
X-Gm-Gg: AYBFou224BCZD2SU+mEuZYzfCmmh07ZGhMgagthkSxskoGkrvQXpVWtkijaQf1zJFig
	y6GdtaVuAvqy+jrwcvZbdl45ALh6fiB3zt9WCgF/oHZoapHrFQyqIFZlNGrGaP0UZtBZAwTG7BY
	HpfsSTVCsWu9VrFcJjs+R/O8Pq/98Wj5Bh70H0yZ+gR/groJZpxd1fQbpvs4CEt/Ifz7oH13h8Y
	RE3IaiS2VJNiv7QZ1U0GUfX+IfSmKe+edq0pBvBaYj8JgqGm/a46MyiQCVH3hWod9StScZUQ60D
	wIhwojbzoS+QfxPdOz0JYJPnuj4Yk9oJbrHQg1IlLP8a3uadX59N35yZ4Yaf5N+7TXycoo/c4/P
	bV+9XEV7FdcVwbz8tqZQkXj+cMPyTavyZReO0aM56Dr0ckK+SWgwQUJjahU/WB+ZuPSdTVmky24
	VA2extYk+vbWlxcTsKEVBJlqusI84fMuyYaNFV5EgUw/7LlT94qlGDmepBURItzZqD+UHProHjZ
	s5WjW5oLZI6NkVzhPXlx2bL0f7Zoc+ORnfDqlzj90q0n8+FeFRes+AO/mGk
X-Received: by 2002:a05:6214:4497:b0:917:edd4:d1d5 with SMTP id 6a1803df08f44-91b557bd604mr362771606d6.42.1792098342597;
        Thu, 15 Oct 2026 14:05:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbbb0d44sm5187326d6.47.2026.10.15.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:05:41 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: validate zonelist slots against concurrent rebuilds
Date: Thu, 15 Oct 2026 17:05:39 -0400
Message-ID: <20261015210539.3243563-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Onlining the first block of a zone (e.g. via virtio-mem or a DIMM)
rebuilds every node's zonelists in place. An allocation in flight can
then be served from a zone it never asked for: a GFP_KERNEL allocation
can get a page from ZONE_MOVABLE.

The allocation succeeds, so the zonelist-retry logic never triggers,
and an unmovable page in ZONE_MOVABLE breaks offline of that block.

Recheck each zone the loop visits against highest_zoneidx and the
nodemask, using the zone pointer itself. This covers both cases and
is a no-op without a concurrent rebuild.

Reproduced with a kprobe harness holding a GFP_KERNEL|__GFP_THISNODE
allocation across the online.

Fixes: c33d6c06f60f7 ("mm, page_alloc: avoid looking up the first zone in a zonelist twice")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ed36ba4d055..a1254f2e1892 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3782,6 +3782,19 @@ static inline unsigned int alloc_flags_cma(gfp_t gfp_mask)
 	return ALLOC_DEFAULT;
 }
 
+/*
+ * The zonelist can be rebuilt in place while it is walked, so the iterator's
+ * filters may have passed a slot that now holds a different zone.
+ * Recheck the zone itself before using it.
+ */
+static inline bool zonelist_zone_valid(struct zone *zone,
+				       const struct alloc_context *ac)
+{
+	if (zone_idx(zone) > ac->highest_zoneidx)
+		return false;
+	return !ac->nodemask || node_isset(zone_to_nid(zone), *ac->nodemask);
+}
+
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
  * a page.
@@ -3810,6 +3823,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
+		if (unlikely(!zonelist_zone_valid(zone, ac)))
+			continue;
+
 		if (cpusets_enabled() &&
 			(alloc_flags & ALLOC_CPUSET) &&
 			!__cpuset_zone_allowed(zone, gfp_mask))
@@ -5234,6 +5250,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
+		if (unlikely(!zonelist_zone_valid(zone, &ac)))
+			continue;
+
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
 		    !__cpuset_zone_allowed(zone, gfp)) {
 			continue;
-- 
2.56.0

