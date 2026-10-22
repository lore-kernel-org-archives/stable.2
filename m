Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706616;
	b=LWgwlmZPrpIWsL183mJft+2wyBUNzxtUycbTl8S8xQCqdDMq1da12DYe50Sm4hIhj6kQ
	 gRH1YHoqwYrYmPCiDHr5EZnmg7uDLbWjxQ8D1N8du79UyY+O8RNx/An2XSr0caidmbddo
	 MnERZk0BHkEjmP+WNhclUVSvl7p3gGJsHwLoUdEn4e4w5i8XF75QdcXuotuYf5NADb9q5
	 cRZrHIEhS8xHTWOiqIEA6esbQU1jIFnkjZvcormkMd/yCEPQjG13ja6Wy1wArsB4Jps+d
	 SSahYNqduYdX/mePMD2E6xpxUkRQ3DxpRpsusCPg3/u/s46sr4Jz9aGQgyrHLX8CWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qOqpsJc7AAWTBffBDxFBpmpv1CgMyzBVCT2a8Vh1xBw=;
	b=FYu70Px8G8duKyoydgNdZWCM+cbhLwR9Ql+hwDwK3psp9G+SW0qgpGorm0bIh7goPKjx
	 a/u4gxnmZHG6ozJw+wMPGRdGj0uQYdOxurqebWZ7RItGMS/IIqW2lIJk8I/IO7hwIZyAY
	 /gCT9R8iPS+tYwCGNj09P8N4rIH61Ykgj9jKsoouvvv7vXEnzVV1TbaGnesURZQ4jP/Mn
	 oPAeckcXBxRG2YzJhgzciTsytJeuJz6Vgd7U76j/KyaCCch8xDaPnwu3ovEEpCaHL4Q5d
	 KKxdBFwqUUXAboF+wwhRFoMovSXRsP+S32O8fWk/+6e03RAGu5VK1VXwBkhBseoQXHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SAJBK/hO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7743606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAJBK/hO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1841F01825;
	Thu, 22 Oct 2026 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706615;
	bh=qOqpsJc7AAWTBffBDxFBpmpv1CgMyzBVCT2a8Vh1xBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SAJBK/hO99fbCW2xhOKxDbd5+qQX1zmfsQisdtJKgksSShbuciIZKOndxP6HrH+mq
	 FYO2sxiHTj+ONxwwvLt6dD20vw+uZAB8Kt9i++4LmPR0MY2+0Vj8JX6orjI4EBDigi
	 4MlmHikrJxJALQ/pNvoh54T/jMluxul1vrTNXVlqLjtJ16URxgkRiOC4RoUrk5QgVt
	 6AsyXT8p/wX5wu9DEexqVp/Kv2Nnz37gNd+EOViqPhcFDZUZmrHU58knbJiGXpkjpU
	 Ev7HMqJpPUKyPw/sJcmrJDIzSH3Q1wgDiFU1PMah2DxhbYx+pKSlQrkfvuhfeRVb1v
	 xlOc1y61SOeOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: fix data corruption with concurrent writes and O_TRUNC
Date: Thu, 22 Oct 2026 18:03:33 -0400
Message-ID: <20261022220226.1992474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102256-failing-clinking-a4c8@gregkh>
References: <2026102256-failing-clinking-a4c8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit a8603b52b39f520ea8a34def74c23fba87396d3e ]

cifs_do_truncate() flushes dirty pages with filemap_write_and_wait()
and truncates the file on the server, but in the old code both
operations ran without holding i_rwsem or invalidate_lock.  A
concurrent buffered write via netfs_perform_write() -- which only
needs i_rwsem shared -- could dirty new pages after the flush but
before the local truncation, and those pages would be silently
discarded by cifs_setsize() -> truncate_pagecache().

Fix by acquiring inode_lock (exclusive i_rwsem) and
filemap_invalidate_lock at the top of cifs_do_truncate(), so the
entire flush-truncate-resize sequence is atomic with respect to:

  - buffered writes (blocked by exclusive i_rwsem, since
    netfs_start_io_write takes i_rwsem shared),
  - read page faults (blocked by exclusive invalidate_lock, since
    filemap_fault takes it shared),
  - writeback collection (blocked by netfs_wb_begin/netfs_wb_end
    around the server truncate and local resize, since
    netfs_writepages also acquires the wb lock).

Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ sashal: Replaced netfs_wb_begin()/netfs_wb_end() with direct wb_lock mutex operations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 53e457759d84c..e4281d0d12dd7 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -990,42 +990,50 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 	struct cifs_tcon *tcon;
 	int rc;
 
-	rc = filemap_write_and_wait(inode->i_mapping);
-	if (is_interrupt_error(rc))
+	rc = inode_lock_killable(inode);
+	if (rc)
 		return -ERESTARTSYS;
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	rc = filemap_write_and_wait(inode->i_mapping);
+	if (is_interrupt_error(rc)) {
+		rc = -ERESTARTSYS;
+		goto out;
+	}
 	mapping_set_error(inode->i_mapping, rc);
 
 	cfile = find_writable_file(cinode, FIND_WR_FSUID_ONLY);
 	rc = cifs_file_flush(xid, inode, cfile);
 	if (!rc) {
 		if (cfile) {
+			struct netfs_inode *ictx = netfs_inode(inode);
+
 			tcon = tlink_tcon(cfile->tlink);
 			server = tcon->ses->server;
+			mutex_lock(&ictx->wb_lock);
 			rc = server->ops->set_file_size(xid, tcon,
 							cfile, 0, false);
 			if (!rc) {
-				inode_lock(inode);
-				filemap_invalidate_lock(inode->i_mapping);
 				netfs_resize_file(&cinode->netfs, 0, true);
 				cifs_setsize(inode, 0);
-				filemap_invalidate_unlock(inode->i_mapping);
-				inode_unlock(inode);
 				cifs_invalidate_cache(inode, 0);
 			}
+			mutex_unlock(&ictx->wb_lock);
 		} else {
 			/*
 			 * No cached handle; evict stale pages so they can't
 			 * be served after the file is later extended; let
 			 * the server's O_TRUNC open response set the i_size
 			 */
-			inode_lock(inode);
-			filemap_invalidate_lock(inode->i_mapping);
 			truncate_inode_pages(inode->i_mapping, 0);
-			filemap_invalidate_unlock(inode->i_mapping);
-			inode_unlock(inode);
 			cifs_invalidate_cache(inode, 0);
 		}
 	}
+
+out:
+	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	if (cfile)
 		cifsFileInfo_put(cfile);
 	return rc;
-- 
2.53.0

