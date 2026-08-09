Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695C1531E8
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283686; cv=none; b=BlPufdqJfP7KExFUDiQDGiWzhaf7YMrbv5xoKzuA6sSRg4jhA2CE08ono5qZLD36N2Zhh6tukZVNJrW6jWtfBzgKMj7E+hHEw961CfwTR06TvhCdl+bYOCMo6oAZb46u9U88dlvzLdMCzTNREDYv+zeVItUEwXOJY0AKIHN9kQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283686; c=relaxed/simple;
	bh=AJdElY0QB/+LcauqwN9rzDg6h2W7cRslZAeVfPC11TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUgJREoLrtyYdK7BeWaMWq3qBWot1CDDMrFwsnBCZBnL6wgn3emdWSMTqVMZY4pPpsDLr1ZbNShrxywU/knQ3mC3gnygmjHsaEjotG1OmVqJgXDKm/4ZynZ428/NlHEMlV2XgRIrwnOS9/5gYnEjjTLYN6LsZ+pw3MzwQUUX2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ceye2EbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ceye2EbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68C1F00A3E;
	Sun,  9 Aug 2026 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283684;
	bh=eKeue4TR2//zyP89FiDsdu2W1d83jIhSflMR7QMltBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ceye2EbX2FrszmBFg7AEeyN8fITKHMcjcw0mGX5U4RF7zpGGD60LV+bIo4apT/ghl
	 RYba1q12iDAxVdw8CfWcK5RgL14LOs0fVclTnpr95sZIKOdRuCHXsXZZb1l4koo0y1
	 tvUVLjn1cG4G67S2GEQtQKFyjUhK1qB3OUWr7SiR1NtqlCnP3/V6uU/KeCz0njAFhI
	 r+8ku+RXjXQcxf/T951BI+QSfPgOK855+QBfi8CWAD6lF6Iw+isfXzLMf5JsnSAsMh
	 sbwTGIaVmDVfOqL6UnfgLhHXuUo1H7TzH+SV4saJaNFyvejnJdfKYs9wDOLzp+r7jt
	 zlP/SaDEkLBHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] smb/server: fix minimum SMB2 PDU size
Date: Sun,  9 Aug 2026 09:54:39 -0400
Message-ID: <20260809135440.1507266-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809135440.1507266-1-sashal@kernel.org>
References: <2026072926-trapped-grumbling-0f6e@gregkh>
 <20260809135440.1507266-1-sashal@kernel.org>
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
 fs/ksmbd/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 3a86758e99897..399ac2f15c60a 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
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

