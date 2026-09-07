Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEA1F09AD
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743000; cv=none; b=BClZImiffvjpxUqUPxdU44rEMV5i9PnEuC8EYsVgc1qxPjKXW+Za5zz9MWgK+7EijYRdfnN5PMjmfqz0NpswCOrXg43xo1BMIe0DkrYly+HwzLEeBRWlLflpi/EQCRifSSNaQBeWbBb/DPeVVjV7rZPz/kMNKJNGrYaBBvr0gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743000; c=relaxed/simple;
	bh=GLl4OD3GluEIu8+gAWliLde26ML5FhxsxCc6nlQfUes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpkU3QKFzcQqIH6TzJHKsDHmcbr3fg7vBq25h/s1x2cfUNlUmiH9fljz3bqXeTny1a9Mj8xWugBdvjQQvLfBa569ggGHB95fD0EIf5mP746nuLw2aefOoZefUrk6zx+6oY5YY8e4eBnWGFKSHQpWEwqHHhK5Jv2RpT6h/FgyNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1jzOiWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1jzOiWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E9F1F00A3E;
	Mon,  7 Sep 2026 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788742993;
	bh=U/PK73hAZxqaMXlaiBKuPkDaK1dYn/1Ji2IzUYjhE0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1jzOiWhY6aHJDfQJ4ClJVHII5XTpsdw77GWe7oMPJ/7xOeoIhAfASCrBIF+g7XBC
	 O3+h9LfBbrF8y07sOlxUMjne01JWmquc07K4hxJw8WMUuWFCov4W5j6rvC2aWjTmzF
	 uCLNc4cgS1TXrm/UzjBnRp5K8jjaLIM4JSnanYuWH3raFz8v/X/SSdG402dGBF8mVq
	 rQEa15Pl+8/HBEawVIJUlggkDE8ExvbYV3BFwdjikvZe+LhO7k0Xs3m4i2hYhHnwyo
	 x6aUJmBsoNu19BVVNFhYJfAA+lMP5d+5LgwTk0yK4R+apm/up/59cqsp3AvVoDlRz9
	 0FxFVxuBFg4gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] btrfs: fix extent map leak in NOCOW direct I/O write
Date: Sun,  6 Sep 2026 21:03:09 -0400
Message-ID: <20260907010309.1949749-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010309.1949749-1-sashal@kernel.org>
References: <2026090310-yeah-payday-4448@gregkh>
 <20260907010309.1949749-1-sashal@kernel.org>
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
[ moved the direct-I/O change to inode.c and used the older free_extent_map() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23918e72a71f6..5b2645147397e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7462,17 +7462,24 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
-		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
-			*map = em2;
-			em = em2;
-		}
-
 		if (IS_ERR(em2)) {
 			ret = PTR_ERR(em2);
+			free_extent_map(em);
+			*map = NULL;
 			goto out;
 		}
 
+		/*
+		 * True NOCOW writes don't need to create a new extent map,
+		 * while PREALLOC writes must replace the existing one.
+		 */
+		if (em2) {
+			ASSERT(type == BTRFS_ORDERED_PREALLOC);
+			free_extent_map(em);
+			*map = em2;
+			em = em2;
+		}
+
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
-- 
2.53.0

