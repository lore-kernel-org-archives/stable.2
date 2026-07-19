Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94317A2E8;
	Sun, 19 Jul 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476493; cv=none; b=ELILd86VC3YqyJ19DoftdNsRrFows6TRIqp7nFktCRRh9QBSofxgwHHQe+87dSm9vkKhCbRY8m5+JZDNgpcDdvx1UY3DaHaTU4iJ/dja0tltpP4SKcPpw8m2Oe9KzNN3IpVGVFOYmvJ8dqiBM5UG/m7O8yqUNs3Vt4nyLYo/u3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476493; c=relaxed/simple;
	bh=/K5q8QdJxQRJVjCWKKILFEhmvj2wUSTr6KXhro/pZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTFZE624MKcvD4yWksbRZhR0SnFBHp+DllChPA4PCTxOUDaLq68wMsA9c+b2QnSr5xbSNFuw+rK3bis54NzXVVC4Xfj/LZWGN0+hCMhBnX+rJuCR08WPvAAny+wHPrDJ3d4NxR7eLOoTxvOdV0RfFDE1HwFYzacJoYe60yEj9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjNF2/0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjNF2/0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C7D1F000E9;
	Sun, 19 Jul 2026 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784476491;
	bh=KpBYAIEEhQYYNRww20xUWDkU0MM2Q4yUHB2q9Y6AtAk=;
	h=From:To:Cc:Subject:Date;
	b=KjNF2/0QuHjvI11h671X6m2vzeHGh2gybnN2uZLis4mVdkPe43kBLpeXWgH0mPpYS
	 Oa//fnDGaKnC1r07nP9PVfe0DJG5Z7I3iKoYEAoZGZbcbvpcWMCd+7bjJ3H7jpPkq2
	 1U2NZzdudIO7LlnH6vUxSJXZmShAcYES9SnyH7j+6n/Gb487Ul+BYiPWWzosmYQHw2
	 lQ2/DDSC8m7toz/L3DBEXVGkdZfve8IN/8SZl1TxhHzPGkwY/MsOFZ4sr8AQr+kNub
	 rGucIR8bbeLfVRBOvrM+dn/Gf4P8BwghLd6LNgIQdeq1mwxcCUf9P/F3EcWmaUB8G6
	 nXXyTXx4bmyeQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Sun, 19 Jul 2026 08:54:40 -0700
Message-ID: <20260719155442.88794-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_apply_min_nr_regions() repeatedly split each region until its size
becomes small enough to meet the user-defined low limit of the number of
regions.  The loop assumes the split operation (damon_split_region_at())
will always succeed and create the new region.  But the operation could
silently fail for memory allocation failures, for example.

If such failure happens and the region was the last region, the linked
list-based next region fetching returns invalid pointer.  As a result,
invalid memory dereference and corruption could happen.  Even if the
corner case is handled, it imposes stress to the allocator by trying
split regions for other targets.  Fix the issue by breaking all the
loops for any region split failure.

This means there could be a min_nr_regions violation.  It will only
rarely happen since the allocation is arguably too small to fail.  Even
if it happens, it is only temporal.  damon_apply_min_nr_regions() will
be called again after the aggregation interval.

The user impact of the issue should be minor, since the allocation is
arguably too small to fail.  But, it could still theoretically happen,
and the consequence is very bad.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org

Fixes: b1029f29eb1d ("mm/damon/core: split regions for min_nr_regions")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260718001442.87129-1-sj@kernel.org
- Break all loops for any allocation failure to reduce allocator stress.
- Rebase to latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260718004301.88883-1-sj@kernel.org
- Drop RFC tag.
- Rebase to the latest mm-new.

 mm/damon/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 20d267c615faf..e0122376f43d4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1886,7 +1886,7 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
-static void damon_split_region_at(struct damon_target *t,
+static int damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
 /*
@@ -1912,11 +1912,13 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
-				damon_split_region_at(t, r, max_region_sz);
+				if (damon_split_region_at(t, r, max_region_sz))
+					goto out;
 				r = damon_next_region(r);
 			}
 		}
 	}
+out:
 	return max_region_sz;
 }
 
@@ -3411,8 +3413,10 @@ static void damon_verify_split_region_at(struct damon_region *r,
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
@@ -3420,7 +3424,7 @@ static void damon_split_region_at(struct damon_target *t,
 	damon_verify_split_region_at(r, sz_r);
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
 	if (!new)
-		return;
+		return -ENOMEM;
 
 	r->ar.end = new->ar.start;
 
@@ -3433,6 +3437,7 @@ static void damon_split_region_at(struct damon_target *t,
 			sizeof(r->last_probe_hits));
 
 	damon_insert_region(new, r, damon_next_region(r), t);
+	return 0;
 }
 
 /* Split every region in the given target into 'nr_subs' regions */

base-commit: 1111bc7bc679131632fe9f436f4c990e8b86bee5
-- 
2.47.3
