Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5B41F35E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211818; cv=none; b=XCRrE6J3/S1yUhSHd5Otp3G+Wx05CyW+QJDf874bjr2nBba9xazm6cIF1sN+YpiZo1vkPMUot8ZyrNQwvyc5vfRWAD+RUidogFt2LwWxYCTLD1lxMkJ0le4euyguIYf/529OSXRKCZpPbmGgs6ciamRbebUy6j1oCwJJkpZC1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211818; c=relaxed/simple;
	bh=J/9xCV7Zmrd06uhBwjjgZecbhwQzEmLgfgwwLIzVI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM2oKh0zF31RbgSav6jGe7nCdlvw9RTFgYL9YOqjhsPmVyQWqZji94aDhs+YzgbL5ZktdeIz3GqYUHVW5XT8hfK9fvNh3iIccKLw2fOx9QBa3zRMye9JNVmrA9YnyROQp9W9hzJ/qONCpMGIrDl185kAXbC4nTkj+vc3PEpyVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XELFnJkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XELFnJkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1BF1F00893;
	Sat, 12 Sep 2026 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211816;
	bh=cOJH7/MlwoZO/oKoHIRVjkQpTah5oUydWmWs7x7cRCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XELFnJkxOC3t+90w3Fxs80KXIBVxyzLo5vUniiZHxR/DAOImic5m5N/4ZMx30Z9yD
	 1hNVG8++gX4RGeD8JpUSNQn7sCuhWq25bl7uW/tUy2lvPnX8dbAggSu8KmD5iHN8Cx
	 5zDspICsPWg68DRch7i34o4QiB5cCbaytqqQODxXYSD1W/UjEBZe6oLq3xcXR08IvB
	 rXONB139TfYgOXmU+NIuQ1rtPZ80SJiiA2QQ/1dV/9lKgpK/01NbWSgQXnZU1YW6PD
	 8admZUG7zXIY1wte1iYFcR789Tpurg+tX0Lljq9CtJ1NLI5rhCJUMra4HiPiRdnjNt
	 eVnC1goqwcsCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] f2fs: reject setattr size changes on large folio files
Date: Sat, 12 Sep 2026 07:16:51 -0400
Message-ID: <20260912111653.2276190-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111653.2276190-1-sashal@kernel.org>
References: <2026090944-reprint-spruce-0599@gregkh>
 <20260912111653.2276190-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 242d30bfc0a84b8b5de0a88821b53c9ad7fd31c4 ]

F2FS large folios are only enabled for immutable non-compressed files.
Writable open and writable mmap reject such mappings, but truncate(2)
through f2fs_setattr() misses the same guard.

If FS_IMMUTABLE_FL is cleared while the inode is still cached, the mapping
can keep large-folio support and ATTR_SIZE can change i_size. Reject size
changes in that state.

Cc: stable@kernel.org
Fixes: 05e65c14ea59 ("f2fs: support large folio for immutable non-compressed case")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47b94e57cc7f2..c9550bbf6b795 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1136,6 +1136,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (mapping_large_folio_support(inode->i_mapping))
+			return -EOPNOTSUPP;
 		if (!f2fs_is_compress_backend_ready(inode) ||
 				IS_DEVICE_ALIASING(inode))
 			return -EOPNOTSUPP;
-- 
2.53.0

