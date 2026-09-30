Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC63793A5;
	Wed, 30 Sep 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761047; cv=none; b=KWr7OoTIwBQzabH1vQTKCiVVX05mDQK5yEGf7plZPFjpsw4S3SDtgIDJa77lovjXCxkZxunxNN27ca5PesR564ozeSQ6VL7MyNJuqOCdqq0eHMVBDOsiUX+/8T+N30zOBmoEl+WH0QDYkCY6RaEyX6pTl9yCNWzQTz/a8eBF7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761047; c=relaxed/simple;
	bh=+EkrZEMmFnWOQsnZgC6gn1VpWaNzay67cH2YrkxYNEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJblWA+CxbQlISTl/BKO9vNXGaipMLqf+QNlx65tkJPpzG27jnnBIwJsZ0nipo7tvuZ1QSgjMw4CBfRVhirjBqc9TgCkj9z0wwewxRse5O20OKU9DrJkfe1T2aC3ZNnELr6ZO2XgYCb03Rbpy/v9gMzw0GuRJ5lYNHop2/i9Kx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPijUOYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPijUOYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC7C1F000FF;
	Wed, 30 Sep 2026 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790761045;
	bh=TJhwfM7LT6ym6ruDowV8au+YTRMbhrcGdOAEosWhPaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPijUOYFBY30whKuElizvUvyUjYt+04gtiid8sSvsY6VYVxmYt8e/gXTp6fRfCJcp
	 dLuwLlA6PBNCe2OUTyDisXpCEzgvT9bzfnoAcKT1VFIYHEnoPhA7qtTUtg2bUF004z
	 4c3hr3yfEPump9x1zWbrmuFK4lDqpArWr2vkmyMHsz20AKCsmKKTQ4xng5j3YH+Q/6
	 fgBcDa8/0rrJdEt9qzQRcoTC6yvTinooUOkOL0IbmGLEUkmNp1CLznSyMugcZUccNm
	 ifL94d2gY8NxjjShq627tQlNd2WWH2Ca7AfPGz+B5hRPFEmH+A0JSiD+qj7gaSZje2
	 jKA/QHXUfzNew==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 02:37:07 -0700
Message-ID: <20260930093707.48739-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092948-moonrise-persecute-3597@gregkh>
References: <2026092948-moonrise-persecute-3597@gregkh>
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
index 0713fda22682c..5ede1733369f5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,19 +883,17 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
@@ -909,11 +907,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
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

