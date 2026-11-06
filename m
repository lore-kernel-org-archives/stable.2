Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992020;
	b=ebfVEcoAPFuJtDa58zf/c9TPRmZpvc6T9TdCPvZeDCjxvQ75yxm6jkoIyTTdEU23YuVo
	 JJT30uSazaKiczy6op27Lf1Tj6phNS+9jftLfFQpvTJ4wJWOEtc1I2Tkg03nXL57BMQ6G
	 NEl0zUEjsVx+kJgA4f5k9r1rhAKR7WJzy0tKMOEo1jcn+r5UsinEXufqS7Z8u8g6KVESc
	 Wll8NKIKbn7jLikBFO7wqC9eS/aQY99uEtR6doryDrH0jMsiUG6SlDEoqpbz+ZXgRStbP
	 OQG1PKjSpobQMtCwEEQ8zq9SaKpbVKi/mHblvHANYogteJhIIrcU67782IO4MS89UAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1K7EZP2+wHAYvCb783vqa7KQmg+bgtLN8J+Z08UbgB8=;
	b=tUjeYq9MabcjW8svdYebVF2DTt1H0zC7snJEgtEn9QeR52pdA8LvvNoykZv5ND/xLzz2
	 qshJQoVsHR3eMpT1qJ5pIJwXmS39pNho5lJ8/2COPMlYwwLvuDlxjPwfzUfrJo+6QsOFX
	 0bRqjKchmPgisPVTeqdtCsePVkZDc2nZLkO86OHtAVMbVjtpJR+ms3PZohCzPJd4I7KBU
	 XOEUxwkpHwy8kLL7x+Egtf69x+Tr4RZ4/r9XmOw00Nax/SLr6TS4uYk81ZslOYFqLWbHc
	 QDGEXYKE7IcR0Q2+m0PqcHP2O28citIZHiiIc5hJQDwAbHLpJjRYOFh2GFYjLvK1wxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkTgj0db;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9F606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF9F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkTgj0db
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so5574155e9.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992018; x=1794596818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1K7EZP2+wHAYvCb783vqa7KQmg+bgtLN8J+Z08UbgB8=;
        b=jkTgj0dbm07+TANWE6TbCW//HlGPyYd5G2qeV+KSzu2bBPxeeYPm7D8yupNcGDti5U
         3U3/jC517nFr9w04v3URH7iC9AskFCMF6/rqUhEXM+wVm9/vm48apY8+qLqeX919Kj5z
         FDlNdavqcVWbcZ/qdW2JBrRgcjDx3VjFVD3kcJSaCWi2FweyLM2Q/LrR9l7siADFutSy
         OtnhEPQpzZ6OkXE/wVYzKw2F/IOR7vNLVIyFtF80rSWc420m5qMBW9FIqEr14vELGswF
         kgI0K6EDaYc3l/ZeMv+MUXAcwbEBpVneCSkvqgIQfaIScjBIzkNQ4LpfSbRcl4dH9uTg
         e0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992018; x=1794596818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1K7EZP2+wHAYvCb783vqa7KQmg+bgtLN8J+Z08UbgB8=;
        b=gibBzlssn5PMlsrLy6r2Rx/pmnWeoln1KquJt8ie78Mp83b4RMAp2kXU5dBbS8/KOQ
         w5dWiLFBF0nrEX9CERmbpTotu1GIR0y+My3uMCE+f8EdpGAPQiqqnwnXdvgFJordynqM
         ln+6IvzfvOzssD8tgA8tRoBGkHPf5vnVWh2eeqZwVucKsec7nirOe7JxmlQT0+PI8DLW
         wWgk/OsLAhyjIIH515KhMqLC0QnDfh36EJO2iQKhT174m3diVi5CFCv1AozOej8Yw82q
         u4sRdGDD6UXSFk3+MWeEsz0BtafhNvZu3+wdR+zpsqmT3HRn75HsNU9tVzn7y30kQlmQ
         qgXw==
X-Forwarded-Encrypted: i=1; AKwUvBwHF4j40i6FIR/w3rse+AebRNipYaTcmNKIz1BG11GjXk9P5Xr21ErTycpOfmnV94eOyauG2CQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OtcQEaqwpR0qHIZuF9ADipAy2fsLdxoNLVi3kj3+0bjYfv6PZ
	el3AOx/9RcrrznpiWm2oZ/RZqKX+oRqtDAPHC5QCbsjEZTe9ua615DYb
