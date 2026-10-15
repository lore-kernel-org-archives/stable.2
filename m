Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B92AE76
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032829; cv=none; b=XZoMDVKU0EVBV+JCgnScfhWnRT8wmsKRvKWd2gGtIF2bz3A94je3amnWngOtMdBNZwQKDKvJcemPOMvizD++2/+9h7J8h054yjRu8Ad4+lTtxpmw3kAm9L3ieLqMm5bOUtg9zzjAyKCmwIa9DzUP9Dd2y6wyFD/ZDAfqCNE8FOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032829; c=relaxed/simple;
	bh=iU9ZRLyySo74AB9A1zhSn36j6jhUhvpNTo1u5XM2BtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt72iKUXYsdrbu92vAJ7lY4sEKdtEv0yzZ7ig/ylLJS0ARRe7M/Jz4EraVtpBOEF8Qrp5LiybPrV5b5Ou9VRAt/9IN2oz+w7hm/4o1PGcrqPla13IqQXxkpkwawQemn9baQ+sqmYRutxHPt+yCiXYC0QfHEAUBbovj0JU001hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byssasUj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byssasUj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8897e83332fso3074729b3a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032828; x=1792637628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0jwQSa7/KFwBhQ0eU8j/tY9IdNhu+VSiabnKKJdx54=;
        b=byssasUjKSFFgorwMItuhyRSj4MWXnZagWcWw4Zkxw6NeWeXwRvloX7VKhv0VX193V
         IJO2SxuHz62FA9EtfPXp7qQGEaqZ79gOxrklNx9r0DRVyXbySQ0BbnbiOJh+03vaUgx9
         bbEOHIvgAuFi4vXhUu+/oVBLiK0OMkJJhoGmy6ZVIwbQt5z56jiX6rrRE7yRCJVHSlgF
         vPSNbIMC+YvDGuMO/++OyR/zJ2bLQxy+kJv6jBZdgv1HiEzd2ATQcUngAwTQOt/CKpeX
         ej9Q6rAdTSuZ29s6Gg5dP5pQz8lwoOQasHVLXC1CqkTSWHTOzjv1CPeY1Lmo9WKLFMU8
         +3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032828; x=1792637628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0jwQSa7/KFwBhQ0eU8j/tY9IdNhu+VSiabnKKJdx54=;
        b=zr0oev4n+Lju3xU3yyPXq2HwQKKnHFhKQ+vX8uwin5ReQmnOH8BDQqXNX+FmV2nP40
         UN4OpgS6uWjV1nGAQdhXFyWWuzYIZ4QJTHJ3XNn57TJD7bonYTXTbLS/T9DNKktOTcjI
         8w2mbYn6me3lwi/qR34sY6ZOvKhBp52M8kLmxI2hpCCvEBv+itz1Q3VxyM/LkU9fVia0
         tVhYSiHtY5cRnujFRPFNxEU2hQTtN7T0TJQYJDUHufJlT6uEmNzDiRJ/sTUIq/3Tqddm
         83SY/7umKAhrRv6auY1+1vNJS3FTj++whdbvUyv8a81S7+D3lnlNqVT5THherobmPl+/
         pi9g==
X-Forwarded-Encrypted: i=1; AKwUvBxUBBHeLJkyiakuhOA87PCVPztAa0O3T3oYQn81Zmc4YdMWQ6Q6emxf62uKI2jq0dQm3vx43Iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvxhUHGSAIbllnJPtIrFMY1ZJmqbhQFQkSTcmJJku5UlFXsioq
	5r+zKAtBznfUVNYL4RgnBZgJZ3k+SjkRcFrLVF905e+UCQu79QBLcjJS
