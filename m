Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3D35E1D9
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127598; cv=none; b=Jn54SqS+T3cO0I+KSyJWKNLOwTd0wQ8x5iGuAjPOUTYD/3lkP79+quAtHQCWlySpwBUDLQ38zyOyLZxt4BPeWunCBmbq6oZTE7zP2/z6rv48cvaW1rMg/edXsA36P9/N5b3ho7Qv8+JlkyAAJbr39IcOJkXmjWyB4ZKz5ti8Mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127598; c=relaxed/simple;
	bh=aQHpXNo7+NDVF/98EhWx31k9wcwwPN32KJF2OCNlG30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0xLANuQZ7g4HB5aOAzWa7xurHFNKpAv2Et6hVS2qjQ4kSM1UhqB5bm6eglaVjH8LNj/pDMYeF6gYdZsauHdGsnq+FxbBJV8CN7RqHojgVWdfVzTtvF5O1Uv7TepLYvU2d79MzeLtNYQpBHA17BqrUu7QriU+cC4SSeVaPr4QaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRdEZNB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRdEZNB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19E71F00893;
	Wed, 23 Sep 2026 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127596;
	bh=1HxmiMK1ij+NH5Qs5Bsogd5Uk5tYy2DEucnn8g3f0Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRdEZNB8BGrrLfa7+7laZ2FAV1CJ1phJqGQv5jMDo7k2lDipGO+EGEO2w7ZobcEPZ
	 VaKYZBYSsKCzUtmuOGsHfe5Jas0b42rEx+Lk2K3RRpO2/BLEp+tifwHwb/b0+/i9x9
	 RkFktWRb9cOpfxqt6jJdO5/kKr6Lx2Px7X2Bo2qLmTtrpiJSSnDsuB84+RVSJwU7MW
	 +eyZWg09QYd9HEjdQEdoQcwNgY9uX2w8lTBy9ErIuIkcusxRP9MzLBC5L2U9wpxnrm
	 aoLOo1998THSZ14HLnghf11W3N8VSgx1W63GfQeylXJzKzY8AeBRixbm1L058kWf2c
	 lvGlfANfrXRlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] smb: client: fix fattr leaking on wsl_to_fattr() failure
Date: Tue, 22 Sep 2026 21:39:53 -0400
Message-ID: <20260923013953.878249-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923013953.878249-1-sashal@kernel.org>
References: <2026092250-moneywise-parameter-6a1d@gregkh>
 <20260923013953.878249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit e1253a82bb4c0fed6706a5839fc8b6e01be1abe2 ]

wsl_to_fattr() mutates fattr fields as it parses each WSL EA.  If
validation later fails, the function returns false with partially
mutated fattr fields that callers do not reset.

Fix this by parsing into local variables and only committing them to
fattr on success.

Closes: https://sashiko.dev/#/patchset/20260906200517.725015-1-pc%40manguebit.org
Fixes: 78e26bec4d6d ("smb: client: parse uid, gid, mode and dev from WSL reparse points")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 872b3a520c9a4..b837f2bf79d67 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -679,29 +679,30 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 			 u32 tag, struct cifs_fattr *fattr)
 {
 	unsigned int sbflags = cifs_sb_flags(cifs_sb);
+	kuid_t uid = cifs_sb->ctx->linux_uid;
+	kgid_t gid = cifs_sb->ctx->linux_gid;
 	struct smb2_file_full_ea_info *ea;
 	bool have_xattr_dev = false;
+	dev_t rdev = 0;
+	umode_t mode;
 	u32 next = 0;
 
-	fattr->cf_uid = cifs_sb->ctx->linux_uid;
-	fattr->cf_gid = cifs_sb->ctx->linux_gid;
-
-	fattr->cf_mode &= ~S_IFMT;
+	mode = fattr->cf_mode & ~S_IFMT;
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
-		fattr->cf_mode |= S_IFLNK;
+		mode |= S_IFLNK;
 		break;
 	case IO_REPARSE_TAG_LX_FIFO:
-		fattr->cf_mode |= S_IFIFO;
+		mode |= S_IFIFO;
 		break;
 	case IO_REPARSE_TAG_AF_UNIX:
-		fattr->cf_mode |= S_IFSOCK;
+		mode |= S_IFSOCK;
 		break;
 	case IO_REPARSE_TAG_LX_CHR:
-		fattr->cf_mode |= S_IFCHR;
+		mode |= S_IFCHR;
 		break;
 	case IO_REPARSE_TAG_LX_BLK:
-		fattr->cf_mode |= S_IFBLK;
+		mode |= S_IFBLK;
 		break;
 	}
 
@@ -725,26 +726,29 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 
 		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
 			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
-				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
+				uid = wsl_make_kuid(cifs_sb, v);
 		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
 			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
-				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
+				gid = wsl_make_kgid(cifs_sb, v);
 		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
 			/* File type in reparse point tag and in xattr mode must match. */
-			if (S_DT(fattr->cf_mode) != S_DT(get_unaligned_le32(v)))
+			if (S_DT(mode) != S_DT(get_unaligned_le32(v)))
 				return false;
-			fattr->cf_mode = (umode_t)get_unaligned_le32(v);
+			mode = get_unaligned_le32(v);
 		} else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen)) {
-			fattr->cf_rdev = reparse_mkdev(v);
+			rdev = reparse_mkdev(v);
 			have_xattr_dev = true;
 		}
 	} while (next);
 out:
-
 	/* Major and minor numbers for char and block devices are mandatory. */
 	if (!have_xattr_dev && (tag == IO_REPARSE_TAG_LX_CHR || tag == IO_REPARSE_TAG_LX_BLK))
 		return false;
 
+	fattr->cf_uid = uid;
+	fattr->cf_gid = gid;
+	fattr->cf_mode = mode;
+	fattr->cf_rdev = rdev;
 	return true;
 }
 
-- 
2.53.0

