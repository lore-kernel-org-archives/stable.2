Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712C473C80
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789100; cv=none; b=FX+XKkqP0mqa/fY07qZc1+b0CXF9bEsadknS1C/hRGfQVD8gfIziBn/Xb0sO0nGlc6PU8kpXdKv7TQjBwXKZw6Oy1fu2KLGe0jOZaNu4/GMzPY/U/y5U5S71jj8NiXxYfCtxRk0icREYn4r8+Xb+iSfYYROe5lcfW8zcP3LIZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789100; c=relaxed/simple;
	bh=Wy9+qJRIiqnQCzBHlsBH/uUmTKECKsV9aBC60cgsA8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HITzDwAKDJYnUTePJ0el869xF04LEKjrjWEnVuM48wm27wRBj7hsh8MiZfR/YOOGMZ2S+Cw4ne0H5x1x/g/YXFPKC11QZhm4E5aOVc9oQl3Gfg3X60d72O+pEov4jnkRjYU0IAyqJoRKOlcsypKKiFQ08WCkSQA/+zDzPIfOQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTUzqgeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTUzqgeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22411F00A3E;
	Mon,  7 Sep 2026 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789098;
	bh=iv4mGFJqr9wTTLXiZRA7G+QjhfJT3cwJdErKgnpZG8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTUzqgeYAOTJZuptDpPXTzJlOYXdPiTQ+JHtw0T6SfggMKf+KRzP4T34azRac3kPR
	 Ev3/4naq9f7MSg/FGWEglPHTdLBAO2z6pIPaS8uRN6jlMyb8RAQ7kk5DGF6yaaak8s
	 3+Igx2o3Lr9AIcq0dl/silHSZ894jgz10jp3dG4BKMqSiAkO1vEmwH5hOp5GH55Uri
	 wFfXP6j4Qs2EsaA/YrF5NZwfdPyrPUC5z8oRFCB1zQGzoaPe+MyMIQLehUPYDnn8Zs
	 5rpPoCN/l/ZL9/TDsL5vBekiRk54aa7GuyimWfcPp4acIMRNXPVHv+D+Lnx4tWr0TT
	 1eG/RcfCvLE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] btrfs: fix extent map leak in NOCOW direct I/O write
Date: Mon,  7 Sep 2026 09:51:35 -0400
Message-ID: <20260907135135.3104926-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907135135.3104926-1-sashal@kernel.org>
References: <2026090311-unison-envision-12aa@gregkh>
 <20260907135135.3104926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[ Upstream commit 3f950867c307c5413d628a153ac44915bd117ffd ]

btrfs_dio_iomap_begin() calls btrfs_get_extent(), which returns an
extent map reference that must be dropped on all exit paths.

For direct writes into a NOCOW range, btrfs_get_blocks_direct_write()
keeps using that extent map and asks btrfs_create_dio_extent() to
allocate the ordered extent. If that fails, for example because
btrfs_alloc_ordered_extent() fails, the function returns the error
without dropping the input extent map. The PREALLOC path avoided this by
dropping the input extent map before replacing it with the newly created
one.

Check the error from btrfs_create_dio_extent() before replacing the
map and drop the input extent map on failure.

Fixes: 5f9a8a51d8b9 ("Btrfs: add semaphore to synchronize direct IO writes with fsync")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ relocated the direct-I/O fix from fs/btrfs/direct-io.c to fs/btrfs/inode.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2778d2b96663..84ea24a8e66cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7954,15 +7954,23 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(fs_info, block_start);
-		if (type == BTRFS_ORDERED_PREALLOC) {
-			btrfs_free_extent_map(em);
-			*map = em = em2;
-		}
-
 		if (IS_ERR(em2)) {
 			ret = PTR_ERR(em2);
+			btrfs_free_extent_map(em);
+			*map = NULL;
 			goto out;
 		}
+
+		/*
+		 * True NOCOW writes don't need to create a new extent map,
+		 * while PREALLOC writes must replace the existing one.
+		 */
+		if (em2) {
+			ASSERT(type == BTRFS_ORDERED_PREALLOC);
+			btrfs_free_extent_map(em);
+			*map = em2;
+			em = em2;
+		}
 	} else {
 		/* Our caller expects us to free the input extent map. */
 		btrfs_free_extent_map(em);
-- 
2.53.0

