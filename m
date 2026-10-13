Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D52D7DF1;
	Tue, 13 Oct 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851227; cv=none; b=Tgox2P58NFn2Vl1s3ZcmuIMlnCPk/H3jrtHF4Sp6gLpQiouArae0Y2EqIaK3rUWalK8NMyG81OfiYlah4xh2bsMqpwrsN7mfKZuEasr3wN1FLeL8E+Uux5/lyKnrX2nhRTpldI8V8vb8O8cqtLt2TG11h0MQ8gW+yZMXEWXveM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851227; c=relaxed/simple;
	bh=bOsZ+L3ozG/XnUPs5KwYo2nM8AbJ8S6DtGVtMKevpqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV9Msi72IL0jDdEiu1Mxmzjb6mYa3jwWgTB5ox2+j7+6WnS1ztR+bHO5LA2r7p3e2w148qi+kd5M+qQ/3bHWcCymRV9ZCzez3CaABG0+RCj/UyK2d1D+BF6D8W0d2Yf+OmFKSw1VQdO/q7uX+KNaNgPrp7D/k5Z3IZhMg/jRRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGQMC-00GgqH-5y;
	Mon, 12 Oct 2026 20:27:04 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 1/3] ida: clear the bit of a bitmap that ida_alloc_range() failed to store
Date: Mon, 12 Oct 2026 20:27:01 -0400
Message-ID: <20261013002703.773923-2-nickolai@csail.mit.edu>
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

ida_alloc_range() sets the requested bit in a new bitmap before it calls
xas_store().  When the store fails because xas_alloc() could not get a
node with GFP_NOWAIT, nothing is stored, but the bit stays set.  If the
bitmap is the one preallocated at the "alloc:" label, the retry after
xas_nomem() reuses it.  The lock was dropped in between, and if another
allocation stored a value entry for that chunk meanwhile, the retry
converts the value entry into the bitmap by writing word 0 only, so a
stale bit at position 64 or above survives into the stored bitmap.

The result is an ID which is marked as allocated but which nobody owns.
The retrying caller gets the next free ID instead of the one it asked
for, an exact-ID caller (ida_alloc_range(ida, id, id, gfp)) gets -ENOSPC
for an ID that nobody holds, and the bitmap of that chunk never becomes
empty, so ida_free() can never free it.

Clear the bit again when the store fails; it was never visible.

This was found while formally verifying ida_alloc_range() against the
kernel binary.  Add ida_check_retry_stale() to the
tools/testing/radix-tree harness: it runs a second allocation from the
node cache callback, which fires in the window where xas_nomem() has
dropped the lock.  Without the fix the caller gets ID 1101 instead of
1100 and the IDA is not empty after both IDs have been freed.

Fixes: f32f004cddf8 ("ida: Convert to XArray")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 lib/idr.c                           |  2 ++
 tools/testing/radix-tree/idr-test.c | 53 +++++++++++++++++++++++++++++
 tools/testing/radix-tree/test.h     |  4 +++
 3 files changed, 59 insertions(+)

diff --git a/lib/idr.c b/lib/idr.c
index 69bee5369670..f298660f5c80 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -450,6 +450,8 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 			__set_bit(bit, bitmap->bitmap);
 		}
 		xas_store(&xas, bitmap);
+		if (xas_error(&xas) && !xa_is_value(bitmap))
+			__clear_bit(bit, bitmap->bitmap);
 	}
 out:
 	xas_unlock_irqrestore(&xas, flags);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 945144e98507..f1e0be0e09ec 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -470,6 +470,58 @@ void ida_check_nomem(void)
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
 }
 
+/*
+ * Run a second allocation on the same IDA while ida_alloc_range() has
+ * dropped the lock in xas_nomem() to allocate a node.  In userspace every
+ * GFP_NOWAIT allocation fails, so an allocation in a chunk which has no
+ * node yet fails its first store and retries; the node cache callback runs
+ * before xas_nomem() allocates, with the lock dropped.
+ */
+static struct ida *window_ida;
+static unsigned int window_min;
+static int window_id;
+
+static void ida_window_alloc(void *unused)
+{
+	kmem_cache_set_callback(radix_tree_node_cachep, NULL);
+	kmem_cache_set_non_kernel(radix_tree_node_cachep, 1);
+	window_id = ida_alloc_min(window_ida, window_min, GFP_KERNEL);
+	kmem_cache_set_non_kernel(radix_tree_node_cachep, 0);
+}
+
+static int ida_alloc_window(struct ida *ida, unsigned int min,
+			    unsigned int max, unsigned int other)
+{
+	int id;
+
+	window_ida = ida;
+	window_min = other;
+	window_id = -1;
+	kmem_cache_set_callback(radix_tree_node_cachep, ida_window_alloc);
+	id = ida_alloc_range(ida, min, max, GFP_KERNEL);
+	kmem_cache_set_callback(radix_tree_node_cachep, NULL);
+	IDA_BUG_ON(ida, window_id != other);
+
+	return id;
+}
+
+/*
+ * A bit set in a bitmap whose store failed must not be stored by the retry
+ * once another allocation has put a value entry in that chunk.
+ */
+void ida_check_retry_stale(void)
+{
+	DEFINE_IDA(ida);
+	unsigned int min = IDA_BITMAP_BITS + BITS_PER_LONG + 12;
+	int id;
+
+	id = ida_alloc_window(&ida, min, ~0, IDA_BITMAP_BITS + 5);
+	IDA_BUG_ON(&ida, id != min);
+	ida_free(&ida, IDA_BITMAP_BITS + 5);
+	ida_free(&ida, id);
+	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
+}
+
 /*
  * Check handling of conversions between exceptional entries and full bitmaps.
  */
@@ -541,6 +593,7 @@ void user_ida_checks(void)
 	radix_tree_cpu_dead(1);
 
 	ida_check_nomem();
+	ida_check_retry_stale();
 	ida_check_conv_user();
 	ida_check_random();
 	ida_alloc_free_test();
diff --git a/tools/testing/radix-tree/test.h b/tools/testing/radix-tree/test.h
index 7ef7067e942c..8ca50a58e138 100644
--- a/tools/testing/radix-tree/test.h
+++ b/tools/testing/radix-tree/test.h
@@ -48,6 +48,10 @@ void tree_verify_min_height(struct radix_tree_root *root, int maxindex);
 void verify_tag_consistency(struct radix_tree_root *root, unsigned int tag);
 
 extern int nr_allocated;
+extern struct kmem_cache *radix_tree_node_cachep;
+void kmem_cache_set_callback(struct kmem_cache *cachep,
+			     void (*callback)(void *));
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val);
 
 /* Normally private parts of lib/radix-tree.c */
 struct radix_tree_node *entry_to_node(void *ptr);
-- 
2.53.0

