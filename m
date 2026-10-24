Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870440;
	b=IEsxyColVsG47NJTnwlSpxXbSI9AHWi7qlhCft71wjrXpw3BVVmefgNLxu8Nb+Ya65Ng
	 50svHPPy4Ahth5m6GH2ipYklI6Zbzi9XBRTnXdWMkbVUaU8OAW+hQZJpFxY1ZYkGpCuvC
	 dXuICYmgeq2GhXnIyhlDCMXF/v9Me1XjZ/6ColwswwCiOPQ0ud4AOzdTBW+ZwP4wzeGbS
	 s2YjuhvsAbzikEVeOP5VZ1kpPzzYoGTiMM98G03dYJEKkheVwbQemCTIfyfgARDc4c8nC
	 wpUybE1pYTZobNJZtI0do0Vmkjxychm2hORs9h33X8N4yoYU8cyBgRR6oxMwbVRFVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HjEsKHyDFKj7HHX5WZLrUS4CLP7wbTWvbErAlhp6Z7k=;
	b=wgzRSbwXjMOWXVLsgC0zq0r0mRcbelzu/WJ8bdqo8Z8QTh8Z05DnjKwLTXlCPNKf1HET
	 M2QKmIYcG57+HSAzRIZy4IdapVeCNAShPssabOfSRY8ey/5YX0e3VXUHuaQHZG+0FmlGB
	 Xwt6lVOwGN2PP1fyNcL9K/tBuDa3DxQuhHNDheNlox90u9XEEL3FKEfCzuSsPP7FSw0cy
	 EhvRABMj6ftGmce3+PKE5hRPY3LEmNHs4k1BjCAR7lIh2iuzin+X+kfwIye+9EKKZH6dQ
	 7lkPKut6pNbjyZrLN4dmgaPU7lxwTe1DRKkCXVEigH+CNe/zWxWWX8S0iNfgp+ytQiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfoDNYpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B6606A32F;
	Sat, 24 Oct 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfoDNYpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B951F01825;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870440;
	bh=HjEsKHyDFKj7HHX5WZLrUS4CLP7wbTWvbErAlhp6Z7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfoDNYpTX4r7251gPD043Z1N82zWoBSTl5aNvZtonOA4CjNZ3L1eLdV95xz2RfATx
	 2faEgGwhj0NbSZZr7VkX0Q8X4/3r4FCxr5Zh6LMv2YSYHUARHCPMkCR59uwDPDlZmc
	 1jQENf/ehnrpbH94glJSmQAZtY2FGFwBYC7vVXrCMTg6LZaHEMBRQ/7JFdgRTK/68q
	 U0NH2cctz0L7JkiXtwHihVPr3EyRbK4hBlBdndEytlIS2aY/x+Geg3w1oWM56MTmaD
	 G3g9mTg+opI83yKo93OuXV0A83hfzIYdrCe0ltAbLOaWcB72/prR4m/cUlsm2mRn+O
	 saIR+PzEetDKg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] mm/damon/core: move static variable rotation to damon_ctx
Date: Sat, 24 Oct 2026 12:33:49 -0700
Message-ID: <20261024193351.87130-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024193351.87130-1-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
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

damon_split_some_reigons() uses a static variable, rotation, to remember
how many times it was called.  It is again used to determine fair
selection of regions to split.  Since it is a static variable, it can be
indeterministic and therefore less fair.

The user impact is not critical.  No crash, no leak.  DAMON's
best-effort and indeterministic monitoring accuracy could be slightly
more indeterministic when multiple kdamonds are used in parallel.

Fix the problem by moving the static variable into the damon_ctx struct.

Fixes: 1a582e6e0174 ("mm/damon/core: split a fraction of regions when nr_regions exceeds max/2")
Cc: <stable@vger.kernel.org> # 7.3.x
Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a47f2
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cb6a50032a1eb..380f9cf6ddd82 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -963,6 +963,11 @@ struct damon_ctx {
 	 * for more details.
 	 */
 	unsigned long last_nr_regions;
+	/*
+	 * number of damon_split_some_regions() invocations for this context.
+	 * Read damon_split_some_regions() for more details.
+	 */
+	unsigned long region_split_rotation;
 };
 
 /* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 09722257ce736..73b571b429cb3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3753,12 +3753,13 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 static void damon_split_some_regions(struct damon_ctx *ctx,
 				     unsigned long split_step)
 {
-	static unsigned long rotation;
 	struct damon_target *t;
 	struct damon_region *r, *next;
-	unsigned long offset = rotation++ % split_step;
+	unsigned long offset;
 	unsigned long idx = 0;
 
+	offset = ctx->region_split_rotation++ % split_step;
+
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t) {
 			unsigned long sz_region, sz_sub;
-- 
2.47.3
