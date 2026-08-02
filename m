Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA293242BA;
	Sun,  2 Aug 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696881; cv=none; b=aEJ1WOgI9Li/H+uHbqUHEdvAdyjwVFXWRcVETDlETK0Uh1nMdkkPg8U331tREH2/zvbduZNv4XAdyLgsp9G+t3fP2U7TQxpclerxlhOjNK/rL9I1GtTlR7uaVypRqplnMnkpQNuTG8yErGxZSRMU/xvF/YXfiZ3Qf0veIV4Fslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696881; c=relaxed/simple;
	bh=SLHaCN6oJ5b09JUDm/ZSjN2yWNvqHhSuGLffrFq5yZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqIyqACEwqrtOb8MpKF8RhnFJwfDmoGXifZzoiGekkg+xdaNvhfu44kplOfNzZZSI5e1lNVCpK2J4GbkUkhI6SKG3X5yrLNmBOxe/T02HomgWIwyet4zCkD7tVnLy8Bf/atffIttznRStp3RKtK5Ze5O2seAnpe+kTD8OIEZG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTae5JiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTae5JiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8FA1F00A3E;
	Sun,  2 Aug 2026 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696880;
	bh=KZNY1MD6P0OCjtAb6cuHefbevIrlOVJqJGEJAaJiWKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTae5JiFy4IZpvv98o7309NigTJWUP3B1irg7TQpYpWaa231tj7JUYYeSSw9q+ny8
	 GeI6Rbk2q0AoNG0KZwsjC+lcLnAY06RZTrIWwhsz2O6rne4i38shQxPuUSs6HTwAuB
	 c8/Bg99D3iClUIceuOzkzP8kZvRxlx0cu+b2fggviRXp+fx1jYW6JwzVjM75mkaXvZ
	 ePjNoZJo+gY77RmBLBbAdqIzvrXwKaAbxuKsFl0kCR8cD3vEkcN5Qxe3cFaFVRDUQN
	 jWpHQp2d6qv9pHdVB9qNJ6KzXB4pYza2Ms0G+D97LkYLda89P1glVzujA5nDgrtkI4
	 7fS766uf+sLyg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx has not started
Date: Sun,  2 Aug 2026 11:54:28 -0700
Message-ID: <20260802185430.9940-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802185430.9940-1-sj@kernel.org>
References: <20260802185430.9940-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT calls damon_call() for commit_inputs parameter user input
if the DAMON context is initialized.  The context could be initialized,
but not yet successfully started.  In the case, damon_call() could
indefinitely hang.  Read the comment on damon_call() for more detail.
Fix the problem by memorizing if the DAMON context has ever successfully
started, and skip damon_call() if it has not.

This issue can easily be reproduced by writing Y to the commit_inputs
parameter file on a system that DAMON_LRU_SORT has not turned on before.

Fixes: de3c60e1c831 ("mm/damon: add synchronous commit for commit_inputs")
Cc: <stable@vger.kernel.org> # 7.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3920d5042f109..bd847829a9907 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -346,6 +346,8 @@ static int damon_lru_sort_commit_inputs_fn(void *arg)
 	return damon_lru_sort_apply_parameters();
 }
 
+static bool damon_lru_sort_damon_has_started;
+
 static int damon_lru_sort_commit_inputs_store(const char *val,
 					      const struct kernel_param *kp)
 {
@@ -366,11 +368,8 @@ static int damon_lru_sort_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/*
-	 * Skip damon_call() if ctx is not initialized to avoid
-	 * NULL pointer dereference.
-	 */
-	if (!ctx)
+	/* Skip damon_call() if ctx has not successfully started. */
+	if (!damon_lru_sort_damon_has_started)
 		return -EINVAL;
 
 	err = damon_call(ctx, &control);
@@ -423,6 +422,8 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
+	if (!damon_lru_sort_damon_has_started)
+		damon_lru_sort_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
