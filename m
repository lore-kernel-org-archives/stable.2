Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9A30DD1B;
	Wed, 30 Sep 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760518; cv=none; b=h2AOP2KTqU01I32edSTw01NazVe5GluviARDj4seiOXkizvyBOir/SjZdM9wI1uKvy2xXyrH8aul4i51VX7y9ZPrdKhwxOr3OZgo98tc3L1sDHyjGb7vf85dCp93pD61/hD0OUyaXOP5r1veHEeSgzMM+ojVriGIg/3HiecuL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760518; c=relaxed/simple;
	bh=Xh9sEhecDpEPVFZGkk2gnqMsRkUSyI8LZGhckc58uIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsN9TG6aiCgmrgiq40bx3Oq8gTc0+73qjcKNLtKh4+3qaoS+wylr58yKB5+YxRvJy0PnHTdr/2Xl7v52HyEqqxNHLAV4M1p8TKR4DeCvHvhCu0H5QKFZLJifG8YIyPiQkDWZTs9fjT+6suuXW4+N0WwOLtlZYLkWwz/e9SXcHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqsc8pRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqsc8pRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883221F000FF;
	Wed, 30 Sep 2026 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760516;
	bh=z3aHHfyyrs0l8iPbF3zXb6TAyOINt0wayQCovhUONWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sqsc8pRz+PJaFXnydT83DD1btS1vLMfBvBrfTKZIf5XAP2rbwBSv1Zs8wtEoH2egU
	 E0GYb0LjkD3wggxA4GX9+/pEvOYYyWCjZI2rOB5MQRjeSbhBvFbokTYP09Ylb2Snl7
	 OfEiAIlaJ0jVuJmPEORYd2x1WVddOJjZ/AGEJRRSJBrntbuDPmreP8V1zNgmCL9h1D
	 XS2g9KqmDninr1CsXi+qHUMF4mkikL7DF/fIifj/tzemoiiLr5tRYs8rvYaj4lb6ym
	 ANiM9BHylcIvJxasMbmOgrQAMEwnEZDtEYaeKm65Xhss4jlRlSpGhUUrpSE2gD/dPn
	 Vf5RQLJtiNBgA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 02:28:29 -0700
Message-ID: <20260930092829.45885-1-sj@kernel.org>
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
 mm/damon/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32737cc5f877b..802005d9186e8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1322,19 +1322,17 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
@@ -1348,11 +1346,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
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

