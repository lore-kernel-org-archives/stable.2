Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD56DCE1
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249229; cv=none; b=f0CYmUlKt8+suSJvAc7V9EUnAc1e3pv+Yk5Avp+kMZu9E71kErJMg6vM8PdNfOCBNU3jSA/QotEW/A0z8ujJiKHZwZ1c0pENtjmicRl/pAUy162THrdrtM+pUkWdpO9stqBP4zMZvph15/WxKhApHkaFAALQI0u+RpkqeeTmGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249229; c=relaxed/simple;
	bh=Tp3q948SkBk0nmmC4W8rYf8IMW9qo6YkUWe5TiwbVWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAptPwNxRJAbiWF3ZZ5OQZSGazt8QYmOk2gRW+V3c9NPEYQSk7Tp5XbRwn/zbT/5W1LdW08WISxtPW1uhJBIdrq3FyuTB4hYMK+0pyvkfZ9wJqH7qnKTDH+am/n8f787hFDk6dS/f/tLO80nJqFnlmf8vpkGy62Pkp+pAfSF9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsfTx/CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsfTx/CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16401F00A3E;
	Sun,  9 Aug 2026 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249228;
	bh=f3LiT7kU73WaiODDJ9iamxYpz6um1NDXCbQtVCbO0sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsfTx/CGSYGwtDnoKpb34s3hRFqlsE+/E8OSc9umhYQ4Ww94AD6LHn0j+JWVetokM
	 TKwJEp+qraS64tNzzL79wuobWvoHZetW2COlFB9wa+Iymsacd6M00lWGoYLn1tma8i
	 UHdDAlEoj1cE1JA3vvUIbGau4Bf2dEJIcauN31+qYazT/zk+m8h7YXo0lxGmh17YyQ
	 rM2Q/HPFk7ppdYsFJOd3S3nTNwNYPvTyTE8XwBwue99OSDnjNIJzxcIht7WRc4tVmm
	 trzm3HD/yaOHeXgy92im03X9CmY/24CpspJB1v2M4J+SqCQOK5u3Nm4lkKzm71Ie63
	 336rBieIhHUWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] smb/server: fix minimum SMB1 PDU size
Date: Sun,  9 Aug 2026 00:20:22 -0400
Message-ID: <20260809042024.1093624-3-sashal@kernel.org>
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

[ Upstream commit 3b9c30eb8f5aaad4a54cdfa470b74c0467cc71e8 ]

Since the RFC1002 header has been removed from `struct smb_hdr`,
the minimum SMB1 PDU size should be updated as well.

Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
Suggested-by: David Howells <dhowells@redhat.com>
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 2fb2f900f02a0..fd74a18fbea95 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -305,7 +305,8 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
-#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+/* "+2" for BCC field (ByteCount, 2 bytes) */
+#define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
 #define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
 
 /**
@@ -365,7 +366,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
-		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+		if (pdu_size < SMB1_MIN_SUPPORTED_PDU_SIZE)
 			break;
 
 		/* 4 for rfc1002 length field */
-- 
2.53.0

