Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B027470EB0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333357; cv=none; b=tUNKp8BjyxC8zYYYlQu3rNE/FSCSZBzFiz68t6zsF32Dxalc/fk4eKRffXLqRtLxI7rOiiT3jnWHoGIHYwcEoLNWUIgZU80lZYhCf1batLnRz4xaV2o+yEQXcjMHwEbQdmxe5iQkNjjwLLx6vb3DztdYIUNOUg3BynqIqdW32eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333357; c=relaxed/simple;
	bh=r3mA4juAlumGK7JAedfgPcj+7GILVH08hAoCT/rfSzk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z4ABI5KnLATHjJnucoAKoQM1gH0bymTDAuwO1GkMtjWhhRkBs6kpNypDSQpw45PJsvMX2Br2dvgVXVkYWN7Z7uGNFJstiTuoOnsZabGYcv/yZNRoj/nPs+TMOBee5g2UIvJKVfEQVAlGYtBD6vlpUF3oE9149bw1NzI1WBLQTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bRvM+kO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bRvM+kO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687371F000E9;
	Wed, 29 Jul 2026 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333352;
	bh=NbXnMIYK+1+tkRxrazo/CU2SsV84+tNU4XOxlY3YWFA=;
	h=Subject:To:Cc:From:Date;
	b=bRvM+kO+zKO51QUq9Be+FZO1dntRZPLjjxbhdGl7UG+d3Ua6fy53O47yiQ0yyVaoa
	 YIbHINQq6X3hFdIG1U/oIu+EY2nqt2UXdNSPKavliOAXLRKdUYzVxXpFW2KuzZPlCX
	 T2GFnnQI9pgjsH5FdfxdhE6mYf0wpXJB6i2Y6rFk=
Subject: FAILED: patch "[PATCH] ksmbd: validate minimum PDU size for transform requests" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:55:25 +0200
Message-ID: <2026072925-unloaded-borough-0d66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cfc0b8e5080aec87700774e8568765eaa4b7b92b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072925-unloaded-borough-0d66@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfc0b8e5080aec87700774e8568765eaa4b7b92b Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 4 Jul 2026 11:30:27 +0900
Subject: [PATCH] ksmbd: validate minimum PDU size for transform requests

The receive path applies the minimum SMB2 PDU size check only when
ProtocolId is SMB2_PROTO_NUMBER. A packet carrying
SMB2_TRANSFORM_PROTO_NUM bypasses the check even when the negotiated
dialect does not provide transform handling.

On an SMB 2.1 connection, a short transform packet therefore reaches
init_smb2_rsp_hdr(), which interprets the request as a full SMB2 header
and reads beyond the request allocation. The copied fields can then be
returned to the unauthenticated client.

Compression transforms are converted to ordinary SMB2 messages before
protocol validation. After that conversion, validate ordinary SMB2
requests against SMB2_MIN_SUPPORTED_PDU_SIZE and require encryption
transform requests to contain both a transform header and an SMB2
header. This rejects truncated requests before work allocation.

Fixes: 368ba06881c3 ("ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-31063
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 9e8fdb39e5a2..dee8e4aced99 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -441,6 +441,8 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 /* "+2" for BCC field (ByteCount, 2 bytes) */
 #define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
 #define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
+#define SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE	\
+	(sizeof(struct smb2_transform_hdr) + sizeof(struct smb2_hdr))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -455,6 +457,7 @@ int ksmbd_conn_handler_loop(void *p)
 	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
 	struct ksmbd_transport *t = conn->transport;
 	unsigned int pdu_size, max_allowed_pdu_size, max_req;
+	__le32 proto;
 	char hdr_buf[4] = {0,};
 	int size;
 
@@ -546,11 +549,14 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
-		    SMB2_PROTO_NUMBER) {
-			if (pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
-				break;
-		}
+		proto = *(__le32 *)smb_get_msg(conn->request_buf);
+		if (proto == SMB2_PROTO_NUMBER &&
+		    pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
+			break;
+
+		if (proto == SMB2_TRANSFORM_PROTO_NUM &&
+		    pdu_size < SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE)
+			break;
 
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");

