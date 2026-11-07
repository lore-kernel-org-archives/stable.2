Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050574;
	b=4YPR31QbJwehe/2JwQJmFmMmkbGmdMSCmGAuggPpCs0ZB+Rxi+f8i54A8r4Uh4y6xxkD
	 qOmcPhQ3W3rwiGiJ7whScAOiSuLr885M/dq1B3jOMjQ88Yye3FOSN+0VR77x5povpEVVj
	 1/Nb6y0wzKkPWz52glwukPlLi8HJgkONUsh0vzgadqp+fDer669Af2mlmR5YcENUSr+Og
	 yiEFM4t2ndniRM/kAx9yLXAm6gVM5CsU3tmEFWNpYU67WsY5H+Clic5hs50ycmAccY4WS
	 qkw0vVYITeUYVkwXWQul4LYXgs50W2dyTSZik5UTSEBCPEqHmLt3ykx4D1JHCYT6bFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=od/EwJDF8crgSkxoQgRFgHJEC/B0bbUHi4S2TUkispo=;
	b=fKxKztEN3Uwq4XCDtcH5yPWScK5yjz0uZWYdMZZ7TCS/qz5wmtRHyHqoFuimE9VFrNHl
	 3+rVF8oAJXN8laBjgygSmw2yWGlyDq4b4odW7jIinW/xjs/zO4a5rY50kuAeJAlndhb2V
	 A5AyoF3X51tMDs6i+vcKLrG+eskhcCAJA7WHjROa2Dm4CYacv7K8lBdbqPSOoos4BGgdm
	 QCP8rs1wt1Esmq+TzFfcBLecWYDFkRQj4kSW3I9gveqUHXIdc+b1Ow4RuKyq21Y3QEM34
	 rbVduwKTgll3DooqpbGTuhcIe++VOOvXDs8kbveiqFYAvWXqL3CgDrETqsaqUGcMhmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0TErJKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0TErJKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE31F0089F;
	Sat,  7 Nov 2026 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050573;
	bh=od/EwJDF8crgSkxoQgRFgHJEC/B0bbUHi4S2TUkispo=;
	h=From:To:Cc:Subject:Date;
	b=C0TErJKOgtpqCVMXDZFeLRfzug1qrsfAPRVrmhnORYdJ2pxwbvEtuq0IxFyivpbxg
	 zrJWyxhf56pM/oxwUC/KdR9Lqm3TmxDCyiqSBS+SOJ5Q3ihGJn+4cEon1cmN+m438O
	 HuholCqFuC+rx+emEKukmoSxQNIoAGVpfJkYfu5fl0/tvoQcACrKeo0v7y88EmFMsu
	 dWpk8rSJxDy+khwG6c0andezmVi8bTlvG9iZdcsSU4kMP6Yws4Lbkv8BAntuCHwu2z
	 eZdQXxOZv/zGoWQ1OlC9t3/J0WT9gJ917rQcyzS4mGY3tFdvaq1+rFuTC7GqKkRh+u
	 ncOXdYpfLRTpw==
From: Sasha Levin <sashal@kernel.org>
To: gkobakhi@asu.edu,
	akpm@linux-foundation.org,
	xmei5@asu.edu,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: fix array out of bound access in __ocfs2_find_path()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:51 -0500
Message-ID: <20261107062251-failed-5.10-6193ce7896af@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6193ce7896afb52a321a0063c8b6a45e477a84e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062251-failed-5.10-6193ce7896af@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




