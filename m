Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3744137AE
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198193; cv=none; b=AwumEGslCTdVoR+7EtKdzEmLFLnbP1u19eoYLSOLJJmphov8I1ESCP0+UqZuPI0S3IJn+8nafKrVwM32Lw5k/YFWsEtUKtpKHGrVrFqjOZ7okzrI5z8PULve04vfNdAd2hepoNDpOoOPLo3sQ8Lp9aEnRhgMKyrFJT1l/motZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198193; c=relaxed/simple;
	bh=Yz7EIgdJodRHm8gFuAtxSR088VaHnMo9tiVvXucLaDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0+2G6FKPYlUyqS+VEEOkoAqhE4CHxBAUmY7sbye0iQ7/9IHpVy5CbN3dwe+QermJFIcC/lO0UegYC6o4CewmC+JPcnK1n+k60aDHi6z2HqQDLiHoK9m3GqiZWrkrpp1KwxTZuChxgRYwYTH1cuq+ARfrqvei0czGu7eD1LXmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+5+7ySO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+5+7ySO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCEF1F00A3E;
	Sat,  8 Aug 2026 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198192;
	bh=bq4UXG/RkjN+4tw6HWfZzPv7YEvTzxTsSRqrUWuD4b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+5+7ySO+OQUFux7aAScmiLv0b8UDkuxxLuAK3ySi99h3e00VSQ+uuG7ff/VMH+4o
	 q760Czr6P/6fpd74cPN+wFzStfZb2b9MjOgBEzpIcLCkcEzJoPZ8TtivvZxeIdlslZ
	 0bgbhQDDn0m4QYVZjvGGidbu260lm0xA8GFDnjniynR55feL1PkfIgT0KoSk/CxORj
	 djeErSzVWduW4/eutN0Zv4/dn3eALMjaapR42D1xXVGPAbov/3+tG6bNzMNIma2CmY
	 CBlk7/22f2Jy6zDFWz3BqGG/j3Ge3ieQ2sK4ZD5VhvrHMXcZAozvhG6MQqHLa/Xa5M
	 3RySoHjSoQfPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/7] ksmbd: Fix to handle removal of rfc1002 header from smb_hdr
Date: Sat,  8 Aug 2026 10:09:44 -0400
Message-ID: <20260808140948.340323-3-sashal@kernel.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0a70cac7896712a08e3cd22c16f44be976d40dbf ]

The commit that removed the RFC1002 header from struct smb_hdr didn't also
fix the places in ksmbd that use it in order to provide graceful rejection
of SMB1 protocol requests.

Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
Reported-by: Namjae Jeon <linkinjeon@kernel.org>
Link: https://lore.kernel.org/r/CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com/
Cc: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/server.c     |  2 +-
 fs/smb/server/smb_common.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index b78126bb23711..3b89d4cd41bad 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work *work)
 
 	if (ksmbd_conn_exiting(work->conn) ||
 	    ksmbd_conn_need_reconnect(work->conn)) {
-		rsp_hdr = work->response_buf;
+		rsp_hdr = smb2_get_msg(work->response_buf);
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
 	}
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index b23203a1c2865..6d7b4449276bc 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
 	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
 		return ksmbd_smb2_check_message(work);
 
-	hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (*(__le32 *)hdr->Protocol == SMB1_PROTO_NUMBER &&
 	    hdr->Command == SMB_COM_NEGOTIATE) {
 		work->conn->outstanding_credits++;
@@ -278,15 +278,14 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 						  req->DialectCount);
 	}
 
-	proto = *(__le32 *)((struct smb_hdr *)buf)->Protocol;
 	if (proto == SMB1_PROTO_NUMBER) {
 		struct smb_negotiate_req *req;
 
-		req = (struct smb_negotiate_req *)buf;
+		req = (struct smb_negotiate_req *)smb2_get_msg(buf);
 		if (le16_to_cpu(req->ByteCount) < 2)
 			goto err_out;
 
-		if (offsetof(struct smb_negotiate_req, DialectsArray) - 4 +
+		if (offsetof(struct smb_negotiate_req, DialectsArray) +
 			le16_to_cpu(req->ByteCount) > smb_buf_length) {
 			goto err_out;
 		}
@@ -320,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
  */
 static int init_smb1_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb_hdr *rsp_hdr = (struct smb_hdr *)work->response_buf;
-	struct smb_hdr *rcv_hdr = (struct smb_hdr *)work->request_buf;
+	struct smb_hdr *rsp_hdr = (struct smb_hdr *)smb2_get_msg(work->response_buf);
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(work->request_buf);
 
 	rsp_hdr->Command = SMB_COM_NEGOTIATE;
 	*(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
@@ -412,9 +411,10 @@ static int init_smb1_server(struct ksmbd_conn *conn)
 
 int ksmbd_init_smb_server(struct ksmbd_conn *conn)
 {
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(conn->request_buf);
 	__le32 proto;
 
-	proto = *(__le32 *)((struct smb_hdr *)conn->request_buf)->Protocol;
+	proto = *(__le32 *)rcv_hdr->Protocol;
 	if (conn->need_neg == false) {
 		if (proto == SMB1_PROTO_NUMBER)
 			return -EINVAL;
@@ -572,12 +572,12 @@ static int __smb2_negotiate(struct ksmbd_conn *conn)
 
 static int smb_handle_negotiate(struct ksmbd_work *work)
 {
-	struct smb_negotiate_rsp *neg_rsp = work->response_buf;
+	struct smb_negotiate_rsp *neg_rsp = smb2_get_msg(work->response_buf);
 
 	ksmbd_debug(SMB, "Unsupported SMB1 protocol\n");
 
-	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp + 4,
-			      sizeof(struct smb_negotiate_rsp) - 4))
+	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp,
+			      sizeof(struct smb_negotiate_rsp)))
 		return -ENOMEM;
 
 	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
-- 
2.53.0

