Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7291F8755
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284163; cv=none; b=JwgHCGg/h2yrkZsj45l7KE3LjFWG/jdwUfLvksf0hFOQh6w0SIhwdfArGAQZc3Qa4+Gnk4km5Nc6iv52Jm43H9OudzQVvq7FP5tuq+6m4mc+Y8HcvEiXwckO1r/6niBExJnFtkho2o+GrknSVI869c+jdINCB+yFPZm0HQa8DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284163; c=relaxed/simple;
	bh=ixeixnuxRPvfpdZ9zW8vh4PHYiArgdq35vwjNeoKsN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N84dtc1kVd/JsTq+L4zV2Msr0nf437sc45dcwfoOqqR3dcQn6Ha/GuKmCNFw1XIPjtMB6k7Pz2F5czAiGWIfHo1g3L+MAjIclRPUfJh2mqcJV2R7wwY/AY2oxk9w44oKlQbcRKIeFA1DGD4w/9v/d1mK9opyD5PbzZliRvMkwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlfARTJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlfARTJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182221F00A3D;
	Sun,  9 Aug 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786284161;
	bh=+Y1JTyiJomeGEEDje76NMdg5iKouMKwDI0lsv9qtC1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GlfARTJns80tqFfJz0cBq97rOhl5MbmUHOyMKrHzlnlfMolrst31ByydxQyYBnxpn
	 hXZMimXEkyxpRnoyjxXMisS3QF+Xr/Gj+3pqUSqOIqil1z2yiw9u5I7pPjtytjb0hj
	 7qVdAUimIfALg99LLVn8BDf6U2vvM49sMSduqjLeBCLkrpbMuHVPDgo8ofzuqNhxpg
	 YjeZ68rBQ9g2eeCxkt0T8RYZHv7ZPYk2/n+EVnWozIvc/d7HiksPcc56M0NsWMz4bz
	 JjY2NYW8BZfX3lYzY07bD82LPz9DkB2xwNpeOHCp0gmi0L2CIsXEOxdx+97lUQwZCK
	 SoTT1h6KLl9dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] btrfs: zoned: fix missing chunk metadata reservation
Date: Sun,  9 Aug 2026 10:02:38 -0400
Message-ID: <20260809140238.1592207-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809140238.1592207-1-sashal@kernel.org>
References: <2026080520-celestial-balmy-f31a@gregkh>
 <20260809140238.1592207-1-sashal@kernel.org>
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
index 2c1827cb957c6..93e0063bb1fa5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4350,25 +4350,29 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
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

