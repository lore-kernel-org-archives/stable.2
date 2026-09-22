Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38654147B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079514; cv=none; b=m82Sr6e4ufO/94UwyKnPwH4NvlwO4G5LHsnPYM9R4mY6kn0eqYxeQiDQY6ucUE+kb21u8ufMaunsnQMs2ycdg2LroVRh4q4+puG5o0f6MelGmglogtwmjHM7IjPoSQtL+vK3RTAhLhHGT7UgcnoByr1SPABHZ8BOkMkdlUvHLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079514; c=relaxed/simple;
	bh=jH51O2oMVF7H+KVbop/LRdyqeVQctDutibMySzekTMI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g8pMrpFZPu3hFvsFm78jr/2QDx9Hkhv27IDTUAZrd8zsbQ5kVTjVpov/QGT/l9jByOt2950rW2lNfvI1Jhjv5HBC+o7T6FQfDVL83o4TFoINZXeB9C5yFpEu6h11spzYV29z8FTGVZaa2HJGxEBfCzryJihaVJiJIGWXhS0ulzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lopc2HmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lopc2HmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC641F00893;
	Tue, 22 Sep 2026 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790079511;
	bh=Mb+BL+JGzKR/GHEYyhgOPYoCKUCOoOAgOaT9FmCz6wE=;
	h=Subject:To:Cc:From:Date;
	b=Lopc2HmDsUXeIZMZpdyyBwiJzGU75gEP1j50nWbd9bCcJas8b72m7Nr+skXz3Bg42
	 KyA8LZVxC+S+6F1mqnq1IEehiHtwCyYWqU3vtPfK3uU40uyQu2VSp+h+Q0gXs90lAw
	 DuzcTEDVp68zvS1sEIAIrJHIadHXMmtozhneo59o=
Subject: FAILED: patch "[PATCH] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size" failed to apply to 6.18-stable tree
To: dhowells@redhat.com,asmadeus@codewreck.org,mike@method-b.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:44:30 +0200
Message-ID: <2026092230-barmaid-washday-b084@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c60ae98c5aa64021751b38ab1313b19d620bf640
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092230-barmaid-washday-b084@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

