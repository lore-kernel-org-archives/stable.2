Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C45921ED
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654147; cv=none; b=DmLhXgN2qcfF+zRGWUCnS8yLFDJXzJOFIumN2jhumkgAQm6/229J+T/y6fHxAaAzlAeNeuG0w0SVcuNDz765ndoZ3Lly1ppiNR6xci8ZZVSCHVYfA1ZVweGBd4huBd7G9VLoI7ldMphND8wh+g18OUWKJCalAtjXTVer6UwIhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654147; c=relaxed/simple;
	bh=gSVRydkUrg79ygHQt+rNZiQvP5ws7RItfaGMfh2BNw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIDXgWrlkvDHmtmQBtbKChRUEHFor5jlyAT2p9huMqnerZWYyeJ98bDxov2n09rVltlKdF/tc3YEmTQBWtmM/5HrkEXTI7sHuqfPNL4i8vrsplpo3HjtbtnLZ4LoN9gegoiWwcNyuJmlvHrhxlRPkgsdE7a87Dt/Pd19ODU/Drs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7FXN1Pb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7FXN1Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514511F00899;
	Thu, 17 Sep 2026 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654135;
	bh=hc05sWUwgwAnM+vZaoz7KKGJ6UlCqw89dzeDUy1XOVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7FXN1PbAXpgCcIxxy8LgJQlo1m9sZyGXaHlrlGm+NlXbZd8FWpO/3GRTn1sUFtqR
	 kXANkVvLR0heE2wtwGNcwPB50wQK94HU4f4Mo4m7ciGC5kzSiN5orRqFflkkn7/FLw
	 m9Atjks9V7IoX0heen3eKCkP7sZH4+wJ2U6nF3NJ9NIZjPkt22hvSSJNJuKyD2FiyI
	 lokMkvNX0vJdci/EKPeU/3hCE/jr/Bvwn5RCIhjXV763s0fk72anlSZxBjOvBjZg8J
	 3oihX7/sPXH85FslSw8cU9+QjVhN7CtjQQr4jdYMevqWFW/S0ElbOkDJOK/N3wSXwS
	 8TdE2h/gPN0Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
Date: Thu, 17 Sep 2026 10:08:52 -0400
Message-ID: <20260917140852.514379-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917140852.514379-1-sashal@kernel.org>
References: <2026091628-glance-dexterity-17f6@gregkh>
 <20260917140852.514379-1-sashal@kernel.org>
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
index 93135be123316..28293759669ed 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -244,8 +244,9 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 {
 	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_posix_info_parsed parsed;
+	int rc;
 
-	posix_info_parse(info, NULL, &parsed);
+	rc = posix_info_parse(info, NULL, &parsed);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
@@ -284,10 +285,15 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 
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

