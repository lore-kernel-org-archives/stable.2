Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2C503BC9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649368; cv=none; b=AWpQILMtpmbO+j+aZE8bYpaHTEpCT3lDmXRnBslkuppwoDumo+CkNwbIcQzQq7rXACTE4k8AFjNGO3us2gRTfOXHMzuEQ9kvNNaNuRwCBNDetStXefjtU95k5o+4+hN46ENvWRFN6tXj4PoCAslRnJy5jG+eDyxxBG/nFgeYTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649368; c=relaxed/simple;
	bh=SKg7/aXgozYml70udtfh6vbqvqY49x0i/PdwmMPO5Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqULna+v9W0SRIU9JxaIWsw9bw6Rdb1g+yEPLbNFgRhLBW7UTwi/7tQJUsaDEmIh6kPLJLKqukS369bPg/YHiU2zTxnX7VfCyYsI4xwSjLxtTkD01IXRZIXG2t9oWdpFtjJAttIqAobF9pyXZ+gd7SZn0P+o2nYtLMr/ap/SEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL7NuwUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL7NuwUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87D1F0089C;
	Thu, 17 Sep 2026 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649350;
	bh=yxhoOsHRe/F+S5sIBNY2/wJr6AFoArSQernrjD474SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bL7NuwUDocTZZJbfS/u3LdZitVb+2xgUdiemFNWiWM48IFXXq+AuuNGVqS4c/72K5
	 VxthvmcaeJRHjsRF2hjrLTPR8c3YkunRfXWRf6XU43AU+ZjooQ+ob0TAe6p4Q00ftl
	 t6kbz90bQkwmUKtHfLDF+WxXJZuSkyoUDyqhBzQKOF5Tjt49VupPuz5S+TKomEWVpt
	 +kTBSuSX6pb3F+IE6bt8dJrRJOZxpLQ/VG/srJEQmV7rjoVRF95bGMRozcjGcAum/e
	 0A8VFHdKTMw1jA5hwYJvuXFCYdSz88NAF9+R8J8/RdVupVonAnxHdiRVBUKx+XUVAs
	 l0TnSsincMCqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Arthur Lesuisse <arthur.lesuisse@ulb.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 08:49:06 -0400
Message-ID: <20260917124906.224368-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917124906.224368-1-sashal@kernel.org>
References: <2026091634-strongman-causation-bca7@gregkh>
 <20260917124906.224368-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit cf4d35896621b7298eef51b7a465e5c0cb22f670 ]

When mounting with 'multiuser,posix' options, cifs_getattr() overrides
the server-provided uid/gid with the current process's fsuid/fsgid.
This is because the condition only checks for unix extensions
(tcon->unix_ext) but not posix extensions (tcon->posix_extensions).

With SMB3 POSIX extensions, the server provides real uid/gid values
just like with unix extensions, so they should be preserved rather
than replaced with the caller's credentials.

Add a tcon->posix_extensions check to the condition so that uid/gid
from the server are properly reported in stat results.

Reported-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
Closes: https://lore.kernel.org/r/DB9P190MB2012266F6B8DECBE5D26A1798DB52@DB9P190MB2012.EURP190.PROD.OUTLOOK.COM
Suggested-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 752982e3a0ece..c859885164648 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2883,14 +2883,14 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_ENCRYPTED;
 
 	/*
-	 * If on a multiuser mount without unix extensions or cifsacl being
-	 * enabled, and the admin hasn't overridden them, set the ownership
-	 * to the fsuid/fsgid of the current process.
+	 * If on a multiuser mount without unix extensions, posix extensions
+	 * or cifsacl being enabled, and the admin hasn't overridden them,
+	 * set the ownership to the fsuid/fsgid of the current process.
 	 */
 	sbflags = cifs_sb_flags(cifs_sb);
 	if ((sbflags & CIFS_MOUNT_MULTIUSER) &&
 	    !(sbflags & CIFS_MOUNT_CIFS_ACL) &&
-	    !tcon->unix_ext) {
+	    !tcon->unix_ext && !tcon->posix_extensions) {
 		if (!(sbflags & CIFS_MOUNT_OVERR_UID))
 			stat->uid = current_fsuid();
 		if (!(sbflags & CIFS_MOUNT_OVERR_GID))
-- 
2.53.0

