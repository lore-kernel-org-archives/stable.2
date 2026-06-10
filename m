Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397D41325C;
	Wed, 10 Jun 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099760; cv=none; b=QDu8u6X4rYEyetn1NZ1Azq6KYQ0XWfGZ2yiMfpUz7eJbDzNpMHHyxRVRpXWhp/ZvO9PhuZ8+YsRxQcWUfsPv5BjveDNhdJajxkielgcsSFYQq4hjdmbVtdjDplfwezw0JG02mi0CXwHIWVg6Dr7jgaiNKbDuDms4Gb5y+5oYUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099760; c=relaxed/simple;
	bh=tyY/UdZQq2D/sVxcxXfMLKmhuTV2Mi47LEa0TyPuc24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnTKeEX9UWX852V9XvwI5UkBO6gkrdKTrQHZdMDpQMtHegyUdpZ4epKt7/rRuA6OKF8rE3i7laUiVEhGolYJQCoMqhtiaiNMIwtub0D798WpDCW8rwnP5YR9oWAAujQP7lHEmRl3OdiXIuwwsStyhiUlL/9BjDXKWi9v2+t1w18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcr15hwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcr15hwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02171F0089A;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099759;
	bh=Q4eyIQGc8+YbZ/+RebaJPmK558jLRcrZFCvASXPTF6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcr15hwWNAfWGBze970neza/Riie2JsT2EdEpr8fVGGSz/6GM2MidgoBinploF7aB
	 /mSVBSfQKFx0TXZi42o7h9jrs2eo4St4BNqW9RUHXl+SUJ6U8KWCskCFY7TQmuXUoi
	 HhQvD925TuFMndmRQsZy8rexLZgA5rUmcw+cp1Rm0SjTH267TO7xydap/4uw/zrgOb
	 ys7XestTmnfII6oJs+RE+lc7U4EocNkoxEMJKZ3KFayltTHMpk+Em8DkhmS9LmUeJ/
	 r5DkrntC04oRcE9ievA7cc5Wi1rranE237bxLJ04yUFDhAP2X6i74MW5Mea5FFg+vk
	 nuxRaNeekQP8A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 6/6] samples/damon/prcl: stop and free damon ctx when damon_call() fails
Date: Wed, 10 Jun 2026 06:55:44 -0700
Message-ID: <20260610135546.64943-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: <20260610135546.64943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_prcl_start() calls damon_call() right after damon_start()
is succeeded.  The kdamond that has started by the damon_start() could
be terminated by itself before or in the middle of the damon_call()
execution. There could be multiple reasons for such a stop including
monitoring target process termination and kdamond_fn() internal memory
allocation failures.  In the case, damon_call() will fail and return an
error without cleaning up the DAMON context object.  The
damon_sample_prcl_start() caller assumes it would clean up the object,
though.  When the user requests to start DAMON again,
damon_sample_prcl_start() is called again, allocates a new DAMON context
object and overwrites the pointer for the previous object.  As a result,
the previous context object is leaked.

Safely stop the kdamond and deallocate the context object when the
failure is returned.  Note that the kdamond should be stopped first,
because damon_call() failure means not complete termination of the
kdamond but only the fact that the termination process has started.

The user impact shouldn't be that significant because the race is not
easy to happen, and only up to one DAMON context object can be leaked
per race.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260610035214.4850-1-sj@kernel.org

Fixes: a6c33f1054e3 ("samples/damon/prcl: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 0db2598946911..edeae145c4a8a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -112,7 +112,12 @@ static int damon_sample_prcl_start(void)
 	}
 
 	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	err = damon_call(ctx, &repeat_call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
 }
 
 static void damon_sample_prcl_stop(void)
-- 
2.47.3
