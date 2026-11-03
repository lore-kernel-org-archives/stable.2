Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750337;
	b=tHJAYGlN6rfzXs0N5o53FdT76S5GnoW+8RBjhMptXD/kRNU4g0XcVF57g6lBxA4hU7+N
	 okrJwMeJyv4gzasb8a3OFqUajoicAcvgeS0zvc8nkAfSTBDa68SEM//U4VYSR3viAwkrf
	 sDll5h+A8As/38JPjVqIMCBA4EN6azlkDvKTAaQscWRnuqvbUj4IapkB+Zadcvn3ASiyt
	 OULPZ+JKr04KvNP9/1Y1daFNZWFzptetW2w1J1NrBuI8wyIP+hFmaieG5+Ua85Z2nl1+H
	 YJ+0SaXp4ShoZonkNnS3Eh9mNwiyZiDQ/j0j0ekWOxzhHq2+0ZJsZOWgUEiXmIah9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OvP34PtnbUo1Z9Wi6BEtBc0YUbLHKYoeUlozyrUtdzs=;
	b=5bZN49L8seCuoBZ65Rjy5bHVih14mENU7O0i9zBtH/uWroJjw0KAhSA9W5nPPiBml3rU
	 DkB4HAROTKhc2ciW5qunm3bYUsg3wpbqYrgqgVl25JASPvEvqxd/fcLcMKPs0kp5oTZhA
	 sw+YP6lCcRJAMlTGv/89ZT2WjmE3HfBlvE1lqQ17LWB5EJ9+Xwze2tCkvBLil00VrCVV9
	 sid/FAo3/E5epOmLCAzAq5zV8QqDsdWeAJHP0j8qEMwp+XOInV1CnlTAo2PGg2DkXFYFx
	 JifOmvhaKh0ixG3Sds/gfGDYdBRO8Lj9cyJ0uKX+ZbRDg9/g3xNWA0Hs0YsrQWFD1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmyOnsTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20A606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmyOnsTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB1E1F00919;
	Tue,  3 Nov 2026 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750337;
	bh=OvP34PtnbUo1Z9Wi6BEtBc0YUbLHKYoeUlozyrUtdzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmyOnsTBae/cmaaL1gAI8A9GSJwuB1AT+HEoUBzjCC0F9B+gE///+V7AXSfSvydZX
	 /gxhxmb2tPpmh8IVJl3/KxoafIWbo0BJHqvVABV0g4G1Q2rbVSI3r+LhCtnHo/WUuZ
	 TD5kShYwCiJtSWllAuclcxNLgEvjpsfFoPzZVIUC2LjLptuNpwb2cN1siEurJm3cBy
	 Wi512eLVJ2+XzdXg6lyUl0J6W/mpRj4UEt0kUvNIfPqQs8tKZsmq2vNRVYvIJ6zBqS
	 7v4TiumdH2dWx9crkJ5dZfji9Y0BEO3cTd5O2NrHwLuVmsuolWejmwxxnTq53quwVr
	 6mzyhWunWcEWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: verify transform SessionId matches the decrypted header
Date: Tue,  3 Nov 2026 18:58:55 -0500
Message-ID: <20261103235758.1654847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110344-unguarded-nimble-eff6@gregkh>
References: <2026110344-unguarded-nimble-eff6@gregkh>
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

From: Dairui Zhang <zhangdairui@gmail.com>

[ Upstream commit 798214e6fafcdcc29f5ba2661a473232b5e70cfb ]

When an encrypted request comes in, the decryption key is picked by
the SessionId in the transform header, but the request is then
authorized under whatever session the decrypted inner header names.
Nothing ever compares the two, so on a connection with more than
one session a client can get a request decrypted with one session's
key and run it as another session. Encrypted requests are exempt
from signing too, so a valid AEAD tag is the only proof of session
identity, and it is checked against the wrong session.

