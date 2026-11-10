Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329941;
	b=lrVf1CAejdsLwtQY/a0mgVM1UvyEe3N7qAe7rOEqRDIG26tjSJgIDIeRNd01pI/m20Xo
	 8pvY5bCCeLH7L7UHLeebZxNGwjehlu/zO6vPv19Bzl3wpr7JzC9uaD7sqXCgrRKA3swZ+
	 js+oPV0HXW9Jf0LO4w+uZI8lCZeZLeWC9X2FKqszfLjbcVAS2B2jTZbpYwYtCP5Ca5TEK
	 TL3fcx8kmmQNXWoLqW1I2cJFmDJ1epnT3B8YXAsUkPXAMOWeueDzx24Vg8+xeISCVXIC+
	 fIWOqoUJpM2G/2Cfh3T5z/wzp/KC3MS/Y3WZprCVZhA90SxURYmelgcUDuKzHN2Gjpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZwRselDa1l8gKoulhCdVLjsTKJQ+34Sz7SHZBIjKDPI=;
	b=qGJSmjJfYoNdCgKm+kAusaykAdseR3xKXfqjJ7DAO4ULdQe/BoJXvL9GutHORCMu7z16
	 6UVDxYjf7sdVGuXI5xdlGFKfiVy4mEJP3gdtomBbGrgbIXW73zVykASPYfntGdE1XgNWL
	 GOIDl5rb7z8B0S76413dKNkmja742tMSRSfb2HKZnhrrnJXU5Gr+osxyPRfEgHKdCtr5s
	 idpOTgqn+HgkC+9PYRAM2oeI9RiCnrEuYzNxebG1kp8b2ROay90Nb++3BtcKeyPDGsOte
	 qLisjfxqXpaSAuKMp1MS6uB+gNQt2uYINuSRn0B5U3Rd3J19S+6TRWs5SouETADKntw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zhK0/skk";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAB606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DDAB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhK0/skk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a058315c79so1203228b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329940; x=1794934740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwRselDa1l8gKoulhCdVLjsTKJQ+34Sz7SHZBIjKDPI=;
        b=zhK0/skkvRI8hLnZNsUUEXtyBeA153mBgD6Ym9Nv4alPgU5olRbcDoeSNAOk5tJi61
         6adiuEdlS21KyvvSv4j3Dzib4Jl/7sTeGQPIVpxMPVUuV+g4rTyEYs1+otajY5cTOzXc
         FhDl/fkonzWix5Yo6rQ8OgEJjXoS1leARxLUcXA5N2iZ6TpzFL5GV9MuB8bkOVTneSV+
         BeZ+lC3/RQs70geiY9UbnQYlVXVXs/gN0Vp5UrVjyucMAuMVKxg5mVQIsdCDNEUY1NY/
         RxeF+cRN2v3ei1ImSjg44U59fMqwKOhcIobI56oQwSwLMCIV/pzCBjal+yTX/DpLXWLg
         EzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329940; x=1794934740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwRselDa1l8gKoulhCdVLjsTKJQ+34Sz7SHZBIjKDPI=;
        b=ZBRRRLYbgVBAcnciiUVA1pY3CZpM7VHWArFcwo9zoFxvUU/R/OK9f6hvzuE8K/dCsk
         UEENxn9jhF6CMzTVF6AbCh4uS0aJ0G5GVTFpaX1i96pp/gS15ew0RQj3abJ67g5JmIWN
         CJzQT6vgKCzeRW5RU3Nw8S+a1E3j5nYbdZ9vygMeGxrcaP1Y7YeNDCLEYSQqax3PZanT
         kY06avLqNJFjpXTC1K1mE0BMjcC/MemBkU+n/+fq7G7bM/JTHwCHosVoFuJW5Ep2N/1M
         YoIOiy6/Otg7tQnCFZIMKulKBu25AAYhbHz9YJVFs5NnMWJiagVxqxwz701dMXomxYL7
         0bxQ==
X-Forwarded-Encrypted: i=1; AL+hErHwdJUwWmh4qp3a57aXMy+t6YTkkOQkjWIPF5CHgWHLsbn8PWqnD4SUVDuFdreYTrxaUvSqVR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UPR9CBNUvx5fm/TXawNh6WAisk97zGk/vYsa3qd5SNJjhB4e9
	1uwv1kjsQUnBKWvTOJCbU6BKCec7wipIoFQhDC9wFD8b35o8jCtJy6Qs
