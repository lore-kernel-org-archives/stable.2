Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9357C70A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653738; cv=none; b=UjY1wY39Yxk3k1mkq8sR+pL9Uh8EYtRkO+k+ib54yT+DK3qLHrs1Fb0eEZP+z0WoBPVkKhQeuYD5DTwpi9bfUboZO/TEE+NZj5+yuCYoRQzxOVdSgl7yBi7cfcR9XzaCyen6K6+P05pzqJOdm2auQsXTSi5IOqTTXhnqviQR4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653738; c=relaxed/simple;
	bh=8QJu8b6BXZkEdj6bWZuihUe8kpnkexlw9Ab5RroeVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTzPlwyI3+DP7wMiA4WvoJFOF/AsEY/ZsqnPLTpVthHQ3W1nJmNhwXX0hX6HDL3aK2G4jwnZRyNbysOM1TZ+OfRUNTXwqVh5KtXstSBcP2WCVXJFJZXeXgbDFp8zXFELSab5D9vbt8lgc5t1hIqj7KdemcD0t7mZl4ubHQbm2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvHGz0LF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvHGz0LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F43F1F00899;
	Thu, 17 Sep 2026 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653737;
	bh=sp25n1gEPlnz0TIHwQGg4QIj9JAnm59kfFm67frtW6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RvHGz0LF7TgVY97Ob9DHp1fn9WuZUBG7+i0h603/9XVjFiOV83uHY0CFaJlsM97YM
	 Fmu6/k4RVnoASo+aQAQd+YknGSra5NSLOKoUPoIFe+b80jaH1z2Z6Isv9Y+uit7Z8Z
	 tjf63VD2Ch1X63wfIC3gPBltbVrR7IXgeg6Z+bRngtrRpZpI7EmsGQrmO4myjETaj5
	 /eWp9S6ErfCwp4p0MN8QzoezXUnfiqV3lEXx3IXL3hFb8YvswiQW555j42YnWkihkN
	 gqQyE+qLZDwzVHF1++JUCT8E10C6luz5bbnP2lL1FcI2qZtc1TjPtepWZqhoW35S/Y
	 Xot+sUzg7qcYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] smb/client: fix security flag calculation when setting security descriptors
Date: Thu, 17 Sep 2026 10:02:10 -0400
Message-ID: <20260917140211.506490-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917140211.506490-1-sashal@kernel.org>
References: <2026091604-anew-player-ae82@gregkh>
 <20260917140211.506490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralph Boehme <slow@samba.org>

[ Upstream commit 4939889c985da68936090cc013e58c28b7bff34f ]

In id_mode_to_cifs_acl(), aclflag was initialized to CIFS_ACL_DACL by default.
This forced the client to request setting the DACL even when only an ownership
(chown) or group (chgrp) change was being performed.

Let build_sec_desc() do the proper flag calculation by initializing aclflag
to 0. build_sec_desc() sets the appropriate bits (CIFS_ACL_OWNER, CIFS_ACL_GROUP,
or CIFS_ACL_DACL) depending on what actually changed. During ownership transfer,
CIFS_ACL_DACL is only set if replace_sids_and_copy_aces() actually replaces the
SIDs inside any of the DACL's ACEs.

If build_sec_desc() results in aclflag being 0 (meaning no changes were mapped),
exit early to avoid sending an empty security descriptor update to the server.

Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d05045177a85 ("smb: client: fail DACL rewrite when the new DACL exceeds 64K")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 4e7ac1c4e5af0..03be080dfd480 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1674,7 +1674,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			kuid_t uid, kgid_t gid)
 {
 	int rc = 0;
-	int aclflag = CIFS_ACL_DACL; /* default flag to set */
+	int aclflag = 0;
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
@@ -1773,6 +1773,11 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	if (rc != 0)
 		goto id_mode_to_cifs_acl_exit;
 
+	if (aclflag == 0) {
+		cifs_dbg(FYI, "set_cifs_acl aclflag=0, no change mapped\n");
+		goto id_mode_to_cifs_acl_exit;
+	}
+
 	if (ops->set_acl == NULL) {
 		rc = -EOPNOTSUPP;
 		goto id_mode_to_cifs_acl_exit;
-- 
2.53.0

