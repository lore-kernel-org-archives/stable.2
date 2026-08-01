Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F53B7767;
	Sat,  1 Aug 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605769; cv=none; b=FWdbs3GbxENtVYj+WKpPZk0WFKiMIdBldhtcPGpwmDiFFSFaTdmqMoLlrweLUUuoP7XutRSa3SZxs+BHxThNxLYPs9qKqfyHiE1uw4Kom/fiBWAFvir9KjNWj0A5k7dK6v1p+O4qAIHMtqsee9hXqJlwYFInHMtCtcuNU9S9/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605769; c=relaxed/simple;
	bh=uBgSX1JL3LZIlrv1TPXSHtS7ge7Vi0spiDNd2yiDPw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHphtrzjPveykKcE/pavFA3KRxbeRH/1urfeJLD9M0R4J6cMgwCrOGBPUGtrzaT+xx7IrZrYkA9nHuX54b6aqE0t/FohE+ya04HI50g7BgeLGNLSIoLsHk2gExoM5EX0xl9+XB4J4ILOEFKyznok4SjhigYXh7IZZ5/mhjDnWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS2FSll7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS2FSll7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4581F00ADE;
	Sat,  1 Aug 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605767;
	bh=2lVMcowLJ38JKqepYS3zjjIyEUx+xmDnTKakKUngaTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hS2FSll79ic9yMYMFuLhwoUua4YRp9/4WIiXbfw5x6UFbIs9W48ZLxX71wW/1mjPp
	 4hElEN3ceCaDJwohmysCJQ8Os/yBJMkMcDr1ed/B5fNDoaLkfvTSODJXQDHLUZ68ec
	 gJq/5SVn2fJak45Gu3sBShz/WaVDXWL15JZpIc2FUL5zEgVrPnbJExuIILUBga5MNX
	 rubm5ausGrbA/uIV/lFwajWxVdcZEzt5htR8R4Y3Vy1v1Dv/LcTJCU1HYMhc+UbJvA
	 ybvYjUeYMh32ArPj5pkOW8bpiM+OXlIQ0Hg/3GPKuhDWGQS26QQMwztb/ASwWAU+BV
	 uGUP52S9y5k9g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Sat,  1 Aug 2026 10:35:52 -0700
Message-ID: <20260801173554.94710-10-sj@kernel.org>
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

damon_get_intervals_adaptation_bp() uses the sum of the active and
inactive memory amount as a denominator.  In an extreme and unlikely
environment, active and inactive memory might be zero.  In this case,
hence, it results in a divide by zero problem.  Avoid it by changing the
denominator to one if it is zero, before it is being used.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

Fixes: 4835e2871321 ("mm/damon/core: introduce [in]active memory ratio damos quota goal metric")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 76764a2056f7c..4944cf2c5afae 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3010,7 +3010,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
 	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
 		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
-	total = active + inactive;
+	total = max(active + inactive, 1);
 	if (active_ratio)
 		return mult_frac(active, 10000, total);
 	return mult_frac(inactive, 10000, total);
-- 
2.47.3
