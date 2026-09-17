Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC72DC79F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617883; cv=none; b=KX644ml6xUQIP1k/w6TpgbAPQ+Vi07b/6MeyeR9x6kaULRJbysIva6sYFzX2Ehuc9vQ6oub64Blkj37Z36K45CTANzVKeDXOE94uBmw5bUBCPn0xB/fNaKBALl8I0wj/q9814euYpOWsqhOUd3FlevlOmQT78i8IcSpEXPG860E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617883; c=relaxed/simple;
	bh=jSFrj2sOHj+PTsYyudi/RSdx5mvNPSehloLhoNdabYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3VC+5GRE0TuS0o4xFpTvVo32rPI1wKnrrEQ0/kmWWq0P0sUhWUIj9XVhOD/IW5uzG7lUrkBW0RnChsyVKDlr5eDVOXZb6fgSbu4i3wL/JgReUwUyHzec/Fd9OB0OCDU9Ggjj/PmOy67YX1G10gyM6mWbKo3GX3OAuElA4DkqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NElX5x/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NElX5x/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EEC1F000FF;
	Thu, 17 Sep 2026 04:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617881;
	bh=zUMtxj9bWKViKbpNPeLaF0wY6dxdabwrnycIYkPvShk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NElX5x/Nf32EB/1y1SK8/zIU9aQL0X4tB1g9cdxsEsS0AS0gpilVQtTTMmEaz9EId
	 icilNSkl2Zb2Gp91a8WCj4s+dJdMmIPdVmvOk37sPEx0Kj+/fr7hMj7L87j0Jsl6Y4
	 X+Vv1FFWre6YP/3DgBT+ObeuwrFGhmhTra6pLJWR1EPHPfp8cluLi0C/+khlfZT6HN
	 8VeMHInd1tsrxtASaYpa9CCpWsn95JQfHnXQK1Kz3QCmLsBO6XVsrg16710tZJsY3g
	 tylEM4jbdEIJbyzXDuO0k5S3HUHsTyDeZgisdC6i5fGIAWdXDb7zINJderWzG+m56D
	 hOUGuqQW6+NdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
Date: Thu, 17 Sep 2026 00:04:37 -0400
Message-ID: <20260917040439.4163850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091603-giddily-overstate-4978@gregkh>
References: <2026091603-giddily-overstate-4978@gregkh>
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
index 230b98b3a272c..e03fa822ad33e 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1778,14 +1778,18 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 
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

