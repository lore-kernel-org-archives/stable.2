Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B67E792
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508243; cv=none; b=WOHj89sxKvDo5jGauT20Qzx7Bai99WqEknW8EWP9/1WqxkKcO8zqQLUdKiTvGYNjwoK5aDsgZOJ8KLJFiY2qhgWbKcc+oNRz915Vi7VTMkSHZ9gdoSgGeKhM5hxWpnXAPtmuNO1G+u63/qs60s7Un+UI9IYmBaTJC37l9Lt6row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508243; c=relaxed/simple;
	bh=vPdUjgM99smAnVFe1vp43LUIFvS9x9NIfZJGUORzJZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FniSguXOx3K8Tz4FoEQXMJ+lnO8yQxqno0hpcD7KJIgg3dShBQrRic65dxhnX9bk4idiTe4Vbj3MgjWBE/sjlnyXFauS9yA14WlLLStjUcKdjqpbB1J9NCP7MlDm1WGxa27dlO7ZaC4NRcwd10s6aFPBj1fFYvojnInSVi666Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g74Uq+yP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g74Uq+yP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A591F000E9;
	Sun, 23 Aug 2026 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508241;
	bh=8a2+MmSzeWaMUlEPXjtb/lP9kHSRHT09xDYoDk8KmRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g74Uq+yP8AQy1/ltaRmHkrlK65o6bIRRdrgLtKAbnexBwdRPtKA1h+4Mkzx4/Px4Q
	 QyQHfk1VXYqTDH7REQsMAoNEiUrobcP0A2sbr6SqJnt6+opyBWZVEhb2f65FOu4/iu
	 l4U0uB1TS5PpgbUauxADfsgTkr97h3G8eqA9Q3SHcpIiFBFsMbCqvnOb3JM3CiBtdP
	 e5c8Mk6o+U+t4zu+8e4Yl50CwOnmTy8hxMWXQzg5VTlnjZ8hjmb6/3TGzHhW5YqF3T
	 0aokc+K5lphYgh8seCLOU2SNiz7HxBrfNc1TzjWp/6nl2d0a4v0v40khKIMKmUS/ns
	 d2L36nFq/hg8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: fix ilock leak on error in xfs_dq_get_next_id
Date: Sun, 23 Aug 2026 14:03:59 -0400
Message-ID: <20260823180359.1422058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082058-bust-worst-3564@gregkh>
References: <2026082058-bust-worst-3564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 63320a0f70f66f311f4bccff3af0719c2119f46c ]

xfs_dq_get_next_id() takes the quota inode ILOCK before calling
xfs_iread_extents().  If xfs_iread_extents() fails, the function returns
immediately without releasing the lock, leaking the quota inode ILOCK.
This can leave the quota inode locked and cause subsequent quota
operations to hang.

Fix this by jumping to a common unlock path on error instead of returning
directly.

Fixes: bda250dbaf39f ("xfs: rewrite xfs_dq_get_next_id using xfs_iext_lookup_extent")
Cc: stable@vger.kernel.org # v4.12
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index fe00ad64c3952..c2bd74263f78f 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -745,7 +745,7 @@ xfs_dq_get_next_id(
 	if (!(quotip->i_df.if_flags & XFS_IFEXTENTS)) {
 		error = xfs_iread_extents(NULL, quotip, XFS_DATA_FORK);
 		if (error)
-			return error;
+			goto out_unlock;
 	}
 
 	if (xfs_iext_lookup_extent(quotip, &quotip->i_df, start, &cur, &got)) {
@@ -757,6 +757,7 @@ xfs_dq_get_next_id(
 		error = -ENOENT;
 	}
 
+out_unlock:
 	xfs_iunlock(quotip, lock_flags);
 
 	return error;
-- 
2.53.0

