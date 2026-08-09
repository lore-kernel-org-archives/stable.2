Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1D17BEBF
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786238527; cv=none; b=kK/Cdp0U5xZ1uVXEvzOWuI+9L0WA9TDPVBoNCd957jEH/w21NcyAcSWXN+u+ItbY4XU3rwvDZN9/BiBYwRxWXJXbnQkBBqCN20XYhgidg5lxjkAW7GxTOPNkH+bxDKruKZu6T2gJka/rZ2g+pJn1ekqSPuvSiPCMYR4vfW0I1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786238527; c=relaxed/simple;
	bh=JqcZZe8kQY5JFGoRDh9f7EomJ9sVpZrpUR/NJnl5w+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dncxnUWi4ce3dR0PnFp99AiqTzUpKPTZM+VtpMJJGgkJcPX5G/MrJn69DbRrivxfappy5u8eMiKzSM6TOwpBM4JGt0QgHAUvU7tp45qx6laqOmZ/utoHbkteNEHZh803XicPJZBmH6xO/YXLiEXTfmZPuQof2ZDfNWvKDcKpH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AanNCgwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AanNCgwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345B11F00A3A;
	Sun,  9 Aug 2026 01:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786238525;
	bh=ybXP/cHlzOrsu8R264AVtK1f1AOlVT1FlVZ7FdF9c2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AanNCgwJo2w5MqxMmTSr0vVk2Bai+sfymqPhJPVoNbli41s+9sF4R6rOfXR4RlNqY
	 q058GeLbMkKaJlOD/c7Iq6O6pdAkGIE72Hozoedcjnq0sDKSHI8iaK7Icfl4DcSioW
	 h9opVLdmOnnllRIeygTTvJm9mZMsFqDxTriHc/4hlHn27yFm4VX/qZCeqPCiqw/FOG
	 Lai3jLyKWGoAfw5Es2eXUB+6G2Hm+7OphtWSgqsi3uiAc3u9+86kKZnW78n1drlmdW
	 p4VB2NBDnpIVFYjJsUH5SHVxyliMw7Hlo+6yXXUO4Q9IJTKwoD4IIk4nXGk5y3C2C7
	 u0AfJANczEBBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] smb/server: fix minimum SMB2 PDU size
Date: Sat,  8 Aug 2026 21:21:57 -0400
Message-ID: <20260809012158.894446-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809012158.894446-1-sashal@kernel.org>
References: <2026072925-unloaded-borough-0d66@gregkh>
 <20260809012158.894446-1-sashal@kernel.org>
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
index a1cd1e0076599..b7f83c8d39762 100644
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

