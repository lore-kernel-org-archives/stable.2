Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816122F01
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236500; cv=none; b=cmcWsPfXLW2wI9JBuRBx2V6cNXrnCa3i4Q7OcMzeSQxTjBPj+MnrNOabPmkI8AjZjw7dAEkOuIsridY3mdkj1IIzEeo1j550/xH7sU6VkESw4a89px+F3kTlA9UKN4ah2HtJaX9Bpbk8y30pu4WRS31S+6iwpaJXBdLRcrezJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236500; c=relaxed/simple;
	bh=8kDB/moSZwWNw8uNbG9PO3H2Tqkr+xGJGh7LdosJoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHRMUJoZBdseCoRtvlIIz/9RsRz4HdL91q+ilnoPKHXkrHqdtEoTb3DBx4xdr7117ffvuSrOEejwa5CUcYFcILRBo50U/anXPrkQT4mnhotU6JN510xNdr1T7A2TyDIbedo6mtdI/UWEhFLHwQjQ1X6SstrMb7brPJ6rQ95GkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC/Iv1u0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC/Iv1u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059841F000E9;
	Sun,  9 Aug 2026 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236499;
	bh=EtQqYQLIHyzn9m/Wkqtv0/l0CkfZnk37ehhyvPksJh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CC/Iv1u0MHsrc+7Fa68E9C/2Sq6Hm+fE2YnH26gysGPoZBxc1QtGf6XyoCzEHrKcP
	 aCvIzHDsif0eTcXT/llpvzRMI58mlslLmscnMxhC5zeqEd56dBKgEjgYMn5tga/7uQ
	 K6pM87XgnKNQf0w3OCCyYFEt4fy91+clJUwiUXUwl7/ko9p0etiBq9p3SSzpItdWN3
	 oqdUYSrGb/MNmQN5JLuJLHeAXJ692+DPmZRZWVRotPQk5yb0MJUULK9GqOHO60aT98
	 wfPQEPycm82rioE+0r42ujlcH01svU1P4qyUh2tggLSzEhmkxiX5JkzHB3191n19nO
	 6aCIfcdYjaK8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] smb/server: fix minimum SMB2 PDU size
Date: Sat,  8 Aug 2026 20:48:10 -0400
Message-ID: <20260809004811.874454-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809004811.874454-1-sashal@kernel.org>
References: <2026072924-music-polyester-3132@gregkh>
 <20260809004811.874454-1-sashal@kernel.org>
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
index 52ed6acd1c682..9b5d95d0481d6 100644
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