X-Gm-Gg: AYBFou09NCS/S7Q4mPDowx3pb5wXMPKSxV7fiQpx9+H/NMsYFj1qmSNHktzn0W+eBNl
	Zp2M7qOiYKl+YxmHA12YrsstBIRSrR503wl5jxopRuoKuI6v4EgGLHb98VERvSxsaTsuRIg9u+j
	hW8Dm6oul+Gmx9rPxxTC1FAb5jmJRYMTEZ84Xdd81CaYEzN7zwtL1GZpdmNMbO0HwjLY7pVBwcP
	huwcWEqlR8lcvKLgu+n880iPasEQOc+8/hYyC3y7NOWKpK6BMuyTyalAq0n1zA8WIBlApNc7JK3
	YRm08O1A/t5zcm1AmMYWbR3a7lvMFx8i2k/MZyZxGflFocu9Y53NRVVdlfKFYy4oSYJ104g26wT
	oSMws7J/kBsfJSFjSkj02qz0aYtJgOzbMAsW3VOdvSx7qvDhi8W5bpSCKFfxBKS4vb2yHTLQVVf
	FHW5NWrUhepv6rGQr6ebIuwukDS+nvtHq0sufEc1xEz5WXuQ4Bx50K2JehCv3w1R9R/hUyN1YO0
	ZVgNisUMLAC1N1Gh48lvTfiSjJZV+hVNg9UE68IrcgU/Y2kl0MZBHPfbJcwONwVsEI6A7muE/MD
	27dF+B+iCkh/T+yjZOhd7VssAFC7s/DBlfjme6SLkaBDZ3QJsuhb5ScDhe46COzsn69kp2NTVxI
	dZvtkSqUqMp81VTM=
X-Received: by 2002:a05:600c:19cc:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4b6de4a6badmr58331705e9.15.1793992018029;
        Fri, 06 Nov 2026 11:06:58 -0800 (PST)
Received: from localhost.localdomain ([74.244.226.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4930a5a91dbsm3960533f8f.35.2026.11.06.11.06.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 11:06:57 -0800 (PST)
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
Subject: [PATCH v2 3/4] ksmbd: use the channel signing key for session setup on a bound channel
Date: Fri,  6 Nov 2026 20:06:21 +0100
Message-ID: <20261106190622.20990-4-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106190622.20990-1-mike.michalo@gmail.com>
References: <20261103171742.18816-1-icb@fastmail.org>
 <20261106190622.20990-1-mike.michalo@gmail.com>
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
binding request. Verify it
with the same helper as binding requests. Also refuse an unsigned
reauthentication of a session that requires signing, as smbtorture's
bind_negative tests expect from Windows. Do not expire the session
when either check fails, since the request did not come from its
owner.

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
 fs/smb/server/server.c  | 11 +++++
 fs/smb/server/smb2pdu.c | 90 ++++++++++++++++++++++++++++-------------
 2 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 064f99427ca6..4430c8d6393e 100644
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
index f587a76971e9..89cce31f7da6 100644
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
@@ -2577,7 +2579,11 @@ static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
 
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
@@ -2665,7 +2671,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (!smb2_check_binding_sign_req(work, &req->hdr, sess)) {
+		if (!smb2_check_sess_setup_sign_req(work, &req->hdr, sess)) {
 			rc = -EKEYREJECTED;
 			goto out_err;
 		}
@@ -2759,6 +2765,25 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		/*
+		 * A reauthentication of a session that has keys must be
+		 * signed if the session requires signing, and must verify.
+		 * The session has keys once this connection is one of its
+		 * channels, including while a reauthentication is in
+		 * progress. Do not expire the session if the check fails:
+		 * the request did not come from its owner.
+		 */
+		if ((READ_ONCE(sess->state) != SMB2_SESSION_IN_PROGRESS ||
+		     lookup_chann_list(sess, conn)) &&
+		    ((req->hdr.Flags & SMB2_FLAGS_SIGNED) ?
+		     !smb2_check_sess_setup_sign_req(work, &req->hdr, sess) :
+		     sess->sign)) {
+			rc = -EKEYREJECTED;
+			ksmbd_user_session_put(sess);
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (work->session_setup_reauth)
 			WRITE_ONCE(sess->state, SMB2_SESSION_IN_PROGRESS);
 
@@ -12982,22 +13007,24 @@ int smb3_check_sign_req(struct ksmbd_work *work)
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
@@ -13041,17 +13068,24 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
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

