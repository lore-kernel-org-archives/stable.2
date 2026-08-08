Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBA418A44
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198194; cv=none; b=p4HAGgR0VpNrEIP5R4FAtqJnhad3qGXQKBkmelW2QAyN35ZLqbPnWA+b0bqfOxx4BQMlVl0rWBNoDaj8/BrFv8YhOmEabfwGG6slONLQ0cmDDeWQTkS2HCPoFzGKAkqKru5DOIHTphZYNZlMc43CqylguIrpTSjHkJ9q2jR9Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198194; c=relaxed/simple;
	bh=DnFdA4+7RJ7ak2ZbFxBP/qtQmQMTxTqKoseLe0nOHQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5ays/m/fwTNpn6ajZxMB5q/4ACTOCRB6u2N4gCRbjM2JfM+pJRR3zIfu48JN0eSf63n0rq7ViaUraQqTty/Q+yKj74Nsu8cfdJrGJeENG/ptGbuDk/MlViGyk3gbSGeUrq/PLR6bFqXys/d3TQQjhT+CWx+nRvAOvbA0EKW1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9XmMsMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9XmMsMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C411F00A3A;
	Sat,  8 Aug 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198193;
	bh=vXBfCR8MZGsHZw4ACXxHibCAwEeTbyKeFct5N1YU6Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9XmMsMtNEDWJ+9SrjnW1wMMaUhK5MTxEb1Rvty6+nhzhXo9USKJFpNynbc8/RaZV
	 YEmoVtlzmFQ9tyTJRMP5yDK805CNGiqL/hI4yCYYdOC0kA3d+jfXHq3KWxdHRBURUh
	 IkQfmK2z0ubfZyttuCj/GU1pZIVI56qu/JB/qPuWXHC/thl69LNUcqcWUn0TdRRdHQ
	 6DFQTGHyIYl2qlD6Q0zXizzLgt/E2kg+I6vbusj8dRIon39MSPpew1TLfeTnIzK4WL
	 n6UPrOre+ZIdsNGSHU5BHDgeI0nG7eaR5q52VzWHJX7T3jVl4qI/Wf6734KdWwKAog
	 l5DfrU7/387Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/7] smb/server: fix minimum SMB1 PDU size
Date: Sat,  8 Aug 2026 10:09:46 -0400
Message-ID: <20260808140948.340323-5-sashal@kernel.org>
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
index edab0edaf18c3..0c583a7aaf1e2 100644
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

