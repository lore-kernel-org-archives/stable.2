Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95B485508;
	Mon, 31 Aug 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184986; cv=none; b=ByVdPLYoqojnl2c0XbBnO2L2XSl/ik1EWg3trDZq5unlay0BKqPLAVVS1yapqUZg+OeDRpuQsB7NF+15OQSUxfBdIpawYE60Tx3xCkQdh75Mh86DQ7mVqJovGpVRG4alVSAgeinJgo9i70B43dN/+oKJOLUWK8GdGDTAwhOLymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184986; c=relaxed/simple;
	bh=1/nML6wnR05rkV9jNVuuWopWlORtCjTUs8FNgIFWA4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7g6CV6F13901/7YikHeZk4K05fSf0A0i25UokZbSaPXChnii2kyrGBm/TfCuANiEKHzx/x0D0BdmYTinzL39NzXRkvw7Wb5Yk6FctBJ/TiYJF7mK/N381yoDrSM/nYt8OrMdizfLyPM3IGShZ5r2cehQqhiAW9LmOsa5NSjY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS4NaUCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS4NaUCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF51F00ADB;
	Mon, 31 Aug 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184984;
	bh=XKdCBVqYdsKdXO80RoHHV0o5QsCfADzPQf1ZzSc7B9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IS4NaUCZQl4owxLyOXkjofnED5AIG5ZNyQRpkBVZBoyMt8ateeyXPEa7lNhU6i4J6
	 OTne7u4RNdgEO8kTKPD835bdYHYEIzzIQsr5p73sCK04IEq+aDZU4YtXGL9/pCaiYr
	 p0M+iMo+J64J/7zmfywqh5Eg8+fE6hGs9MEkbpP7sV94aXy52aO7mNVdDsIV9B8Fz7
	 j9fPrxqbBOFfNuY2etAIKQua52nNoNhmwemNj6VzAu0yVgptcjyIMLlSBkrD5s8WK9
	 TR4tehQpFQtRK9ajPeTGv+B1PNb1AcKYep11zfhv0Eh+3+1Lz4kHLDd2NQWjmQ05HJ
	 nH3HY0AzQivCw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 6/8] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Mon, 31 Aug 2026 07:02:45 -0700
Message-ID: <20260831140254.72004-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831140254.72004-1-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
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
index e2900d0c984c9..75d71ac09515e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2816,6 +2816,13 @@ static __kernel_ulong_t damos_get_node_mem_bp(
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
