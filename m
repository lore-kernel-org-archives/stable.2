Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB784756C0;
	Tue,  1 Sep 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268419; cv=none; b=oqzwHLNrRcKsBXLn8e7h9M3MsGw6nLgPaA8DID/5lr4UlHr8Ku9UWJpb3TYXGsfRxPYKt7zNdHViQBNJJn+SMGxHpeI3mkd7jMEg0GJeFt6SWpNeO6b+rCcrvhnB/+83UZDjkrGBQxqDCjbPMAjeFkUhIAEUAWqkdaYq4UYfRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268419; c=relaxed/simple;
	bh=tzAcE6SEgWB3A7dvKIyT7G341pe6G1l97zdd278rH/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN3CTYuXiQtAxdK+75Fn0vEpSTg6bAsYPytHJFdCorzxBJr9L9Hg8bC80r/d6IKsc3cqrD/FczlETLonQp5KZ7ql7EMmVCVKQjZe0JKX5u0AbMxK0K7mRanCgcXW9uy8soygxblrXeYHZ2oJl37spzLI9RYZbrRfIIEp110KSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuII0p++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuII0p++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D331F000E9;
	Tue,  1 Sep 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268416;
	bh=YLJtgrH/eA5cfD1d64StUX4ou+TBBQRag4ZJY9MXlY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuII0p++NSivesuV41kQLUZ8NvVu65lJ1q0Po85tU2T2wrCHHnSCAip4Mc7mNtJ8U
	 mSu+1g/nC+ZndK2iZqieVTsVDOIysZt3y48irQsnaeHM04LP35H5p3XbD17eecxuoJ
	 e8JzG78Btt/C6QsIAMOjflxrNSpcuYr8bgnGwcGFyM4XSprpMtQZN8Nvyylhak30nC
	 u/NtYZ2ALhqH9V89sXl72O1jaIehbk9AZHp8YPKR4Tq9vm0ZjhxpwOkmBLmYnV53q/
	 CgdNTDi6YbwVVNH2Ydqww6DAt3MVJX9BudXurVUvWcR2atT5G1mo0Lx/7/jMO9aMfK
	 QfOGNe97ZAlfw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Tue,  1 Sep 2026 06:13:22 -0700
Message-ID: <20260901131326.97615-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131326.97615-1-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an extreme and unlikely situation, si_meminfo_node() might let the
caller show zero total ram.  That could cause a divide by zero in
damon_get_node_mem_bp().  It could also show free memory larger than the
total memory.  This could cause underflow and make DAMOS temporarily
make unexpected behavior.  Thanks to safety guards in the auto-tuning
feedback loop, that should not be a real problem, though.  Fix the
problems by respectively returning 100% and 0% for used and free memory
queries in the corner cases.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a6fdb3068262d..ad3657d356fbc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2807,6 +2807,13 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 	}
 
 	si_meminfo_node(&i, goal->nid);
+	if (!i.totalram || i.totalram < i.freeram) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
+			return 10000;
+		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+			return 0;
+	}
+
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
 	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
-- 
2.47.3
