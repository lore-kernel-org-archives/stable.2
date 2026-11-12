Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458832;
	b=Y+11aLz0Dq2nr1MylWtqr6nFjPhqp0ZKp4+I1UF2N8aotT5OY+LT755dig6HT6tqnPT/
	 qGHhLemERQp0n0v2M+TU5KNyhFvsL56ODCzySdZLU+b7ncctDtEFWUJou8zhAFBh09jSP
	 Rjr8CLMYToGH704pjN1DBZVsc4c+gQ4Pjxbtdsmo50ec2he/PG+HaTY+Tgiqi0Y12SXjm
	 CK7wIrFT433Cd/3M8vzBSbvOvxE6tWPuBR5iJbUIfLFmuto/O1EjXnD1hhJ+f44nVf0/A
	 9sHdKK9Y5ppCjXsq02BLerZu8zlmvg1zkGambNVLSWq/reXK31F8PNNKnTN5oeVK5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HDFx2pg4f7Slu2eztLk/kGd0GFHbbPhuhMmkf6+waT4=;
	b=IvPl55aQhbXTdW9VxU6pZ5s0ygIKYakLb82L6bXECRHi/DdyffsfQJ6jqVcZXYCrj9O8
	 wPRf9UlIgnY5OVANy2jf6xnz0O+s1RWmnHEfqtSPiCzBaR/lso/mzNVZ0hFoaUdq7dXpn
	 /QdUrYPwQf/Jjmj5ACx6hyF+OMmhjE6looZsl8AzMBk+qnqJ85HiBIOgyY/Ehq1uE90J+
	 cI+Al10r74dyrS/L7nH90VwKJl22xgtRD05nDJpwvmvJoKNaZ6zT4fFqDWAWoV2OUCBCz
	 UPbfAoBwurRtoHqefKnMTU6YfyWUtlaSl4++E5xvdMTjL0w2H+kBvMKxXclarEjeEdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkIA7TsY;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD0606A336
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FD0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkIA7TsY
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37600b0db49so441029eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458831; x=1795063631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDFx2pg4f7Slu2eztLk/kGd0GFHbbPhuhMmkf6+waT4=;
        b=WkIA7TsYgk5IkCPqLgtdQO9IrRH0ZW1ud0KjTQYhlKuF1VZfpCbIN21Y//l0s4lOkd
         QEfh0M1mXiv/cL/1WbTtGTz5eZ5bg3Y3/j/f9SdB1Dj74WzMzlw3p+PpbdLfXYJQdpwK
         v+jFgxvlCpNALM9DZffV9GYTAjtIj3pko39zOA8Ygq+JfuKXdjKA4tPCzkeGk3pOR/jq
         mG/SDCvw0YCqn4FBvH/v3HPgHwVWvV64suphJ1KH/tpTg5VqYjkztLlC1xZKIcEgs0/+
         nDkkG8D70D26EwQJO0A2U5k0q05mr1fXn9rIZshAdq+EGd+Jj2/g9k2Q2L6EloIlnYc/
         fi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458831; x=1795063631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDFx2pg4f7Slu2eztLk/kGd0GFHbbPhuhMmkf6+waT4=;
        b=vKQhZqSjlDpf24A22O44/rgM6pEo6MbhPIfZTInJ5TX+o5wg4JlLUvw1mT2R2Q4x8k
         8msri7NmVmJ/IW+CHJLAmbM251FML6ALyJprKOAwzMjeSDJbhj+eJxZrWsNIXVTYN9mv
         vC+0oy/+cAlOKu7OU/tujhaBYBhhxayAtIP2YsPw39xjGw/Sn9O+WgInAidkK0wuv6t8
         NW9oGpWdx68U4oL1xvFD92poyewqbPELC++V6PK59mqCpjfdVjxtgJqIDggkpXelRZ9w
         RBSSoVp5nAeGoKhtMK2UD3yR9empqgD9X5zUvOh8hlseveCFcKVM9bCrcrM2tcO8Am8n
         CZCA==
X-Forwarded-Encrypted: i=1; AL+hErHdBYV1000aeM1zggtmE63gWTOMYqTdJh0hXnSFtiB3k6G0F/5QS8nDiF7F3p4UHASPVieRWJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NSVdgKVCb12l2yZqftyBUQyLGbfHJsTv+kPGAReq+0cy7Oixb
	FHhgiW5Y6h7l0cTA6sWc30dlUT3NNfI5UV3cTSYvJmCxhsGS3lGosvbt
