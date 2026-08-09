Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D10305057
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283685; cv=none; b=mmi1REhfG7BY9Gi5ReOVhVxHanXtNHIvNlCV5k7JUOo+2DxqIGZzPf/5FwyzI7y5BgCXMdCmuP26r3qrNj8OrVpBmBz8FGhC+nIlDJEyAGh0QpRItMDrNe73cr/0m1cEkhg9/7VyiEUtjloHoppGpdbMmSNre017wcSsvpOlFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283685; c=relaxed/simple;
	bh=0RA3IvIDPnxFi/DGXPhz17l7sV3uHbQS1R1GLo3otmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxVQBnO0mAGc1AzuLgFp0l3RUSESHSO3xk0H9jO3aBKnd97UMHkEPaTbYoJU2jB51clFyd/NRUQJzSB+dJQWLJK8fe35iudSop/DqxLz/BNN3atxwxztdN/+F/Q70cjlQR3iCVEXFUIKY7fWjHtOKlqIaMXlcb/kYrVhGeambCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjJuBTHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjJuBTHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DD1F00A3A;
	Sun,  9 Aug 2026 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283683;
	bh=X6dnGRvXGTqFCLEnTLsZd5PQpgM4E9roXV2u902NcGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjJuBTHl2Qa9kytxg0hcJPMJ9L2aU94CrXFLbt0vGsZxVceHKSfzTQ5/aRuuhf69f
	 FtFqIbFdKJkgZUz3IEaWWrfzTFSx/VShtRPOQkdtUWUZiMNgmaSRMui9X32RDXi/o3
	 ECi9TervGqE45+98HcC3+HR/sw8F+HD6R3aFlqhE+TcDL+HC8KcxRsO0Kc2AWH2crE
	 YZ/BkL7vIlBfUA+IOA1Ui3t+d8E/TF9gC6loQDRtvp6gZof3M5X7FUgyGmFkpgBeND
	 bguVbotTQDjQFkNEovRQOlbek+fJ0gpQhzHAMj7HK0sUNt7hmzK3Rr+0Bk682qHonY
	 cwSrVHrpap+Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] smb/server: fix minimum SMB1 PDU size
Date: Sun,  9 Aug 2026 09:54:38 -0400
Message-ID: <20260809135440.1507266-2-sashal@kernel.org>
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
 fs/ksmbd/connection.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 0e04ad18c5829..3a86758e99897 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
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

