Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC042F8EA1
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286890; cv=none; b=t4s3uw+3uE5I0PKtK7nMEZmE5iNGfg8yhXjxluHl1NKB6/STtcTL1pDUCSjqe4QLH1Op9BbNeDUfVdQ/W42FZXdPBdDveFSVaImsBNdRgeIOFNkycs8vj7n3Ma2sjYeOQo/bSnOOneHqgqjIVL8cbmMLZm9tK0jFcgHPTrRPcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286890; c=relaxed/simple;
	bh=W7pMsd7CaTd2p9tKL1iMZ15tiGJTj87IknEjpgGgDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/iR55EhPezLNwv8wlAuqA10JTSOnoNHVSLbMWJVzyowlMc66OcD8qVOaEr87Gm+eN0W7kaAuAKE/RRLn0P/CozIz9Q3lJJaxpq2d/yf3ttWpqzzQO8Q9fkRsYFXAwJAAh/yVovb3/PBI+o3EXLCm+fhD42hNlpHhpnPy62fZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsK61xdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsK61xdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4340A1F00A3E;
	Sun,  9 Aug 2026 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786286885;
	bh=WPKjBSiPwdjA0f1eSZkhsso7qE+O6CqRGRAVp/Ra6dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsK61xdLqt4qDH2dd1H+TW6Ib0q9sx00M8+CTVDe7+5TB1ArGDYBimSKlznyjoqAG
	 xW+UJ+M4bZcxpEwgO9h5W6uuKiE/lonjFwMPN3B9MAnEaWRLKCNeazCUNPBiehy0wA
	 3dhijyHPEdquErcMdD2h3+ErcYrn0lzdkAtTrz5XwAtZri+xpZJW+qMk/tlUfl23JR
	 w3T51SKvWBZ49uNLgtWX9bJxVpV+FFwbuwGFNTlyqunhQlU0EJ7lo1o2VxlEi6vByM
	 NneE8AoqX35Qv+LBXqWI6W9uQwpk0MuFmFWjr/lEaqJARCIXIyeJ1DrKqM/B4Xs37G
	 9kJxFOvJMDjFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] btrfs: zoned: fix missing chunk metadata reservation
Date: Sun,  9 Aug 2026 10:48:01 -0400
Message-ID: <20260809144801.1787109-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809144801.1787109-1-sashal@kernel.org>
References: <2026080520-punk-economist-e412@gregkh>
 <20260809144801.1787109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Yang <3497809730@qq.com>

[ Upstream commit 8bc4d7209611e8aa9d5409b6a4a86a9eb91b69a3 ]

reserve_chunk_space() stores the return value of
btrfs_zoned_activate_one_bg() in ret. The helper can return 1 after
successfully activating a block group, but ret is later used to decide
whether to reserve metadata for chunk tree updates.

As a result, successful activation skips btrfs_block_rsv_add() and leaves
trans->chunk_bytes_reserved unchanged. Use a separate variable for the
activation result so positive success does not affect the later
reservation. Keep activation failures in ret instead of returning early so
the function uses the common tail path.

Fixes: b6a98021e401 ("btrfs: zoned: activate necessary block group")
CC: stable@vger.kernel.org
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2e7351bbd23cc..a01c4a5b95db7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4346,25 +4346,29 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
+			int activate_ret;
+
 			/*
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(info, true);
-			if (ret < 0)
-				return;
-
-			/*
-			 * If we fail to add the chunk item here, we end up
-			 * trying again at phase 2 of chunk allocation, at
-			 * btrfs_create_pending_block_groups(). So ignore
-			 * any error here. An ENOSPC here could happen, due to
-			 * the cases described at do_chunk_alloc() - the system
-			 * block group we just created was just turned into RO
-			 * mode by a scrub for example, or a running discard
-			 * temporarily removed its free space entries, etc.
-			 */
-			btrfs_chunk_alloc_add_chunk_item(trans, bg);
+			activate_ret = btrfs_zoned_activate_one_bg(info, true);
+			if (activate_ret < 0) {
+				ret = activate_ret;
+			} else {
+				/*
+				 * If we fail to add the chunk item here, we end
+				 * up trying again at phase 2 of chunk allocation,
+				 * at btrfs_create_pending_block_groups(). So
+				 * ignore any error here. An ENOSPC here could
+				 * happen, due to the cases described at
+				 * do_chunk_alloc() - the system block group we
+				 * just created was just turned into RO mode by a
+				 * scrub for example, or a running discard
+				 * temporarily removed its free space entries, etc.
+				 */
+				btrfs_chunk_alloc_add_chunk_item(trans, bg);
+			}
 		}
 	}
 
-- 
2.53.0

