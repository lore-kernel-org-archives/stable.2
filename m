Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2818FDBE
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126051; cv=none; b=oewrTYiaAHF7FD5p9IDEZxURiQ2rAyA6wE3WuEbYnWpjDZ/7tZpW2PsN8V7WU8m7XdRiZpSHrv7OhFKGQmsIZ2W7sjIw129AR9pxoEIItYp6O4tng7R3HaDUKnjuDD8qgZEdb0GWCJGD0KYmfMHwTsXX1g/hbdTmt8XBlsj0MFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126051; c=relaxed/simple;
	bh=xAtKHsl6VIBIN/YSB0GYHfEptVLoynNWDpDhhKRBoj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzbiq5NLatQ9fWO/MtLE8NTE4yJu6a8Mc4NgylWjDlX7r+gEjkZGFt4FCt7rZc2lvF4lxzbfgysRPJSGQnCfBqK9ZW9vLlzEw7sFF0u2A4QBdQrEIsUUivAAY/LCQBIK4gQc+w4ZiRX24bng0uX0biGBCKqx2GDhe15ssdAD2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3pXHW1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3pXHW1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB331F000E9;
	Sat,  4 Jul 2026 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126050;
	bh=HXkcxnyNyxOy9NQyWEtzQ84U/sG0b3ZB6tbyxZDqBCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3pXHW1B+tKivRzYmHQNMohu+38w1E2krlZfie7zrTNoD61XsIXcNdmZQEVsxzMhm
	 xMk71YaGwyGKZnYOUhxWbebnIe33THB+OgPor/wDnrTGCxODPxWb6dUTFq+qxoJcuV
	 5K+BsJ+VdoTg9LiSp4P1vdx0WF6RMpXbnaHn2vqUrgUeqPeOywCaCD/u+/wrdVPGZ2
	 SLq59WcHKN0aaoZ+5ERtFlEeBI+nSHbXmHLvWwwWI5M2el9K/94hMtUampQr3IxXB1
	 JwU/04iu2T+x2MB//v9vc7Pk6LJpbwnlRS1NesL5V4hwZOKuGWNE/4eeoUf6Ie0P7j
	 8wn7JCqLkLmyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Fri,  3 Jul 2026 20:47:28 -0400
Message-ID: <20260704004728.435151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070201-xerox-struggle-538e@gregkh>
References: <2026070201-xerox-struggle-538e@gregkh>
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
 fs/f2fs/xattr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 0c9ac0c85e8c20..95f85b4b1543fd 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -576,8 +576,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	list_for_each_xattr(entry, base_addr) {
-		const struct xattr_handler *handler =
-			f2fs_xattr_handler(entry->e_name_index);
+		const struct xattr_handler *handler;
 		const char *prefix;
 		size_t prefix_len;
 		size_t size;
@@ -589,9 +588,11 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			f2fs_handle_error(F2FS_I_SB(inode),
 						ERROR_CORRUPTED_XATTR);
-			break;
+			error = -EFSCORRUPTED;
+			goto cleanup;
 		}
 
+		handler = f2fs_xattr_handler(entry->e_name_index);
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
-- 
2.53.0

