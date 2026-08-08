Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E84195DD
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198194; cv=none; b=Xtqd03f5fKh3AzolFPyQhJF14x266+0O104dG4aVtA0Ja3uaTjPsi6QlZd+L/KOaEG2SDJco5pQk3ppUSQWpibUTNG5jqKw3/NCyYX7Z0JdVVF8WSPX/eeKDk4uVy8A8ynvGqBI3L6/owNEmZCduQYi3uoFqG33tRHxdug5UWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198194; c=relaxed/simple;
	bh=ZD4/BQ0/kfQxbCMFEBvFvBQzxZNvskBoLucXcbC2gRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd5YeOA42lRkhjK6eaQ9bUG4n4R3p9ZgcHWNXY4aFlt7z3M84fGCpict1aOKaQ48J5kajgszm1f9hvGbJrrMrtlu1lZcQM2UAt6zOClhUYZClnE8sW9/G69mFYyuYAZbBBS/SakMXWcNiSgdovu2ClSZpauDTdWheABTNP0+3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X52ltdm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X52ltdm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B1B1F000E9;
	Sat,  8 Aug 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198192;
	bh=xnF3Ay4ErYa8oVf/1WfCa2MZqRjAy8Z/PsRO3z+gmo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X52ltdm/tHFt8lF/KPsdemIISo9HepFw3A+dTfwF4NqbZNUVccDQLitCvh/vN5uTI
	 iyEN65flSf+SJRmRYF9Z6DVo2mSvivf39O1iN9FActCz2IFLpSsDWss8v5it5J2J5G
	 bJayo9/rfNMDrSn8eQfAR7VX/WC0smt22ety5HWqNryV082HZC4R6ihXHUGYEJQ8dg
	 3Tb/2W/zny62229Z2v0LbBGceQmn0B5XtxXPUgbpfsIBKr77j2uDH8Cq7pOimu8Hl+
	 yBM2BIpj+oyM4H1GcpJl2+noyn5icCpQ55bSpdvbkarPZSIwgQe9gujQuKhTejrAaV
	 qRnuED2aaLE9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/7] ksmbd: rename smb2_get_msg to smb_get_msg
Date: Sat,  8 Aug 2026 10:09:45 -0400
Message-ID: <20260808140948.340323-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808140948.340323-1-sashal@kernel.org>
References: <2026072924-aviator-carton-3ed9@gregkh>
 <20260808140948.340323-1-sashal@kernel.org>
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
 fs/smb/server/server.c     |  2 +-
 fs/smb/server/smb2pdu.c    | 70 +++++++++++++++++++-------------------
 fs/smb/server/smb2pdu.h    |  9 -----
 fs/smb/server/smb_common.c | 18 +++++-----
 fs/smb/server/smb_common.h |  9 +++++
 8 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index a778275207fe7..3f8258954901b 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -710,7 +710,7 @@ void ksmbd_gen_smb311_encryptionkey(struct ksmbd_conn *conn,
 int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
 	int msg_size = get_rfc1002_len(buf);
 	struct sha512_ctx sha_ctx;
@@ -837,7 +837,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(iov[0].iov_base);
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	DECLARE_CRYPTO_WAIT(wait);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 9274953eb064c..edab0edaf18c3 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -475,7 +475,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
 				break;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index ff0dbf3f8cbf4..d83370f53d6f0 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -663,7 +663,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -677,7 +677,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -776,7 +776,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -790,7 +790,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 3b89d4cd41bad..9da4525010ccd 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work *work)
 
 	if (ksmbd_conn_exiting(work->conn) ||
 	    ksmbd_conn_need_reconnect(work->conn)) {
-		rsp_hdr = smb2_get_msg(work->response_buf);
+		rsp_hdr = smb_get_msg(work->response_buf);
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
 	}
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 64a1cfc4e8099..53fbf2e4fae65 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -48,8 +48,8 @@ static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = smb2_get_msg(work->request_buf);
-		*rsp = smb2_get_msg(work->response_buf);
+		*req = smb_get_msg(work->request_buf);
+		*rsp = smb_get_msg(work->response_buf);
 	}
 }
 
@@ -155,7 +155,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = smb2_get_msg(work->response_buf);
+		err_rsp = smb_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
 		int err;
