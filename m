Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811352;
	b=BtE1kG0KFxmE3BNpPh0MlRZR3Vxyo1IxfCBaA23FouF7eRQ5CG+fWpctHdX0bJfRRRln
	 1QgU8yQWgUBTYQsyaYKP+lc6mKy1IPdWzFTpzaH/AVUN8+ujYpSJzPkRjbYC0myp7PwQD
	 8fgamjAnFb5zWrUDcZ/+kjoAo9jTlUFMHC+uEInpgpBcwCgcVXOrzw9TyJQkSg+yZHiAd
	 DUXkHWEGWWfIaDV7K8DP1MmdAy0VblmLKDUI7ft7tVaoiXjMR5laBIJ3OLy9lDy5qxL76
	 8J5aYLnNQuGze2xOXNtJbiq+U3Nq1CHG6TywvtiIdOhiXXG6W6afgMd5fg4QXhZUIGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811352;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fo3kb2xiJIrnwItMokltpCeg4H5rwUaCp7vcM7w/6ME=;
	b=IEJxj7NSMXwlyGyrGkYPEQeHWcj0m6TZxshMiBKN2TduP7CDoqkWrec/aUWu/8QzUNjc
	 0FtwHOuWOn4p88c+88zV5MuGePY3iUxNu2o37Ndiz57xEC/kaR/h6qXzlmulpWK4/zdx6
	 1B0SujcwIDoNXXGJFwXFC4A9Koa4IbwK0+Xt3uwDye3hWHzuvI9z0DuGPHSszzQOerPMF
	 XR3uCUJRvVOkmojK1MzkpBVlgG0TG5PBMjgDwuXhmZ9nQqdfog74EpTe8eqAWojnTkyPw
	 HnAVBwo8WZJ97xjabXx91KKieCKIIXXZdDA1oWmZYERgKi1+L2hhdRBXfqCV8ufE73Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dojkCSD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686E606A33E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dojkCSD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2781B1F00A02;
	Wed,  4 Nov 2026 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811352;
	bh=fo3kb2xiJIrnwItMokltpCeg4H5rwUaCp7vcM7w/6ME=;
	h=Subject:To:Cc:From:Date;
	b=dojkCSD46byVzeemA3XPR4BFLdGqLyAsd7A9Xf6AZ3yTP/oaZl+rkCRbjP5qazQvJ
	 bSLQEdkEFOoWC1bK/CmeiN87XU1BPzil5+NmiDRdEefUOP1X4T0Ii5TVQWE/VXsAKG
	 O13Dz3AHCFRRZbA2og9ibooAENtvArw9XIs+BsZQ=
Subject: FAILED: patch "[PATCH] xfs: bound da-node entry count against the correct geometry" failed to apply to 6.6-stable tree
To: qwe.aldo@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:55:05 -0500
Message-ID: <2026110405-unleaded-ongoing-7d17@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110405-unleaded-ongoing-7d17@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

