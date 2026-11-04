Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811361;
	b=Gv+SYheMNDJrg7iwSjMQB9nayVkE4IsDFgiKpxXBtWYa9EHm0wg1dTRIUbYrE+c+th0u
	 xpsNcokPJ1Y/aivNHt66cyujkuPbOwrGdXMeDwYzP9CR+EPsUOiZ+IP5IT8efeumdtOuk
	 P2nUX5kuPowfM3hsYENq6kUL+ctZtEtUkuonMjq7F1tXqGwHtNw+85v4ZYD1n5Mx5pfZU
	 9HCESO1oM8ckODCcUlO5a+jOADQssBVlAtPQ2rXrdhNkvO2+tNpuyx3O5xHoek0XHeDUS
	 RS1qvD+/Z3Wl6fa2GaVezApAbE80kwTJKKmw1lIyJx4IYJo6g+wfco6dK/rlECBLz3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811361;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vjEuMStM7oGSnzqmo1x4ZdzQs/XqQ55ewyEuf5fJYV0=;
	b=dtNKzAuQTzlOji/X/pJjnedYXfD74z/WKxym5/UR84yA6ugcg7QXUDG389T/T3Rt8ya0
	 VL+RpiV2hWGrzoFlw24OBydnhGyZ6srlFBnLqR9R38kF6tXBn0FPGJw/sizu+uJQuczUO
	 yyoBfWMxzyUqyq/xtNpOYkU82chP2nfgE6FD3OgcJVtDxAiT/YdxLfYK7zeHB0OpkZsyF
	 9BDvAeFcfFoy8YRVTxJK7yBy6k2ZdZFvh9AMQMcHIrQi811ehfeCAXN6gg1M2zvwjI6nx
	 ZMjDZsTXhFVZ508NIxKZFY4ZbQ25d21i3wtapJZBKlmqLnOEfRIQFGsE8tiz6cujCYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B+zN2RZR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3458606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B+zN2RZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEC41F000C1;
	Wed,  4 Nov 2026 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811360;
	bh=vjEuMStM7oGSnzqmo1x4ZdzQs/XqQ55ewyEuf5fJYV0=;
	h=Subject:To:Cc:From:Date;
	b=B+zN2RZRIBWXgu8Hof8W08JE2ItuCu8vyC6T7PDhJLd+wiOf5hTNMEWqMExFDYpVJ
	 dJilxEQ8EHpnQYlBoDqUDQU8pLAbqzXD0CUdOa4hK5Z2d9va6b6UxqHyIovR1NYCqD
	 HSUxGbvyKTdZSWfy21mS/8qdH9ZN9qgjySmnWARc=
Subject: FAILED: patch "[PATCH] xfs: bound da-node entry count against the correct geometry" failed to apply to 5.10-stable tree
To: qwe.aldo@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:55:07 -0500
Message-ID: <2026110407-hyphen-guileless-3849@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110407-hyphen-guileless-3849@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Wed, 23 Sep 2026 08:57:54 -0300
Subject: [PATCH] xfs: bound da-node entry count against the correct geometry

xfs_da3_node_verify() bounds the node entry count against the larger of
the directory and attribute geometries because, as a buffer verifier, it
cannot tell whether the block belongs to the directory or the attribute
tree. When the directory block size exceeds the fs block size (e.g.
mkfs.xfs -n size=64k -b size=4k), an attribute node buffer is a single fs
block that holds only m_attr_geo->node_ents entries, yet a crafted attr
node may claim a count up to m_dir_geo->node_ents and still pass the
verifier.

xfs_da3_node_lookup_int() then indexes btree[] up to that count during
its binary search -- an out-of-bounds read via getxattr/listxattr on a
mounted crafted image.

The buffer verifier is the wrong place to tighten this: it has no fork
context, and the transaction-less read path used by getxattr does not run
xfs_da3_node_set_type() either. xfs_da3_node_lookup_int(), on the other
hand, always runs on that path and holds args->geo, the geometry of the
fork actually being searched. Bound the entry count against
args->geo->node_ents there, before walking the entries.

Fixes: 7ab610f9e0f1 ("xfs: move node entry counts to xfs_da_geometry")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 3d02a0d7ba44..faf88488265c 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1787,6 +1787,20 @@ xfs_da3_node_lookup_int(
 		} else
 			expected_level--;
 
+		/*
+		 * The node verifier cannot tell whether this block belongs to
+		 * the directory or the attribute tree, so it only bounds the
+		 * entry count against the larger of the two geometries.  Here
+		 * args->geo is the geometry of the fork we are actually
+		 * searching, so reject a count that would walk btree[] off the
+		 * end of this node buffer.
+		 */
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			xfs_da_mark_sick(args);
+			return -EFSCORRUPTED;
+		}
+
 		max = nodehdr.count;
 		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
 

