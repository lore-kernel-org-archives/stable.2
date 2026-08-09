Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431778F26
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236496; cv=none; b=h1GeTXCLnfpWLSIUKqM1ibT8rxrkT2KBGPY45l01PhwL//QEwTKI+rtPBJR2sZolItbbZYPwyE4ie4+7apauLFMCzj5KdvzHbgWrLqDFeupqjUNjIsWs82N3F8bPa11Wg6gd7BxCJ7uuE638xn5xzqvEm5jskYMt2DsZkRRvHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236496; c=relaxed/simple;
	bh=/QoSZYIhphbO/GgtNQQ/2XaAucMRIH1Z/iKVDHQYsYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4IeKGnB3GLtVj5cTXs39504neGL9r7pgbo2SzW3KcwpDEpqhcUX9KuKeIULwbrptPfBi+5Z28T3LX55MxXkAT82pIDfmuucQYNbISIlMAV0rxBAZ4ISaI+cfBEqeNc0BtCbxbK3dwRBNWclMlVQp5CNfy3L8yyZCqgcNTRRLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzR8bcQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzR8bcQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74A51F00A3A;
	Sun,  9 Aug 2026 00:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236495;
	bh=xjrzueeZ2J7NyVb160ySwjtpXYOAuW57v2t735AFKRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzR8bcQ3V5jhXi/pOOfvxhU40hpy73BEi1w+7F2uGP9Y1l9VHS4ekoklDmg1bPsxK
	 hzL35CeS/7nnzs7/SeOkXh+uZfy82wU/4pXfY4K0BfemYQSWmV3MIoH1/N32lZEqei
	 Wus2nfKZzVw87SYTpo55be/FCj+kggi1oKuHMiMZWTMHCkvwrPb6kDqX4pohVYCYmc
	 Ea4GNEiSuW5D/tPMuJSuKcBNyXSMuGtfFjpf3lX9uJ9M42fXbvcEifg5xU31nrI7CF
	 UNZTQjIE1ZmKn8c2za6SNxp7uft7/B/ADn/GrmDopkSfil+EFFqi//Lc3JyvPE99nK
	 Mo7TSQb6nZUnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] smb/server: rename include guard in smb_common.h
Date: Sat,  8 Aug 2026 20:48:07 -0400
Message-ID: <20260809004811.874454-3-sashal@kernel.org>
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
index ccc7d94c9d09e..42054a3846523 100644
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
 
@@ -421,4 +421,4 @@ unsigned int ksmbd_server_side_copy_max_chunk_size(void);
 unsigned int ksmbd_server_side_copy_max_total_size(void);
 bool is_asterisk(char *p);
 __le32 smb_map_generic_desired_access(__le32 daccess);
-#endif /* __SMB_COMMON_H__ */
+#endif /* __SMB_SERVER_COMMON_H__ */
-- 
2.53.0

