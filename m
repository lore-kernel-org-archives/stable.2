Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316693;
	b=xW/v0PX3yWQAydsKjMPtmV3QnRxWq89mm+mdLvIPO/5PB9qxt/Pt9XZxjx6sR9mn7BL0
	 gihGqMT20jxTlTJSJwajTxAxlAgd6e1R4kT27jAmrZhhRnxrgARqS+mLRAD1BlRu39U4a
	 d/VPxlhKGdfKP2RWyNe6+QUCHV0Cutvb/Y30YTYI1u6adQ+cJFiQx0FBmL36KNGuHy+j2
	 eWeeDEYYm6RwTdHxp3YXTTN0Xrn7JlbEycFVIjT0lZIjx3vRY6C4LuzmK+++7s4Vldbbt
	 fc9V1OBXppXTvm+vXuiv99szT0IZv95bM+dFxdkIRGvsLoIASvnbyLI0eOAJYtFx60A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JoDaipnOTgvtUGsKK/9IThiIcUBMG9JBuG9PWQ/GiGs=;
	b=Vfbgfackbs8HzG3JxDkwcfx3vOrUrZ1dsgRQ6k6ps0Phxt179L8yn9CyRDQSnTYHgN4P
	 Q619KawxzMiVzufDPyHNzJDoFOb72zHTbWIKPIxBE9kYBUtp0cbz/md5kVg0AhMsgZiBG
	 obYz5KbwwCSStzeJ7BS8ChwKfMjsfnMBBBiYcDvEOdnzDoEKo6au2AhX/4eJjyiXCqQYW
	 pND1fNjbtiLEdx4GsPvu7bwEjshy4Fc92o9P/bj7092CppDQADrKXZlcGWTSTCj3bddIW
	 OR2tEWYAEGt4MjCgjYTwwzBBxJymVjSG2FKyscYWs3wrNxiuVuGboZYcAjH4dJqFR/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH7BSHLQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFB606B6E3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH7BSHLQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D681F0089F;
	Tue, 10 Nov 2026 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316693;
	bh=JoDaipnOTgvtUGsKK/9IThiIcUBMG9JBuG9PWQ/GiGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IH7BSHLQ2LEEZXZ+JJbpaSKNkUrTgbi/WU7+VxDZE42kGz/WUKb3hOCxIrsIXSfqU
	 plEGJFC3l8V2ca0RJ6ErFx/+t/gkjX6L3CXa9v2CbTDEnekyxuqXRsSHmUvTAmyURu
	 h0oKBCN9tsio3KQbvo0TGUam8CfUgZ1LRUiVWM+hRfRSfxQlBDtxMSRx57qEz4NLkG
	 os8Xw39WIRESdukVbqYe14nHxJolwuC6y/7NOkdL9WQCeRRsX0IjxzwoOD9T+Mcg3m
	 +f8s7D8aMrBSKyX6ln3cdGnYusjU4WG3o6oHp8y5fo0WqhLHB+3VnMoHbF6MdgBvAo
	 +zQcxuDlJNqUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
Date: Tue, 10 Nov 2026 08:18:11 -0500
Message-ID: <20261110131759.1710950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053107-failed-6.6-1383cff4ccf3@kernel.org>
References: <20261107053107-failed-6.6-1383cff4ccf3@kernel.org>
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
[ sashal: adapted cache-entry handling to folio batches using folio_nr_pages() for index increments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 74bdce66f866d..ff8d336c8bffd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -406,7 +406,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct folio_batch fbatch;
 	long nwritten = 0;
 	int nr_folios;
@@ -427,9 +427,8 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
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
@@ -458,7 +457,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
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

