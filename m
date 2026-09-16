Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18752E053
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577377; cv=none; b=g00FkQSt+eMU+OCqcmZD1Jc75gkRqu3YUUjfp4cXL1gIobd+0QPuecctrbB+ldhUTJD4uVJOnB4ZgUqZBHVE0Ul6XZ1yNFVang3IvL9oSRL1gVGXMEUXRF0SlkM7ylgh0ochDoHJmIi/RmX7ep1ZzfRJew+lsaziSH5nvW+c1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577377; c=relaxed/simple;
	bh=GzgQ45llZEowPQpBKziEvK5G8P7LtqrRLw4SUWplkEw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OlEAOI/Y3Bp9w3lZvturYHuMwwdUCwWUHlwIzi+h2RQ6bKrmTXGVx3seAQvAP4+LTzgtrlQftqOCrip3SNg3n+/3z0f7OgMGKs1odfSkjpoqxdGNwPqQGfzqA8KefD0nSrCqv3VYBWgW6b0LmWaCsCdry8FIfWQQ5zO8EnuYAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuFntQSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuFntQSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F01F000FF;
	Wed, 16 Sep 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577369;
	bh=r6IsS9uGv788z5EGJ3Nc+u1D7PD7XWky5P5cvyZ2AX0=;
	h=Subject:To:Cc:From:Date;
	b=WuFntQSasC2MhQED8JzJtS6le5UcILCjltF6X0IzwVVr91o0Kh1bx91VKZKrJT0Sv
	 iU6E1MimwDT1IvuvGS9NJ/OMO7S9jnSIltyNlgPQoBbzb4GKwru+SGcC5vltlLSty7
	 zXPwCJyp4Io1VsqOzhW8xy86J7Ln0e2gYQzPtCB4=
Subject: FAILED: patch "[PATCH] smb: client: avoid leaking refcount in" failed to apply to 5.15-stable tree
To: doebel@amazon.de,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:44:15 +0100
Message-ID: <2026091615-enchanted-bucktooth-2e30@gregkh>
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
git cherry-pick -x 9f2e63f1b2d5fc5b5423424902c091123e220e7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091615-enchanted-bucktooth-2e30@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

