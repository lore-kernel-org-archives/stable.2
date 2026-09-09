Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DE5328AF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951275; cv=none; b=lUeFajPGnomxs3Fd5wDwMtg2hX17XXzfmDPH5Rxc0rC5+dwAXy082xJP8zFVyICmf8JKAOM9wiTlRMaN+gwMQkChgBVMf4hnifZIDtxZ5VOBKDStvOH38JqjT5sk3aQDNSkVtqbf9iLEKHTRCcag6kLWBIohE+RXJe2Hb1JyN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951275; c=relaxed/simple;
	bh=onIm0Nx7uJHQ11bucC9/vM6fBsxDeC2SLYVl/oVSWOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN12SQ4B1GgTqhFDYl6AtVryCneGGVod2SWSldzFIFweqDUvxmeDnlcDBEpfQvnn3tFvtiyIyDHWmw8JIfU0P4Sy57jDSN0ZPYLgKHiuxPjIYHTJxPo0+mq2o3ayUePaL8VLlwmVE9zi0FtIaYaigR5djZfnhwXitDTTOVN3jh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSGaqKqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSGaqKqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5791F00AC4;
	Wed,  9 Sep 2026 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951272;
	bh=UjY7VNZqX95wxLOVrO0edIm/s59v4nBn3y9P89NbpPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSGaqKqn/d7osQuFnizC63LlAP0tFAuLukD9rUctyg6gCnnjluld5QzYdKZiUmrnU
	 G5VnM7kPAZTB/n5d9u2FLOm8r/9JFvW7WwlOKM6jiZNNklPuqHzPotVytCMfWgXe97
	 ScwkYyzj3wP/Jp0wjl2qUUQ26mkJU8ahNwimd6o2TtOXePXP2Ptg4g6TgKhWgjK6j5
	 k3m1VgcPy5bdp78EZGFYahxPz3UxtrQzafcZ6vH9J1mJzWVyrd0QjAVHRUmSjCci3p
	 J0k0mQfq7mYggkqCPVbvWdXEwWxqZGFj0rT00oCaboPQfLiKBmvr8qeQTbfp4V9SRp
	 vqcRLuv7kZD6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Joel Becker <jlbec@evilplan.org>,
	Kees Cook <kees@kernel.org>,
	Mark Fasheh <mark@fasheh.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ocfs2: validate directory-index entry counts when reading metadata
Date: Wed,  9 Sep 2026 06:54:28 -0400
Message-ID: <20260909105428.1621457-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105428.1621457-1-sashal@kernel.org>
References: <2026090342-superbowl-automated-9228@gregkh>
 <20260909105428.1621457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doruk Tan Ozturk <doruk@0sec.ai>

[ Upstream commit bc70726ddad53c7e9a9a85915bf2415b0d4f42f9 ]

ocfs2_validate_dx_leaf() and ocfs2_validate_dx_root() check the ECC and
signature of an indexed-directory block before it reaches higher-level
callers, but neither validator bounds the ocfs2_dx_entry_list counts
against the capacity of the block that holds them.

ocfs2_dx_dir_search() then walks

	for (i = 0; i < le16_to_cpu(entry_list->de_num_used); i++)
		dx_entry = &entry_list->de_entries[i];

over de_num_used entries with no bounds check.  entry_list is either
dx_leaf->dl_list (from ocfs2_read_dx_leaf) or, for an inline root,
dx_root->dr_entries.  A crafted on-disk image can set de_num_used (and
de_count, which is the __counted_by_le() bound of de_entries) to 0xffff
and make the walk read far past the end of the 4KB metadata block, giving
a slab out-of-bounds read reachable from any path lookup, stat() or open()
on an indexed directory once the image is mounted.

Commit 775c17386a6f ("ocfs2: validate dx_root extent list fields during
block read") already bounds dr_list for the non-inline dx_root, but left
the inline dr_entries path and the dx_leaf dl_list unchecked.  Add the
same read-time validation for both entry lists: de_count must equal the
capacity of the block (ocfs2_dx_entries_per_leaf()/per_root()) and
de_num_used must not exceed de_count, rejecting corrupted metadata with
-EFSCORRUPTED before ocfs2_dx_dir_search() can walk an out-of-range entry
array.

de_count is always written as exactly the block capacity when a leaf or
inline root is formatted, so the equality check does not reject any valid
image.

Found by 0sec automated security-research tooling (https://0sec.ai).

Link: https://lore.kernel.org/20260713205625.92391-1-doruk@0sec.ai
Fixes: 9b7895efac90 ("ocfs2: Add a name indexed b-tree to directory inodes")
Fixes: 4ed8a6bb083b ("ocfs2: Store dir index records inline")
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dir.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 5a7dee683418b..6305e465994e0 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -613,6 +613,28 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 					  le16_to_cpu(el->l_count));
 			goto bail;
 		}
+	} else {
+		struct ocfs2_dx_entry_list *dl_list = &dx_root->dr_entries;
+
+		if (le16_to_cpu(dl_list->de_count) !=
+		    ocfs2_dx_entries_per_root(sb)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_count %u (expected %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_count),
+					  ocfs2_dx_entries_per_root(sb));
+			goto bail;
+		}
+
+		if (le16_to_cpu(dl_list->de_num_used) >
+		    le16_to_cpu(dl_list->de_count)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_num_used %u (de_count %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_num_used),
+					  le16_to_cpu(dl_list->de_count));
+			goto bail;
+		}
 	}
 
 bail:
@@ -652,10 +674,25 @@ static int ocfs2_validate_dx_leaf(struct super_block *sb,
 		return ret;
 	}
 
-	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf)) {
-		ret = ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
-				  7, dx_leaf->dl_signature);
-	}
+	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf))
+		return ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
+				   7, dx_leaf->dl_signature);
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_count) !=
+	    ocfs2_dx_entries_per_leaf(sb))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_count %u (expected %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_count),
+				   ocfs2_dx_entries_per_leaf(sb));
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_num_used) >
+	    le16_to_cpu(dx_leaf->dl_list.de_count))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_num_used %u (de_count %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_num_used),
+				   le16_to_cpu(dx_leaf->dl_list.de_count));
 
 	return ret;
 }
-- 
2.53.0

