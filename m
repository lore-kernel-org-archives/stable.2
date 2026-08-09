Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62951531E8
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283684; cv=none; b=fpHf1cMtveKUVaB57p2EGh0XyGgLMqJnqWltZ1bC6yxR4c9Wt+vlWK/HliG+neV82XvP1ClLA1THiyvB9AyCVlXouJceo2mqYLtSzgTJswSz85oQWjNm98HpRISS4X9gGTwooDk4IfSC1AF35qDKhZmyv7c8L6XvWhSmChop//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283684; c=relaxed/simple;
	bh=fAVDTte3C59f9ySMxF6DvVWwcK8U7V2Y8KiREFYIe+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX3s1QLZG09ZbgdyErcScQVrorgyCCNs/Q9xZ7D8iRuT+IP91Z5UW9LX8fjKuNmmDFyfLT7l92rgqbbP8ACfcGDqhve0SOETlNTbzAy/+J79w5cikfqwsNkrueGYtU+1Wc9xXQS0bZC1sJS4rYyv6gohx4lfJ67hRuXnbdU7smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asX6pQ9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asX6pQ9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C471F000E9;
	Sun,  9 Aug 2026 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283682;
	bh=IIaRljG3G6mKcJK22FZBFXxOek05K4j9s0bNQxc8Czo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asX6pQ9OOlXw43g4pGvv4ussYlL8uJAaykgjEBUxupyWw+u9p9863fWQluEUSPOCB
	 kfFngA6pwU7vlgd0+fh+CibEXfJLn6N9zzo5y04zLApDKrIfnqtbnxfHBSZz/xjgOv
	 DqeTyOT3xvsI4E4EASE/mz6WcniFvOgcSUaetB5QjMcXxta/vNhetbA2P4IeLcPssw
	 3rwMPDr3bRugutF5nfF5WHFHN8btRphQKFZMvu1XoZooz/sb5SgjONII4MNS0iOxmU
	 GRKBSz4ZdsGAAys4Mc57tsmsWNWAPhxxIXKj+x8boccCrDN/WUEqbmJrhH7u9MRGJI
	 7pnHefBNklaXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] ksmbd: rename smb2_get_msg to smb_get_msg
Date: Sun,  9 Aug 2026 09:54:37 -0400
Message-ID: <20260809135440.1507266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072926-trapped-grumbling-0f6e@gregkh>
References: <2026072926-trapped-grumbling-0f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0b444cfd8b74ebce421ccd96eac9c495e536c92e ]

With the removal of the RFC1002 length field from the SMB header,
smb2_get_msg is now used to get the smb1 request from the request buffer.
Since this function is no longer exclusive to smb2 and now supports smb1
as well, This patch rename it to smb_get_msg to better reflect its usage.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/auth.c       |  4 +--
 fs/ksmbd/connection.c |  2 +-
 fs/ksmbd/oplock.c     |  8 ++---
 fs/ksmbd/smb2pdu.c    | 70 +++++++++++++++++++++----------------------
 fs/ksmbd/smb2pdu.h    |  9 ------
 fs/ksmbd/smb_common.c |  6 ++--
 fs/ksmbd/smb_common.h |  9 ++++++
 7 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 1947edb0cd28d..cc4233c414b66 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -920,7 +920,7 @@ int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
 	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
@@ -1107,7 +1107,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(iov[0].iov_base);
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	DECLARE_CRYPTO_WAIT(wait);
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 76afa733351a2..0e04ad18c5829 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -396,7 +396,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
 				break;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index a6730fd9d76ea..78d73deb54443 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -656,7 +656,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -670,7 +670,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -760,7 +760,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -774,7 +774,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f7eeb79be48ab..49ecd359c5fe0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -46,8 +46,8 @@ static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = smb2_get_msg(work->request_buf);
-		*rsp = smb2_get_msg(work->response_buf);
+		*req = smb_get_msg(work->request_buf);
+		*rsp = smb_get_msg(work->response_buf);
 	}
 }
 
@@ -147,7 +147,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = smb2_get_msg(work->response_buf);
+		err_rsp = smb_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
 		int err;
@@ -173,7 +173,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -197,7 +197,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -223,7 +223,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = smb2_get_msg(work->request_buf);
+		rcv_hdr = smb_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -236,7 +236,7 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
 
 	work->iov_idx = 0;
