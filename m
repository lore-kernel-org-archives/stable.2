Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF8548577;
	Tue, 29 Sep 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703909; cv=none; b=jhS7aZ2XMUdl97TUe9+jqPiUfjU9CaLYW+1KI7yePntwocp6XUk/OweCWjS//GBOyZXwBu3s3d4Hu2i+Pw7yedSKTVo229Umm3YBeIN6nc8i0oRTi0I19yQ6RBvhVIQXpw8Zv5J5YQV6XeoZbTnXopYPhBZspzy5nReU4Rc/wmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703909; c=relaxed/simple;
	bh=DoySbtQ1ED7skReaEfBV+YI+kXtuxgNgjTvPaxT0bAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCuYJIyh1q5wfz+6hPpvlSc218EjXuJtGB9nHfpRqtGpLHdPCqflhYBKcMBQzr3pwAhowCFqMmMqRsF7tRaEw45lK0f5T//G2pwYKkynuj27Th/N9G6xxRcXKxp0qSyAB3uE5TOpVp/cAJYZPrGpwXm2nvJMsEBq0hbN05MyWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qscv5bkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qscv5bkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760CF1F000FF;
	Tue, 29 Sep 2026 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703907;
	bh=6Zxy3fbIljcqjt4qcr6yZa6Q26fBVTfs6feBpnOszkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qscv5bkU9jmIopXNr4TOWwD9yJl8pVhQRnG/GYttTH0UErLCEQDZfh7yvjAbeOTwy
	 K3lCvvByhZMml1l6AUu1A4EI+J+m9/AmCe9kjQKy3tuqNKWDBtEhlrpesoQvSAqZjY
	 UTdNO3H9hM3lWD6DxNWtxJIFsD+LJOGOWn8KT4C3Z0RNBEn+H1T2f8dCQZZJFCXDl1
	 4NBqin+c56A1BffzuRoOxbmreM7kkKtSZXY7F9eameB/y9Mrj0qZtB1uPZHkNUoDL8
	 amgTEtCFAfgKyFMywCMEj8Bfrx4+Dt8n2a3C68yHX1iAhkJb3UF6vFyLdYB2gdXDHz
	 OfXOdWOhg2WZA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y 2/2] mm/damon/core: fix unconditionally skip last region
Date: Tue, 29 Sep 2026 10:44:56 -0700
Message-ID: <20260929174456.9251-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929174456.9251-1-sj@kernel.org>
References: <20260929174456.9251-1-sj@kernel.org>
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
 mm/damon/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index facb1fa1f695f..5bb69a4d2ffdf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1746,37 +1746,41 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
 					r->ar.start, min_sz_region);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_sz_region)
-					return true;
+				if (damon_sz_region(r) <= min_sz_region) {
+					skip = true;
+					goto out;
+				}
 				sz_to_skip = min_sz_region;
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