@@ -181,7 +181,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -205,7 +205,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -231,7 +231,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = smb2_get_msg(work->request_buf);
+		rcv_hdr = smb_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -244,7 +244,7 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
 
 	work->iov_idx = 0;
@@ -267,7 +267,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	int err;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -281,7 +281,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	WARN_ON(ksmbd_conn_good(conn));
 
@@ -455,7 +455,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -506,8 +506,8 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rsp_hdr = smb_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(work->request_buf);
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
@@ -536,7 +536,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -552,7 +552,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 		    offsetof(struct smb2_query_info_req, OutputBufferLength))
 			return -EINVAL;
 
-		req = smb2_get_msg(work->request_buf);
+		req = smb_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		     req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -726,10 +726,10 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
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
@@ -1107,8 +1107,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
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
@@ -6094,7 +6094,7 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_echo_rsp *rsp = smb_get_msg(work->response_buf);
 
 	ksmbd_debug(SMB, "Received smb2 echo request\n");
 
@@ -6672,8 +6672,8 @@ int smb2_set_info(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
@@ -6901,8 +6901,8 @@ int smb2_read(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -7330,7 +7330,7 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
@@ -7347,7 +7347,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -7379,7 +7379,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list, request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    iter == work)
@@ -8336,8 +8336,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -9023,7 +9023,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rcv_hdr2 = smb_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -9048,7 +9048,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -9122,7 +9122,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -9258,7 +9258,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
 	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
-	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
+	struct smb2_hdr *hdr = smb_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
 	/* tr_buf must be cleared by the caller */
@@ -9297,7 +9297,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *trhdr = smb_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
@@ -9309,7 +9309,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -9350,7 +9350,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rsp = smb_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 5163d5241b90d..9d4c01c453b26 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -490,15 +490,6 @@ int smb2_ioctl(struct ksmbd_work *work);
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
 #define POSIX_TYPE_FILE		0
 #define POSIX_TYPE_DIR		1
 #define POSIX_TYPE_SYMLINK	2
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 6d7b4449276bc..1cd7e738434d7 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
 	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
 		return ksmbd_smb2_check_message(work);
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (*(__le32 *)hdr->Protocol == SMB1_PROTO_NUMBER &&
 	    hdr->Command == SMB_COM_NEGOTIATE) {
 		work->conn->outstanding_credits++;
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
 
@@ -281,7 +281,7 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 	if (proto == SMB1_PROTO_NUMBER) {
 		struct smb_negotiate_req *req;
 
-		req = (struct smb_negotiate_req *)smb2_get_msg(buf);
+		req = (struct smb_negotiate_req *)smb_get_msg(buf);
 		if (le16_to_cpu(req->ByteCount) < 2)
 			goto err_out;
 
@@ -319,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
  */
 static int init_smb1_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb_hdr *rsp_hdr = (struct smb_hdr *)smb2_get_msg(work->response_buf);
-	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(work->request_buf);
+	struct smb_hdr *rsp_hdr = (struct smb_hdr *)smb_get_msg(work->response_buf);
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb_get_msg(work->request_buf);
 
 	rsp_hdr->Command = SMB_COM_NEGOTIATE;
 	*(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
@@ -411,7 +411,7 @@ static int init_smb1_server(struct ksmbd_conn *conn)
 
 int ksmbd_init_smb_server(struct ksmbd_conn *conn)
 {
-	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(conn->request_buf);
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb_get_msg(conn->request_buf);
 	__le32 proto;
 
 	proto = *(__le32 *)rcv_hdr->Protocol;
@@ -572,7 +572,7 @@ static int __smb2_negotiate(struct ksmbd_conn *conn)
 
 static int smb_handle_negotiate(struct ksmbd_work *work)
 {
-	struct smb_negotiate_rsp *neg_rsp = smb2_get_msg(work->response_buf);
+	struct smb_negotiate_rsp *neg_rsp = smb_get_msg(work->response_buf);
 
 	ksmbd_debug(SMB, "Unsupported SMB1 protocol\n");
 
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index bce7887a907fd..95062e922de93 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -423,4 +423,13 @@ unsigned int ksmbd_server_side_copy_max_chunk_size(void);
 unsigned int ksmbd_server_side_copy_max_total_size(void);
 bool is_asterisk(char *p);
 __le32 smb_map_generic_desired_access(__le32 daccess);
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

