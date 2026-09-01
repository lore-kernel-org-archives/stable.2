Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA88476044;
	Tue,  1 Sep 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268419; cv=none; b=eV/8aPGMf5fCXM0xL6JJG1zuoJEfql24usVFxsSDOTPS9MIRpPbNvYUaHenlUGRRU1CW8lFf2D81FGZqFFo1lHeX5lH1yhcX4Qv7s6ejerqnfdBG6Dheo0p0EqEb9OGhNv36WMK69nNA4H6z8PDeesflN5YbFPtratyEET5nAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268419; c=relaxed/simple;
	bh=GXr/1jJ0ZcG+tvVvUf9OAFx0ZgFUmAAa9q7CIMr6dbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHrZIR6eR73az0FNZC3w84TfXt0r1799RhJiFZoOLJEXml0pBsWV1utXpPjsEYyqZ6Kygryr5D4hur6nr23HGrm8WRXKqD7h4jvqsfHZi6wglGq5qFrIob487zEVZKgBCo1EmuXpsFhNEuSssSUfrC6c8VYF4NPw2H41okm463o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhxcEplR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhxcEplR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFE1F00A3E;
	Tue,  1 Sep 2026 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268417;
	bh=VvO9nu/pvwrT8AJnGanMkEVbhfeAa8vp4BSGaiM1GXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jhxcEplR7ISywxsedbUTqGQu7PZiqFsRqLmJ3SUop1iqYrPGKpKqoT674IWzD2tpu
	 vBKhSLCyTbHm0V6fYoTATWVQveKAq2w5X64m/0MQNtP+IiYN93BqNWV2ViAhcMtX1/
	 tqIZdRCnsYz43Xci1FCQr67kw4uCSYAx7jYvLx1WYB3dpyKaQ4+Un1lTsNMSWrmB6W
	 dC8vgFFYVStw3iHBO6BUnogGZQuhtMB3gXe30XaprI60pLphYo6I3Ivlp4/LbIiE1+
	 ibEu3mqQ3WKSz2Cp3lcPTVpM5FnaQu8gT7ZIy2gGykqp8hwfyfGbLKjMaiUtZF0Czp
	 G8fV0gNgBz3nA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/7] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Tue,  1 Sep 2026 06:13:24 -0700
Message-ID: <20260901131326.97615-8-sj@kernel.org>
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
