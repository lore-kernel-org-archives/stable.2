Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE943C07C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099478; cv=none; b=jZb9WZ+RnLCsJdj45iSoXDkRyDBVJApvdiGJbFrIz1U7TIDevub1YpRmUc/DG8Ey0LLFYUky+jHHGGyyfpkjJAUnJ6yDOQRwJpunMMtZrF9BTpRei8BGxL4robzT+C+/xouq1B+5lP+3O18DKKzFacm5FflUE3as+3RWRPQgI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099478; c=relaxed/simple;
	bh=u/a6mfQXyw7y9CaGujBA/Y6K5L4oXY9+VX15fqwuLzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh2FexvZj63Z+T9aQEeznZZCFc3iEDxvQd/G5gPa3YXqyVHL9gXZTUQFif0cDbFQQy/Ug8UlSmg3spVH4OgjJMuFUeAQhks2/kkwBu7aGGhxi1rLDrTMcq5GqNyfhTKKujgd4Ek7WnueqRHGBRZ36YorivJliT+XYP4sQnrjsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP0T/XQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP0T/XQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BBF1F00898;
	Tue, 22 Sep 2026 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099476;
	bh=NfW3FAADEU1PT/shzaJNafm7JrJVnchcFiFTWS8Ya+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GP0T/XQ9C4FwPcAcwEUDR54YYppw82h1/vO2sRxfaUqPEkfn+Q8DCCbiA6/X6SPCN
	 bnlXC/ZBYzHgmCUQ9MtdFsHOLb54mDxjRJv1Gowrg9uHgR+UFKfchAlgDyIpHXtM45
	 Lj+DWvh5wRQQZjqoUF8zy+jO61Vjv154xbogHFhWd1KHKBzGYyvhFqleGWxpv9cz5E
	 Xdei+wsKNgT6TGCkRS0z4iEQmWp8wyXZrVLLBFEmpCB4Ykh1eNvRYrqHyC/N1En9nY
	 FWaU9LLfLwMZcripM5DJktB6N6Cm3VrF3REnreKhm25Ptma7tMm4bvlAHSABfWygIN
	 Ql+pgnP1DfhRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Michael Mulqueen <mike@method-b.uk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size
Date: Tue, 22 Sep 2026 13:51:12 -0400
Message-ID: <20260922175112.3308891-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175112.3308891-1-sashal@kernel.org>
References: <2026092230-barmaid-washday-b084@gregkh>
 <20260922175112.3308891-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit c60ae98c5aa64021751b38ab1313b19d620bf640 ]

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
[ replaced unavailable netfs_write_sizes() with i_size_write() and direct remote_i_size assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_addr.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181baca..6bf5973445b66 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -54,11 +54,38 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	struct inode *inode = subreq->rreq->inode;
+	struct netfs_inode *ictx = netfs_inode(inode);
 	int err, len;
 
 	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-	if (len > 0)
+	if (len > 0) {
+		unsigned long long end = subreq->start + len, i_size, remote;
+		bool set = false;
+
+		spin_lock(&inode->i_lock);
+
+		/* We can read the sizes directly as we hold i_lock. */
+		i_size = inode->i_size;
+		remote = ictx->remote_i_size;
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
+		if (set) {
+			i_size_write(inode, i_size);
+			ictx->remote_i_size = remote;
+		}
+		spin_unlock(&inode->i_lock);
+
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+	}
 	netfs_write_subrequest_terminated(subreq, len ?: err);
 }
 
-- 
2.53.0

