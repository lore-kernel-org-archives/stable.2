Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0C3B3BEC
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166838; cv=none; b=dSl+0YzP3gtOAD7lADASu4N3sLkRD6xGjULMtSQs3GsAo3oQg1UIGxpaUgNOpXXPBCkbXHX9bIL+AlbJ0FsxD6VquZEnS+vgwjJp6h1ynFN2vXG7Ab5q6W9tZ2LiSUxPCKohRQ4pD6IJxq/HsQN8ri6l6adIJ3dmtIpq/d9gkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166838; c=relaxed/simple;
	bh=7TbmGkj5XctrvRQfI98zd+79MAqRuuIUULa9r12HdqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FekCCMLLYFZ8uCuUstqPb7FkE8OdgDMMWxTLl67Oy89CUWnWDt82s2HMs1nHZAdm/m2yCfhfZOeOjYoqzKH7w2zDm7pEpFbmcq+GflvKrlX9q4Izn3+lx+b7m8iicPWPvOiqaUs8IzRa7lyLBdBru2tmx6mR8GuOPLmMshBBOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkMo3iy2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkMo3iy2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485b358552so3002035b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166835; x=1785771635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZNNFqmiKhCxMpepdTGRnKCzuc4JoIea+/gUgOwbSgQ=;
        b=rkMo3iy2CSGC/gBh/Wn6tw9ruFufrGgHTWvzCmSTurhhFyrhz0juFCW/1QR+5bhNEP
         CKDD4L3QVuzh0NKSnsAKHv8PA0PeKm2UAmcNIi2RScTVCSeDDje/K8R8LTMMbJAQKAAW
         JExwfc4gMefDi4HBSJ6e340oCjf52pgs4zfoc5E3M/Nl030FUyYnf5Rz3Y/3O9G94yIT
         mza5HmF3V+qDjq0qL8Y9d/rs+A3sYLk+wjfMvOxVX2LbIVbc2jLQnY/xZXOPu0aOVVYO
         AAXUnIDDAvhyEkL7ysfANcCf7kawbr7Cjv446jMMmUbn5jBSdel3HkC6Ga8cH60ybukk
         tOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166835; x=1785771635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZNNFqmiKhCxMpepdTGRnKCzuc4JoIea+/gUgOwbSgQ=;
        b=dwbKshJ5KsGl6OHeA8bhyPcCjqE4lFMeV038a28NR5FZIkh74yi4gpKsErrabFHZ4O
         NigU8qKs2Y0Pf4jXdJdRRplofJmc6fTNGIEJ3YqkRlxNDXTmckXf5IhFoJROI8Q+X2D5
         LbVqzQucHJP28okta5kPsVUoX0ok0fJ8EWRI/SDCGf28l7oXG/a4OF9txsBVubg2tJar
         WqMepsw1cfKYEP146nJLZOW6l8/oOwKOcG3dG5iOyl98Z+0udd0HdDNCeEk+vZJL5F0B
         vP8lbSFOXCpsojPhxjzNvZCbeLSkbZ5i/Kg61a3WSdiIb68y4XdhiH6+spEeGKmUzFqh
         vLiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpafeTPm5Vcynynmg+56tphUNpEFVym/rcwG8pEHlLR105l8qegZg7JnuvVrOFBdxFT+a2ZV5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwMiXgrlgSIqwYmwZbQ9PRnT+6a8O7B5JFjbz0/wl8eK+Q5U2
	BEJazigCUS9kUzwgCORRu+yr8sBElhaxfzaPXTq2Iy8Y0Wj0twp+fROS
X-Gm-Gg: AR+sD11ZdR/ujxLEXvhY0MCJLRIuXTeq+3BLV6MGQhm8BmCtizQwGc2H6O66YnM4DGf
	mWzChdHOXCm3GhntddUkMhRLdEdJwGndva3MmSh8XwhPbPrBSMNihbK9SGjA3Wu9DxtjDBVssyF
	+Lq6+FgBn3Sl97SGM6yEyAaWWbFaQrIhrcBx8BFq+I5Y7CK3eoFqCxvUZa6SbqFkL6SPAyBt8Lt
	Oohznom8Z7yRrd8Lg84a6dfRSnzPFSuO926ruTHBCjJEZqyEwCYpvqgrm+Lg5v9Vi+UyYAjEuIN
	5Cr5iIv5LRQOX+R3/3oZkdInZiz5qhs70aQqL0bZWD8dmAlcAtvZHPrszEJIOqTikW3lM58h5+d
	HfUKAX1J6+ntW03Qp5SYjigGX318c8p2Fz9ez4ClFydlUjzehwypW+vqNmbAyVkw3IaJmwBZWtx
	j2zxRcL/U0kMNhQq3pZ9C9
X-Received: by 2002:a05:6a00:3393:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84e8cf89b3amr16485b3a.25.1785166834932;
        Mon, 27 Jul 2026 08:40:34 -0700 (PDT)
Received: from spr1.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f3fbsm3332996b3a.19.2026.07.27.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:40:34 -0700 (PDT)
From: Hengbin Zhang <uqbarz@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hengbin Zhang <uqbarz@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC PATCH v3] mm/thp: serialize huge-zero folio state transitions
Date: Mon, 27 Jul 2026 15:40:01 +0000
Message-Id: <20260727154001.4102341-1-uqbarz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
References: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nonpersistent huge-zero shrinker clears huge_zero_folio and then
invalidates huge_zero_pfn. A concurrent fault can publish a replacement
folio and PFN between those updates, after which the old shrinker
invalidates the replacement generation's PFN identity.

A later partial mprotect() can then misidentify the live special PMD and
enter the ordinary anonymous THP split path.

A writer-side spinlock keeps huge_zero_folio and huge_zero_pfn updates
from different generations together. Lockless getters still use the
refcount fast path. atomic_set_release() publishes an initialized new
generation before a successful atomic_inc_not_zero() can admit a getter
on weakly ordered architectures.

Suggested-by: David Hildenbrand <david@kernel.org>
Link: https://lore.kernel.org/r/20260724100509.2300200-1-uqbarz@gmail.com
Signed-off-by: Hengbin Zhang <uqbarz@gmail.com>
---
 mm/huge_memory.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..79bec4495540 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -78,6 +78,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -237,17 +238,18 @@ static bool get_huge_zero_folio(void)
 	}
 	/* Ensure zero folio won't have large_rmappable flag set. */
 	folio_clear_large_rmappable(zero_folio);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
-		preempt_enable();
+	spin_lock(&huge_zero_lock);
+	if (READ_ONCE(huge_zero_folio)) {
+		spin_unlock(&huge_zero_lock);
 		folio_put(zero_folio);
 		goto retry;
 	}
 	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
+	WRITE_ONCE(huge_zero_folio, zero_folio);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
+	/* Publish the identity before admitting lockless getters. */
+	atomic_set_release(&huge_zero_refcount, 2);
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	return true;
 }
@@ -298,9 +300,15 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 						 struct shrink_control *sc)
 {
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
+		struct folio *zero_folio;
+
+		spin_lock(&huge_zero_lock);
+		zero_folio = READ_ONCE(huge_zero_folio);
 		BUG_ON(zero_folio == NULL);
 		WRITE_ONCE(huge_zero_pfn, ~0UL);
+		WRITE_ONCE(huge_zero_folio, NULL);
+		spin_unlock(&huge_zero_lock);
+
 		folio_put(zero_folio);
 		return HPAGE_PMD_NR;
 	}
-- 
2.34.1

