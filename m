Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814962DEA6B;
	Fri,  9 Oct 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557304; cv=none; b=AiOI/puXyHWsTpewuWa1XgU1epoatNxw3k+xQcyjxYe1DRz0VGEzphyhfE+Iyl1Ff++E0ipcWsnCBoJ4p3NJqDtgTx+fpR6XFshJ5JtsYQh273gLe72+J1fRmUnpZFdNjjquU3WuYPYIHjWWYzr1NzzYVw2cs/J0VaZLiY08PPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557304; c=relaxed/simple;
	bh=2uAx7LTaA7OCPN+u8CwE9eb5yLoL9fHv7LaiKUHovok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzy0ixUoSIDFTexnhVqulI38OCJLFIvwlMQ2ou/EZUwUfJcz/Pyd/x/G1S2cG7u78QzxVk4dpKX0zpeh8VGTfD+6DRXclp8wVuXVQCJQBxramdINVKHuEw1TmoxupIXSqH4vOyAlC3pyraLSSC6bxraMRgxVwFLXxwIR4dL4BG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn1rHP2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn1rHP2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD491F000FF;
	Fri,  9 Oct 2026 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557303;
	bh=CVT5PRt0dTyvufkIKuOFIFmWNz6TXrIoc0o4HWEvw1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rn1rHP2sVSpjnbWJyVJgbZwvIkeCiUd8N/aLuOx4+dE/LXBPqQSAtQkESYPsXQv+J
	 4s3DJizeXDpaRBgeGVhfrLqtMeXgrMl475JIRKwVUeT3jvW47BdcbBUJD6kR4MqjT4
	 OlST/Y1LmAcFbNlZchUu1rWxl4E9dLFGSbwlTTAegv/hS7/+nidFxKwDx5DeP0uNbC
	 lXzl/nC8MgRND6P2jbWOuP8J5rsgRmkKhSKqEtxaPE99U9YKZiyQk4AmjkmgI9ivmb
	 prQ69HbD6OsQot1v0OXuSWeALIHSy7IqE9hKRTMcLqBGCRp+A/mJrZzp17m23AtAJR
	 qrbGrlMeSaKeQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y v2 2/2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  9 Oct 2026 07:48:08 -0700
Message-ID: <20261009144808.18317-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009144808.18317-1-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261009144808.18317-1-sj@kernel.org>
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
 mm/damon/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c65d2cbeea6b..f2f6f125c09b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -756,6 +756,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		unsigned long sz = damon_sz_region(r);
 		struct timespec64 begin, end;
 		unsigned long sz_applied = 0;
+		bool skip = false;
 
 		if (!s->wmarks.activated)
 			continue;
@@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->charge_target_from) {
 			if (t != quota->charge_target_from)
 				continue;
-			if (r == damon_last_region(t)) {
-				quota->charge_target_from = NULL;
-				quota->charge_addr_from = 0;
-				continue;
-			}
 			if (quota->charge_addr_from &&
-					r->ar.end <= quota->charge_addr_from)
-				continue;
+					r->ar.end <= quota->charge_addr_from) {
+				skip = true;
+				goto clean_charge_from_skip;
+			}
 
 			if (quota->charge_addr_from && r->ar.start <
 					quota->charge_addr_from) {
@@ -783,17 +781,25 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						r->ar.start, DAMON_MIN_REGION);
 				if (!sz) {
 					if (damon_sz_region(r) <=
-					    DAMON_MIN_REGION)
-						continue;
+					    DAMON_MIN_REGION) {
+						skip = true;
+						goto clean_charge_from_skip;
+					}
 					sz = DAMON_MIN_REGION;
 				}
 				damon_split_region_at(t, r, sz);
 				r = damon_next_region(r);
 				sz = damon_sz_region(r);
+				skip = false;
 			}
+		}
+clean_charge_from_skip:
+		if (r == damon_last_region(t)) {
 			quota->charge_target_from = NULL;
 			quota->charge_addr_from = 0;
 		}
+		if (skip)
+			continue;
 
 		if (!damos_valid_target(c, t, r, s))
 			continue;
-- 
2.47.3
