Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047696;
	b=3yS3bheMDpvvOIT9M2ECrLO8MRg1c1BLtbCjh5L7Sml3EBtp1vmVft4eH43YtBuuP07N
	 SqoUGhV0TVWvxdZ6hmBg8add+eEhX5U7F8jEKEudgp02jD6z/dfCCNRAaOjz8FHE715iI
	 m7gj4QfQ70ah8Tzc/3zjUI7kGi7v71tg3X/Sz1GYnEK/oJ7PRd7nvdvbDfYdzfMICPuMR
	 by/91Ad+qq+3FUzw1yUXJ5HKiJecAB0FaAUlwy+fbOAPqqaE5fvxJqD5Z9J5DzOR9z1Rq
	 a8kM15eV35vaE07llqo0/db41JU6dxucNxnGZUFvpHPx6i+s5lj7v/O65jD0UgY3aOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047696;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ANVggE661r0p9QeoE15SfxxnvNjjC0RhjRyxjCTSCYQ=;
	b=rjh24Jeen9IYn5N8s8hxbrNLI1FlnLSRLcW/2TQY0jV3XVNGVuJtU3dW52VAoFl4CWdm
	 o1OJp3wH8bpE8LdqdE1EG2V5BrZUxd6STfNglan2GtUwTZx3TlDHaoPkbUXtvbwXUPfYC
	 kyjQBZG2fCmhApexEoVqkeVmKMq2MHPtrE9EkI2OwB7rx4MK/r5vRwVItCbmxzrnl+wmP
	 tbxCbUqtFS9/smNDpnYkVE50y+jZS/ptiWOS/c1e5f5oG+TSj3R96ngjPLbxNxsfZfwv4
	 HRhDFRP0oFvIWyNJyX/539zZrI/sJqs7en3EJeC1fZ8dXX61j7MZxSjYfGMYrjkA9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbCBqGuM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbCBqGuM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4831F0089F;
	Sat,  7 Nov 2026 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047695;
	bh=ANVggE661r0p9QeoE15SfxxnvNjjC0RhjRyxjCTSCYQ=;
	h=From:To:Cc:Subject:Date;
	b=jbCBqGuMQKL4xX7MkwUXhpaIdxN8KIRJQV+kggtfRf28rA8AJTHPGgq8lE84EQAy2
	 mMKPedhFTa7wWLFVyBJZqTmPTId9GaROoeWukDDD2kEd0lsZBrXA4sHJCdC3LLfYd4
	 H3b31wJ0zebgTpGoeNuecUdRBLn4WxZILjFYn6tRX1qDwzvymL+5R+rnfOyKflAL4b
	 rnWNdOxFJVpMtCQJAMJrEg8sfL6k0/tc3//EKldgXCdm2M18w4teEDAXClz1AVYWxL
	 B1EInB8SGfuY8KdFrPi93qv9gFcRuM242+GcHKfx2qTajFo1cU5lCg2u+cVolClT3x
	 SjN9o2rHQWn+g==
From: Sasha Levin <sashal@kernel.org>
To: gkobakhi@asu.edu,
	akpm@linux-foundation.org,
	xmei5@asu.edu,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: fix array out of bound access in __ocfs2_find_path()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:53 -0500
Message-ID: <20261107053453-failed-6.6-6193ce7896af@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6193ce7896afb52a321a0063c8b6a45e477a84e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053453-failed-6.6-6193ce7896af@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6193ce7896afb52a321a0063c8b6a45e477a84e2 Mon Sep 17 00:00:00 2001
From: Giorgi Kobakhia <gkobakhi@asu.edu>
Date: Tue, 22 Sep 2026 13:21:59 -0700
Subject: [PATCH] ocfs2: fix array out of bound access in __ocfs2_find_path()

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
---
 fs/ocfs2/alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 2fdc5403b10b0..fc949e5946269 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1844,6 +1844,7 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 	int i, ret = 0;
 	u32 range;
 	u64 blkno;
+	u32 prev_depth = OCFS2_MAX_PATH_DEPTH;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -1851,14 +1852,16 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
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




