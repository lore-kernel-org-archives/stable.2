Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691B4756C5;
	Tue,  1 Sep 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268418; cv=none; b=HxgdzaVDe8n5GhgsucNCX9Ip+UrnKCTp0xkI4QoJi4Ycif4tPtExoALxX8jFJb5GAgM9weRJPleFANhLosGSvztle5pGIZh2qM3kt/3cpnLZ8/mEiFY1ApkPjw8m73MWzdp7VsqbHVBm/PGL2ieuxj8+MDkt4wL3aLoOE8WIHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268418; c=relaxed/simple;
	bh=lZqnF/fq0s75WPlK1Ldiv9o028oS83xr/Lv60UdZAxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ75xTi9vZ3lcStaNwiPc+7E4Sc+yYN/lmjxVgEOux5inZYdiZHkyJoI2oM8Y3rYiAzaL4t7auXZ7zlJ2tFcRPdewHMKTV+w/weE+NgomJHpVoialSVegZt/IMotSAuppFR6kRhyGQWWbRduXRoNy/Rr5so7ibMuarw/FnLVWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7aBuYx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7aBuYx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A4F1F00A3D;
	Tue,  1 Sep 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268417;
	bh=/E3Oie88We+VUNBoQinHbEvxciAXpLnuOmC5tKc4/XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7aBuYx/zoaNFKLfyEi3UwnDYq4cH2lGtZXVK8S2AnTXEpjIkTxPvQPvbnSKGBfCE
	 n+3ROEh/GlRyDbtHcq8cp9T2dv9o+stRSkAbb9/rXv1D02xuuuaRI3FjNcDA63olqM
	 +f9pWQPDebd/5u3QrrvNqgVNHMvS/aGO+8a6Bnt6f5wBvuFy3QoKbraB8D/HcNnQMd
	 uE3raa2cOTxCpXZDsVTb90cy+Wqql3A8KH42Q1xeIFfoIGLwnubw/p37bcVoUiMKf0
	 hbcuRernukzJBG6qSveIbRz9sujbYxISeQMTsBRVr1JQPkhXSGrVH+DWGztzhJ/Ozn
	 umezALzzlzjwA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Tue,  1 Sep 2026 06:13:23 -0700
Message-ID: <20260901131326.97615-7-sj@kernel.org>
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

In extreme unlikely situations, total memory might be zero.  In less
extreme but still very unlikely situations, lruvec_page_state() calls
might let the caller show used memory larger than total memory.  In the
two cases, damos_get_node_memcg_used_bp() could cause division by zero,
or return underflowed value, respectively.  Handle the cases by
respectively returning 100% and 0% for used and free memory queries in
the corner cases.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ad3657d356fbc..3060edf5e4fa6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2854,6 +2854,12 @@ static unsigned long damos_get_node_memcg_used_bp(
 	mem_cgroup_put(memcg);
 
 	si_meminfo_node(&i, goal->nid);
+	if (!i.totalram || i.totalram < used_pages) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+			return 10000;
+		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+			return 0;
+	}
 	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 		numerator = used_pages;
 	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
-- 
2.47.3
