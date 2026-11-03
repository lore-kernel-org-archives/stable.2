Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748486;
	b=JzItSbI0Kr1ny2XR66gKoUK+9MDGkEHbmtkt+cD/bPOBdZY1oiJI8POx/wGnfVed1Q5w
	 HsaU5IczP/Wz4MQCoHgue4LKnnBCEeQYH9LKRDpQWtqD/UVsX+Km8WFc5fe2GxshGFg9y
	 Qjo23WR+6t+Bx+K5vVeVXuAXk9lbvJprXD8NBjQ7q6kPDYGFo50eCmeyDwPRnVWeF5ypL
	 eyTBESVkBpB/gjUVrMJGsQFH5SZkBWSvSwYzXAXzA6i7HFAHDbHBs5o0qoQef6uztj3f/
	 NV49Xq9aU9uUYzUQA4NDAHrZVOXhIGrTqnrDfFt3S4lLcHz/RLqqhgSkN/yPrGoU5vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ho/+1NPALtJlojAFcl626txMYj4Z0uTanNT0kkQ3VCc=;
	b=lXF3fGCwj5GBkwJHSfOkYQLGldVjD3X8wDsbmwZfiVBLBPJhI+fPm2hpfYdjdGDdFtBe
	 ytoiea6/CRfYjPmxbuMrQGfWfra3PHheaq7/0DT6IBf0u8dw5B2hoAve9/yCaD/e5tif8
	 kYIekSAlzmkhwzpFlTVJ8Z+A/fk+yZfegIqdSZR2Fl255+iPG6LHu6as8NqxFMcybo9fL
	 /svmcb7NttzAxdDXOLws5E6KDm7gGY8wJyfnwASE0ta259I3l49Q6B1ozryu7NFYq9P7u
	 RTn5eCO0lG2undPzv1MURpJF2zQaM0HFmxLFNUrWSORP+j2HP3N2G1YP6DznXV/r6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWKvwSxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72735606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWKvwSxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913C41F000C1;
	Tue,  3 Nov 2026 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748486;
	bh=ho/+1NPALtJlojAFcl626txMYj4Z0uTanNT0kkQ3VCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWKvwSxGEPscp8EtbHyJj3OUTQ49o56E6u8/dNcKn/w5ysgdbsAuSPvL2bytWKJ/t
	 t75Gqym8Z3T/XokJWA5axAAXzRDltNdwzgiWcx8E1HSdW6MbwSQAepfpRWa2eLREA8
	 rTOpOTG9ZOGoPRV6yKABsCOA1OzUUc2+HhwajQrMX+AEZVn4wisONfssY4YB35bLg/
	 B29YEDz8T0vQkXrkBpNwVVTVnE4C0BPefSyVFeklRjCvsFD5zYgPl/SBKd2kDBetaU
	 4mtgnfNbcBJACfpC1C1tkVlPSo0PD1pNxMaQH8MQEvC8Q25/jdgRFE8l7M5QWx7zSh
	 cNoLEZMLyPBxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: prevent stale data from being written by SMB2 WRITE requests
Date: Tue,  3 Nov 2026 18:28:04 -0500
Message-ID: <20261103232717.1549133-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110352-stung-radiation-169e@gregkh>
References: <2026110352-stung-radiation-169e@gregkh>
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
[ sashal: inlined smb2_current_req_len() calculations at both call sites because the helper is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/connection.c |  1 +
 fs/ksmbd/smb2pdu.c    | 34 +++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 65dd05290c9ba..9dd02322275fc 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -399,6 +399,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..b321f13bf8ee5 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6552,23 +6552,28 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
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
@@ -6719,14 +6724,25 @@ int smb2_write(struct ksmbd_work *work)
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

