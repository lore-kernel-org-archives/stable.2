Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453600;
	b=kaWcZCyMIosO4NSXTbV6jCsfcFHjkSoOVOcow5znQiSfhGFM0xByenvMaduERk6m/tIb
	 dWBulGls3/LeYMF+uivTZiZIcZciTwDVnNbgRefPN9p1xE3IuxXqXfpzFKqlki8F8ZRHw
	 SaF8wY9xmUuu/PFbS9TyQOneM7cyFNKFNDkPfoWiAShep1G8tf72WDq04C3jSh4MFwJWm
	 03kQ7QLWgbXrYsvvefswYpuDBQDMsSlN10TyYzsPM1dnMSZyufIuR75eofF0XD3BtvpmF
	 zJ2NxRV4NoZ3qymFkM65of8N1ptlMSxvYvcXaKJ1ypeSBd7pG9w9f7PKYJpzOkqXYdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JqtnGZxMojerQKIlLuRubJx+IIFcUPKH8n6sLbPRg0g=;
	b=wuRRwp+6A1UWXHaPqW+J0o4gqtzu5pj94ftY2m/Lwi8B/4bdY1BX7SBwftfVPJMWXR6D
	 f2uyLGqr3qsa71auN13Jd32tRtKorULVEUpR7Zvg+eK6sglQwDEwwDHTpUbUzgsVUs4bY
	 X2JIP9Qi5TDEELvl3hSjt25H80sVUp2cXg2jnX7HFhhFvmRTQRCO0XFc/M2Ikc0MiLptx
	 HhSTUet6LDj9CqzOjTfl3t4Uhne6gcHiYkUpLmWotIP8OH2qQcClarxiG8ep3KQ3rdzJC
	 j5Ryw1/LrkhpTnnWUDHlbINeQ9bHCPk3NkMU/jDnbwBP8Z4/sQkounn61vdQ5K0IcPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5z7av3P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F8606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5z7av3P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1928F1F00A05;
	Thu, 12 Nov 2026 03:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453599;
	bh=JqtnGZxMojerQKIlLuRubJx+IIFcUPKH8n6sLbPRg0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5z7av3Pqoi4SxlYIZ9R0Seos1R2Ww29MrkJvdQx9gvsh2/3my0+e8683WXMBljpU
	 fv/ghI+8pCrCqNYQorbQ0BK//wznzWPKRh5g95+Q7WK4qR6aBrbVuN3/+82lnQ3PL7
	 o51lXenVBCfypNee+PhYClTKzVBPu0YQo7ncQHaWFDRtWAFLr7/cbm5IyZlgN9Q6BV
	 +IkJqSHg0Kj9HJdcjU5qGSlONV1x+4qvc++WdDy8/Ybgo6p7T4XPKQ5y63O3o1MA6M
	 Qf76xD/ZhdFrEclYXqNJqK4/HRp/BsdGu0iG1m6T0EGDL/MeUaXsNlZ+GQvRLy7ki8
	 sdoTd2ih7/3QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 22:19:57 -0500
Message-ID: <20261112031934.1536570-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055525-failed-6.1-cd6d8b189139@kernel.org>
References: <20261107055525-failed-6.1-cd6d8b189139@kernel.org>
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
[ sashal: adapted cache entry handling to page-based APIs in f2fs_sync_node_pages() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 233448ba3a299..d00c8866a1d70 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2061,9 +2061,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
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

