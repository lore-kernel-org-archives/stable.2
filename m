Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277504;
	b=EY61O82SyEuPzcENExEzNeBJyhrWXVAvaGUugkZj77kxgUZwzfc3yfjksFF2TI/5WB4e
	 enIorPlumdNwJxnUNgsI6KbBCowMpbNz6t7SepmcIMJa0B5PvK6jz8kUAEW/ZvVG0JFuk
	 1LZjvuTSV0KycIhOyb2MHCRCI638bahRuuySk1T9sMbHdXBITVkOSQ4Wckq4cOy8rg0ka
	 sf/vVi6c0v/XGtjwc50Xh9qoAI8rHVExBm5/Fa6En3c76xl+n1X7QNWsy3YdyDuLuYb2N
	 ohR99BIy7Y9pXWdFTL0H3Hl5KPLgvntYfBWyuB18TpJ6Ykzy3YFDhwpVexGxlnK1h9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lM4m5T67vL8+cPiiCKZ45w4hjL/d5OYgwK/JlLAImo4=;
	b=vBJ6iQ5OnuhEbhTr5a6ghqRSfr65xVpWUXshJbVeiTkEOjVbjDTc6AfTZ+1AvvIi0ly3
	 AIF9eqPCJRug/q9bmiQqsnnufEsvmvGZAAlHrQUP/SluKBda7UNJohWDc7Kmz1rp0RwTi
	 vpAoZBT0E1LpS3dzgVIcKDNxoH96Bre6cQFmDFfGm8dQCmgVzuiwcU0xlNCI4wUCKDbRO
	 YAdw1eNoVjgiNCS/BANetR4lKU4XYljaepOQBShuu/9soa61j8uR7T7JijKbSbrBe7aGb
	 aGNxFsAbULJMvmWQRg9Ap3UCPMXzP8Y/sU9w1oIY8ZRTj4IZdpL4DOaeKkPI38PijTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bud2HuED;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bud2HuED
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F851F0089F;
	Tue, 10 Nov 2026 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277503;
	bh=lM4m5T67vL8+cPiiCKZ45w4hjL/d5OYgwK/JlLAImo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bud2HuEDb4wFfHjEbkpu5s0cw24FBicJGs/BkbhGWcztoMFGzKZEDxwAc6xX+xvsX
	 wvFw1qdULKep0GYY69U8NvRv8beHWZ2bssL9ljNFxw25bcUuPxiGbuSz2XYmPoLhpp
	 pXDo4qwtx+SV4s4eF5YRsIMKwO2lhTgEN/wciTWpqBeHMU0vwQG7MBLuAXiw507x0a
	 G2QAv9yYwhTv1baqm1XUkerDQZx2EZrvIhtppa8AfD2NVUv8avuQRpQlJWwQFaAdq8
	 zH0PDaeSygdZapPROL/ybL2BfCTrus4+Quy7onvBoProiOuic8g0xYznjynoe/IlAv
	 EqxVzIl5kGaHQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6.18.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Mon,  9 Nov 2026 18:24:54 -0800
Message-ID: <20261110022454.112647-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200407-failed-6.18-26ae50a0901a@kernel.org>
References: <20261109200407-failed-6.18-26ae50a0901a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_split_regions() uses a static variable last_nr_regions, to infer
if the region boundaries are too stable.  If it looks too stable, it
does a more aggressive region split because it might be a fake stability
coming from non-aggressive split.  Because the variable is static, the
inference can be racy and wrong when multiple kdamonds are running in
parallel.

The user impact is not critical.  No crash, no leak.  DAMON's
best-effort monitoring accuracy can be degraded when multiple kdamonds
are used in parallel and the workload has certain access patterns. Still
it is a bug that is better to fix.

Move the variable into the damon_ctx struct to fix the problem.

Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a47f2
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: <stable@vger.kernel.org> # 5.15.x
(cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 656a314ad2159..46332310fef87 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -804,6 +804,11 @@ struct damon_ctx {
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
+	/*
+	 * number of regions after last merge.  Read kdamond_split_regions()
+	 * for more details.
+	 */
+	unsigned long last_nr_regions;
 };
 
 static inline struct damon_region *damon_next_region(struct damon_region *r)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 56f2343ffefac..701173dadd7bc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2525,7 +2525,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -2535,14 +2534,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		return;
 
 	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
+	if (ctx->last_nr_regions == nr_regions &&
 			nr_regions < ctx->attrs.max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
 
-	last_nr_regions = nr_regions;
+	ctx->last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.47.3

