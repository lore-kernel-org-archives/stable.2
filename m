Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7A4B1276
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443317; cv=none; b=uldjqi4w1mcQ34wTGUWyQmGv+9inhGh/8nv/VDv93E2aSB+kG+/ve5cmLUlXXBCfcjgBDWO+NYaEwdnMbejkODOCYKZn+p0sSNABdMEJZWyaQmn+GuDopUt6fR9FO40gHz88eUoVBsXOlFgjTXu4STo7gy9XhCwNz84bzz+Ho2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443317; c=relaxed/simple;
	bh=bM1OG7EX3hEM52HTT3+ZgRjg0+L3ElgUxAOaPEsBi98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NE/EQyPK9uPlNqBCVJ7Z++LzC9Q0RQCYQXOMXtGy/Q+g1jpRAEWyTw5MEzzRjtM4cmVaprkE3ra2V/7ezqqha/HPyU4D7n2xwAh2O7wbC24wFG7Ogavo/J+gk/RKJAHSbidpZMUHlRN3jqgt+mJUT4xTviuF79K7P6MpHFxYxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nPN+uQII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nPN+uQII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54D11F00A3F;
	Thu,  3 Sep 2026 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443304;
	bh=qDy9o0KRc3hrjqhWM1DgJAiGKkiLXZUf+A584jwZLUk=;
	h=Subject:To:Cc:From:Date;
	b=nPN+uQIIO/Ebo5/ZeENI3tnh/RSRKLTI7eqLsS6YtHe9AniPIXeOtqBOaQCuHoWyV
	 0xwVwa8vsSgaKSZB33oZssnV9BOEcJdKhg0CUeGO3ZHqjSeH2RXDxkDkmqRwurwPdT
	 3l3nucKBtzpIRHwqRnHHYBWxaHnbJXtzUub9q8z4=
Subject: FAILED: patch "[PATCH] smb: client: clear setuid/setgid bit on write with" failed to apply to 5.10-stable tree
To: yijiangshan@kylinos.cn,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:25:54 +0200
Message-ID: <2026090354-consonant-fondue-4dfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b8e5dc4f95e5484159b343903f302eb6d783f2e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090354-consonant-fondue-4dfb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8e5dc4f95e5484159b343903f302eb6d783f2e6 Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Thu, 16 Jul 2026 10:22:14 +0800
Subject: [PATCH] smb: client: clear setuid/setgid bit on write with
 cifsacl/modefromsid/posix extensions

When a file has the setuid or setgid bit set and is written to, the VFS
strips those bits and issues a setattr with ATTR_KILL_SUID/ATTR_KILL_SGID
together with an ATTR_MODE carrying the already-cleared mode.

Both cifs_setattr_unix() and cifs_setattr_nounix() unconditionally dropped
ATTR_MODE in that case:

	/* skip mode change if it's just for clearing setuid/setgid */
	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
		attrs->ia_valid &= ~ATTR_MODE;

This is fine for the default mount, where the mode is only emulated via
the DOS read-only attribute and cannot represent the setuid/setgid bits
anyway.  However, with the "cifsacl" or "modefromsid" mount options the
mode is stored on the server through an ACL (id_mode_to_cifs_acl()), with
the SMB3.1.1 POSIX extensions the mode is sent to the server directly,
and with the SMB1 Unix extensions (cifs_setattr_unix) the mode is sent
via CIFSSMBUnixSetPathInfo().  In all those cases dropping ATTR_MODE means
the cleared mode is never pushed to the server, so the setuid/setgid bit
survives the write.

This is a security issue: on local filesystems the setuid bit is stripped
when a file is written, but over these cifs.ko mounts the bit persists on
the server, potentially allowing an unexpected privilege escalation on
subsequent execution.

Fix this in two places:

  1. cifs_setattr_nounix(): only take the "skip mode change" shortcut
     when the mode is emulated via the DOS read-only attribute (i.e.
     neither cifsacl/modefromsid nor the SMB3.1.1 POSIX extensions are
     in effect), so that the cleared mode is propagated to the server
     in the ACL / POSIX cases.

  2. cifs_setattr_unix(): this function is only called when Unix
     extensions are in effect, so the mode is always stored on the
     server.  Remove the shortcut entirely so that the cleared mode is
     always pushed.

Fixes: d32c4f2626ac ("CIFS: ignore mode change if it's just for clearing setuid/setgid bits")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0afff761aab9..5f58fb46363d 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3214,9 +3214,13 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		attrs->ia_valid &= ~(ATTR_CTIME | ATTR_MTIME);
 	}
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
-		attrs->ia_valid &= ~ATTR_MODE;
+	/*
+	 * This function is only called when Unix extensions are in effect,
+	 * so the mode is always sent to and stored on the server.  Do not
+	 * skip the mode change when clearing setuid/setgid bits: dropping
+	 * ATTR_MODE here would leave those bits set on the server after a
+	 * write, which is a security issue.
+	 */
 
 	args = kmalloc_obj(*args);
 	if (args == NULL) {
@@ -3425,8 +3429,23 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		attrs->ia_valid &= ~(ATTR_UID | ATTR_GID);
 	}
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
+	/*
+	 * Skip the mode change if it is only being done to clear the
+	 * setuid/setgid bits *and* the mode is emulated via the DOS
+	 * read-only attribute (the default, non-ACL case), which cannot
+	 * represent the setuid/setgid bits anyway.
+	 *
+	 * When the mode is instead stored on the server - i.e. with the
+	 * cifsacl or modefromsid mount options (via an ACL) or with the
+	 * SMB3.1.1 POSIX extensions - the cleared mode must be pushed to
+	 * the server.  Dropping ATTR_MODE here would leave the setuid/
+	 * setgid bit set on the server after a write, which is a security
+	 * issue (the bits are not stripped as they are on local
+	 * filesystems).
+	 */
+	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
+	    !((sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
+	      cifs_sb_master_tcon(cifs_sb)->posix_extensions))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {

