Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11545039;
	Sun, 21 Jun 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782056895; cv=none; b=Sz427t64tWiytJSjglIj3R2ivjs0ETe9mWJdtwCRmK0mE0MiJOYHPElPwSrQdnRgnKZnHo1lLk9Ai1p9lti6m6LSYLxkTDR7vA/FhBvD+pMRIC9KOcx5PKoVZK35SAG+kZQJ9/vY2tbr1slW4qQx1t0gytFEzEkAApcvPKZmKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782056895; c=relaxed/simple;
	bh=rcbBh4qPhLcMkmjNOahlfWWxRWZQO8BXgh3SWzAW1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWY8Z3xBnLuVy8W1hS774h4CxtDZ9ER49i80S4384wOHy4mp+TAWZVDekW7F0zIt1pTFkjnHw/K1eWaNwwVrL0gLbf4Ojh2dV8U8X8+6EETIYARn/T6WLpCim4xZEV8zzizEbnD24HLOn+caYudmKLdBmhluCTB4nXAHoN1ipI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrxISM1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrxISM1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3451F000E9;
	Sun, 21 Jun 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782056894;
	bh=WgPuBJVNaV8iXn7vMN0W8u2z/1iTfOUDdPi402d7mmA=;
	h=From:To:Cc:Subject:Date;
	b=FrxISM1zgRMO/d2IZ5VFsU3Ox0FmX7tXAqncJWmvpdLmADHpGk5f73S+Sa8rwE1ke
	 c92AVcPIS2diEorB5JftN6EPClV3Bh1YXbPa/XL3Hsxv4BqbUzSXoaA+9zg5RUA4m5
	 f17g6DRjmnQgyJ4PlEZcQ0iDiALUK3mUtII/AoZX3hW0EFPcBqKKrct8tB/XNMikPq
	 lS3ppE5VKbLTjgQjnAwaAIPmVwsEi9LAUZN7WM6zL47PTneVqziTs7iimFVCPzUMC5
	 RtOxN1QmyRV23E7EMZfjeb5DwoUOnqrLuHr+GdUr3xh5VmjLbzVJCAApx+mfCxnrNo
	 djxouOXt73YQQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sun, 21 Jun 2026 08:48:06 -0700
Message-ID: <20260621154808.86431-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
is set to zero by the user.  If the aggregation interval is set to zero,
the function returns zero.  It is wrong, since the real maximum
nr_acceses in the setup should be one.  Worse yet, it can cause another
divide-by-zero from its caller, damon_hot_score(), since it uses
damon_max_nr_accesses() return value as a denominator.

Fix the problem by setting the denominator in the function as 1 when the
sampling interval is zero.  Also ensure the return value is always 1 or
greater.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v1.1
- rfc v1.1: https://lore.kernel.org/20260620171413.89555-1-sj@kernel.org
- Wordsmith commit message.
- Drop RFC tag.
Changes from RFC v1
- rfc v1: https://lore.kernel.org/20260619205144.150664-1-sj@kernel.org
- Handle zero aggr_interval case.

 include/linux/damon.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 64d75c78f4df4..02ac34537df9a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1066,9 +1066,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
-	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	unsigned long sample_interval;
+	unsigned long max_nr_accesses;
+
+	sample_interval = attrs->sample_interval ? : 1;
+	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
+	return max_nr_accesses ? : 1;
 }
 
 

base-commit: 7a58ae62cdf3c006a53b805bbb12079ab2621a07
-- 
2.47.3
