Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F73CC337
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766851; cv=none; b=Gvd2qh6oQRlmVAmHh1oDfiKdKopuUjK6cr5FXZ7ICI7QIdcfPYyyof96Y8F3/jnQcWFcB9NDSfzzfDYOQF/3s0t6VePQXkk9g6VxmFIyXTzvtY83vZrQp7e4eqp+0vPRzf/XDcY4GpD6csjHm3ddmpt/FurjD0htF+imuUGRPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766851; c=relaxed/simple;
	bh=zKLxCBxbPeAr9G+yQMNP0X8t7WLdiqZF/zLZCKui+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz4MGNCjkoQnvEgFG3TdkkB6Jvw5KR4AKoLbCP6VQiCChlO4JdTWTNwMMLa93B/ObAT8X99isEwXJot3LlRGITb69+Ew7ZqDaO+sLwkOs/DcwScyXZg9rB9lCenmwNJvaOae8WjVIqWsWx0qVYQha/bjtghGBcn+eZvFzzuJHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYnzTp1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYnzTp1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828E31F000FF;
	Wed, 30 Sep 2026 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766850;
	bh=OsGIIGPbBG34jzKvJlH249DksOSVAe+eR7ZnJ69SdKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYnzTp1OkqmFNwMy/av5lEk28o6XU6EtiVV6CwyKZwaa0FKaTrx8/z5KlsQmL5v+I
	 AP7qHV6ox2MrusfGqOsgUYPqNF4grSHBc6nJJdNE0tdPXXnQQxV6h5J/HdCkg8cKNj
	 TkVXD4gG5+yIBWf8N3QrX+Lc5RZuDoxjjKFvMv/clkfiLl90hF6bf96kiFS6KmAalV
	 x0nC7nilwnzjMFkWkIAt8t2YZesp7YWwxaQvgZFMNbgbP8lpgRrxqNQ/1Utfv6jHcW
	 Kdof50nPCHRTMdCGzWCZlazj91cSuDflk/FocNMGH5VFHLru7JdUDT/ST+q9FAiT3x
	 Rkr7mbIXbVq5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 07:14:06 -0400
Message-ID: <20260930111406.1206660-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111406.1206660-1-sashal@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20260930111406.1206660-1-sashal@kernel.org>
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
index d2ebfb6e34e3d..82d806d0e2124 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -886,36 +886,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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