@@ -259,7 +259,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	int err;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -273,7 +273,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	WARN_ON(ksmbd_conn_good(conn));
 
@@ -448,7 +448,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -499,8 +499,8 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rsp_hdr = smb_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(work->request_buf);
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
@@ -529,7 +529,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -545,7 +545,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 		    offsetof(struct smb2_query_info_req, OutputBufferLength))
 			return -EINVAL;
 
-		req = smb2_get_msg(work->request_buf);
+		req = smb_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		      req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -732,10 +732,10 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	}
 
 	in_work->conn = work->conn;
-	memcpy(smb2_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
+	memcpy(smb_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
-	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr = smb_get_msg(in_work->response_buf);
 	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
@@ -1112,8 +1112,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 int smb2_handle_negotiate(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_negotiate_req *req = smb_get_msg(work->request_buf);
+	struct smb2_negotiate_rsp *rsp = smb_get_msg(work->response_buf);
 	int rc = 0;
 	unsigned int smb2_buf_len, smb2_neg_size, neg_ctxt_len = 0;
 	__le32 status;
@@ -5570,7 +5570,7 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_echo_rsp *rsp = smb_get_msg(work->response_buf);
 
 	if (work->next_smb2_rcv_hdr_off)
 		rsp = ksmbd_resp_buf_next(work);
@@ -6118,8 +6118,8 @@ int smb2_set_info(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
@@ -6348,8 +6348,8 @@ int smb2_read(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -6766,7 +6766,7 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
@@ -6783,7 +6783,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -6804,7 +6804,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list, request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    iter == work)
@@ -7736,8 +7736,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -8405,7 +8405,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rcv_hdr2 = smb_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8430,7 +8430,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8505,7 +8505,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8641,7 +8641,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
 	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
-	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
+	struct smb2_hdr *hdr = smb_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
 	/* tr_buf must be cleared by the caller */
@@ -8680,7 +8680,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *trhdr = smb_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
@@ -8692,7 +8692,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -8733,7 +8733,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rsp = smb_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 912bd94257ecf..3dafe8cc1bb13 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1704,13 +1704,4 @@ int smb2_ioctl(struct ksmbd_work *work);
 int smb2_oplock_break(struct ksmbd_work *work);
 int smb2_notify(struct ksmbd_work *ksmbd_work);
 
-/*
- * Get the body of the smb2 message excluding the 4 byte rfc1002 headers
- * from request/response buffer.
- */
-static inline void *smb2_get_msg(void *buf)
-{
-	return buf + 4;
-}
-
 #endif	/* _SMB2PDU_H */
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 0438a634f4c21..537733ee82c06 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -163,7 +163,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn)
 	if (conn->request_buf[0] != 0)
 		return false;
 
-	proto = (__le32 *)smb2_get_msg(conn->request_buf);
+	proto = (__le32 *)smb_get_msg(conn->request_buf);
 	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
 		pr_err_ratelimited("smb2 compression not support yet");
 		return false;
@@ -259,14 +259,14 @@ int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count)
 static int ksmbd_negotiate_smb_dialect(void *buf)
 {
 	int smb_buf_length = get_rfc1002_len(buf);
-	__le32 proto = ((struct smb2_hdr *)smb2_get_msg(buf))->ProtocolId;
+	__le32 proto = ((struct smb2_hdr *)smb_get_msg(buf))->ProtocolId;
 
 	if (proto == SMB2_PROTO_NUMBER) {
 		struct smb2_negotiate_req *req;
 		int smb2_neg_size =
 			offsetof(struct smb2_negotiate_req, Dialects);
 
-		req = (struct smb2_negotiate_req *)smb2_get_msg(buf);
+		req = (struct smb2_negotiate_req *)smb_get_msg(buf);
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index c4978579c5412..62b6367dc2572 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -512,4 +512,13 @@ static inline void inc_rfc1001_len(void *buf, int count)
 {
 	be32_add_cpu((__be32 *)buf, count);
 }
+
+/*
+ * Get the body of the smb message excluding the 4 byte rfc1002 headers
+ * from request/response buffer.
+ */
+static inline void *smb_get_msg(void *buf)
+{
+	return buf + 4;
+}
 #endif /* __SMB_COMMON_H__ */
-- 
2.53.0

