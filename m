Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD95435EF3;
	Mon,  3 Aug 2026 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764816; cv=none; b=Bl0lwqjl+NOPWdRidNfgWsFi4RNROx8/IhjiJlqoY3M5lOIGBwT00FAeqP38n2GYrQmOqR4qnP5JkAvd8FDC5UUbTZ7X+8fKO48Uu0l6bAN+vKNU087zDffBgZ8xy+DXIqfF4PFfgPoLwo52GfUSjTmwSxeGc2rQ6vYCC5FZBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764816; c=relaxed/simple;
	bh=SLHaCN6oJ5b09JUDm/ZSjN2yWNvqHhSuGLffrFq5yZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+w1674q/YKhsp/+P1XZ+LVc1op2+oKUaINq4wHZJcfFb9ibQObxU2g14boTfVd0MV3CMvFmb3FeJf7AbNTRVIzi3w7LHKh3GVJXPPg28Mr/19Ay6SFLyofqVeahoxmJ0CIJqrrzxttrfFL06kj3Ubg81i6kusf97ob3ZWWESFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtLiJMjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtLiJMjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F8F1F00A3D;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764815;
	bh=KZNY1MD6P0OCjtAb6cuHefbevIrlOVJqJGEJAaJiWKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UtLiJMjPFYh82D0ZcUpbJO8m7vG45NurdccoSqF8tLAeGDMrpFVqwLgvKfMo5mPBM
	 1A/vIMEgVaklPo/HQsr7cr+4GJaep+hkLzWJTkQHkowTG9svjcLIxmy8YdUvriAuiV
	 +JbFbq6JwEH6aQexXArZ/1tIKmFGfBSb7dCJJjeonQiVRqE4lFzU/8Sz+HhYKzvqE+
	 ITAYn/0sITU47MIQ7FZT39wF0zCOHN1dwA/tLLKIF0VqesGIaAUrnwLdqE0E+j8t+V
	 DxRYUEq7FOHpz3sRS79YPczyP7HXPXEAVuGchOHnyKArSj5nfuZeKb8tCOr4uMfTzu
	 QnaR8LQeuTS1w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx has not started
Date: Mon,  3 Aug 2026 06:46:45 -0700
Message-ID: <20260803134646.16640-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803134646.16640-1-sj@kernel.org>
References: <20260803134646.16640-1-sj@kernel.org>
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
