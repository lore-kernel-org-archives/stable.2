Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667151D524
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577565; cv=none; b=btG4Fei6F5sQ8StdXdZQOYf8F/nO5vYSGQEjx/McMGxe/rvKN9zuB0nMzB0oM0Up6xahPilEtYjksJ/D2ee7CQL7TsrF9KHsnd9f7kAJPoxKtaOV5zJcuX0T1zcK1+qmSDbW2jZJ7DuS4YSSxUGgYB+JnRzzYYJ2jSsPHDlUzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577565; c=relaxed/simple;
	bh=zAkHbbm5/2wROpm3H44in0biaKJqzxtsvfcZ4gT1FhA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HXDk2Q2GtqGvYJv48zqjubxFxCdLKUd2qr5sSNpZz85Ggtjx+PSFvKhBLzo4Uxi+d5gJoNUMdWT6UIbMJNzOHtIIgRjjQfeQyblI+cb32bJfg70dGis0KL+hnzXwqjPyuVCmsNJIEWc408js/KB2rDo/V56SHb/wueVO+k8JgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Lexk+RM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Lexk+RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCD81F000FF;
	Wed, 16 Sep 2026 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577557;
	bh=WzOgdoNlFYd3euupZCoJIKxPYcQiY2Z9VBSoptgvFzU=;
	h=Subject:To:Cc:From:Date;
	b=0Lexk+RMYzHc8z+fxkX++AGoDsMWBm1zLYjoBo5yofNb2o16mZ1SCj5BebsEcS0id
	 zMgrNXaiwL/DzlE9Xyr6rFulcLV2MzO6dEKyTPjEGHQDS/eY0rIQDSoUBrHC3t4vJ9
	 df/qc3X/B/WB6O0FTUk9LQmRa46U4fFvgHT+JkYI=
Subject: FAILED: patch "[PATCH] smb: client: fix WSL reparse point uid/gid override" failed to apply to 6.12-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:46:52 +0100
Message-ID: <2026091652-frantic-unexposed-7b62@gregkh>
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
git cherry-pick -x cd2b2b57921d4caa7875e83198bb2aa71254328b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091652-frantic-unexposed-7b62@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd2b2b57921d4caa7875e83198bb2aa71254328b Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 14:40:23 -0300
Subject: [PATCH] smb: client: fix WSL reparse point uid/gid override

wsl_to_fattr() unconditionally overwrites cf_uid/cf_gid with values
from WSL extended attributes ($LXUID/$LXGID), ignoring the forceuid
and forcegid mount options.

Fix this by initializing cf_uid/cf_gid to the mount defaults and
gating the $LXUID/$LXGID EA parsing on forceuid/forcegid.

Closes: https://sashiko.dev/#/patchset/20260906190803.667489-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 5cc5b0410d48..178da801e775 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1137,10 +1137,14 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 			 struct cifs_sb_info *cifs_sb,
 			 u32 tag, struct cifs_fattr *fattr)
 {
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_file_full_ea_info *ea;
 	bool have_xattr_dev = false;
 	u32 next = 0;
 
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
 		fattr->cf_mode |= S_IFLNK;
@@ -1177,11 +1181,13 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 		nlen = ea->ea_name_length;
 		v = (void *)((u8 *)ea->ea_data + ea->ea_name_length + 1);
 
-		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen))
-			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
-			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
+		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
+			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
+		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
+			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
+		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
 			/* File type in reparse point tag and in xattr mode must match. */
 			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
 				return false;

