Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75214973B7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658267; cv=none; b=R/3snzFE+HjZFRJK2j35Xusrdm/A2xgUq8U5nHoI5rOO19ZE2R0YhCwJFduDrozPr3lfcKdg6QoMw50KGa1e/PBQWMxY3KThipirx4YyoOaJYU1vXf/9JpV2piZ+m0xRR1QPvgeNvh9qjsUfgawSgGMNc7vZy6s1mbkKCipndQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658267; c=relaxed/simple;
	bh=RmWLJY5EZq5zT4AgXrY1wA6e2pZOa8TESwlPXC8Pq5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCgc2lYVp9oY1iSaspvN2VVK7+Fk5XUudoX+AGmZqyqQxeBbkLwXZuAjg1vMotLQ43SVR5uS6G++vkELwje90fVuQo7acmbyaAdqxh88ITtq2vQYulP1RMDBYURRekNl+MUeF6cpricqBAVNx2JkcTlWczPlz6netHnPKruJzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgFYD928; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgFYD928"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653231F008A2;
	Thu, 17 Sep 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658246;
	bh=/xhpfOuxrTdtYqZDVQGOW1bfVoIZ/qPxeaSK50yBqpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgFYD928vtOK/6CBoggNahiee+qC90jIsBMarFXPaKN6UpXDb2Fn50aD6EtUnGIKu
	 RBEp+WaR848W0zS8i6q//FSQRs99tvZiMrKWUhNQq/TuNnyKVoszhPC+pKmJvBKdno
	 ktSFYahzHroy43uSDdrO1Utqjo+lJ+H+/tQiIHJobH6hb9eaEVwT8Veg9mJeUVk/WA
	 AJb64yN84zIXs0LzqwQXJYjqY/shaZU5z1VrCfFcjnWHxYuk27p+SuFUC8UKTqMxK+
	 LhDO/Z+uqTID1PcRivxTcKiifQ4fpmrm0Nbmjv0LeqGKhYHkBoi8De+uFrVyApJ6K8
	 5qxp2i09Lp3+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/9] xfs: factor out xfs_attr3_leaf_init
Date: Thu, 17 Sep 2026 11:17:15 -0400
Message-ID: <20260917151724.693663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091651-freedom-anger-bd4d@gregkh>
References: <2026091651-freedom-anger-bd4d@gregkh>
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
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 22 ++++++++++++++++++++++
 fs/xfs/libxfs/xfs_attr_leaf.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 14dddee4f8fa6..dd3923fdcb205 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1330,6 +1330,28 @@ xfs_attr3_leaf_create(
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
index 589f810eedc0d..deb62b544ac54 100644
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

