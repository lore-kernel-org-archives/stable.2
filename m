Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E886485CC1;
	Mon, 31 Aug 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184986; cv=none; b=LtjXfLrnLmXvVUDfdAYQmI/zeO7TF/Y8vgoKyUd0fDXhK/j/urFzsQb/1oM4mC4wpe5xYh9zBwhot1Wh25l1Gw+5s/y0RhZ8642aw2RLSZePyXWlTJqKb+7lwmgUnwKAXhj8wGPrDTftKrIAg8AbtwtnG7Lg+5yK+X23AcxFj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184986; c=relaxed/simple;
	bh=lj/M1S5oaN42+56NlgGpIrZFtQOGxHB9iPCOijXVAX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATBn8aEFC3h0JdPx4dQYOUBACOy2THJ6AE7WMIkQfuM7KFBGkIeAgeRYKCT49WhKM07GMQPyFE70mFjx8n/UavAcwttCvvCRiO1jjesBzd3i1eYj1ppqjwRYxcMu4YYqKMp4tNh6C/lyLRUuf0HTJypyJnNGOtt/vVA02TrSfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erWnS5qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erWnS5qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B32B1F00ACA;
	Mon, 31 Aug 2026 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184985;
	bh=W4ZULCHKs962Ql2lXNfqffyY3ieZ1mpdjWXyoNcHe50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=erWnS5qgR382J6JC8z3nVk1ADCqsV8VhofU2Ph+h8YZCbWmv4FeaOqyakgTD3sVT6
	 SCDWU3vMlqX54v/PG7m1wVOXEswl6nXm00wz0VJf1/lwCiwoCY6x84Nr8suHAxrml1
	 HYX2AqXO5O0XBw0XgDnmhCcAsrFQG6jZCOXpgTM7chqvOzAfbTmkPZRdUFtgHqupVn
	 KFECZgtDxf1hYRvQLoN0g0494AS6/lMMnnPUqTbS1HlN3doLwddGJzAqXf8UQr5gMo
	 Wo5XQy6dUpXn7VLZLO5JQ+v4igVQ51FDFI8oDOcG+r5CGMMu3QBHsVi/DP4Xbz3rs4
	 5HnIhItzFoL/Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 8/8] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Mon, 31 Aug 2026 07:02:47 -0700
Message-ID: <20260831140254.72004-9-sj@kernel.org>
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
index 3779a04753061..f8dddbff74a77 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3015,7 +3015,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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
