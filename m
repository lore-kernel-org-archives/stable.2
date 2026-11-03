Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701141;
	b=b8WKyzGWzyG7MPRpNkoRmwaKrlThu8hSSOAhDbmm5RovV4YDOiJQEF31G3hA2pVhdE9G
	 ZXifP/6q6i3jpeZkZXyEqSh8defeFEX2mePxMIepFYluX5gL19Y7jtU9saonipyqQ8Aii
	 ORk5i2PH1JXKg8Lu9bgTuG368OqtTK6RyMnhMRhIi7WEZmzb2fGsHBUQrHUQSY1CtSAWQ
	 COuhhmSwEZdNJhArQwNmunXu8ct6gxx1xl//uJfGUnIPjKQlQQMkEPrJisKwvPg60FeMD
	 04wyqRSrXy7HyAhew+ZT3piAV9kikRhw1jqQ0bPXcL8xs8+ZxpDaem4OdP9cF/XbhdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701141;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+SX7lTpjQ1kuL8wfweh8s6GaouTdIj1pUf96a7drLGU=;
	b=Lpaub22WAptW3jcPBuFrsFALX9oeWqxxKq4+aAdVXlVBRCHoE4Cf593W2fmnnlIXSW1S
	 oV+ig05iYY220uIadBhB5iOPk+yA7eu1ipVeUxpleYmXiaN+3ImX8cWZeFJ7mcYWxGbEi
	 qEV8SaA/C1gmd9kX9RjX/aN+rau2zYJZxfdnEMvLYXoBrkz1ALBE49PJFOequCaBtVYIB
	 66SLRmLAbylsPEms40nlVF0Z4mzsZYO+knEvS2ExODe8UBROeeLjfgY9QssYCkXCMH/l6
	 /CxtXoBRw17h41ZDQ78O90HVBiRqBey7u23C7hstd/V2o2BtHiwblEc+XZUJ6azhfdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ESsCxSIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E4C606A813
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ESsCxSIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3A51F00919;
	Tue,  3 Nov 2026 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701140;
	bh=+SX7lTpjQ1kuL8wfweh8s6GaouTdIj1pUf96a7drLGU=;
	h=Subject:To:Cc:From:Date;
	b=ESsCxSIMHGLX6TZDGFrIPZFUkRuGVaeagSIg5htJOc2SmPQIedx+WN18eqEnFN/z1
	 rJW2Px2LcUaH5jHjUEUHCcOK7o7/xRXarq9n3hKyjv+ppuuWAwUIq6cxmurK2xBnVU
	 dXIIE01sv9QLmXlrxgUeP4n613iJ9+RoOlLWaml8=
Subject: FAILED: patch "[PATCH] ksmbd: prevent stale data from being written by SMB2 WRITE" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:18:52 +0100
Message-ID: <2026110352-stung-radiation-169e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bc0e0f5ac1d7b044d403f859406b4b66d4b1ce9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110352-stung-radiation-169e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc0e0f5ac1d7b044d403f859406b4b66d4b1ce9b Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 7 Sep 2026 13:35:51 +0900
Subject: [PATCH] ksmbd: prevent stale data from being written by SMB2 WRITE
 requests

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

diff --git a/fs/smb/server/compress.c b/fs/smb/server/compress.c
index 5162fb84c755..3fcb3e44302e 100644
--- a/fs/smb/server/compress.c
+++ b/fs/smb/server/compress.c
@@ -65,6 +65,7 @@ static int __ksmbd_decompress_request(struct ksmbd_conn *conn,
 		return -ENOMEM;
 
 	*(__be32 *)out = cpu_to_be32(out_size);
+	out[out_size + 4] = 0;
 	rc = smb_compression_decompress(conn->compress_algorithm,
 					conn->compress_chained,
 					conn->compress_pattern,
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d211861ff86f..3f8cc4998da5 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -752,6 +752,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!conn->request_buf)
 			break;
 
+		conn->request_buf[pdu_size + 4] = 0;
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
 
 		/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 18602a4759c0..c792ed5ebbd3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9276,23 +9276,25 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	int err = 0, ret = 0;
 	char *data_buf;
 	size_t length;
+	unsigned int data_offset, req_len;
 
 	WORK_BUFFERS(work, req, rsp);
 
 	length = le32_to_cpu(req->Length);
 	id = req->VolatileFileId;
+	data_offset = le16_to_cpu(req->DataOffset);
+	req_len = smb2_current_req_len(work, &req->hdr);
 
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
@@ -9579,14 +9581,21 @@ int smb2_write(struct ksmbd_work *work)
 		writethrough = true;
 
 	if (is_rdma_channel == false) {
-		if (le16_to_cpu(req->DataOffset) <
-		    offsetof(struct smb2_write_req, Buffer)) {
+		unsigned int data_offset = le16_to_cpu(req->DataOffset);
+		unsigned int req_len = smb2_current_req_len(work, &req->hdr);
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

