Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316293;
	b=Y57A2gYJ9njC/8gwTsJLIuWG8mx1Bi0SqRJaPOv1R8H8tj2IBp5/OxWpY3kmR+2vojnJ
	 NtPlKELlAV+hUo+kRtr2VHG7aYkBympkJSuaYUA7CdjbzVXor7W7RF16/R9J5Rb1k95c2
	 WxgcoFcwXtudofh52huuMX+hITRQRQFjeYHpxGdPukwF2rTrTU/va1nGvXnYStuRPXCHB
	 C85VYksHMxxW4ZORPRewn8Y1EMDZBu/TRLyrqMU+xH/RgoCRdV0r3iHRIdqtD6j/Zq8Hy
	 zq8bX3r7f76bLTi9lqmRGzyStOsgSgdZdKqrqU4KWJdoBYJSmJ5Y4QK8HTtqzQNjaXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3lY8QB2WONU7uSrP+Yx5/bB/kgV+ERAksq/tZYWx0o4=;
	b=hS4KKLANyYfs2IVq3LF8yZZa9rZMyuaa/yXyrj8hP/hGoipmwBXsL4c+c2ZnH+vGOnd7
	 68ssPvh9rsimvi0lK8h3VNE5n1hxeaXX3lcxB1vXuz411k2Ihma2YCuA2UZXm72TK1Mwz
	 3pVg8ltwiss1qq6Ryh1us+irI5WhOdqF4E8ZFNnGmNhyh0pmYstQiNyYwR2k8DN7AJMKq
	 gd+xkexyiganT22mtvY5NZYTX/MkndBoAjzoZdD3HYTNaGk3FLP0/QeRTsPcGvILMZhOI
	 T/+Yy50UISs+wbdpYS5+PtzZ28pS0e4wMTa6x3eB0hJtWaUc3RZDWo9yBZJFbvOc5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HP5DwJsw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA0606B2DE
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HP5DwJsw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42231F008A3;
	Tue, 10 Nov 2026 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316292;
	bh=3lY8QB2WONU7uSrP+Yx5/bB/kgV+ERAksq/tZYWx0o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HP5DwJswRIVAIHEwXXYF1jl5ycW5vlu9FrPGnHyq4hD+/l+MaWg331T90L2x62kq9
	 XuS37KtxZ5vW/XxhB9unHUMVZBCXeHVNiPm8dWKJ2vwBUUDfy6kbVZzi0JDB5JyRK4
	 Vl6pFLdaHCkkdJwmVrhhcYU7kLrWqzDh4NltUMN0gmBUH6hCxoe4SN1rMZgehMP99h
	 jVxyRxc0DRFRiwP9XenSSY4l4dyn9DnecKrqWhyQp03Wz83qraUhkA6MmIs/AFBsQL
	 eCRxxCDEH7Y8D+DQcud81xEPqvAURzQZvyVThGvPmDOaiQwc0AgqTFkZp/1frgsa57
	 /cRrX68BzXiXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
Date: Tue, 10 Nov 2026 08:11:30 -0500
Message-ID: <20261110131119.1670286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050804-failed-6.18-1383cff4ccf3@kernel.org>
References: <20261107050804-failed-6.18-1383cff4ccf3@kernel.org>
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

[ Upstream commit 1383cff4ccf3c8833c6255edffa29eb67c6419bb ]

In f2fs_sync_meta_pages(), whenever i becomes zero inside while loop,
below check may be skipped, it failed to check the continuousness:

	if (nr_to_write != LONG_MAX && i != 0 &&
		folio->index != prev +
		folio_nr_pages(fbatch.folios[i-1])) {

Cc: stable@kernel.org
Fixes: 580e7a492608 ("f2fs: convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Adapted cached-block continuity tracking to the folio-based f2fs_sync_meta_pages() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 66d3714dda32a..5bc47603b83e1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -411,7 +411,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct folio_batch fbatch;
 	long nwritten = 0;
 	int nr_folios;
@@ -430,9 +430,8 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (nr_to_write != LONG_MAX && i != 0 &&
-					folio->index != prev +
-					folio_nr_pages(fbatch.folios[i-1])) {
+			if (nr_to_write != LONG_MAX && next != ULONG_MAX &&
+					folio->index != next) {
 				folio_batch_release(&fbatch);
 				goto stop;
 			}
@@ -460,7 +459,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				break;
 			}
 			nwritten += folio_nr_pages(folio);
-			prev = folio->index;
+			next = folio->index + folio_nr_pages(folio);
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-- 
2.53.0

