Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDF519905
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650904; cv=none; b=DZTWp+JW+zFFpu7y+2muOmXMbHHIaL8qDUaw1pQXhnvJaWb/+1OJ5280/rpwj8rlzTAbwr2uvEf3x8pJLxKHLhw6kL6VjD9Qfh55ynVO6xRQJRV6lNE8U03Hb7QcIJ+2RGKqNAlnEBQMEhi5BiBGdC4W/S6fbtu/5Lk1iHDoJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650904; c=relaxed/simple;
	bh=UxvcLCAqS7ZctoqUJFdiuuRitSjLJbNEUyZEUcp+ioc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQFCek8OXdwCnF35M9dPZielWoeC8GNruwuvpCn8lNTazJ3/ETzbK819WJgogOPWwhfwzwGgfhqoEQjnPwpJCvzBTj9Cik/btma4q4QJB+AOyd09OW3bG9xl5/uQzaEo5JvZlp+YGQ51C1Vd6BTq+uwB26IeF2e4czZ1VfFt188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3dVjl2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3dVjl2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2210F1F00898;
	Thu, 17 Sep 2026 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650899;
	bh=yzYZNyvW03Ktt4bu5fZ5WdfLOSJqNcjR+/kQTSXkMRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3dVjl2/AD+QQqzHaqbf/LbETVup/Fei63LZKnnAHcSYl1VMG0pXtEJekoloYKepR
	 2/qD5m2vAaVFxeqUEcNMw3iY62YpgfK/xQ+HXKsDGCEfXOsmq/62UP86QC17E6N7V2
	 VZ6GdKAXN/anI+KBAGeEfkRCGZB/3yhogy0Jl2zoPERLkh0xF+sCF3GPEX+ckLXPzZ
	 1Ua58A2eUJPt94p9acj3+sLTSPtnijQ7DdFe0Am6WHN/9O+9NHNUaxzRjyw9lZtXwD
	 6uE+UkpOtDixQ+quUEVy3fqNs/85LkZLwjDTdLX6G6LMcs1OnjiC92Gpt4/Y9RPEU1
	 axnIGp8/eR1Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: avoid leaking refcount when cifs_sb_tlink() fails
Date: Thu, 17 Sep 2026 09:14:57 -0400
Message-ID: <20260917131457.350073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091628-uniquely-reborn-a640@gregkh>
References: <2026091628-uniquely-reborn-a640@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjoern Doebel <doebel@amazon.de>

[ Upstream commit 23b26f4408ac3f35a482d2e5cf6fc865d4201b71 ]

cifs_oplock_break() takes over the reference that
cifs_queue_oplock_break() acquired when it queued the work, and drops it
with _cifsFileInfo_put() once the break has been processed.

Only in setups with "-o multiuser", cifs_sb_tlink() may fail, at which
point cifs_oplock_break() returns without putting the file reference,
mirroring the reference leak we already fixed in the companion patch to
cifs_queue_oplock_break().

This would trigger a crash due to busy inodes on the next unmount:

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]
  VFS: Busy inodes after unmount of cifs (cifs)

Drop the reference on that path as well. Doing so before the out label
mirrors the normal path, which also puts the reference before
cifs_done_oplock_break().

Found by Sashiko code review. The failure path was not exercised at
runtime.

Fixes: e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Changed the target path from fs/smb/client/file.c to fs/cifs/file.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71f585a41d456..aa740478fe78c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4886,8 +4886,11 @@ void cifs_oplock_break(struct work_struct *work)
 			TASK_UNINTERRUPTIBLE);
 
 	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink))
+	if (IS_ERR(tlink)) {
+		/* drop the reference taken when the break was queued */
+		_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 		goto out;
+	}
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-- 
2.53.0

