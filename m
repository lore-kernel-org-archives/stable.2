Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07316277C88
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723064; cv=none; b=q12uUjuQ9tCw6gS2sRDAb55AX67ffDApDOq1uWmbDiYHLS4CxXI+4muIwnM0ZHnSNsRF31MrqnzSLfTmRQP7pUJn0Gt20VaDtrhZE1m3UcoH+kJHauJO+Uyx+OxW2Sh+fvQHAasoAKn4V9YIrO9JzRtl7aoNOCaaR6EOpm1H3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723064; c=relaxed/simple;
	bh=tAZjKO5adKhWsc1uBo5uoEUnSIR7V1LFBTkMoJ/XndM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQFMy0jXp0Va03OpSRMqaa722ml/LDYCfEDwEtfsZaFhwXjq7WaTajaycpw0Ab7WU4WfQ0lszYcUKoA68DTvuFGvFSF1hXLRZguIr2YGmtIGKSGYVhxCl2UPuwNlAu0gMoVXHt5+2cSPBhbHNQ4EsE2G6XNwrF+F1yXDMcWzG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNHa2C1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNHa2C1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA011F00AC4;
	Sun,  6 Sep 2026 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723062;
	bh=pOVib1VZpS8pTNVzvf3EenkcXbALRVx0PXUeTXDVvRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNHa2C1JW/jRL6uotIGIcUKld5L6j4hO1yhMr01DElDInZRWZhBMVQVGIGolqVxFK
	 B7nemG2NTQOOdK20awtC3VhMcBSCTlRLqVpxjm3t3NcNU19cEaqL08x8O4YuiDQ3Ia
	 FH3TSg7h1iXY6YVRUU9dlTXLMIGnkxUEvz2MMG/Lwyqto65QFrnj+yVn3WcAWcqJAQ
	 LaYVvUV8agt0aIBwBCuD1m76U4YYZ0zm0DX4bXEUL8qvr6LQv17kQfwsJMLpRWKqP8
	 KC6mPBdRk1veR8xoDsWGwpOjoA6zy6ZOqOqwp+k0lCSbFsHdJPJETsxZfABgdTI32/
	 tXSVmdH/wNXkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] btrfs: fix extent map leak in NOCOW direct I/O write
Date: Sun,  6 Sep 2026 15:30:56 -0400
Message-ID: <20260906193056.1792186-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193056.1792186-1-sashal@kernel.org>
References: <2026090310-unwarlike-canister-1f00@gregkh>
 <20260906193056.1792186-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/direct-io.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index dd450ac19cab4..3d6fabd67960c 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -280,17 +280,24 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
 					      &file_extent, type);
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

