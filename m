Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A249E13F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162940; cv=none; b=YjtzYgETPr0ivtcPJ1iHpxo7xopJlE0BOYjMlsRtd63m5slCd1xJY5t6m1DTOVT5jAxPYrry5G46nXqykmEW8dfWk7RyJ1m3oMaW788JKRUtQToIPRgYPrUPKGvMLYHcXRkyfnVsHL4K/j1UFyME7cFoycHgZDHMQasGP4zHX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162940; c=relaxed/simple;
	bh=IspALO+3heOALiMPdKFFwnPa01hl03NUxgfK4CxiXlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcJ1wQw8WR/1aiCT8qpzXfa/r8gcLZZAtVdUIDtydawOunoWFbE1guMriJKz7Eg0Pc26mJ5X15xTTyi1oL9nxf82SGVntWdkoawk2uRw4AYiBnRzSYbVucv+3DlYybj3qNQfHH0laew/5ymxclPjmMyuJkS/+ytC1SqiwNgWFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPG3khh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPG3khh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99B61F00893;
	Wed, 23 Sep 2026 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162932;
	bh=tT8QHjR0J5l6A+IVbQHuT2/9xKJC7Ac3OHCtDPh1s7c=;
	h=From:To:Cc:Subject:Date;
	b=hPG3khh9KxYByqakistWJ0A14aEwHtSiaRA+kRn/+RECx2JC3jFPF798zqE8KLSWj
	 xvaknTr1XtPNVsWf/kUzmowctUuJYE0vJ9Idnd0+otlMIwacJQOje6vmp/ikqpinYi
	 f82GGqTkHuYhhAP+mjVQoxAopGAK3azxZMUrPLNBoscePCJv7xqFguCPT7JFAG+YSe
	 90E053x6kmQEnLim/C+3o4wXPPfnT3ShcaXEbVGZGAiJILgpR/lFQpXIuJJxkH4VCM
	 H+SHzzRzYpVySjABCLKQUEw8Py07SyWosTqglYP6ltUOjgpBFgaq2yhpbMhQkDSwaq
	 VhVJOH9pU36vw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.18.y] Revert "ksmbd: Fix to handle removal of rfc1002 header from smb_hdr"
Date: Wed, 23 Sep 2026 20:28:49 +0900
Message-Id: <20260923112849.21461-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 29dbb4e29e1f ("ksmbd: Fix to handle removal of rfc1002 header
from smb_hdr") is a backport of upstream commit 0a70cac78967.

The upstream commit depends on SMB1 header refactoring which removed the
RFC1002 length field from struct smb_hdr. Those prerequisite changes are
not present in the 6.18.y stable tree, where ksmbd still defines struct
smb_hdr with the smb_buf_length field.

As a result, smb_get_msg() advances the buffer by four bytes before it is
cast to a structure that already includes the RFC1002 field. This causes a
four-byte offset mismatch while parsing and constructing the initial SMB1
multi-protocol negotiate response.

Windows clients then receive a malformed negotiate response and abort the
connection.

This reverts commit 29dbb4e29e1f ("ksmbd: Fix to handle removal of
rfc1002 header from smb_hdr").

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/server.c     |  2 +-
 fs/smb/server/smb_common.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 76515d9777e3..9a5b6b960b19 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work *work)
 
 	if (ksmbd_conn_exiting(work->conn) ||
 	    ksmbd_conn_need_reconnect(work->conn)) {
-		rsp_hdr = smb_get_msg(work->response_buf);
+		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
 	}
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 3e3758f5ed42..2f08c667e5ef 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
 	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
 		return ksmbd_smb2_check_message(work);
 
-	hdr = smb_get_msg(work->request_buf);
+	hdr = work->request_buf;
 	if (*(__le32 *)hdr->Protocol == SMB1_PROTO_NUMBER &&
 	    hdr->Command == SMB_COM_NEGOTIATE) {
 		work->conn->outstanding_credits++;
@@ -278,14 +278,15 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 						  req->DialectCount);
 	}
 
+	proto = *(__le32 *)((struct smb_hdr *)buf)->Protocol;
 	if (proto == SMB1_PROTO_NUMBER) {
 		struct smb_negotiate_req *req;
 
-		req = (struct smb_negotiate_req *)smb_get_msg(buf);
+		req = (struct smb_negotiate_req *)buf;
 		if (le16_to_cpu(req->ByteCount) < 2)
 			goto err_out;
 
-		if (offsetof(struct smb_negotiate_req, DialectsArray) +
+		if (offsetof(struct smb_negotiate_req, DialectsArray) - 4 +
 			le16_to_cpu(req->ByteCount) > smb_buf_length) {
 			goto err_out;
 		}
@@ -319,8 +320,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
  */
 static int init_smb1_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb_hdr *rsp_hdr = (struct smb_hdr *)smb_get_msg(work->response_buf);
-	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb_get_msg(work->request_buf);
+	struct smb_hdr *rsp_hdr = (struct smb_hdr *)work->response_buf;
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)work->request_buf;
 
 	rsp_hdr->Command = SMB_COM_NEGOTIATE;
 	*(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
@@ -411,10 +412,9 @@ static int init_smb1_server(struct ksmbd_conn *conn)
 
 int ksmbd_init_smb_server(struct ksmbd_conn *conn)
 {
-	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb_get_msg(conn->request_buf);
 	__le32 proto;
 
-	proto = *(__le32 *)rcv_hdr->Protocol;
+	proto = *(__le32 *)((struct smb_hdr *)conn->request_buf)->Protocol;
 	if (conn->need_neg == false) {
 		if (proto == SMB1_PROTO_NUMBER)
 			return -EINVAL;
@@ -572,12 +572,12 @@ static int __smb2_negotiate(struct ksmbd_conn *conn)
 
 static int smb_handle_negotiate(struct ksmbd_work *work)
 {
-	struct smb_negotiate_rsp *neg_rsp = smb_get_msg(work->response_buf);
+	struct smb_negotiate_rsp *neg_rsp = work->response_buf;
 
 	ksmbd_debug(SMB, "Unsupported SMB1 protocol\n");
 
-	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp,
-			      sizeof(struct smb_negotiate_rsp)))
+	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp + 4,
+			      sizeof(struct smb_negotiate_rsp) - 4))
 		return -ENOMEM;
 
 	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
-- 
2.25.1

