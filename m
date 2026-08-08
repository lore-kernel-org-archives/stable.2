Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7A3F65EE
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198192; cv=none; b=XVGqSHcjIpoabgqaRoPUa1c/q5GYX0pMlDY2TNSF8S5Qvvbf6SKMJc/F+ach+HHpuXGigORppn4BZbEPxVdaBM7JQy6+vLzxvbSK7U7HdaDp9AF7IQdAVXRr4HY7Iy0T2LgWCnHpktzdsDqA95/L0mFTVa9XgF87UMpS9v/NYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198192; c=relaxed/simple;
	bh=8VZpokzHfd2eYt7A/wOXKTURFvjJsSjKdBNM4NnQYDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s341cYucqowFBxBs+MTyQA4LXckJyH55ucZ4ua0yx9aMZPNfp1PgLezNl2CcySQ/w+EzkqXZNMHHNVAkVBd/QgwQQfFOymVY9MU3Az6pp42b6TIykbMCjDCAgcViP4bDpEfFjM1aYSlhwRZ0e4yaDM7a/8d/e4ho9Q3u0ISb3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrGFlUzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrGFlUzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CED1F00A3D;
	Sat,  8 Aug 2026 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198191;
	bh=Fn6wTIEfISkaVVxbefF+iYubbMcpvkkF/56oMcsXmqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrGFlUzDBycHGZqK31HA+tRoZ0XUrf0+pULufQJFyfnooYKWQ2E3J3x84nSawXYI5
	 EHw0B2yKUEasBdLPStw09aw8boOXxviSSZnWbRLdQHT/1th3YrN1WvM0oDTxBgE2D2
	 1x0eoafVvegk/sdaHUKhYHXK9WF5l3q80AEhrFwCBmDa/tU/G7RRobMjF6nK6pwsBU
	 c/Z0ogYMYjuxJu+XtzyFlh2dCoPbe0qZqjRl5WMpsG0SacJ3/Cg2ohkMFVnnPdG15o
	 2iODk5iGvQ8vHXkLPfDVuwn7Z07p1m4OpIiX3dJ9fA987Yycp8LdNLag5eRrbYjAgZ
	 ptZkLtl+BLQhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/7] smb/server: rename include guard in smb_common.h
Date: Sat,  8 Aug 2026 10:09:43 -0400
Message-ID: <20260808140948.340323-2-sashal@kernel.org>
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

[ Upstream commit 01ab0d1640e379f0a0d6602250b33ff2b45e9560 ]

Make the include guard more descriptive to avoid conflicts with include
guards that may be used in the future.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cfc0b8e5080a ("ksmbd: validate minimum PDU size for transform requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb_common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 3c78acf6ed6d5..bce7887a907fd 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -3,8 +3,8 @@
  *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
  */
 
-#ifndef __SMB_COMMON_H__
-#define __SMB_COMMON_H__
+#ifndef __SMB_SERVER_COMMON_H__
+#define __SMB_SERVER_COMMON_H__
 
 #include <linux/kernel.h>
 
@@ -423,4 +423,4 @@ unsigned int ksmbd_server_side_copy_max_chunk_size(void);
 unsigned int ksmbd_server_side_copy_max_total_size(void);
 bool is_asterisk(char *p);
 __le32 smb_map_generic_desired_access(__le32 daccess);
-#endif /* __SMB_COMMON_H__ */
+#endif /* __SMB_SERVER_COMMON_H__ */
-- 
2.53.0

