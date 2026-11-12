Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458820;
	b=muL1FWexnghyhhr1cYmhkvpra28WY62gCEzxMrpmeJ3EqViAo2W+p234glP6s+ww27NK
	 R5vaZouv5X4rBvcGxxfXJ7peeDB4zrkbpp6ub0WU3iEPrl+kBXxpUm/gyEWqN/a03xA+9
	 VRhz/DaQQ7elpLoaKwxHukWkONNl91ZKQeyH20f79eW9VR4aAJ8Jn9eCSPkRPZqUDrtLC
	 cyuA9Jx1NTRnwW10SH1sq4oQNEF6jVztPdUDzJjEfTAT86pBO+B7v1NvMs8/FEX32ysNF
	 ce+OO9Fhk2zNTVIShzOVBl0Lu4EQdIlEMWKWTEokSbg4VYmeP2f7Sili77SStU7XBfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YDdtkgR2Ax+qh2egno5L47oBgsLaxQbHxm84SkQprk4=;
	b=kFFBGyE3SPP6NkC8EgD9X8ZwB+Og/UiyzM4Mgo3UQN/aGaXbnrrwm/n12Mo5UKOFIAe+
	 ABRbNXg91A6DXIA3V8J19ESfoSIjPic/YfEJKsCpTfUcqRR281FZhFWJrVB4CIVNFFxOT
	 g43b2tGckZx11zEV/hazS043iBhox3vULsbOj0tg8Nw5N6OCt2dESzwEd6zF+kDjtPxji
	 uN+KtXi0k7uzXkf6p/dKsPPAHrvUEX0fNzif7DeTZdIy7eOcSJfI77fstD9Zth4xf5QsI
	 fPhf7d14d42vcf8Pz21E5sNSgDjnQc+7ihE+In16Ar7rpJwcD9IxN0nllPNWzBcpuvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pb0DaDcZ;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55092606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55092606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pb0DaDcZ
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so2155645c88.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458819; x=1795063619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDdtkgR2Ax+qh2egno5L47oBgsLaxQbHxm84SkQprk4=;
        b=pb0DaDcZJk+p6Dxdcd1n034vA+QRxcVhwHL4pTtzynAWvP+KDwvToMa/bBqjQtqQku
         40Y8J62Vmq4jeRJWPb94rV68eG0HnBUvvoabVgI9+bpTHtsAhqHH5Jt7rmrxPKjvafwE
         sblwNifsjJP5cXh+QhbKMgOIAbZL/yubn6FU04nHomAGAJmsBXsvy0MDApeuRqYVcY/B
         aFHRssUaXUvcZHUhobV851pp3FTNNRixrawu0eDIwkwe3eSMQD/9Mzgl4DsjpQUuw27O
         0ToYvvYiVqybXDbwVhiw9EVXIduN7gPgkzMnM0OyqzHmOHk3W/bYE3gMrnLGsDmmskrf
         BZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458819; x=1795063619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDdtkgR2Ax+qh2egno5L47oBgsLaxQbHxm84SkQprk4=;
        b=WTDWkUQw4bzCOhESNghiBtWm2o4p5p2du/gEAJXn0y4lQr8iyU0Nxg4j8DCokzk990
         H94pfXBesEdFWAaGvCRbwPheX2jAix1A2GIuZ2bvhKWoItD9VMMjGgdRLd0jSikWbjyW
         clpp/OtN1QD8cslwGfOY491Dy+mH/Yw9gwkhilmsHfp6q9d5mghqVEV8kZVwqOeIsVAq
         DqCSdOkFJjrdLXJbKwGcBa2MC9VqqZsZ1EcxZj/r/tYdzuh7u9jT9KzehSpJy1EJSpji
         Q0jCz1oNjM2vBw8aha0P0VwvdNEyZNtXk4dNt5pio/dS91zx2K2sEZuTAoxu4Om/Iuv4
         G4QA==
X-Forwarded-Encrypted: i=1; AL+hErEdaIMAllvs1fpDKqRkz6yEE74Gk/atu8XDmeRO8cCWASm1XnEfmiKcLwo81jM+va0NJxTr7Y0=@vger.kernel.org
X-Gm-Message-State: APuU4Z88AdkLdtmV5hPdIfqYHh0yJqjfJpMn07mWauy8l2dL66jDQnag
	lk81/Rd74Js7N9Ly8UAjAaq6iYleoYSrhh+vC+vLnDsB8o8d1ws3V2/j
