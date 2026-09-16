Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC34C33CF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577657; cv=none; b=Qbd49nyPQY7sJpgXeiXFnUUXRibqiv+87TOT7dC8IYDUi7VWp12LzF0opHDXDFUH23yjMSBZGbXnv2bm7OnUPXaHUjiqNRPSNBuDMD89SbW4kJdyJNOs1eR7YswCT6TdhX2BiLhITxqaeNLUnWNk3yh6zgyAyG8SL77/cJMMnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577657; c=relaxed/simple;
	bh=vMvHqd/dg31Xp5isiPFQGQlRB7ZUl5abb6ZtfNJXziM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UbGc5OUyxRB7dYfbUjRyiaODfC9jBTfyJ9EI0OH40uDoud0Q5v1cUeSYkcF5ZV5JOUND3hlWxMcim5ugLuRrjHgqXruZuo52kx2hLBf969AKnU7vjk+yMsaNw31nAZv72rrl4k4LrDwRYOYE0Xo4ftcZXXzUtoI3kU2jhZie/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYw5t+Wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYw5t+Wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F21F00893;
	Wed, 16 Sep 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577648;
	bh=yZSXWkjE+xWZJs7nIo0hfpXPOzGO3MHSGhf+VqTZOKc=;
	h=Subject:To:Cc:From:Date;
	b=jYw5t+WkjF5PfJYWB6YzdEyWFyjXebN144WsqHBTZZRSYGyLrSmOh4glF2kAOUtAp
	 LbG4UY4a6O0n4XBimwsPuFYkgrj9f9TSk4cEsKi2h+GG+H7qTeZ1/ZMEqhMl7OXsQs
	 u4CPRo6DldsKSBaANn44QlMMfATJs6BsbcXge9K0=
Subject: FAILED: patch "[PATCH] smb: client: avoid using uninitialized SIDs in" failed to apply to 6.1-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:49:30 +0100
Message-ID: <2026091629-whiny-coveted-cab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x da6e25842431982d5a53cf00d925b98c690f4467
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091629-whiny-coveted-cab9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da6e25842431982d5a53cf00d925b98c690f4467 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 14:40:39 -0300
Subject: [PATCH] smb: client: avoid using uninitialized SIDs in
 cifs_posix_to_fattr()

cifs_posix_to_fattr() ignores the return value of posix_info_parse().
When a malformed POSIX directory entry is encountered (e.g. invalid
SID lengths from an untrusted server), posix_info_parse() returns -1
without populating the 'parsed' struct.  The uninitialized stack
memory in parsed.owner and parsed.group is then passed to
sid_to_id(), which processes the garbage bytes and passes them to
request_key() to construct a SID string, potentially leaking kernel
stack contents to the userspace idmap daemon.

Fix this by checking the return value and skipping the SID-to-id
mapping when parsing fails.  The remaining fattr fields (timestamps,
mode, etc.) are populated directly from the 'info' pointer so they
are unaffected.

Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40manguebit.org
Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 1ea84f4ada39..9530e5b01564 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -244,8 +244,9 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 {
 	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_posix_info_parsed parsed;
+	int rc;
 
-	posix_info_parse(info, NULL, &parsed);
+	rc = posix_info_parse(info, NULL, &parsed);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
@@ -284,10 +285,15 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 
 	fattr->cf_uid = cifs_sb->ctx->linux_uid;
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
-	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
-		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
-	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
-		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	if (rc < 0) {
+		cifs_dbg(VFS, "%s: failed to parse SIDs: %d\n",
+			 __func__, rc);
+	} else {
+		if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+			sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
+		if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+			sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	}
 }
 
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)

