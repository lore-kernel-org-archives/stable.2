Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD731F9AC;
	Sun,  2 Aug 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696881; cv=none; b=oKGWcBIlfJ1H5RveaW1VsW78U7HdtbWfC/q4tm0hPfi/IkDfNCfWIbIr8TN7MtEfKL3gyQs1zKNmiSKNfbV2BIAIk31goX8fcxGSv75swDmNeiYaQLhWnBHhHrOo9T41vS1K8FewlvgTfvPdkhxA0zHfwWSpuxO+gHFMsvK704I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696881; c=relaxed/simple;
	bh=7kchgOt0aA7MxTKa0Tj69FFDy3D3f9dhvNB5JTY3Pq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+pRUo/5aTfFQfcx+/MpCzJnGpiohEel2+R/CQIS7ufMrun6OA1c3fUJivO2a+ehbtAL+C5y3bnOGNIBWbKmVNP3YfImlKc6Z8HxJYxq/rVt6Gaz0PiHQ+fovYpKcCtVNZdm0UEHqea8Y8nrSBucBShdkA6Y2hwZGK/j0b9Cu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGEesB9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGEesB9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C1C1F00A3D;
	Sun,  2 Aug 2026 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696880;
	bh=ew/a4uW6pk7X4wPVJ5ylrhLZPDJztc2+7Q2+2wvo0Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGEesB9vu6VW1zZJApPXDAYtyn7jICQs0nToBK7mFRxVE5xAkmXxHdpx8y0fGFb/n
	 EZNIVQOiAhBtbDNaDEf9s3YJjX8CfxzFoLVzCFUxmJkfcxVtKulHiXqAX4R8hYw8iF
	 8xTOMazRTsizkcNMvnAv+cnBsV+pUEtHCzUNaok563hA0Gkyfzu+dh0WpPlX5LB8Q2
	 J32OO0Gtc811I9E/WYhalF3fyKzbA6AikVlkc0U4xiei+OLMVZguDwyhBKyIk/w1Te
	 4hi0/rYRN5VivhOC/LCoNMeDqCHG0vWvCpFkHtBoH8sFVy75PFx6TMrVuQa/vLFkgs
	 SW2eR9fQjSZBA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started
Date: Sun,  2 Aug 2026 11:54:27 -0700
Message-ID: <20260802185430.9940-2-sj@kernel.org>
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

DAMON_RECLAIM calls damon_call() for commit_inputs parameter user input
if the DAMON context is initialized.  The context could be initialized,
but not yet successfully started.  In the case, damon_call() could
indefinitely hang.  Read the comment on damon_call() for more detail.
Fix the problem by memorizing if the DAMON context has ever successfully
started, and skip damon_call() if it has not.

This issue can easily be reproduced by writing Y to commit_inputs on a
system that DAMON_RECLAIM was not turned on before.

Fixes: de3c60e1c831 ("mm/damon: add synchronous commit for commit_inputs")
Cc: <stable@vger.kernel.org> # 7.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 09e941d75f67d..45d5557cc575a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -271,6 +271,8 @@ static int damon_reclaim_commit_inputs_fn(void *arg)
 	return damon_reclaim_apply_parameters();
 }
 
+static bool damon_reclaim_damon_has_started;
+
 static int damon_reclaim_commit_inputs_store(const char *val,
 					     const struct kernel_param *kp)
 {
@@ -291,11 +293,8 @@ static int damon_reclaim_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/*
-	 * Skip damon_call() if ctx is not initialized to avoid
-	 * NULL pointer dereference.
-	 */
-	if (!ctx)
+	/* Skip damon_call() if ctx has not successfully started. */
+	if (!damon_reclaim_damon_has_started)
 		return -EINVAL;
 
 	err = damon_call(ctx, &control);
@@ -344,6 +343,8 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
+	if (!damon_reclaim_damon_has_started)
+		damon_reclaim_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
