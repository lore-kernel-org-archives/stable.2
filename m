Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BB349CD8
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691324; cv=none; b=Ny7ABYfONBoPdKs7gdoDt6GyhaQSya5FfdM4qixcPftVXWnjzLKENr5SgRFbnxoEQ1L0JdAVm0Aba7dDBubK1U0Fq98EsEs/o2IP3SsX2V23EfBrJGEudI5LG/sNJO3MvpEwPBIbaLDvI407/1pov9u5CcxjiL5cCxPJ5TnUwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691324; c=relaxed/simple;
	bh=+qj8SH6ipWiwRVDzzAtt1isAZTdOBE9vPlWorU0sZz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkJBGgBgUjZGCkPYy92dffvTbi4H0ytxvpNnJ/qs8AsbIkN/JHV44wTTPwWEyimDrGbRmXFh3WLcf89q83jtArQQsJp1ybEl+fZ+eFqtErc2Mba0BIVRfbt4mZFItvFABseA+liA11u4dGBkmDAfqp+CFjNLGLqXc6qC/1Mb6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXbuFUyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXbuFUyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E62B1F00893;
	Fri, 18 Sep 2026 00:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691315;
	bh=D+lq9NSjCyl5c6LXZA9ou/oirVj3mtuFwKcG3Xa3vhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXbuFUyQK8SvuXN0mcweYWsoeGtVa2/v0wh6EVMYwvorsNoMAtHn1bj5iM+QnfkgT
	 fWeiWq+mlM1CcdH0NzRHbYI8Bm3KCzWr1mYf3Iaw9eNHTsUsSe96oHDHS2SmNo1CLz
	 m634FvtHNH9Ehdl+gRaQZjbD+tw6Q8xn6qQRKNumKZonQpRQf5M29ymL+t5rjceUyK
	 hvwdLO7efFE0RMAnhPp7IToC1/luoNXq6i2jP83sAqqqTiVW66ueieXDOy9wSDV7JI
	 nXg5eObgGj7oHYmtaQxIT2KCA2+khYjQ5xITYPhMAc6/rNQM7TolM2m8nbGLjU7Kio
	 c7IhtPJFwIJYg==
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
Subject: [PATCH 5.10.y 2/2] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 20:28:31 -0400
Message-ID: <20260918002831.1323627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918002831.1323627-1-sashal@kernel.org>
References: <2026091636-plot-cobalt-bbd3@gregkh>
 <20260918002831.1323627-1-sashal@kernel.org>
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
 fs/cifs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 6f44f54ea60e2..2258ad7f43eb3 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2418,14 +2418,14 @@ int cifs_getattr(const struct path *path, struct kstat *stat,
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

