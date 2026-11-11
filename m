Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406726;
	b=JNfGTJAsqGGulKZH8lUIw2ZGGhyohVhvrYh57U6m/TyhIMyZEOBnnFxopRS9LVrYc/J8
	 OXlJPdeQ97rejShY/fgtbnQKr/qgZzjD54fgVvemMLGQbxohMYTegcp2hmFrEiLhCmwQ/
	 jguUsRioOhxF74eLSzek6bjGf1z2xlfQ5Q8X1CEWoWV/359cPSYXNjP2oNcDlMG5OKD1i
	 k0FaETZ8FYh3uC1DBrVTmaoNctw5omF5+rWcqagQMTOPgnVy8SCB694LJQ/Zs6fCioHMX
	 PM6Sh40xFPULV03ZGUpcY7xgmF/J3MvsQFpGpouNN/Ghb+pNaTpPmdB430CCYPEbhLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cbEh3RDnsj4XssgncEcgoJ1U9HQx8+JM/llFHftymYo=;
	b=oKbcP18tNOii96k8KldSh5xeBubmPo2Km5VkORlXrXtKjOiZBoC+QbDapsGeVhsd0MN6
	 o3B4jfeCe85//Cb4yQSBEc8zJOuYJ5QaFmp6TTn7F55zqZqmYfnvh6WcWzHrnfHtKRn49
	 0V1rhqXauFv8HOYL1pzzdCWqzKA4zVa3VGRBvsfmyHF/ujx65pcah4BQdlJv7XVTYA4IK
	 KGazO66Dgai/nQVO4sNTByTEtQJaAdXSA84Mx+kNXrkUzBvdIegXXSOkattIkcMX1Wa/1
	 24xmcvquNicvWjdNGL4WivPJY8IzFw4NVbXAxnjgIRDYTUyPdfPRuw2Wu6zxtGZg9DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gG8xM3R/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A783606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG8xM3R/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2DE1F00A08;
	Wed, 11 Nov 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406726;
	bh=cbEh3RDnsj4XssgncEcgoJ1U9HQx8+JM/llFHftymYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gG8xM3R/LgY1v3uzdeFnIsdh89kiyu5qxtUV1j33NU19N0bGevng6ypzeZqSadLOv
	 Yvqj9RA27k7WBGuJNLVnxnFD1SOxW5ZC5dfCFU5roWhMdNUpr1rcjuOvnm1vK/JOaj
	 vDg7TeHbyI8tpismi4+S/lryNfKtpPucchnIhwdLVV7fElo3Nb5rqqZhfNxkTHuNw+
	 NgIWVo0Ma1Yi5kcKKgmjuL9r4zMAEyIt20uyiO/ggPdxjNOFwx+PPJduOjklPaXDXi
	 2w1QHKKBm9dbbcp5V+YDc201zdklbRhUaDvNq2WmI6LW8MzJxUZjkQioUT1KLAAfbh
	 w9w/6kCTChd2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giorgi Kobakhia <gkobakhi@asu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xiang Mei <xmei5@asu.edu>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ocfs2: fix array out of bound access in __ocfs2_find_path()
Date: Wed, 11 Nov 2026 09:18:41 -0500
Message-ID: <20261111141742.2282202-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111141742.2282202-1-sashal@kernel.org>
References: <20261107053453-failed-6.6-6193ce7896af@kernel.org>
 <20261111141742.2282202-1-sashal@kernel.org>
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
index 038cee19dfad3..7e48626dfa9bc 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1789,6 +1789,7 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 	int i, ret = 0;
 	u32 range;
 	u64 blkno;
+	u32 prev_depth = OCFS2_MAX_PATH_DEPTH;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -1796,14 +1797,16 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
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

