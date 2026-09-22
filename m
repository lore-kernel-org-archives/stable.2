Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58733403AF8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065467; cv=none; b=nk5+VKYlHrARZkqhy2wFJnL1zO4dPmrN014cpBMG4r/PbLC29d3lCHW4yQIzEw8oVJl1x1FQ/lRBxtX3KqXfRSi0USIcVs3/STlpFU9kCBW6rXWstUjpx5qxYUt9ZVK4DGhB8EWweYN7j8P36GCA7Cvt92E+03bZR/GPfUMa4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065467; c=relaxed/simple;
	bh=W+a1zqKAX9SYLgjiZBl+xb4cjZidKRSrVhKdo7Pd6Eg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E1iXtFGYuv5F6oV1+wrFfBebU382nWDkFtDLyt+/d+MVhX/FdyL+/orHceFLTHKucmLpLOTTncI6MpuZpXxXhoz5TXYJKu+pp6oiKPTvKrZGOI8qfG46ofSwVp+16D8OxU3l7Iv4RWfOKyA7BTjxm+/8B0qlbqub4dTmFwTI+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+laU7YL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+laU7YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F11F000FF;
	Tue, 22 Sep 2026 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065465;
	bh=TpA/nkpeJCJYh1eELEm6ybfm6rUd8Zc0peFZ/1XUpeI=;
	h=Subject:To:Cc:From:Date;
	b=Y+laU7YL4JiWPyZTqTlDhBpe8/JyUi4K5GeIfTJgZVLVfuveICL2bzdqccgdv/JzP
	 42Ap+eXlBdRz0BPFY80W6VBzyhTyFxMLQpM50EAbr/Ovos70eTHsMz3hzESeEBlEb+
	 JOg+6zTp3c0ozi8O6CCtJdkcvMfkeylyWD5JOxKM=
Subject: FAILED: patch "[PATCH] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,asmadeus@codewreck.org,mike@method-b.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:24:22 +0200
Message-ID: <2026092222-rubbing-overplay-5a22@gregkh>
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
git cherry-pick -x c60ae98c5aa64021751b38ab1313b19d620bf640
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092222-rubbing-overplay-5a22@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c60ae98c5aa64021751b38ab1313b19d620bf640 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 11 Sep 2026 10:25:04 +0100
Subject: [PATCH] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size

Fix v9fs_issue_write() to update i_size and remote_i_size to the new size
of the server file if we made it larger, using the start fpos and the count
returned by p9_client_write() to calculate the new minimum file size.

This assumes that if the 9P server makes a short write (say it hits
ENOSPC), a reduced count is returned.

Fixes: 5fb70e7275a6 ("netfs, 9p: Implement helpers for new write code")
Reported-by: Michael Mulqueen <mike@method-b.uk>
Closes: https://lore.kernel.org/r/fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk/
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
Message-ID: <2226525.1789118704@warthog.procyon.org.uk>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 1ac0b3dcc077..13cf87a5f90c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -54,11 +54,37 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	struct inode *inode = subreq->rreq->inode;
+	struct netfs_inode *ictx = netfs_inode(inode);
 	int err, len;
 
 	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-	if (len > 0)
+	if (len > 0) {
+		uoff_t end = subreq->start + len, i_size, remote, zp;
+		bool set = false;
+
+		spin_lock(&inode->i_lock);
+
+		/* We can read the sizes directly as we hold i_lock. */
+		i_size = inode->i_size;
+		remote = ictx->_remote_i_size;
+		zp = ictx->_zero_point;
+
+		if (end > i_size) {
+			i_size = end;
+			set = true;
+		}
+		if (end > remote) {
+			remote = end;
+			set = true;
+		}
+
+		if (set)
+			netfs_write_sizes(inode, i_size, remote, zp);
+		spin_unlock(&inode->i_lock);
+
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+	}
 	netfs_write_subrequest_terminated(subreq, len ?: err);
 }
 

