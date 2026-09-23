Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DE37E5D1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170327; cv=none; b=DJ55o7t1vNnUA0SlVhcqY0HD/j5t91iwJpoRQTGOmRmOpQ/R8trhL0jdwbl8JLRnSpMWV71U8XxU1u/ZDxoPJ73TDJzLlGyVP2zCBwR/Q/giwjWoiB1rWkBjaFhxlsgMWHtQrO448sS5aecelVLw/RFU81dTPrOtsn74TMxf8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170327; c=relaxed/simple;
	bh=kauMvqjli821tBTXKHXpDC4cXBHKkOp8rOt77FC1+Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi9snAONC5RVx7xrVgK08wlfcEOKWFnUJTOqkRgJcUcUSQI0XKkakiiOA2BneKU+M4/LsjIoRmsCmbZv7tPa/hSbuYqlGN8RdxZ62i9+9lGzlL1MIb5ycQiT8Mjx/gc4fiooOUorxOSRPu+OQb+F0JS990eWjAwcY/aU2FLhO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YonJuTmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YonJuTmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E441F00893;
	Wed, 23 Sep 2026 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170325;
	bh=MIr3pjHzJmvsdpuX2G31uV7b8SJP4UdFVhcSKTv/CuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YonJuTmnWA7IyvaJA07DD8tljpErdTBkTMwqIdkakptr+i02LQGym1LPf5zCssOVS
	 dfGb73YaUHVG6qoiLgCwJ1muEUsxJjmvPCC0pZ5ziv4qZB2Ly/UTKG0rFtweB8s/hT
	 Y4lNZe+0P/uK3Be3tcmPcm30kl6PoFg+80bmq/wU04Y7XF6q48rDfolLZpOrusAlxH
	 t5ZLrTaDtyAWwjZ8d8vMb7ZXM6Ox3jJpP4bDgOsuAr90TKVHZglQNfngqZhgAAtBfg
	 S8UKl6B9EogNZIzHAm7ZD54V+/WfY0Jmj3epkQttPUEiRQb+H0oYl+ukT0yMTWSSEu
	 NqJaGS9RkOHsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: April Cardenas <april.cardenas@canonical.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] smb/client: send lease break ACKs thru correct session for multiuser mounts
Date: Wed, 23 Sep 2026 09:32:02 -0400
Message-ID: <20260923133202.2174959-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923133202.2174959-1-sashal@kernel.org>
References: <2026092353-natural-vicinity-cd4b@gregkh>
 <20260923133202.2174959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: April Cardenas <april.cardenas@canonical.com>

[ Upstream commit ebc5660132ddd244b57f03ed324922013a3d7363 ]

Currently, when cifs_oplock_break handles a break request from the server
it searches for the appropriate tlink to handle the request
but incorrectly uses the current fsuid as the search key, eventually
causing read errors for users with multiuser mounts on NetApp.
Fix this by using the tlink from the cfile struct instead to respond
through the correct session.

As breaks are handled in a worker thread, the current fsuid
isn't guaranteed to match the session that the break is intended for.
This means that cifs_sb_tlink may search the rbtree using the wrong fsuid,
and return a tlink with an incorrect session than
the lease break was intended for. As a result, the breaks
may be ACKed through an incorrect session.

While it seems that Samba/Windows Servers 2016-2025 ignore this as long as
the lease key is correct, we ran into a case where if you're using
NetApp ONTAP or Azure NetApp Files they will reject the ACK
and return `STATUS_LOCK_NOT_GRANTED` errors on any future read requests
a user may initiate through their still held open file handle,
and the server will eventually close the file.

In the dmesg logs, the user may see errors like these:

CIFS: Status code returned 0xc0000128 STATUS_FILE_CLOSED
CIFS: VFS: Send error in read = -9

With a multiuser mount using NetApp, this issue is really easy
for users to hit on a wide variety of kernel versions
by attempting to copy a file from the share
to the local machine through GNOME Files/Nautilus.
This copy will always result in Nautilus throwing
a `Bad File Descriptor` error to the user and fail.
With this fix, you can copy files through Nautilus without issue.

>From looking at the traces, it seems that glib will
open the file first, and call listxattr before actually attempting
to copy the file data. The listxattr call always triggers a break,
causing the copy to fail.

The proposed fix returns to the way the client grabbed the tlink before
commit e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break").

The bulk of that commit (checking for list empty) remains untouched, and
I think the change to using cifs_sb_tlink was intended to avoid a
NULL/ERR deference on the tlink as well as update the reference count.

I believe this fix should preserve those safety properties, but of course
I'd appreciate any corrections here.

Fixes: e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break")
Cc: stable@vger.kernel.org
Signed-off-by: April Cardenas <april.cardenas@canonical.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Bharath S M <bharathsm@microsoft.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Removed unused cifs_sb and sb declarations because this branch lacks their remaining upstream use. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 466d25c90a10f..11549ab43f9ce 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -5173,8 +5173,6 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct super_block *sb = inode->i_sb;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -5187,8 +5185,8 @@ void cifs_oplock_break(struct work_struct *work)
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
-	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink)) {
+	tlink = cifs_get_tlink(cfile->tlink);
+	if (IS_ERR_OR_NULL(tlink)) {
 		/* drop the reference taken when the break was queued */
 		_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 		goto out;
-- 
2.53.0

