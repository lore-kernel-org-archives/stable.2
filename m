Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF27303C8A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216222; cv=none; b=kd8enyZa1125QC+WXrX74HNL+SQJii8PEYRvR7CFBfPCVpGmmB0iK9fTr4K59Rfh4JzvjT5deenX+IKvBuXxfL4CpZkD1njGcq6RaD3BMWOCuA7ItlXPV37pD58uQiPm2AvxY7fxjpG9gjtHwRAwV/+6b5TVMmDyO5Tr/jHr+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216222; c=relaxed/simple;
	bh=LNI2yy99ut+xgvF0WsUNoCcduezAo4257NFXm5MdTuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPV79+AOxsZpEWjEfZoIHYVNhHiHzOUlLR0vqHYcm4m6J+ozjPG743NPFPEFXt0B0k5MCmS9293ZaamSCBn2Nt346R6Dr5JfB72i0QP2YE7fc92b8xxdVbDIZW5cbJO1Ke9q7YcTGWODq8p/w30weHOa4xRflPoSma3+lpHHqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeJZbXeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeJZbXeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044F1F00A3E;
	Thu, 16 Jul 2026 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216220;
	bh=y7pSb9y7IZb3fsiA4Hxbkr342UqB8CMTLZ5UBC+hwOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeJZbXeZk4/mfX9icSxvU2v3UT1ij8ch05mhqmoKASMFt1Z+7PWjyIc2pSfvQMWl1
	 iVFE3f21/EfyQ+KBlXsitZ10JDzKnK4QdEogWM7Xs23t5jKvY2+wZsAcD5qCLvcYFH
	 F9zLVVM1Hvc43aJlcJRqNQjLvA1+7lgk1gxwTN8V3SSPjVYDQFH6tdWsGTTdLqqKGW
	 Gg5eOi6RKKHql3NLkf2Vd5jo+30s4z4TC8dfsUILm5d6RsQ5V9MCFWrxkhx1XByVqr
	 ygemv011KXrx1BdQyGGweBpjCoTHEW3u/41aRf6sEsILqoeLXIKsXBWSzzjapgpoAQ
	 yzUTWKHYst9UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] smb: client: Fix next buffer leak in receive_encrypted_standard()
Date: Thu, 16 Jul 2026 11:36:57 -0400
Message-ID: <20260716153657.582978-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716153657.582978-1-sashal@kernel.org>
References: <2026071454-rotten-imitate-b195@gregkh>
 <20260716153657.582978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b ]

receive_encrypted_standard() allocates next_buffer before checking
whether the number of compound PDUs already reached MAX_COMPOUND. If
the limit check fails, the function returns immediately and the newly
allocated next_buffer is not assigned to server->smallbuf/server->bigbuf,
making it leaked.

Move the MAX_COMPOUND check before allocating next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e1bd7b070535a5..022e99d1241b1b 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4961,6 +4961,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+
+	if (*num_mids >= MAX_COMPOUND) {
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
+		return -1;
+	}
+
 	if (next_cmd) {
 		if (WARN_ON_ONCE(next_cmd > pdu_length))
 			return -1;
@@ -4984,10 +4990,6 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
 
-	if (*num_mids >= MAX_COMPOUND) {
-		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-		return -1;
-	}
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 
-- 
2.53.0

