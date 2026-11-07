Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090131;
	b=3gUubRJnys6Ehnxp3GB7xVRJN37jJagTXhQThCKr6dNGQ5g10EtABvu3bCeSTP2U4EZI
	 xqOhUjz+D6OimPiJCa3ywi0+vtcf3nK1z0gmc5FMkWIk8mT+iEFHJlm9U13gjMgdFbedC
	 YurkUxZv7v0Q42HLQcCbVxfxb1K5HkRnDudmqtPujxVlfaDqn8UJWArf6Y2VYa1O+rQGs
	 o1Xns1ztw4TXOGt1A7peNbWMDuqqpZt7/b94KE4Y431JaEvGtxvWDy3SDWz3p3Qta/q1t
	 x1Esh5M4K2d5nV+OpPKVace58yLcVWLbMUEDQGxNX64lQXkoMBjpyUbZDx5miGHPn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uQA9Oy9D6eu6KxEgI1EDIZ+uJxOBHu6oOt+CM7JsTKU=;
	b=Z6WCIWVEBGIdigAYjMrpzJzVaNnQsKPbuF42Zt/JlmlZ53hPcmTsNpY846YOBzXgDARG
	 lb7lpm8mUCOvVfZi9DkUy4A8c48F2+2tP5iBeRHXKtOZpG7TdUMTCtH/+/yUULSiqbnT0
	 mO5B0tf4pOpw+gamyKdDRseAuYUFbWXv2pt+Eo2HGqzUxDvbRVLMce1fLmj+xGn1wUKSs
	 RdjzdUUKHBVXCnuwvfUNzuMvA9q3Nc7DvQUdKLRTzMpe52L5I92C+u4CTItbGS9lNmynZ
	 90h9fi1d9o5Ofa6TBHeH25d+CgM1719kJiI7mWXNzAz2F0td8xbw8UG9KRpBL1laKJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eK3SGUJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AC606A32C;
	Sat,  7 Nov 2026 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eK3SGUJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF21F008A2;
	Sat,  7 Nov 2026 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090131;
	bh=uQA9Oy9D6eu6KxEgI1EDIZ+uJxOBHu6oOt+CM7JsTKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eK3SGUJ+hTk9RnrDzTsbm96CvUxA/sAAt8z0vcM6y9l/SBkeINJBgcSzXp9fH1j3q
	 W25eqed/DbIyDITqOmP9iTtfsULpID2zTxYENVem0TxmJsSIMDPr4xoXC85jjtX/Y1
	 RCgHLAh2bCWAeC6gmXKYRA1S8gXo0ckQWKLYmZ2Ayg2sou6KERpZnQmQD8a6qZgIxe
	 aM9aHExtmGc28U1E4j4xUCi9MNfwkZ/MgsJEkn8P87MWP3gMQGgmNAM8HekMQgpHgd
	 JDMsEplXJ/AbGP479I4gXqooPHgglC78AnNsCukDe/fRu+ZL4xXQAhGw50SCfyCUqm
	 4oCgQ6cjQSZZw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 14:21:59 -0800
Message-ID: <20261107222202.331476-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107222202.331476-1-sj@kernel.org>
References: <20261107222202.331476-1-sj@kernel.org>
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

Patch series "mm/damon: fix DAMOS bugs in core, paddr and vaddr".

Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory allocator
under extreme situation.  Patches 2 and 3 fix wrong folios walking in
DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in DAMON_VADDR.
Patches 6-8 handle extreme and unlikely memory situations that can cause
divide by zero and underflow.

All bugs are discovered by Sashiko.

This patch (of 8):

damos_apply_scheme() splits a region and apply the action to the subregion
if it is needed for not violating the quota.  The split operation
(damon_split_region_at()) could fail for allocation failure.  In the case,
the quota could be violated.  From the user's perspective, DAMOS becomes
more aggressive than expected under the extreme situation.  Handle the
failure.

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set min_nr_regions
to set the maximum size of each region.  If it is reasonably set, the
transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

6.6.y porting notes.  Modify damon_split_region_at() to return failures.
It is a part of commit c60874860762 ("mm/damon/core: handle region split
failure in apply_min_nr_regions()").  Without it, build fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 5.16.x
(cherry picked from commit 90c2fa6adfed7abe0935506a43cdff3a05c1fff0)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b5b6d00d7a3b5..9d4a78deaa06a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -828,7 +828,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-static void damon_split_region_at(struct damon_target *t,
+static int damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
@@ -1004,7 +1004,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					DAMON_MIN_REGION);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_filter_out(c, t, r, s))
 			return;
@@ -1266,15 +1267,17 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
  *
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
-static void damon_split_region_at(struct damon_target *t,
+static int damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
 
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
 	if (!new)
-		return;
+		return -ENOMEM;
 
 	r->ar.end = new->ar.start;
 
@@ -1283,6 +1286,7 @@ static void damon_split_region_at(struct damon_target *t,
 	new->nr_accesses = r->nr_accesses;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
+	return 0;
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-- 
2.47.3
