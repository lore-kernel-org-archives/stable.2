Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408297;
	b=1Sg7WU6x/MFRtvrHZk58fJQy6liV558zyEFW+qva2YMiVJq11ZteHdHhcbs9NzqhBV3x
	 cFLvw94SCiJY+IlkJMDyiDCbgtzkJjr1t96aTd2pjIXIc2S07+bdLC6XxOqWu3JZ0uNbZ
	 ITVWDvo4pJIqZtcJSchjJoeOGTHJYCrt/61m+D9hURdcD7HoXsyM4cbDJHaJILzK6i1NB
	 GWRIdR0NRuPsK8gwRrYx0Bql3dKwFO8RT7tayAVeXh45Z0LmdfI86bJ9X1k7aSqF2bauI
	 C0G6CGCS7m+5gHDrAyQ8tFdvaruqGyXqp32des476yGg0GQ6dDR/FdNHwR1wbvMo+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QL9KjYkLJ5AMqZJ1gM8qH0ZGgDiOxNntA3/ZK7TuFdw=;
	b=OuXoFBUVZhNciI851kQB69nuUyJv8LK+9ZxlyL9CsGJMC9nHUPmhR0TRV6PetLx11ceG
	 2ZwKr8uXePco9tzCL8/M+T151WqJkZYk9ip0sK3oL0AkVzt6vbCD/NPbAx8wc5HX3f3lR
	 /LCzjk9dSpSkekgvrdoAV3f/KozqIbl2DMEPTcaxwdOP7XoSnJ+W0QLw1edoWh0vCd1fH
	 hmB3jEgILL73ICMwJqcbsEqQtCBg9Z0dPfjTj0NQoxDYE3xENyO9xVPy36lVFo+a82A0b
	 rKTRuajAJggDOVKmQ3Q6h7EVC0LWC7ylQxjRZSqZWNEcD37TkzQ40aMO3b5+UahdTow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbdCa05F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DC606A895
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbdCa05F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551611F00A05;
	Wed, 11 Nov 2026 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408297;
	bh=QL9KjYkLJ5AMqZJ1gM8qH0ZGgDiOxNntA3/ZK7TuFdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbdCa05FmpZ2H6LNE/7OrlrcNOn5TMr+hI5PRmT1OcEHxwM+umOeCqmJ6nsszZfiA
	 zByvx4D/mOyRXxiDgQCi9vcaK+hAKcrOvFm2ZxHoTStae6Bg/5Gow1cOPXCjQGSTrh
	 ttBhXZIahBmLg+viXKdS8TwI1fesLQeHUuauM3OT/aCAKSe7o7LM/NgD4AVtUnEtYM
	 xas4GUeIlTY876ihqxY0EmQIkTQY066KcfH5odLgsxgoUZjSP4cdZFr41URCKtOOgH
	 Mpqoq8V1lAsNebhTO9JRZnY318uClFGccCbxLJWoD8iVmR24WYqmhnC8q4FzVJI1CB
	 WUM8ADlxSJaDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giorgi Kobakhia <gkobakhi@asu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xiang Mei <xmei5@asu.edu>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ocfs2: fix array out of bound access in __ocfs2_find_path()
Date: Wed, 11 Nov 2026 09:44:52 -0500
Message-ID: <20261111144420.2422486-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111144420.2422486-1-sashal@kernel.org>
References: <20261107062251-failed-5.10-6193ce7896af@kernel.org>
 <20261111144420.2422486-1-sashal@kernel.org>
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
index f7c80cf1f1efd..cb92a653429e1 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1791,6 +1791,7 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 	int i, ret = 0;
 	u32 range;
 	u64 blkno;
+	u32 prev_depth = OCFS2_MAX_PATH_DEPTH;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -1798,14 +1799,16 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
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

