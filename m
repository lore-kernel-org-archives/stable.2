Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946911;
	b=LGWqMrrgz61fnk7LecLAqwhfqcq0DmuO7bvnsUrVlkMdF2FPh9MwrHAIjPoJUzeXVc1x
	 uOdNTXFJCAYgPIlp1zNvsNULAarjxBqVjpfkYh1xSrlG4E1wqobsaGOwj8pUJnaKeeoDK
	 2BavResMVA3UZczx4wc11ipIC01wJaZmWtrXqr/oQG5yOHgignRbJOAgELR9ghTX9qxYT
	 UwbxD0WmMz4c4zqkFJHInKMvbBpTd+t5Z7wEd5gKQpIvLDUvqppDszCb9hy6eRAAOVkoS
	 V+nphxHuca/DglClA27AvfCyTKMrMofR2O7W/AbJHec4MI6Jzbzy8LUpx9LKp1KnVIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HjEsKHyDFKj7HHX5WZLrUS4CLP7wbTWvbErAlhp6Z7k=;
	b=j6EkwK2BFrx/sMNJeDnY3JgAqZymRVCICPaI73TfXgRSrLJ4grexFyK9ZlPGOqhfeH6k
	 MRMkPVwpG9AfZgd1xwELwvpc0tls3cGGwC7t2A7P7vJElWTyWRWBnea3UbUzyKeqzqS38
	 mQUzUBZbccHIx/UvsSa7izrrs2xho7GdhqGozazf8on3BDcHfbd+ccGBA0Njsk+B6xYWr
	 JMibBVDYlI0sugi65Xoy/xhDadIP4Kln0EsCaNsZMb3VUrrZuCCIPer59GmnE50vETB+/
	 k+Qjd7FYvpSh4zmx0nc1R4dL/2fjUKsgMwf1wfAya/V441mlSUrPmQ5BzOotZ9HyK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD8B2bWH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB9606A327;
	Sun, 25 Oct 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD8B2bWH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14711F01829;
	Sun, 25 Oct 2026 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792946902;
	bh=HjEsKHyDFKj7HHX5WZLrUS4CLP7wbTWvbErAlhp6Z7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iD8B2bWHqgzjI/FQKlqUb/8hW2GaTV5hN/GUwnLZ3KLp1erPD0njJHPkCkyN297ny
	 zW2XJC+SMYZO2ojUSZ6bCd1dToZAJ0EpeuAECGZVh5jgaAt/XkfseZtVkpZ/w7hdPc
	 PCJWnva3sBiqz2Unh2MVFhliRQ8r+T/14pScXimM7+yq7L1gYHuAhknT07LrmUl5pe
	 0LSfP98oYntPL0DoZM5Vy0jZALZGdjOphx51lhSGHMoq3dGQH7nFmfdO9nGGmDmaFa
	 jyc14QAtpnPF24hh2R8nbM2kFxdMxE/DyIH5x8Jcv9m1ucgXN/IeCLec4M/FevsF1b
	 vuA7SPvhkOgrw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/core: move static variable rotation to damon_ctx
Date: Sun, 25 Oct 2026 09:48:06 -0700
Message-ID: <20261025164808.152048-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025164808.152048-1-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
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
