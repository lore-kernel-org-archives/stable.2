Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57383DA7E4;
	Tue,  1 Sep 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268742; cv=none; b=mbgjOxs+H+t9+DhBiATdNnIgVya+ll8LS/2v7WhO7u19206Xq7fS6dXZscVSjf2MdGmx9JE11KVwNnlfyNB3+9dEuX/owkS8C5i6tTUN+00NPEqgH5a5Sr+sWD+Pse0tnSHgbWDcZMD49t414p0vUOJs0qA/0jqvVYQUw+3/XV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268742; c=relaxed/simple;
	bh=tzAcE6SEgWB3A7dvKIyT7G341pe6G1l97zdd278rH/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsciObuILD2R7XdNCqv8iTKndQGRqwOKrJeWmIJCsb+YqOsoU8zTUOrtgVcbK16mHtPa5eJOhK3oi3VP3p4MvGo2dFXqapft8HvCX8xgWFaqUiUg21yTg+v10kstra9bwUI5+tp/J3W0HJJbWQ3VDzXIbVHB4QClCcjYuHUHT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvRKDNbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvRKDNbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DB1F00ADB;
	Tue,  1 Sep 2026 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268740;
	bh=YLJtgrH/eA5cfD1d64StUX4ou+TBBQRag4ZJY9MXlY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvRKDNbT0hyEoN7m5TjTShQ5sN5bJPnuNWLT6l7VT3lCd/KVbAfzwtJkyYLnKaccq
	 P1Jw9u0g7PmSQBwVBlbiQEs8LfnoL/0DQbMK8XTluP/mmlATssbYqxglyn6C/fYh7l
	 rp+7LZauxItUuyiDJ4F/zDntxqOpzYlZKFlU9xINPgFA4M7tWIzkweK9pz461bhAnY
	 3/Wx8HiFakAB/JN3eWrXGLGf1uJiGNbN9/qPXlnfQx+MbZgFfnQ5N0f0vD3P9DNS3Q
	 QY/JgRdyAdRo48bYa/MLnNFX/VQqTSlkN74Z86yHtOfe/uztJgo8Qnbfn64UX4i+4q
	 MBDXcwSvH7XyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Tue,  1 Sep 2026 06:18:47 -0700
Message-ID: <20260901131850.98037-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131850.98037-1-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
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
