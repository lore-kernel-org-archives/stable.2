Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270656;
	b=TII/FuqRioweI8RJoz74FnADRnMkRanx1MdZBex+kae0Ipte4NAqXtBijrjmXZpYmfm8
	 z3U6NGfxyNQIAJe8AWHOTvON3JJB/l+0Hd4K+cAYaCpTmZzldTZA02oBbrEsnfdAgW/9u
	 eaRCzX5siyutusmICpWj5Dg/9QH/qMWBVjLRwUli5CyXERcZ+JwNYyKVhG+Em3FuGcjsN
	 bm4faEKhx94mhFiQzoK2sQQlzjTIy5GeEjjbYCm72/o9BHsCPzoCZRiK0D6xzsQ8wp0jJ
	 D7wPm1l6vOHr+zFbdU2Y72TA+MZ/KKxao9SWbIMk5vSBc94zH1IZLSXFKJUqAxKhASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270656;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Z9eiRA9OkFCUVhYH0CVOKfXufpFXWjFThguNF2Kcag8=;
	b=1e6xxyf3zfBW0UnXU0yTo+rMSHSDxqPhjRzcvxxMWxl95FVqIn0UWJOfKVkrTWImy/AR
	 gtvbwxTK0h7nVC0kQpWgYKUl5mK1ts5gertOYUHmKV9oLMY1QE57dp2+0Bv9WLm97/Sqr
	 JywxcDqM+GIwLNMoozb9aoJlyIt1GoF41DCuUSAQO8XIDnDlhbBW4G+PB8rXIKS5ED/Gi
	 VT0nB3h5oUH9aeFmoBDQBY1xc3i39YZ964r0y3RLCmzIS59VF0LXjK2CPkEkLBBJNALxY
	 /Zdh10ucL5unQpBQ4ntVSryLHN5dsfxZ3ShVv8yshG7L6zE1V21nmNDZzH0KR700wuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kywdYZ9U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73300606A31A;
	Thu, 29 Oct 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kywdYZ9U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8C41F01829;
	Thu, 29 Oct 2026 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270656;
	bh=Z9eiRA9OkFCUVhYH0CVOKfXufpFXWjFThguNF2Kcag8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kywdYZ9Ug0e28ktD9RtmZAUZDu9cJqQrgac0jhHi9o0dlkY7O+X0Bju4bd39AXgHi
	 EgLCIcRcvVcGG1cgPmENXxWWIREr26oTP1eZkn5SWyZsTbAxWzt97TtA+M9MUj/HqN
	 wABeNhmaozTOpR92/Ki0RYVT0A1Q4pgP564kyotL2zzR8YuMW0hZePN/8UFbzF77+e
	 O0fIfA8MrnquopUS5/QwEuc/ebmJDrtv9ik2HWl10hl5BzTv7VLJ1BwFjrhIAYdd08
	 vPWgT9XaF3oFxqIMS9kfKX91ZMXCjrQNBabgbkQXDTSl+0qZtYYU2O0/171T0Y5Cq9
	 kC4jQyFoLxMqw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:24 +0100
Subject: [PATCH v4 03/15] tmpfs: preserve explicitly disabled quota limits
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-fixes_shmem-v4-3-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=david@kernel.org;
 h=from:subject:message-id; bh=mHULKBAMs4xjW0VzLP2nnjZNPWIPFmkQhWvVe2XbF4s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4fN2Gv+OF4x4gej59Z7/7ftM+9pXHLJ5Rmj6+7Xf
 4pkhWa86ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi3skM/+y/vNxv9PrZ9qgQ
 RfP5pReWrHULWe2TdeTmkTsR7gLlNnYM/wu7pG2ent805f/DtZYFbY+vf/1y5yv3wXtP+ycdqVr
 ars4BAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

An administrator’s decision to disable a user’s or group’s quota
limits can be silently lost when tmpfs restores the mount defaults
after releasing and reacquiring the quota record. This can cause
later file creation or writes to fail with EDQUOT, even though the
administrator has explicitly disabled quota limits for the user or
group.

do_set_dqblk() sets DQ_FAKE_B when all block and inode limits are zero.
This means quota enforcement is disabled for that user or group.
shmem_is_empty_dquot() treats the flag as a reason to discard the entry
from the mount's quota tree. The next shmem_acquire_dquot() finds no
saved entry and recreates it with the mount's default hard limits.

If the cached dquot is reused, DQ_FAKE_B remains set: Q_GETQUOTA reports
the restored defaults, but enforcement is still disabled. Once that
dquot has been reclaimed, a new dquot enforces the restored defaults.

Remove the DQ_FAKE_B test. Only discard entries with zero usage, zero
soft limits and hard limits equal to the mount defaults. Explicitly
disabled limits are then preserved whenever the mount defaults are
nonzero.

Explicitly disabled limits now retain a quota-tree entry, just like other
limits that differ from the mount defaults.

Rename shmem_is_empty_dquot() to shmem_is_default_dquot() to describe
the check for default values.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: de4c0e7ca8b5 ("shmem: Add default quota limit mount options")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: code cleanups; rewrite description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem_quota.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index 43d3b4fd6cb1..d191ebda3f00 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -239,7 +239,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	return ret;
 }
 
-static bool shmem_is_empty_dquot(struct dquot *dquot)
+static bool shmem_is_default_dquot(struct dquot *dquot)
 {
 	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	qsize_t bhardlimit;
@@ -253,21 +253,21 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
 		ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
 	}
 
-	if (test_bit(DQ_FAKE_B, &dquot->dq_flags) ||
-		(dquot->dq_dqb.dqb_curspace == 0 &&
-		 dquot->dq_dqb.dqb_curinodes == 0 &&
-		 dquot->dq_dqb.dqb_bsoftlimit == 0 &&
-		 dquot->dq_dqb.dqb_isoftlimit == 0 &&
-		 dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
-		 dquot->dq_dqb.dqb_ihardlimit == ihardlimit))
-		return true;
-
-	return false;
+	/*
+	 * Defaults are zero usage and soft limits, and the mount's hard limits.
+	 * DQ_FAKE_B only means that *all* limits are zero, which need not match
+	 * the mount defaults.
+	 */
+	return dquot->dq_dqb.dqb_curspace == 0 &&
+	       dquot->dq_dqb.dqb_curinodes == 0 &&
+	       dquot->dq_dqb.dqb_bsoftlimit == 0 &&
+	       dquot->dq_dqb.dqb_isoftlimit == 0 &&
+	       dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
+	       dquot->dq_dqb.dqb_ihardlimit == ihardlimit;
 }
 /*
- * Store limits from dquot in the tree unless it's fake. If it is fake
- * remove the id from the tree since there is no useful information in
- * there.
+ * Remove the ID from the tree if it has no usage and its limits match
+ * the mount defaults. Otherwise, save its limits for the next acquire.
  */
 static int shmem_release_dquot(struct dquot *dquot)
 {
@@ -302,7 +302,7 @@ static int shmem_release_dquot(struct dquot *dquot)
 	return -ENOENT;
 
 found:
-	if (shmem_is_empty_dquot(dquot)) {
+	if (shmem_is_default_dquot(dquot)) {
 		/* Remove entry from the tree */
 		rb_erase(&entry->node, info->dqi_priv);
 		kfree(entry);

-- 
2.43.0

