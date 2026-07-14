Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1E3D9DD7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039985; cv=none; b=tq7Qh6CFi0p5UG+fLPs3U4SYYqJdfvlUGOO5GL08uZWoTIj+X1R0ak/1SKISDd8ACdzCqLGyfRGG3OfyC1HwY6HLO6Sqfpig7TPSkTbjDgHYHuggVI1fQfr1hIEOlJkAXwuJ0k+aiWED7SnrDiiOLy4YHAXvj57mdyis09X3BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039985; c=relaxed/simple;
	bh=QUfWLxYnrTatekuzlfrvHj4mSABHQM3uQTD3LIOER+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bwc/EaAGcNuHdJ3MBXSmcRUOeWgdomuQTDbi9jPuzUOHZyO4avCQBpIXgiwPKPrKbyUmeyCc6TDeyxiGmAoSExdSrXfeMAplq0kJGR6bNj6zaSQe+vRaDzZK08hKoQQ/azxAY5KxOR3HcG2rlfKflAjxV5peIMlvpSPUyTkTQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqvo/2o2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zqvo/2o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A8D1F000E9;
	Tue, 14 Jul 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039983;
	bh=xLtyv03InINs8JuCZY199wOxZESv96LQoTyu0hVIiC0=;
	h=Subject:To:Cc:From:Date;
	b=zqvo/2o2GR/ldz3nfSkewpH5E/iZSS2gdevlodPKEsQIMXd/p3Cs+GBupTZYrORZg
	 nOA1KGyy/S+tVi4bkiepZwJU0OaxQCAsGi0qAQRo1JAJwV1+ZKw/b0rG7PylpZtkhI
	 ZgmyZkXhuVsAOPVK3ibEyM5G0tTwnSYY1HjBZ+FM=
Subject: FAILED: patch "[PATCH] ksmbd: validate NTLMv2 response before updating session key" failed to apply to 6.6-stable tree
To: lihaofeng@kylinos.cn,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:39:28 +0200
Message-ID: <2026071428-stays-dinghy-8521@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 954d196bebb2b50151cb96454c72dc113b2af1ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071428-stays-dinghy-8521@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 954d196bebb2b50151cb96454c72dc113b2af1ac Mon Sep 17 00:00:00 2001
From: Haofeng Li <lihaofeng@kylinos.cn>
Date: Tue, 23 Jun 2026 09:30:26 +0800
Subject: [PATCH] ksmbd: validate NTLMv2 response before updating session key

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

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index e99409fa721c..86f521e849d5 100644
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