MS-SMB2 says the server must check that the transform SessionId
matches the one in the decrypted SMB2 header and treat a mismatch
as a protocol error. Add that check in __handle_ksmbd_work() after
decryption, before dispatching: the message has to be at least one
fixed SMB2 header, the first operation must not set
SMB2_FLAGS_RELATED_OPERATIONS and its SessionId must match the
transform SessionId, and every following non-related operation in
a compound chain must carry the same SessionId. NextCommand
offsets must be 8-byte aligned and stay inside the message; the
bounds check is done by subtraction so it cannot wrap.

When the decrypted payload is a compression transform, the
existing decompression step runs first and the decompressed SMB2
message is checked instead, since a compression transform header
carries no SessionId.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: placed the transform session check after the existing work->encrypted assignment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/server.c  | 16 ++++++++++++
 fs/smb/server/smb2pdu.c | 54 +++++++++++++++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.h |  1 +
 3 files changed, 71 insertions(+)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 0746a9f45fb5c..0f1889d34740b 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -169,12 +169,28 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
+		u64 tr_sess_id;
+
+		if (get_rfc1002_len(work->request_buf) <
+		    sizeof(struct smb2_transform_hdr)) {
+			ksmbd_conn_abort(conn);
+			return;
+		}
+		tr_sess_id = le64_to_cpu(((struct smb2_transform_hdr *)
+				smb_get_msg(work->request_buf))->SessionId);
+
 		rc = conn->ops->decrypt_req(work);
 		if (rc < 0) {
 			ksmbd_conn_abort(conn);
 			return;
 		}
 		work->encrypted = true;
+
+		rc = ksmbd_check_transform_session(work, tr_sess_id);
+		if (rc < 0) {
+			ksmbd_conn_abort(conn);
+			return;
+		}
 	}
 
 	if (conn->ops->allocate_rsp_buf(work))
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..8f1324b3ba0be 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9342,6 +9342,60 @@ bool smb3_is_transform_hdr(void *buf)
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
 
+/*
+ * The decryption key is selected by the transform SessionId, but
+ * the request is authorized under the session named in the
+ * decrypted SMB2 header. Per MS-SMB2 the two must match, so check
+ * the decrypted message and its compound chain before dispatch.
+ */
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id)
+{
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
+	size_t msg_len = get_rfc1002_len(work->request_buf);
+	size_t off = 0;
+	bool first = true;
+
+	if (msg_len < sizeof(*hdr)) {
+		pr_err_ratelimited("Decrypted message is smaller than SMB2 header\n");
+		return -ECONNABORTED;
+	}
+
+	for (;;) {
+		u64 sid = le64_to_cpu(hdr->SessionId);
+		u32 next;
+
+		if (first) {
+			if (hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) {
+				pr_err_ratelimited("RELATED_OPERATIONS set on first operation\n");
+				return -ECONNABORTED;
+			}
+			if (sid != tr_sess_id) {
+				pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+				return -ECONNABORTED;
+			}
+			first = false;
+		} else if (!(hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) &&
+			   sid != tr_sess_id) {
+			pr_err_ratelimited("SessionId mismatch in compound chain\n");
+			return -ECONNABORTED;
+		}
+
+		next = le32_to_cpu(hdr->NextCommand);
+		if (!next)
+			return 0;
+		if (next % 8) {
+			pr_err_ratelimited("NextCommand %u is not 8-byte aligned\n", next);
+			return -ECONNABORTED;
+		}
+		if (next > msg_len - off - sizeof(*hdr)) {
+			pr_err_ratelimited("NextCommand %u is out of the message\n", next);
+			return -ECONNABORTED;
+		}
+		off += next;
+		hdr = (struct smb2_hdr *)((u8 *)smb_get_msg(work->request_buf) + off);
+	}
+}
+
 int smb3_decrypt_req(struct ksmbd_work *work)
 {
 	struct ksmbd_session *sess;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 07ae4c0e1491d..00c239b1440ed 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -467,6 +467,7 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess,
 void smb3_preauth_hash_rsp(struct ksmbd_work *work);
 bool smb3_is_transform_hdr(void *buf);
 int smb3_decrypt_req(struct ksmbd_work *work);
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);
-- 
2.53.0

