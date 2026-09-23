Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5C4DD3B4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168692; cv=none; b=Ou9WoAgQOAbb6tcpx2e/WMguPs8+G4r2VIHWsF5q29FXerNhxMWliikiaQVBt8HaAzb2kFMpn6Cd/BITT0zG5UEmeEXsGJ2MUBLPtYPBC3iagf359L0D0gA0MEw+emwuMH0q3ip7uIABz9LTX/LPu+EHPOYTeUcsEXELzZEspxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168692; c=relaxed/simple;
	bh=vlMB+ZxLjKnvMWVwz9d1zc0Jkcx9iDI7/XVH+SdqVDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhPlu7Ldimbq4OAuPkhi0VWqdNT7+kxaeaRjHZS7lYJlwrFw7Xd8lpmWBO4+dMBLoIDdyxOpL2jY/w8AWuCdTMwhzE1hlbTF1tI5fGksBJsYQDMfAuVae3Q8y8qQVCS2/M1+oyb2rM5w1rrK8jb4Hk8v8nPHGefRoU+FZC6dhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDvx5XV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDvx5XV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF731F000FF;
	Wed, 23 Sep 2026 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790168690;
	bh=9yX7pSYcChvRvVXlNCWMsgBOwTdHbZvVdkFY38ohYcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDvx5XV36QFmRbH+znUP2/mVc8o15D7pf9rDrDVoPJJnFZ2FrAzRexjYrs79l01HH
	 QF+vu1Ez0B0gT5SSQRCGRgCTnKCxwDYGXIc9eqW9LMXRMkyxJenma1dS8kjHwbJoIb
	 DtpNXAuWUYmU/M6bBn2V11Ll2LrJvQ/Ptl1QDtS4gc45vgFYnPlS1Dyple/Mk6WdXU
	 rtGhxzv5k6s4xPy5WsF2/IfPglM1H75RzkMhvsrJIXhwIlbUZ9zmC7HSzP03Ds5IC1
	 cPGHagpA6QzMmRF9Zd9mdZIPBtvQOYUSEofHrOkZvL1w0I/8zeYgBmnAT11FtjncIf
	 DEo/v7cUVlDJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: April Cardenas <april.cardenas@canonical.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb/client: send lease break ACKs thru correct session for multiuser mounts
Date: Wed, 23 Sep 2026 09:04:48 -0400
Message-ID: <20260923130448.1728068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092352-cascade-punch-044a@gregkh>
References: <2026092352-cascade-punch-044a@gregkh>
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
[ Removed now-unused sb and cifs_sb declarations from cifs_oplock_break(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 339346a82ecff..997a84042c1f0 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3062,8 +3062,6 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct super_block *sb = inode->i_sb;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -3076,8 +3074,8 @@ void cifs_oplock_break(struct work_struct *work)
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

