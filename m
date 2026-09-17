Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD5503BFC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649367; cv=none; b=MgcDEE79zKL+XQ7CQj9rBywoeDATZmxXldED5bUNDPk0aDSo0CfseZzmlHRVN3HM98J4gugaQ4s9ZOLpEtXUzW7SI16eygwgxiPnDN+QxDWT2rv5MN94vwO01Tu0PLjAzdYar22Ra4FrCoHodkPOJltqEpW7MmcpgKmtmxeFs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649367; c=relaxed/simple;
	bh=HDCSYcWrPNYbXb6+H/C/u0ILvSr/ED1yqDkYzQ4KeTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWHqr0eImaRhDVvKY75UiBv4T3wgEDX4Zhtj2cTwmbP5cmb2R5aYAs3DyKLEoracFHzYywFBHl6wxi2jyrJb0MQiwPvQ99PR+2R+YOIOkw1fhZ7+DRHVMRuXatTtz5i9jACg/gX9kfdtted9z/fXlk4vsrBQgVMgCUoeTdnpYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn6sX3gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn6sX3gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6591F008A0;
	Thu, 17 Sep 2026 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649352;
	bh=UelwT0wJoBwueIWKprN1RQ4WXIP5rSZOKg3b4g5g1Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bn6sX3gfmbzAZdUk3817RWV59UOc99TxegtdfemnZNHK1u1fQGK3iOFnCbb3EFe6W
	 LDsJjEtmkOzsRtximRp4f1bFGYM/wcZi1L1+XFli+KUd/mc9sr4Zy/mOqPN37dH9t6
	 FgFZeToKXP4BvpQGPXCX7FgwAYRkp9g5ZMm/PWRs/tQncg7BRjc7vm/otT9+6r0KZ9
	 wVz+KyIR0zwXtzrIPUHaGtT9w1WwPT6bnvGTtQlFgEqpF/AH5eXfkhoEZF2OT5YrXX
	 qMnwr73YEmbqWy5tJadlJlNuJeD4KzqzySV5f6mn2OIVS9RV2kF3B2JUjdFB/FF/7Q
	 W82el4k37tDmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
Date: Thu, 17 Sep 2026 08:49:07 -0400
Message-ID: <20260917124909.224558-2-sashal@kernel.org>
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

[ Upstream commit a540a64c4801fe02e452ee37e961018106418260 ]

Refactor the control flow in id_mode_to_cifs_acl() to reduce nesting and
prevent error code overwriting.

Instead of wrapping the call to ops->set_acl() in a conditional block,
introduce early exits (goto id_mode_to_cifs_acl_exit) when build_sec_desc()
fails or ops->set_acl is NULL. This ensures that any actual error returned
by build_sec_desc() is not overwritten with -EOPNOTSUPP.

Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d05045177a85 ("smb: client: fail DACL rewrite when the new DACL exceeds 64K")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 879dcd4b2f353..122375e21661a 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1776,14 +1776,18 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 
 	cifs_dbg(NOISY, "build_sec_desc rc: %d\n", rc);
 
-	if (ops->set_acl == NULL)
-		rc = -EOPNOTSUPP;
+	if (rc != 0)
+		goto id_mode_to_cifs_acl_exit;
 
-	if (!rc) {
-		/* Set the security descriptor */
-		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
-		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
+	if (ops->set_acl == NULL) {
+		rc = -EOPNOTSUPP;
+		goto id_mode_to_cifs_acl_exit;
 	}
+
+	/* Set the security descriptor */
+	rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
+	cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
+
 id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
-- 
2.53.0

