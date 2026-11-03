Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723985;
	b=rTFBE43U5Rdc1az6DU/dwc7fNEY2udqe2HCIJv37aWIshSW04HOWjnv2ApV5aaskXFtQ
	 HqHEID9ImYw2nlgHrSSNypiqwQ3/LD9mPy0z2Nq/zExaCWCHR4nfFELEDsM6kJVvB41IR
	 3VueIi9VLLTLW0YpfL0EPk6s0PtOGK4/sbbVU09pHgpzzwUWLxAmeEUuI/FcEPWu23O4m
	 hgq0jqJhhnn/0r4hgfgYshxAcIYrWPuGGISWiv0ZCPa5FuBM9aKUwZG2lml2LrkJgml6F
	 CGv/fZgbFXOFJt7btt7fe4oCfEJW5MB54EjnmIeHIwO7ZbdJvc4q4BsyvH6T+qo+ZLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Enc8TR23gw9j1IR2jPzVk9FgWDjw7wKAMbSVzRe4YWQ=;
	b=RTU8mjQwgR8grybCumUrTrnS8QSsXOTo6R6LnUcndTCgLeuIqGwdJiT0Tjr6bB15QYdn
	 QwTCkAG8NIP/INbU3vp1o3fHMwMjBs5tZJyP50Tal0ogBO32jdRX7guvTPc1ukhyvifIg
	 /Uwl4NHmPo6skXYBO+Xg4PAiy2G3lcPHgBNKEUg6fIDKy3QaK/M8cL1ztoRkpclbUQNAg
	 OgInvzCbw6F/G7/yjDkd1vrZ88AuUYCLUuk6gyQCxfB26khptsFYfHm7jzSUwg87BVddG
	 LGoOYgXaprNz2elwhZLwVb7GZY3tbPfH5lqDavT0vi0bxdlcFd82Vx3v6sFG4bpOa4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eof3qKl0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC161606EEB3
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eof3qKl0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564ED1F00919;
	Tue,  3 Nov 2026 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723984;
	bh=Enc8TR23gw9j1IR2jPzVk9FgWDjw7wKAMbSVzRe4YWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eof3qKl02vIuWuCYcYPWHiwiPExNQLozpe15r8ffKZ8bfKFAtz10DNLPTeX4FGEoe
	 gffI+2pdIzNyUSKrhTnkn9fCMWDhwbQMQXURpwIdRPwd96EV0TOtsGAk1EhFmvcT9Q
	 vBkTQIkHIWIef4xD6AJjcKUhoIzf8wXb6RUA8O0axPwDiW/cRTe+hCLs3/ldwno4VR
	 OV5RR/064G+jrF6gI5CzW5f3+dsF77fD0ffY+i8k6EJhnZ0ZyClvkn+8/H7DPcAy2F
	 X7gRZt8EHEWN1Wiy9Xkq+HTxYn90/pyJV6HDDHOr/1g5gqF3+f8z8ghR94SMUOBEO+
	 xgTqnKlo2FyuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: prevent stale data from being written by SMB2 WRITE requests
Date: Tue,  3 Nov 2026 11:39:43 -0500
Message-ID: <20261103163911.497623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110350-activist-riot-545a@gregkh>
References: <2026110350-activist-riot-545a@gregkh>
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
[ sashal: replaced smb2_current_req_len() calls with inline request-length calculations using NextCommand and the receive-buffer offset ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c |  1 +
 fs/smb/server/smb2pdu.c    | 34 +++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d3dd89e612c6e..b532e553301aa 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -520,6 +520,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..73b310f748e09 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7168,23 +7168,28 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
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
@@ -7335,14 +7340,25 @@ int smb2_write(struct ksmbd_work *work)
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

