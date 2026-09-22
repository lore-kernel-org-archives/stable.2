Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EC541E75
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079553; cv=none; b=BoqCxKt8M9P7QzNeZDLfSMu94lTuizpxwtRd05pVbvHHrFvJNCZzvMM2xMhfUfRMikErOvQgg/Vu4RJkWsLpDDRTihp/AEG0KBdJaIUs2oT/m9zQ4R8NMrADUv2w8UPpYUNAx73p6EAq50T/OZK4ZnKajiccAxu/1FPdCqsBQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079553; c=relaxed/simple;
	bh=hy5cywyBrX35BSrBugIuTatJyEVhOuALUCSqgqRuOA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+IwhwRkpbr6SJnp8A5iysNd1JiZTxp/ymDkbvh2MgyLU+ou2RQbtBUPqFfwU/5iwn6i6vuzY6lEoEapxiKc6qQjV6h14a71DJdhlXJ4zZJKmwZ7CyZiBwjIJi+EF2ic21f63kYq5Moerkc461hG9tgMZ1t5fd0cBshf8Vtl/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE1m5Vg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE1m5Vg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FAC1F000FF;
	Tue, 22 Sep 2026 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079552;
	bh=x7gbyzhyHekExF/wXMz8tyTFNXf7bkVWg490tH0i7Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lE1m5Vg4IZXOW/rr5go+hB7PdM8Ae1/iZ9ZIxQr+xBIkgGvxyJXiq11gTAHipYL8z
	 UCwr/8WQsdk4OzOgdb3EgnNT1i0qo068x/klji/h+lMAU7hIzBu5+7sIlbouS1CM13
	 GKJzLvH7KqNEhMzaXZuNsgfRxeAlCFqTSUdKCbB/H/SJCJBdHPieU8mWH8A1AL45mX
	 y/fAQGXg3fRY2LSvQMKhBtna/zd5njS8rXtfyWnLLzBdxMjOl0aWvwmTD/gIUtZSYd
	 GZuOiPzmXknfzsC2OtWZT978H/gsTCIHp+hJv3AkbnGg+uw0gPYja4Uo+/7868WxNG
	 1MF2g5nqkA29Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Michael Mulqueen <mike@method-b.uk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] 9p: Fix v9fs_issue_write() to update i_size and remote_i_size
Date: Tue, 22 Sep 2026 08:19:07 -0400
Message-ID: <20260922121907.2213071-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922121907.2213071-1-sashal@kernel.org>
References: <2026092222-rubbing-overplay-5a22@gregkh>
 <20260922121907.2213071-1-sashal@kernel.org>
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
[ replaced unavailable netfs_write_sizes() with i_size_write() and direct remote_i_size updates under inode->i_lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_addr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index d6107ac50e882..5bf1e5caaa623 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -54,9 +54,21 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	struct inode *inode = subreq->rreq->inode;
+	struct netfs_inode *ictx = netfs_inode(inode);
 	int err, len;
 
 	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	if (len > 0) {
+		unsigned long long end = subreq->start + len;
+
+		spin_lock(&inode->i_lock);
+		if (end > i_size_read(inode))
+			i_size_write(inode, end);
+		if (end > ictx->remote_i_size)
+			ictx->remote_i_size = end;
+		spin_unlock(&inode->i_lock);
+	}
 	netfs_write_subrequest_terminated(subreq, len ?: err, false);
 }
 
-- 
2.53.0

