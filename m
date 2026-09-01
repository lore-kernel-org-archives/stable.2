Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C743B3C6;
	Tue,  1 Sep 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268742; cv=none; b=Gi6KkXs92awQDOIqdb662s55res1zNn7jl0Vzq5tDwwjqVJs73UuF3ziopzRz6Glxbxu0uOgU5LSZrSenDFVvlJl0ILucg28od3mbrKXlqWMaU3FJrOriyuS1X3ImymykolXmLnzc84A6HINBwR9xd91LlclHjhTuoHlbpsgF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268742; c=relaxed/simple;
	bh=GXr/1jJ0ZcG+tvVvUf9OAFx0ZgFUmAAa9q7CIMr6dbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey6ktulilvYHyj5h89ybycXHc0SgqnZRAItkAcMVdt2FK2KqV13MhYyWGhRrxrfF+PAT2L0pCdS9TE+NABGys4b5Nf5cvp6qEw9Ioj+OVmgRIXXfwH1lWEaU3qm6vhaOXge8HRii1+y0nKcsa5fdpfkjY6fmdX9wJu7d9v2urBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig92mQta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig92mQta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452D01F00A3E;
	Tue,  1 Sep 2026 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268741;
	bh=VvO9nu/pvwrT8AJnGanMkEVbhfeAa8vp4BSGaiM1GXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ig92mQtakTdHt0VVFboiQzpG74wWcUaalH06d9B8H+DqFvf8O10xsK8agpzNt48dI
	 J6z78dAJsmkAgL1bGwzouj7Bo1tsFXUwjGUhxaemvkiP5iJj5I27039kzIr6sPksz/
	 JmcUMbUDgwzghHaFtsLePi+nD/8bOnxkGtErWkZTfW+jquJlWqsN8qC0LBAV4yE2Mh
	 E6LBN4vo828WsQkUMz4FEZZroCbmbvGpWvYiJZv6EeK+4lqNiYuxidJqZjeLKjMtPt
	 iXRCXVLksLVM8WMlccLkVlGFJDyXyLeFnLG3uFITa+I94BxAVO5fXbh2YuVmqx6CPS
	 uPIFRnMKnnwDg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Tue,  1 Sep 2026 06:18:49 -0700
Message-ID: <20260901131850.98037-9-sj@kernel.org>
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

damos_get_in_active_mem_bp() uses the sum of the active and inactive
memory amount as a denominator.  In an extreme and unlikely environment,
active and inactive memory might be zero.  In this case, hence, it
results in a divide by zero problem.  Avoid it by changing the
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
index 3060edf5e4fa6..0df785e72438f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3006,7 +3006,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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
