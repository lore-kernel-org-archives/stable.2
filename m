Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA83F8ECC;
	Wed, 30 Sep 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763305; cv=none; b=tUPoP5nisdJuJYU3HtG0bk+z5rgixhhGdIpVrMtpAoqsSZ+O+9ZNQ92CvLRqDXOm1wlY3xXeBg6sELBIjnpWgPys8MuT9xMhm064H7+ZiM/av1lK4OZfpl3wsky/nNPFzQkETal6Roq9nmYpMJDnoQovPmNSyZQq0MJFwB205qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763305; c=relaxed/simple;
	bh=54Ipld09kO1PDJ/KNnkR/JdBcYQe+xP3ce5MeATcFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbVlyHb5cmJOxQ1Z+tdNHDr5ISjuYJfJGpdIH723q14ohleNdOV15gMhku6C9qYUcCqEQMCRpN7et3LHIM1BNoij+BF5xeiFbeXUlN/l5azyzfEgymvrpKcTV6uTy7YwWqHoko9/PLmwVXh0gHh406cWJ7uPN4n39dWlLurVO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOuYfvbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOuYfvbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AC81F00893;
	Wed, 30 Sep 2026 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763303;
	bh=NtupvILsbBdrVRwH08Wy0zosMmo163lp4SWgQYvg3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOuYfvbihP7q1bkBsrCG02IGNPzue0PBHqEYCA6QDfb33n6tRuPHlfhqgBOBfxftH
	 vWH3VhMhgloU3prfw7HT7YKiQDdimou1xDcag4r08uldAxjXoMFauA7WlJZTnlmHEr
	 qF8FkQLzVvtCD9O3Wc5kbGMfkHvNtAn12jsIB+XneHUskKjkFMzmrqtZXt+qSPHOZ9
	 zAkZvyFf6R/TsWo0d2DFmisl2tDOd+yDEPlkL9TIih5ZXtf6mJ1/0xoPUi89fTm/8q
	 k86kdEuml0bO14CBOHjCSzPXXwrmYZdZr72Y+K87/qMpyXUfSUCo2PgfRjwJl1aSsc
	 yP4/Nq3kMa0CA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y v2] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:14:57 -0700
Message-ID: <20260930101459.56041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092948-agency-overhand-3fd1@gregkh>
References: <2026092948-agency-overhand-3fd1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can be
skipped even when it has not been processed.

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

However, it is important to note that this is a very minor issue.  This is
because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except the
last region were skipped by damos_skip_charged_region().

Fix this by only resetting the charge_{target,addr}_from when last region
is reached, only skipping when it is applied or cannot split.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org> # v5.16.x
(cherry picked from commit b3723b596b548c837a766aae3553c14a7b15af2b)
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260930092829.45885-1-sj@kernel.org
- Add missed change for damon_sz_region(r) <= min_region_sz case.

 mm/damon/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32737cc5f877b..cc7250f0936af 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1322,37 +1322,41 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	struct damon_region *r = *rp;
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
 					r->ar.start, DAMON_MIN_REGION);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
-					return true;
+				if (damon_sz_region(r) <= DAMON_MIN_REGION) {
+					skip = true;
+					goto out;
+				}
 				sz_to_skip = DAMON_MIN_REGION;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
 			*rp = r;
+			skip = false;
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
-- 
2.47.3

