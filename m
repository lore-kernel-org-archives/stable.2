Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5737A83A
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249230; cv=none; b=ihTtxzCn+T6c3/h5BZUwizB7CkA/a9w6Ncc/SsP2c/jlj4IIMV2NnwbCWjcz7tdsn2cPiFk61eUi8EGNiPQi91aeeka3ofLBTSMQMgdPMhY54EGCgpgHhDaKclSXSBJnd3VDglf/jzulS0rKgIcUtpMPy6UXrBhgSuupAftYrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249230; c=relaxed/simple;
	bh=uebUcIfp8zbZXUNzAr21oTlkpwTTMURzaCbtHt/kgfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N84DbKU8rqPzGo4YB38G/FFC0McO7duCw9No1TfYvlsoUrSZHhkQVwxvPdwinOBvCxCrUjZoNt6+vHpV1vFL312XKOOghgmISZqqFkB/tA+Buy3h5RGNcnliqRzeaicAPVEM/nSUwqEFaRNMD8iYZo/YH4ADBXYSB8Ig5prXfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGMsqXum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGMsqXum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E7C1F000E9;
	Sun,  9 Aug 2026 04:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249229;
	bh=+xqN20OIZubI42d/onSRwD3NkRiKCwjaSoujpDICA78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mGMsqXumf7jn8zvGr1PF6e6mko5cOqig9LZPR1AJALiqlvx9dzIpfsywMQ2cIrpNz
	 A7f4cV0IvN45geFvbDJGG8qglHG88QdYMvLtA6oecheMpFNiPvze/DWMag3Hs3/lWG
	 f6bHUMKY611kZgOc/ctvGD87w+aRdk5tt1c0y7iWdg+pvTpeCghh/WMBwOqRPAQ73G
	 KWN6gg6DBgAgfU4w0fWV6bDQGCctOxzs7NdKIm51LwzDRz6i9GhrBIaIkg1/DnGKLO
	 6t6j4SU22ZWPah+THb7pwSVoms4VpUbCQ1o6UIWZxapRUZ4iBtApmiqKYguaF4eGRg
	 E0wY8kzpmIdvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] smb/server: fix minimum SMB2 PDU size
Date: Sun,  9 Aug 2026 00:20:23 -0400
Message-ID: <20260809042024.1093624-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809042024.1093624-1-sashal@kernel.org>
References: <2026072925-revenge-tabasco-bcf9@gregkh>
 <20260809042024.1093624-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 4c7d8eb9a79ae5400eac19c4f6f0815bff674452 ]

The minimum SMB2 PDU size should be updated to the size of
`struct smb2_pdu` (that is, the size of `struct smb2_hdr` + 2).

Suggested-by: David Howells <dhowells@redhat.com>
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index fd74a18fbea95..b10313cb50ea2 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -307,7 +307,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 
 /* "+2" for BCC field (ByteCount, 2 bytes) */
 #define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
-#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+#define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -399,7 +399,7 @@ int ksmbd_conn_handler_loop(void *p)
 
 		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
-			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+			if (pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
 				break;
 		}
 
-- 
2.53.0

