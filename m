Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453286;
	b=R2BPJz6BN5IUnY6hhKBgCuY8a3UF0h0qCfYnqOwQF5HQlpK9K+aDWs1jyu6D4fBgpQ4K
	 cLStpEvatjsK+MV6GpszSVZ8mrC9STIw20I6ZsvQElC2vQVGMPR0k6H4Wu50Ck92oqX1H
	 VOr3yQp3zsBxn7MeQPt9/23Pv9H7xJfwsQTni4N9LftZnHNM1DC3wK44ijgyL4okW7AeK
	 7dxJ5QEWJbONCjvn11rPGu6IZAh/xhDNvgq0wa66PDV5alQuTq8PXSBEORtdzyf1Sdhm6
	 3LrV4tLn3bqpiBWdy0FkUIbPhIaMcSo1Mb/hR4mxSUAvkrZwCFUVVSBdq9YbAc5BnTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aB9Fb4MwbVDdI8c9DTVer7UsKeCqOlrvcYRD3uASDyo=;
	b=wZDoilm8Qm+KKtrrbG+W7SXKGYeNYiY58mZH1vY6HTXh0ft5S9d+J8L2CVEEhn4vQYFh
	 GfeffgbMs/oFoebEBgM/Fn5qcfm7adpVKHV7dsfgLv6Yh3I1+KqCtRPvm7typiv8WG+E6
	 SgKjtbEFB7H/O1HwKnGFy5FKL2AmHW157baYJlLYs2elGi0OnCZAdKIBKe054OhivjY1F
	 yORiHvCOVj1t6kDrehnotw8Oy5Jc7jIW4gR/xjQLiI+jCIxz20kP2rDg8nquuFKZ1hu6K
	 hYmgcsZdyV42Da4Jtpz5x+RWvPHFP/kKfI60oLYGESaEY4zkoSE4nFSyNq449I5cpqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbNDXlOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24E606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbNDXlOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C5B1F00A05;
	Thu, 12 Nov 2026 03:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453286;
	bh=aB9Fb4MwbVDdI8c9DTVer7UsKeCqOlrvcYRD3uASDyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SbNDXlOgA0AHQPui5h0Jxw8d9Yz41uLClJA5QDE33k9OqvkzgN4OuEAkfVGThgZta
	 /Sl0GN0uP3maVZidDjjV35h/vezDrY+KttBkpYQmkzotqDyAmDo6SJuZZPxMaUanWZ
	 dgiKQHkVfPOE94ltzRWvR0m+zMZDkFzj8W/NxyYwpAf1eSwl+OOd7d1+a9gRAW1SAQ
	 B8TEPzgiEGbmLbirUMIPDjE7JWM9IGyeQ6OJtip+t7WUksyEJySU6lbE1ap+7pfAh8
	 Tn8f8PUFPUnX7ENoqyBIsoQMcv9+EQo3WS/1BqqF+x79LNlbdLT/m1J6Ha5S6d0D4x
	 SzR37vFvjiYMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 22:14:44 -0500
Message-ID: <20261112031419.1526019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053937-failed-6.6-cd6d8b189139@kernel.org>
References: <20261107053937-failed-6.6-cd6d8b189139@kernel.org>
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
[ sashal: adapted cache-entry handling to page-based access in f2fs_sync_node_pages(), using ino_of_node(page) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8aa52629f788c..e81ce0b6cd212 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2076,9 +2076,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
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

