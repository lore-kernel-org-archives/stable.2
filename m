Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB246EF87
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795148; cv=none; b=kd/XnQo36ykAlwfmCpp0fWugT9dXYeDG1wf7eg0TIqU61c+vgF4b5A82RPgc0GkMTzNDM+PURP/LcLd/V6+mscX2eBR5lhk3PypDh4kIi/s/woPh7+OgZQifgf1XcaR9Ydo2O1pYvHxlihgw9mi/Y4j9dGzy6f8YuNhV/imfVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795148; c=relaxed/simple;
	bh=QhaRa2mY+IymO4Rv6Poy8sXy7mIdcYO32IEPU6Q4FUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1NFzpmJSXHpvTRpGNODl199GuVQ1QhJIXMvcib06Mk36GDGCTvdLn9dHFcg4FGhISDTaeamTdqra+C25fQxeoFwxTTwthiTAIU4EOmEXBiwLhr1IJGs8AjPBTid5slCRzFEkWo3CECQMSrokFBPUaxxfQaIcCS9WIR+HouCejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDyn26op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDyn26op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3A61F00A3E;
	Mon,  7 Sep 2026 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788795145;
	bh=q+f2boTJUOBK7sMRZATIHEVgW+Qn2HeN0VP5HAzcfaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDyn26op7TcYWFT2fhBBnn3topmfz2A1t1u+HZZH06ecHIbSWuHu9iey7SYBwqF7u
	 OY2bJht8Liu364znosEgTG7CfYDchz+YqgSKMS1TBG5i1/KpEuw+tXDeduO/DcDhYI
	 y50sz9pCUSXz+pIFkS7jK5hK8zRwuRsAfS123lFnYwcgTs9dyVN8HkeI8X5N9mXHgG
	 HxqEThX+kowsEnvOdXcvG9vi+kd3qGIpogvlM4pLmGMcTsQkrjb95NSGpHQlZd1yoF
	 WWSejbPrnl7yp83pI+z8td2V5LrWe9iu0/PVrP/5K8g+2AAXbrQeUAOwWY3ShIfGDW
	 cxWa6XMMi3hYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] btrfs: fix extent map leak in NOCOW direct I/O write
Date: Mon,  7 Sep 2026 11:32:22 -0400
Message-ID: <20260907153222.3844162-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907153222.3844162-1-sashal@kernel.org>
References: <2026090311-oblivion-chunk-24d7@gregkh>
 <20260907153222.3844162-1-sashal@kernel.org>
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
[ relocated the ownership fix from fs/btrfs/direct-io.c to the equivalent code in fs/btrfs/inode.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7f2aab8eb8705..98d46638a0572 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7339,15 +7339,24 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 						      len, orig_block_len,
 						      ram_bytes, type);
 			btrfs_dec_nocow_writers(fs_info, block_start);
-			if (type == BTRFS_ORDERED_PREALLOC) {
+			if (IS_ERR(em2)) {
+				ret = PTR_ERR(em2);
 				btrfs_free_extent_map(em);
-				*map = em = em2;
+				*map = NULL;
+				goto out;
 			}
 
-			if (em2 && IS_ERR(em2)) {
-				ret = PTR_ERR(em2);
-				goto out;
+			/*
+			 * True NOCOW writes don't need to create a new extent map,
+			 * while PREALLOC writes must replace the existing one.
+			 */
+			if (em2) {
+				ASSERT(type == BTRFS_ORDERED_PREALLOC);
+				btrfs_free_extent_map(em);
+				*map = em2;
+				em = em2;
 			}
+
 			/*
 			 * For inode marked NODATACOW or extent marked PREALLOC,
 			 * use the existing or preallocated extent, so does not
-- 
2.53.0