X-Gm-Gg: AYBFou2a1vZiFGbrQ553bPXSzD4FEt7xrP/heBzb5Mnmc1nhnv+D2zMLculgNivCAiZ
	cdwckORclpAQea+myg7ZuwIAsmUulygNJKbLbf0najYEs8gIkd0ZZGvPi4bTvqhgUvDth+dUZho
	+/epV/vQEN4liegRKRcs/wdOSJRxntQayivBKrjxWpphoCZooB7AMQs5f8PPD1qv2+h4zpTLwtt
	0EksroCGf3/mUvTS+Fu7VtCVKhPEa98isBSYcyPxylozPrcWiFPswZOVjoXVSVOPnchl8CALdxA
	SGET/Yvkl/9qILRBuhBS5b4Ok3itsEjOcOROBciU7fyFc4vUUMC3IOZpZa02UK1iIlcUkXZ7CQO
	5beYdn/RHixvtcmcxT30aPgwG3K+8tFnZy5EK5luoBj4Gcm0q9ccupC6RhOjUtD9pB/S4Q6hlmP
	I37z2wf6da/zy9b2jWfLZ3Z1aWkQKSA+/3RvlMwhzBxCY3GP7AdtGqSFw8llT2mqykYmvHTXYNY
	P2YYYARpqXiu1GluNx81fxkINGOh1iqqdKWA1a/1viW1tteudahKy6NyrpHqkb2
X-Received: by 2002:a05:6a00:c4c6:b0:88b:7e32:d91 with SMTP id d2e1a72fcca58-897d316cdbfmr7112036b3a.6.1792032827798;
        Wed, 14 Oct 2026 19:53:47 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d802d10besm1706735b3a.28.2026.10.14.19.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:53:47 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	fvdl@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/cma: fix list_insert_sorted() ordering
Date: Wed, 14 Oct 2026 20:53:40 -0600
Message-ID: <55118c45ec8251d7be2eaab87d9c0af4b8513161.1792032699.git.skunkolee@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792032699.git.skunkolee@gmail.com>
References: <cover.1792032699.git.skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_declare_contiguous_multi() uses list_insert_sorted() to keep its
candidate ranges sorted by size, largest first (revsizecmp()), and by
base address, lowest first (basecmp()). Both comparators return true
when the first argument sorts before the second.

The helper stops at the first existing entry for which cmp(entry, new)
is true and inserts the new range before it, which is the reverse of
what is needed. If no entry matches, mlp is left pointing at the last
entry and the new range is inserted before it instead of being
appended. With revsizecmp(), inserting sizes 1 2 3 4 yields 2 3 4 1
and inserting 4 3 2 1 yields 1 2 3 4. The first range inserted stays
at the tail until it is evicted.

The caller relies on list_last_entry() being the smallest recorded
range when deciding whether to skip or replace a candidate, and on
walking the list largest first when picking the final ranges. With the
list misordered, a candidate larger than some recorded ranges can be
skipped because it is smaller than the first range found, so the
function can fail or reserve less than requested where a valid layout
exists. For example, free ranges of 4G, 7 x 1G and 2G, in address
order, with a request of 12G: the 2G range is dropped instead of
replacing a 1G one.

Insert before the first entry the new range sorts before, and append
when there is none.

Found by code inspection with the help of an LLM. No kernel-level
reproducer was produced and this was not tested on hardware or in a
booted kernel. The example above comes from a userspace copy of the
helper and the selection loop, written from the source.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: <stable@vger.kernel.org> # 6.15+
Assisted-by: LLM
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 mm/cma.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261d..527b2d894f3e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -348,16 +348,12 @@ static void __init list_insert_sorted(
 	struct list_head *mp;
 	struct cma_init_memrange *mlp;
 
-	if (list_empty(ranges))
-		list_add(&mrp->list, ranges);
-	else {
-		list_for_each(mp, ranges) {
-			mlp = list_entry(mp, struct cma_init_memrange, list);
-			if (cmp(mlp, mrp))
-				break;
-		}
-		__list_add(&mrp->list, mlp->list.prev, &mlp->list);
+	list_for_each(mp, ranges) {
+		mlp = list_entry(mp, struct cma_init_memrange, list);
+		if (cmp(mrp, mlp))
+			break;
 	}
+	list_add_tail(&mrp->list, mp);
 }
 
 static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
-- 
2.56.0

