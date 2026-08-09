Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3E81732
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786238526; cv=none; b=XO1Kj2DrLU1EbFkWKA/qaMik6djHxvlYC9lM1wjF0cZbWaQVqbwEnAYGw719yXh+mnVGv1M6YZKeNPPogrINgkOAkBQUvOoi9B+masDzUarwVAEn2hxWeRJ1/hqhSV8cxdJj1YUWoVvxXYI+CQwy5sU8HnUr3bivdHsIwrHLvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786238526; c=relaxed/simple;
	bh=aX1BgPq4ZdLMVR2Uukw1bCArp6Qk4qTl6PxU6OsVvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEyLsE0xZzZVqGxCJ8jprj0dultpsQR+DwzvQyPFSLt1maXJTx/Dy++3yMdf5gD7kPZbxH0rcdjZlu4sZ2QifXgz2SeMXuEyLAxPSwowgRiXeQf+NfjLfVPoo9SNwZKSUYIZhutcLsWfS1W1ou6ngkCFerXpthXwAH+C5MYx2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKPBk5Wx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKPBk5Wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E78C1F000E9;
	Sun,  9 Aug 2026 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786238524;
	bh=FI2dnukt6Z2cANMCYNerC6rpo8hLwcW/nOgTk5vTdew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKPBk5WxcPmU1RJlbCrfmsPWv+cK0R767x8xbC8SEqPoB5X6OIBIm30fiHqnlJKYG
	 D/KJdRSwpgejEy1Rsvcbf/MdBGLoIj0Tt0+/00GRCVAZyEpSyVMMUwPO0drxlyhA8N
	 to9N24poY5KYjHy357UfRkW4zLmwdDkwwblxB6VYm2lXw4IAzkIDof03pYe2bsqNE3
	 DNOUH3xrOYfoY9XKi0g9okscelqNBypOgNh7zUOGNuO3CdMFWe//PwQ6TZso7KRVKU
	 a8HRb7//On1R5TNr+r9j2BehEbUrtaYW3umXfoTgAFYyf2a8EA/OoLmOmoP8haPT+R
	 yeIgq8seBTOZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] smb/server: fix minimum SMB1 PDU size
Date: Sat,  8 Aug 2026 21:21:56 -0400
Message-ID: <20260809012158.894446-5-sashal@kernel.org>
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
index 82bad1745a507..a1cd1e0076599 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -376,7 +376,8 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
-#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+/* "+2" for BCC field (ByteCount, 2 bytes) */
+#define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
 #define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
 
 /**
@@ -444,7 +445,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
-		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+		if (pdu_size < SMB1_MIN_SUPPORTED_PDU_SIZE)
 			break;
 
 		/* 4 for rfc1002 length field */
-- 
2.53.0

