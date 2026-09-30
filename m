Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB527727
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726642; cv=none; b=iy4LIlR2wGTnJcb2wgVggtgI0ZhdlPr2AgboszRb25MrkaM0ElDcEjsi8YI1X36Y8DAM24qFGilljVH8JV/lTLZUir9YyYlIUcViOS5YHA4gRI4jpVc77X7LXfuTLNQFC+2WM39mXjo3WfSBDaJs6Lf80/eMHXg9E7WLg4nsKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726642; c=relaxed/simple;
	bh=zfliBmflzjlBVFTUGNUobF3XhlPJNBsLevKNQETobhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6fPlr81js7ugRzN+Nm5ijomGeKYobMSvdMgLYhPXlcyuDeAFCG165cCS0Tg8pj6cMbB4xRP6iS2IjtBz8av9nl1YnQQn907UpjWpjaMFmRFpAdIZQy65VpIWHf/lCbRLvRvz0xJufXVf4a4WbWgXQI/9HLwhokXWPuHtZyVwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Srl/AvmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Srl/AvmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23E31F00893;
	Wed, 30 Sep 2026 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726641;
	bh=5zs6hq5GzB+6HX0HaqupieJ2fJ2aPf8oPs2h+hygmyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Srl/AvmCOIbF/sWRwYk+YcFk63s1BlUHNTLZReFvkMMqerHhop7vRhrymMmbrCL+M
	 LsLcp7SG7SkQqGBdG+Wpoi86fF7iNFpphQAHuMWoTHSfpyVGfJoMZWKmZwKCKNgam3
	 my0QZ+3cgCb+5IgxkZDIsDSI98r3DDJEEc0wsfVmP16zrpZacj98MDglF9w76Q4sdZ
	 SuCU3BR6oTr7fwYlsAcov2lkHRrsbW9oAxg8m8m5ZqSbIoklqxwdd4s1bSaaxo1vP2
	 +vucfK7//LWIEP5hUlPyjTlXVNPB43BXmRA35VppmRmvwAEMW98p+O/Nci4nZlVezV
	 WarylIJ5sJxfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] mm/damon/core: fix unconditionally skip last region
Date: Tue, 29 Sep 2026 20:03:54 -0400
Message-ID: <20260930000354.2861391-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000354.2861391-1-sashal@kernel.org>
References: <2026092947-shush-encode-1e48@gregkh>
 <20260930000354.2861391-1-sashal@kernel.org>
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
index 3920ce7d07925..38d3dc0d84735 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1748,36 +1748,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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

