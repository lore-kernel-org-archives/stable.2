Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299513;
	b=CrX3zeDQ41HyiYdoOoIJzBBs297GJnmZc4pIWzsX9q9tFyzjwMEx1lRkFpuwOMsnZXoZ
	 Kz2Mb1ae1L9d2JkwhfHE/JYzHBv5ndYDUR9dXdAl7G0bYJh7oxk28pwjvScNQQz0jb2Hd
	 Q5V7HcN9+IzU90RnW1s0FuNd7HgDtq2XbCgStvF8/XE+k01cr/+ATLeszf03VeGp4IGPp
	 /2r2Ys/ROBhIh69t0EZeStNGgGtZFVx5mLzVfoCvbYcOA2vQ1N4SSfqlhGtHXfkJEKsXv
	 awx9w+Xihp45SaG+Pi81Q9AhQJGvI13VwMl54sajiqjjlABhGeKa8FnuNFZucYvACZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299513;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:In-Reply-To:
	 References:Subject;
	bh=jc0e9w5B/WyGX+EuQP/e+iqjqymm8yhUQoI3phbuDaY=;
	b=muoB4C1O9/Ilpq6i1ZH4ua8IygliWZUi0YTyzdNB+WF9bOY5W1bksf82Bq/LBDBvvU/F
	 qEu1ekJPecR8+6BRn1WhLNqi44K6tpMvrFCYxiEvDnsaviKzq430B6Ei/1yjira+X2oyw
	 4bOTujDbRaQfCwJSvCa+z165H30WW6DN3Nk+rzM8lXIXxWSF2Rs+GJrwTCtw90nSTiQoV
	 jFTuXqZ/wN3JeAPZoVMxnR2bAP38KyFxChI/AW1vRjqDX4s3nOFpJbVBd/yspJYpbe2sY
	 UJ6V9+o6KTki1WquvbOY5ib00eXwdLWzy4If5V4hNyykYC/c6FxvACqKB7XhwPCp6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=msTCBmdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255A606A33F;
	Sat, 21 Nov 2026 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=msTCBmdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C76D1F000E6;
	Sat, 21 Nov 2026 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795299512;
	bh=jc0e9w5B/WyGX+EuQP/e+iqjqymm8yhUQoI3phbuDaY=;
	h=Date:To:Cc:From:In-Reply-To:References:Subject;
	b=msTCBmdx/suzcgkscRklorUgg/8vtfuieQdHp9uhxXagQtLOwDnOXCi3AJ7WQpABL
	 +wwJrGEuXhSaVHGEX3Wl1wL3Kgc6esez2FUElfc+kH+LiUE//NDY2EPrfQO4VidCpk
	 4PUexmk42ZsdgF889/XL/Zpp0jKH6VEZGlksVkFo=
Date: Sat, 21 Nov 2026 14:18:32 -0800
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Nickolai Zeldovich <nickolai@csail.mit.edu>,
 syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com,
 Baoli Zhang <baoli.zhang@intel.com>, stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <08ceefcb212e4dda9767389fe7f162a8.2@linux-foundation.org>
In-Reply-To: <08ceefcb212e4dda9767389fe7f162a8.0@linux-foundation.org>
References: <08ceefcb212e4dda9767389fe7f162a8.0@linux-foundation.org>
Subject: [PATCH v2 2/2] xarray: initialise the offset of a new root node
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Nickolai Zeldovich <nickolai@csail.mit.edu>

xas_alloc() sets node->offset only when the new node has a parent.  A root
node can retain a nonzero offset from its previous use in the slab.  While
xas_expand() links that root below a new one, an RCU walker can read the
stale offset and then the new parent pointer.  It can resume at the wrong
slot and report an entry at the wrong index or skip entries.

Initialize the offset to zero when allocating a root.  The old root
already has that offset when xas_expand() links it beneath the new root,
so remove the store to its offset during expansion.

Link: https://patch.msgid.link/20261024014344.830116-1-nickolai@csail.mit.edu
Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=73641b60a3bc11dfca8c
Tested-by: Baoli Zhang <baoli.zhang@intel.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
akpm: Tested the two-patch series on x86-64, with the new test present on
both kernels.  Without the fix, 64 runs of the test each failed both
root-offset checks.  With the fix, neither check failed and all XArray
checks passed.  Both kernels used the same configuration and test setup. 
This tests the stale root offset; it does not separately reproduce the
concurrent RCU-walker failure.

 lib/xarray.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/lib/xarray.c~xarray-initialise-the-offset-of-a-new-root-node
+++ a/lib/xarray.c
@@ -387,6 +387,8 @@ static void *xas_alloc(struct xa_state *
 		parent->count++;
 		XA_NODE_BUG_ON(node, parent->count > XA_CHUNK_SIZE);
 		xas_update(xas, parent);
+	} else {
+		node->offset = 0;
 	}
 	XA_NODE_BUG_ON(node, shift > BITS_PER_LONG);
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
@@ -617,10 +619,8 @@ static int xas_expand(struct xa_state *x
 		 * Now that the new node is fully initialised, we can add
 		 * it to the tree
 		 */
-		if (xa_is_node(head)) {
-			xa_to_node(head)->offset = 0;
+		if (xa_is_node(head))
 			rcu_assign_pointer(xa_to_node(head)->parent, node);
-		}
 		head = xa_mk_node(node);
 		rcu_assign_pointer(xa->xa_head, head);
 		xas_update(xas, node);
_
