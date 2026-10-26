Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007672;
	b=uT6PSEuvbXmhxKlmo2M3+vmFe+wQzk50RY3JNr1bKhrdihC1yqCsGasV0FRcfJgJGPIu
	 uKB3Xw7NNP5wjl4McePKirWmqILYY5TWtYrIH4D9fXLY9igm18ArPI8KfqVF3ypsXqpFW
	 /3rBp+N88eoXtx/C2AT+hA3jD8vcKcDWxvJD6tv2IpJabkVmlMmIRGSgHG9Pa2Yj3EgRh
	 wiwej4IRRouZAZeDE8rtPMGIGgZ7Q/anmr/CAPsTTX5DYDYsCXVCFOTkjymO7slokZOPU
	 ptlN4RqyfWcZPij2ehQNC0w3M8h71vSPzoJDN9kNGqZ9wgGwJJT8dija20S2rlm8Rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ju0wQu+417wa892fYJVYM+soH6OLcnP1RPOW0oc0dDM=;
	b=p6hXcgZLQhjiXJ4CCHAFSloen/w4IF8zzhKO8aXvClDqZavul/MoubVvegvl4aAALKFj
	 fgIZGyNVlMk1rh55VcX6k4NWWDygEdJw/Z4fi30zD/wDDIyVpsF8ej/e7QSr2+lhMi4YA
	 WKJbH0mZQMv69OuGYOlgoZajfaGX4aiYNciv7njip3F3j4+spFDz7Wlv755ZpnI0V6YI3
	 O7QkSqn9oH+nz9TydzzOzgMXcs+SAic0FfRf9Wj4nxUNRcFG2mWiNNtDFCSODGjYk40hp
	 B66bNcl1gWAXtzfxez1IOn11RN6rotgY5OtiBIuoEij0zmxv9mLL8SzQwJYXpNBvAiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bkq44vBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AE60A2608;
	Mon, 26 Oct 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bkq44vBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4491F031E4;
	Mon, 26 Oct 2026 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007671;
	bh=Ju0wQu+417wa892fYJVYM+soH6OLcnP1RPOW0oc0dDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bkq44vBorzSIQqNmE5BNdeuoyahOtvJ9i5Y+eF290s5oC8VnzESCnaiifiDGgU9Pv
	 /oihNsBnllA9zdlu0zmW+ZymZeMRlvki2nWcLwiMILvzfhn2dGoICcdpKQMgT/1u7o
	 0RZ5jMTxBTP8Hkqj0bkn3hpNJJw+PrSrKrGCeqnBMDc1AP3xhYcGogJBCKNmYOlMgp
	 Re5+CA4YLl/NlVqmLzZeDVBOaUo0GlojAkKFiUU/H1uW6MMtBWETGbQfPxYjT/t7x3
	 1QjOlu2g6QoIBXRNUzt7Wr83/+1As0Shja16nbj82qEDcwk7ptskwHIjvpzKkQ5qfV
	 WtwS7/rQfdlgQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:36 +0100
Subject: [PATCH 03/16] tmpfs: preserve explicitly disabled quota limits
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
Message-Id: <20261026-fixes_shmem-v1-3-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=david@kernel.org;
 h=from:subject:message-id; bh=CyHODL1qX+fF6X6EwBAvC5OXSBg9riD9JUneF+nbOeM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4jdrV6/fb3hxrsPVVz9n6q+lD7MXLzwfk9dBNvuN
 fJFqowdHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykT5KRYWetUuzuMLa/M9iP
 LYw6H752h5PKTQ0WDv5NKTFfTgs5tzL8U+icE1EXLplc5PfcZdLdbvMnH5maJ5htnXa7y7Zb0+0
 NJwA=
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
[ david: code cleanups; rewrite description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem_quota.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index 43d3b4fd6cb1b..d191ebda3f00e 100644
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

