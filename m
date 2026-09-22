Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC355293C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090018; cv=none; b=fm0hM5KqfqQgGfPq+9kjXp/sizH2VqeoX4AJ12+gN27ry4OBKDullievkWOA2GdbI2rL4Y8yu902/AXqH5jcIOEtskb9rqGCXfttxJNoAhX0huCK2Sh6N8prHPPtclplOJBK/NoxkICUQgn6oy5s8oWg4mwU7EzTm4j/bFFBxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090018; c=relaxed/simple;
	bh=kg4FR13KfYMDcbDXMxJJHgU69L3KWJEhNMLWRlXoK1A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GB5gu+/my+e4uNSvKq5pfBkpR1dX4KVswR9mCMolPx605Wi0MNGli6m80Cuh50JK6nzpC6qTPlGtnfmppmY+YxX72yhn6tQ0Id5zpAV90uGJxa7tCaXlq1qyuDbnio2cc7HJG84WEiqATdIuiK8sBK9WArFv578Hfo85AFJvKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBgS18xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBgS18xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AE1F00893;
	Tue, 22 Sep 2026 15:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090016;
	bh=ZfD2w5mtbKZ/f048dLO1QvzBqNwPzfK3nzjtP1yUUI8=;
	h=Subject:To:Cc:From:Date;
	b=XBgS18xw5Db9Lnfo0kJQwatkAnNttVaI939vmj1jkfSm7haxsP6pK3iVoEcKuAIpu
	 ELU+zK6AVTzMvVJOWU66BSh2Arq2lkyvoYzSPjVGU4sjCwvfBB4jPhbcgbk8cGUOfL
	 yBr15O3PFrgA4+jWsIAhH53cgTkuCWKCRFQnwhiU=
Subject: FAILED: patch "[PATCH] smb: client: fix fattr leaking on wsl_to_fattr() failure" failed to apply to 6.12-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:06:50 +0200
Message-ID: <2026092250-exploring-whoever-83c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e1253a82bb4c0fed6706a5839fc8b6e01be1abe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092250-exploring-whoever-83c0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1253a82bb4c0fed6706a5839fc8b6e01be1abe2 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 13 Sep 2026 21:15:41 -0300
Subject: [PATCH] smb: client: fix fattr leaking on wsl_to_fattr() failure

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

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 6ac69f4d391a..3a27773186ae 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1149,29 +1149,30 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
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
 
@@ -1195,26 +1196,29 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 
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
 

