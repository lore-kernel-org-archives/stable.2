Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D0242D72;
	Sat,  1 Aug 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605765; cv=none; b=kAYmSIUVm2b9L/nBlEAIgFjfSm++NbVENfKUmCvt5k/TxrN2QILJLtjJlh15VzzpAjF204Czu+wmTt164VT/e8NqQCqtjXFKd8yTZ3lqQ/ghBZf/T6NBv1d5uiwJhH48fK25ATuXse8yPhTh1pr3sBAAD6jxfl+hLXEmPfN+NfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605765; c=relaxed/simple;
	bh=c8YnLYM9gCkCamNMX4Ifu9ihjCO2crXUFIBol3Mz1aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngI7vgUpFj7hT5ou1y5H94/C5GKextklz/TzufsUdTJUZfM+rxGBo5n+TVkZpBKN5xmp8IguRuztEMdiYK//aKdyXjYS1tO9eFkUZI97rISCs26gr4Es1gSfgTjFvKK9BoJrmXaVoPo4PmJY1ynFfKkKM1kplz44qD1o23jKafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqZJuyL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqZJuyL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D21F00ACA;
	Sat,  1 Aug 2026 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605764;
	bh=ccJR9KUzvn7k6BzhoDEjN3sQrL1C2MxY/yOiNOzvC90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqZJuyL+6d1IhKbNi3w6gCesrHj9Klcy91QoQIT3Yfypuou1ns/P3r9cPTwoBnKIV
	 UUBjUbqYoAyh2tbixCqhvMuXxpChVokzSU1CCrquXVF3A4jx5FYg6eN9e4cXC3Vry9
	 qahhEhLizN95D1WMm9bve9Lt4DCQFkCKjdjzI4uJJoR6lHTrXiHAT/Px6f6pUGUcso
	 7Wg9gv4kXybbp3KEgKqkIBcCzvCiCeD4WocPdrWGwWrjPhapXPzQcEEwrzoqKIXcKr
	 YIsG53J1BNDLdEBw3Nqekbid0SncAlf0EQmhHeMmdz0dFM8QgahAYOkCKbxIb7r3uX
	 AQd5+b4cgEABw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  1 Aug 2026 10:35:44 -0700
Message-ID: <20260801173554.94710-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801173554.94710-1-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_apply_scheme() splits a region and apply the action to the
subregion if it is needed for not violating the quota.  The split
operation (damon_split_region_at()) could fail for allocation failure.
In the case, the quota could be violated.  From the user's perspective,
DAMOS becomes more aggressive than expected under the extreme situation.
Handle the failure.

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set
min_nr_regions to set the maximum size of each region.  If it is
reasonably set, the transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a16560..e2900d0c984c9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2613,7 +2613,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
-- 
2.47.3
