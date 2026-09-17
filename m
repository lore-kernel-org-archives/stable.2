Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0D38F935
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617278; cv=none; b=q2LFvicmX4bczTx5h7Rq/qlCaL9mKeui4tgWGDFrh+SzMStoacgpX8TFlbDUmxYc3TRNfkzLsKWUZZm5Jz6x8y3pVDNfffFkbfGfmQgXDH/Q9A4qOSqs7Uar3b/HnATDEcaNADrc10BI+apbpHttAndaasrXMjEI3JHjHt5F0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617278; c=relaxed/simple;
	bh=1M8Gxbv2wuijoRvkjkn/4BSugwE5ttV+78dphQgF/E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drHiwJCaqkYbTNxAJ/y8Ln8R0712i8aQjZzVKP3RwnpMho653Zavvd0n1BmvzIkrxwMeF8FAunL0zsnFsK75BGL8hsx2knCifyh7u5jLWdP3PkBSomNfmbkf1paILHtNFglQWpf6S/aJA6qolPKXG7dOZ78gc61zBE6fk8ARqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjN9MpAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjN9MpAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68651F00898;
	Thu, 17 Sep 2026 03:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617275;
	bh=naqfuWM/Oc1e6S9ELTK+XbjL05LqoywGbFUVWInVHM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AjN9MpAvEUoWjPBDCp1PswXWaAmDnidgi6K1ocDwoF4/btBTbRb3WEnAodRHZpi4t
	 6D5li+79J5zeOMm+IO9xk18mrV906QfnXaVLTUWjDJHY613BOrFx2+xlD1v5UT+UPI
	 aaQ/CKtNV7VMl/In3V9M9cRC6f2jMDk6v0lardrmkmvpjdsajnVnDK9SFnH24OK8V8
	 OsPmfTO8bPsxTXFcq1P4/HGX+NpJdTOrDRV/1eKT8Wb+8KKzDBs+7qqXGBMOcQ95GN
	 NHaQQBiKRYxYxv1hWzoUFMBw1Gkc0hACTl8xSgJESXAXkPGrLCVxjs7OrbjvPzk75T
	 A7eSTsRoC1t3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
Date: Wed, 16 Sep 2026 23:54:31 -0400
Message-ID: <20260917035433.4114718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091601-untagged-squatter-778d@gregkh>
References: <2026091601-untagged-squatter-778d@gregkh>
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
index 92ee03cd01b39..7864d9f3b7053 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1779,14 +1779,18 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 
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