X-Gm-Gg: AYBFou3l3SVDIy/yWNOHJsjTPps03QsY31aO6shqJoSkwK7/ZREOT76sUkfyUc0SNVR
	xvKkKfSjrBSX+mDEihJu0qKFVcRtPUW1vaO9Grg5JyaQY7pe75BVykU6k/gvG6MxtbDvhHfOMOe
	jtFSM+XAAYJwzzoA8xc87VQljEHnFMC93FShH/C5Q0lOhUlSikzBH5ePcEAhD9yrwJC0NHXskAZ
	Js/t3oFPbjeAiuRVkHGt20Fbbu6OL93JLpj4GYLJsKUtkJVlqtGXal3hQvNedcr+RlMhJlIfq08
	zivLHLTgzIu1BcrQ4MR+GE+TSE46qV6saxY6ZdyCtlw8055ZZKUEaOXqiVDZsYvg1+tey615VOD
	6TK/GwwCwu6zyeXtS8Rie6gSF169D6QKpB0bTRO0R8Ba5xAgiWpj8pTv49r+kYOnzcgfOQAcYAI
	5QMguKPpNzj+cgVpGXiFsjRiXzR2WYchq9UfBOCxq7ZKnWNJw9yEuorjC3QZ38Snu9+SdsTLu7n
	IamaCpLxqhutBVmtE3kL7flG/BTNLgdlhGf8SjL+woVcmlO6i3X0fO7IzkPr+lCbA8e+HfqxxUc
	vhTgv6ZSn705GAuHFXftiaj7xJiHYBrWb2pvMS0oVUvwJAjfADQB/bVO4wI+XrVyiqB6hL2qDxX
	q2cg1+freKfWakZjT+yJj6RpLA83uViHzGw3PbQ/WWAskDi4h517M8sI=
X-Received: by 2002:a05:6a00:148d:b0:873:e3b4:5d4 with SMTP id d2e1a72fcca58-8ba82b55227mr3115023b3a.2.1794329940141;
        Tue, 10 Nov 2026 08:59:00 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab4fd5c6sm1157154b3a.46.2026.11.10.08.58.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:58:59 -0800 (PST)
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
Subject: [PATCH v4 2/6] ksmbd: sign with the negotiated SMB 3.1.1 signing algorithm
Date: Tue, 10 Nov 2026 23:58:30 +0700
Message-ID: <20261110165834.28162-3-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165834.28162-1-mike.michalo@gmail.com>
References: <20261110165834.28162-1-mike.michalo@gmail.com>
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

decode_sign_cap_ctxt() stores the algorithm picked from the client's
SMB2_SIGNING_CAPABILITIES context in conn->signing_algorithm, but it
runs before init_smb3_11_server(), which then overwrites it with
AES-CMAC. As a result the negotiate response always selects AES-CMAC,
even for a client that only offered HMAC-SHA256, and every SMB 3.1.1
connection is signed with AES-CMAC.

Keep the negotiated algorithm and sign with HMAC-SHA256 when that is
what was negotiated.

Since connections of the same session can now use different
algorithms, each signing key also has to be used with the algorithm it
was created for. The session signing key belongs to the connection
that set up the session, and MS-SMB2 3.3.5.5 requires a binding
request on a new channel to be verified with it. Store that
connection's algorithm in the session and use it together with the
session key, while channel keys keep using their own connection's
algorithm.

An AI assistant was used to draft the patch and as an independent
reviewer. Testing is described in the cover letter.

Fixes: 378087cd17ee ("ksmbd: add support for negotiating signing algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/auth.c              | 14 ++++++++++++--
 fs/smb/server/auth.h              |  4 ++--
 fs/smb/server/mgmt/user_session.c |  1 +
 fs/smb/server/mgmt/user_session.h |  2 ++
 fs/smb/server/smb2ops.c           |  4 +++-
 fs/smb/server/smb2pdu.c           | 20 ++++++++++++++++++--
 6 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 0c51ca0cb14db..fc6ace49584b1 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -504,19 +504,29 @@ void ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
 /**
  * ksmbd_sign_smb3_pdu() - function to generate packet signing
  * @conn:	connection
+ * @signing_algorithm:	signing algorithm the key was generated for
  * @key:	signing key
  * @iov:        buffer iov array
  * @n_vec:	number of iovecs
  * @sig:	signature value generated for client request packet
  *
  */
-void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
-			 int n_vec, char *sig)
+void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, __le16 signing_algorithm,
+			 char *key, struct kvec *iov, int n_vec, char *sig)
 {
 	struct aes_cmac_key cmac_key __cleanup(aes_cmac_zeroize_key);
 	struct aes_cmac_ctx cmac_ctx;
 	int i;
 
+	if (signing_algorithm == SIGNING_ALG_HMAC_SHA256_LE) {
+		u8 mac[SMB2_HMACSHA256_SIZE];
+
+		ksmbd_sign_smb2_pdu(conn, key, iov, n_vec, mac);
+		memcpy(sig, mac, SMB2_SIGNATURE_SIZE);
+		memzero_explicit(mac, sizeof(mac));
+		return;
+	}
+
 	/* This cannot fail, since we always pass a valid key length. */
 	static_assert(SMB2_CMACAES_SIZE == AES_KEYSIZE_128);
 	aes_cmac_preparekey(&cmac_key, key, SMB2_CMACAES_SIZE);
diff --git a/fs/smb/server/auth.h b/fs/smb/server/auth.h
index 7ce9c42d58f1e..5a10482678ee4 100644
--- a/fs/smb/server/auth.h
+++ b/fs/smb/server/auth.h
@@ -59,8 +59,8 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 			    char *sess_key);
 void ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
 			 int n_vec, char *sig);
