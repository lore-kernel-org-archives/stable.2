Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2033246F4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170325; cv=none; b=GuzW2mCbQ+jTATuFLFZgE59WnMhIFWOkc8sSEPdnByG2dLjoVqYHH8b4gACRt1cZOIdp0p7bZ22MjrMwvextePpmDVyCkyd3HXwXA7x4DYTPm2cdcE64GA7qkQ2nW2Fkwu8xh7zDqko8Kqz48HLmk/IAohRG8r4q9RY072dj4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170325; c=relaxed/simple;
	bh=xd6n0pGLtJesIvdVgFnidKGn4U3TbtCuAKYiHaTz5og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfGM+89sPIDtuAFsE64r+FjqoXxC4S5gTB42km3tZus4TePefBjJVO/wWqRG6+40+vDX3V9Qh3TLS6J0cbVIpQ1hE61IjuudbXzzTL9eBEOYSzDRjtxhaW2Rwkj91F7moID+J4kWPOfpsc3wcHn4dC6mk+ZpGVIW0VFmS+4rfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o13yhusK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o13yhusK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990B1F000FF;
	Wed, 23 Sep 2026 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170324;
	bh=WZTpnuQp3dqXStb9qLjhBk9J1475c3MkoSBc0VNyutk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o13yhusK7N1OU4IaU5SgzLjXMmLhz5hInf7vHpTi2Tb6mJvMg4ASOdF2twXWWgldc
	 Qi5zWzmH0uUWMEapmj/2cOl61CHx3kE8taFtZU2YSaGUgzs8NzzwEOjMzULMVxicyz
	 yM1nGgWtoPW2n3jRprXEo4jVL3ylK9k+XKrUi9XhvmySrLD/Q++MunhnpOL92EjxGC
	 SF4slnhj1vEF5aS0pujtZisKTFq7FqgGoM84a7LcIigQ7qlnwwR4W8OOCewNXijDup
	 1xdnU02jOthMTy89zpgCikTI7pm3dd9yyG6eZx7a9tyGtcDETbFx1Umn9CdWYjIiEF
	 ZhnF4YcA2ZWiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] smb: client: avoid leaking refcount when cifs_sb_tlink() fails
Date: Wed, 23 Sep 2026 09:32:01 -0400
Message-ID: <20260923133202.2174959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092353-natural-vicinity-cd4b@gregkh>
References: <2026092353-natural-vicinity-cd4b@gregkh>
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
Stable-dep-of: ebc5660132dd ("smb/client: send lease break ACKs thru correct session for multiuser mounts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index caa55b5bc110c..466d25c90a10f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -5188,8 +5188,11 @@ void cifs_oplock_break(struct work_struct *work)
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

