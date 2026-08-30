Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33B1514F8
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071518; cv=none; b=N7Hw3QZg1y1Uw4la6k7+Q/kor0GIwCG+A7no1BqpVFhlx8mLK4gQKBuDPz4aG39R02H6t9lfeazEKdO6PaeLJ6PX5ByahGHDululVtSdgx5afLGa4R0VaTroNxevX+HoJfhWp9GT9DJ6OH/g4lKj0RSyyfHCcKvyWlt/85XLk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071518; c=relaxed/simple;
	bh=cjGZh6aJzF6tvnNxut3Za7JYORBuyxbP4UJEMgWdxxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj047M3Mo6dVhR3NurgJmWyVUPooFl7Oh3KY6kCIe5Gm8eGoRBkTVy6xDKQTiweZajykXGOyExfgv4C5VroBoAiQnXkRZoGM/ne0cM2wrZ5Fol+LJ1TIXNNgR9PoQhPOMT8kjZh0MTnS6HyQ3oKnkK66r2Qz54dVT0yAukj6OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od5rlwcp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od5rlwcp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2726646a12.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071516; x=1788676316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjCEjlQx+exRVLDUDevoSIURgdv5YYALfDraYMLva0o=;
        b=od5rlwcptFPEN5pd5uSBVUcpYddK3IYfgcdkqMMGwbIumfj6U57F43U3cToR2+RyKy
         KmQBgQVRSXiS7ySop8kGI2SchIzUYkoF77YJ05hVSEKdg5W5d/wMb5RyXhJHV7EhHAYw
         ldnGDXPRJTJVq7rq3aWpGL4PzdowyjMPIZi0cEDYffcc7v8C5f2SOvfiWyV29CRe6SnY
         TdgJKCA8JkNenMI9AaBLxuqdbAr0irdJLdBX+hQCv61YjLKMYo6D62BJaVP99uT1CfPC
         B0uQ1hOTGL5tfCSx1F4QnNlHAeYDirUgCZj59UYcluKYG84RJFhOlJ6ckbmIlVsjtT17
         qiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071516; x=1788676316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjCEjlQx+exRVLDUDevoSIURgdv5YYALfDraYMLva0o=;
        b=Nn+gQK88q1yYtUR4AErUJ5PzbnKl+4W8dJ2U8pSzC6y2MIf2+MVgdBQzLEgT1x0mVv
         XaZN8lHvQej/cBQwQgU199X1umcz7J3y8WvhvHfr3zJa/DN6ayzuhWclkgO+X+h41j6R
         VtMLk/ukys47tO8XxulcfrzzkJnzwk2T8/w37YcUMUvmAU1de541wn9tCjLbr4xiPH1j
         TJiVBEcjS4ZMfaRV8+hQ+E14xJqpXtC21OZrOv5V5odqB1v/g1gaK8cBupf073cZr4Ao
         3cBC6L9dt0Imlj8vrfj/AtSMmRbteSII2bhGHV9SXNh1X/OYtiMrR0lbZxw7ItRywU89
         sZBw==
X-Forwarded-Encrypted: i=1; AKwUvBygA32oVcQ0Qa6zJEpUr/KsEbYZOqWKfwW2lTmdOzHsK064h67L/dMXiI7q+tSe5r6S++fXa40=@vger.kernel.org
X-Gm-Message-State: AFuF++nv4Vg4GsEdhSHLRWntXLB4Lvuxd7ylK1lYjLcAIJBDduuTLSjK
	hmbuvJKliM6+J3HdW18n1AGGx+TFzVlLEIjsS02nJ9DVagVmUgSAjdgS
X-Gm-Gg: AYBFou1+EVitqIAl7/TXmYjLEhsqcdToYic53nCNSgTeT08n92IhOgHRietLdDeHo9M
	6wTbuJDYTQDDTfpiG8HZ5f8C++BmBLJVZzIjZ9/hAISRhRIRMNKqnKktyLji2wHeyQhBBERWzEI
	4AretlMFronELc9H7+CtT3GkKgZZ8nLIQ7OEPVz7r0/xFnTnvOMIUwBGu0tmW1GzmpEPrVHWKWD
	SDJnzZ3H8Kv5eNaEvktfP5SeGtKcvfHo1IRtNTcWlqP5ahMCRWs62tZQNwHPYI4oFz8YKUP+21/
	v33tFN/GwKI4P+zVp58Pt/rHMMwwa9PuhUh69XecEswhUrgXQPasQHXlRqVIFp1rPxfPAOUhGHy
	0O3hq6IDEDHia0IsuOBXFvdsaUBBHFmEAVdiPvd2eadDMbsm7UKgaJbg+GYyogzTll34HH6/2cV
	uJ7+oBozrz5DwSWTJtuBCscRCTt6A64ZjPRQeHPuSlZ8p+gSnhaGgXvCVVdT1kBnS691RJwTGy+
	tGHgOLoZUjV6pHd
X-Received: by 2002:a17:90b:55cc:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-398da65a974mr587978a91.8.1788071516309;
        Sat, 29 Aug 2026 23:31:56 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm10079411a91.9.2026.08.29.23.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 23:31:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 14:31:50 +0800
Message-ID: <20260830063159.6347-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can
be skipped even when it has not been processed.

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

However, it is important to note that this is a very minor issue.  This
is because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except
the last region were skipped by damos_skip_charged_region().

Fix this by only resets the charge_{target,addr}_from when last region
is reached, only skips when it applied or cannot split.

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # v5.16.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v1:
- Simplify example in commit message.
- Add clarification regarding the severity of the bug to avoid causing
  users unnecessary afraid.
- Modify the patch code, each time the last region is reached, only
  charge_{target,addr}_from is reset, but the return value depends on
  the situation.
- Modify patch's title from 'mm/damon' to 'mm/damon/core', since it only
  changes core.c.
- v1: https://lore.kernel.org/damon/20260828084737.290024-1-aethernet65535@gmail.com

Changes from RFC v1:
- Minimal fix, only fixes the issue where the last-region is skipped.
- Add an example to the commit message to demonstrate that this error
  occurs very rarely.
- RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com

---
 mm/damon/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..fb76b530bbc6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
2.55.0

