Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAE37475C;
	Tue, 15 Sep 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458593; cv=none; b=Q9lF4sXBF4rLWhKJIFh/rfQoug1J4I/QgprhXBCgBNO0+70CPp699W2+FgYouLlYkcedbdHp4rQdJeCW0SDKPf4o4g3eMuT5dpUb2CaFoWde4DIPqxXBaTha1KlsRCmvIQoiGv0JyqkLfbyl1rPe5SKEdhK5tlGNXyudFeJkylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458593; c=relaxed/simple;
	bh=cw7gLlAxbZuTtB38KE0IoqDYFKA/59Z/vrsA+PUuN44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJwh4X3YsCtIGCl9xPzVsDXkGCJbOu2qclgUcEI+Ojl2rhN7Nsz2gHqIS1lw0Lvn1PCncmn34GjZle8tb300WyQZXzcUT8v8pm1wpkAlLkHqoKXRQNi7QkjqQ3FqFVZ4epVQFTR3KmPHz/H8ojfq+YlHhLF3mp1eqpnWLzj3GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 03a7a7cab0da11f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8f2ab040-5536-41ad-8532-fb9d25d4391b,IP:0,U
	RL:25,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:50
X-CID-META: VersionHash:7db8b62,CLOUDID:698a00d3bc0c39f0ec6b3b8d823d0796,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:99|11|95|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 03a7a7cab0da11f19a56ed5b684f684d-20260915
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2140594793; Tue, 15 Sep 2026 15:49:43 +0800
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
	stable@vger.kernel.org,
	Qiqi Liu <liuqiqi@kylinos.cn>
Subject: [PATCH v3] mm/page_alloc: apply per-task GFP context in bulk allocator
Date: Tue, 15 Sep 2026 15:49:28 +0800
Message-Id: <20260915074928.327471-1-liuqiqi@kylinos.cn>
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
PF_MEMALLOC_NOFS, PF_MEMALLOC_PIN) are not applied on the bulk
fast path.

By ignoring PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS, the allocation can
theoretically result in a deadlock.

Ignoring PF_MEMALLOC_PIN also has consequences: without clearing
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
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

