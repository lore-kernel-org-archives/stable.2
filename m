Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2D4A207A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106496; cv=none; b=XyHE9tAhvG4f6Zb+DPy/4/vyKfh/oHfwBrtBdMgZ1B7dn0UDZPBQJ8Q5dgLKpg17+H6qgQK+TComhhJ+NsozKZCB35vAQJQ9KUhSigj/Zi9mk6pEVjK0ZZRELm0v+TIcHiH8VV3z2FzGPvqf+QAogKXcqJlB5euQC8CluC7G9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106496; c=relaxed/simple;
	bh=xw9pCE3I4SffVuoNE1Xiu0so/j+RHMQIXfZK0EYsFx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBYVdXWreU56mvek7s7rSJiDkZjNPNbIdXAuaY9XN3yAT6ajdOMZygGExFaLHFZ4AYX6cWd4OuNCFR2xDyQ1Qe0Ffcp5+VcLtmthQzPpWcSyPfF4wdDkW6S7QS6jKy1JLXTfUVoIryo5R3iXm2rBgN2zRYHiYh9jQNyhhTPbH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzZTIt9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzZTIt9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5671F000FF;
	Tue, 22 Sep 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106495;
	bh=vT8tTryQDmppVi1H0rasiswBs9iD5ztVnLiul+zRqq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzZTIt9P2iiN1Wrw9HQDQ9JyM9g3F8v/3PPE5oTJ2evPiPAgyK8kCHyBtTldkyw+3
	 5rqkqnkPL1EgG7qK3oxXttsuewaETmZpJx2oZ2aCtp6Wvfa6aCKv2LRGzcGAg+Iks9
	 FDOUaSBIqwiS2lb0353+0GJBxuT5LzcYbs1BANnSqBdMJLIjDat0GGJLiZBZhmdBRi
	 cqv7Q6X2kBf4F78xevV8qXPOpr13S//XP8nfoQmBQJkD//dmG3uDSAq+9fwiZ+6BRA
	 ttDOZpEGF2ghXF+yHiEwgErZdxaFhR9pG+Rvg1+2saytGsXdqBPAREb3h5BiylLdGi
	 J4bmqx9zCk1xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] smb: client: fix WSL reparse point uid/gid override
Date: Tue, 22 Sep 2026 15:48:10 -0400
Message-ID: <20260922194812.85938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092249-multitude-amigo-b729@gregkh>
References: <2026092249-multitude-amigo-b729@gregkh>
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

Backport adaptation for Linux 6.18:
Keep the existing S_IFMT clearing from 99daf7535445 when adding the
mount-default UID/GID initialization.  The stable branch already has
that file-type fix, which followed this dependency upstream.

Also include the two wsl_to_fattr() mode-read conversions from
e1aeaf79dea5 and include linux/unaligned.h directly.  These are the
remaining context changes needed for e1253a82bb4c to apply unchanged;
the other helper conversions are outside this target's context.

Stable-dep-of: e1253a82bb4c ("smb: client: fix fattr leaking on wsl_to_fattr() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 6ec6b8c46ba22..c87b282da1ce9 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include "cifsglob.h"
 #include "smb2proto.h"
 #include "cifsproto.h"
@@ -1109,10 +1110,14 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
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
 	fattr->cf_mode &= ~S_IFMT;
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
@@ -1150,15 +1155,17 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
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
-			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
+			if (S_DT(fattr->cf_mode) != S_DT(get_unaligned_le32(v)))
 				return false;
-			fattr->cf_mode = (umode_t)le32_to_cpu(*(__le32 *)v);
+			fattr->cf_mode = (umode_t)get_unaligned_le32(v);
 		} else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen)) {
 			fattr->cf_rdev = reparse_mkdev(v);
 			have_xattr_dev = true;
-- 
2.53.0

