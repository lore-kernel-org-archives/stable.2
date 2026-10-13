Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E765372060;
	Tue, 13 Oct 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851228; cv=none; b=qeW0Pl4zD/M82yHmyBCy3ZgwdPZOEpKTRNRK6vfZBX01aPrVqSDgv4qdEOA2IQRRXp6hzVThxxQLlyvH6sJxuXZTvJTbqR2NNgT1ng2zMztZhXQQpFj1uBjS4eF/5R4tEVkm585GOq3kEjEayMr8FRXIREt7YQwHEfQproTvFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851228; c=relaxed/simple;
	bh=3l9AKdWgZ75VKzpzvrIWNFecE+mYMhVIm7S75rXFWR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSxlYxgHwyhflUJe+7wGrqyMlPZIHmMtk8eyb4/+9lYk03SbIcz5lWtE1zuTI/0jVAiD4RHHs1FyBgiJSGArKzEE2vup25gtREHZgZvks4QwQPUgKkVgPtjSL4mUETBuGAdOLicAo1XXg/IfJ21cmCS31B7F8S/vsCTZKam+iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGQMC-00GgqH-8r;
	Mon, 12 Oct 2026 20:27:04 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 2/3] ida: free the bitmaps that ida_alloc_range() fails to store
Date: Mon, 12 Oct 2026 20:27:02 -0400
Message-ID: <20261013002703.773923-3-nickolai@csail.mit.edu>
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

When xas_store() in ida_alloc_range() fails with -ENOMEM, nothing has
been stored, but the function loses the bitmap it was about to store:

 - A bitmap allocated with GFP_NOWAIT under the lock is neither the
   preallocation "alloc" nor stored.  If xas_nomem() fails as well, the
   function returns -ENOMEM and leaks it.  If xas_nomem() succeeds, the
   retry overwrites the only pointer to it and allocates a second one,
   so the call succeeds and still leaks the first bitmap.

 - A preallocated bitmap whose store failed is not freed on the -ENOMEM
   return, because the exit path takes "bitmap == alloc" to mean that
   the preallocation was stored.

 - The value-to-bitmap conversion resets word 0 when its store fails
   and then loses the bitmap in the same two ways.

Each occurrence leaks a 128-byte struct ida_bitmap.  It takes a
GFP_NOWAIT radix_tree_node allocation failing right after a GFP_NOWAIT
kmalloc-128 allocation succeeded, which is what memory pressure looks
like to any ida_alloc_*() caller, such as create_worker() allocating
from worker_ida, get_anon_bdev() or the misc device minors.

Hand a bitmap whose store failed to "alloc", so that the retry reuses it
and the normal exit owns it, and free "alloc" on the error return
whether or not it is the bitmap of the failed store.

This was found while formally verifying ida_alloc_range() against the
kernel binary.  The tools/testing/radix-tree harness cannot fail a
GFP_KERNEL node allocation or let a GFP_NOWAIT kmalloc() succeed, so it
cannot reach these paths; a user-space copy of the function with fault
injection at its four allocation sites leaks one bitmap on each of the
three paths before this change and none after it, with the same return
values.

Fixes: f32f004cddf8 ("ida: Convert to XArray")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 lib/idr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index f298660f5c80..86c572e60f75 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -424,6 +424,7 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 		xas_store(&xas, bitmap);
 		if (xas_error(&xas)) {
 			bitmap->bitmap[0] = 0;
+			alloc = bitmap;
 			goto out;
 		}
 	}
@@ -450,8 +451,10 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 			__set_bit(bit, bitmap->bitmap);
 		}
 		xas_store(&xas, bitmap);
-		if (xas_error(&xas) && !xa_is_value(bitmap))
+		if (xas_error(&xas) && !xa_is_value(bitmap)) {
 			__clear_bit(bit, bitmap->bitmap);
+			alloc = bitmap;
+		}
 	}
 out:
 	xas_unlock_irqrestore(&xas, flags);
@@ -460,10 +463,12 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 		bit = min % IDA_BITMAP_BITS;
 		goto retry;
 	}
-	if (bitmap != alloc)
+	if (xas_error(&xas)) {
 		kfree(alloc);
-	if (xas_error(&xas))
 		return xas_error(&xas);
+	}
+	if (bitmap != alloc)
+		kfree(alloc);
 	return xas.xa_index * IDA_BITMAP_BITS + bit;
 alloc:
 	xas_unlock_irqrestore(&xas, flags);
-- 
2.53.0

