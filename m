Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082210;
	b=cVuFaChthUqOe+UJM5rfyZNrMNVptLyapXIUsTDFJHrMwqWBgIBFM+iG821r0pBvhJw6
	 R5oZnQsfhQRQmsDIFnww67Pj5oSeBujjT3RaljGKzl8FuYbVfFh/GprGSgFqHhxH4tAAh
	 IpgppU2+wk02IhbFAQGcvwy8yN77sJOBGFzCs+p01Hl+aojNm5h/bEtmNcLJFyA6tLmwb
	 DKBAoTgGKihqKmTQtOIeNR3tlesZ3BeM+JQsibKt/qIydRW6c/ar5rUb7ZURzHjxCm5b0
	 F0InhHz80+GI+hUH3KBCKqTHO2rwOwuk/c5RXd5GehZgoloZffDU/geHcC2BQ53oUkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7xZ+n0JvDN3hrYenLHVXLkTjZ+lK0ATIB/YUR73+pmo=;
	b=fwInv+yPwgrxvGiFE54XVtoFswaq/JblNLoEdyikVC/Z9BwPFwz9kMa/t6KEoUb/RC8h
	 2zKevyf+bFQ67OQykHwp3NgBwB0o+gdR8vADzGn4ITlUCpLYmQbyvrpAlPqivdCeBQOK3
	 mJTjeE7xtF3BP1uuthq73q3pT1Ws1N2Fao2vwJNAN2EOXzbJdcmR2VY0JqAkprrKK8nLX
	 G4eosgfTtCTjjDWHiIta1euQYZ/bkoSzRIQhA8I+atDxwR+noR2GjhQmGhlkXUlaaXngf
	 k7Evn/+2OFPwmNi0wyBL02nyuUP6qoMe1R9tzf5kFVgth0FXs5K3z1ybpIaqJ6EhjDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwVMtEuT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC96606A332;
	Sat,  7 Nov 2026 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwVMtEuT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A3C1F008A1;
	Sat,  7 Nov 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082209;
	bh=7xZ+n0JvDN3hrYenLHVXLkTjZ+lK0ATIB/YUR73+pmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dwVMtEuTJ5rlYV9k6tS2s3XV+LH54GnadV1bpKatYsQ+cshaJXCCBerN9baepeb+i
	 wMKX5dVtJPWcf2yX5XEg4h4t0n8tOY/PP+OXUq/EmQ+BxboSqKLE/PxSHwuN1x+sil
	 x4n0XaRVduvJ8XXL+krw+cxz9SLpfcoFMuZC811hIgIRawy16PKW2cc2XZC2JiQUJ3
	 hzufchlNNtYqx2IMLNd87r6PIT93UNTkgXOQDg1h7xoXdim5+0H5VwOsuZyom4B409
	 hRFoO+IG1Fn3DrdJ8+QPRh3yKLwxsVep5QBaEetxWt9zJI0ab4XYJEHIS9C9zKu5Pj
	 KSsmLYfwO4Wrw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.18.y 1/5] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 12:09:57 -0800
Message-ID: <20261107201001.206120-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107201001.206120-1-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
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

6.18.y porting notes.  Modify damon_split_region_at() to return
failures.  It is a part of commit c60874860762 ("mm/damon/core: handle
region split failure in apply_min_nr_regions()").  Without it, build
fails.

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
index 8fa788b0d709c..4c536a9b958e4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1700,7 +1700,7 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
 	damon_set_attrs(c, &new_attrs);
 }
 
-static void damon_split_region_at(struct damon_target *t,
+static int damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
@@ -2000,7 +2000,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_sz_region);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_filter_out(c, t, r, s))
 			return;
@@ -2454,15 +2455,17 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
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
 
@@ -2472,6 +2475,7 @@ static void damon_split_region_at(struct damon_target *t,
 	new->nr_accesses = r->nr_accesses;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
+	return 0;
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-- 
2.47.3
