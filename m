Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85442522F09
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169921; cv=none; b=GFLxWK45blORCJxa+lLKlFMUiG7/gkYZQyffxYHh1q4gixIYV9rM9vk8RTpb6FTf605TXcvAIKwiwXis8Fmz6ZIp/TN3s0HSka18IRwVGiHhkOtvB6R7xvmNkzT5fXHPyFE/MqSkCJEnXFlUT9wtHv8hciuxHwEQiTuIm6AaiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169921; c=relaxed/simple;
	bh=jjtkjBkmZOxmZ+2ubZ0aCSc96nLWLdGoRJdFCb+87A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htnKhJ2CUaEbcS/fPqLZvkgbFacmQLUWd7Hm56h9UxLkvHOl7fUzrq/c5x9R2Zc4hxlixswiy/VOzid3FGcvwYw1JdaPpmEe9ywnH9yfENGTFZPA/nBnnE6NHdZhKvIBYYQPJ5i0aAgjKnAZ41O1XX/9MFqsMcwjx4lG/0GL6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaOZAh6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaOZAh6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D881F00899;
	Wed, 23 Sep 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169920;
	bh=zYqD7K988qnfVUuGfCDVxCi/5zPCl9sFhM21LEdfXLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kaOZAh6LMIU9MUwAE17c84tAX90v9hVOXBfZtwyq0d+TUCEB7kV+hztMfeYbot8/N
	 pU/Q0ttW4U+Akd3BAFSkwYcRnGxMas6eMUTZrs8RFye7/amqx5QKVH9pYKR88pgjuR
	 TGe00VBArFQam3mgC+e2KCySJq5B6bCb4zFnip9FAAGU+nVY8MvQbC1DHO+MvvfTDv
	 sn24m7u3hzEwRuYMMh9BmNC6Nw5FDLzCy2n2UpZ8TJQUR4vTKbxP5PsIuELvnSz8pB
	 nWI51jwQPioaYNk6rhSx762bZbZZbMOyRrkCzAwHQa+Fzb6iaAJnMnZ/Pu1STmS1X8
	 kR9aDhGpU97pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: April Cardenas <april.cardenas@canonical.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] smb/client: send lease break ACKs thru correct session for multiuser mounts
Date: Wed, 23 Sep 2026 09:25:16 -0400
Message-ID: <20260923132516.1891163-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923132516.1891163-1-sashal@kernel.org>
References: <2026092353-snowstorm-carnage-f809@gregkh>
 <20260923132516.1891163-1-sashal@kernel.org>
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
index a6be7903a67cb..ad2b335d81f31 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -5139,8 +5139,6 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct super_block *sb = inode->i_sb;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -5153,8 +5151,8 @@ void cifs_oplock_break(struct work_struct *work)
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

