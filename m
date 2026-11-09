Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253332;
	b=aWAzKMtDw3w/GsghOfy1Q/YNs+y0vckqyxF+cTfU9+RMYpCVKmVhZW2viA08iU9UbDSs
	 mXbCXEIoLC2r1CmILjqxdENw+RaouvwI3jl5OelIZoGox5omqOFQfkqflc4y2VPVb3dKl
	 7W3y0trQvpztdn8X/hkUV0I5BjpepMVcN+RSLEMfUj4xDc8dQFk2O/c2/+pX4TA7jR8Pi
	 ReHkjAvZeIi1q4APPXF53TA1UpGI0FsGExj6nWeK/AKdEq46Q3aAqDQkwnzTGOfVau1jv
	 T0VXJDWcPd0V4xIzeGCr81Hw1G3SfwneWNh13KU/2cE9q4Glpr4VDjt8TF2cs/Sm6JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PUPl+ApB+9u+qzt/i8jIifMeFEhVOmG0DXWj1SviarY=;
	b=jG3eQNz1OAj3HCmzz5jvBUKAQhT6uTkW5y99KZPt3j21yDlaMGAW7Xxw+3ndZQ1XGLRv
	 M+5dZ0tPETjlgOObv4NFUo32pv+NfS76KqbqmnbG0jzKqDdmJOc7ewF2MDbzyh9Qth8Xo
	 HyGi8hnCJjvvx/Vhp/9A6htq67IkNUjOOe4hnhq3/Ngl9rnGlhXTWeIar3hWwVuuuqwL3
	 JgUtfkefUdik+4wKPGYMoXfxclU8PnC9ghyalpWdGmeyW3xMrbvD6TK3pMFCHGn+nRKt0
	 7Ss9aaCf1HL/aLyXHNCy/S86M+R78SVVS2D3rQwLd66jOTCP2E+wbi6FSSYS6QTKsHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEVCFL4+;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702B606A33C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5702B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEVCFL4+
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e98798cbddso5944575ad.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253332; x=1794858132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUPl+ApB+9u+qzt/i8jIifMeFEhVOmG0DXWj1SviarY=;
        b=dEVCFL4+3tO2YlMLJynyvigzSYs/Fb+ZFdqJUQqskUFWU77fPvBBNuXFD2d7DK21Om
         2tkoYd3KpzG5u5LpXm/Khp2jNiJAdaNbqlgaH37U6HQX9fVKc9+lwK05TFZ2revLSdUi
         YPh7AAUE6CW+058Lo31F9YaET89BW2gvWw66mvtl7GIZp4mLVyDWxTU6369CVSb48hrD
         humlF5YQRAtoxbR8oRVOT7dYk7E947eKMWzCZiIaFDOrAEWujiPSqrVD/OKVIOzTGsg1
         7iDtYueD93EjuQcAG6AQ9SMTBTt8uTUMmwCDm1tjaCJMp6n6kkItdUotqV5zlhLIJmGG
         ojiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253332; x=1794858132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUPl+ApB+9u+qzt/i8jIifMeFEhVOmG0DXWj1SviarY=;
        b=t3Xygmof7UBVKSZwAYo/bQYrAtax4h5s0qGiUf4UUp6iFE4rP/O8hCD3sCQRs2g9Kj
         YBVw1hwgIsITXTKSNMiI6C06w4Gl6XlyAuhSTTtKVZD1tuVZFlRBl79qUEGqogdkSzTz
         CIwkNoMDRx+JoTSLQhkYOG0cla1vcaRU2UQ65U06448XpPh2X6WLqAvX5d/eJEOPVPPC
         rW3+aqcvLpLYirRKlGqPLpTc/j0QVe6sJqETaPlar/l2idBdmdaRVNBojZ0yduIOsDM7
         2hqrCkdFeL9ASR1BUHTmlf71AMUvVnmPQo4M47P/QQmOwP/Lg5g03JiiSfuSouVVuOG0
         liUA==
X-Forwarded-Encrypted: i=1; AL+hErHsdPbpdd2DkDdhiBsfo8MxIgZVzmB6AZEwBLbtAYtdJltsIjVrBHhqxfb+g8bw+7JaFHSVGcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DXoyMZ2WcTfTADHOdcgAHuD69kYS2K/AL7bp/cBHUxA4hu7ev
	0TmZ64g6cmAqf+eUPLeka/BJAXKNg/btWxfGSdD8HcMbKmDAXDNAAv4R
