Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEB4A3F1C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106497; cv=none; b=ern2vZXb85+LU4PAtGZPDX3xrpcGqfcE5IdtG8UuTBeO0B4ezvwFOZpDJFcCYWamTs0rmh6JjRAVPEpTQRZYve5c4yjJbAPymq281Vm2P/lQVNjRU2D1o5xzHmc3rb9ZdKmlyMB/NghWWmMhtpAz1++QFNkLBPawTIKDsRzLc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106497; c=relaxed/simple;
	bh=qEKZ7Ptw+nn46n9UnGmwKYxF3HjWRg6i+u/Sc539o+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDrkExp1peaRO1dyf8ER4JOSoxoNpTxlmLHl4feHV6b4y73EHL5rMiis/z4F+GBl4n1OlTTDfulqj5T6JvIKjj9lZZJmm/8q95c8jsDRacABMjFq/DhoSWsX2vPdVoDppMIq8QDToEVAWO4MIEjkLEAVXqE0kIYncdtik+0QElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McbxgoC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McbxgoC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863B21F0089A;
	Tue, 22 Sep 2026 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106496;
	bh=hLUIJT9E775+h2jLK3Nx0bicWJ2H1MnhyGD3GDhRrFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McbxgoC+DvfLh5wtfE+INqFPdOu8Mof9Xk4cGPHV0SXcFGADAh/87PWDV4D7iwCBK
	 cBu2uzgjHqgSvVwFd3IGuRRE3gC5n2kuFNMZdizUBQIqL+vDFt3Zzy1b2FJfmnFjsM
	 h0p0Be4G36rJoQj6SjtipNU9ArPsGAViq+TOwWj58VmKPc/uTOPGUl4gbDeAHHZar/
	 YczeEFa/XVhHyPJzTjGQ6dFbC0odd80qblr32VMKgncgIMZk+XKfovS4WIlDr53viD
	 o5NZwjYq6hm/Jj/gdBrfuBStkkHtdYSnifztS3fpJxARDs7rGOmjqE2RI//sxJKiya
	 iJjOMIGtRjEpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] smb: client: fix unaligned access in WSL reparse point parser
Date: Tue, 22 Sep 2026 15:48:11 -0400
Message-ID: <20260922194812.85938-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194812.85938-1-sashal@kernel.org>
References: <2026092249-multitude-amigo-b729@gregkh>
 <20260922194812.85938-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit e1aeaf79dea51e6065da56924bc07e22d59012ac ]

When wsl_to_fattr() parses WSL extended attributes, it computes a
payload pointer from ea->ea_data + ea_name_length + 1.  Since the
smb2_file_full_ea_info struct is __packed and all WSL xattr names are
6 bytes long, the value pointer always lands at an odd byte offset,
never satisfying __le32 or __le64 alignment requirements.

The code then casts this pointer to __le32 * or __le64 * and
dereferences it directly, which may cause alignment faults on some
architectures.

Replace all such casts with get_unaligned_le32() and
get_unaligned_le64() in reparse_mkdev(), wsl_make_kuid(),
wsl_make_kgid() and wsl_to_fattr().

Closes: https://sashiko.dev/#/patchset/20260906200517.725015-1-pc%40manguebit.org
Fixes: 78e26bec4d6d ("smb: client: parse uid, gid, mode and dev from WSL reparse points")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Stable-dep-of: e1253a82bb4c ("smb: client: fix fattr leaking on wsl_to_fattr() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index d7d205cde8689..701969e018d24 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/uidgid.h>
+#include <linux/unaligned.h>
 #include "fs_context.h"
 #include "cifsglob.h"
 
@@ -22,7 +23,7 @@
 
 static inline dev_t reparse_mkdev(void *ptr)
 {
-	u64 v = le64_to_cpu(*(__le64 *)ptr);
+	u64 v = get_unaligned_le64(ptr);
 
 	return MKDEV(v & 0xffffffff, v >> 32);
 }
@@ -30,7 +31,7 @@ static inline dev_t reparse_mkdev(void *ptr)
 static inline kuid_t wsl_make_kuid(struct cifs_sb_info *cifs_sb,
 				   void *ptr)
 {
-	u32 uid = le32_to_cpu(*(__le32 *)ptr);
+	u32 uid = get_unaligned_le32(ptr);
 
 	if (cifs_sb_flags(cifs_sb) & CIFS_MOUNT_OVERR_UID)
 		return cifs_sb->ctx->linux_uid;
@@ -40,7 +41,7 @@ static inline kuid_t wsl_make_kuid(struct cifs_sb_info *cifs_sb,
 static inline kgid_t wsl_make_kgid(struct cifs_sb_info *cifs_sb,
 				   void *ptr)
 {
-	u32 gid = le32_to_cpu(*(__le32 *)ptr);
+	u32 gid = get_unaligned_le32(ptr);
 
 	if (cifs_sb_flags(cifs_sb) & CIFS_MOUNT_OVERR_GID)
 		return cifs_sb->ctx->linux_gid;
-- 
2.53.0

