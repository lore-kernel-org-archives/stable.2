Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94F3B9952;
	Sat,  1 Aug 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605768; cv=none; b=QrxSxGFWLJ4huIgQwizozeoA2qIv7IbdPOMSFrQb1X0pKVWOee5y18KbNhaTbb+GqKrkVB9+uXeGcCxCPmbHGthkw9RJ6mvHk/Oo//59Jtq2o79A4VuTemLq0qK93Dk64J8OYr9Ok3yAZc80G2J0N5rwFPFf8mlNt0eg1cosi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605768; c=relaxed/simple;
	bh=TsApn/EBuEZDdp22FMCoBKg8o3mNdte07+twbtXDt38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExPkJyaBvDsiibfbVQtuG3Whwv7okaVp9IfNbLvsp4tB+ZJZ8FhCZMjwCKy9vdpeRYA6Q4fa0Ljtjb2SW/WVLcYrBjdFSMnsv5cVdorFd1F3vOsvyI5/pFE1MZqhVwuzaFZrSg5bnpt1IaPGOrdS70bRDJu1Y4rFkPttsONkDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLT4gtqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLT4gtqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132801F00ADB;
	Sat,  1 Aug 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605767;
	bh=yKFkp73Zizuc7gexvqH7fNRh7GwZeAoSufeXbUk/pxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLT4gtqMoalg2zLuDMjvtK/ef07qFRzpt+RM2ctRTcIZ3j9/K93AyBnxGZVuNwRng
	 Gopobsn1Fx/WJ0+EPpcLwkzkBIyGDzjtYzBPjMV84zQg8qjWyUZm2S/h0EGdVAGM97
	 8+ddelOUyoG40WvlZHuHGfMa4oVq/Q7lZQjm5vDVaU6vHW1HSRoL2qKTCb8fPT2DCb
	 8VbgD0EaeCNFedX9ba2aXObuYY/jOAyAh0LmpwssCEGEzmr2Lr9FhrYr05xvYJFC1g
	 QSnU8Y2im/ARKApd+jeszY1vR4bIsqgjhyWquzUzQ1/8vJpzmIjD43qOPfHm9UBe+n
	 TGZ7L9lrbZd0A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Sat,  1 Aug 2026 10:35:51 -0700
Message-ID: <20260801173554.94710-9-sj@kernel.org>
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

In extreme unlikely situations, total memory might be zero.  In less
extreme but still very unlikely situations, lruvec_page_state() calls
might let the caller show used memory larger than total memory.  In the
two cases, damos_get_node_memcg_used_bp() could cause division by zero,
or return underflowed value, respectively.  Handle the cases by
returning 100% and 0% for the two cases, respectively.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 269865eb8fbfa..76764a2056f7c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2858,10 +2858,16 @@ static unsigned long damos_get_node_memcg_used_bp(
 	mem_cgroup_put(memcg);
 
 	si_meminfo_node(&i, goal->nid);
-	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+	if (!i.totalram)
+		return 10000;
+	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
 		numerator = used_pages;
-	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+	} else {
+		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+		if (i.totalram < used_pages)
+			return 0;
 		numerator = i.totalram - used_pages;
+	}
 	return mult_frac(numerator, 10000, i.totalram);
 }
 
-- 
2.47.3
