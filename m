Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B735E1D9
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127610; cv=none; b=tQN5dGRDhspVQ//VLUfP/0/s21I759HAH4WDsUHDaVJyZLsU7cMR5oWNn/i4UtjvYUpI6CfFL5YEI4lnVkN3p3Pt3OBQY3KFbm3Bw7SGZIDTzAyodAhvFWekHnpmM4TGsbWsG+MqFrSDA6uZWd2m730FqMTjmOYsPsMIfFQOINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127610; c=relaxed/simple;
	bh=x2nJNYqghFx/lgHm7PKzd2EJvHdLzosS4ehNxP/Xq/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5ddyXT9bcpGUwV2tBjGQPb2ii96xUmCrtHLOM4PFzLI+DwznxjfIb68LQ8gmagI+YHRLnKNu8PL6HvXeiLOKK18J5KyPTOVXATdJD6DUBbrz3Lt+aCeqFO30jfukwxuY1Chx+lvPhzAtshhqcwtskgObo4+mKeTWgB/gZDE3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCNZKEM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCNZKEM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7CA1F000FF;
	Wed, 23 Sep 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127609;
	bh=wYXM93dR02cyC+r1eLKH04Xfw37dfItAi9QNZ6Sn2O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCNZKEM7UoUeB2Jo5fiOCgABWPScc/KGNEWk9kTvJwuaVs78di626ppZOmGEK7iNb
	 c80eXZHVRFcFb3Fo23w7DggWPcxY1LS5AOOsghoxDQ7q83L7uyfBNeeEVMg3TtY6TR
	 43fVxwZPIiR7KW4WjNs40BaBhPVBbEtTeX1oYwpgR4Zrcz+HL/t1ioyq1i2m46H6zT
	 ouVGfOhKDwyDmp8zXx4Ku8tkFeFJF6nrlUprqXpPgElUaNmLjoUp9fQ5FSZuyfSxHn
	 JvWeEMaCyCC+6yzjN4kXhKXZBdNnI6+a46l/HrocYs1qk2maDOqu7Z+DO8uJF9ZC77
	 5JGyyDeRxS7WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: April Cardenas <april.cardenas@canonical.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb/client: send lease break ACKs thru correct session for multiuser mounts
Date: Tue, 22 Sep 2026 21:40:07 -0400
Message-ID: <20260923014007.879489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092219-pretended-swung-72e7@gregkh>
References: <2026092219-pretended-swung-72e7@gregkh>
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
[ retargeted the patch from fs/smb/client/file.c to the older fs/cifs/file.c path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71f585a41d456..be87e12aa6bcb 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4866,7 +4866,6 @@ void cifs_oplock_break(struct work_struct *work)
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
 	struct super_block *sb = inode->i_sb;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -4885,8 +4884,8 @@ void cifs_oplock_break(struct work_struct *work)
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
-	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink))
+	tlink = cifs_get_tlink(cfile->tlink);
+	if (IS_ERR_OR_NULL(tlink))
 		goto out;
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
-- 
2.53.0

