Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766893ACF16;
	Mon, 14 Sep 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373104; cv=none; b=lR8kpXo+pA0RCc5YXMJDzJu8rmA8N5Q4laPRkoo1bR7/F3gqE5FW4k4tBSJ0IOCiXcNN4nWDNtYXcJNY6RuAiplABZB99KhdiC5WcVRMks+v5ip3UCIwYSUdPNVKKI8+tqnuyFt2eGWt9cy2SPpTExtdtpfjy9ncgD3Eu/PURVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373104; c=relaxed/simple;
	bh=bnDie4ATY9L7KljtTBcFIsi5Hc5gLseEnKmWnnnaZ/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmUnb1kCN8Mt4ofYYvfLhPkJrmov8iJ+OJsC9yGRgDi51o6nLf9YYPr+ebactLfrkyBBG6QaZ6S9DfebLBD1ODpBRtfcrAwo7FfaYjxOsDVD+tChzrMrD2wDa7tyuqWpJaLxxXNhGgD7B2oMTb+G6bPQrfa+v7BDLJKkXrfm7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f87bc8d0b01211f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a3771e0c-53e6-4c4f-922d-0948eb8dba23,IP:0,U
	RL:5,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-META: VersionHash:7db8b62,CLOUDID:f7d32dfd53290b8c3cc408f3885045e8,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:99|95|82|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f87bc8d0b01211f19a56ed5b684f684d-20260914
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 873099512; Mon, 14 Sep 2026 16:04:54 +0800
From: Qiqi Liu <liuqiqi@kylinos.cn>
To: akpm@linux-foundation.org,
	vbabka@kernel.org
Cc: surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qiqi Liu <liuqiqi@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: apply per-task GFP context in bulk allocator
Date: Mon, 14 Sep 2026 16:04:51 +0800
Message-Id: <20260914080451.294896-1-liuqiqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_pages_bulk_noprof() does not call current_gfp_context(), so
per-task scoped allocation constraints (PF_MEMALLOC_NOIO,
PF_MEMALLOC_NOFS, PF_MEMALLOC_PIN) are not applied on the bulk fast
path.

The most direct consequence is PF_MEMALLOC_PIN: without clearing
__GFP_MOVABLE, prepare_alloc_pages() selects MIGRATE_MOVABLE for
the PCP list, and a task with PF_MEMALLOC_PIN set receives movable
pages from the bulk allocator.  Once pinned, these pages can no
longer be migrated but remain in MOVABLE pageblocks, violating the
mobility contract.  This can increase fragmentation and interfere
with compaction or contiguous-memory allocations, eventually
surfacing as higher allocation latency or allocation failures under
memory pressure.

Found via review of the bulk allocation tracepoint hooks [1].

[1] https://lore.kernel.org/all/20260907120949.418450-1-liuqiqi@kylinos.cn/
Link: https://sashiko.dev/#/patchset/20260907120949.418450-1-liuqiqi%40kylinos.cn
Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Cc: stable@vger.kernel.org
Signed-off-by: Qiqi Liu <liuqiqi@kylinos.cn>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..3be7288a1aa7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5207,6 +5207,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
+	gfp = current_gfp_context(gfp);
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
-- 
2.25.1

