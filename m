Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D623E334
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735658; cv=none; b=D/0egSh9tza5kaKO5a2Q0yF/4XR5/5MQMIJOz/Sf8vvA/EyW8mmXrz6PBq/rWCwjIqJARCaQ/eqi88/UWhMROvt2zsVDOYQno6sGL+jgEq6wDDkgq597bIY1fgkHfH7/ZNslKOQ4pGyp4PGMQ2pFB79DmWDfVvyZDfxHFxYYOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735658; c=relaxed/simple;
	bh=3xTrTjeMBVPDnAXbwgdZMsY9C6ChZhrBQeC3UZ5d2C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7jzZvHmYA4t6JDV7e6VZHWH7aFFcOglWKqsY/LmfNeoiAvHEgjq9idPRYUcJ5LRK0XdU51r41TfMR3nkNlwBZ7FfqHtrOKBWjmM+Jv03EP+laXARdhu193zZF5iJukFQM1s294/FxH7Lc09NUifsEsNcc7L7Xcay3OFy8WxL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFl4HFTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFl4HFTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD001F00899;
	Wed, 30 Sep 2026 02:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735644;
	bh=5uc0pW3yq/naLdLk09cygXzXt9AXYUdsgTAkV9FolUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFl4HFTvGz/oUBZp/y9fY7c/9PdHRngFhtSw4M/aD09Oj7Rggdw+hEB50X5rUwvdI
	 rqhP2nS6wEiuS1+xELrWxD6Pt8inmr7J4WLrmMAyK8Y4PyPQisKYu8HCJqAwa0QLOt
	 4D3xPHjb6CcN8ExOhPpVncO4crKVQmXONrpJPhVVSWYNcbKThR2g+vF641skoXjAB6
	 GViEFb9SLRHU2MwaQ+qZp4I1Gkjie7MKNZfOu+1AkggkmPc/ijPX69Q8HZkG01FZJW
	 H5TzSOHRTp/oI/kcispuMsjqM2tlCxef09iIgzu4uMadFjjasFlr2EPLqFftAiBVKb
	 H7MI/ASdXAjEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mm/damon/core: fix unconditionally skip last region
Date: Tue, 29 Sep 2026 22:34:01 -0400
Message-ID: <20260930023401.3420697-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023401.3420697-1-sashal@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20260930023401.3420697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

[ Upstream commit b3723b596b548c837a766aae3553c14a7b15af2b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53d479da2007e..2a24e817e5360 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1325,36 +1325,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
-- 
2.53.0

