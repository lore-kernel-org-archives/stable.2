Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50C47FB0C
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781662; cv=none; b=CptmSTSG1zl7zUTRprrLKv5bfPkGGxITz3uLWiJYvU9ezU9QsjRVcnyEFvQsu1hwNAw+DBdYQDVgkv6/NB/xrW212DeZ7NP91EQlZpTLJ9U9P1cZhGBHHRMwrGtxFxlhaJ7IMNfEkMDSp6P6NU3ORxpU2bDeJwEZElk0/oXcwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781662; c=relaxed/simple;
	bh=BD3uNBaah+EVuj5aK3+XcOJsHJnL4zodzUKv+fTEMSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0xZIqDR6J8M3kETTQIymZNAjfmWTJ2CiF7G26AXgFwzZ0/xorzromKy/EYexGmHJJPzVn0lqIYnA5+GNWNUQNId1eu/4rp+QdcpadH31OIhWlKVc+REopSMkRlbC71EaSXyMLENyVbC8C0kWKUB6tLtpr4m1Q3+f8hBTMWsPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG2kkMQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG2kkMQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C91F00A3D;
	Mon,  7 Sep 2026 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781660;
	bh=Ib6iwH95s0tVoWRxsKyFfyOlQak7k63Eoe6tQLTU4KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gG2kkMQUOcn74sbTuPUPhqctrWLNhSSKS2wpaMHa5nNRzcJudR27C9r1ONhzLmJPH
	 FYWmVAn3qr7lvieQfdAgb2hdwB6s37b/uLVhCXr4ahwOpSinBv9GRpaLMgEfNEJZqH
	 RnEIWOrbp/1XKpXlYRhd/CIEg/dlvL7djS/Vjwt0o/zoY3EcHpVtKOn8uBkRAHTcYl
	 knxSZyvq3Shmlp2hEseN3+pHaI9mKNkNSll5H97CR0ZMCsD94gw73p0m8MAIgTWqvI
	 Ri0voxMepk4vOlCHE+T4zTNyNgA48Pg29q1F+/rGw51GmYL4hNCUltsZLVkrPTbgGc
	 bxtP639205auQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] btrfs: fix extent map leak in NOCOW direct I/O write
Date: Mon,  7 Sep 2026 07:47:35 -0400
Message-ID: <20260907114735.2871157-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114735.2871157-1-sashal@kernel.org>
References: <2026090310-catchy-recollect-7ab5@gregkh>
 <20260907114735.2871157-1-sashal@kernel.org>
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
[ relocated the direct-I/O change from fs/btrfs/direct-io.c to fs/btrfs/inode.c for the older kernel layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d42e29ad9e87..b1d79defa11af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7690,17 +7690,24 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
-		if (type == BTRFS_ORDERED_PREALLOC) {
-			btrfs_free_extent_map(em);
-			*map = em2;
-			em = em2;
-		}
-
 		if (IS_ERR(em2)) {
 			ret = PTR_ERR(em2);
+			btrfs_free_extent_map(em);
+			*map = NULL;
 			goto out;
 		}
 
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
+
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
-- 
2.53.0

