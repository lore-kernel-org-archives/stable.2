Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3A569F0C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653737; cv=none; b=rqKW0LOoIVxwY4Nn7UcAQ3ugoYBphDOE+YgfG5e4l6oh5e7AzpkmDgHTAxjU1C5c6lizms28u1vIpEnSvoD+mJpDVQ06Tb9PwIVg+02ZFwk7WhsV8+AiVgSaKJZIcjlEpB8pU5B65NH2eqmJ7uR3Q0fOKn0cKydfO4/8B3Ipshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653737; c=relaxed/simple;
	bh=1AVVhosBLGZpwwPckkWbbBFBj6NMrxhLLFhGdWzthQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8pAIzhd0REuT3dzLvMroikMQTVFNiaYVgMglZd2vR3wYC2WlXuP88c438IlwET3KjJzFkNqh+4VnacfUDvNiFAk63rYp96Vn2Nrx/xGtECW8Xu3OIksRen6wQY1JJrG1s1AwG2RVoqZxwmj3+K+lPyXmVSvGncafO4uB5BupZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiaKR6IK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiaKR6IK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E81F0089B;
	Thu, 17 Sep 2026 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653735;
	bh=GK39aeIOaTWvKreqvW5CA76HBnNgQuLT3PyqP2GVeas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CiaKR6IKp38BX5IlibErYUjrERnw2ozt78WmTBt4Hq5wtHB0AGxFm5Y2lMMjdo/IG
	 IlKmiD2kGS6oq4jZkV+uW4ZCBxsdR2RrOVpfzErauFooFGH2t7Z68GoMR4NlKkUJBp
	 6u1z6WeVNF8Q29AdDAclcc2QRYPy4Oaeb27LzT0zXs3G4i30WmZeaeCUjIAiKQ0cgh
	 zU2wGEbuK5suK5zgOcxLj+bW0J8bahNO8a/XPb5FjHIoz3dZ/4i78OJvKSJ26ddqFE
	 XwCk+hefO1A+ty49N26UKFEF54dcr5lYZLGop2oGF/omzAC6B1uGnp0Eeu0AGVmywT
	 gyrn+RA+O3Jrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
Date: Thu, 17 Sep 2026 10:02:09 -0400
Message-ID: <20260917140211.506490-2-sashal@kernel.org>
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
 fs/cifs/cifsacl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bb6aaf518f425..4e7ac1c4e5af0 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1770,14 +1770,18 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 
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

