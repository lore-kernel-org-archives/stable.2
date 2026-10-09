Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AA4D1783;
	Fri,  9 Oct 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553809; cv=none; b=e1+hjeSirBdmkynkNRNtEL9tELS6e1q3yKXAsT0anL14UWpIER20fxDn5DZhTLI/EaijMdPpB5AOup37E6kmIuHHFfZsKLmwez2zNaXdzG8Wi+K+tbJbqiGzn9si0CE+yNzQ7LfAaCqrnlpnJVww+bBu7YRXMUA6ZQ5Lq2w/dUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553809; c=relaxed/simple;
	bh=D18RrHPud1qI2Cz1IspOwsOX9/qc/GepackvpuKD5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCQLqcOVB5nau1YANVSs5XJYYWz542wd9F5QtBMAf5PAZzCns5LAcrbZeJ22GCfw4y456v/OBuDciZBVSXAyaI51qD1ZjeRMUbBqAKp2TfUd/boKzCGw0LAUzWmP/l8stw8ECbrygDmCMIhtAMn0FjgJBmqOGYmxrA4gWAHc8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POPZCRVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POPZCRVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4190F1F000FF;
	Fri,  9 Oct 2026 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553806;
	bh=NGYamTbhyF8fPIDsPezdQjUGd6YDkrBY2lo9+2JMLnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POPZCRVTopIVD6QueeAp/dbl/2w0eQjppiua1Xgapd3r3bYqxeOThVbyppGzpk+Ua
	 FdxU9T/jq3b0gprHOqC08n2+VSwbkSBFDcXCv/mm8c9ZF9Zaq1use1gra0+sx/neEK
	 9mZuxnkBuRKpHgwau3IiHViu0chKTSycGzEVW5YYuTfNPfGXSkD5q+YON8/dPfypzD
	 YA7884+MinfTyzde+PG6yLPhO9XUZXFjPbF6uRZiXKo+1j+jGn3CemPeBGvzRjbkJ0
	 Fno1psmye9lcBTBlPAMduLnRV7SnTFfNAT3v7CMc+eWrQEHmxsHMSOZ8B33jWPfSCl
	 7ld4as1g2mg4A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y v3 2/2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  9 Oct 2026 06:49:49 -0700
Message-ID: <20261009134949.11507-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009134949.11507-1-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20261009134949.11507-1-sj@kernel.org>
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
 mm/damon/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c86cac855b9b..c459eae4bbae 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -884,36 +884,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
2.47.3
