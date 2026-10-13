Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DE371068;
	Tue, 13 Oct 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851228; cv=none; b=mWBkMfAVHl9f5g+ewNwiKqYF+9wn1r68gRClGGV0KfJog60naR/vc9ZZ1Jbr6R9qxCz0f0Y+aJR/P0eDJlbDa5D7sHtByKRU/2lP9PU86jyywzMi2YCtXZ7cc+F/LlseHt9Ave7ugPT0Rc40pJtfTTiQuyoNd0vU+p9wRrExUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851228; c=relaxed/simple;
	bh=ac84fA9Xlz6n/G3G6c1lu7kdxnKvzIRZKJQUWfPifHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CixFP2yPgN81AR2w8N/V+xYla5P3E1R8WufEkWPtBvKzWHHy6uOgcoRZLWOHpyRZVtoW3vigJs4QziYabBiX5g4QAq/3UErNIRMZ7s8DseUwCzxo/r3XaeB5o8Fhh32DCKsD4HgeDIUCxbOoeovMCldw3fdiCDoEP3EesJifBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGQMC-00GgqH-Be;
	Mon, 12 Oct 2026 20:27:04 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 3/3] ida: free the preallocated node on the ida_alloc_range() failure paths
Date: Mon, 12 Oct 2026 20:27:03 -0400
Message-ID: <20261013002703.773923-4-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013002703.773923-1-nickolai@csail.mit.edu>
References: <20261013002703.773923-1-nickolai@csail.mit.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When xas_store() in ida_alloc_range() fails for want of a node,
xas_nomem() allocates one into xas.xa_alloc and the function retries.
The retry either consumes that node in xas_store() or, if it reaches
"out:" without needing it, returns it through xas_nomem(), which calls
xas_destroy() when the state is not -ENOMEM.  Two exits do neither:

 - "nospc:", when the retry finds no free ID in [min, max] any more.
   The failed round stored nothing, so this means that another
   allocation took the IDs while the lock was dropped in xas_nomem();
   exact-ID callers, ida_alloc_range(ida, id, id, gfp), are the usual
   way to get there.

 - The -ENOMEM return at "alloc:", when the retry needs a bitmap and
   both the GFP_NOWAIT and the gfp allocation of it fail.

Each occurrence leaks a struct xa_node (576 bytes) from the
radix_tree_node cache.

Call xas_destroy() on both exits.  It is called with the lock dropped,
as xas_nomem() itself does, and it is a no-op when nothing was
preallocated.

This was found while formally verifying ida_alloc_range() against the
kernel binary.  Add ida_check_retry_nospc() to the
tools/testing/radix-tree harness: an exact-ID allocation whose first
store fails loses its ID to an allocation made in the window where
xas_nomem() has dropped the lock, for an ID in a value entry and for one
in a bitmap.  Without the fix the harness counts one node still
allocated after the IDA has been emptied.

Fixes: f32f004cddf8 ("ida: Convert to XArray")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 lib/idr.c                           |  5 ++++-
 tools/testing/radix-tree/idr-test.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 86c572e60f75..468a9b7adb14 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -473,13 +473,16 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 alloc:
 	xas_unlock_irqrestore(&xas, flags);
 	alloc = kzalloc_obj(*bitmap, gfp);
-	if (!alloc)
+	if (!alloc) {
+		xas_destroy(&xas);
 		return -ENOMEM;
+	}
 	xas_set(&xas, min / IDA_BITMAP_BITS);
 	bit = min % IDA_BITMAP_BITS;
 	goto retry;
 nospc:
 	xas_unlock_irqrestore(&xas, flags);
+	xas_destroy(&xas);
 	kfree(alloc);
 	return -ENOSPC;
 }
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index f1e0be0e09ec..4b862f2080cf 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -522,6 +522,29 @@ void ida_check_retry_stale(void)
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
 }
 
+/*
+ * The node preallocated by xas_nomem() must be freed when the retry finds
+ * that another allocation took the only ID in range, whether that ID lives
+ * in a value entry or in a bitmap.
+ */
+void ida_check_retry_nospc(void)
+{
+	DEFINE_IDA(ida);
+	unsigned int ids[] = { IDA_BITMAP_BITS + 5, IDA_BITMAP_BITS + 63 };
+	int allocated, i, id;
+
+	rcu_barrier();
+	allocated = nr_allocated;
+	for (i = 0; i < ARRAY_SIZE(ids); i++) {
+		id = ida_alloc_window(&ida, ids[i], ids[i], ids[i]);
+		IDA_BUG_ON(&ida, id != -ENOSPC);
+		ida_free(&ida, ids[i]);
+		IDA_BUG_ON(&ida, !ida_is_empty(&ida));
+		rcu_barrier();
+		IDA_BUG_ON(&ida, nr_allocated != allocated);
+	}
+}
+
 /*
  * Check handling of conversions between exceptional entries and full bitmaps.
  */
@@ -594,6 +617,7 @@ void user_ida_checks(void)
 
 	ida_check_nomem();
 	ida_check_retry_stale();
+	ida_check_retry_nospc();
 	ida_check_conv_user();
 	ida_check_random();
 	ida_alloc_free_test();
-- 
2.53.0