-void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
-			 int n_vec, char *sig);
+void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, __le16 signing_algorithm,
+			 char *key, struct kvec *iov, int n_vec, char *sig);
 int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
 			       struct ksmbd_conn *conn);
 int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 15662fd745abb..87aba04a8cbdd 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -557,6 +557,7 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 	int ret;
 
 	sess->dialect = conn->dialect;
+	sess->signing_algorithm = conn->signing_algorithm;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 	ret = xa_err(xa_store(&conn->sessions, sess->id, sess,
 			      KSMBD_DEFAULT_GFP));
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index 5f0f6276e3168..931ca102b8392 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -48,6 +48,8 @@ struct ksmbd_session {
 	u64				id;
 
 	__u16				dialect;
+	/* Signing algorithm of the connection that created the session */
+	__le16				signing_algorithm;
 	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
 
 	struct ksmbd_user		*user;
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 747276b171bd1..c5b3cf34494e7 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -320,7 +320,9 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->ops = &smb3_11_server_ops;
 	conn->cmds = smb2_0_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
-	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
+	/* Keep the algorithm chosen from the client's signing capabilities */
+	if (!conn->signing_negotiated)
+		conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_LEASING |
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 053f3eb398f5a..ddaa98055154a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1858,6 +1858,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	bool posix_ctxt_seen = false;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
+	/* A previous, failed NEGOTIATE must not leave its algorithm behind */
+	conn->signing_negotiated = false;
 	if (len_of_smb <= offset) {
 		ksmbd_debug(SMB, "Invalid response: negotiate context offset\n");
 		return status;
@@ -12953,6 +12955,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	char *signing_key;
+	__le16 signing_algorithm;
 	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature_req[SMB2_SIGNATURE_SIZE];
@@ -12972,8 +12975,14 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
+	/*
+	 * A key must be used with the algorithm it was generated for: the
+	 * session key with the one of the connection that created the
+	 * session, which can differ from this connection's when binding.
+	 */
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
+		signing_algorithm = work->sess->signing_algorithm;
 	} else {
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
@@ -12981,8 +12990,10 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 			    !(hdr->Flags & SMB2_FLAGS_SIGNED))
 				return 0;
 			signing_key = work->sess->smb3signingkey;
+			signing_algorithm = work->sess->signing_algorithm;
 		} else {
 			signing_key = chann->smb3signingkey;
+			signing_algorithm = conn->signing_algorithm;
 		}
 	}
 
@@ -12996,7 +13007,8 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	iov[0].iov_base = (char *)&hdr->ProtocolId;
 	iov[0].iov_len = len;
 
-	ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature);
+	ksmbd_sign_smb3_pdu(conn, signing_algorithm, signing_key, iov, 1,
+			    signature);
 	/* Restore the request as received, for the SMB 3.1.1 preauth hash */
 	memcpy(hdr->Signature, signature_req, SMB2_SIGNATURE_SIZE);
 
@@ -13023,6 +13035,7 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	u16 command;
 	int n_vec;
 	char *signing_key;
+	__le16 signing_algorithm;
 
 	hdr = ksmbd_resp_buf_curr(work);
 	command = le16_to_cpu(hdr->Command);
@@ -13030,12 +13043,14 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	if (command == SMB2_SESSION_SETUP_HE &&
 	    (!work->session_setup_binding || hdr->Status != STATUS_SUCCESS)) {
 		signing_key = work->sess->smb3signingkey;
+		signing_algorithm = work->sess->signing_algorithm;
 	} else {
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
 			return;
 		}
 		signing_key = chann->smb3signingkey;
+		signing_algorithm = conn->signing_algorithm;
 	}
 
 	if (!signing_key)
@@ -13046,7 +13061,8 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 
 	iov = smb2_get_sign_rsp_iov(work, hdr, &n_vec);
 
-	ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature);
+	ksmbd_sign_smb3_pdu(conn, signing_algorithm, signing_key, iov, n_vec,
+			    signature);
 	memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 }
 
-- 
2.43.0

