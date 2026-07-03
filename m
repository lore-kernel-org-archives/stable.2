Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54629ACF6
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103066; cv=none; b=XWzEli7u23moGkSZFmkBtoNJYK/tPm9+SDwwAs6fw27/U+4NdRGzJ+yJXqkjcZUExUd6Sgtzq7dOr3Heo6vTOPatW1tC8tx1P3lC5KebNGBz/5TxEyvytwOOSmtehUZwAaYd4kjF8kJazjp2d+U5JBPK5BwvmJdQ5WTMlrFC1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103066; c=relaxed/simple;
	bh=IH8qIMzhtyIpVlJ4ztHpKlCCaDtMZEswARdPA0ddxnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U60YMkkAAAZKDp7dxwt1LvozhaiWlbNCdS45C3+GZx31g0nWM6/exE4ayGvggcl6nZHIDLYB7eAEb+5gs0mojTWZTV7ncR264gp9momI6NXGdDULW2E7ZZWYKSNs6vRDFg6ExToWph5qlrn8KMZ7WtSOg0U17HcMxGkycLZrtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm2h12nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm2h12nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A31F000E9;
	Fri,  3 Jul 2026 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103064;
	bh=zhg7QRBVUnSLOH8z0bB6SQJhXQg7B5OoZdqwhoBdAvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dm2h12nBcfMn2Ya9wK+L2Q1uyflGo0jkN3pw0udDLbWw4VV6v3UrVD+kuw8DLeJJN
	 0VRO2wfkaocoB3Zs5dn/YubC9IxzoH9F6REZ2iWLpvtzQzfGEJQAqY49uJ+rj6bmYi
	 vxREthODABW81D2BBw/6N5McRhm2nW5rK5MgS/HyxRrg5P9zgU+hhXSa3xpJLUJScL
	 Bq3A9TdUFu9oYlmJgGgMQzzYtRK9Wwuf7R4b1RDrBjKbBuRbEVGeJZ2RO813AN0vRz
	 LaAIUdVUIa052SRflwuUpKyN7y14sNtEDNSuD0XoxcbKlNq/R+GuUKnsPLowwIabMJ
	 NVbpdBk0JzAuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Fri,  3 Jul 2026 14:24:22 -0400
Message-ID: <20260703182422.255104-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070200-clang-pueblo-1487@gregkh>
References: <2026070200-clang-pueblo-1487@gregkh>
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
index 610d5810074dc5..1b8952b3a44788 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -581,8 +581,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
-		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
-
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
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

