Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499D81732
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786238524; cv=none; b=q0CATRhGfgBa/UvREIfWjE5mmWXO8PTtAT3+TPN84A7Nuj/1sEnafXhHxdq6nAOGMP1ydTnCzGtphGP5XmrfZjJIlsQUlzEOBjU5uomOUJgs9uWX0JYLd2QkVrqGwJxRzRK7f7OrGE4VaUavLkTtFgb2d8c3iGdSNjVJXAIm33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786238524; c=relaxed/simple;
	bh=ba0QvqE47tgc2wVAcMKfwLTupZSzLQa2GpqD80QWqhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r33SKsFNq/tEtKQnPmQzLCPTGSENB9N4LgoUKYDdR5Tr7pluEs+OMPY2AnSBmnI/a3z/2Yinz2oFR1a8kzsWsq3fw6YqWPb9wW9YxpnDzj5tKuUqdHWqMZhoG6l0FAIG3YyF7Rla8JI1nlIIeNKpsoBgW9LBTSMhsF4UbailYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtGHOWjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtGHOWjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1911F00A3F;
	Sun,  9 Aug 2026 01:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786238523;
	bh=SsCdoglzWbWX/CG6cY/o8FcSIREfaE6vWuHN7URm7wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtGHOWjIMuTuEs/3LoK0/nax+89g46ojpC/l7x6X7tcNuI4qUcsSqayCn8Z/Odf9k
	 eDt1k4eQEp9GCnXj8oCnkCtTkSsVUxijv9ESPLpEw1gO+j3sqdT5/6EmMXXKvpFhQh
	 Yitr/RS7hKjpjbJt/LKeXPgLgHp0UFo1xgJpQ41cKEF8jqRlZSun5vBEQUPxVJ7moI
	 2y2RXxKfDmKsaxSeehYRN3rQbu9PEEOL0At4nuKYU0/eP1t09EhjYnDtW6sO8B4FKY
	 wMxWmFwmTe+0eY03OrHqqCiPqnH+3MDBtoHkPQfXq97STR+S+WmNl1Gvx5Eud1BlSP
	 fO3nXADLBVgNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] smb/server: rename include guard in smb_common.h
Date: Sat,  8 Aug 2026 21:21:54 -0400
Message-ID: <20260809012158.894446-3-sashal@kernel.org>
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
index 612139bdc91b0..26f8c268ece99 100644
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

