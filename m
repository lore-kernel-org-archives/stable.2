Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89030F533
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691322; cv=none; b=BEr7xbNc/o1NfFBBnJFJVZI5QAxzoDmXCIUyHH3Dlii+qhbX02bh29h/iHli3+hmU8bXJ/qHHwUV3tY9ec7iOrvqhqQ/bacWS/F8vvnHXR8qb8XuaXy+wBF37ZSgChiTZDuIAbwuWURvW/2bA2wBQhtqc555kcIbUkFliEzEh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691322; c=relaxed/simple;
	bh=CIsxbs81KXq1K/eSL3kMHahjzUc0C7Rl/K0J4Mt/05c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWYpU3FOnv17eFZ1Km26vfsD8ko7x4vQ4wu3cpGlZ5hv7r/iPU2MupR5wKCk5+PIuI2drq9tzI0u2VlsUHqDB0lfaFhH9N9HvY+IyX3F8FyYRB547a7K7EUXML70zkqPX3hUye7v3lNEVzGdBxOnKYLDi8lw45ZvmfPyZ3TsQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af7xyRQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af7xyRQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1D21F0089B;
	Fri, 18 Sep 2026 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691318;
	bh=kv1FMQwTWldk5q6+fxvkbxyQa9hu1t6EguDcdjOpolo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=af7xyRQC0YhSrrTaMOSN9PEITJAcVA/b3i4lLDsh/8ZPDsc5WiOhnYKCPR4PD1ks4
	 szvlarTylrvs+PI2gKt1aJt3PYgBkxHQC5SHOpD8fCB5qEmdXFbv3qM36QljZHa7Az
	 4AqgNWQ0jcNZreioGUDIXybl7XEzEDtcSWf6Q+G21YJWxYK74RnLwpKcYNxo5Y0b6A
	 Fezovqph3xOTcphPMQEPrrifghP8mdCI/sdsZ67r2gGHwHSuQExPthYzJ2JkrQuLos
	 dbQFdS/2mijJXMb22NaV70GCij0C+ZYvcJ3uPIBUuEpdZO0XWeN2H4Hsk1wgk3o60I
	 UzqxtMkYDaRYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
Date: Thu, 17 Sep 2026 20:28:35 -0400
Message-ID: <20260918002835.1323758-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918002835.1323758-1-sashal@kernel.org>
References: <2026091630-sherry-congenial-9b1f@gregkh>
 <20260918002835.1323758-1-sashal@kernel.org>
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
 fs/cifs/readdir.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index f0c3b51b984df..bc7836f6774ee 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -248,8 +248,9 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 {
 	unsigned int sbflags = cifs_sb->mnt_cifs_flags;
 	struct smb2_posix_info_parsed parsed;
+	int rc;
 
-	posix_info_parse(info, NULL, &parsed);
+	rc = posix_info_parse(info, NULL, &parsed);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
@@ -293,10 +294,15 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 
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

