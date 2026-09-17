Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F648489A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657764; cv=none; b=cst6/Xl6mPKyZwiLpIV79PlU5YcUzIsal5DNfB+4yxjQaMaICB0wgK1XjvnagYYZL0J7TUy1W3DNYSSlwR+A8D6b3y59JLjb04F84A2QtXKuRuNO9jQNE5jTVqlL/2Htkr3H82TZxjlAJMNEHg5CaDC3VEVbVaCwwWHDlsaxhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657764; c=relaxed/simple;
	bh=S1B3PYH0kejGTSdOhV+ElWcw3s7OoY5UmBQzj/QMFOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI6EHrUea3ZOF+5ff33GqtHwvJLYK4msBWxSDwQokfpSqrCmDMlIQkwfv0Z9zA1cdhOzY5dkUgu/83X77OnoKeG73QW3sb338kENlLHMEagUm9v9KM3EqJIiIQs8JSHxGm1xbm1YIJ8+NF+fhH5jnXM57P69dpoxVsYHpE0B7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4jGKViH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4jGKViH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122F81F00898;
	Thu, 17 Sep 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657736;
	bh=5oi+IAV/rvo9psWtSlnkZbvbvHTgRvBIGNGagv+etfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4jGKViHSEVXLMS9tB0f3itA36fb0MOljmDkpIyZRyMYj6ZZbIIaVzl0DF3aqorfc
	 +9Ww/xacBUGv6jt0j13DrmTNsLs55bctTU/HeY+6JSK1vAP7fjJKABWokCf+PhznZn
	 BY+eNvjJxu0WtxwRLR/MyC2ZirD39YZAXGKCE1WnRe6LKj4CJodHDSYekghHxH1FjD
	 uDxvubEH11cz5aFmSt1JgFEaeKHVxjDBQ4ZnNwSmv35TxDK18sDvgldd2MUs7LEPVh
	 lQVDlZKL5HrcQIUEMqQDV/m8OmZRP+BL5xLWDh0X3A7Tdx2wwQoQB/bPMKHKmUpwXe
	 +NiKPqXVQWtsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
Date: Thu, 17 Sep 2026 11:08:53 -0400
Message-ID: <20260917150853.681793-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917150853.681793-1-sashal@kernel.org>
References: <2026091629-most-slimness-8500@gregkh>
 <20260917150853.681793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit da6e25842431982d5a53cf00d925b98c690f4467 ]

cifs_posix_to_fattr() ignores the return value of posix_info_parse().
When a malformed POSIX directory entry is encountered (e.g. invalid
SID lengths from an untrusted server), posix_info_parse() returns -1
without populating the 'parsed' struct.  The uninitialized stack
memory in parsed.owner and parsed.group is then passed to
sid_to_id(), which processes the garbage bytes and passes them to
request_key() to construct a SID string, potentially leaking kernel
stack contents to the userspace idmap daemon.

Fix this by checking the return value and skipping the SID-to-id
mapping when parsing fails.  The remaining fattr fields (timestamps,
mode, etc.) are populated directly from the 'info' pointer so they
are unaffected.

Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40manguebit.org
Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/readdir.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 8ccfdc6a10cfb..2f580a4868915 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -243,8 +243,9 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 {
 	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_posix_info_parsed parsed;
+	int rc;
 
-	posix_info_parse(info, NULL, &parsed);
+	rc = posix_info_parse(info, NULL, &parsed);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
@@ -283,10 +284,15 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 
 	fattr->cf_uid = cifs_sb->ctx->linux_uid;
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
-	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
-		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
-	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
-		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	if (rc < 0) {
+		cifs_dbg(VFS, "%s: failed to parse SIDs: %d\n",
+			 __func__, rc);
+	} else {
+		if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+			sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
+		if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+			sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	}
 }
 
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
-- 
2.53.0

