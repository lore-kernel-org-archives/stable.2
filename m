Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC13D3309
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287843; cv=none; b=bKGudg5cWokHnSu9S01DlNEzxr0ekPLubxYmjujX47rpYW0XWPWoUkABtlhc6m1Y0MIGbmHJ3Dme1RRAcwGaSoKxz2W9H5Fw6lBrD+Ls0nV1uZJa/+mjmAvtPuiySGX3bfgH7WriVlv00vxIuxwh6Xc0eNEtx0oeBSdp30ioLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287843; c=relaxed/simple;
	bh=IWJY22qyXKGduklHRaoZl2odrsTP1X5JyNk4vncfErM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFgxr84/qnk3dIzuKU5/WMBFJMvDS6Hx8D3Z3LFhqzA9HwPuFA8ThETe/OJWNfPOskv5PE7ps+4fkeG7n8Tf4/Ndlp/hXT2spXcl2dux41hHvMp49QHfXsnHkDevkCHm9Zk7U+POGOsqwb5Sf/Xo50BP0Kt8VBtRzD5jPVfe3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMFtRIBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMFtRIBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E581F00A3E;
	Sun,  9 Aug 2026 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786287841;
	bh=F3Xnk2+OI1JJGxTtMgzx+LeWYG4zXfS1FyfpoB//LTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMFtRIByof8/D04IMD1mML5kqapqFFeDi69uxf//srR2JMP0Jn30RH53D7Q9bnaiQ
	 +WQOtu1rF4Cr180YzDSNaVc8ae2xqBVqLdbcNPgvfJgaslkTJWzRI5cz2yHmUqxrxU
	 26PtMv8h0vSDD0ucrrinIB4G1L7ujxV7e4Wwrns7narJnn2WpsD+H5NtXrQHuVtfwa
	 fvp15sLpbTh3pmXh0QL/9c8cA+CgbHOLu9wY1CixZZR4yqhkR73KrdghhqLT/E7/OI
	 gPqcNJZaTrqjlUxeIBuL5BW9qSFhNrr/F19K9wztC9fRARdjuMNb1go59bpePsEU2B
	 +LV1mJGVSVEkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] btrfs: zoned: fix missing chunk metadata reservation
Date: Sun,  9 Aug 2026 11:03:56 -0400
Message-ID: <20260809150356.1872210-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809150356.1872210-1-sashal@kernel.org>
References: <2026080520-wikipedia-kindness-ddd8@gregkh>
 <20260809150356.1872210-1-sashal@kernel.org>
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
index 8741495a8decd..a78b233cb8981 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4280,25 +4280,29 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
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

