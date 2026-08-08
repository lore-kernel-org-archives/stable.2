Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAB416CF9
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198195; cv=none; b=Idl4wQi4qn3W4LOLWCefArp4ZiQbiwxGo+j+zd7tEjpjBrrCo+hNpWlQC2CfrLlwWxieT9C+556bV1XvFp2hhKD0a0o17nRJU4w5Kq8Y9TuO1fmf5Q08VvZgOKFKPFXHpg9wSdz0lns+9UyOKTlWXpBJot8CWPbDFKLWs6hCrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198195; c=relaxed/simple;
	bh=B380P6LNImf9z5nf/wzfVSCNJlmduUAX0cJPA/6x/SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6xjWcCEWZZSRkqfv58ySk6ShyioflgqqWNndIgR9t/DCXB3YNgF7Q+OTl7d53Af4ExlfyZLcTdW7EvNP2jMfwW9Pb6Qi7D32dRTW58EhknSC4ACGgcFX0+avWSJlApjDzncigJ9LmuDzF+FG9liwDAdAEQEZidqk69oK1PEAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTMNccgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTMNccgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E655F1F00A3D;
	Sat,  8 Aug 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198194;
	bh=+DcKZwX4ZLVqtfFs4GXFk4bpWc7wkbi8Jeg9F4U/ao4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTMNccgDjIGkuBKIeYWaB1jdF7HRD6aaolp1tThZcVBhp+VWK0ZYKjAujcvgwYNxY
	 GZOo2dzISz9X3cqx7dzXGD9oBtCZOHmn4jE5iPIccP/es25Ge0Cl74dHSVfmVX2q36
	 9QmbRdBGIwTqTYhj3HQgxr5bQNfCetxEpSuChZfoNX+TzZA5MwvsHyMlLw85WHSLWk
	 TfJyyvcuzIV/Kry68PxZsa12muLrTmPhkaeejOrz6tbYCCqpILHUcfgSj2uG2C3t/7
	 j55X6n8V6f2f5I8h8bQEvDKYc1FtobIU4QBV9kR/w43oXUJQur5LM2tPhfnJLRcMaL
	 x3NwETk6OxW+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/7] smb/server: fix minimum SMB2 PDU size
Date: Sat,  8 Aug 2026 10:09:47 -0400
Message-ID: <20260808140948.340323-6-sashal@kernel.org>
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
index 0c583a7aaf1e2..a50213e4307e1 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -378,7 +378,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 
 /* "+2" for BCC field (ByteCount, 2 bytes) */
 #define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
-#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+#define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -478,7 +478,7 @@ int ksmbd_conn_handler_loop(void *p)
 
 		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
-			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+			if (pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
 				break;
 		}
 
-- 
2.53.0

