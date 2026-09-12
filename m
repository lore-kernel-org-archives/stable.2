Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9192EBDE9;
	Sat, 12 Sep 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197643; cv=none; b=QUF4veTzZccORkJZ6T05RNa7/r6OpmSC7DfQ1IaccsJC6npbuR3JICC8NPYJCMFr5+xWJ41JQ5RK6FxsITEcat6J5i1fBJvTRTwR6HGCkBaGHmidEevQyr4yTYiGjcQcTneHGB+bWQLMexWKFu6++2tz9t27TFik8lvtIrGfCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197643; c=relaxed/simple;
	bh=u8ivYwxK+2BIM0DzoW3aB5C7wCGYriQe/fCxpUC+Tmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgEKXqymMA+L2f1rthKpr3Xh+OD59emhgUYHNAnplFfSZik94yxoZ2XDei05+xeJ/beMA3g6gkxR5sfc4OIYEGxuDrptkjkISute97nf7NEEIC6gNue5IHUACMCZBpL9hGvoaL4zU85tryFhOvCCR4sOMCAAqR//bNP0FNj0yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=TblNxtxB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="TblNxtxB"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8622F14C2D6;
	Sat, 12 Sep 2026 09:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789197637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dW41XwRFtq+O0RRRVs3avgWhzaMEj/gxt+nXVXX5eHU=;
	b=TblNxtxBcJrUuhFvy/DHnW8cXnEWRxowX/lEeBIiy88g/ZDWBxtW2DTUhaFFVXhfD+6nS5
	ttbaOwOjzY6KZJIFVnE/+3Jv0dgjrwRMiw5n9Fel5HzDCAVtPAmFa+6mqADDbvvTkX4NuN
	8+AcC1TqvVHnOGTuq75lD/jOURdsD1av2alQL9MyFy8vFGnKEBHKPY6FHCoPtOIhQnLDAr
	fEkCLfRqhD+zGGIvsorzB1OOofnr4WbJqvmFNnR9dlhAwlr4Ae/VONri3zwR+ej8V2MeJG
	oJ9HkkL+NXm62Edih7thZbpV4usOpIk3FqrWX5ITAaxLxiKbiyXWo4xB0LEEvQ==
Received: from gaia.codewreck.org (localhost.lan [127.0.0.1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id afb269bf;
	Sat, 12 Sep 2026 07:20:33 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: 
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Michael Mulqueen <mike@method-b.uk>,
	stable@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size
Date: Sat, 12 Sep 2026 07:19:41 +0000
Message-ID: <20260912071940.3-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

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
---
I'm resending this as a patch to get sashiko to run on it, please
disregard this email and reply to the original thread (Closes link
above) if you have concerns about it.
(well, I guess either David or me will see it either way, but it's
easier to follow if it's all in the same thread)



 fs/9p/vfs_addr.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

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
 
-- 
2.55.0

