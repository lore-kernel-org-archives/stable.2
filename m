Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A27501F4B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650943; cv=none; b=FacpBllTqmMj16VLtnN23Vj7gWLwLphSaxwX5B+KT95HYVD/OHg1LNEx8q459I/vxUWZchx2h3g6Fd9v8LdKzxyBDyOi98ckEKvkSWHndd7G4t7Zm8n9rCWvlL6jjpCD3nK33rfGIp6AkX+ZqdnLfpM3IYmUHPX1O8YIluuBIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650943; c=relaxed/simple;
	bh=KihSoGVQxIPtpSFHiqgUvrt2SqZKDDHIsWMLPqT7sc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+1ub1UMi5NSvpJLtXRqmL/joMVEZzazrhqrrO+0MirIMOlOLpdhM1EFj4dNziwerAZ4bPG0Wkum1yaA8tZOJvf+ymj17Ey1AJ1eHY3aRY1JIOGqbXwW0lwpzGQAdTMZ+gPRYCyDNHTnXiiMP7UXl9TQaYGs3if7FXqfyahG9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIa9vvia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIa9vvia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EB11F000FF;
	Thu, 17 Sep 2026 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650937;
	bh=83CcTzApoHkjHNbNCiNGDKQOOapltvUHMqBDsyRJV7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIa9vviaHV/esPB8cSMtx8kGIPkGpn+dp+OYYErmPDwszTBXUaxPy/8PG7qZZ5V7C
	 kZz4LbrZ+R3JIN4aib+CJ9FQ6X+q/LgDtDdAeD8buoa5jorvI7up0DsGGwF1rRfB09
	 57CeJ7rOh0MSO/p9jA4H8IdHT0CYx9eYLwFCbZJC2ILN70YEfYNtXx7g6gHQgr9RX8
	 nKT1jFF7oycyGzUSlScxmnF8tIp+yF3wqHJh00ComcbGLegGbsmtbKEPc5ugL96Hnz
	 jwrH6SB+//tRJvqbSA53PBGhAlF3+eRfOIVq4yTwNnq8XQGWCMNNXxMEU5PTeqi3ha
	 BlwaIy8FWbGSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: avoid leaking refcount in cifs_queue_oplock_break()
Date: Thu, 17 Sep 2026 09:15:35 -0400
Message-ID: <20260917131535.353048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-voicing-bauble-48b0@gregkh>
References: <2026091616-voicing-bauble-48b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjoern Doebel <doebel@amazon.de>

[ Upstream commit 9f2e63f1b2d5fc5b5423424902c091123e220e7e ]

cifs_queue_oplock_break() unconditionally takes a reference on the
target file before queueing cifs_oplock_break(). Only that work item
decreases the reference counter again.

If another oplock break arrives while that work is still queued,
queue_work() will return false and not queue this second work item. As a
result, we will never reach the point to drop the file reference again
and are leaking this reference. This can be triggered when interacting
with a slow-responding server.

As a result, later unmount operations for this file system will fail with

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]
  VFS: Busy inodes after unmount of cifs (cifs)
  kernel BUG at fs/super.c:777!

Fix this by only incrementing the reference count if the work has been
queued successfully. Taking it after queue_work() is safe because all
three callers hold tcon->open_file_lock across the call and
_cifsFileInfo_put() decrements under that same lock, so a worker that
starts the handler in the window cannot drop the reference before it has
been taken.

Fixes: b98749cac4a69 ("CIFS: keep FileInfo handle live during oplock break")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adjusted the patch path from fs/smb/client/misc.c to fs/cifs/misc.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index b4199b4085db3..e9be60ca34454 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -628,10 +628,11 @@ void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
 	 * open_file_lock to enforce the validity of it for the oplock
 	 * break handler. The matching put is done at the end of the
 	 * handler.
+	 *
+	 * Only take a reference if the work is actually queued.
 	 */
-	cifsFileInfo_get(cfile);
-
-	queue_work(cifsoplockd_wq, &cfile->oplock_break);
+	if (queue_work(cifsoplockd_wq, &cfile->oplock_break))
+		cifsFileInfo_get(cfile);
 }
 
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)
-- 
2.53.0