X-Gm-Gg: AYBFou0bv1DInCq4GGdvnuLwqNwwm+GL+kFNzSlR9Ze4w/+XlNKi7+S06zzChhBvmrJ
	Xrsy8uT58gCHLptI4WUgaAOsMvJJ0YtrSyx/rAtM2n0BECBhZXh/HlW3STpTX9Aa/Yxpd3nwzgx
	r6r1gBCRev7YU08D13ywg4nR1bVrJdUY9gjV5nkDRgMkCfgIv0zyvgHLwoXwgs9jPCp3Y/y7cXF
	Y2v+wdYv4koAhEV/7k3ukcmFc3bHN8AKEkNiINIdLnQ6Yzh7XhQgPfNLQZvTi72uju8y5QRGmf6
	lEliYZA6tYYq44wriGn52ozoonNOlsrZmV7c0LOacwSNhb/do1shOsWBEJcoUu05Fvl/fwdWfbT
	GrCzU03j/E3smvFzhl9q+FrjuMyBMRuj5GQQesTWNy1K2o5PIwopvLIVx9MIA7JQd4Snf3jCv7L
	OAndPNZWrG8dRPDO7NNP2U3C4rQtGVqRERphfZ4aYtS07mFyjPa81GKkOuESlJ32cwdak+uLpfX
	0gBFDdpYRDTg2pxA6MN9gyFE96zBppgH1bLkfy3Y137xUt8NjQ4LU2sSVCVPjwxlAs/JK9yclb0
	qWloYbQ/7JYAH/bn2kKirJW/wJQQLaUPJSbpXr6czkRDICMhBS3y3LDqrs0QsY8g4nl5UHXZcZU
	1cfbYrVeKqV26DIwFxqiK1hbn
X-Received: by 2002:a05:701b:4544:10b0:1ab:9742:e860 with SMTP id a92af1059eb24-1b4f5f67318mr1281955c88.20.1794458831076;
        Wed, 11 Nov 2026 20:47:11 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm21024827c88.12.2026.11.11.20.47.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:47:10 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: icb@fastmail.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	ematsumiya@suse.de,
	lsahlber@redhat.com,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/8] ksmbd: use the channel signing key for session setup on a bound channel
Date: Thu, 12 Nov 2026 11:46:40 +0700
Message-ID: <20261112044645.4074-4-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112044645.4074-1-mike.michalo@gmail.com>
References: <20261112044645.4074-1-mike.michalo@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb3_check_sign_req() always uses the session signing key for
SESSION_SETUP, and smb3_set_sign_rsp() does for every SESSION_SETUP
response but the final one of a binding. That is right for a binding
request and its non-final responses (MS-SMB2 3.3.5.2.4, 3.3.5.5.3), but
a reauthentication sent on a channel that is already bound is then also
verified and signed with the session key instead of that channel's
key.

Use the session key for binding requests, for their non-final
responses, and for SESSION_SETUP on a connection that is not yet a
channel of the session. Use the channel key for everything else on a
channel, as the Samba client and smbd do. MS-SMB2 does not give one key
for a reauthentication on such a channel: 3.3.5.2.4 has the server
verify the request with Channel.SigningKey, while 3.2.4.1.1 has the
client sign it with Session.SigningKey. 3.3.4.1.1 has the server sign a
SESSION_SETUP response with Session.SigningKey unless its status is
STATUS_SUCCESS, and 3.3.5.5.3 the final response of a non-binding
session setup too. The two keys only differ on a channel that was bound
to the session, and that case has not been tested against Windows.

The signature of a reauthentication was not checked at all, because
SESSION_SETUP is exempt from the check in __process_request(). A
reauthentication of a live session with a forged signature therefore
got STATUS_MORE_PROCESSING_REQUIRED signed with the session key, with or
without multichannel: the same kind of signing oracle as an unverified
binding request. Verify it with the same helper as binding requests.
Also refuse an unsigned reauthentication of a session that requires
signing, as smbtorture's bind_negative tests expect from Windows,
unless the request arrived encrypted on a session that uses
encryption. A session that negotiated encryption has sess->sign cleared
even when signing was required when it was set up, so remember that in
sess->sign_required and take it and enforced encryption into account
too; merely having negotiated encryption is not enough, since clients
such as the Linux one always offer it and then send unsigned,
unencrypted requests. Do not expire the session when a check fails,
since the request did not come from its owner.

