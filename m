Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169688;
	b=uUp2AqiTTqWE/7XePt4A/dWoTWpJ/AUDNAX/icGEFbRyi/18fdVNkanLIe4fM6De7rwo
	 lpbjTuZ7ppCRDdt3PXrV0q1Th2yU/e5e6lNqiI17iSSE0XzkTeJGPcU2qTB7yGS/11EA/
	 hcwAF9J6rV1Q7xUhwCUkL7RfoFjRUnYqhMteIss7ieh7PrFTqY79my1xFSKiL9L/Nv3DK
	 Mjo92mCIKR0c3uijzHpHU38hIIrVw6MNETi+zWt9wSuPnwgIGbMTUzl3qc15sKWH7oI16
	 ezjyo6Tp3GH3/oKg3Qjs4N42T1jm2CAHVgrrGVk3TShUuy3CEfcQ7dKzmvmXADMFBFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5YaiTR6YvNrjuQTrS8BnXcbgh9AurDD3C2wJRI/aBVM=;
	b=O6QA3s5Qo/Am7oEPHAAiYK6dUCU4PF40nnIMGw4ZUpVr0a3CqZkQkfNEeLV5lXpRpQiU
	 5JSjXj3ECjZbtS9HOHJ7E86CAPXmD36kBf3gh+QsyCLnfo8LxULNruVecyZ6IpUwSsSC0
	 S/1h65XdeQtZz4js4OZd4hBq2fyVVRkIdgsRcxnVSj73xg0xyCc/OGVhff4L5kxxUbybw
	 8rUTzYmx6hZcpnLgJMMEs6sAL3gOaieoEwhUlrkCZuOB02VOIuRNxYCxmsPXPVUjlevwK
	 v4jK9tXSDVqDJQBof3yBPETMD0OFicN8tGOo6Yiw01Vdu0STyh/XgQJYaQl9U0fWiHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drJI3pUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF16606A335;
	Sun,  8 Nov 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drJI3pUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B2B1F008A6;
	Sun,  8 Nov 2026 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169687;
	bh=5YaiTR6YvNrjuQTrS8BnXcbgh9AurDD3C2wJRI/aBVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drJI3pUcu28AmbrSo8Vp2Ld0QhvA3rTIT70Q7TlkET+5DSFDiSPMy2kwY7h7E+hjp
	 3JZ8qRGYgwBa3/2PwT3JQ9jiN2GiESvI7N8pyEQ9fg4wQvdI0KK/t5Dnk1It2HouZU
	 Fzxd8qKTTtguL4YRPBf8GyZdMrm9bMeZ6sXbB9nMQxirougefh3pMwmPCinLYkPB1P
	 xMfKjDxcS/10JvYt55IS17I6ml3xRSxhOQvPwFj2KYqL8Hih6Fn0NxywxPxf1VFdEv
	 /lxa+zT5XQAkaaeE8mYSDdxC/b5an/LHIUv/1D+Kiplz16EH8Yg9cqLiBBtbdoSmfC
	 EqBEHhP3gIJ0g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 12:27:57 -0800
Message-ID: <20261108202759.117377-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108202759.117377-1-sj@kernel.org>
References: <20261108202759.117377-1-sj@kernel.org>
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
