Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C243C9EF0
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200914; cv=none; b=tCXgE3CrmgBQq2+71ivPCXeM3Hi7fNreHGzt6j99SEBSbVYQne2uRgDN1Um28SoMec/QJJ7kMJQDNo6KlU2n3AYn3Uv/0EY3yywdIjqcX1PXCXcdpnPaRr0QzbYp/uDYazFEUJcjKspdHi/IEQ4aSQub0bH+4/1Mryyp0SqKsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200914; c=relaxed/simple;
	bh=SJYrsBRzphXVwWuWj31XNSvBt+2FYPKJcHths7bexkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVjguEBjpeVVh4zgmnwQM016X0CfFFMhjNtSZTbblluJwfCYxpvEigLhEWqYRjOo+6LGjN+ffl0PU0t89fqZNlcuf160qdutwzJ3UauYX3TtXBkj8EC7IKUusPp4eg7z5JdhPgZyoxHsR7Qnnbv97CL+71+vbsTcwd8XQoVMnYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZbB6idr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZbB6idr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6853E1F000E9;
	Thu, 16 Jul 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200912;
	bh=4W8fM8VyIXyBZFQC2/d4TwbraB79hZ5coCtgefMwhzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZbB6idrCR7oV0LAcqBhBB0DzzKHUnh9Eigogkj5dVNhqH43kJSI2iYT51+/ZcCYH
	 CVm8w7sSUpbR8WeWNO2zg5ItK6NqAr1F+ZX6ftdm88RyLtQxO8uyY5TD5wikc//vU1
	 efx3UfL4NOmWWcGot3gAKA71u1qBe/fASsxOG0h2HzzOyGJkjbxCUXiZe0Q+0GrLa0
	 B8hrGJiscnIT+x6ntt4fbAI25yjEDuBiIWItw0ikdQn572ws2jJwTwMWUKvtJEXdOq
	 lekv0P9uIqfG7cRCjvBX8natDLAsOm9Zc0Kp58rhsauDlICAUouK9PIfjoII3JDYO/
	 MZa7P7NKdY4UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] ksmbd: validate NTLMv2 response before updating session key
Date: Thu, 16 Jul 2026 07:21:47 -0400
Message-ID: <20260716112147.1735816-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112147.1735816-1-sashal@kernel.org>
References: <2026071427-follicle-footprint-220e@gregkh>
 <20260716112147.1735816-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

[ Upstream commit 954d196bebb2b50151cb96454c72dc113b2af1ac ]

ksmbd_auth_ntlmv2() derives the NTLMv2 session key into
sess->sess_key before it verifies the NTLMv2 response.
ksmbd_decode_ntlmssp_auth_blob() then continues into KEY_XCH even
when ksmbd_auth_ntlmv2() failed.

With SMB3 multichannel binding, the failed authentication operates on
an existing session and the session setup error path does not expire
binding sessions. A client can send a binding session setup with a
bad NT proof and KEY_XCH and still modify sess->sess_key before
STATUS_LOGON_FAILURE is returned.

Relevant path:

  smb2_sess_setup()
    -> conn->binding = true
    -> ntlm_authenticate()
       -> session_user()
       -> ksmbd_decode_ntlmssp_auth_blob()
          -> ksmbd_auth_ntlmv2()
             -> calc_ntlmv2_hash()
             -> hmac_md5_usingrawkey(..., sess->sess_key)
             -> crypto_memneq() returns mismatch
          -> KEY_XCH arc4_crypt(..., sess->sess_key, ...)
    -> out_err without expiring the binding session

Derive the base session key into a local buffer and copy it to
sess->sess_key only after the proof matches. Return immediately on
authentication failure so KEY_XCH is only processed after successful
authentication.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: f9929ef6a2a5 ("ksmbd: add support for key exchange")
Cc: stable@vger.kernel.org
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/auth.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 35e9cb63abcd77..a778275207fe78 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -142,6 +142,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
+	char sess_key[SMB2_NTLMV2_SESSKEY_SIZE];
 	struct hmac_md5_ctx ctx;
 	int rc;
 
@@ -164,12 +165,21 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	/* Generate the session key */
 	hmac_md5_usingrawkey(ntlmv2_hash, CIFS_HMAC_MD5_HASH_SIZE,
 			     ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE,
-			     sess->sess_key);
+			     sess_key);
 
 	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
-			  CIFS_HMAC_MD5_HASH_SIZE))
-		return -EINVAL;
-	return 0;
+			  CIFS_HMAC_MD5_HASH_SIZE)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	memcpy(sess->sess_key, sess_key, sizeof(sess_key));
+	rc = 0;
+out:
+	memzero_explicit(ntlmv2_hash, sizeof(ntlmv2_hash));
+	memzero_explicit(ntlmv2_rsp, sizeof(ntlmv2_rsp));
+	memzero_explicit(sess_key, sizeof(sess_key));
+	return rc;
 }
 
 /**
@@ -226,6 +236,8 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
+	if (ret)
+		return ret;
 
 	/* The recovered secondary session key */
 	if (conn->ntlmssp.client_flags & NTLMSSP_NEGOTIATE_KEY_XCH) {
-- 
2.53.0

