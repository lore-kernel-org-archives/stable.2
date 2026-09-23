Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BB47CA76
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154895; cv=none; b=nCVXQN9S0HUZSsN5Fjeg7HoswJoUI88NjF1N0W//CzfPUHZMNTUYzdt0XL/mccnpvXi0CSWY69rTiMfgJH81+ACPoXr6+ywQZ05DJhmk16GgEg4NZFYCcoH5qFRkHeomcB8jMrog+YDldxBHeZVKD46aDAIFWQktwG6gobG1BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154895; c=relaxed/simple;
	bh=bF95LPp5xRg4SCfhGL2Ub2CUe6kUUBFu/fRLk9o6B10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rFfVaqMGycTzrMriibGmNV4+VMN59f4QCtZ4iKGC+Ec6bh54Etgw1XCfZyjsZ3JN1wsGlWRAKzNHNKOvJ4F/lDyRSo6mcw+ChWRSHnBeOCgKwyicJaDJZHNrXm0xlRqf9m5H0A0UDlMQxxkeBaH1EVDzUjNlV2uKqPeHI7ALaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSOehPmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSOehPmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D71F000FF;
	Wed, 23 Sep 2026 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790154894;
	bh=tYq5KWcdYM6rGB+kBfLYd9A8Gyn9IrMgAYuGo1BcKBM=;
	h=Subject:To:Cc:From:Date;
	b=uSOehPmuIqWSIVUolPJmhT0TrdqXiWjO1QmZH6ILvu/zaKhGa8nFM7Lpi6M+ogx46
	 RCBokhhLD11NrGIVfOQBKYy698vYPgZt7uibRv4A5j1pWeGjJk08jUIGgxspVJAGJP
	 qr84hNSuCU9a0qFYPiW7TQfPeuoBqGUlAJ2MpsGg=
Subject: FAILED: patch "[PATCH] smb/client: send lease break ACKs thru correct session for" failed to apply to 6.1-stable tree
To: april.cardenas@canonical.com,bharathsm@microsoft.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 Sep 2026 10:10:53 +0200
Message-ID: <2026092353-natural-vicinity-cd4b@gregkh>
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
git cherry-pick -x ebc5660132ddd244b57f03ed324922013a3d7363
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092353-natural-vicinity-cd4b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