X-Gm-Gg: AYBFou19lIVlDIfjXSXOqf/TitcgoMaVxlagqJ8w4/+XWcOrwgM6AukijRDeo5JL18I
	rlm4PtXD5T7FQbWvF8mZ7V2DiqfncwzQv59Y1a7sAV9Ct7JRhePiN18j70b677U5pDr+2JLH51v
	9ip0N0UPLcJEDiQQW1JvDzI1RZmnK40wHXIy6GmsoGS1PEZeRQrDZSNX/vFviz4Bi3qCegpKD8Z
	73hL9olqKH4/5AxQxMXnEYjdnDMhHs9NEia5jGe/x2xqX7Z5wHAON9l2sPV3q7H8I/c/k+wl6HV
	YmgCxQ+MFd4sb+9ulAMmIfEfr74vGgHIdvR2smWQHSqBtf988PFTRKbVdjquX4UJfn75RXd6MdZ
	REHSlBb4N6LXwo1RnT1h/g6yRQLV2y3TS8M9LbaakKkjeomGMFfmgWytabFJIv51xU7tbDwGehE
	D/GLb6kikXERE8G/NxOOpV6HXLFlirNHtqUcYTjJUL7ALzVO58IcdN/Opjzd2bOqtlkMmY8WxxC
	gWWfilUFes/64caViaGt2CWx4g/aiJoig9yV2sGqcaEIXcEH82usiO25YJWWPKB21pzYVxVOgZC
	oxQtYqIT2oZ7UU55C508Pb8SMPn4CrgvvsDv2DwpEunttDRqSID8GIlHtP8wCj1cSHSVjunGNTM
	85JmikrHxVmV7ySaXZL4H6kM9+nLpUMqeYry9n/NVul0Hy/umHS4WlgI=
X-Received: by 2002:a17:902:cec1:b0:2ed:18cc:d3b3 with SMTP id d9443c01a7336-2edb8d6f270mr1644585ad.6.1794253331652;
        Mon, 09 Nov 2026 11:42:11 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm1388585ad.13.2026.11.09.11.42.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:42:11 -0800 (PST)
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
Subject: [PATCH v3 3/6] ksmbd: use the channel signing key for session setup on a bound channel
Date: Tue, 10 Nov 2026 02:41:41 +0700
Message-ID: <20261109194144.22814-4-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194144.22814-1-mike.michalo@gmail.com>
References: <CAKYAXd-Jo-ObBDs-AdGfaM+QmDsot3gj1g0oJiyDKczoUDg2TA@mail.gmail.com>
 <20261109194144.22814-1-mike.michalo@gmail.com>
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

smb3_check_sign_req() and smb3_set_sign_rsp() always use the session
signing key for SESSION_SETUP. That is right for a binding request and
its non-final responses (MS-SMB2 3.3.5.2.4, 3.3.5.5.3), but a
reauthentication sent on a channel that is already bound is then also
verified and signed with the session key instead of that channel's
key.

Use the session key for binding requests, for their non-final
responses, and for SESSION_SETUP on a connection that is not yet a
channel of the session. Use the channel key for everything else on a
channel. Samba does the same. MS-SMB2 is ambiguous here: 3.2.4.1.1
has the client sign any session setup with Session.SigningKey, while
3.3.5.2.4 has the server verify non-binding requests with
Channel.SigningKey.

The signature of a reauthentication was not checked at all, because
SESSION_SETUP is exempt from the check in __process_request(). A
reauthentication of a live session with a forged signature therefore
got STATUS_MORE_PROCESSING_REQUIRED signed with the session key, with or
without multichannel: the same kind of signing oracle as an unverified
binding request. Verify it with the same helper as binding requests.
Also refuse an unsigned reauthentication of a session that requires
signing, as smbtorture's bind_negative tests expect from Windows,
unless the request is encrypted. A session that negotiated encryption
has sess->sign cleared even when the connection required signing, so
take that and enforced encryption into account too; merely having
negotiated encryption is not enough, since clients such as the Linux
one always offer it and then send unsigned, unencrypted requests. Do
not expire the session when a check fails, since the request did not
come from its owner.

