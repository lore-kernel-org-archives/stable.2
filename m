Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674812;
	b=bBi1fhg7I6m9fzA/u2CcBsJy/oQURqot4Lt+H0eCs8DbgLDLeIUDW9PXhdLod4hJMAn4
	 C+QnILWw69HDn0SWN+ko22xmO9JipIyKz/YvxoAX9UQZSgn5JZ9qsyU7xNAD+wmE3NEul
	 d4uQziWVxs49d+dk3XIwNDtIRgXoYQzVppwTgiblroBZ429Odp71nKxPlm8sCssnnmbgm
	 dTQsuiR11xgeypFBToF/FV57UlrD7QGRCJEhJB3IqF/KCi+2Xk1dwLJUomu9WF69A2o+G
	 MHjE2zNhhbrnr6Wvbi44igYyi8w8YTO25ZfjfT/6OOxxqaeRuZLpJRTBbhIabye2jvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674812;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KsKUuFKnFyYKCamxU/zrDdfJgIVxvZ69syHCvzV1WXI=;
	b=vXscru3iCGVv7iopy/LO3YZZRqwev3stamB5ODpkRxszh0BeJahbXGcINC5GvsM6m5Qm
	 q0CePpMmpW1o4hFw9UDjCPs4Ur02TM5kFzXtmhuZE/IpLgVa2Zhv+EtTc79adWgAHFcaS
	 psCjsob+v/mbNUorcrDRbVS4Ezv9x2XM+UH6qZHt4oEzxDzx/J5EuthE6ourSwRlH8LLh
	 ii9dj70u4z0cJ1OnDy+dlPp5eVpRJkZS98nQ+K78j40TpZHz30RjbMpnGFBTxhuIeorqF
	 hCRnqoE1TvszxHaiMRxNdkTpmdxFxAhCQ4WF/+1kXbd+yEwRaTFm1kLNQuDzyVGaTkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dNTtgCBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE187606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dNTtgCBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175171F000C1;
	Thu, 22 Oct 2026 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674811;
	bh=KsKUuFKnFyYKCamxU/zrDdfJgIVxvZ69syHCvzV1WXI=;
	h=Subject:To:Cc:From:Date;
	b=dNTtgCBvWicyGsST6yG/qxnCUO1ODYaeN/z92mZ+rOV5PW6BqR2Q764ld4bkZhkyD
	 6RiWIj0KzUMeoDwvuv/JgXt0t7tfj2A9mZJfA+Orw7ZtvaG96JSqkRwLiclR1a6XMP
	 8c/Txsil6Okg9H9seaT40pC8mFys9QyRIxjLzwIg=
Subject: FAILED: patch "[PATCH] smb: client: fix data corruption with concurrent writes and" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:10:56 +0200
Message-ID: <2026102256-failing-clinking-a4c8@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a8603b52b39f520ea8a34def74c23fba87396d3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102256-failing-clinking-a4c8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8603b52b39f520ea8a34def74c23fba87396d3e Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Fri, 28 Aug 2026 19:08:09 -0300
Subject: [PATCH] smb: client: fix data corruption with concurrent writes and
 O_TRUNC

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

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 100acc76e9be..61f9c6ccc6be 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -999,42 +999,50 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
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
 
 	cfile = find_writable_file(cinode, FIND_FSUID_ONLY);
 	rc = cifs_file_flush(xid, inode, cfile);
 	if (!rc) {
 		if (cfile) {
+			struct netfs_inode *ictx = netfs_inode(inode);
+
 			tcon = tlink_tcon(cfile->tlink);
 			server = tcon->ses->server;
+			netfs_wb_begin(ictx, false);
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
+			netfs_wb_end(ictx);
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

