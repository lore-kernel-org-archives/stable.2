Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2B49D584
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670380; cv=none; b=COPi6WLLLs4qiYMK29FRmw9ftwH5162Ff7wBle/nNFczYmG5NLeRBzVnRz+cSexOGixY2bxnmnqg31tbyJxNUrf8FelQpCaEH+9FR4unCdTG1REuKUgiL4TVepBed9REXvIwdKsmB5hnTlnZUSxiCgTCz7JYxSEl7R+B2B02OMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670380; c=relaxed/simple;
	bh=RWSMclJsGzUJ77a11Td6AAypBUNR9wj9BsyKYKtZQ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXdFPsp1IWCgjFIL/I378L2A1mDhCogf/7P5FE2kFuyT+shAT8PSrpNHPBbC4GH4UWIfZZ7w9sTtQvgIrEvhIMJ+3vfCHlaDdJvCna9EMnX3B29P9UYQwxH7eT2mod1wK8NPQREpnnq1ur/qA2Aq16dhmzGqoN6w+RbimyYwcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBt7HAH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBt7HAH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9521F0089B;
	Thu, 17 Sep 2026 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670378;
	bh=DTO3rEVtkXsY1mflVPE8xJvwY79hbdCYjhAaj1ZIHMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBt7HAH955uwlJq/Xi+bQ5YYbaxxq9Sq02lP2zmXBd9Hj83Vmuot1rOb4vTdZru5N
	 Lr9jAXFL5jgVQpG3sE+Zi0s04YuAJrAGdDNBt2tEeBGjl7sI/GplOyemlTQ7fb+tOd
	 mDBjaAfc4R08vD7UAdPwA201MKsJyM8W9945Td/CAt2Lvl6upg4q7crgpb4mV1x+AR
	 WbFgcea1AcibwGtvEKb4H0UORsDYvmn1DOvvJ4C1aUMut3wjp59msN03Z0MjMRHiTd
	 ASeXUYF795jp58xzT7/ZkDXDIrlnDi6y+B6YBGxCMudBHwi4nOIEW6z+4SrJzBr3PW
	 DOI+yaDcWyCLQ==
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
Subject: [PATCH 5.15.y 2/2] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 14:39:35 -0400
Message-ID: <20260917183935.1200920-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917183935.1200920-1-sashal@kernel.org>
References: <2026091635-untwist-absently-462b@gregkh>
 <20260917183935.1200920-1-sashal@kernel.org>
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
index 537e5baf4ca24..99a72ca8f958e 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2482,14 +2482,14 @@ int cifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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

