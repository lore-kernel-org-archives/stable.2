Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833135328CA;
	Tue,  8 Sep 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875279; cv=none; b=uy36lTl4/RnPB2AdREecwBYiO0QjhiSIS+5eOlaTLMKBT1UiUFIcBSSf6R6P1DG8N2NWNiCoHr3wDCbnKL+fWm8dGUYwkf+MzRcsqjOMc4oqwswYLKSk3T/1hC80MMe3v/CRtgARoFWR0lJHQX2FZ3D8zO0lCdrurUuL6DAJtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875279; c=relaxed/simple;
	bh=zg+ku0v8xf8FI+6NLadCu8VySTs0P3c+ycaKmGYmKyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahqifRxyea9v4i2HFNjhXjQiBmdE0AHBNOVTe/qjumRvT3Kht0zFXogZSjxL1/pROWuWK+lHiW+U7auHY8mejMmd2oMi8siBnAhE9LdJro2jlVaTK1KYcrC+PzkQXAcV2P7O3BfiHErYKDwdNDdNP39kA9vMJYV8FPCRuw4fTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEm1mdvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEm1mdvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C51F00A3A;
	Tue,  8 Sep 2026 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875268;
	bh=A0+1vx5ssYACbosB5yRUtT7K9nBFjhQE+WMx9lniBm8=;
	h=From:To:Cc:Subject:Date;
	b=FEm1mdvUsgl8JbaTjjjXn4ngQWgIsDJ3WlnaMSAqxVKqgSnG7Zq2/bhxpaSfntSxh
	 DXisyx9vnI26ygC2pzU0jYMrWh1Y5CAljaY7Fg7FWr7YUC56AmYoL7AqguQluP/0EH
	 Tz6W2kk2AvP2uxMTz1dbgqsgK98Pvb71PEp3id/q/8ix53CNS+oz3BtzMTKVB3PiTv
	 KXi/ecHyHZKN+aBMxAMTMiqqS6Lg2e0tBhY8Oglm9I10opPeGcQaTCxSe8CQhoCVIB
	 XXu8TiHbpx/4rwgdyf2qhb9iLhYSBSUj5MzRXg28dMljsBkKHCY114h17Qx0YMuDfm
	 ZgetKviUSsrtA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3] mm/damon/core: fix unconditionally skip last region
Date: Tue,  8 Sep 2026 06:47:38 -0700
Message-ID: <20260908134739.96919-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can
be skipped even when it has not been processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 100 bytes per window.
    3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
       addr}_from is saved at (Target, 100).
    4. Window 2: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the charge_{target,addr}_from.

    Result: R2 is permanently skipped even though it has never been
    processed.

However, it is important to note that this is a very minor issue.  This
is because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except
the last region were skipped by damos_skip_charged_region().

Fix this by only resets the charge_{target,addr}_from when last region
is reached, only skips when it applied or cannot split.

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # v5.16.x
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2:
- v2: https://lore.kernel.org/20260830063159.6347-1-aethernet65535@gmail.com
- Collect R-b: from SJ.

Changes from v1:
- Simplify example in commit message.
- Add clarification regarding the severity of the bug to avoid causing
  users unnecessary afraid.
- Modify the patch code, each time the last region is reached, only
  charge_{target,addr}_from is reset, but the return value depends on
  the situation.
- Modify patch's title from 'mm/damon' to 'mm/damon/core', since it only
  changes core.c.
- v1: https://lore.kernel.org/damon/20260828084737.290024-1-aethernet65535@gmail.com

Changes from RFC v1:
- Minimal fix, only fixes the issue where the last-region is skipped.
- Add an example to the commit message to demonstrate that this error
  occurs very rarely.
- RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com

 mm/damon/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a360c41cda89c..7e6cd405161d4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2452,36 +2452,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
+	bool skip = false;
 
 	/* Skip previously charged regions */
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
 			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-			return true;
-		}
 		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
-			return true;
+				r->ar.end <= quota->charge_addr_from) {
+			skip = true;
+			goto out;
+		}
 
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
 					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_region_sz)
-					return true;
+				if (damon_sz_region(r) <= min_region_sz) {
+					skip = true;
+					goto out;
+				}
 				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			return true;
+			skip = true;
 		}
+	}
+out:
+	if (r == damon_last_region(t)) {
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
 	}
-	return false;
+	return skip;
 }
 
 static void damos_update_stat(struct damos *s,

base-commit: ab263dd200a7a9101ce3c1374fd23139f29cdac4
-- 
2.47.3
