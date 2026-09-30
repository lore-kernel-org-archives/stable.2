Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23893BFAD0;
	Wed, 30 Sep 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763539; cv=none; b=Q0A03X1lVdCbhG5/YvUk/JDm3UVK0eIFIXXnWZ5xKmhzoE4rFgKJQqyZEgroVlSIVef8hbqQnYtL8fPcXdIz+zqw01njok5Hrp/u54ilX7dEcYXMOiGcOWrsZ5sMtz7M93X+qExCX7L7X9IkmhiniS/BU8RdirfsvngbmGuCPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763539; c=relaxed/simple;
	bh=tj0g8fJaYKaUE2oxkXi40N5hVCetqNIfKT/mFUeLA+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw/BWMj2EEYg9ToleMc0cCC08X1sc4KRYiISvNLuSo23xXBWXD8TNOeWczwhurNKkFmbNLZ0teebwryI9PCAqyH+cEQai4QicHyoJ6mKEtfPeveuPEgX93esdIGa3LAjt2Dzl+zBhyxz+BKjhbsqZ/AsYOZ4ia8bb+/wlrhg4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj6J0N0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj6J0N0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6E91F000FF;
	Wed, 30 Sep 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763537;
	bh=aIdp5NFz5jYFmYd/Zp5vP5FJaAUez+gZx8uHmrXspSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fj6J0N0wnpX5kI/d7oGj7n8D4HXPboWV2ajKtDICn3tbvOuJKUKauKGOVgsR44nvx
	 0v74ZsgR0HFXOVOgt9M6nZrUcxtQimZ8/T1t2BFzutkPi0JSCWPK3JmkR2JhHBqODi
	 pJpPZqVQ7uV9ncsf4FBduYSqU8G50Gs9hmY+YEjDr4B/KJse8+SchvTOB4CWzG8k/1
	 hE04yCnYckI2O0DcpvZioyoWCUgtXvrR0hKB8CBJMjvO9zoXHGlso/3f3DJNdvuyTz
	 s9ihz08ILHdHOswB5tk68CZYT6TCTG0V1aNZLRpzSkz7P9j+PaBC91Qv/NjTdcAlMc
	 qQfvxyY+lVlnQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y v2] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:18:52 -0700
Message-ID: <20260930101853.58786-1-sj@kernel.org>
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
Changes from v1
- v1: https://lore.kernel.org/20260930093707.48739-1-sj@kernel.org
- Add missed damon_sz_region(r) <= min_region_sz case change.

 mm/damon/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0713fda22682c..c31683c12dd48 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,37 +883,41 @@ static bool damos_skip_charged_region(struct damon_target *t,
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

