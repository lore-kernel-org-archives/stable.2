Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980341;
	b=OZZkz8AevYnYGam3lsy0x0lrKLLVsN8rdVEiBGCSTvRrAlFlXt6VSF8eskustlQDJY1S
	 SRv/j5MjVL9GRbz5x5BRDxYHan0eFy1AO3Xc6KmbPdcscPsrMSyEg4bvmeaStCMzey2R5
	 chhX1wQvTHRsdcIKMkVyY9jYHAqufPhLxkSJHS7u49nWlqMKJwfadB9QAlkQrIifjxVHw
	 FbjmEfSYI9BQ0WTyUs03g2HfmuzSyQd+mvKrikfU9L+S2WTmNETJUnusgb4+7A0mpqLHV
	 Q3tW8S5VabmsRKhSpg+MlcS4nRoJw/SkPsO6C/Z3vpZvD2jf+Xma/JBc0pr25Fyn9dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tVxeufujTzI9HWysjAFfReuCDOgIHDgnaJ1AMH90bxw=;
	b=CYzPg9Z2qDBDLx+xEmZKZDqT3LApAbMfzJERfq7TIkK1ScI1A0lOHkKlPrCvajCw/Mcs
	 8GgLZ+ocm3j9XDrlmdViaei38HM8F7Fa6RFLfW5hKN0LHa6h+SR6dpubSF6Z0cw5hsLDn
	 Uy8HE/7mX/bSPt/yvaRLtjLx5LHGovS467zFXiJAlAS+qHQPSRaIpkznJBLfIaqofmVNT
	 Vk00ASgRxF9J++T0PGU3+vrVUgpsGBJnQexgyxBS5oHg+QQ+bawYXw63tZSDATKiLguY7
	 Ygimg8K4tAki5/aWirGzc8uWBOcz8QFQmkogJoHMIJMApgjEqG2/+L9iIojKyQFcHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/HhKmXI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBE606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/HhKmXI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254EC1F008A1;
	Fri,  6 Nov 2026 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980340;
	bh=tVxeufujTzI9HWysjAFfReuCDOgIHDgnaJ1AMH90bxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/HhKmXI5hPNroOmOeZfdq+WgH2mwnvFygqfMo6+09Z6EkjmrgLAueTz1UA5J1WvA
	 caRbEUaDWHjj3L+5NIMcZ6f0ooXtmEcT0upwYqyoxx5m9fPjkrmDbk6FWOn2enbf9I
	 CHmIIJSi4SVBTIPvU5jgHzGYs3TDq6wRUBhPMMIRKWhYng9L/Jrn1pbSlKR7LLJ0De
	 4+++Dgr7bHw5DEa6wn2jOl4yHAjmJtV8VlDqDLlBqjhcplv0Y6TchJ2VMIQiqiOG5F
	 DpJqB7DPyOt1kCjNE83igg+i6qda764HEasFRUJMuR6Ihfwwyd4jyaGwRqCZJAG3me
	 49KKaq38PeWOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gael Blivet <gael.blivet@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: look up stream size by exact xattr name
Date: Fri,  6 Nov 2026 10:52:19 -0500
Message-ID: <20261106155201.409535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110444-union-header-f23a@gregkh>
References: <2026110444-union-header-f23a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gael Blivet <gael.blivet@gmail.com>

[ Upstream commit 10ea20d6584ecdaf2f7505855412a856a88d8934 ]

get_file_stream_info() walks the xattr list from a single
ksmbd_vfs_listxattr() and sizes each stream it finds with
ksmbd_vfs_casexattr_len(), which matches with strncasecmp(). Linux
xattr names are case-sensitive, so two streams differing only in case
report each other's size.

The loop already holds the exact name, so query it directly with
ksmbd_vfs_xattr_len(), which is what casexattr_len() calls once its
search succeeds. Make it non-static and declare it in vfs.h, and drop
the comment above it, which describes a different bug and no longer
matches the code.

This also drops a full listing per stream: casexattr_len() runs its own
listxattr on every call, so enumerating a file with N xattrs cost N
listings instead of one.

Fixes: 689f1eb3719d ("ksmbd: report actual xattr value length in stream enumeration")
Signed-off-by: Gael Blivet <gael.blivet@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: retained non-const struct mnt_idmap pointers to match the existing vfs_getxattr() API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++-----------
 fs/smb/server/vfs.c     |  4 ++--
 fs/smb/server/vfs.h     |  2 ++
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a8a42fde4ca02..12e73fa159fc0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5275,17 +5275,8 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		streamlen *= 2;
 		kfree(stream_buf);
 		file_info->StreamNameLength = cpu_to_le32(streamlen);
-		/*
-		 * stream_name_len is the byte length of the xattr's *name*,
-		 * not its value -- same class of bug ksmbd_stream_eof()
-		 * (smb2pdu.c) already fixes for EndOfFile/AllocationSize on
-		 * a stream handle; this enumeration path needs the same
-		 * real xattr value length, not the name length reused as a
-		 * size.
-		 */
-		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
-						path->dentry, stream_name,
-						strlen(stream_name) + 1, NULL);
+		slen = ksmbd_vfs_xattr_len(file_mnt_idmap(fp->filp),
+					   path->dentry, stream_name);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 130dd0a4001f2..68781f7a060be 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -950,8 +950,8 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	return size;
 }
 
-static ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
-				   struct dentry *dentry, char *xattr_name)
+ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name)
 {
 	return vfs_getxattr(idmap, dentry, xattr_name, NULL, 0);
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index e9a5798d7baed..ca5048ebb1308 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -106,6 +106,8 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   char *xattr_name,
 			   char **xattr_buf);
+ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name);
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len, char *actual_name);
-- 
2.53.0

