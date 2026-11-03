Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741876;
	b=e74sIGdrKXMXaaEi7W1yuARWjMABxVbiWASG/ddv+ttRe1y9XcRoy/PZ9IzWxkaGfGcB
	 Lso+f/l+UmIWYQH1MQ2N0LCdPvgwTWW8La7thccDk3W5mkUh+vMLkaHf1X2QJAZAamKZo
	 DZiLnDgAu6mSgz2aZ5NBYq2bg97ls2/1HjDTLk7sUn4YYGvbMZA0/DCRM789eV3XOVgVd
	 owZZwUUYLXvl7/W5XUW3oXu+katDKptpjvRd479EtejiCz7/GOapSIC7ZEBsYzpWS0zeM
	 lAhug05XCKw6pA1wjguK1/I/jRJHaTV+rYS9kHjyo80NCJeBRQyJJeG/dgut3z87K7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+tEQw+x1IvRtQzqpybcWKDPDSy38WEtFgVQ3zOUAHs0=;
	b=nML1o4kMUQHbeGblXhd9cV0lEajz/+JgHubYc8jsrdiTpNRUOLoaHf+MjPNr5gDN1nNA
	 lq2poYKrwkeDXhaskYK0t8qBmz1zlBrOHHOxXQSot5/vMIdpOMUmn6padvDJc8CqpZRmZ
	 OnpXZTR2XLIXCo7axF9I2MNB2xArBKbrPQsfHe+TxTWBE4odErGOSFPhWZ/n0i7SwUcus
	 pq/XK4pgCE7DfivFMpuiwH4gHK2lXtpwGAKZDQFecjFlCIgZkOCvXrYS7/JMIn/whkAyi
	 Dz/9YR1IaVuDOjij36y8YILhC5Th4fDWfAGQ7RmemzCYcgqHQzGyVcDjqRggId5j7OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHlIfxe3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD3606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHlIfxe3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1CB1F000C1;
	Tue,  3 Nov 2026 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741875;
	bh=+tEQw+x1IvRtQzqpybcWKDPDSy38WEtFgVQ3zOUAHs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHlIfxe3IlMTfFJWULzbgnLu3dAtuiKlUoeMm86+c6A6xuaODZjAEXnfRwoKiXLY1
	 X5agS5Vio//gqsTREhCD7gkEc+d+Vhq4IS1GKhV4mNeByQIpAsCxDy4g3kB1GI5xJe
	 hZudTYPk6Gy4ZNM4K0/b/Yuz4yz07tJg8SzL48qMDCfh4S8I3QYm0jwmNlw9M4H9J1
	 KeqD4LKhf0fcCjuy5H1WmdJF1ect94083PxVrex4OHVPEh9ZADzlW2ycLzOYOMUUZB
	 LRgMXTOegO5n4sMfhgHPeDz9M7i+4yYTZio3RfLlFj4dhQRglHjZOG1HGYVkwiYLfE
	 PtiqQ7AlKTCsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: prevent stale data from being written by SMB2 WRITE requests
Date: Tue,  3 Nov 2026 16:37:53 -0500
Message-ID: <20261103213706.1417838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110352-entering-splice-bcab@gregkh>
References: <2026110352-entering-splice-bcab@gregkh>
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
[ sashal: replaced smb2_current_req_len() calls with inline calculations using NextCommand or the remaining request buffer length ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c |  1 +
 fs/smb/server/smb2pdu.c    | 34 +++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 168292f73a843..28c60d3070a25 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -403,6 +403,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..250fb3d0a4c64 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6683,23 +6683,28 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
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
@@ -6850,14 +6855,25 @@ int smb2_write(struct ksmbd_work *work)
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

