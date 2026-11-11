Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405044;
	b=o5zZHlyjgfp8+5B3T2LwG+KHResqQvz/h5iPXYDx/u7KZxeGOMepzX/TLs23JxcUxjTS
	 44jVGWysGtnb2/+VPQUYY56BAdjDInaBkZSmXX5V76VC6drcIKxwxbOfjaFzyCK/qmRZa
	 P9bZRaGYonRAXkP8wLekQWDlQNU4mEvPl36F6MSwXnUZ0xu9Ek3YlO5BTDNRHpU3DsHAy
	 BENc7Z8LIcj/bhQP6I0lsch3Djj7Z8ClT/VWCtJvh+sw1viOfbgHcVa22bHw+M+XmTv+y
	 p4+JdYv/zlaES6ovZqStx4jCrUZnKBGeqO0qUwo4HHT3FVsKvy3l9vF6fTj4TTMr4+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y76zAN4s6IMiCHypH5KC/u3D5OuQIRoWgZTf8LazQxM=;
	b=vb+uPED/rAoFUtKWSxNLunj8hSdIp4u7NCLEYdQ+J3WbdS/nqGTWtKKc5nQe/6FxGG/P
	 YUyZueldkVr/UVpiodcPTEJ7wDZyPxfCoBMkOtQBHc9aJOckQzUJ6+8qLr8jLfrsuYoKw
	 VRx1XEbNa5mqm/i3wdc+wyKLHAh2alodhPJ/sHMuRU7Se4ewsYMlFCSUIPYUwUsdkpaLa
	 S+r9w/Alm/ktzxIOyoI/+IxDXoThqnK4x/1bCFYxivfJePZ9jF23N0QvNq69y75hl6Yvx
	 Ob17hThO+NMoO3e3XWsNq3MRRIchI31p97hlDNa07FR/BZYIRFuyuZAvN2HNJL0qcPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhCzCrMo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB560A263F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhCzCrMo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B4E1F00A0C;
	Wed, 11 Nov 2026 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405044;
	bh=y76zAN4s6IMiCHypH5KC/u3D5OuQIRoWgZTf8LazQxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhCzCrMoktcoLqKpYoqsMBQGcgWnZidpFpSGsIE1pEWgd1/sMMIHqiEWLhCpFsofs
	 n3iudCti0DCiqmlKE436dmaB6aeMjKtyg4HyLmMMsXOaOD/1vfUK7utptMqeTUdB4u
	 BvQHgriCjfKPyueqoKVH9z4ogiJE76krYkvSAD3RWNZ1WEAom3Y9q2KFv5n8scqDRm
	 QTjMRIOXhBIhVNtehADArC355Djrf0/ws2GHABi5LL5LJckZI8w6LQqJ5JQjMaHkLV
	 BMLr+KMADXquvkh/1m7/QK7iY9n174iBBouBL1YXb1TkM1hsDHiAGKkx+UUvMXi7QD
	 c5Unv4mZ6AIzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>,
	stable@kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] f2fs: fix defragment writeback range truncation on 32-bit
Date: Wed, 11 Nov 2026 08:50:41 -0500
Message-ID: <20261111135034.2134948-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111135034.2134948-1-sashal@kernel.org>
References: <20261107060550-failed-5.15-92154fe28c37@kernel.org>
 <20261111135034.2134948-1-sashal@kernel.org>
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
index 36a2fbfc19997..943767254c7a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2633,8 +2633,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
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

