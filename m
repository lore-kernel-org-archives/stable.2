Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD750AC0B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649370; cv=none; b=oo2ORdrZ9ORj49FNkYMnY+DLLtWQC2l79SjNB3bQl4rTn8TP9U9WpIE10oLIO0qXn6KIhMzHxb9A/+TdLLHvNsslMKn685rO8QrwJACQLbUM2Ad0UwbvZkmQT1okv93h3UJaMT/JaBT55rkCCcJicx6+AHeG9UpTytEkUj+IzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649370; c=relaxed/simple;
	bh=pv6CctSfVLp97l/B1WMX4ibwfqEw0MOdZngNVLE2Ej0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A36P98McxGRJ96NGeRloKBPy5igVgzY6j+J0/OM/8KTNRBEPLNGkjqkIlubTHQpnQ8WGGq/RF9zZBP89lpYtv2O9nZN+iosKU8/O+rdT/0wbu4RBcM0PWYBP/YLVFsqUAIcEemXbg38NSJwevn3DlaDDqjzum63CQsYJ7NL+044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnDaPh0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnDaPh0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBED1F000FF;
	Thu, 17 Sep 2026 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649352;
	bh=MJL2Y2XbHseFOAcIHwGPOSKMn+0wOPFui0uc1AoGBzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnDaPh0GcvkQIgsXfPl+fRhgaP9txdppeAASTkdTyObvKnD/GP28zHCGg9WZw7521
	 Kenj7aoezuw3wxwlXs2pn82sbCu2nlg8aBYdmTlC01ovJmolufe/3zbZPiv3OQ0WrC
	 QrIhoSKPoN0ARwVjcpVVlDxukvOG8pTImrVDHvCunf+VCAL/F8wMmir0i5lih1BL6H
	 +l36kybE5MlsS0O84LTATVNY7uXYENzyz2g3m1maDU5Mng7+WaVF94d6/fEQ/m8xAa
	 99xXDdaYNeDEtabkpzEtCOOrwTmD4AjRP4zFvAkV1RUj6dMbp8YGaQVGnp6LDZmDY9
	 /aOVsty4+cHxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] smb/client: fix security flag calculation when setting security descriptors
Date: Thu, 17 Sep 2026 08:49:08 -0400
Message-ID: <20260917124909.224558-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917124909.224558-1-sashal@kernel.org>
References: <2026091604-pug-prewashed-fdb3@gregkh>
 <20260917124909.224558-1-sashal@kernel.org>
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
 fs/smb/client/cifsacl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 122375e21661a..741b852355bc0 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1676,7 +1676,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			kuid_t uid, kgid_t gid)
 {
 	int rc = 0;
-	int aclflag = CIFS_ACL_DACL; /* default flag to set */
+	int aclflag = 0;
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
@@ -1779,6 +1779,11 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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

