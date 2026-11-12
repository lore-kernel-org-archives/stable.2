Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453051;
	b=vQm4a825NJwcEjbEmGDI8KGXl6gyQ8V+qz+Lpm1vTf/hVse+0eTE/44YFHcMayRDj42b
	 9771bOF4dZFpcBYafMD4aBGjGXhackFbXilSK0+pNn35aG1E5XoJR2FGO8OEP4c5Bl8Jg
	 n5r5vMuJmZUuGce99L9XB9JcmMIGzL0PCf45WyIbUWC7i/i5JhDnVrFMi1yEmuy7j6V5F
	 mqObzmHB10JgSYtN7GNecuB7Aop0ayCcIKhtYc0yL2DAJdHcI22KGIyFk0RIMr0+cj3Wu
	 RFP1vMxDrJuHY6N3SXgzDlDWoRrc5VwrlonlJ6Ih64qFflbGbElnFJVIBQFIJIHStKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PSJ+7rN3CktjZH9fwWUzjLqpnJaD5KbAKh4d7D6IEOk=;
	b=qStEiwF7v2KO5+ZZbsjrFufHXAKw/oW816rM+H12S5mVGBq1vbBAu03EEHbkektVcrZc
	 e1iT3U9IZlSdCggenrnHOfaPjY2XjXTK1WPPihCauMLelqEn/K6rgzitU2t4D+TopPqGz
	 JmMdKWaKxNpM0MzMi7p9x88mVqC6lajPrHLqbjhBliUoXYro6gx2C5M2OTc8uMjfHK+QM
	 lepKMkfIH/zYHD2/EVvbfYOSEQItD74v57hz0dgkce9nW4co5KxtovlUEk/oayevBlrzt
	 eh/qB5PpuvWjtxCuWi4rLQ4eUcPfNHjjKjNzDYzcanP/E3RtH0lzHxpJ0EZ8p96+uTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du6Zb4xk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E9606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du6Zb4xk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896421F00A05;
	Thu, 12 Nov 2026 03:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453051;
	bh=PSJ+7rN3CktjZH9fwWUzjLqpnJaD5KbAKh4d7D6IEOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Du6Zb4xkKZ/SVLXZEWTVBcCtSLG70z11UBK+e8jBudKX4A4mYAbLydeH2Fg3j4Bzl
	 KDItuq0KM2R8XNY1PR9/ZK7jGAgLcrha2roviQkV+qQXiI5xJVL49XMV7d2yof59Qh
	 ImeMfGl2V4nrf/j3SDnjJ+zGxrO8mb/lmDfc0031IBnCodOoYe7MFwYNhaxDfvIkuo
	 8QHTpVO5VeShDk3zYadYdqlUrMEIRInVCD3HhcU+eXFnhS/qPHsotp60XJ+yGzg6ZH
	 Oy1CORVi1X23vIofWVABeI9xoV5F9TG+4HcuGxZvJ60mWfMK+GXp5NMcHLUSUTKvpD
	 KMy39o3konGjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 22:10:49 -0500
Message-ID: <20261112031033.1479912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052650-failed-6.12-cd6d8b189139@kernel.org>
References: <20261107052650-failed-6.12-cd6d8b189139@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit cd6d8b1891395b681f2060916a4b83880b765698 ]

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: adapted node cache access in f2fs_writeback_node_caches() to page access in f2fs_sync_node_pages() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8a11623dbf1ef..d36b8de23d678 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2088,9 +2088,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			/* flush inline_data */
 			if (page_private_inline(page)) {
+				nid_t ino = ino_of_node(page);
+
 				clear_page_private_inline(page);
 				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0

