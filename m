Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343E38F954
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044503; cv=none; b=QuTwUwIbOw94739tZ6ZoMQKnZGyUQMsFOQDubieowAJzpGuyvjEPdRsGumbcNvURe6uRbn6GE0zBaQGrSeBgi4L8DF14A4LtcIE6jf7O5SfljLsgMSqCAVrxye3SkmkeN/49S0UT2Iou8Bk/ABrWXROU1MIfocqguD6JuzksXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044503; c=relaxed/simple;
	bh=whZxFE06ngNi6m7iZYGv3lT4S6CYGGhwLE/SdTxm/LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvitVngsGQTVPfAVQoM7rWe9NuTBOUMfRMEOZUfYDWLby871rAtPlkqLa0inuD1SQp8N2D7BGVJGWpjfx8uZTh6G6fmHhbcIL7ObOiF0a7suG4UV7oVBcP6yOBFwA7L2dGTcnwyv/Myaz31+bcXgnSSwTmEw3UH9NAulmk3q4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZR6V2xjL; arc=none smtp.client-ip=95.215.58.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZR6V2xjL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=whZxFE06ngNi6m7iZYGv3lT4S6CYGGhwLE/SdTxm/LU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790044498; v=1; x=1790649298;
 b=ZR6V2xjLePExbG3feuqR8sCqRepq2VRl8vgEN9NogtbpC8rgxupWgt3kt3YtKV7J6TgD5NHd
 jSDLO8C5uat0Ebl1gsv+IhWENaVS0hSAIGH33V85Tb5I+0+FeTQb/AFIhAFuxkQs2OKWeSsO7+H
 4IJ5D5J1HuMTD3/qm5ktqurw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d068ef4ae6c970bb;
	Tue, 22 Sep 2026 02:34:58 +0000
X-Mizu-Trace-ID: d068ef4ae6c970bb
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Erhard Furtner <erhard_f@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH] netfs: Fix missing alloc tagging of direct mempool allocations
Date: Tue, 22 Sep 2026 10:35:41 +0800
Message-Id: <20260922023541.51532-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
adding a mempool") added a mempool for the folio_queues and made the
request, subrequest and folio_queue allocations distinguish between
writeback and everything else.  Writeback is part of memory reclaim
and must not fail due to ENOMEM, so it allocates under GFP_NOFS
through mempool_alloc(), which may dip into the pool's reserve and,
if that runs empty, wait for elements to be returned.  The
GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
the pool's ->alloc() callback directly instead.

The direct call, however, skips the alloc_hooks() wrapper that the
mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof()
and rely on current->alloc_tag having been set by the caller.  With
CONFIG_MEM_ALLOC_PROFILING_DEBUG=y this leads to

    current->alloc_tag not set
    WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_alloc_hook
    alloc_tag was not set
    WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free_hook

at allocation and free time respectively, as reported when reading
files on a CIFS mount.  The allocations are also missing from
/proc/allocinfo.

Wrap the direct ->alloc() invocations in alloc_hooks() with the new
netfs_mempool_alloc_noreserve() helper.  The GFP_KERNEL paths keep their
failable allocation semantics, they just get tagged now.

Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by adding a mempool")
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@mailbox.org/
Tested-by: Erhard Furtner <erhard_f@mailbox.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 fs/netfs/internal.h       | 3 +++
 fs/netfs/objects.c        | 4 ++--
 fs/netfs/rolling_buffer.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c79c8e69d60c..08ba7f0ebff0 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -45,6 +45,9 @@ extern mempool_t netfs_request_pool;
 extern mempool_t netfs_subrequest_pool;
 extern mempool_t netfs_folioq_pool;
 
+#define netfs_mempool_alloc_noreserve(_pool, _gfp)				\
+	alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))
+
 #ifdef CONFIG_PROC_FS
 static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
 {
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 7f6a3e912602..0b509c93d4af 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 
 		rreq = mempool_alloc(mempool, gfp);
 	} else {
-		rreq = mempool->alloc(gfp, mempool->pool_data);
+		rreq = netfs_mempool_alloc_noreserve(mempool, gfp);
 		if (!rreq)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	struct kmem_cache *cache = mempool->pool_data;
 
 	if (rreq->gfp == GFP_KERNEL)
-		subreq = mempool->alloc(rreq->gfp, mempool->pool_data);
+		subreq = netfs_mempool_alloc_noreserve(mempool, rreq->gfp);
 	else
 		subreq = mempool_alloc(mempool, rreq->gfp);
 	if (!subreq)
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index 424e77a9a109..54867ceaa205 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
 	struct folio_queue *fq;
 
 	if (gfp == GFP_KERNEL)
-		fq = netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.pool_data);
+		fq = netfs_mempool_alloc_noreserve(&netfs_folioq_pool, gfp);
 	else
 		fq = mempool_alloc(&netfs_folioq_pool, gfp);
 	if (fq) {
-- 
2.25.1

