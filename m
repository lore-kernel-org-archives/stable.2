Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952C6DCE1
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249228; cv=none; b=PSRAH1i8OFxYJ96uZTmWUT8wDXK4d1H1mudJl5oTDI3CUlW1XjbzXNb1mi2odKH4fxwNN99PmclTj4UUVehu6LMMtUTIvjxftoFnVoIUWkaDYWceU5Xo2VwkDGMIP5Ja6mZZ//JYV1oJDE2R/+XOorYM2uMOoHYHCnFFm+Ukmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249228; c=relaxed/simple;
	bh=Uz8q6/99rnhh04GlB3nTs+DZyvJcc46WkpBtEN7s8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAJywrpub72EuGRVhr3PrSPZtd0ITitij6J+eFIgx1VTUp6h86FCM2pJ9QMIHvLtsxTvPMwu5ArxIm7WzLhqpH/CCnfpKbYYiSKqj2D/HLEVKUPDA/qwrePNNJ+UjZsugaLBL/qhkdk7ync1KtKPt1D14e8daqIwiv2/wwkrjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eudSrVcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eudSrVcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B9A1F000E9;
	Sun,  9 Aug 2026 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249226;
	bh=xLZt/SOSvGIjt39riJ0E4opclOobeYQjv6SoA12DRJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eudSrVcZodclx1gpTF14+skDd2RGnvcLJDkUR74B4vFO1s6k2OtLkx7dqCbJLOAda
	 A/Za8WSNb5lxELzWVzX7ICojdAfmbsU0kmdil9NDBV4aJA2aQYMoJf69H7d/5aG0Gj
	 TnT3N1Ww5vjJPq6WvmnuXPtiOssKpXTtR8pOFDq70/78/feAOgC87IPMqeh1kbC/Ht
	 uEgbxNCUifRN2wfs/Cuyq8weXX+N1RAs7INbdwxny3uUveXoZZ4TnEHWcuMjpEsxUu
	 Rp/oGXvkO7l4oO9hYA7Sl2c6WWdDX/VRX+w8z68n15364PrsBM9jhMKhkD/Or8GZfP
	 vooOYUrJcqCcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] smb/server: rename include guard in smb_common.h
Date: Sun,  9 Aug 2026 00:20:20 -0400
Message-ID: <20260809042024.1093624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072925-revenge-tabasco-bcf9@gregkh>
References: <2026072925-revenge-tabasco-bcf9@gregkh>
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
index b2f8608956cdb..7f44537b73281 100644
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
 
@@ -426,4 +426,4 @@ static inline unsigned int get_rfc1002_len(void *buf)
 {
 	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
 }
-#endif /* __SMB_COMMON_H__ */
+#endif /* __SMB_SERVER_COMMON_H__ */
-- 
2.53.0

