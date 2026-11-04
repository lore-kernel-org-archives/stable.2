Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795486;
	b=irZ1Yx0gW8hAVNHolxGArQn4JzKrx3JaTJ5gN40X5f/CwBjbtNJ5sZD+1BMN/lsaxp8R
	 DZ+jWjNtujTCtkGCH7PxD7GhXZmLRoCJeYKTefAfZBhw+TvAA12OU4iYu+J2YdpTzke3h
	 qcRAG6gWlQjsgFwl6eBQBUMkpJ2E97MCeIWqSgrDaJ+NIOs5R/rF4vM0N4TlVn858J7dt
	 kRcaQm7zRpx0AVAAzbRjb1IxP6A3EI+yvjvgOhsSJjDesa8r1WswBh+AoscA8/acRsmPD
	 5H6G2EeDAgOTKenDaApfNXv0OHqZEFAUGsBoIAHkS8C6WKwD9LqHkQJDtM3RhbXplpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hiigXn1+Y0gyM4wI6sI9spwgKhzHeQjn+bks85MPoyw=;
	b=bQAXsSCI+VEv4kM54hKxL+FB+oi/CIF9o6s5RRJvgcocynvalz7MV1OktTOTRHNtdwEH
	 jWNOhXLwvNSGNTuEmS26GFUszwphd1RlLETmU05c9vQ82HuNyiQfUGtHiN9hwaRxfw34a
	 zUov+cyw6Pk1aGeBrS1FpZSqvkoQZnnsmr45WbYR/K3RdVukVGd5eayQKK+LAb1H6dJlT
	 vwsMbkUEcwQAiU38dgnwsO9PTfoT3tLBzjflMRK6AlS7nGkrCqWi9WikldjYdKgjkCUFo
	 GBXW9x/2/5lM+MCHxNR6Ed0pLelCvvF9qBU39xpUpom559DF6aKdc2joPedkWJ7QUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7GcqGrv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB4606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7GcqGrv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A931F00919;
	Wed,  4 Nov 2026 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795486;
	bh=hiigXn1+Y0gyM4wI6sI9spwgKhzHeQjn+bks85MPoyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7GcqGrv1ny0YN3cXeFNkE7kkd9InErTyxXS3zKTdZLLo1G0O4sp/MCu5xnavhPEH
	 LWPcyt9cMkctZRjdnkJphWbwVQoVst3YXBO3QfpeXy9+57P3gIvgoPwNmygb9Z4y2H
	 RJQGUg4zTkD/Mkj5ojuV4nSAcs/qWGL6c4iNCAm1G0ntQTWxSUB4g6btQ57ivw1nDo
	 Yljn4UE/bxzkQKgeqQGd7c5q0eTNTugBxEjlxle+jp7Z2tacsgoja1fMjpCvo13A7H
	 WIxLAGqFSSbR3Vhwrzz1elxTTjEiBs0eM0SQTYcs1tT/+wffWyG5rYwUehcIGCW99G
	 Sw15HD73WFcqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: verify transform SessionId matches the decrypted header
Date: Wed,  4 Nov 2026 07:31:24 -0500
Message-ID: <20261104123051.2624370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110338-directed-skinhead-7051@gregkh>
References: <2026110338-directed-skinhead-7051@gregkh>
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
[ sashal: replaced unavailable ksmbd_conn_abort() calls with ksmbd_conn_set_exiting() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/server.c  | 16 ++++++++++++++
 fs/ksmbd/smb2pdu.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/smb2pdu.h |  1 +
 3 files changed, 71 insertions(+)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 275eeace4ba13..cc3d985b4b314 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -169,10 +169,26 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
+		u64 tr_sess_id;
+
+		if (get_rfc1002_len(work->request_buf) <
+		    sizeof(struct smb2_transform_hdr)) {
+			ksmbd_conn_set_exiting(conn);
+			return;
+		}
+		tr_sess_id = le64_to_cpu(((struct smb2_transform_hdr *)
+				smb_get_msg(work->request_buf))->SessionId);
+
 		rc = conn->ops->decrypt_req(work);
 		if (rc < 0)
 			return;
 		work->encrypted = true;
+
+		rc = ksmbd_check_transform_session(work, tr_sess_id);
+		if (rc < 0) {
+			ksmbd_conn_set_exiting(conn);
+			return;
+		}
 	}
 
 	if (conn->ops->allocate_rsp_buf(work))
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..59f8698562fec 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8752,6 +8752,60 @@ bool smb3_is_transform_hdr(void *buf)
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
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 3dafe8cc1bb13..9ea3e3437dbf6 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1674,6 +1674,7 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess,
 void smb3_preauth_hash_rsp(struct ksmbd_work *work);
 bool smb3_is_transform_hdr(void *buf);
 int smb3_decrypt_req(struct ksmbd_work *work);
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);
-- 
2.53.0

