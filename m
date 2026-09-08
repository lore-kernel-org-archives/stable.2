Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45253ECF7;
	Tue,  8 Sep 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875691; cv=none; b=m7BJUx6gtzdHdvuHDeWxrM4F8y2Z1KbS1hLrRy8dR3g1OP/opYEIFfJgKc034oxd6eruGGUXT/ptAA2zd2vg9+6xNWJ44GfHu/xhnfz8Zgk9GVkmUa/UO6U9PKnkVYU9fZ/I/ls+AHGiPgJKl+Z8kw5uNOGal2A5mzdAGbrMO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875691; c=relaxed/simple;
	bh=kPuATQTBg5dz0jp0UuEJw2h9NO6hSRbPbNnNgA8vCus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PM2IqDmRFYMsmsW40aLK+6eVVEItMHYsNOSlmfPJjvaZ3xiscNfFPuhRl++n96edfTGfAU3hA/XyhZlZadUueM5qz7aTj29h7yp8vQl97NB2VaF6Kn14Mx2b7gPjrLftIuZBJYb7CPqDF6zQO/EmKF5RBEZ7k3ovSID+89W7uxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z86lqUUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z86lqUUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39851F00A3A;
	Tue,  8 Sep 2026 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875679;
	bh=CgoRG7kKCzhkx46Y0+lhAJX5PsX1/GyoeuyPyR0dxwo=;
	h=From:To:Cc:Subject:Date;
	b=Z86lqUUMYk7rbhqAZ9Zo3V48PT6WAZS89KSYGDOwN27qGsZ1M+LhuJrs9Zpu5DvFd
	 GW1l/FqbXXw5u2E/TYJMNHJ2R1J0BXwYfuZCUm+He6fr5EH9REzvqiHVCVx3tQDydS
	 BOak43kkjbizFAtOn1wR8hUkT+/1iN3EmeuXbLHxy/9b717qQ/I39p8r8j6bfiYJbh
	 SzLlXRZb+/928FB050/Wnt8jgzSbYXDhTC6Dmvmv9eSdGDBBNtX84BvMFfaOfA8eoa
	 nwAyYF7+WvVC4q4FiKMSSMQPWJBFprVg5hc6+Gs3PeKTUwipvEg/QsUJ8aLz9kzDDz
	 4+3PLFLuk9Dow==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4] mm/damon/core: allow esz to be set to zero
Date: Tue,  8 Sep 2026 06:54:11 -0700
Message-ID: <20260908135413.97570-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz
becomes zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has
already been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v3:
- v3: https://lore.kernel.org/20260905124706.3398-1-aethernet65535@gmail.com
- Collect R-b: from SJ.
Changes from v2:
- v2: https://lore.kernel.org/damon/20260902082050.19566-1-aethernet65535@gmail.com                      - Changed implementation, more general implementation provided by SJ. [1]
[1] https://lore.kernel.org/damon/20260902150301.88535-1-sj@kernel.org

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105951.106246-1-aethernet65535@gmail.com
- Changed implementation.  The initial solution skipped the
  min_region_sz clamping when esz was already zero.  However, this would
  revert the fix from commit 8bbde987c2b8 and cause a regression.  This
  revision fixes the issue by adding a specific check for a zero esz_bp.
- Changed patch title, original title: fix quota could not be set to
  zero

 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e6cd405161d4..06cf2ab7e97d7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3242,6 +3242,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -3262,8 +3263,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)

base-commit: 6f8c7324e336e626bd993bc36f177dcf493a871f
-- 
2.47.3