For a SESSION_SETUP that is not the first command of a compound,
__process_request() already checks the signature and zeroes the
Signature field, so the new reauthentication check then failed. Restore
the field after that check.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c  |  11 ++++
 fs/smb/server/smb2pdu.c | 115 ++++++++++++++++++++++++++++++----------
 2 files changed, 98 insertions(+), 28 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 064f99427ca6f..4430c8d6393e9 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -150,7 +150,18 @@ static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
 	}
 
 	if (work->sess && signed_req) {
+		struct smb2_hdr *hdr = ksmbd_req_buf_next(work);
+		char signature[SMB2_SIGNATURE_SIZE];
+
+		/*
+		 * check_sign_req() zeroes the Signature field. Restore it:
+		 * smb2_sess_setup() checks the signature of a SESSION_SETUP
+		 * again and adds the request as received to the preauth
+		 * integrity hash.
+		 */
+		memcpy(signature, hdr->Signature, SMB2_SIGNATURE_SIZE);
 		ret = conn->ops->check_sign_req(work);
+		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 		if (!ret) {
 			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
 			return SERVER_HANDLER_ABORT;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index af1e7aac4ded1..7d107a61626ad 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2561,15 +2561,17 @@ static int krb5_authenticate(struct ksmbd_work *work,
 #endif
 
 /*
- * A binding request must be signed with the signing key of the session it
- * binds to (MS-SMB2 3.3.5.2.4). Check it before the request is processed
- * and before any response is signed with that key. The Signature field is
- * restored afterwards, because SMB 3.1.1 adds the request as received to
- * the channel's preauth integrity hash.
+ * SESSION_SETUP is not covered by the signature check in __process_request(),
+ * because work->sess is not set for it. A binding request must be signed
+ * with the signing key of the session it binds to (MS-SMB2 3.3.5.2.4), and a
+ * signed reauthentication with the key of the channel it arrives on. Check
+ * them before the request is processed and before any response is signed
+ * with that key. The Signature field is restored afterwards, because SMB
+ * 3.1.1 adds the request as received to the preauth integrity hash.
  */
-static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
-					struct smb2_hdr *hdr,
-					struct ksmbd_session *sess)
+static bool smb2_check_sess_setup_sign_req(struct ksmbd_work *work,
+					   struct smb2_hdr *hdr,
+					   struct ksmbd_session *sess)
 {
 	struct ksmbd_session *prev_sess = work->sess;
 	char signature[SMB2_SIGNATURE_SIZE];
@@ -2577,12 +2579,37 @@ static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
 
 	memcpy(signature, hdr->Signature, SMB2_SIGNATURE_SIZE);
 	work->sess = sess;
-	ret = smb3_check_sign_req(work);
+	/* The key, and so the way it signs, belongs to the session */
+	if (sess->dialect >= SMB30_PROT_ID)
+		ret = smb3_check_sign_req(work);
+	else
+		ret = smb2_check_sign_req(work);
 	work->sess = prev_sess;
 	memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 	return ret;
 }
 
+/*
+ * Whether a reauthentication of @sess must be signed or encrypted. A session
+ * that negotiated encryption has sess->sign cleared even when signing was
+ * required on the connection, while encryption itself is only enforced when
+ * configured, so check what the session actually requires. Merely having
+ * negotiated encryption does not count: clients such as the Linux one always
+ * offer it, and then legitimately send unsigned, unencrypted requests.
+ */
+static bool smb2_sess_needs_protection(struct ksmbd_conn *conn,
+				       struct ksmbd_session *sess)
+{
+	if (sess->sign)
+		return true;
+	if (!sess->enc)
+		return false;
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+		return true;
+	return sess->user && !user_guest(sess->user) &&
+	       (conn->sign || server_conf.enforced_signing);
+}
+
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
@@ -2665,7 +2692,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (!smb2_check_binding_sign_req(work, &req->hdr, sess)) {
+		if (!smb2_check_sess_setup_sign_req(work, &req->hdr, sess)) {
 			rc = -EKEYREJECTED;
 			goto out_err;
 		}
@@ -2759,6 +2786,29 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		/*
+		 * A reauthentication of a session that has keys must prove it
+		 * comes from the session's owner: a signed request must verify,
+		 * and a session that requires signing or encryption must not
+		 * accept an unsigned request unless it is encrypted, since
+		 * encryption has already authenticated it. The session has
+		 * keys once this connection is one of its channels, including
+		 * while a reauthentication is in progress. Do not expire the
+		 * session if the check fails: the request did not come from
+		 * its owner.
+		 */
+		if ((READ_ONCE(sess->state) != SMB2_SESSION_IN_PROGRESS ||
+		     lookup_chann_list(sess, conn)) &&
+		    ((req->hdr.Flags & SMB2_FLAGS_SIGNED) ?
+		     !smb2_check_sess_setup_sign_req(work, &req->hdr, sess) :
+		     (!work->encrypted &&
+		      smb2_sess_needs_protection(conn, sess)))) {
+			rc = -EKEYREJECTED;
+			ksmbd_user_session_put(sess);
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (work->session_setup_reauth)
 			WRITE_ONCE(sess->state, SMB2_SESSION_IN_PROGRESS);
 
@@ -12982,22 +13032,24 @@ int smb3_check_sign_req(struct ksmbd_work *work)
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
@@ -13041,17 +13093,24 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
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

