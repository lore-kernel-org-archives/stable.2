Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605987;
	b=fvqZlahI8+jsNxVblNiMVeD2/+yZD492SGSji0WHThcgIrXnPS097lIwo6k2xNMypn5c
	 lZgdtZdvwwOXLqJt5xEJp7tEYO95mgUW075F3607f/SvdAB6k4yIm4lEqFDlGchcjQ4Cb
	 xnWtKuBdj0d+fMJsdWjIWcEPlOzIkG5T9BT7AWpP6Jw8drXkx34j8eeJvYZgq4UnDEz52
	 l0Vag8nNFCdEOv9HJgki+cKgrOBBTnjyjnigWBbzyxnKwsBMI2T69KY4FQhaD62RV8n0X
	 TBOovHIZhYabEr0HkKDx7bHFM/JmG9VvCuJxkE3oU6GpRyQchVUgLPr8mDwtbmUFjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605987;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ilQJuzbJPFh95ukmDskbbaFBPQb1xa3CtU37RvzGfP0=;
	b=BtOvKCTORb97FxibSqoPp8kE0P1KdbMHh7v6ypJ9Rm4EmZrGyS8RfCGkuIJbkpLZQkJ9
	 TQ/SCOPrYwnUXDKDKgxydKpe6ngHg+1DzhevlTIxBqw1X0reUaR9Dy6c2Yezr0Zmo2jQh
	 UtBunnjj4DYbFSFN3iWzVjK88lkOPMMjr36O9DeyWFOckw11Rkp41yAHfDYLSihaIA1tK
	 hbD/oLUDxHYnVk/D5SbbLSXdfQrpgHnfhiDkdna44Irsd3Z3Xj7z74TJo3lpd7ZdDw49T
	 dVXxxF+qGnJasMYUOtWkYaLvtLr4JrVmAgfkjXf7CO/1x3TFW/A+zF3N4iQPzcBqXNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V5OmRTAT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1804606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V5OmRTAT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B750F1F000C0;
	Wed, 25 Nov 2026 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605986;
	bh=ilQJuzbJPFh95ukmDskbbaFBPQb1xa3CtU37RvzGfP0=;
	h=Subject:To:Cc:From:Date;
	b=V5OmRTATw5GRInQJFX8sF5hy4yiZOjuhmBUorBiAk0/QVLBLTLmUArA5NCa5l9FqK
	 XffxPDLGrY9PTm1pIkWG2nf+LepgauEoC7hXRrkjUBm5O8mlIIR8l6Z8R/SZKhiOpj
	 s8VnYz13IWMzZ2MMYrJeZALiku4XVP3zt9uc7ltI=
Subject: FAILED: patch "[PATCH] smb: client: don't block dying tasks waiting for writeback on" failed to apply to 5.10-stable tree
To: pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:10:34 +0100
Message-ID: <2026112534-bullfight-wanting-5e38@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 15ea186abbcd04157c62e0901701870b812bb2bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112534-bullfight-wanting-5e38@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15ea186abbcd04157c62e0901701870b812bb2bd Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Wed, 28 Oct 2026 20:35:11 -0300
Subject: [PATCH] smb: client: don't block dying tasks waiting for writeback on
 close

cifs_flush() waits uninterruptibly for the writeback it starts.  A task
that gets killed while closing a file on a hard mount with an
unresponsive server is stuck in D state until the server comes back.  It
also consumes any writeback error for a caller that is about to exit,
hiding it from everyone else.

Wait killably instead.  If the closer gets killed, stop waiting and leave
the error bits in the mapping for others to see; writeback already in
flight completes on its own.  Don't wait at all, nor check for errors,
if it is already dying.

This is also needed before letting dying tasks issue their writes from a
worker, which would otherwise make them wait for every one of them.

Fixes: d3f1322af8f8 ("cifs: wait for writeback to complete in cifs_flush")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index e8557c670dc3..03e179c30d5a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3043,17 +3043,44 @@ int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return rc;
 }
 
+static int cifs_wait_writeback_killable(struct address_space *mapping)
+{
+	struct folio_batch fbatch;
+	pgoff_t index = 0;
+	int rc = 0;
+
+	folio_batch_init(&fbatch);
+	while (!rc &&
+	       filemap_get_folios_tag(mapping, &index, (pgoff_t)-1,
+				      PAGECACHE_TAG_WRITEBACK, &fbatch)) {
+		for (unsigned int i = 0;
+		     !rc && i < folio_batch_count(&fbatch); i++)
+			rc = folio_wait_writeback_killable(fbatch.folios[i]);
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+	return rc;
+}
+
 /*
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
  */
 int cifs_flush(struct file *file, fl_owner_t id)
 {
+	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
-	int rc = 0;
+	int rc = 0, rc2;
 
-	if (file->f_mode & FMODE_WRITE)
-		rc = filemap_write_and_wait(inode->i_mapping);
+	if (file->f_mode & FMODE_WRITE) {
+		rc = filemap_fdatawrite(mapping);
+		if (fatal_signal_pending(current) ||
+		    cifs_wait_writeback_killable(mapping))
+			return 0;
+		rc2 = filemap_check_errors(mapping);
+		if (!rc)
+			rc = rc2;
+	}
 
 	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file, rc);
 	if (rc) {

