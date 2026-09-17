Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FF57C70A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653736; cv=none; b=TIu6sl1KZV4f7uYpX93L3mLMPMwumib4OOmOC6ZbHxQRuLU+QjrhGUo0djn4X+j0P7IaYyA9A6DtZTmKRQnECBA/2N3aBzGPFySyVSBHfnAfJMlyJ0zDg54fRkmSm/ITq2Pl95EINpvPfc3OPKLxJ37Ab89fhYdmAK+ra67qXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653736; c=relaxed/simple;
	bh=Dqa97ENP4I6+neg2em9HzctXXMt+SMmA/eYSRZmZPdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmB5QXfTtWYC5Lu2AcnQpE9MtJf7SRUX9KSmdB28HpO4ZIfpbfl+rx5MqRx1yxe2oSMJeXwWbvq+Qvc/2vsdnPb+mSWY3tFC4vvxapFLDP0ujlJMWsPVOAo6ozQSbnQbLgROEwyI+aS+8zisx8q7WyvS6quAwpgtjnscRh/zLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Ps196t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Ps196t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364E21F00893;
	Thu, 17 Sep 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653734;
	bh=TYbBblZ3AMLgD+uS0DKqIJX56Rj/x0NF+Be8WO84b5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+Ps196tPTlF7i9P+Y3u8r13QFXw1jYoC4AEFedTDvQUirjD1NWBVKgdgsPEcPoUy
	 GYjrVsGpF1j49ZJ0K5kEf56GVeA3w8YxMBH/4LgUwCOwwhx1hxJyuXjDmNlIDC7y3g
	 XLfkCkbnKGhvBJzSTo8ULswKQJ2DSzrTyBBcB/+zFaDMdKUjPn3eJBMFwSNJATOYdZ
	 A9xF8nZ8Rl8bWtE4V2BEVro8bS8yTs2+Sr0GzrGy7hnRRR3tLM9zpPLio2ZJDjdXBN
	 Y/5S9zWz1v6tHWxdV4MkrcFASC2wrU/XcA2iMxdVlernmBz5z9/FFO/n0xFl/TQ31B
	 wGnYE3w8wHq/g==
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
Subject: [PATCH 6.6.y 3/3] smb: client: fix uid/gid override in getattr with posix extensions
Date: Thu, 17 Sep 2026 10:02:08 -0400
Message-ID: <20260917140208.505903-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917140208.505903-1-sashal@kernel.org>
References: <2026091634-finch-unglazed-c530@gregkh>
 <20260917140208.505903-1-sashal@kernel.org>
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
index af4a99ccafc20..7a77fbcb50b5e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2832,14 +2832,14 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
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

