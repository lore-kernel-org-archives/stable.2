Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAB387364
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089990; cv=none; b=N1FqBg36R3DxDRTQnvADp0LI/gDI/TnzvZuaU2ZSyBHRBwrZpL8isKTVtNYYATZ1JaQFw/IHm5mAx4ThM8PthnUaveyKbIvgcr4dXK1/PkwNsM6YmJxdnbrYdRm4qRMQ1HKoQCh/RMCPXn5W3yQlyUfCXYk6WIvucgBxTRFFtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089990; c=relaxed/simple;
	bh=LdBaBH8SCp4SkMmXqxFqTUYdfGsNMcchQpGs6G4WL5Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jFY/644K1Ow8uxUXvN2Vp6xSx1SD30xSmr/A5mBm7mj6a09CVgPE6C6tPzguobXITShtnuE9uttl77w7OUkjNks8oSr5a3VDBA0QhIIiDBFfTOsHmoDjeF3SOBlfOs3ha0YB0EbUqh4lTfbKxnp+bVp5r9V3XNh3mz35Brx4ULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Zf8z/XI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Zf8z/XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C91F00899;
	Tue, 22 Sep 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089987;
	bh=G1tp7Iqw1lHf7tsPS2Sk6aICkJQSGv5rFP+v2EgI5Rg=;
	h=Subject:To:Cc:From:Date;
	b=1Zf8z/XICRveNsV0raR0gPCXB6kLRLu1dYODJdTJy8tvxPS4mY+rfSVbh03+p63ng
	 XnZGggy2WyJsss/OV+kZKykb1Bp2QiSiLi6XouIqaxaPOddrWhVur9varOzYkzC6u6
	 MgN0Qpqok0y+I4wxXW3d37QhUYMWRAnvi8aDEmCk=
Subject: FAILED: patch "[PATCH] smb/client: send lease break ACKs thru correct session for" failed to apply to 5.15-stable tree
To: april.cardenas@canonical.com,bharathsm@microsoft.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:05:19 +0200
Message-ID: <2026092219-pretended-swung-72e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ebc5660132ddd244b57f03ed324922013a3d7363
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092219-pretended-swung-72e7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebc5660132ddd244b57f03ed324922013a3d7363 Mon Sep 17 00:00:00 2001
From: April Cardenas <april.cardenas@canonical.com>
Date: Thu, 10 Sep 2026 00:16:49 -0500
Subject: [PATCH] smb/client: send lease break ACKs thru correct session for
 multiuser mounts

Currently, when cifs_oplock_break handles a break request from the server
it searches for the appropriate tlink to handle the request
but incorrectly uses the current fsuid as the search key, eventually
causing read errors for users with multiuser mounts on NetApp.
Fix this by using the tlink from the cfile struct instead to respond
through the correct session.

As breaks are handled in a worker thread, the current fsuid
isn't guaranteed to match the session that the break is intended for.
This means that cifs_sb_tlink may search the rbtree using the wrong fsuid,
and return a tlink with an incorrect session than
the lease break was intended for. As a result, the breaks
may be ACKed through an incorrect session.

While it seems that Samba/Windows Servers 2016-2025 ignore this as long as
the lease key is correct, we ran into a case where if you're using
NetApp ONTAP or Azure NetApp Files they will reject the ACK
and return `STATUS_LOCK_NOT_GRANTED` errors on any future read requests
a user may initiate through their still held open file handle,
and the server will eventually close the file.

In the dmesg logs, the user may see errors like these:

CIFS: Status code returned 0xc0000128 STATUS_FILE_CLOSED
CIFS: VFS: Send error in read = -9

With a multiuser mount using NetApp, this issue is really easy
for users to hit on a wide variety of kernel versions
by attempting to copy a file from the share
to the local machine through GNOME Files/Nautilus.
This copy will always result in Nautilus throwing
a `Bad File Descriptor` error to the user and fail.
With this fix, you can copy files through Nautilus without issue.

>From looking at the traces, it seems that glib will
open the file first, and call listxattr before actually attempting
to copy the file data. The listxattr call always triggers a break,
causing the copy to fail.

The proposed fix returns to the way the client grabbed the tlink before
commit e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break").

The bulk of that commit (checking for list empty) remains untouched, and
I think the change to using cifs_sb_tlink was intended to avoid a
NULL/ERR deference on the tlink as well as update the reference count.

I believe this fix should preserve those safety properties, but of course
I'd appreciate any corrections here.

Fixes: e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break")
Cc: stable@vger.kernel.org
Signed-off-by: April Cardenas <april.cardenas@canonical.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Bharath S M <bharathsm@microsoft.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1aa4844f8b8a..0d428517f454 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3354,8 +3354,8 @@ void cifs_oplock_break(struct work_struct *work)
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
-	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink)) {
+	tlink = cifs_get_tlink(cfile->tlink);
+	if (IS_ERR_OR_NULL(tlink)) {
 		/* drop the reference taken when the break was queued */
 		_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 		goto out;

