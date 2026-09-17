Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECD3803CC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618826; cv=none; b=leMnMpb8jRtU6tr63sY/f3M6XUtkKgZf0ihL55JgV5UOC7u2Kka2Vk9cPfN44MO84aoaCEz16dZ25/7U6u9UFRupOzahDzWf5mM1RewFtt5iuvbmQDLcAaO5YoYdbSM98feTGuEJrQdyQ593g2gV+xmLC/KUS1qjDAZV3Umvrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618826; c=relaxed/simple;
	bh=sz7vvFb0iDyh0mr9nJUis8kyhYWrTiN7UpRCeBOzR4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myR/qKWkrZmoPsn8zCR5eQQDsP4iiY739I/GBd4x/ezJXNpuA5stN4VwKboaMYcPnspwcPNn8xY2oAnM0puSJiYs0kV23cBXE26wQ+bbmdpQy4cYS69o1scpnHrjI7/UijCHre+POpSpNh16e0KdJPIjEoIYe2hWsoCZqkquD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJRmxeiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJRmxeiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6331F00893;
	Thu, 17 Sep 2026 04:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618825;
	bh=zGQmVf7SK+u1H8NigvuTLpj49F+jyQACTjW2E0PLVC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJRmxeiLjIvTld/uLpV8QcVxghImVumv2EgzAqpWHh49F2DXuVX3VG+GuoMcnckBu
	 iylaAAnZq3QnLxHdwHZGHgQ/5LuyDTqtHU2X6k4chXDYIh647dsVZ8s0MuENBpZut3
	 yYrtCPsQSHNLtjZiGLKqFPVS20xecGy8051h11OkwR/76dcAdkdzXE1/c35lade5ce
	 6OjYH72u2Gx9AX9ErPbOnbgarLuWTF/HyUwQwICpA/Ze4moeZFjUmJixtGww1UEcWJ
	 im1ax8hMD4cEbrl5M7sipsQcykQ6Vl/qb4BEGxEimwpvQnwfJZRLgQLpMkw9R1Yash
	 tjh4+aeYoxz4g==
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
Subject: [PATCH 6.18.y 2/2] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 00:20:21 -0400
Message-ID: <20260917042021.6589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042021.6589-1-sashal@kernel.org>
References: <2026091633-nearby-gravel-9004@gregkh>
 <20260917042021.6589-1-sashal@kernel.org>
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
index e3858ab001695..b547466b1de90 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2972,14 +2972,14 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
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

