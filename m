Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168908;
	b=33u0cooFekcNQSdK0C+Ix1RC/R7CUIk9hyGG7H5HmjTeIlXY9G7LpUr/219iRPpaowTm
	 arBC0+YxKyavfcTCEg277i67zdtuARair/TJIJe0LyfuUx6AUI1Q/ceqxMDi0Qt9lK1ql
	 CoM26RNrd43mlmL0SrzQ0EZAJzl70nYinCAhN+7BQMS1tA/5duZHXMNQbQm8BuFkNls3o
	 Qqq4cAB1OmZQZJW0WBQaySwIYD+o8X+NkKCGtphLt7gTzjezs/yYoFunStBYFmvJMXeA1
	 jYQ+KyN9pwhIgq4I6fyCCI+gkKVrmX00M3aORFpxO1IkOkjSMVo5Q0T9IUdf5TsWgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uQA9Oy9D6eu6KxEgI1EDIZ+uJxOBHu6oOt+CM7JsTKU=;
	b=BCbieoaisGVpfVyq+xTLKNmdblfKWpSrxPBppa+bfIQJ/GwFZUaUfbBE+7WN/M+MT2XQ
	 WOkoxiGnNCEFhTcMAsFfH5tPgXfX+gRUoaSXvRtn9zSAA6AkBaLLApEcpzLn+sEOXMBN2
	 iagXDGZkHp95wYHyYhjkA8zZQmSy8I1nL2VmxDEqtpt05JXcosqDGA2cY1LzmIEafW/oq
	 eHU0zAtT9qSDtSSqdyVgBR1AqOK9TzyCHelPODfHvvcHqCeJ+jAC5M0B2er1dpf+HcLRd
	 1SMk3Iz3JmlL+xOOlQcJ0xUSQ/LRQeOfG2Soc8/5WP2NKlwa9UpOQ4hBsqnA/gHhmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZGTGAoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90482606A320;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZGTGAoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339741F008A1;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168908;
	bh=uQA9Oy9D6eu6KxEgI1EDIZ+uJxOBHu6oOt+CM7JsTKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZGTGAoSnxPWLIuE6uo4I9+ALy76x261/kivftWKEy78SkHTjJDypwqsxHLAekK/D
	 Y6rUL1pbvzRfbkI4ucKZujclvkVBOlXYLDzyEcWrjBwNSh31LjynpwipS+L6vDHTr3
	 /rIQlowp9fXr0yKTk/Rk+Md5qR69ujJGJtdI8McQy9XBn0fdKux43BsjEV1IJzuI1K
	 nKVs5rTQabk7j1EbHPw9X1nQrP0o6Dj40e/Fwx7VVA/gGGajQNY7pozXe9nLK0blIj
	 tgbSuw5pEATop+IRLHGTSmnst52qu5zEMy00r8JJMLATRXguHoS9QJpWIHrHVzr0t9
	 jLUfoQME7suPw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 12:14:53 -0800
Message-ID: <20261108201456.116824-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108201456.116824-1-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
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
