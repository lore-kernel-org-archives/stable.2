Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49C4C33E6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577380; cv=none; b=ToSLDDlSFBZ9dJNcyVfRNkr3PSHZM3aqMFyp6ZCS/dhvKMFehKH2YuGMd3VxLaB4sOuwrPWgcQH5YuTJCpjryg3vqQmPAK52Y3Pue+pC7pSkhiZwgczaXfHUxHM7j/gvYCCnw3B02nSIu1miJFogFfwSooVhPfAWgRaRGm4CGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577380; c=relaxed/simple;
	bh=zpXkAMn96VjOPCsHUoOxhj0q5uEdqAqE/5zsTJBuPM8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jurpt23JpxjivZuWF4Q+BbO/mdYYASWLNO5uND+NsvEZE5hC0y4pKT4Ma6HvuW9g9olHNcbcbMvnjh/L+Oqc0f+N3xVVwixMB+xQphpcHKRpbjy7UGDKP2aKkffofI3k9DW9MzmdMiwdjPZkyqT+AoiFfQUBk50VppX1xOIIlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=moyZME2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="moyZME2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F691F00893;
	Wed, 16 Sep 2026 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577372;
	bh=rE51vi7Knd+GbtkgMRkMTIDFwz9hZymWH+hnIT43FCY=;
	h=Subject:To:Cc:From:Date;
	b=moyZME2NSmCUuDI8ZficjLFZUVObj42LfPaRYuZzQ9RqtYchk5i7Q2wjF4ez3NHET
	 hiJvEMnnphxjDNqkULvQF+H8ttqJDh5RMOvnFLbVGFC9J7drhTBowhbXxNBQc5ZWeA
	 /3m/qDpzeWmh5Uv729SlsxYfh4Xaz8CQmf+5pQqM=
Subject: FAILED: patch "[PATCH] smb: client: avoid leaking refcount in" failed to apply to 5.10-stable tree
To: doebel@amazon.de,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:44:16 +0100
Message-ID: <2026091616-voicing-bauble-48b0@gregkh>
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
git cherry-pick -x 9f2e63f1b2d5fc5b5423424902c091123e220e7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091616-voicing-bauble-48b0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f2e63f1b2d5fc5b5423424902c091123e220e7e Mon Sep 17 00:00:00 2001
From: Bjoern Doebel <doebel@amazon.de>
Date: Thu, 3 Sep 2026 21:28:58 +0000
Subject: [PATCH] smb: client: avoid leaking refcount in
 cifs_queue_oplock_break()

cifs_queue_oplock_break() unconditionally takes a reference on the
target file before queueing cifs_oplock_break(). Only that work item
decreases the reference counter again.

If another oplock break arrives while that work is still queued,
queue_work() will return false and not queue this second work item. As a
result, we will never reach the point to drop the file reference again
and are leaking this reference. This can be triggered when interacting
with a slow-responding server.

As a result, later unmount operations for this file system will fail with

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]
  VFS: Busy inodes after unmount of cifs (cifs)
  kernel BUG at fs/super.c:777!

Fix this by only incrementing the reference count if the work has been
queued successfully. Taking it after queue_work() is safe because all
three callers hold tcon->open_file_lock across the call and
_cifsFileInfo_put() decrements under that same lock, so a worker that
starts the handler in the window cannot drop the reference before it has
been taken.

Fixes: b98749cac4a69 ("CIFS: keep FileInfo handle live during oplock break")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index d4db3f91a91f..945194fe7a97 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -378,10 +378,11 @@ void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
 	 * open_file_lock to enforce the validity of it for the oplock
 	 * break handler. The matching put is done at the end of the
 	 * handler.
+	 *
+	 * Only take a reference if the work is actually queued.
 	 */
-	cifsFileInfo_get(cfile);
-
-	queue_work(cifsoplockd_wq, &cfile->oplock_break);
+	if (queue_work(cifsoplockd_wq, &cfile->oplock_break))
+		cifsFileInfo_get(cfile);
 }
 
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)

