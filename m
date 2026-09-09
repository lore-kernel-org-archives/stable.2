Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CB531B0B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950762; cv=none; b=ImuoxdK76Quy2KU1WvwJ2v8U4lItBB0AfMyq/W/an/wD+LLIowKGwCwcDZZBnX7kPa/VkA2g74NnA5SSmt3ssWgwX9FfkiJeJdlrRFogHQxdMxPPULvskFArzpdQdbnkI64CgHFHnos81cgbjfcKOC+zkhdV8Oq0jpAcAEOCj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950762; c=relaxed/simple;
	bh=qal8//+ItT2emLToJBwelt8hE3y2LWIU1jcucOUmbkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9aLOYdfaNVZcxFs/6abxLb6FBO8Zbbd2bllT9UhC8WtGPFFY1JsKHVMiiOHC0WOdQmAKwr9UpzuOnnM+qeKdHvwMMmYKqPkxA8qqyyk2pmfyEH5Y3rBH5PKdhvuddisYuGuBoWzstUGHXHUS3P/Hi364b/9aLxUnEB/SFqaQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZfweNPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZfweNPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D511F00A3D;
	Wed,  9 Sep 2026 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950760;
	bh=czveEORPrJHOY8Sc2FraT7LpFekrcDu2di6KjUCq4Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZfweNPuMY5A1BRa8os+O+yfeBNPDoiGt7DZe1EISPhDebk8kBq1k3WG+HLrR8jyf
	 Qx2aNf1RVfAOQNFylsmKez2xUqbC2dlZLnTuCBbO0eYqH86jAssTdMdVto9oE/4/Ii
	 6KAB9naof8LBKeE/iU4GY8rL0hFPA3KXvF4eXbdX2bTm/Rl37teTUzcOHMxjywgYt/
	 wTofkhy3nIPbVT/d9ofnGtw6uNnnhDZRsTjApDAUj3A6uLRRm819vgc3BsVqR/NmpL
	 vX9yp6mePO75bOYsebV5D2GxvTApI1GNCPSwfGRsXzQwbbAuqQS1XTMVzPtd/GZP9E
	 7R6Jkz8+5gcrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ocfs2: validate dx_root extent list fields during block read
Date: Wed,  9 Sep 2026 06:45:56 -0400
Message-ID: <20260909104557.1564171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-gurgling-unison-81ab@gregkh>
References: <2026090341-gurgling-unison-81ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit 775c17386a6fd695f999d4cda90e3931386570dd ]

Patch series "ocfs2: consolidate extent list validation into block read
callbacks".

ocfs2 validates extent list fields (l_count, l_next_free_rec) at various
points during extent tree traversal.  This is fragile because each caller
must remember to check for corrupted on-disk data before using it.

This series moves those checks into the block read validation callbacks
(ocfs2_validate_dx_root and ocfs2_validate_extent_block), so corrupted
fields are caught early at block read time.  Redundant post-read checks
are then removed.

This patch (of 4):

Move the extent list l_count validation from ocfs2_dx_dir_lookup_rec()
into ocfs2_validate_dx_root(), so that corrupted on-disk fields are caught
early at block read time rather than during directory lookups.

Additionally, add a l_next_free_rec <= l_count check to prevent
out-of-bounds access when iterating over extent records.

Both checks are skipped for inline dx roots (OCFS2_DX_FLAG_INLINE), which
use dr_entries instead of dr_list.

Link: https://lkml.kernel.org/r/20260403090803.3860971-1-joseph.qi@linux.alibaba.com
Link: https://lkml.kernel.org/r/20260403090803.3860971-2-joseph.qi@linux.alibaba.com
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: bc70726ddad5 ("ocfs2: validate directory-index entry counts when reading metadata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 4d4d5ef6ef29e..6b199ddab1d99 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -580,7 +580,7 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 		mlog(ML_ERROR,
 		     "Checksum failed for dir index root block %llu\n",
 		     (unsigned long long)bh->b_blocknr);
-		return ret;
+		goto bail;
 	}
 
 	if (!OCFS2_IS_VALID_DX_ROOT(dx_root)) {
@@ -588,8 +588,32 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 				  "Dir Index Root # %llu has bad signature %.*s\n",
 				  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
 				  7, dx_root->dr_signature);
+		goto bail;
+	}
+
+	if (!(dx_root->dr_flags & OCFS2_DX_FLAG_INLINE)) {
+		struct ocfs2_extent_list *el = &dx_root->dr_list;
+
+		if (le16_to_cpu(el->l_count) != ocfs2_extent_recs_per_dx_root(sb)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid l_count %u (expected %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(el->l_count),
+					  ocfs2_extent_recs_per_dx_root(sb));
+			goto bail;
+		}
+
+		if (le16_to_cpu(el->l_next_free_rec) > le16_to_cpu(el->l_count)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid l_next_free_rec %u (l_count %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(el->l_next_free_rec),
+					  le16_to_cpu(el->l_count));
+			goto bail;
+		}
 	}
 
+bail:
 	return ret;
 }
 
-- 
2.53.0

