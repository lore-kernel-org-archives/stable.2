Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA2446066
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155155; cv=none; b=StgmIF2Hpope7xTlnfzkwlsaYIjd8yCSbEzN5HG+2ohZ0IXLdunJ1D1dp273AGA7A9t8ViBBJKq5dQasuS6q6jf4G3q/dn7rbHcqa/1k2k+r2D64xddboXvDNTWtFktDhgshmKrcp+wcPOBLh5+CnfoCGtiROq9llAk4BdwmKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155155; c=relaxed/simple;
	bh=1eAH8frn6EB7xyxQlBlhl5piN5vmt9GyCTRHu74FDN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9iHDIJqEzPyBJts2iNZHo3K1tpxOhT07A8e9y0ZFdp0tuvQDHGJ9R1RSBFrR3F7+Sg0TIMJELbTQqSzeKX5lFR/OVxYcKLl0CZgTqTX2QsPtS47wpiuJNMfRif0yW4bBgG31Rk230J0C33VfGCC0Fce9RGRPfqsXEQCvJlw8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKsQqhH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKsQqhH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4B51F00898;
	Fri, 11 Sep 2026 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155151;
	bh=QHUiNWoT6s6KV4+LhtvwMzkHl8jWb0kBR7Cmd3gBAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKsQqhH9m189L3YHxN398bPlusiSs59IVaGOoZ4B22W75w0E3rGqSa6rv58jyUnAy
	 OMIhmn6G8s6LsDJgcaCZ1YRtjfV40ocBHCQWAj0T77DRFCDdZH89QpRs1B2mkgUbew
	 ZRazjSxjVoCbUt/koF3INbXR3SJhRfMZeek8+qM7jqFcuE9xWlU0kqox8X8Zn7SMoZ
	 nm6GTNmiJNYxb0tpnliw1DllahHfkBdvZqJED24ZNO/+dAqQKxGuYjwOnNuJFlWPUt
	 JjSXaRQ+jZAFkpPLm0ddcd4p/kBpXvL/FI9f1DUM1zxdeW4bfhtQKZ+CJJzfSt7WSc
	 10qDM80bvvWAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wangzijie <wangzijie1@honor.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] f2fs: don't allow unaligned truncation to smaller/equal size on pinned file
Date: Fri, 11 Sep 2026 15:32:28 -0400
Message-ID: <20260911193229.1414042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911193229.1414042-1-sashal@kernel.org>
References: <2026090949-defendant-bonsai-eda1@gregkh>
 <20260911193229.1414042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wangzijie <wangzijie1@honor.com>

[ Upstream commit d738f708564764ed591cb6ab50d55489f87c726a ]

To prevent scattered pin block generation, don't allow non-section aligned truncation
to smaller or equal size on pinned file. But for truncation to larger size, after
commit 3fdd89b452c2("f2fs: prevent writing without fallocate() for pinned files"),
we only support overwrite IO to pinned file, so we don't need to consider
attr->ia_size > i_size case.

Signed-off-by: wangzijie <wangzijie1@honor.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: d0a481fad5c7 ("f2fs: fix to avoid potential section-unaligned pinfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 038b3f14b0a27..9cef43052f8b5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1048,6 +1048,17 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			!IS_ALIGNED(attr->ia_size,
 			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
 			return -EINVAL;
+		/*
+		 * To prevent scattered pin block generation, we don't allow
+		 * smaller/equal size unaligned truncation for pinned file.
+		 * We only support overwrite IO to pinned file, so don't
+		 * care about larger size truncation.
+		 */
+		if (f2fs_is_pinned_file(inode) &&
+			attr->ia_size <= i_size_read(inode) &&
+			!IS_ALIGNED(attr->ia_size,
+			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
+			return -EINVAL;
 	}
 
 	if (is_quota_modification(idmap, inode, attr)) {
-- 
2.53.0

