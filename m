Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405765;
	b=lrogSZEv/0E/QTyFjXKv/TPR3qgT0PNOS9EQK1XE87VUWF7+EBCq4AW9xa3p7nO+sVZZ
	 7q0IUQXN4U0vhVRUPAs4gvdI2IaVcPDyI7j91sF9EMPSdjjwOrccPDhhVk8RV8mJ4o+mW
	 v9486u7G7BFg1kPYsovz4A5gRaWhwkeCBNxayljGEU+rtvINhD/YBDR+1yj4ALi3IRMIy
	 t33vrw38IVxSJVOlk9AYQ32hZ58ymsu7MFskjV/D+5mCVIPpe7qfsKgO4+6rHmfPdCOIU
	 BX4PDwktzLZzKE7hTjbMtVlh/98CBkKci4XZ3gWmPlKjhlgx45sAWYCexFW/7UgNW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dukt5yeJZcOdAveQV1IpSzPHi5XOgzKPviUSAYxi3rI=;
	b=zD5vrwYfycBL/o3rOM6U0GRFPDJYFqqGL49U1E0xxiQar8Fmzpvyxq1987GV6CwigsM2
	 HZg08Pv06defCpEW7b0HzfylaCVWybYOx/UJR6Fu+65p/9idxl+r6fsklrefvjYV9rbeI
	 SsVD5FrjRRqm6Uq1eRZF06mIysbq9eIz3A9GbHD7KDUa9gJI9cf09eet3Q9rocjjjM/o/
	 8IxRyahEcWBnggrpGFq+Qj+Q3gLwetBPY8k6Y6Sa2IfgSni2vxWVs3hKpaxE1W18hgnED
	 FdxOELgUPJwKDS89R/mQ0SxRvzMKN+sZzQFjlrmh0C0b7c6jZsSuOcfp+HqBFxui9uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l72GwTkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F9606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l72GwTkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC66F1F00A08;
	Wed, 11 Nov 2026 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405764;
	bh=Dukt5yeJZcOdAveQV1IpSzPHi5XOgzKPviUSAYxi3rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l72GwTkzKP9QyiMj8iUveSz0gTDuVTy804uxDKx7Pfel2klkCriZnW4wJHKTmF3Mr
	 op+ulr2IRkvYqXJaiC4K6E1xlpc4FSSUK02jUK4340n9DG17twc3cAr8j0N6yq1jgh
	 hFnU3DmTx9CBuHqW9ub2gw8a1F3cm2KaBoYm/Jeqfn2DjXc8n+cQWlE2lqlkGJsd7w
	 vj7xqi1Q+GheHjRzuHmuCDSgEhZkaqHaXmnCAm6k7j0r9wXyUJ1M2sdlkcOtPSlAqT
	 H89po938HVsE6LpPzrD7jEyOfXt/7IZC/vaL3c/sdzm8PjCtZx4r6spjuEeFyIAlVP
	 raLfpOjBqIKOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giorgi Kobakhia <gkobakhi@asu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xiang Mei <xmei5@asu.edu>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ocfs2: fix array out of bound access in __ocfs2_find_path()
Date: Wed, 11 Nov 2026 09:02:40 -0500
Message-ID: <20261111140226.2169257-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111140226.2169257-1-sashal@kernel.org>
References: <20261107052223-failed-6.12-6193ce7896af@kernel.org>
 <20261111140226.2169257-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Kobakhia <gkobakhi@asu.edu>

[ Upstream commit 6193ce7896afb52a321a0063c8b6a45e477a84e2 ]

__ocfs2_find_path() walks down the extent tree and records path by calling
find_path_ins(), which appends entry to path->p_node[].  It only has 5
spots.

A corrupted ocfs2 image whose extent block is pointing to itself causes
__ocfs2_find_path() descent endlessly, writing past the end of
path->p_node[] array.

 UBSAN: array-index-out-of-bounds in fs/ocfs2/alloc.c:677:14
 index 5 is out of range for type 'ocfs2_path_item [5]'
 Call Trace:
  <TASK>
  find_path_ins (fs/ocfs2/alloc.c:677 fs/ocfs2/alloc.c:1914)
  __ocfs2_find_path.constprop.0 (fs/ocfs2/alloc.c:1882)
  ocfs2_commit_truncate (fs/ocfs2/alloc.c:1924 fs/ocfs2/alloc.c:7286)
  ocfs2_truncate_file (fs/ocfs2/file.c:515)
  ocfs2_setattr (fs/ocfs2/file.c:1224)
  notify_change (fs/attr.c:556)
  do_truncate (fs/open.c:68)
  do_ftruncate (fs/open.c:194 (discriminator 1))
  ksys_ftruncate (fs/open.c:206)
  __x64_sys_ftruncate (fs/open.c:211 fs/open.c:209 fs/open.c:209)

Commit a406aff8c051 ("ocfs2: validate l_tree_depth to avoid out-of-bounds
access") already restricts el->l_tree_depth to be less than
OCFS2_MAX_PATH_DEPTH, which is equal to 5.  However, does not handle the
infinite descent case.

Check if the el->l_tree_depth decreases on each descent.  Maximum descents
are restricted to 4 and the path->p_node[] array does not overflow.

Link: https://lore.kernel.org/20260922202159.2421642-1-gkobakhi@asu.edu
Fixes: dcd0538ff4e8 ("ocfs2: sparse b-tree support")
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 0a377ec4ed8ff..f33aa48a3bc57 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1796,6 +1796,7 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 	int i, ret = 0;
 	u32 range;
 	u64 blkno;
+	u32 prev_depth = OCFS2_MAX_PATH_DEPTH;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -1803,14 +1804,16 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
 	el = root_el;
 	while (el->l_tree_depth) {
-		if (unlikely(le16_to_cpu(el->l_tree_depth) >= OCFS2_MAX_PATH_DEPTH)) {
+		if (unlikely(le16_to_cpu(el->l_tree_depth) >= prev_depth)) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
-				    "Owner %llu has invalid tree depth %u in extent list\n",
+				    "Owner %llu has invalid tree depth %u in extent list (max %u)\n",
 				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
-				    le16_to_cpu(el->l_tree_depth));
+				    le16_to_cpu(el->l_tree_depth), prev_depth - 1);
 			ret = -EROFS;
 			goto out;
 		}
+		prev_depth = le16_to_cpu(el->l_tree_depth);
+
 		if (!el->l_next_free_rec || !el->l_count) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
 				    "Owner %llu has empty extent list at depth %u\n"
-- 
2.53.0

