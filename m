Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE384F55B8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112321; cv=none; b=WfQ9L4uh79XkP5JlqIUZyc/FO4dDF9xuuGRrNmy79S0J4aOyhLraZdT2sm+t8XOPAvWBo4ALmnJcEFDuYlHnLvLCZNAv8W5SY/B1A5AZi+U2G87oG8urdbmkfS9LkZSvN4usdDnM/e/hE+WsOeD9xZ65oNqii+Tw9th6L4NPlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112321; c=relaxed/simple;
	bh=cbxiVJa5HjOb6zA9EMLhsfhgZ8t2IjYUP9Z8kd4TJ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFdlMwuY0UJ2bMI9jO2om8y/u+PHJ2jnsK3/MTk7bQ/xfJ8ORLfBzHhz+WJYRHddhNP2+UkthXsSgt03Q3XDmDX4qgV0+IN2MabImVNZYv/bgDYKL2EnKuAlnBQJKTRof2VmDGDZtzqrZVkVgkMY9Ja/tRNMyrmExxTdCatZtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNHctgoe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNHctgoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECD1F00898;
	Tue, 22 Sep 2026 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112309;
	bh=4r0xqfwKcD7rYuPhuxy5Eq0i6gnj1H36f2pi3RLzn2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNHctgoe5cHiU8D+gGbPawhkZRcvs7vk9UFFVzmBidqJnQnO2nZed86Mcf6uEKxpJ
	 +S/136lDgYcr8r3dGNwfb204lKu4wZrZNcmI+ork/2XZ3dKoZZgBVn6kjXcKCOIkLl
	 6mhkOVJ3+WJbv8C7RKwsA3bv53ct4y1Hk5WgfRBBBzykBtmYNskfldBUDgMunHop2l
	 xLngjg29tLh60k0oxMOLpdOaNUjBstW9hXn1MieJ0Je42M5Q81jH5uVjMNnmbUb2HU
	 Bfobvdr9IhHTu5Cuw1uml0tgMm+GnAyiOEqy4qGVcIlT6V8lGw4f4juP7yUo99QP/J
	 Hipr/cuu71MWg==
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
Subject: [PATCH 6.12.y 2/2] smb: client: fix fattr leaking on wsl_to_fattr() failure
Date: Tue, 22 Sep 2026 17:25:06 -0400
Message-ID: <20260922212506.765193-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922212506.765193-1-sashal@kernel.org>
References: <2026092250-exploring-whoever-83c0@gregkh>
 <20260922212506.765193-1-sashal@kernel.org>
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
index bb2caf01cd895..7a7189f547efd 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -680,29 +680,30 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
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
 
@@ -726,26 +727,29 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 
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

