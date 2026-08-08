Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE34137AE
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198191; cv=none; b=mddS+MbQgNRndS6QiNRavuB/oKlgRMzf60qQuemeVi/FsTYKhUm2zlgKfyFvfEcaDo4rDYBEFJa6uUv/ty6qqvGlpNxakklqOazEWrh0Ih2T7Zyd66EnRA35+NQUwf7AB1RSfGk6dvD6Meio/bvWj5aDn9sETnmqhUe3b42awgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198191; c=relaxed/simple;
	bh=70YpSREh5oWinulmhtgYWIttYZ5F6nacKqTSZaQtXuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj82JJ0UksMdFPZ+BRIuxOMme3sAyyWegGC9D8nJxxqm+dtJkofyQiaY0an4ZDmiynPDbqaFZF8ZY+ub1yG78VnCXfAQU4xh1ZZJ7Aj4BQWwtkWUUJ2r7dshQzcZ2oLP/1OoSHOz5+gN1q6QFt5DqQwbUTAe4x0kpt8ulqUED54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzYCB3Fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzYCB3Fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17E01F000E9;
	Sat,  8 Aug 2026 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198190;
	bh=HsfGEB1a0VQOtsUS2IHEQpUdqEkNTptg8KLAyOOY54U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzYCB3Fw+6IPjXevPcgOMo7AQqAXIyPEbHiOnDJ1ric8icQO/Ek53y52NTY0OCpKj
	 PwLlrUE2U3h0TvCXNqWtwEZawhpJKMs8H8WLsMSqcsE5q9KoZFXorM8a8/k8ILQ3yT
	 8+UbRbOOE8ZUVwtQjTSnRAvzDka/Wx8Mh5RDd3DZlu++oxQdIHt2ukwiyPfRdPeIq9
	 AbodWNKEmi7e1BFHSXBQ2LpQg/eK4/8T0On2qr+OHPwN5n7xO+UKwVKHfFT/9OBhkU
	 CyZtfoo4cXV1qOrGUD9RBHsxO1n7V1WQkglNXbGfV+bngs+1GME1zcC4S6fNZpBQCh
	 8BMg1WZTVm0vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/7] smb: move get_rfc1002_len() to common/smbglob.h
Date: Sat,  8 Aug 2026 10:09:42 -0400
Message-ID: <20260808140948.340323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072924-aviator-carton-3ed9@gregkh>
References: <2026072924-aviator-carton-3ed9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 36c31540cf5279262bfd148d8537cd04866499f2 ]

Rename get_rfc1002_length() to get_rfc1002_len(), then move duplicate
definitions to common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h      | 6 ------
 fs/smb/client/cifssmb.c       | 6 +++---
 fs/smb/client/connect.c       | 2 +-
 fs/smb/client/smb1transport.c | 8 ++++----
 fs/smb/common/cifsglob.h      | 5 +++++
 fs/smb/server/smb_common.h    | 5 -----
 6 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 69deb29502a8c..38b4053d97919 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -671,12 +671,6 @@ struct cifs_mnt_data {
 	int flags;
 };
 
-static inline unsigned int
-get_rfc1002_length(void *buf)
-{
-	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
-}
-
 struct TCP_Server_Info {
 	struct list_head tcp_ses_list;
 	struct list_head smb_ses_list;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 7694ca283fdc3..cea397617bc9c 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -615,7 +615,7 @@ CIFSSMBEcho(struct TCP_Server_Info *server)
 
 	iov[0].iov_len = 4;
 	iov[0].iov_base = smb;
-	iov[1].iov_len = get_rfc1002_length(smb);
+	iov[1].iov_len = get_rfc1002_len(smb);
 	iov[1].iov_base = (char *)smb + 4;
 
 	rc = cifs_call_async(server, &rqst, NULL, cifs_echo_callback, NULL,
@@ -1459,7 +1459,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	rdata->iov[0].iov_base = smb;
 	rdata->iov[0].iov_len = 4;
 	rdata->iov[1].iov_base = (char *)smb + 4;
-	rdata->iov[1].iov_len = get_rfc1002_length(smb);
+	rdata->iov[1].iov_len = get_rfc1002_len(smb);
 
 	trace_smb3_read_enter(rdata->rreq->debug_id,
 			      rdata->subreq.debug_index,
@@ -1831,7 +1831,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	/* 4 for RFC1001 length + 1 for BCC */
 	iov[0].iov_len = 4;
 	iov[0].iov_base = smb;
-	iov[1].iov_len = get_rfc1002_length(smb) + 1;
+	iov[1].iov_len = get_rfc1002_len(smb) + 1;
 	iov[1].iov_base = (char *)smb + 4;
 
 	rqst.rq_iov = iov;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 2ee2199d2a6a2..3e06c0eddb3af 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1295,7 +1295,7 @@ cifs_demultiplex_thread(void *p)
 		 * The right amount was read from socket - 4 bytes,
 		 * so we can now interpret the length field.
 		 */
-		pdu_length = get_rfc1002_length(buf);
+		pdu_length = get_rfc1002_len(buf);
 
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 518f764dedcce..bafc5181e0292 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -165,7 +165,7 @@ SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 	int resp_buf_type;
 
 	iov[0].iov_base = in_buf;
-	iov[0].iov_len = get_rfc1002_length(in_buf) + 4;
+	iov[0].iov_len = get_rfc1002_len(in_buf) + 4;
 	flags |= CIFS_NO_RSP_BUF;
 	rc = SendReceive2(xid, ses, iov, 1, &resp_buf_type, flags, &rsp_iov);
 	cifs_dbg(NOISY, "SendRcvNoRsp flags %d rc %d\n", flags, rc);
@@ -177,7 +177,7 @@ int
 cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		   bool log_error)
 {
-	unsigned int len = get_rfc1002_length(mid->resp_buf) + 4;
+	unsigned int len = get_rfc1002_len(mid->resp_buf) + 4;
 
 	dump_smb(mid->resp_buf, min_t(u32, 92, len));
 
@@ -370,7 +370,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
+	*pbytes_returned = get_rfc1002_len(midQ->resp_buf);
 	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
 	rc = cifs_check_receive(midQ, server, 0);
 out:
@@ -554,7 +554,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
+	*pbytes_returned = get_rfc1002_len(midQ->resp_buf);
 	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
 	rc = cifs_check_receive(midQ, server, 0);
 out:
diff --git a/fs/smb/common/cifsglob.h b/fs/smb/common/cifsglob.h
index eda5e666a7617..371160fec1cdf 100644
--- a/fs/smb/common/cifsglob.h
+++ b/fs/smb/common/cifsglob.h
@@ -40,6 +40,11 @@ struct smb_version_values {
 	size_t		create_posix_size;
 };
 
+static inline unsigned int get_rfc1002_len(void *buf)
+{
+	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
+}
+
 static inline void inc_rfc1001_len(void *buf, int count)
 {
 	be32_add_cpu((__be32 *)buf, count);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index e3be583e803da..3c78acf6ed6d5 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -423,9 +423,4 @@ unsigned int ksmbd_server_side_copy_max_chunk_size(void);
 unsigned int ksmbd_server_side_copy_max_total_size(void);
 bool is_asterisk(char *p);
 __le32 smb_map_generic_desired_access(__le32 daccess);
-
-static inline unsigned int get_rfc1002_len(void *buf)
-{
-	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
-}
 #endif /* __SMB_COMMON_H__ */
-- 
2.53.0

