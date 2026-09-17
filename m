Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2E37C91B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617501; cv=none; b=KOOofdF4rfZZEUP0HhJIW/X3jpTkOCJ/MxCeBurGiiZdTAnEiY9NUVax2DsjMagJnUGUFux7hViFv7VeJzEsoyEGeByYW229pkIZ3EEBdqXtKDkh7CaXW9/Rhsp2m8HzJ4Jo82N3I+5E/mMr0Vtne8K1KPgzNH43r8nF089wxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617501; c=relaxed/simple;
	bh=jSFrj2sOHj+PTsYyudi/RSdx5mvNPSehloLhoNdabYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkdfUKm8O1t3YjuMK8LbX5eAfhQ0WzEsh87+oftLaSU9vFB7uI0E1X6VQmOlAKmiJB4O2Js60+8DuaZO7F9EI2Sz0kMZokku3y09XYaleNSg6huLhwkCfvX/SSHjcP29tOlMWzygC24PdjKqkUGo4QPsUXyX1ypTNQhpqzk85Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9r5UQOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9r5UQOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C191F000FF;
	Thu, 17 Sep 2026 03:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617500;
	bh=zUMtxj9bWKViKbpNPeLaF0wY6dxdabwrnycIYkPvShk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9r5UQOzZOcFhoybLuUg4EhnKZnr7diWqrx7pXmiH8ib3cgCbatGOVP+oLtEvjWxR
	 EqZJqQR9IT/v6151UeG6Eqp6XEV8G26JTLyzeA5GEibkmsAsmB/tjbaLh2OZ5h45iT
	 ZKjsxniptCu84qEhGYwWUf1e7/CrMHN6MUcCyVTlY1q/+AMSYtbHVGLaPP1HByU6V0
	 jP2Mh09Z9PZRS0SrddyaBxKbc3brafQEXfpO8TCXUuzGA+QVprIaBtKTEHUOt/8QWa
	 IX9+i6xrpbtqbt1lgwUedfX+diY4onYRFNnnnpNIflDT1pwJu+punmjbPDMAWO6J6S
	 ES3+vLxHW+D3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
Date: Wed, 16 Sep 2026 23:58:16 -0400
Message-ID: <20260917035818.4126527-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091602-staging-palatable-a0c1@gregkh>
References: <2026091602-staging-palatable-a0c1@gregkh>
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

