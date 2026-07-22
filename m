Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF6352025
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728505; cv=none; b=lSztroWsZSi6LniTUX9XkRihaM1feDXAxL+q0Y72I0L5v8w/uTFkcV24Bzbi5mmRF4afuLWEJsh6fOl1aovW9LQG8vwf3gRaI1IJedpYBzzjecQEwx2RyufLxdCfqJIxxSGFC1+qTSInh72gJpAkp6pNDZYELevRmX+B/hYcTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728505; c=relaxed/simple;
	bh=62ExwWpov5jGN7NEpaxSIlSZrhptojqMXRWHiKKAbnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfPNBEBFP38X7BzyJKXL/iUJP8rRChUV1XZveqYbPKWyLlov29Ro5XBRAf4Ad88TbRshyG6Vlq/Ate62A0TYRYTLzF2TPtqESM9H2OheX4ymSqXv05J0AQemZpWqQiXamHFEKTh4Kr65a+FCh+jrOg3qLykETvN9n+n8UvuFBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic+Xn+7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic+Xn+7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B11F00A3D;
	Wed, 22 Jul 2026 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728504;
	bh=6yMc4JHPhYex+Q+cZKHu512zhli1ZrYvek7nE0vwpe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ic+Xn+7OmbxUJV8ZW2UrIW6gI5h0ea4GFyqm05EBvAaGoAN+hgHgrhbceahXOdt8Y
	 gt+FW0zBNo9sL4KhSS46WRZX78Bu31VcGrV4WhyVHIvSQ0PpxMABsb25T6ETHgn4Sp
	 jdE5JlH89wT9ujB0Mu2uWnf24DtCOzfeD3j7UMPAPuf+KZx4FDrXWMeUgVfzAQ7DlQ
	 ZaP8xh5J6yBhaYwUOKDoN7XIXBFQRWADHBjZd0io4TwTaO1FM7g/RybSy2RqvKV394
	 p2bN8+fyjow4SW32sTpiughHjpHyyxt1p7Z6HaxkjsmKfXpRzpOBccZ8sT3RaOF1jW
	 DXdyfM2IZ/dFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: factor out xfs_attr3_leaf_init
Date: Wed, 22 Jul 2026 09:55:00 -0400
Message-ID: <20260722135501.1366960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071711-ion-surgery-b10c@gregkh>
References: <2026071711-ion-surgery-b10c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit e65bb55d7f8c2041c8fdb73cd29b0b4cad4ed847 ]

Factor out wrapper xfs_attr3_leaf_init function, which exported for
external use.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: a1caeeadbf57 ("xfs: don't replace the wrong part of the cow fork")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 22 ++++++++++++++++++++++
 fs/xfs/libxfs/xfs_attr_leaf.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index afdd3fc0a8be1f..7c307025cfcb64 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1329,6 +1329,28 @@ xfs_attr3_leaf_create(
 	return 0;
 }
 
+/*
+ * Reinitialize an existing attr fork block as an empty leaf, and attach
+ * the buffer to tp.
+ */
+int
+xfs_attr3_leaf_init(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	xfs_dablk_t		blkno)
+{
+	struct xfs_buf		*bp = NULL;
+	struct xfs_da_args	args = {
+		.trans		= tp,
+		.dp		= dp,
+		.owner		= dp->i_ino,
+		.geo		= dp->i_mount->m_attr_geo,
+	};
+
+	ASSERT(tp != NULL);
+
+	return xfs_attr3_leaf_create(&args, blkno, &bp);
+}
 /*
  * Split the leaf node, rebalance, then add the new entry.
  *
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
index 589f810eedc0d8..deb62b544ac542 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -86,6 +86,9 @@ int	xfs_attr3_leaf_list_int(struct xfs_buf *bp,
 /*
  * Routines used for shrinking the Btree.
  */
+
+int	xfs_attr3_leaf_init(struct xfs_trans *tp, struct xfs_inode *dp,
+				xfs_dablk_t blkno);
 int	xfs_attr3_leaf_toosmall(struct xfs_da_state *state, int *retval);
 void	xfs_attr3_leaf_unbalance(struct xfs_da_state *state,
 				       struct xfs_da_state_blk *drop_blk,
-- 
2.53.0

