Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EF4D4878
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658267; cv=none; b=oYgiYxpHLsl+KU5aiYa4485gBE5McnGmSsv89g6Nzab+Fl2+lKNL4C31F0GJqQ5/IPm6HkZHLvhqVQyj/Ey08VlNO6KDik2Jy7mZs+SqyzBC5laQHxYVWpql3fCATbffjVEYO+kknLfoZZ6o4XZTWB6mXMonrQUmOBI+ND2IY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658267; c=relaxed/simple;
	bh=B3bHMnWP3gNYNWKGllDqNdZXEy2Lm//9WRcGVKj8hfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p050CA4nn0wgsxC2FHb9D6FyHja7k/4JV2D4jKETY9n3xmVzsQSkACmC2i01aGeB7bMg/5z1DgAtZiv+hEmAffjCeYqKwlKIoebcqGizWnxHXgZmlUK5tgfrGre0bwzVakyYBciMTHpvggEXR4JHcnKUhzv08I/QGn1Q8eoIj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELpuqa1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELpuqa1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D381F008A1;
	Thu, 17 Sep 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658241;
	bh=EL5vh+bz04rI+95v0M6FiEP7C72puKyhWj/S9pfZp/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELpuqa1RFvl1C3LhFbmLIlPEVf5pCkpFkxID68bSWCcZgH0rhVp7VSfgkxs03n9yb
	 LJxbgMQnAybFpW7W+YY4ftfa9AgGHiZItd+M/k8mMw9yTT66Sy7zDiQYcGxCBi8qXm
	 jMYBV0WGuz1uWnyXP1v4VvK1xZJn/d/gpJDgIlBPRHGE8UbvyV7shNTsR52EWcpsEz
	 4iuYvZx0wvIVzpyjCtnr2CNIG5Nq4d9CoGya1DQg3Etn2wtBy/4603XZLr7vjDkFrC
	 NUL81KGaV0mpATzVzJ5fSIqEi8R30vDLPUlHH9iLLzhmphlD1qRPrMvi9lFcd9XbG8
	 L+85KRvxCgsfA==
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
Subject: [PATCH 6.1.y 3/3] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 11:17:16 -0400
Message-ID: <20260917151716.693532-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917151716.693532-1-sashal@kernel.org>
References: <2026091635-bolt-hunchback-845c@gregkh>
 <20260917151716.693532-1-sashal@kernel.org>
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
index b883b9164ead3..c4c1148ff777f 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2594,14 +2594,14 @@ int cifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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

