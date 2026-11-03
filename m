Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735274;
	b=zqAowaQhoPX+I+ABZGxqDqh3As+yi+jM0bMlWr14s4V0mq0NBrKUhWxP0wiqJ8nPrIGs
	 9L4AaW5qUmy3QHG8XYw2UpHciWfyLIWgSZKqQjluUx7fNDINn9ngd8OFdCnUg4YiYTgvh
	 H8AqflaobS9hjiHrcYj8Ktxr1BQpTBbtBW3XCx8GSEci3uXbfTuxMjEeUmW5nTB/8rG6h
	 kVatol7RBpqqKKUyWgiFurdbFZDtmXqxMzbo0LDLuvMH2SKCS9kC9uAYGBydQLiq0OJwD
	 iXJd5q6bS84fAIbCIdh9XKxdjZ6v/v7FmmRBZ2IhhYgpZTK9u0L3/6botYNFjKa4eog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RFDP1+qeI/6PE5pzKeEg2jAo+1vbuaZZQsZqEYbMZig=;
	b=diEvJLLWgUSG7+2ryTXmiBfYBACe/NDMyPy8lTdbfaUtLV9N5CHS4BZfFDxsl9cm4Xgy
	 6Yw0NRV5RUmNJ34MuW564DkOuvtFg84Y6eFYPbVqtJJ2k1NfInZlk3aFqsSZeiavMAWmc
	 gV6KS2eD0l8ZW9R6gCtoBuKe0QDfeiBB7pCfBxJqibmDO3/Z405oESRxQRiagmBLV5NBc
	 L9fIqS/gaumSH+RIJporkBNBYPIV7CltfBPdBYFfCxcC9zz3vpxAgLO561S1fibefOKdS
	 DpIHR26oWWnIKhxFj3LvRmjtaJx9movm+ReEmP74Te0uuqN0vhHTWcF/CIGLJLo/GQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4OiUkxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA0606D811
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4OiUkxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432661F00A02;
	Tue,  3 Nov 2026 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735273;
	bh=RFDP1+qeI/6PE5pzKeEg2jAo+1vbuaZZQsZqEYbMZig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4OiUkxbUNC+mZwD3QR0QnlPwFSYAtsy+XoPt9aUkXWQ7p1QwklOWJ8t31UklnzVr
	 71xhAMCMhrBvV5NGJ4AGLgXWs+KqOJfqLuoAz1R0puTSxqWJdUBg+RyV7nzqBHM3pe
	 GYDFRcBSTHq5Uw8ID/qJkYHIwpJZeQYDMov6Rb0R4iFiU1YtOiov2p0knTeKmmD4Z8
	 VddG1YWPIQ2sNbV51pVY3XWBUV7K1TmG0FesvlkYGd9FjOrVVDcBdlHSYeOzILtu71
	 ld3ExivYBvO4K/n05QHEfgpIBkScPV6yzuPp0duhuXBDt6KBrC+SlXdSg4T7RFk4HP
	 jdc0qoSZxaV+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: prevent stale data from being written by SMB2 WRITE requests
Date: Tue,  3 Nov 2026 14:47:51 -0500
Message-ID: <20261103170316.642979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110351-marsupial-sandbar-d3cd@gregkh>
References: <2026110351-marsupial-sandbar-d3cd@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit bc0e0f5ac1d7b044d403f859406b4b66d4b1ce9b ]

Initialize the compatibility byte in request buffers without zeroing
the entire allocation. Keep the one-byte compatibility exception for
SMB2 messages so valid zero-length WRITE requests remain compatible,
and validate the data range in the WRITE handlers against the current
compound request before accessing it.

This prevents stale request-buffer data from being written to files or
sent to IPC pipes.

Fixes: 443d61d1fa9f ("ksmbd: allocate one more byte for implied bcc[0]")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-32436
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: replaced smb2_current_req_len() calls with inline NextCommand and RFC1002 length calculations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c |  1 +
 fs/smb/server/smb2pdu.c    | 34 +++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index ec265f12c4902..833105f23d260 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -520,6 +520,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..d8aa61602b827 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7140,23 +7140,28 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	int err = 0, ret = 0;
 	char *data_buf;
 	size_t length;
+	unsigned int data_offset, req_len;
 
 	WORK_BUFFERS(work, req, rsp);
 
 	length = le32_to_cpu(req->Length);
 	id = req->VolatileFileId;
+	data_offset = le16_to_cpu(req->DataOffset);
+	req_len = le32_to_cpu(req->hdr.NextCommand);
+	if (!req_len)
+		req_len = get_rfc1002_len(work->request_buf) -
+			work->next_smb2_rcv_hdr_off;
 
-	if ((u64)le16_to_cpu(req->DataOffset) + length >
-	    get_rfc1002_len(work->request_buf)) {
-		pr_err("invalid write data offset %u, smb_len %u\n",
-		       le16_to_cpu(req->DataOffset),
-		       get_rfc1002_len(work->request_buf));
+	if (data_offset < offsetof(struct smb2_write_req, Buffer) ||
+	    data_offset > req_len || length > req_len - data_offset) {
+		pr_err("invalid write data offset %u, length %zu, req_len %u\n",
+		       data_offset, length, req_len);
 		err = -EINVAL;
 		goto out;
 	}
 
 	data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-			   le16_to_cpu(req->DataOffset));
+			   data_offset);
 
 	rpc_resp = ksmbd_rpc_write(work->sess, id, data_buf, length);
 	if (rpc_resp) {
@@ -7307,14 +7312,25 @@ int smb2_write(struct ksmbd_work *work)
 		writethrough = true;
 
 	if (is_rdma_channel == false) {
-		if (le16_to_cpu(req->DataOffset) <
-		    offsetof(struct smb2_write_req, Buffer)) {
+		unsigned int data_offset = le16_to_cpu(req->DataOffset);
+		unsigned int req_len = le32_to_cpu(req->hdr.NextCommand);
+
+		if (!req_len)
+			req_len = get_rfc1002_len(work->request_buf) -
+				work->next_smb2_rcv_hdr_off;
+
+		if (data_offset < offsetof(struct smb2_write_req, Buffer) ||
+		    data_offset > req_len ||
+		    length > req_len - data_offset) {
+			ksmbd_debug(SMB,
+				    "invalid write data offset %u, length %zu, req_len %u\n",
+				    data_offset, length, req_len);
 			err = -EINVAL;
 			goto out;
 		}
 
 		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-				    le16_to_cpu(req->DataOffset));
+				    data_offset);
 
 		ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 			    fp->filp, offset, length);
-- 
2.53.0

