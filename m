Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046784;
	b=km5a6x4sLNQHO3drePusyTjxyvP4UKrmyd8WuEvWhYfh1BWh8hsQohIHD4/cu/X8X25V
	 FR+FYUUwFGvWFO7SZ+ODdRuzv/Luw+0lHiOh2h5otu1Sh27xmjEY6VY5HPdww4yqx9Zt6
	 M/5cy7LxhErBGPXGakHxZpF3UftsR3m9uGiHXOXI687GYE+kxG/9PpLMakJOjZDhFyyOf
	 cK3bYSrJeV1WQJ1+fPUdXme2Ja5W7lNhcVl7P0uYzZBP7gz4K5ShrNNCtZg5lTIMG6Lu9
	 M5wsiNPQEWTYWZBu0pn4P8O9nq1wKPZvbY0mtRBw5+Pm/twMCUu4MeYzfWxFKw2VN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QpBFjVgElnaHzeHQS+r6f9rKajllvimEeA195p1NErA=;
	b=qTRdqRO3pZpyr1KD6L/qMYrN3giMCmlZXsnNIxBNOzkIP9zAyN4obpxiakAGOiKeh3ts
	 MD7FLL6lS80wfkDMonjFr7oZopcCbf5JnoztKus6IZCoKalNSWKl4aXMYWBweWp3jlTPK
	 Kc/ILxrDm+9CaZi5NZDtaajJR9iDl/ncUQj+nfVjRltYq+i2iHz3X4JyJga/mv4FEotuD
	 WiJ4K89Ltj9yWFstJWaqwr2WI3y/yd+8uSejS3h2qVmrWbnzbEBvveT5koVfrk4/AwWV9
	 2sqZaFpqy+vpUtw2v05oxeaoSKU6tDS9QMocnzthYDcM4kvq2BHxJhAPzoW2z+rtnag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9fX3bEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE021606EEBE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9fX3bEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5138C1F008A1;
	Sat,  7 Nov 2026 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046783;
	bh=QpBFjVgElnaHzeHQS+r6f9rKajllvimEeA195p1NErA=;
	h=From:To:Cc:Subject:Date;
	b=R9fX3bEerU8vl75WO7sO8/f2sn/5XpzQj5Kt0AgLstiFZAcUL4Rd9XOsDKQZzSwW5
	 8N8g+IuJvNfzYm1DO2Ig5kd7o0A2lWEVMpFiihvxWz43c4Xfp/LYmA9wlvTaq3fjM1
	 20RDvEg8aXE8pOmwTiKTOyGdb8T5CoizqBCvpcSO9WgYsrk4ae38BYj9UQzTNhBYRx
	 S8TpQgXoaE3ke6rO0eAZ+VG97YbXOEmLGRxMMIVcX09K0F1CubqeSQusBSX2Eqt3Oa
	 FYlOzI1C8scFky9tk7DyTwt27JCKTl+Mq569U0dj1oK9cj5mocHIbXdajeg5LAifsE
	 xYXiEBBYC+5lw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: skip applying scheme if region split for quota fails" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:42 -0500
Message-ID: <20261107051942-failed-6.12-90c2fa6adfed@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 90c2fa6adfed7abe0935506a43cdff3a05c1fff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051942-failed-6.12-90c2fa6adfed@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 90c2fa6adfed7abe0935506a43cdff3a05c1fff0 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 06:18:42 -0700
Subject: [PATCH] mm/damon/core: skip applying scheme if region split for quota
 fails

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

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 5.16.x
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d63d4c6fd3ffd..53952d16ebd88 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2607,7 +2607,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
-- 
2.53.0




