Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607E3537FE
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169920; cv=none; b=V8gwaYMnbo/hraAFsVg5/EFaYdZNT402AADL2/7pRL9+gZxKuxqxsoXEDyfzaM801jE3ZkAqRRJ4LYiE5mOjPgREEtAsX6WKsh2L6tNKUDGlHt45YJHHL6SZokxMoDZOdy4DziIbavsc2fGs0IQThnaO99ZC9r6y5sRLxY7qw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169920; c=relaxed/simple;
	bh=V823P2M8RpBA1LBlFE7TdmDYm3PSnAVuwY8gc0bnvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3uI4xI+uyy17uCq2UjuN1+3JHV8pHXhF48sYKmkHhJvPoamgp17M+VJf1zDRNMzwcUE8KBbLWCGEiwIqRIDsN7u+cmPFBvhwQBoS/N89BNqFmHlGtrXOjYl7w4X2DFSlJK0dkibU80jVAsKkxYl57F4ssCYWIXdlL7Hle4Qo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNV2zgQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNV2zgQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DACF1F000FF;
	Wed, 23 Sep 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169919;
	bh=SwEmRd7IvoOmcwEsP4Neodn0zXGQhiCmwLMJ4nD1Oys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNV2zgQMmXj9bZDbMnCdXoANGSR1biFo6/L/RJZBSUp6Nv6A4/SwXWYkG2dl1xswd
	 22fO7DNd8nTLACEgaw9AZqJujS3/ZnWogpamYfhRT6EYL3ozE21g+ar64iZS+x25Tq
	 dUmsl8SNmNouHq96kUdwwA9fA1t08xpCtPvr3J4XR1XMoTHfEIAVw/0Mmz2gzgSkbQ
	 zUGcTxYjdlX22HonQXv79eALvhjcXX+ePc/kc4bP0udUua7a49rvz4xv4w3/AHAqbL
	 j2pKuwQsnYmEs/pATMfrrrKos2iOeBszgEkbkpEYFoIW3QS1mQxvRaW5THJI9tlu/J
	 KKp8UYTSHZ41g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] smb: client: avoid leaking refcount when cifs_sb_tlink() fails
Date: Wed, 23 Sep 2026 09:25:15 -0400
Message-ID: <20260923132516.1891163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092353-snowstorm-carnage-f809@gregkh>
References: <2026092353-snowstorm-carnage-f809@gregkh>
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
index 94c8b173a8d63..a6be7903a67cb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -5154,8 +5154,11 @@ void cifs_oplock_break(struct work_struct *work)
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

