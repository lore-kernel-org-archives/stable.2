Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDB2F1FEC
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103984; cv=none; b=u/l7scMhwaU1pv/KhPFgTGDiaxzEVCRP1e65LFSzPoV2SpG3VGq+QJMdVEAH4Mn4t1d74s+gKR47edB8nMCc/m667JBL0Y6EVL9ZK6UrYBp2G57rTOeIhfMeRxnSKV3k5DVrHYx3Lkq3PZN8wU0i90cuBEse/edBSSwoDt9yjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103984; c=relaxed/simple;
	bh=6YFg5oGEIS1RV4JMsdsdpc8ekqde02V2+0UrmqeeFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDlyDxsy5kmyOjL4IbztjOBOnxm4ZBbzk/SaBn6gzdqgd7Ia49bRw7RbqFIKy+KH+28HYsmT6q3kPdl1fbuATgg+uezv1pgIme9Jsg9ypKHmSru8kn5i2oC280qhOrHsxC41zO3R/msI0wnnvGSGYFg4hKybw5t+nhE0pZxkG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oky1VcFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oky1VcFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45481F000E9;
	Fri,  3 Jul 2026 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103983;
	bh=J5TBfNRvbWqnfgZGFBHMQ75BOVN/mdbXIhVJRU3hlIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oky1VcFU/MSO2gHXAUuGMro/XJ/zPLsFz3qP0lxHRXFgDlwjx6iCENV+IAiGXx8FL
	 jWSoGZ463xAL0HH+ceMqq4sTxBUAh+B/B7gpCdQVJ5Kv1nZlm8U0Oaxul8RKpJMqyc
	 BG+ZhTBDKqZ8P19SMGm85zwn3/VN0es8mNHaZ7FlhPBaMBU2NvYNk85I3SJFWGkhRQ
	 Mfvm1Ubn/kVkeu/rnaTwNsIGRc1idJ1WXLPpCAYg1T+FlfEuwgD9ti8FXX31kibGTO
	 bzmgD0aaJrlTT/XfvkST9CbtaM2tT99nA+BFDiTJfrW8Up+MKWURxrD+VlXM48fyL2
	 qZkXyT1qbxM6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Fri,  3 Jul 2026 14:39:41 -0400
Message-ID: <20260703183941.265158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070201-elevate-aide-0fef@gregkh>
References: <2026070201-elevate-aide-0fef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keshav Verma <iganschel@gmail.com>

[ Upstream commit 5ef5bc304f23c3fe255d4936472378dcb74d0e94 ]

Validate the xattr entry before reading its fields in f2fs_listxattr().
Return -EFSCORRUPTED when the entry is outside the valid xattr storage
area instead of returning a successful partial result.

Fixes: 688078e7f36c ("f2fs: fix to avoid memory leakage in f2fs_listxattr")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Keshav Verma <iganschel@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index b4e5c406632f81..8cb0de2a5bcf9f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -581,8 +581,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
-		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
-
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "list inode (%lu) has corrupted xattr",
@@ -590,9 +588,11 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			f2fs_handle_error(F2FS_I_SB(inode),
 						ERROR_CORRUPTED_XATTR);
-			break;
+			error = -EFSCORRUPTED;
+			goto cleanup;
 		}
 
+		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
 		if (!prefix)
 			continue;
 
-- 
2.53.0

