Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046946;
	b=u8aHOihOry4ObIoU2ne+2d4a4fZZI7m7bNipN1PiItCxTkojOydVmAsQaV+VVuGjEzpY
	 vnrE1LciivLj/p5GobAuoyPrncd7t9/kqFhhOLjZOG1/nabQTgw4QDCclkAAKgSjXi4fE
	 p6ayZgnkYrKv+lXQ6DXKY4MLKY2n0KfC1zGip3jELUn3OLnYTeIWdN5/93GWJnWf/OPe4
	 LVgeVHFCl4PIQn9D/sMBvveJ5ulbYcgt7bSz867NdSKel9LmezDIB7T2j8Jo0myWNqcFe
	 cxOUHwpY8IJYQy33rE/DTE8DcravuHYF7dzBldO6stVBImsIr7etgOmqwpRQvkbUKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PmIRptGtgBn1re/taVXoQs7YS1qQu5ffO2wrOojrRiU=;
	b=FCu+AaORZtR7QP6uQwaBPRQieL93AhIjIKJ2RGLqke50xXJ2iDgdRQVCEiu8nXWQAp1Q
	 0Gs96QlyTx8I6fykcxTDEizj7icRVGASDsAJblKrW6eDmSNF9aOCzQpX1F3DdgaMt5pC2
	 lrtx+wn1j5S34mIPbZv34l7c6H49N1B2HjPsB7VA94TBWyFSIfML9bw5Wuyr4hFkwEES6
	 +XPigKjYEs3VcOWgYWI4iGHbxc0mIryBx3bVwolT+J9fbVOUMA89grPH0CuEGKnBFr/fX
	 PSyQyEYL9MYH7BH2JmOfi4YVwwwJoXE3fXyC5AD69uqjqgGekZDT8aFYouY0sTznSmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QV1VbYHa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEE606A8C8
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QV1VbYHa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158001F0089F;
	Sat,  7 Nov 2026 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046945;
	bh=PmIRptGtgBn1re/taVXoQs7YS1qQu5ffO2wrOojrRiU=;
	h=From:To:Cc:Subject:Date;
	b=QV1VbYHamdazEaArf0HvFi6XCV/YpbUiSMAW01D1hxhTrYkh1XwMYQR/JkZrl9jHf
	 kI/MuEz/hV2NAX0cSbCxz6anq+kzZr3eBBz8+7Lbm3mesn6oWQel1sDCrXHjlntGM1
	 CvgyopxIcOydyhgqDPndbIKiNNys0VwK/eNEFCS23s9fdekl9ANiyOwgegfeKetmk+
	 bX8eaDU61Q94SAOlhHUS+B3IFB4oG+yhdw26E+zky0K5idmdQbXjFtAdj3HGBHl4a1
	 yUgv0vfOP3UOB0TQn0fiN2vLKugWeE2F9rNTz6htct7U5a+7L9IzMrTvA77b9zb3G/
	 ScduInbJBD25g==
From: Sasha Levin <sashal@kernel.org>
To: gkobakhi@asu.edu,
	akpm@linux-foundation.org,
	xmei5@asu.edu,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: fix array out of bound access in __ocfs2_find_path()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:23 -0500
Message-ID: <20261107052223-failed-6.12-6193ce7896af@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6193ce7896afb52a321a0063c8b6a45e477a84e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052223-failed-6.12-6193ce7896af@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




