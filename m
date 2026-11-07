Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091694;
	b=yhE8pPbyD/chUuknmE0UuStGbmueQk6FNLOacSle8uQ8ZiTYdZVu8RFY6UAOIeC1P64K
	 F1rMXN6Un2VDFwJ/3UkzTo55EY4tSEIoUeEgyvP4FQCbziP5871BR+CdCbWwga4aUuppT
	 3PFtMLQp1PO7umJNP9h3spJY252wHXGDmNpQiga+jywXjShnQYNIIYiQeTVo++b6YWrGt
	 ZPme3s4ITtUN7ubySWcnecNduGugrdw70zKaVUdJsuPGtEDsdFU6JwbM9m3OGz6y9ZsP6
	 MKOwgklL1E3fu3d5gEJYu6ZmD5jYL1SwJT0iEEtk2E3bz/I5WcIEVM3v+4BdDD9dvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5YaiTR6YvNrjuQTrS8BnXcbgh9AurDD3C2wJRI/aBVM=;
	b=i/PEHncbMk3mk197hukgPPXZp1wlYdaagwht61Fr0XTvXRCXrFFo8QHItXistR8sbhFy
	 CP/519lobzjxEUVa5v7efrf4nerwbEFzQylPGBAUZOFyfi/Frhn1SXBeIiLXAXcqAMLAf
	 /bFFiB5mwaZDD+RoIGg1QendsuV7AszYoIj0xcWY36PvMAi5jtqMh2XhAXer93wVGm327
	 virAMrFELqbbB6EPV5+RYR/3SmxISsKO3sXLDF8VBsukuVd3uIF3Wos4M+nQEgww/MBqy
	 Q6A66glTmSzccJODq/07sYD6kzN+rp3EhHHoN2uVJsyxBuYuSkquAygg2maH4PldfCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wehaffyx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC9606A32C;
	Sat,  7 Nov 2026 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wehaffyx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EBB1F008A2;
	Sat,  7 Nov 2026 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091693;
	bh=5YaiTR6YvNrjuQTrS8BnXcbgh9AurDD3C2wJRI/aBVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WehaffyxMILU6DpPeAvh1jF4YN8KxbD9iSnKdW95fZkZZpmkvLvFXjQnmf4gQu/Lu
	 efR+vL+pRUU/RAubos6dBanSyx1pj8R270IxKYY+XxBWT+iV4AcAz+vsMxUKMCYuCA
	 lKY147zy26BJrGh3Dq6u1GxFUETuXaJH7UhBhrmi48wsYBWA22lsWslrveA9lAdTn9
	 2CmMflEsTPVg5ybkA8DnYvogxpJ7VLPNBHei8yadzU5NSeTxSVJirZ4qf8syGOTaU2
	 OUoJFou0DWndoS709NDUNkEehZWMTz47Y73VQknW74dGFtgnbYUqwZ8PhLi+yiDVHb
	 1uLtUNBui3EyQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 14:47:58 -0800
Message-ID: <20261107224800.340250-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107224800.340250-1-sj@kernel.org>
References: <20261107224800.340250-1-sj@kernel.org>
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

6.1.y porting notes.  Modify damon_split_region_at() to return failures.
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
index f0da5cb2b88a0..9206737d05ae7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -718,7 +718,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-static void damon_split_region_at(struct damon_target *t,
+static int damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
@@ -810,7 +810,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						DAMON_MIN_REGION);
 				if (!sz)
 					goto update_stat;
-				damon_split_region_at(t, r, sz);
+				if (damon_split_region_at(t, r, sz))
+					goto update_stat;
 			}
 			ktime_get_coarse_ts64(&begin);
 			sz_applied = c->ops.apply_scheme(c, t, r, s);
@@ -1015,15 +1016,17 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
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
 
@@ -1031,6 +1034,7 @@ static void damon_split_region_at(struct damon_target *t,
 	new->last_nr_accesses = r->last_nr_accesses;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
+	return 0;
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-- 
2.47.3
