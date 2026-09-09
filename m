Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87514B53F7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948708; cv=none; b=DKzbWEMBCAZxhekgeqHdbRBYiI4igbEm0eAo3GFV5+G5E6w4oex+ZDkFkLdiZ72S8QeeJH+37dVF9Oi0nI1ypkvlFEO7E8kZ7Qa0DMOlg5b7HAcMj+lKmnd4PrG4r/MFcV13uSjQuQZ2su8giunUUfTKqwYVm9DFAKgyYMSWN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948708; c=relaxed/simple;
	bh=Oa1R0nJcWTquL67HXGie37dNHrrvn0OfDzQUd7O/gjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh8Drd3bT2qcCrTaW7jWfujAKztaoWftcFUpawgLBk9uavvhVMklGNuhmQgaIR+FOC+g3CXKBNq6alK4X/dgpwrPtUp/yxP+MPysgJ8afyEiOfygI1Q0ep/VJ8aTu4SoAi0ydM2VdhZPZ19ku8BhwWhU5POyV4JtytjKsjlbWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJBofBWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJBofBWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504471F00A3D;
	Wed,  9 Sep 2026 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948706;
	bh=/qSJoAiRtwIsllasQqvpxZzMgZRdeWwTAId/Uldix+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJBofBWVqnxxIyu5sH6mguIjn7orbmjMJkwTS3k1n8hgF7TNA7koFes87B/XMgxlV
	 yT0fUyGAIBn4qBkwA/MS0W3O3CYlG5rbiJhMb3f4PAb0RVcvSVTkfW1BW6Vck8HsJE
	 i9Oj9G4KU1/mQSYYNl0bCP2NNizNbPJaeqcnKWt6L9pbEynMGS0biMOX/Q6FS+C2I3
	 6BdrnDmVx5ht53vOFK8Sc5zhEoA8cYD4eK8aWZ5Ca3vopqLB5LKjuTNAxBnw1oP1iq
	 3L1xmqpU6OgPr8VBQ0YW0O84e43rnJLp8styaMpJ3ohYi49TVTbKtJTTPaUY2tkvLd
	 A1M7YCGFBdXXA==
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
Subject: [PATCH 6.18.y 1/2] ocfs2: validate dx_root extent list fields during block read
Date: Wed,  9 Sep 2026 06:11:42 -0400
Message-ID: <20260909101143.1462422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-enjoyer-humming-d784@gregkh>
References: <2026090339-enjoyer-humming-d784@gregkh>
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
index c0fec28e62c83..16ab67ac3e039 100644
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

