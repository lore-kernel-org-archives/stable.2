Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC433D4E4;
	Fri, 19 Jun 2026 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902312; cv=none; b=ZHgBtc4wqKKVU/KkQAuWDIoRRYHYUeoao3s8m9UtT/PWhGzNb1enV5NC7EQwPZJInaTzUz63aizNInSpuW9wGfPRCTMYJZmmcgg+u4caAXVGxlYqSXlnUr/yvvSDBo6BKvBtnfkywHfHVUqXCyFu8BHbrhV8+Iqs6WDHZ69EwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902312; c=relaxed/simple;
	bh=Gyz/K4csJI0UfKAbXzLIi3BIMnhcQOycKEtnC+z4rFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXYakCG7tzGIfVSbAWCM9b+TWA6RMm5Jqt2XLxOvu55ZjisnNTI8rvx5uFVDMFCh4JBgZukHrKvBwwdAhPvq6DrDQi2xrVZoM4weyNXDVfaIJxQSPutFfVwnIdR4BHgL2IGFAKs5+Y7/aO3wIHFeAjSYSGmao21zWBs7O4XRR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1OovN4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1OovN4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5F21F000E9;
	Fri, 19 Jun 2026 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902311;
	bh=4iq0ijo90COF3Rq3DtHD6rw3T7Yg//ZMNQpyM055t7Q=;
	h=From:To:Cc:Subject:Date;
	b=h1OovN4sxY+yovVJ4XlVy27s5+y10ZuVfIBbIbydeh9OnbDkr+eYx8cPyiR3q5j+C
	 GVikjWO2PHiS906CfWT4guAhMyn/S4moYzQKGLfmTi6xVj1/A7GbnYzzbg+3mLhdb7
	 R5Mp19yxBUCqaVpJPHTSBu+NO5PAJL2rrnib2acSYL7hO/NAvOOCToKF0lpH9LHf7W
	 dVz9nlgef0HbkOQ8I1Y+oFjCMkMX+XRUwOqi5tzPYnEZymQ0hHWxQn3ZbEnK3ii3qe
	 WqBbKxqdMrTHl8ChLcJ3yNEwNgrU6YxNdB275kEGLFGBJ6pZUbno+1gHg837V3574V
	 OzZUHgQM0SYsQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon: handle zero sampling interval in damon_max_nr_accesses()
Date: Fri, 19 Jun 2026 13:51:43 -0700
Message-ID: <20260619205144.150664-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_max_nr_accesses() causes divide-by-zero if sampling interval is
zero.  Fix it by handling the case.

The issue was dicovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 64d75c78f4df4..b6fbe6089abc6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1066,8 +1066,10 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
+	unsigned long sample_interval = attrs->sample_interval ? : 1;
+
 	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	return min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
 }
 

base-commit: 7a58ae62cdf3c006a53b805bbb12079ab2621a07
-- 
2.47.3