X-Gm-Gg: AYBFou1UBSm0qjoVSxBQOvT0aFLZOvYaI46oKMzyIIDLU+tBimbGiHGHMIkSCuzmdQ7
	z93tUnDFd29+TWh1j3BbKNnjTk9Oef/bC1nCQcHHL0ypAvKvn+7Gc8LbJ/BUqmx44quqwJc+gI7
	DqkluvMN3ieBojawGL/DiTBoOGuxO/IwnIwaL+9qHBCBg1kitvJxLCX4HCLwFF2Tq3YiUJHa5+b
	0R6oaRtreZpKkptxoVGySQex1K9sOK5hIs/qOashqITRcgW0eYjK72DSuKO0pj9iElEaSgh6tGu
	dAiTwP6Ba91l4HisZiF5drOUD22vMNTzq3/WaGq0XyDTmHWkTzfJcB+tcDrZ11GU6kLk6VG/yeW
	2EXIGl1cXFx/iULbzMPlpgmQwTi9AscdZCtEm6DhMRN1fGkjnwiYLFRZXj6rl9oPQk22FBqU7Jb
	O6Rmgh1U23vuO0edasVZnhwNfcvMWq2/QhPVP5FqJ+Ph+Al6699LE+n+3rwBwAjunwZURFtUhlH
	lWDPFaCBDqBGDtC5H+Xoab82TYA9ooD58jPxUEX4LlcBGEyv6v5Pss3erbGuHO+ldAYCEXfjcpD
	O5Wtqoou6YWFW13Nm2IHrDH+VPVUscG9lTMN+LpjO9r89p51YSAC0XfoBQ5fbsn/0+MGFr4Kknu
	83NmXq+ha6N7gDUIu2vfN4Y0j
X-Received: by 2002:a05:7022:170a:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b3c02f06bdmr3875092c88.9.1794458819457;
        Wed, 11 Nov 2026 20:46:59 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm21024827c88.12.2026.11.11.20.46.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:46:59 -0800 (PST)
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
Subject: [PATCH v5 1/8] ksmbd: verify the signature of session binding requests
Date: Thu, 12 Nov 2026 11:46:38 +0700
Message-ID: <20261112044645.4074-2-mike.michalo@gmail.com>
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

When multichannel is enabled, smb2_sess_setup() accepts a binding
request on a new connection once it finds the session and sees
SMB2_FLAGS_SIGNED, but never checks the signature: SESSION_SETUP is
exempt from the generic check in __process_request(), because
work->sess is not set for it. The request then goes through
authentication, and the response is signed with the session's signing
key, since the request claims to be signed.

So anyone who knows a SessionId and ClientGUID can open a connection
and have the server sign STATUS_MORE_PROCESSING_REQUIRED responses with
another client's session key, each with a fresh NTLM challenge and at a
MessageId of their choice: a signing oracle.

MS-SMB2 3.3.5.2.4 requires the server to verify a binding request with
Session.SigningKey and to fail it with STATUS_ACCESS_DENIED if that
fails. It does so while receiving the message, before the checks of
3.3.5.5, so do it right after the check that the request is signed. The
failure response is not signed, because work->sess is only set once the
request has been accepted.

smb2_check_sign_req() and smb3_check_sign_req() zero the Signature
field in place to compute the MAC. Restore it in both before they
return, as generate_preauth_hash() later hashes the request as received
into the channel's SMB 3.1.1 preauth integrity hash.

A session that is still being set up has no signing key yet: the key is
all zeroes until authentication completes. Refuse a binding request for
it before verifying, in both binding branches, with the
STATUS_REQUEST_NOT_ACCEPTED that 3.3.5.5 gives for such a session
(3.3.5.2.4 would answer STATUS_NOT_SUPPORTED, as the key is NULL), so
that a request is never verified against a missing key. Set
SMB2_SESSION_VALID with smp_store_release() and read the state with
smp_load_acquire(), so that a session seen as valid has its key.

The other binding branch, which rejects a binding request that is not a
valid multichannel bind, verifies the signature as well. A missing
negation on the multichannel flag made that branch unreachable for an
SMB 3.x request when multichannel is disabled: such a request fell
through to the reauthentication path instead and was answered with an
unsigned STATUS_USER_SESSION_DELETED. Correct the condition so the
request is verified and rejected there.

That branch signs its refusal of a verified request with the session's
key. An SMB 3.x connection binding to an SMB 2.x session now gets there
too, and the connection's own handler would sign with the SMB 3.x
signing key, which such a session does not have. Sign that response
with smb2_set_sign_rsp(), as is already done the other way round.

An AI assistant was used to draft the patch and as an independent
reviewer.

