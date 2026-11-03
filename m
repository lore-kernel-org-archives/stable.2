Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741894;
	b=yc280oyWFmE7Jq9wrnDQ8/RuebWwpOT4XyycYNp0LqQCbnPUz5X1Jo5ExNWqPWz0hLGT
	 l79ZSkd+ZSh1vFhV1vo/y2Fh/D1h5WB0d44a7yNroawrF2PU8Ty5OtelUBJCtITpc9Ydf
	 vSARODLrG/w6vZ643slLdT/tO+8YbNWQV57mY7YRXCcHqJYw8RebiFW87wiqKvUiOxuc+
	 8+/OVDvsVrhSRc6Ov7Qgn9YXkT9SDBd/tyXGg+FmqjBh1OA4AzTjNPVYTVxVIBltfXmzw
	 CdczC7IvPeydy1iMytpj4ixn5ghaQmgjYIuhSwhxhZPRnOrKDETXsz46KN8SuW+D3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1RYo1R4Q1MwFPyxITCOquBrdl575/3iD61Z5xv4ZBNk=;
	b=NZecVbwwETwMEwUSq1tiyFQgnG5Hc+UdS8GVfMAnthkMrriupy7yjVgO4tyEvXpcp/2T
	 pa+FOyXlmfCyjDZBszvQm+H0NpdZ84ctsrA/LWh6fP89cGp2lZwEtKvYLGfGBAFUQQleG
	 b6UtCff7MtnaY/W7dOjzx1P3oAj0UzQdr0CatxIPaJ7hayxOWwvWcGWfAtENNlypRaqOL
	 cVLy9YwTg9nfshbjikgD8uboLV1E5aQk/e4DKXz0PnEg+ZHyX+/W1AsimRRdsj40dQJDl
	 Ij5DN09xeg7pPj68XUqL9ier+m/CGT3NBvYnag1rld/o4/pmpwgyonc7vbgetgGZloA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGcctCzV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DD606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGcctCzV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1537F1F00919;
	Tue,  3 Nov 2026 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741893;
	bh=1RYo1R4Q1MwFPyxITCOquBrdl575/3iD61Z5xv4ZBNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGcctCzVi1Cka4ZJsNna39gw8m8mY2v+GySl9XWWUjQMChO5G/4iUFs+ZVxqgjx8/
	 Y8pE3MbHE9Zx0DhbBoYYpJmSXJCJm7//Rp455lKOmpfSp/Y8oA2CDcPPPZHj3jOWTC
	 Cacrj+nNKGPmu9HERSTDYwt7IJ5sFmemkEVfi/MeXon6PLpLGx4qX3f4oR1OMRu8fC
	 Nk2uIkJfUyeQtiLjthZSeraX7EeS/TfLhk8yG41eM+yxtPXBLqGXEHUG/TR4iddexc
	 25OlMcKcsnRzWsyMldfaqK/4WShpYYWGnMgyqf1u5sgmrHlfyb6FoUr9nfKErOeEcv
	 KDRjgsM10jXmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: verify transform SessionId matches the decrypted header
Date: Tue,  3 Nov 2026 16:38:12 -0500
Message-ID: <20261103213708.1421521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110343-kosher-bleach-17a4@gregkh>
References: <2026110343-kosher-bleach-17a4@gregkh>
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
[ sashal: Placed session validation directly after decryption because the intervening decompression code is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/server.c  | 16 ++++++++++++
 fs/smb/server/smb2pdu.c | 54 +++++++++++++++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.h |  1 +
 3 files changed, 71 insertions(+)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 85f14d1cc0cd3..ba625b52c6375 100644
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
index 793c219b9a610..80e7b2532f968 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9414,6 +9414,60 @@ bool smb3_is_transform_hdr(void *buf)
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
index 6833342407013..23abb70ea5d3d 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -441,6 +441,7 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess,
 void smb3_preauth_hash_rsp(struct ksmbd_work *work);
 bool smb3_is_transform_hdr(void *buf);
 int smb3_decrypt_req(struct ksmbd_work *work);
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);
-- 
2.53.0

