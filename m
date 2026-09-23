Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620243DEBC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145432; cv=none; b=MKBvGRlQFgpXPSxXzpUqJR2V08PaQ/oBuSCohcqTyGEtxvf/eqM9Edp7ihSu0zb5leOvcegF7/3wwYhZ8kQwpRa0zFyIjDW8LL2WrfdahW6uXjUIqwLHxc72rsYUKuv+lCxpNDvQgmKfQMIa5eCBgVHx9hjkwRURg9TgTeDM4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145432; c=relaxed/simple;
	bh=q6FUjfAvrde7ObIfU3V3bTgB9v/JDqJhh9doDVfzOdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpHHU9xo8FOibC33e1PfvRz9X9HMH+ZYOm53VDCaoqoSJBAYBOVKrAJGxSZIj7+8mIBilcIHZrvVvO0RGSYdWZ5JMQOBm6WEMjKNsnFVUoKUOkXj5hY/gSEU8tR5uByxWQPxfuGRD0/5EZgSBLiuZHltjVrKH1CKBOXvcc7X2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVFv/uIS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVFv/uIS"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q6FUjfAvrde7ObIfU3V3bTgB9v/JDqJhh9doDVfzOdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790145423; v=1; x=1790750223;
 b=eVFv/uIS+I1VHWvWtO6OR22sC3Wuuezbinq6fogB4nWW7v6eQkWcSATeQY8bdJ/bU8mATOlw
 567/twCJ84E0AErl7Ic1oz6B3YECEkoGeliM3lgzczHhxv4vCHLsVigRFA3csi5PAoeOQGLVrMf
 g65B3MkOV26laY79W7spbPIM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7a7d515496bbdaf5;
	Wed, 23 Sep 2026 06:37:02 +0000
X-Mizu-Trace-ID: 7a7d515496bbdaf5
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	Erhard Furtner <erhard_f@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] netfs: Fix missing alloc tagging of direct mempool allocations
Date: Wed, 23 Sep 2026 14:37:59 +0800
Message-Id: <20260923063759.34667-1-hao.ge@linux.dev>
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

Wrap the direct ->alloc() invocations in alloc_hooks() with a new
mempool_alloc_noreserve() helper in include/linux/mempool.h, next to
the other alloc_hooks()-wrapped macros such as mempool_alloc().  The
GFP_KERNEL paths keep their failable allocation semantics, they just
get tagged now.

Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by adding a mempool")
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@mailbox.org/
Tested-by: Erhard Furtner <erhard_f@mailbox.org>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
Changes in v2:
- Move the alloc_hooks() wrapper from fs/netfs/internal.h into
  include/linux/mempool.h as mempool_alloc_noreserve(), per Suren's
  suggestion, so it is not netfs-specific.

v1 Link: https://lore.kernel.org/all/20260922023541.51532-1-hao.ge@linux.dev/
---
 fs/netfs/objects.c        | 4 ++--
 fs/netfs/rolling_buffer.c | 2 +-
 include/linux/mempool.h   | 7 +++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 7f6a3e912602..ad549daa9c79 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 
 		rreq = mempool_alloc(mempool, gfp);
 	} else {
-		rreq = mempool->alloc(gfp, mempool->pool_data);
+		rreq = mempool_alloc_noreserve(mempool, gfp);
 		if (!rreq)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	struct kmem_cache *cache = mempool->pool_data;
 
 	if (rreq->gfp == GFP_KERNEL)
-		subreq = mempool->alloc(rreq->gfp, mempool->pool_data);
+		subreq = mempool_alloc_noreserve(mempool, rreq->gfp);
 	else
 		subreq = mempool_alloc(mempool, rreq->gfp);
 	if (!subreq)
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index 424e77a9a109..d30d5ef6d86e 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
 	struct folio_queue *fq;
 
 	if (gfp == GFP_KERNEL)
-		fq = netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.pool_data);
+		fq = mempool_alloc_noreserve(&netfs_folioq_pool, gfp);
 	else
 		fq = mempool_alloc(&netfs_folioq_pool, gfp);
 	if (fq) {
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index a0fa6d43e0dc..6da502aef2f7 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -70,6 +70,13 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
 #define mempool_alloc_bulk(...)						\
 	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
+/*
+ * Allocate a new element without dipping into the pool's reserves or
+ * waiting.  Returns NULL on failure.
+ */
+#define mempool_alloc_noreserve(_pool, _gfp)				\
+	alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))
+
 void *mempool_alloc_preallocated(struct mempool *pool) __malloc;
 void mempool_free(void *element, struct mempool *pool);
 unsigned int mempool_free_bulk(struct mempool *pool, void **elem,
-- 
2.25.1