The checks apply to every session that has been authenticated before,
which is one that has a user, including while a reauthentication of an
expired session is in progress.

smb2_sess_setup() copied conn->binding into
work->session_setup_binding after its error path had cleared it, so the
response to a failed binding request was signed and added to the
preauth integrity hash as if the request had not been a binding one.
Copy it before that.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/mgmt/user_session.h |   2 +
 fs/smb/server/smb2pdu.c           | 118 +++++++++++++++++++++++-------
 2 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index 931ca102b8392..423f0a10315af 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -59,6 +59,8 @@ struct ksmbd_session {
 	unsigned int			flags;
 
 	bool				sign;
+	/* signing was required at setup; sign is cleared with encryption */
+	bool				sign_required;
 	bool				enc;
 	bool				tearing_down;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d15024d34f3d6..7b07108a48c15 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2406,8 +2406,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 
 	if ((rsp->SessionFlags != SMB2_SESSION_FLAG_IS_GUEST_LE &&
 	     (conn->sign || server_conf.enforced_signing)) ||
-	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED)) {
 		sess->sign = true;
+		sess->sign_required = true;
+	}
 
 	if (smb3_encryption_negotiated(conn) &&
 			!(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -2510,8 +2512,10 @@ static int krb5_authenticate(struct ksmbd_work *work,
 
 	if ((rsp->SessionFlags != SMB2_SESSION_FLAG_IS_GUEST_LE &&
 	    (conn->sign || server_conf.enforced_signing)) ||
-	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED)) {
 		sess->sign = true;
+		sess->sign_required = true;
+	}
 
 	if (smb3_encryption_negotiated(conn) &&
 	    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -2561,22 +2565,47 @@ static int krb5_authenticate(struct ksmbd_work *work,
 #endif
 
 /*
- * A binding request must be signed with the signing key of the session it
- * binds to (MS-SMB2 3.3.5.2.4). Check it before the request is processed
- * and before any response is signed with that key.
+ * SESSION_SETUP is not covered by the signature check in __process_request(),
+ * because work->sess is not set for it. A binding request must be signed
+ * with the signing key of the session it binds to (MS-SMB2 3.3.5.2.4), and a
+ * signed reauthentication with the key of the channel it arrives on. Check
+ * them before the request is processed and before any response is signed
+ * with that key.
  */
-static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
-					struct ksmbd_session *sess)
+static bool smb2_check_sess_setup_sign_req(struct ksmbd_work *work,
+					   struct ksmbd_session *sess)
 {
 	struct ksmbd_session *prev_sess = work->sess;
 	int ret;
 
 	work->sess = sess;
-	ret = smb3_check_sign_req(work);
+	/* The key, and so the way it signs, belongs to the session */
+	if (sess->dialect >= SMB30_PROT_ID)
+		ret = smb3_check_sign_req(work);
+	else
+		ret = smb2_check_sign_req(work);
 	work->sess = prev_sess;
 	return ret;
 }
 
+/*
+ * Whether a reauthentication of @sess must be signed or encrypted. A session
+ * that negotiated encryption has sess->sign cleared even when signing was
+ * required when it was set up, which sess->sign_required remembers, while
+ * encryption itself is only enforced when configured. Merely having
+ * negotiated encryption does not count: clients such as the Linux one always
+ * offer it, and then legitimately send unsigned, unencrypted requests.
+ */
+static bool smb2_sess_needs_protection(struct ksmbd_session *sess)
+{
+	if (sess->sign)
+		return true;
+	if (!sess->enc)
+		return false;
+	return sess->sign_required ||
+	       (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION);
+}
+
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
@@ -2670,7 +2699,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		/* As part of receiving the request (MS-SMB2 3.3.5.2.4) */
-		if (!smb2_check_binding_sign_req(work, sess)) {
+		if (!smb2_check_sess_setup_sign_req(work, sess)) {
 			rc = -EKEYREJECTED;
 			goto out_err;
 		}
@@ -2761,6 +2790,29 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		/*
+		 * A reauthentication of a session that has keys must prove it
+		 * comes from the session's owner: a signed request must verify,
+		 * and a session that requires signing or encryption must not
+		 * accept an unsigned request unless it arrived encrypted on a
+		 * session that uses encryption, which has already authenticated
+		 * it. The session has keys once it has been authenticated and
+		 * so has a user, including while a reauthentication is in
+		 * progress. Do not expire the session if the check fails: the
+		 * request did not come from its owner.
+		 */
+		if ((READ_ONCE(sess->state) != SMB2_SESSION_IN_PROGRESS ||
+		     sess->user) &&
+		    ((req->hdr.Flags & SMB2_FLAGS_SIGNED) ?
+		     !smb2_check_sess_setup_sign_req(work, sess) :
+		     (!(work->encrypted && sess->enc) &&
+		      smb2_sess_needs_protection(sess)))) {
+			rc = -EKEYREJECTED;
+			ksmbd_user_session_put(sess);
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (work->session_setup_reauth)
 			WRITE_ONCE(sess->state, SMB2_SESSION_IN_PROGRESS);
 
@@ -2843,6 +2895,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	}
 
 out_err:
+	/* The error path clears conn->binding; response processing needs it */
+	work->session_setup_binding = conn->binding;
 	if (rc == -EINVAL)
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 	else if (rc == -ENOENT)
@@ -2949,7 +3003,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 	}
 
-	work->session_setup_binding = conn->binding;
 	if (authenticated) {
 		/*
 		 * Draining the previous session drops srv_mutex. Finish using the
@@ -12991,22 +13044,24 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	 * A key must be used with the algorithm it was generated for: the
 	 * session key with the one of the connection that created the
 	 * session, which can differ from this connection's when binding.
+	 *
+	 * A binding request, or a SESSION_SETUP on a connection that is not
+	 * yet a channel of the session, is verified with the session key. A
+	 * request on an existing channel, including a reauthentication, is
+	 * verified with that channel's key, so that the session key is not
+	 * used at the MessageIds of another connection.
 	 */
-	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+	chann = lookup_chann_list(work->sess, conn);
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE &&
+	    (!chann || (((struct smb2_sess_setup_req *)hdr)->Flags &
+			SMB2_SESSION_REQ_FLAG_BINDING))) {
 		signing_key = work->sess->smb3signingkey;
 		signing_algorithm = work->sess->signing_algorithm;
+	} else if (chann) {
+		signing_key = chann->smb3signingkey;
+		signing_algorithm = conn->signing_algorithm;
 	} else {
-		chann = lookup_chann_list(work->sess, conn);
-		if (!chann) {
-			if (le16_to_cpu(hdr->Command) != SMB2_SESSION_SETUP_HE ||
-			    !(hdr->Flags & SMB2_FLAGS_SIGNED))
-				return 0;
-			signing_key = work->sess->smb3signingkey;
-			signing_algorithm = work->sess->signing_algorithm;
-		} else {
-			signing_key = chann->smb3signingkey;
-			signing_algorithm = conn->signing_algorithm;
-		}
+		return 0;
 	}
 
 	if (!signing_key) {
@@ -13052,17 +13107,24 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	hdr = ksmbd_resp_buf_curr(work);
 	command = le16_to_cpu(hdr->Command);
 
+	/*
+	 * Responses to binding requests, other than the final one, are signed
+	 * with the session key (MS-SMB2 3.3.5.5.3), as is any SESSION_SETUP
+	 * response on a connection that is not yet a channel. Everything else
+	 * on a channel, including a reauthentication on a secondary channel,
+	 * is signed with that channel's key.
+	 */
+	chann = lookup_chann_list(work->sess, work->conn);
 	if (command == SMB2_SESSION_SETUP_HE &&
-	    (!work->session_setup_binding || hdr->Status != STATUS_SUCCESS)) {
+	    (!chann || (work->session_setup_binding &&
+			hdr->Status != STATUS_SUCCESS))) {
 		signing_key = work->sess->smb3signingkey;
 		signing_algorithm = work->sess->signing_algorithm;
-	} else {
-		chann = lookup_chann_list(work->sess, work->conn);
-		if (!chann) {
-			return;
-		}
+	} else if (chann) {
 		signing_key = chann->smb3signingkey;
 		signing_algorithm = conn->signing_algorithm;
+	} else {
+		return;
 	}
 
 	if (!signing_key)
-- 
2.43.0

