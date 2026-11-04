Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811358;
	b=DXpW3YL/3QmNMJLYXliridxX3/gM5j0iBqWyMMn6WZb8Q2h1KCIqez9RKdMciNMYozXj
	 OjwuZh/c5DTKkUetVbhsPNN/YpKsFpfeSkUEHqbZMWKhI2tiBQ2Ss6R3L4cfBB+ZIKlDU
	 i3SOCMvAoNEfrl4OyYZr+AjFkBtwCC/OzK0revxkmBu184mbzgexvqUMnLdREm4jjmPeL
	 1CQjDk/cXb6bXNFjFsD4fwNNGkyaubvrwPVZ89Kjq4qSN1q3gx42kVpgkeeV3zCDkDT48
	 slZxzXUrxGzdQK8z8ZsKMHJGA52NsPct+T6FCdcg0kVqLKDmkp0QhSAQHKL8WZ/Q8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811358;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1BvpXtgo/6d9OinL5TFQe0p+d+h5ApdfOg0iLtZt2oI=;
	b=UkXWFHXxQA5EctPXcBMuh961douI9EXUooCsnSxEPNBrWNK1+fQ0ijqb3pVRWmSut5WD
	 YUeO1j/qu5foEWqDbhQ/+6mBgRtPhPIItuv0v4a3MbkdlyahjSUsLWEJTKTBvJ490m6J7
	 yjIL56D/QMC+JZXwNkWSy2Rg72462MpCQxBm6Q2CO8JmBOcuXNSAwGW+SF2Iae1MuXZ2T
	 MDErKkMNxLiJ96gAFPigKk4o2K72J5iBn9c5UH3jvJglwVVvuwh27HKuARlOT7N0SWHZw
	 PVIkBe17Mw5eeO0a35bu+kU8YPoVGezulsMU7i+Fvu3cTJ1vmOJMXzxJzxHpUg+nnUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=peZMUHz1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48483606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=peZMUHz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F61F000C1;
	Wed,  4 Nov 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811358;
	bh=1BvpXtgo/6d9OinL5TFQe0p+d+h5ApdfOg0iLtZt2oI=;
	h=Subject:To:Cc:From:Date;
	b=peZMUHz1LMpk74TUoALhnXaWIILQCdECu+nNz9tqgb/jRG/u6oLxeEWjhbFshK9xQ
	 aUctJsTODsP7Xe4ictyu44i6Mt4VrtppIgzz9kYyLMdRqC1kbhJChIJH4BGbCYroZ1
	 lOmUeFHBAizilGzmGSbe909jboLHjdm/NDC3s5Eo=
Subject: FAILED: patch "[PATCH] xfs: bound da-node entry count against the correct geometry" failed to apply to 6.1-stable tree
To: qwe.aldo@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:55:06 -0500
Message-ID: <2026110406-crummy-perfectly-a5a4@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110406-crummy-perfectly-a5a4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

