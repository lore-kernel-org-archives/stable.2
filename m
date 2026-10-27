Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106227;
	b=r+hCPTAdBLjO5YMKcM/vnq1jV88QwrH/m3M/lzOkReVayAdHEi6t+SSc1hKnRHIs+sba
	 dUcCKcKEtgR6pA3lYMTwNKW4tX54vA6BbpdKzx5ZcerJSapJjPPvPeGja9StiW13Nzgj1
	 wUpJHLVHCiiCHcG4H8BqjMnQIGMWakHkkgWpM5bmsL/qEpP09qicqTROH+FMDMfBSYxOP
	 rf+PbDZJJhgsqe9+a1QL6G7B6knuYh6dD5Nq5BMH77/CNhfo3VSTyYP3r3kNIPTpPQZ4V
	 XBWPVGofamJOkwzOOCKdiHJVXAZRPk3/kj77Qoi0EhcEICwXglAGAtUfrqliz9sQKvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106227;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FuTQQCIIhCRj/ogwMUaU/txEPw0T6il6C0pniQihRqQ=;
	b=K6JuolWK4u0Kz8Z2xD+bayfmFqzgHkK8fv5Y4Us/dBn0tueJWQcQlHxjBC/Hhm6izC8O
	 ku2sHMqgih23UOV87Kydt6Qp6t/eNP65XQB7D3qf38g2CID8OhrlCoSvXFl+nv/bCUrur
	 3zlPl+yaxmW4XOY/Ban0UCW+/4Oc2M4ZJzr9CkZKtpy+IbGPMoxcyBKGWP8MBy4tFo8Rd
	 gLSgqA9WNrkHv0Ci5mv4X2JNaVBYeNgmFBeuGZgTxXob8MggZGsIjhqosrLxrZhbbOnSG
	 RjyXNbtWytTaOhj7UhDkBlk/whSDwj0rvkljKoYBBAZ4zBsgdoOF4GO0oZYtLjVeZqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntWz1aq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBE606A31A;
	Tue, 27 Oct 2026 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntWz1aq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4751F01825;
	Tue, 27 Oct 2026 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106227;
	bh=FuTQQCIIhCRj/ogwMUaU/txEPw0T6il6C0pniQihRqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LntWz1aq54bGNesh7BxKU9O4TTVvUn8Nb85jHj0+dEg8gBWUsiJ7EEsWPcueC9j0X
	 FEuCjgO84J4BAk0jUowFE9WbI9ZGoKLdwgkpL4rVUhTEV6NYNUdjZgLMw4A4BGrJv5
	 gjo1NCsMWD7eMYBn0FWhWSbdWub9sNQok57/LZA5p4iB+kJGV8bNp4iAMwTdttRLrh
	 JCz1Tp5kyVK9krOqnecfbenbFoxboTngoFDFGhcdM5Qfsq/4xr02OvkZgeCRbjhs30
	 Xlahlb2PsI8DOkN1tgA38JdF9skFrmcmNRvKiCPzQml01gRIi2OXy6Vr+V+N42C0mA
	 NGFNhzFrX8Utg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:08 +0100
Subject: [PATCH v2 03/14] tmpfs: preserve explicitly disabled quota limits
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
Message-Id: <20261027-fixes_shmem-v2-3-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3975; i=david@kernel.org;
 h=from:subject:message-id; bh=F9NYnsgH8oBV9j5aJk45w6lMYbZSDg8OHv+OvgcNne8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBSImX5u9oq8Tz/OLVvmufhkyP6PYpnd6z/uOerZu
 0/3Tr59REcpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATmSLN8D/lhY3YFJW8jPJk
 Jg0O3cCODbd7eO7szKyOebl/KQ9niz3DP+ONsuyv1B4p9m08uLNo0Yup1QWLVhxyTHw2L1Rj3WH
 GUj4A
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
index a83392f75e56b..eeca9efd448a2 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -234,7 +234,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	return ret;
 }
 
-static bool shmem_is_empty_dquot(struct dquot *dquot)
+static bool shmem_is_default_dquot(struct dquot *dquot)
 {
 	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	qsize_t bhardlimit;
@@ -248,21 +248,21 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
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
@@ -297,7 +297,7 @@ static int shmem_release_dquot(struct dquot *dquot)
 	return -ENOENT;
 
 found:
-	if (shmem_is_empty_dquot(dquot)) {
+	if (shmem_is_default_dquot(dquot)) {
 		/* Remove entry from the tree */
 		rb_erase(&entry->node, info->dqi_priv);
 		kfree(entry);

-- 
2.43.0

