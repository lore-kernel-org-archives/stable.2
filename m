Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5B3B774D;
	Sat,  1 Aug 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605768; cv=none; b=NNMq5qE7i0UVlUkbsncONsDu1NxMAZiYNQGFNvfsf2C1wIvMGAqYofkzW+Vf2f47xQvvUTcdyS/BSnUOv5NTSxzgeRwRQKB100GRFSxdnt3sHlVhKASTbqOXL3iPy8oVlM+pVGbrDolZdbF/n6Ibf6b2Y3t5Ts4CQWYLe0YX3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605768; c=relaxed/simple;
	bh=KjoY84pOsntbTzs2pYQd5yUSWCVGO50nSKIZh/b5N2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG229i3Gk23CPXq8vPD61e7zFn76gxIlYORQsnCzYvavAbivXZc5idUStcsrLXc5mk3xu7+ZJUvqz15cOSZZP5ME4IYqdCpexBVo5vABpdv6gAcSgEDxdfzsKI9KMAXfHhr80Tn+vT9q8pj6H0plqNT1yMx0L5plxz451mAElrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBhdoT/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBhdoT/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBA1F00ACF;
	Sat,  1 Aug 2026 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605766;
	bh=o1TLO1J6QDVVNz5r0BRdl5+1+gHGcHEvIPNqhuz3/rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBhdoT/oGy8uRNBe84+vYOBuny3Wc3DU+omPxB8qCyOOhCnd7o9VPHfTLGSr0svTm
	 WIVpXEAo95W2gFYNTc60Q/WrtdVkwUCPxrXFqI0aCS1pvhIFlzieCAPUArKSzS7M7E
	 WiCSPcSHFSaorwfw1JYkCD+X/Z6b8UycD0GVzoa6YTU6LaSH+i8jYQ4BqC3u4nkN50
	 aVM3BZ6dyZVLl5ekBfmG8Qzr27Ok+q7YLzONrQq1/3z9fWr02hCNBH7/Bbv78Ez8kf
	 DORcHdnxEUA7CGYp9TRVu0eCFvk35jcx2SgKzYvpD57ijKfUj4y99iyAUR1EaPkGGM
	 LadBoeJhACBfg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Sat,  1 Aug 2026 10:35:50 -0700
Message-ID: <20260801173554.94710-8-sj@kernel.org>
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

In an extreme and unlikely situation, si_meminfo_node() might let the
caller show zero total ram.  That could cause a divide by zero in
damon_get_node_mem_bp().  Fix it by setting the totalram one byte in the
case.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3bdbf4fbf7147..269865eb8fbfa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2816,6 +2816,8 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 	}
 
 	si_meminfo_node(&i, goal->nid);
+	if (!i.totalram)
+		i.totalram = 1;
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
 	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
-- 
2.47.3
