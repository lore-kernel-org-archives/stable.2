Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657742FE042
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167657; cv=none; b=f3yh3/xYuICNo8XrvSnF+sq9Exn5Cpp0zJ5HaFOmd9/3B5vrM9tVK4WCVLG811gwG0jfZosN+mgHtyYWD+1z/6j4/w+3G5FjPff6aNnSCHyk0t5M5viSfpTc3dnJVSsL3wHojHH27Z2Hqm20G673X3L7xO6tru9cm4zyEjJd7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167657; c=relaxed/simple;
	bh=7IjVZ6q0mNrzuEmsLzkIeNwNUKXIM0c0whN994K+498=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MajYRif/A9vw57eSJKulw0s51hEDdPFJiJwbzMBHqljEsRdq+osOqyIhyCF/Ht0vIB94nR+MneZ5WRhq3M7ltTFGUmE4rfjHUqUn6F6zuZlaQpgOUFVHBxlsnieBrTTe7mbXhbZE3oYEpBv2vEGDo/mX0vTxh0DwNA6TnCY64Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUruSqf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUruSqf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602B71F000FF;
	Wed, 23 Sep 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167656;
	bh=LMFc1chpiAI4vdU9rJ8JQwju3z2tweGr/w7xVjj6nEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUruSqf0aRxnrPHncQ95cylh8CCiaDpDQuZc1oFGPj5Og7CSr03menFEHH6beAQsG
	 c5nA+NPhX+nXtEgDiYUlRxGZWcGLKoexOd2lkLl/yITNy2WLSHHZZzc3dv+o9fHFT9
	 ac+QBwRwJohpNDdeclNxviNCfguYrggnKzulmOJxkxj/xB/CmOgIOFLa4p9lpumZaA
	 dcwag7M6c14fZfxlvxtCMnoHA2vcRmAm2Br+fIYtPq6rN1WzwlFk5hsw3if2soV0c0
	 xqBCxhaG4YsgI26397cmoDSGcsq9UPpcBFoorIC13uacKTmY/6hdM385QENianG91P
	 WHlRNw+U/P8+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: April Cardenas <april.cardenas@canonical.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb/client: send lease break ACKs thru correct session for multiuser mounts
Date: Wed, 23 Sep 2026 08:47:33 -0400
Message-ID: <20260923124733.1367118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092351-tigress-refresh-28b4@gregkh>
References: <2026092351-tigress-refresh-28b4@gregkh>
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
index 235e365f60934..0110750d4fe6c 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3136,8 +3136,6 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct super_block *sb = inode->i_sb;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -3150,8 +3148,8 @@ void cifs_oplock_break(struct work_struct *work)
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

