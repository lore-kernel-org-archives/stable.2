Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAC5328A6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951276; cv=none; b=sPeEZi3gD054FNVn/W14eQbeIIPl+gyEPtgqkL5UGHo+xOw6pjOIyCD6tROOlzBhe5R8OGqbRhg/lnk2MenjSsZ6wxEv/ykBZY0JdIm/7P+ktnygHHRR8pInOxFnXvVMBbhHF3Ix4RN37DcoB11CzXJcE3MzsS2zmnbw8iTwads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951276; c=relaxed/simple;
	bh=nJOPZtRQO8nQR4wn9a/tAaKw1aCXBhCNuy0r49ne6nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0OtaYhsGctwzgzTak6w1+NQkj+TJoRP33X/g+rhZN5XTReeQPIrBc44J5zf6zNPODsE2jdOM77m4Zn9uYW6yULX5NQobv6KwBC7aaH1pX4t9ZIKkGgDk3B6E1a8giIaSe156eUkyF8d+V+BwGfaglNJ3a1jECUKSUt2diSVToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtLjAZrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtLjAZrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFBA1F00A3D;
	Wed,  9 Sep 2026 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951270;
	bh=UGUYspmAs2ezDx511DEKs/V5N/gkX7ULZuO+z3qwTdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtLjAZrdekx4aW/d6xIjB/kLEStXi2YBWpPLuEP07AIGS/Pzgg5awZx7d10mxwIy+
	 K+aObCSmvRqgc+k4OzyHk2lnz+qTOZWpSvXbxK8BqsVdRCP+DfKdHG+pl+EPXRw7VW
	 ukGP98ZYFfsQDWeZ4mCy5/03Kc8qoIvKfFagO5CQ4zCW7y9alTAKDsEXFbbsj0GV3s
	 eHHvzVRNAQ7Fr7amh7dkbocYfhdgDXrDoyq4yjv0VKdYcbeoEjZzTYEfSA/adKkFx8
	 CTGpjGe45Bi7dKZcDdX9S9BNZHXJoVU6QGhQBwjbC6cY+B5JlljmMvcwwjMLUl7+9q
	 JX248fxA4lvuQ==
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
Subject: [PATCH 5.10.y 1/2] ocfs2: validate dx_root extent list fields during block read
Date: Wed,  9 Sep 2026 06:54:27 -0400
Message-ID: <20260909105428.1621457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-superbowl-automated-9228@gregkh>
References: <2026090342-superbowl-automated-9228@gregkh>
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
index ae96e58ba5399..5a7dee683418b 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -582,7 +582,7 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 		mlog(ML_ERROR,
 		     "Checksum failed for dir index root block %llu\n",
 		     (unsigned long long)bh->b_blocknr);
-		return ret;
+		goto bail;
 	}
 
 	if (!OCFS2_IS_VALID_DX_ROOT(dx_root)) {
@@ -590,8 +590,32 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
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

