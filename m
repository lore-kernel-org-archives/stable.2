Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464F38E8AB;
	Sat, 18 Jul 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784392641; cv=none; b=Q9nXuapmMheEP8foXIl7qJ5GMSK9GZXcI0JMJecStl7jLq6usceCjfqPtfw3CBqotXzbnj+fNA84t+6NhzsbttC6JRFLZ9WU4zKYG7bh/HnHPGUq7pwFR/l137ho5l9zTj+zPtm6ygFBa/QUQ6yY9Vfpe4r9DEzHkeo2gsLsCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784392641; c=relaxed/simple;
	bh=C9MknaTLLis5/Ia5RzK6jYZXDY2dtsTuUByDAaNu3EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F02mLjgdO7yETcg3jX21cw//4f/UVuR82AfdZZoFT/Nm45ZkSdYU+pXPWDSK0vhbgTfu7XSa1Ww8GwjOjOjvb4lMxm26iTbxuWl6wFLlepin9mL+Y2au6VuHRU1giBvrB9lAAtJnWiWSrWuU0FJ8jfUKo9+kt/L7ljjAI65miZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otAS01m9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otAS01m9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3EC1F000E9;
	Sat, 18 Jul 2026 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784392638;
	bh=/NLv8lWlFLX8POfC/o9e/GmzCTrY3L3nsFmzwSxFA30=;
	h=From:To:Cc:Subject:Date;
	b=otAS01m9vVCzKAR6avi1M0LBz981e1I6CmxlFLclXf4D4yubOkFbJx2uk+H41ThxG
	 ixiDFjMqhCKY3hNGMsOapGPFQqJzotsJEZzwCXR17J7HAFdTqdpySxmapZZBpnKfH5
	 r8KtGH1fW/aN1rTzfH1JpNUXaIpoyGskUVABSvS6owPGRFyX1y3427OXninuv413nv
	 +8xpHGOiPP7ZIpHthx4Zys9A9MQewzdPs05kCa7gE7hwYV8n1pf0DShO3fz45+3pxQ
	 8NvX0rDZh7Z7Fx3qHlsp7kl2wn7LiOIZAY9vzQOoPeLFZBg3y4Ltl0qglXhezDrpLN
	 ZozlD+WMIwUIA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Sat, 18 Jul 2026 09:37:06 -0700
Message-ID: <20260718163708.84113-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_apply_min_nr_regions() repeatedly split each region until its size
becomes small enough to meet the user-defined low limit of the number of
regions.  The loop assumes the split operation (damon_split_region_at())
will always succeed and create the new region.  But the operation could
silently fail for memory allocation failures, for example.  If such
failure happens and the region was the last region, the linked
list-based next region fetching returns invalid pointer.  As a result,
invalid memory dereference and corruption could happen.  Fix by breaking
the loop in the corner case.

The allocation failure is unlikely since it is arguably too small to
fail.  But, it could still theoretically happen, and the consequence is
very bad.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org

Fixes: b1029f29eb1d ("mm/damon/core: split regions for min_nr_regions")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260718004301.88883-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.

 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 20d267c615faf..3d829e0ad63b5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1913,6 +1913,9 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
 				damon_split_region_at(t, r, max_region_sz);
+				/* split might failed */
+				if (r == damon_last_region(t))
+					break;
 				r = damon_next_region(r);
 			}
 		}

base-commit: 5817557f6220462f0ca298b73e4b3f4bb91ccd1f
-- 
2.47.3
