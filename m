Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C13A6EE6;
	Mon, 12 Oct 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849571; cv=none; b=V+mEVVq7DTF8wYnB9hj8dgikGBL6CmSVPdFuP9id46X2uOuYiB7TadpLC0FWNHKuFVr9yN7QG2ZHBHkV1YhMeQ3b759bVVzPXKNWOGuaoOy87s6rgNUZ0/NmKWAM5QWVQiEFvnLeuaULZ5dh3ivR5PnVpV4Fdtuksryd38b8sZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849571; c=relaxed/simple;
	bh=2P3X1l7h+LmLFLbRWJdrh2AzEgZh4GyPiUjyqafA1qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feldAes9WbMeoetw80/Wa8hKDxLT8f5w4434uG1HPs2Ns0bVMLldbxgKuc9Xm5JjN56hyXRPqcA4Qdn914kT8pYHKacSnD+nE4J/3pwnRb3vhrVTe4/LYUDQ4EG+y4iUmJItl3rGWaEmbcm55inlqOLmqipvmWM3PUEot7wXb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGPvK-00GbRU-N7;
	Mon, 12 Oct 2026 19:59:18 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 2/2] maple_tree: remove the late metadata clearing from mt_destroy_walk()
Date: Mon, 12 Oct 2026 19:59:18 -0400
Message-ID: <20261012235918.773421-3-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012235918.773421-1-nickolai@csail.mit.edu>
References: <20261012235918.773421-1-nickolai@csail.mit.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of mt_destroy_walk(..., false), mt_clear_meta() clears the
metadata of the node the walk started from.  By then mte_dead_leaves()
has replaced each child pointer in that node with the plain node
address, without the type bits.  mt_clear_meta() decides whether slot 15
of a maple_range_64 node holds a child or metadata by looking for an
encoded node there, so for a node with 16 children it decides wrongly
and writes end = 0, gap = 0 over the first two bytes of the 16th child
pointer.  On little-endian that clears bits 8-15 of the address (bits
0-7 are already zero, nodes being 256-byte aligned); on big-endian it
clears the top 16 bits.

mt_free_walk() then frees, or walks down, the corrupted address.  On
little-endian that is a 256-byte aligned address up to 64KiB below the
real child: usually some other maple node, free or in use, possibly in
another tree, so the result is a double free or the freeing of a live
node, and the real child is leaked.  It takes a tree without
MT_FLAGS_ALLOC_RANGE in RCU mode whose destroy starts at a full node:
any such tree whose root has 16 children, for example a tree of 127
ranges on 64-bit, when it is destroyed.  No race is needed.

The clearing was added by commit 2e5b4921f8ef ("maple_tree: fix freeing
of nodes in rcu mode") together with the clearing of every node in
mte_destroy_descend(), which also covers the start node while its slots
are still encoded.  With the previous patch restoring that, the late
call has nothing left to do except the damage above, so remove it.  For
a leaf start node it was a no-op.

This depends on the previous patch: without it, nothing clears the
metadata of the start node and mt_free_walk() could take it for a child.

As with the previous patch, no in-tree user hits this today, since all
trees used in RCU mode have MT_FLAGS_ALLOC_RANGE, but the API allows it.

The new test destroys an RCU-mode tree of 127 ranges without
MT_FLAGS_ALLOC_RANGE, whose root is full on 64-bit.  Without this patch
AddressSanitizer in the userspace test suite reports the bad free from
mt_free_walk(), as does KASAN in an x86_64 kernel with
CONFIG_TEST_MAPLE_TREE=y; with it both pass.

Found while formally verifying mt_destroy_walk() against the kernel
binary.

Fixes: 2e5b4921f8ef ("maple_tree: fix freeing of nodes in rcu mode")
Cc: stable@vger.kernel.org # 6.1.x
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    With the first patch alone, the reproducer still shows the damage: for
    a tree of 120 ranges (root full, height 2), slot 15 of the root reads
    ...c04000 before mt_destroy_walk(root, false) and ...c00000 after it,
    and AddressSanitizer then reports the free of ...c00000 from
    mt_free_bulk() in mt_free_walk().  With both patches slot 15 is intact
    and the free is clean.  The 127 in the test is the largest such tree
    before the root splits (64-bit).
    
    If a version without the dependency on the first patch is wanted, for
    instance for a separate backport, skipping the call when
    node->slot_len == mt_slots[node->type] also fixes this, but the call is
    redundant once the first patch is in, so removing it seemed simpler.
    Both patches apply unchanged to mm-unstable and linux-next of
    2026-10-12.

 lib/maple_tree.c      | 2 --
 lib/test_maple_tree.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fd7c3d20394c..870ab3281051 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4886,8 +4886,6 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 free_leaf:
 	if (free)
 		kfree(node);
-	else
-		mt_clear_meta(mt, node, node->type);
 }
 
 /*
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 5d940bcfae34..9d25b31e9b3c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -4015,6 +4015,8 @@ static int __init maple_tree_seed(void)
 
 	/* 64-bit: a 15-child non-root node two levels above the leaves */
 	check_rcu_destroy(&tree, 2768);
+	/* 64-bit: a full root */
+	check_rcu_destroy(&tree, 127);
 
 
 #if defined(BENCH)
-- 
2.53.0

