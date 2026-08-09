Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCB22F01
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236498; cv=none; b=ql5z0esk0TjYqn+wIEqhvS35Mn5eKd19mqjfuOMraM1elzmnR7LrbRtpHBsc4n1i5r8NK++7vDuig09m1edg0o26e9/AFEh6hSpuZN+MqOlmlVRLvBHPIRiQhi2duWaSKRYmXD70jMPTXEgO8u+V3OUK1iEZsGp1+zk050LYGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236498; c=relaxed/simple;
	bh=Ah/K7kOAP+vfChyHsBPHITnxuwiZD+sG7BVEglZInxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cINGYARQw3k4CY0N7XGUXHAkj3h2FXe2cJmKD/RJT/l0/nOIJzgXI7feepA4p/tRJ0m834NfmuS2/HUzGW8X1WBjGbcXkbdhYcijGzqA0NQ4J9kp6MEAy5CmVC24xuuaLXJEa6YrhAR0L+umz+CjV31179mFPh5/dcWwtqSaEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2OGzT5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2OGzT5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B603A1F00A3E;
	Sun,  9 Aug 2026 00:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236497;
	bh=ZYjTXPDLc95RXT7jALXXiRh0RnY8kAnyduD4hUsNPPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2OGzT5G4EZNItW1p2NRx/4feS7CnwuMWYo2II7hopp2w6BxKFvVSWrUCDFnES/la
	 R7WFSkf1+rcuGpo4gKXrKZ5RAm8QdVhnncRQ0DeJquhDcKJJWYTj3jKBu1WmK5v7ly
	 2DYj3OTW/W4ppuq9cOxpJFcD26anSUuGJDgTscc4A5TAJ1C5eB37tVd4VBqZFJKTZs
	 hJh4f6nq2R31f/AEux6mJiBBlfsBKcJy5sD5RBIfLRgb2G+7BGoiN7TtSUdiJuEge5
	 J7ytGdAclXHYt4LXSPrKyf8jHpdQR45M3AUvpQj0z9FZvp6SzlgqjBAqKuzFxaPKms
	 ue8gHTkaqpQ/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/7] smb/server: fix minimum SMB1 PDU size
Date: Sat,  8 Aug 2026 20:48:09 -0400
Message-ID: <20260809004811.874454-5-sashal@kernel.org>
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
index eff5f3ee71d89..52ed6acd1c682 100644
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

