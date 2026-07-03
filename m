Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCC1F30A9
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104618; cv=none; b=soIKsZMiq4mB2+RfJYUe/N6ovUqaxaxuoPHwltwWlOkpvhYdwXy11sbHB08LyQmCZtY2v2AVIWVykGkYnkpvPqh51H5ItHFcTZ+apHSX96kbzbxtdE3ftg98evkLObE9S7ZeC4Df0i5a9iXnbnMK9CvgxIL5L9s8ElUoDTyBhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104618; c=relaxed/simple;
	bh=z0hnzX30G4X+RZ8iSAyuCIhBW0F050jK0jf8VOmji4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RymV1ANyUXp06FK48u3U1oyOL5zKg79PECVrL217caE1Stnj64PfY/t5bRoHB38/9WHnymRZPnWm3luoc4v48ogYJqnDPP12klegi1oxYwXxGsiM69rSc+ACPY5NKgitBQCsvkrCN2xj66no04L0fGs2ChQUfZuSzsWjKu3sG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJUKDdgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJUKDdgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E4B1F000E9;
	Fri,  3 Jul 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783104617;
	bh=4OGAHsZz/B5AMHiTwpSetPxmIekAOQvHkTXLo/QsLnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJUKDdgrPHc3GF88cUKzhv2ytWSYDmnkK4rzC74wDWW6sQ+vGYShsF0RDW2SG97Ec
	 MjNjJc2yw9oZUhtTXzl70VpQvshTOjbwVkJ/HgNdhLqtNZAvyJ9HmDQGouuP7ufaFu
	 6rHIHEP1uEsXyMWtckGRGpxjs6l04d/6ad0boitItGT489rzsvQFsEOtZeHRBCRaHP
	 1kxddtXUP78jNkAn5x5HcusXFTpgApqfSL6bSHvCBklvyudOzeB4EIqLeTDMqvZJIn
	 REe/9001v9ZFbqPB4x4A76A6wj4pY12CSvjzRRBuVrZ/QsKU3Dfhy5Hgx6VBEuEikG
	 IUAhsHin6nw4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Fri,  3 Jul 2026 14:50:15 -0400
Message-ID: <20260703185015.285028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070201-oven-junior-8a26@gregkh>
References: <2026070201-oven-junior-8a26@gregkh>
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
index 7e9f24e5215116..eac4c0d934f71f 100644
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

