Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316490;
	b=uvgfriOB41bkAOYYlTekw28neqThvTnxiI6pFUQQc/BThspf0hO03UPyyiXj9NAXtNpO
	 C8cRYE9fxqhAG+blkaqeDjsxO2+tz0vwd/Ul1VRbJNoHxld7Un3UJfXF8c+TMVsF2BWTL
	 MaX1hrLhDQAz0ga7H3ofdnmAVhKoFPZpmhibTZJ1gqmy+nb0EIdcPHpDFLfo5Nsnm23Hq
	 wuIaCRmR5E3lZw9iEo35N4MeE4KhXxLAJPuR4SJ4uUo00vHWSXvlLaYwlfwIk2eEt8vX1
	 tO8ghHEltJ9jZr4vrj4gKycUt+enaDplq/Epk5AwsYNZc2FzrtW8OsgaMi/ES0cTmBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5acTGg2bO/eOR50xPO3y8Yv2ondVwnX7LFCapqMBQHg=;
	b=bZdI8a87E7yuSYzXxrml7FrwXqAVK7cxQSLqK4VxpLG7xhWxSRDfoGSjdWdkFYjKLUTs
	 mYOXWD0rxDXzgB7hwDlZQkhE8QQrEJBqMwR/BHVHHYs7h1oYkT1wuLu6Rx8L3NoP4w4nL
	 GQnLVSAgzkf2E5CwXwKZVd308FxH3AkWu63ctlBJeBlBAm2qoBoakpeL3l3cNabz2I8NH
	 n3oAUl/uHG7HamDUGOi246kGq2HWl8OAjIGPDhmASnjlAMESMs0L9eTIV7X0QgMoT1AfB
	 7mQW5DEaBeMhxQ0il7BNbVNII3uFlFvXlEx6is/OLcBu8cWnoUy8WgMGHD2+cWzAnaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRTZO40Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3F606A74F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRTZO40Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3AD1F0089F;
	Tue, 10 Nov 2026 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316490;
	bh=5acTGg2bO/eOR50xPO3y8Yv2ondVwnX7LFCapqMBQHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRTZO40ZlbwiIf3qJXCYnjpogHfzFQ8yQpIx8m8FCrv0j3R/5OKBa4J3rj4HiUi1i
	 uc+vmpZUpVZLG+971J8b6I63s+amgqmuraKM73RQufhjlmLCHnZZ48SKRohw2Q/Oro
	 SUEJPoOiU3rGsV7jEDsJ0n9zM12UL8GsZgW8LzXuzUXYF0Wpje+duDE32zdPioeNYV
	 7thqvyT9+SnYukYAQPO48E5mJjt9SCQkmETfnOl5jHJI0cH3i5POVRaEoP2BFHxn1Q
	 6pQ3tIhkI+yv7gicOvxQzRKYVgsgVAejvQbNZIdgiXSlsDbCFrtuQ+DlCg37ww2qMM
	 Kkq1hQiw7eTzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
Date: Tue, 10 Nov 2026 08:14:48 -0500
Message-ID: <20261110131435.1701877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051837-failed-6.12-1383cff4ccf3@kernel.org>
References: <20261107051837-failed-6.12-1383cff4ccf3@kernel.org>
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
[ sashal: adapted the cached-block check to folio-based f2fs_sync_meta_pages(), using nr_to_write instead of background and folio_nr_pages() for index increments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index dc9540400caae..eb928d644542f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -423,7 +423,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct folio_batch fbatch;
 	long nwritten = 0;
 	int nr_folios;
@@ -444,9 +444,8 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
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
@@ -475,7 +474,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
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

