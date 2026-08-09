Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCD3264C4
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249229; cv=none; b=EEjEp2yLQIKft+dAvQIz3LCY1DQsah9zIqKM10ieKJyecDsYo6Xb5xQ/JiTgc/1WJAhtpt4nkeFFljVBgnx41EW6X5PfR8+NNGCj4FGQP+eWFfMmy2Xa8Uq1fK2Ab7LdvWKbwH/pc1c/4SNv1xHx5K3b7vtBdyzAh0w+UwC6tGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249229; c=relaxed/simple;
	bh=h2AROmQ5CWTGncw8WoHh2YtCWGOzIz1zKVHvMWIT47I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzCHXkkoTU4J/qfgKxSIRE94Sf8mXB+ugbVfZeNRjpVN8BpW27uV5owVVJCkO34lMHDDzvYAeaomU0BpiqXUktAHeT/Z7fTd6ESSFhjVPDNaN7ILrW201giLyxmmWxFgb0ogF1LJgYO21S5AS+RIqwkNjlXoQ6E6yHcFjd2LtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg6i+3U5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg6i+3U5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C4C1F00A3A;
	Sun,  9 Aug 2026 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249227;
	bh=li4eb3vV7EJziISZdoutYme868PU/vgazhBMJcGW9YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eg6i+3U5/i1nbKEGf+jQy8T5aijE8WTTxm/egKe3BCV6rIoL1foKuncTnUuu/9QNy
	 +aYyQiqXSz3wlI/z+FSYxREMcRhUOJsg7BlnijqpOZ47hjxtujY5ByqINN8mmDnu5N
	 Gtl81YA8D+p65Ii6awdWVHm1O+61PPi+ac/mjDzfn3MzCXNvWISWqLZABM7d+x+H4C
	 Y0q3WEdI0oRry5fLeDBxchB+3gMQimXdYXM0KnORwqrCkc43WFxDBK13rwjBrt+82O
	 myz32glVMiVN6TCtMqY+jGPNh6vucjHuOG2tD9HcDuMzkfJ16NAKpyewC7xaoaftA1
	 VYsRsEw2OdswQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ksmbd: rename smb2_get_msg to smb_get_msg
Date: Sun,  9 Aug 2026 00:20:21 -0400
Message-ID: <20260809042024.1093624-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809042024.1093624-1-sashal@kernel.org>
References: <2026072925-revenge-tabasco-bcf9@gregkh>
 <20260809042024.1093624-1-sashal@kernel.org>
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
 fs/smb/server/auth.c       |  4 +--
 fs/smb/server/connection.c |  2 +-
 fs/smb/server/oplock.c     |  8 ++---
 fs/smb/server/smb2pdu.c    | 70 +++++++++++++++++++-------------------
 fs/smb/server/smb2pdu.h    |  9 -----
 fs/smb/server/smb_common.c |  6 ++--
 fs/smb/server/smb_common.h |  9 +++++
 7 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 38e0eb27bad53..6509814770938 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -914,7 +914,7 @@ int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
 	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
@@ -1101,7 +1101,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(iov[0].iov_base);
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	DECLARE_CRYPTO_WAIT(wait);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 2c90eec592f36..2fb2f900f02a0 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -396,7 +396,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
 				break;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9af7c55a3fd7a..2414e103b79e3 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -671,7 +671,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -685,7 +685,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -775,7 +775,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -789,7 +789,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8ea6d4ce3a1f1..866a0533bff55 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
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
 
@@ -447,7 +447,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -498,8 +498,8 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rsp_hdr = smb_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(work->request_buf);
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
@@ -528,7 +528,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -544,7 +544,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 		    offsetof(struct smb2_query_info_req, OutputBufferLength))
 			return -EINVAL;
 
-		req = smb2_get_msg(work->request_buf);
+		req = smb_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		     req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -731,10 +731,10 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
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
@@ -5605,7 +5605,7 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_echo_rsp *rsp = smb_get_msg(work->response_buf);
 
 	if (work->next_smb2_rcv_hdr_off)
 		rsp = ksmbd_resp_buf_next(work);
@@ -6171,8 +6171,8 @@ int smb2_set_info(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
@@ -6398,8 +6398,8 @@ int smb2_read(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -6817,7 +6817,7 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
@@ -6834,7 +6834,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -6866,7 +6866,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list, request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    iter == work)
@@ -7811,8 +7811,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -8494,7 +8494,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rcv_hdr2 = smb_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8519,7 +8519,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8594,7 +8594,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8730,7 +8730,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
 	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
-	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
+	struct smb2_hdr *hdr = smb_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
 	/* tr_buf must be cleared by the caller */
@@ -8769,7 +8769,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *trhdr = smb_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
@@ -8781,7 +8781,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -8822,7 +8822,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rsp = smb_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 59e3de95961c1..6011fca980456 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -525,13 +525,4 @@ int smb2_ioctl(struct ksmbd_work *work);
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
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 2850802f4a508..648b23103b8c5 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
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
 
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 7f44537b73281..d4291834b04f1 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -426,4 +426,13 @@ static inline unsigned int get_rfc1002_len(void *buf)
 {
 	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
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
 #endif /* __SMB_SERVER_COMMON_H__ */
-- 
2.53.0

