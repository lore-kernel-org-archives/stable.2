Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A62F290A
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783165754; cv=none; b=AIOT5f7khOdXHRzT8L6im4wBReSj2DiDnfPP5JnWJED2dv+ipViD4rxsIDB78DY9FTXC6JezxPVZaPNIFbXn3xLllycOzcLQFq9GP11s0Ll2epnf2PMLR8OSTh45GK3NorvUuk8D+WSJA+UPDbToZ7cBpnmp8OOaVBsH4wY33/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783165754; c=relaxed/simple;
	bh=IRHdqK4CmocB9/GWM5QP4rENfkfHribJKBDmVhznkgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3GgeCJd0mw97w8lLRPmAStMSQfyCC4BBLA3SB7wr+yehZF20sjRBer8VyzR2Vp2juslvTxifvwwpZ+z9Kd1P8/CaZGjUXZvRssEMDQIhez0O+pBkolAX8jNtphgfqvmXPRet2UPoMLY/DLtD9ZR58CTUwYu2LQKg2l/Z1fOO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcWYpUU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcWYpUU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320841F000E9;
	Sat,  4 Jul 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783165752;
	bh=0v1VUmxqU7mQYXUJbjeyLcgBCG0ad3tGx/eZFR2Th8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcWYpUU3JGDxaaYKmBX0aQkPkoATrr47ihCKjIxn8BT1gyqKR8SKa45Ss7zgw2p3H
	 NaqobzreLURLqLJbUhnX488FczhIa8qNuqeppkU/EMWpQ3xklA6/LqEmNKn488ca+a
	 ElzS3QLEB71AC8Yewh+s+ASpYCzAayZHBHyBU1WYaZ+WwbgqH7rnhwwSLKWSZN9K61
	 rlskYYjr09IkRsvF0NaTxLutL7W3kY9zo1NUnLfM3tbcxVe/xYPg3YPLMXES7m+wie
	 mCdTQv91LPYNykLn3A3OVnpyT940JsjoabZzTlnUAmQmJ5awlNGP4XBtGSKq6JZFHh
	 uHYWSZde8FPYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keshav Verma <iganschel@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix listxattr handling of corrupted xattr entries
Date: Sat,  4 Jul 2026 07:49:10 -0400
Message-ID: <20260704114910.619768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070202-tint-clean-159e@gregkh>
References: <2026070202-tint-clean-159e@gregkh>
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
index 4f49b660f9b633..f7fc6e743d656d 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -579,8 +579,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	list_for_each_xattr(entry, base_addr) {
-		const struct xattr_handler *handler =
-			f2fs_xattr_handler(entry->e_name_index);
+		const struct xattr_handler *handler;
 		const char *prefix;
 		size_t prefix_len;
 		size_t size;
@@ -594,6 +593,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			goto cleanup;
 		}
 
+		handler = f2fs_xattr_handler(entry->e_name_index);
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
-- 
2.53.0

