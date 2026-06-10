Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1D411687;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099759; cv=none; b=AQzKSSwRTkRaf4L0mZplH2N2PBSKOYvLmGHSnrVM52RKtRrBm/ZohBSI21us7uibd4+HDGVYM7B3TAYDO8K6MaU0WDJQPrOXiHSLCsgBwS8aQjTFZTsWnnWY4PGZDNiqO2oNx4rMsgfsKsj0vBC5OCTovU47PS6stk4qqvIjuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099759; c=relaxed/simple;
	bh=enbigSKfZhHs55sFswY1ofWl2WsfR5xtqPL9/la+0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDsq7yTv6CWeYmRQN11mePUuBfOX7Re+a7YMdA9S9/fWyfF1zq8MB9YPrbce5iz9paA33tzpljYoTzhECcIsYWKyMbx5zeSRvLSMJXx4glUjGNEsAHxP8CgGYCiMbb9Wf2effDAY9eH/RAQfWY3zyLKsz/+YY4o7+IyMY95lrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rji3sPlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rji3sPlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4991F00893;
	Wed, 10 Jun 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099757;
	bh=wvTmgzWVeo+cgK/5Fasuy9LNL6Vq1lM40f7iFKommVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rji3sPlqTY8ctgiYIT9CS7Y49q7tR0k6yOM2EHlHJxaxhefyvT56Z4d8udfEUajwB
	 KvkJHgfh5cbOSx6wEKZATBQfuvsAxdepjtiqaS8Pyk7OOsGfM1rxlIhF5gho1hEhpv
	 1+DAxz5IqAUFViWqsp4HF4jFvKcHi3mjr0zRpGY+EZ3MmExzagpwV47KeSbjHTP1u3
	 I1z8PGc2/8prMVoAza0dBmaA32J10LmYm33c1lRvbOtXvJK9WJwg3bg8nGy9ROCoq+
	 O2x69ckdQhHNAtLTxPFtRNByinbhkTVSrezp8gN9HU8g71V4clAzrBS8cZa8w6zxeG
	 WyR3+cd1IFNww==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 4/6] samples/damon/mtier: handle damon_stop() failure
Date: Wed, 10 Jun 2026 06:55:42 -0700
Message-ID: <20260610135546.64943-5-sj@kernel.org>
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

damon_sample_mtier_stop() assumes its damon_stop() call will always
successfully stops the two DAMON contexts.  Hence it deallocates the two
DAMON contexts after the damon_stop() call.  However, if a given context
is already stopped, damon_stop() fails and returns an error while
letting the DAMON contexts that have not yet stopped keep running.  This
kind of unexpected early DAMON context stops could happen due to memory
allocation failures in kdamond_fn().  Because damon_sample_mtier_stop()
just deallocates all DAMON contexts with damon_target and damon_region
objects that are linked to the contexts, the execution of the unstopped
DAMON context (kdamond) ends up using the memory that freed
(use-after-free).  Fix the issue by separating the damon_stop() to be
invoked per context.

Note that DAMON_SYSFS also allows multiple DAMON contexts execution.
But, it calls damon_stop() for each context one by one.  Hence this
issue is only in mtier.

For the long term, it would be better to refactor damon_stop() to always
ensure stopping all contexts regardless of the failures in the middle.
Make this fix in the current way, though, to keep it simple and easy to
backport.  I will do the refactoring later.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 66b591f2180fa..faaaaa12e6206 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 2);
+	damon_stop(ctxs, 1);
+	damon_stop(&ctxs[1], 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
