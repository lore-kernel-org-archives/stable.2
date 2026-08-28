Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0612F8EAC;
	Fri, 28 Aug 2026 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881631; cv=none; b=QXNAGqAeGOMARK/MTT0kDg5KSQn42pQApS7+Xw0tLO7Azut8rL2hy/6aAVp/Y3ng63HtaS4DpvJannagCFb19tvWsZ9yFBKoCHPWYMJMekaWB0TzVwoPmA90Otmogap/21KqGKUn0wjD47jWLOagOSt4Pq3Md8sa8QUZ+KgCZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881631; c=relaxed/simple;
	bh=ncX71bZRwu4AuWDsk7FltFFxkbG60aAYKLG941OcN9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc0jQA8Md6YV6PK0wjLAutbdRB2E6qx01gw61nmoowzOVG8An6lzBhj4eFdBR8MBVdunb0pX/ha9HPSa3yXf5fkYkInqiVbOtQli2UYpShIrUr9JvnqzV9Z++O+3bOoEYRDuS1Niz+yWzMmwL+rSlqxpHytEoZsK1y05odT6Ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtbX8mVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtbX8mVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1101F00AC4;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881629;
	bh=9nWd2JiHbGpFxdKtIgR1/mA2jBP+r1D6KF4ucSMyulY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtbX8mVLoREWGaHmBM5m9kXliDsh2AQfn0hrzWT7rWHB/eaufkaZ43YdaBE5485NG
	 qMUCaHb0VIsQUV5/EfZdhs25mD+BsRV0UyBoYHNBAyzu0KrQkWdogw8wF/puukDrDd
	 BT3HFeCdQ97JhybLUtgPXRR55Jrav7TuPg7gGKmxukLTLgA321GvoZQRVNPmoXJfqc
	 g89xd3XGWdfQvhoOp7ENaxFZDliNMY2sqMSNtgZMozkfskvuRXe83gB2jeQyFPLLyR
	 5LrwkykKG96zwmt1q3iBUqlPekmRTXzAhNkjdKNnDlUJa5iUPIf0I0c1SS2qvnv6/O
	 79c9OP49m95zA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 4/4] mm/damon/sysfs: set next refresh jiffies per sysfs context
Date: Thu, 27 Aug 2026 18:46:58 -0700
Message-ID: <20260828014659.121058-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828014659.121058-1-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'refresh_ms' is set, DAMON sysfs interface periodically updates
auto-tuned parameters and DAMOS stats.  The timestamp for the next
refresh is initialized when a DAMON context starts, and updated in its
damon_call() callback function.  That is, each DAMON context updates it.
However, the timestamp is a global variable that is shared with all the
contexts.  When there are multiple DAMON contexts having different
refresh_ms, the update frequency will be changed, depending on the order
of the contexts.  When there are multiple kdamonds, it will be even more
chaotic.  Fix the problem by having the timestamp per each context.

The user impact is not very critical.  It does not leak, corrupt or
crash.  The update will not be faster or slower than the lowest and
largest refresh_ms values of the contexts, respectively.  The user can
also manually ask the updates on demand using kdamond state commands.
That said, clearly this is a bug and can easily be reproduced.

Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a global variable")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e3858ffab4b22..f05b256c90ee7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1789,6 +1789,7 @@ struct damon_sysfs_kdamond {
 	struct damon_sysfs_contexts *contexts;
 	struct damon_ctx *damon_ctx;
 	unsigned int refresh_ms;
+	unsigned long next_refresh_jiffies;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -2215,17 +2216,15 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
-static unsigned long damon_sysfs_next_update_jiffies;
-
 static int damon_sysfs_repeat_call_fn(void *data)
 {
 	struct damon_sysfs_kdamond *sysfs_kdamond = data;
 
 	if (!sysfs_kdamond->refresh_ms)
 		return 0;
-	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
+	if (time_before(jiffies, sysfs_kdamond->next_refresh_jiffies))
 		return 0;
-	damon_sysfs_next_update_jiffies = jiffies +
+	sysfs_kdamond->next_refresh_jiffies = jiffies +
 		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
@@ -2273,8 +2272,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	}
 	kdamond->damon_ctx = ctx;
 
-	damon_sysfs_next_update_jiffies =
-		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
+	kdamond->next_refresh_jiffies = jiffies +
+		msecs_to_jiffies(kdamond->refresh_ms);
 
 	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
 	repeat_call_control->data = kdamond;
-- 
2.47.3
