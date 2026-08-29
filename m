Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886D2DC783;
	Sat, 29 Aug 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006483; cv=none; b=poFe93Zx4xowCtbVSIITpR3L4jK+yaV965KkQK8oHTMsso8tjlQs3+M7uzKOlXoOSv+VfUzkOSmJFIDMJUROJdiV5rmHXUIpRKVpe9bukyk83rxBEAosudyFQI2LKUP5dyJwf49JWloDJuwx7HcgFgTm3bXww41aaEjpbgwcwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006483; c=relaxed/simple;
	bh=VwUiMkZBnNI69pBkdAmD5Xsm/G/FSJcHnsrHJ3DRI1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY86FerpZ3rfeK67RTleK3MgJZNtvntqgNawA7qvs0C1qzWQoaqhpeOKsSIvpl8AISB13qwLv/ZptYZ/x8Gvpjz4mrLSqo7GZ4BxXBURg+ayaI6jzi0RVoqZKiFo+SzWP7Closr/exvAi49ewUvmGG80au49GA0H79+GoyCWhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcV3yJPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcV3yJPc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28CDDC2BCF5;
	Sat, 29 Aug 2026 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788006483;
	bh=VwUiMkZBnNI69pBkdAmD5Xsm/G/FSJcHnsrHJ3DRI1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mcV3yJPcCp7qluBM9FSrIzefUajMd/IEYQEJ71Cx6CcccjcVnHwI880PimSqx3Mlx
	 kbPFgfTuY7C9IDAZT2P/i5ODPJlUzoum4Z9WbHU4Z0Bo/6RNnB7uqECqXB1xifKlH9
	 C0gaW4YoHda97rHmLywqsD1kM0v9gGljK19m6enX3Ifbo+i4mBP5fVUxOJrpy7VAYo
	 /pY/2cLsiQIINJ9gxFWKgq7NYBnKYcgmN6kmtXsYLIckCcHamEHnRz2CGHQ93iORlP
	 OfOo/7UgZZFINxp7GDhuSGvcH86aMYptPiJCYX+InR7/oLBQbOsCkHkOX45KcprGa+
	 gcW6MyV2hYJfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A1C61DDE;
	Sat, 29 Aug 2026 12:28:03 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 29 Aug 2026 05:28:00 -0700
Subject: [PATCH v2 2/2] ceph: don't wait forever for undrainable dirty refs
 in vmtruncate
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-b4-ceph-fix-null-oldest-snapc-new-v2-2-71fb4aa49968@clyso.com>
References: <20260829-b4-ceph-fix-null-oldest-snapc-new-v2-0-71fb4aa49968@clyso.com>
In-Reply-To: <20260829-b4-ceph-fix-null-oldest-snapc-new-v2-0-71fb4aa49968@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788006479; l=3073;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=9a3HsBuwTPgOP5z1+94cCYsCp9toglPrah46KIsV2Vs=;
 b=rxokNK7vuqrMhJnHCmuCtU+X2bPSReQnMp+IKA9037NojxQHfRb0q2Qx/kx6p2dqBHJFVXkym
 tvNbBQHXHtvCepq/sxMUo6j7g1uyRraWUfXK5Y8J4QGu+vPQNpLk6wk
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

When a session is lost, ceph_purge_inode_cap() removes all cap_snaps
of the inode, but the dirty folios referencing their snap contexts
survive in the page cache.  Their refs are left in i_wrbuffer_ref
while no cap_snap owns them, so i_wrbuffer_ref_head stays below
i_wrbuffer_ref forever, and the flush in __ceph_do_pending_vmtruncate()
can never drain them: get_oldest_context() returns NULL and
ceph_writepages_start() bails out with -ENODATA without writing
anything.  The retry loop then spins forever while holding
i_truncate_mutex, starving concurrent truncates and unlinks on the
same inode.

Detect the orphaned refs (i_wrbuffer_ref - i_wrbuffer_ref_head exceeds
the sum of the cap_snaps' dirty_pages) and skip the flush in that
case: there is no snapped data left to preserve, and
truncate_pagecache() below discards the folios and drops the refs,
which ceph_put_wrbuffer_cap_refs() tolerates for a missing cap_snap.

Fixes: 355da1eb7a1f9 ("ceph: inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/inode.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9ea0588a18f9..44d99fab5716 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2334,12 +2334,37 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 * possibly truncate them.. so write AND block!
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
-		spin_unlock(&ci->i_ceph_lock);
-		doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
-		      ceph_vinop(inode));
-		filemap_write_and_wait_range(&inode->i_data, 0,
-					     inode->i_sb->s_maxbytes);
-		goto retry;
+		struct ceph_cap_snap *capsnap;
+		int snap_dirty = 0;
+
+		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item)
+			snap_dirty += capsnap->dirty_pages;
+
+		/*
+		 * i_wrbuffer_ref - i_wrbuffer_ref_head should equal
+		 * the sum of capsnap->dirty_pages.  A session loss
+		 * removes all cap_snaps (ceph_purge_inode_cap()) while
+		 * the dirty folios referencing their contexts survive
+		 * in the page cache, leaving orphaned refs that no
+		 * flush can drain: get_oldest_context() returns NULL
+		 * and ceph_writepages_start() bails out with -ENODATA.
+		 * Waiting here would spin forever while holding
+		 * i_truncate_mutex.  In that case skip the flush and let
+		 * truncate_pagecache() discard the folios and drop the
+		 * refs; ceph_put_wrbuffer_cap_refs() tolerates the
+		 * missing cap_snap.
+		 */
+		if (ci->i_wrbuffer_ref - ci->i_wrbuffer_ref_head > snap_dirty) {
+			doutc(cl, "%p %llx.%llx orphaned dirty refs\n",
+			      inode, ceph_vinop(inode));
+		} else {
+			spin_unlock(&ci->i_ceph_lock);
+			doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
+			      ceph_vinop(inode));
+			filemap_write_and_wait_range(&inode->i_data, 0,
+						     inode->i_sb->s_maxbytes);
+			goto retry;
+		}
 	}
 
 	/* there should be no reader or writer */

-- 
2.53.0