Reported-by: Ian Bridges <icb@fastmail.org>
Closes: https://lore.kernel.org/all/20261103171742.18816-1-icb@fastmail.org/
Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c  |  9 ++++++
 fs/smb/server/smb2pdu.c | 69 ++++++++++++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 064f99427ca6f..51aa981bcef4e 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -322,10 +322,19 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		if (work->sess &&
 		    (work->sess->sign || smb3_11_final_sess_setup_resp(work) ||
 		     conn->ops->is_sign_req(work, command))) {
+			/*
+			 * A refused binding request is answered with the key
+			 * of the session, which can be of another dialect
+			 * family than this connection.
+			 */
 			if (command == SMB2_SESSION_SETUP_HE &&
 			    work->sess->dialect >= SMB30_PROT_ID &&
 			    conn->dialect < SMB30_PROT_ID)
 				smb3_set_sign_rsp(work);
+			else if (command == SMB2_SESSION_SETUP_HE &&
+				 work->sess->dialect < SMB30_PROT_ID &&
+				 conn->dialect >= SMB30_PROT_ID)
+				smb2_set_sign_rsp(work);
 			else
 				conn->ops->set_sign_rsp(work);
 		}
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b084cca8813cc..3d9b966235dbb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2558,6 +2558,23 @@ static int krb5_authenticate(struct ksmbd_work *work,
 }
 #endif
 
+/*
+ * A binding request must be signed with the signing key of the session it
+ * binds to (MS-SMB2 3.3.5.2.4). Check it before the request is processed
+ * and before any response is signed with that key.
+ */
+static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
+					struct ksmbd_session *sess)
+{
+	struct ksmbd_session *prev_sess = work->sess;
+	int ret;
+
+	work->sess = sess;
+	ret = smb3_check_sign_req(work);
+	work->sess = prev_sess;
+	return ret;
+}
+
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
@@ -2635,22 +2652,33 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				goto out_err;
 		}
 
+		/*
+		 * A session that is still being set up has no signing key
+		 * yet, so there is nothing to verify a binding request with.
+		 * Pairs with smp_store_release() in smb2_sess_setup().
+		 */
+		if (smp_load_acquire(&sess->state) == SMB2_SESSION_IN_PROGRESS) {
+			rc = -EACCES;
+			goto out_err;
+		}
+
 		if (!(req->hdr.Flags & SMB2_FLAGS_SIGNED)) {
 			rc = -EINVAL;
 			goto out_err;
 		}
 
+		/* As part of receiving the request (MS-SMB2 3.3.5.2.4) */
+		if (!smb2_check_binding_sign_req(work, sess)) {
+			rc = -EKEYREJECTED;
+			goto out_err;
+		}
+
 		if (memcmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
 			goto out_err;
 		}
 
-		if (sess->state == SMB2_SESSION_IN_PROGRESS) {
-			rc = -EACCES;
-			goto out_err;
-		}
-
 		if (sess->state == SMB2_SESSION_EXPIRED) {
 			rc = -EFAULT;
 			goto out_err;
@@ -2675,21 +2703,23 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		conn->binding = true;
 	} else if ((conn->dialect < SMB30_PROT_ID ||
-		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
+		    !(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 		sess = ksmbd_session_lookup_slowpath(le64_to_cpu(req->hdr.SessionId));
 		if (sess) {
-			int sign_ret;
+			int sign_ret = 0;
 
 			work->sess = sess;
 			installed = true;
-			if (sess->dialect >= SMB30_PROT_ID)
-				sign_ret = smb3_check_sign_req(work);
-			else
-				sign_ret = smb2_check_sign_req(work);
-			if (sess->state != SMB2_SESSION_VALID ||
-			    !(req->hdr.Flags & SMB2_FLAGS_SIGNED) ||
-			    !sign_ret) {
+			/* Only a valid session has a signing key to check with */
+			if (smp_load_acquire(&sess->state) == SMB2_SESSION_VALID &&
+			    (req->hdr.Flags & SMB2_FLAGS_SIGNED)) {
+				if (sess->dialect >= SMB30_PROT_ID)
+					sign_ret = smb3_check_sign_req(work);
+				else
+					sign_ret = smb2_check_sign_req(work);
+			}
+			if (!sign_ret) {
 				ksmbd_user_session_put(sess);
 				work->sess = NULL;
 				sess = NULL;
@@ -2928,7 +2958,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			destroy_previous_session(conn, sess->user, previous_session_id);
 		if (!ksmbd_conn_need_reconnect(conn)) {
 			ksmbd_conn_set_good(conn);
-			sess->state = SMB2_SESSION_VALID;
+			/*
+			 * The session's keys are generated by now. Pairs with
+			 * smp_load_acquire() where a binding request is
+			 * verified with them.
+			 */
+			smp_store_release(&sess->state, SMB2_SESSION_VALID);
 		}
 	}
 
@@ -12853,6 +12888,8 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 
 	ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, 1,
 			    signature);
+	/* Restore the request as received, for the SMB 3.1.1 preauth hash */
+	memcpy(hdr->Signature, signature_req, SMB2_SIGNATURE_SIZE);
 
 	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
@@ -12972,6 +13009,8 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	iov[0].iov_len = len;
 
 	ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature);
+	/* Restore the request as received, for the SMB 3.1.1 preauth hash */
+	memcpy(hdr->Signature, signature_req, SMB2_SIGNATURE_SIZE);
 
 	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
-- 
2.43.0

