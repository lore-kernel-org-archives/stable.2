Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58F3A7582
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166093; cv=none; b=oLP9uL+Cz7C3fpyZ/D/WZPWhvdJUAmB7LhDigO0T7oJTkiIU0BLEtqETvzxqz4+HqWJIbHyI9JWoNCsLKlF0cgCfNzclcB2sd5pRPAoXkHHmqak7OLU17W2l5V8MLeweS8zbBc6JaH7CS6rzx3uxxrxJyXCHSScxIzmIAsreCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166093; c=relaxed/simple;
	bh=nE63wM2MJi2ieYBJJGPVX7tgkCS0FghiDZPv+ixwKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG7T39W/noiIQn4BfJEJmq5W1qMy2aIaAr9qzDO3idlX/Ai6Dmai1JoDXi9hWmhriRAPlptzRJBTf1+sQbOpnH8QL9D1S5HLiRlKcHbGErKpEd7m4q23/yY0FpKr9OcGZc+qg+u5QPHyrfLsFlapxtf9XIsKaRzzg6FWYS6C/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXXRxYW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXXRxYW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B4C1F000E9;
	Sat,  4 Jul 2026 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783166092;
	bh=0+C7xYiGsIRm0fugPRvJaZwFMFnZf2J4bk3rOy+NGIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXXRxYW9tlnqOw6aQmAvk6iomZYVMeYwnbsAjbMVXgCZyqODN47Cm3IZOhIBJJzGG
	 O1MLm5ol1WLYbBY6PB3QG5Kdd5IF/2bBl4VEejNgpfEIk6n+XI5rDhuSqmF53vuSgM
	 nAZWDm07jzyBMIq6GU2oRs3Bbd6g3hX4zUpp3JyzWrjfkcCXRFGNd2tgOi04r0EfEP
	 nxNLOT22sMR7y4IeQw9QOE4cQHYJdYOqhv5GCcGpEcerY4LeB2lDinv+bLAbvPAqc/
	 PHxfjhLe/ESvK5ctPcpQwe3ZJfouRPgI6qa2mxKG4FMQZWrbeC33etHrLHA2E/Tmq4
	 uRMF0yY4ivJkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Sat,  4 Jul 2026 07:54:49 -0400
Message-ID: <20260704115449.629037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070202-anchor-engaged-bfd1@gregkh>
References: <2026070202-anchor-engaged-bfd1@gregkh>
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
 fs/f2fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ed475fd172afaa..416ddf11fd0dd3 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -575,8 +575,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	list_for_each_xattr(entry, base_addr) {
-		const struct xattr_handler *handler =
-			f2fs_xattr_handler(entry->e_name_index);
+		const struct xattr_handler *handler;
 		const char *prefix;
 		size_t prefix_len;
 		size_t size;
@@ -590,6 +589,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			goto cleanup;
 		}
 
+		handler = f2fs_xattr_handler(entry->e_name_index);
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
-- 
2.53.0

