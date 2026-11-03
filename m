Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720847;
	b=IJEPEevg2uXOf2695GUGENlJMKBWtsRHwXdT2Sz//6WncQLTBq4jVTNE0rGDS0Q82oTB
	 cxUwdjZDPfc6PNAtsIBduY7a1uXyhgZGv8mXVexQSCtP9wSMWZdZbgO1SQamD+lxCKCoX
	 osj0C2GJH4LLMAr96Ym6rQt6KjCrGpHGCHt23bCnZLKbMveX3nSu0tUHClXHuvVoa4opJ
	 gNz0rHsv9YnwuZA/J5oDSQH6CxeIQknccxqEsYjbeAxeVo/HJQgUlaoecz58X3bRSt6HQ
	 nSl94FsIm1fFB37CHBTE/alJKhMX2JcCsbntpd9wtiHQCBfHEQRYxw1PVHEFoNooOiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dKPJ6608J1BqVOjmF+cq8HEpkC2n601wwA1rhFj66w4=;
	b=KCDmGWGgnbXDM+m6AcDQseDF9zG+GxpAfGRIPmISuQakWSyYyn7sqRf1fa+l9UNNcK1c
	 Ky4mmSH1WOVgTc/4AIMuGJokG18Zhkxzx8VSXql4D3+vBMuPakDSGrRQ3rUeNvZjKSSII
	 i9kuJyyhXTEU5ygqqNgUN6NH4FfFZ9OXW9Ilpg66pEXRKcPT1GXBrrOif+kPtyN/Fe699
	 dTSj4TfTvJcTjZZW5mj1osW0lzHfqlM25jCQgueplHrS28+9BTDQOIEnYhsRZl1xjfPMd
	 GRitC0J6eRxK5M9+2S/kF9QiEySAzuydcLvm3aqBpUVpt9sbQ+hSxPeB+ptXxzXBmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXHdRPS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AD606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXHdRPS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DF1F000C1;
	Tue,  3 Nov 2026 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720846;
	bh=dKPJ6608J1BqVOjmF+cq8HEpkC2n601wwA1rhFj66w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXHdRPS18lxq/byU2fXVBp/jBLu9p7quEUeICn3IdmOohgubG8JHgkS6q+Ntg5AcV
	 FJ6BtSskaGKZlXFxuEOHymvYvW4WFf4nwagnK14N1gk9GK68UpE9VVXUCczXb36fbZ
	 UQpGsa/N9qUtWORs7k2csTAf6l7JeXDM7PQAIjA1ql4hZ6YRvWVsW3eTG1vZ63FyFN
	 166dvLg6kGLXylBcBYA/N7W1ZOhSm7+ifwT89OM9aBlLvp1UDuDokEsp+5NIz3S33Z
	 ihU6oS9zk0euea/ycvGqeNl/TVRPrdjh27hHKB+w54FdykhnJf2uerFJvILDm8vGAB
	 vE6Gyh5UgoHcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: prevent stale data from being written by SMB2 WRITE requests
Date: Tue,  3 Nov 2026 10:47:24 -0500
Message-ID: <20261103154703.377857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110350-lustfully-linoleum-666e@gregkh>
References: <2026110350-lustfully-linoleum-666e@gregkh>
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
[ sashal: Inlined the unavailable smb2_current_req_len() helper and omitted the decompression change because compression support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c |  1 +
 fs/smb/server/smb2pdu.c    | 34 +++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 8f1b70e39362e..e8739b482b2fe 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -520,6 +520,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..22eb73bb66c44 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7202,23 +7202,28 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
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
@@ -7375,14 +7380,25 @@ int smb2_write(struct ksmbd_work *work)
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

