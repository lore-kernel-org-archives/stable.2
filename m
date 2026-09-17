Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF01448E0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618628; cv=none; b=nMCL8eFwF61Bw/dRBMwI/tFEAGcrL2H+uk1ErrrfNTzf/zQJUZ5DhMReTmBVgj29cU6M88fgv5kDsVxB4h40LqMNKiwKo2gD3wky6jwhl7EFKLQvSruk5Gpihz9roWScAPbdyK5IgbrplLxmKDcaejogyUbEvAg/TCVvojeOo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618628; c=relaxed/simple;
	bh=bF1GsDwRYXTmvYxl9gQVFNjMN3Tj328jtnO+Lfl85wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN2jSfxuFQp7snIZRKapyLc33P4DeV0NGRP5Ss4RFKTaF3VrPTuxwLQowx4w+lJZ1RiX7BK2ynTOgyXmCIh9EJCkH9/FIfQqcmSo+7RN8Uf7qzjooX1prAvEOaoNSMDJUiIJ6TnA5dStnwVlXVrnnRlrX9vJDYbUzLaRbi48hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsOVKe0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsOVKe0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3BD1F00893;
	Thu, 17 Sep 2026 04:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618626;
	bh=YwLuRxphQDfS5do9RqtejH4tOH9cQ7SQiQmVLzOe7tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsOVKe0NiVa1Kbmg1DTh4DABEa0WJo29YG6WryUlpiEhYwddGQiIgWyImRg0mrdtM
	 2vO7KkpzDMyQxRKy1y1xyzneNFTINPRIqBBSSYLTkXQQq0dsso2Eu8n4d+hw5J3Vr1
	 mKUchInNLnnWUqQTcx3myf7O/Js2QYJFlLIKgrUbyTMFoepl3YjnbjKbr8rcxYAaS5
	 FIUUQHm/jT1aEOvrV02M4aEEZfLXp7btaoKrNl26YXCVB5jlFXSx7eMJy0VhtMfeFC
	 ZY7iNIsLT7SgUjvNGHMD6y5vfFzxdt6WoeYP8ikqtHHUwRa8xOQg7QMJR/wP3NZs0t
	 m1Al1PsNVXqDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] smb: client: fix WSL reparse point uid/gid override
Date: Thu, 17 Sep 2026 00:17:03 -0400
Message-ID: <20260917041703.4190978-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917041703.4190978-1-sashal@kernel.org>
References: <2026091651-rehydrate-vexingly-f239@gregkh>
 <20260917041703.4190978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit cd2b2b57921d4caa7875e83198bb2aa71254328b ]

wsl_to_fattr() unconditionally overwrites cf_uid/cf_gid with values
from WSL extended attributes ($LXUID/$LXGID), ignoring the forceuid
and forcegid mount options.

Fix this by initializing cf_uid/cf_gid to the mount defaults and
gating the $LXUID/$LXGID EA parsing on forceuid/forcegid.

Closes: https://sashiko.dev/#/patchset/20260906190803.667489-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 58bd67f32377f..383eb9bd45793 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1108,10 +1108,14 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 			 struct cifs_sb_info *cifs_sb,
 			 u32 tag, struct cifs_fattr *fattr)
 {
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_file_full_ea_info *ea;
 	bool have_xattr_dev = false;
 	u32 next = 0;
 
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
 		fattr->cf_mode |= S_IFLNK;
@@ -1148,11 +1152,13 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 		nlen = ea->ea_name_length;
 		v = (void *)((u8 *)ea->ea_data + ea->ea_name_length + 1);
 
-		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen))
-			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
-			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
+		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
+			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
+		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
+			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
+		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
 			/* File type in reparse point tag and in xattr mode must match. */
 			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
 				return false;
-- 
2.53.0

