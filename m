Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402917;
	b=dscvNJRP6BSpeiy0MED9gJ1r7tV9UIEKFV0fbdBTNmAeCQ7bHHmcKh8q+NFO4GUITzME
	 f8EdkmIsWT3bCvRPOLj8pZGCRz3P1wudoCZ1ctkQvYgWHzaR50MC+hdvBT7LxTnPX/3KX
	 7B3Wgb0l4ydDdh9I8Av58W+Gkl2fcJoExQPMV1tILD53Z2TY9JIzgkdLgXIncZfbMjk1H
	 01Ilmwz/+OopKDbbw1QoxOACC1uq0C8uBFzl3Tp4lYiLhamusVJ1pL3LXsPdTmSR+djlC
	 xlZWVj7MRLmvJdIKNKu8qAhZ50JJ4Q1/NVC468ZqwrJ7Yq3ZLyr6y7AbDE2g5TYITuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402917;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YGZz1bChbAYOfYeSQsuvOCJ19yjYYo3Kc25eoDSu0OQ=;
	b=45kFp/Uz9N4fijArDd3DexYwKfPfPPMEf9DNJivy2QFbnycdGA/WAFyLkb4OOZw3Ujqz
	 0j0fY4fRYaPeGY8JMKT/61Sta2A/jNmzraEfvPzXuK3Jj/XH9c5j3ErUtFLMthY4Nk9mb
	 ZK1nPXt7urFS2ZfJP4MJeLzJnFE/XYAxoYB6MsQKdY6ppCVDZ9MIZru388fcYjW2ZiijL
	 LfVXT2cCUtJOPX1vD0h9R6C8bZDUVab0Ui4JJHiC+K+NfagwOmK4E1EvfV6CwMjSj4oD5
	 QD31bgK2Y5pTEP3u75jgCxQo8q1QIANpcIt68WmeoqZTHkJrO/QzndP7mUNSKURW5lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxw4STcx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9092606A88E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxw4STcx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F63E1F00A0F;
	Wed, 11 Nov 2026 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402917;
	bh=YGZz1bChbAYOfYeSQsuvOCJ19yjYYo3Kc25eoDSu0OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mxw4STcxAW2sAo+T0OMLYbpD5x7xIar/q42WRE2+QjOWWlBfvorQUyMhl6oW3MeOy
	 rUjCFHrnXTtEdX12TsSvCysLKxPjJ7ZN1YKaMmND4n1SqYcMFKeHVvgF6doJVzbH6b
	 iTug3xmt5RrKN5KxOj2cnAnEn+AJ5fjNk9/LqNqbjB6jiw7Ove9TNM5JIJZYtMwvY0
	 G57yp4nOpijoWM1bymmOdRBEveYxyoAvfRp9HF97Wbfyb1U6qmvfMm47XKu0lZLC+2
	 kW4yzuzuG19Ffq86UcP7pxCwDuISsTtjOd93WWF+2EIOhMf1NkRpr/51qvLsEB9Ce2
	 JuA3QUOXH8fcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>,
	stable@kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix defragment writeback range truncation on 32-bit
Date: Wed, 11 Nov 2026 08:15:14 -0500
Message-ID: <20261111131438.1022037-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111131438.1022037-1-sashal@kernel.org>
References: <20261107053449-failed-6.6-92154fe28c37@kernel.org>
 <20261111131438.1022037-1-sashal@kernel.org>
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

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

[ Upstream commit 92154fe28c3701bebf75176dc5522bec62519a8f ]

f2fs_defragment_range() flushes the range it is about to defragment:

	filemap_write_and_wait_range(inode->i_mapping,
				pg_start << PAGE_SHIFT,
				(pg_end << PAGE_SHIFT) - 1);

pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
shifts are evaluated in 32 bits and truncated before they are widened to
the loff_t parameters.  pg_end is only capped by the file's page count,
so for a file larger than 4 GiB the shift wraps.

For a 5 GiB file pg_end is 1310720 and the range collapses from
[0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].

The matching call in f2fs_collapse_range() already casts:

	filemap_write_and_wait_range(inode->i_mapping,
				(loff_t)index << PAGE_SHIFT,
				((loff_t)pg_end << PAGE_SHIFT) - 1);

Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
"shld", i.e. from a 32-bit shift to a double-precision one.

Cc: stable@kernel.org
Fixes: d323d005ac4a ("f2fs: support file defragment")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f787a5a64ef02..64a64cae329e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2888,8 +2888,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						pg_start << PAGE_SHIFT,
-						(pg_end << PAGE_SHIFT) - 1);
+						(loff_t)pg_start << PAGE_SHIFT,
+						((loff_t)pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 
-- 
2.53.0

