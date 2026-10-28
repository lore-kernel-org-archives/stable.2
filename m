Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207850;
	b=IR6pkAQmYtpvsfK8J1dxc4DXNaqHG77jaXmwB4TZYot2CWtPEwryYEOzF2O0FF89C8h9
	 uE2wuvmPmVKeaxWE4TD3oD3iHgZL0pFtxEZNS7C2qKMMNiRjOe0rCP3y75Mrv9CXj66kQ
	 oz85oQWUvOUNPPhgnRulGdzC58uExLC6jEYkFdw6udMjj3wmWIcWujATCNGvIDsBgYhhr
	 inxhrRmEyl/31IvJwJAhCGzFaGubr/0D5jCoNosTW6+uN1E/sUI4XVmf2F1WzAH6S/+c2
	 NXiJp4YA4lXVRAy+rhquMhn07sC8887LL7eoltiq2TOC0PYw7XPcJqhE1z7Sp8REWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8zJ+CABCBU45JUBR07bzfuVV9dkmnMA2f9ZOSTtAqbg=;
	b=Xy44pZQLPtNMZNTMj5xIkXa8Au3M4Lck8wL4K/f/v2akZ2na5pqGr0WIZnGle9Ki5y6A
	 o8bDIQ0yyCg+u/2nxFMeGb5Wd/RuK3oe2JsZjebjWrIy/T3OQ0JyXIMNYBFbTsalVJ6W2
	 MS4tw/M92yuSt7qbER1q5oZPAbeIcNkX4GeVYRP0SKN71PKHmPamvWykgofFZQn3FGoLy
	 CfHj1tlxkm6la1y/46t4ptRWJEORMV0h3KguSXKEmCQVFX1gBdMyfmGleMdzh7MMiWih3
	 7jEuggHy/r2gWJ841dis4dzLIWGh494FvvPVK7pCwUNOyMvnHB05VZeVp3fZTRiA3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=CI8y2eXo;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E2606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=CI8y2eXo
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b05bf699easo13139407b3.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793207848; x=1793812648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zJ+CABCBU45JUBR07bzfuVV9dkmnMA2f9ZOSTtAqbg=;
        b=CI8y2eXovwu/O5fMtk947eXXsHmnlNxwGrTROXV//Q8qMHsfQljEZshE1ytljUjlKT
         NuYxQaotba5cxDEzyVf4zNqNA0L4/Ey8T9lWccUzBDTk8bwdODKqLL53H67ikao9MUNk
         d12kOZtlBmk7hCKx1pcI3BeAhbHzCSFpxqWziTGjUD5CABmZGC/DAnvec0L9kMz9Lzuk
         eCsheYTS3wED3G7AjNheGRs+3o3rVI5PlhIW0TGGeIZoDR3mAloTMzhw3xccnj8oc1ER
         Zngcqxz0qaR4u/J10Gc5njuMJc69LoT9h8VHZBNL5dFKCsp+lblZdsE88e4Fl3KAF6n1
         p2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207848; x=1793812648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zJ+CABCBU45JUBR07bzfuVV9dkmnMA2f9ZOSTtAqbg=;
        b=xY+3nsQbpJomerCxooCW05Jh2BeosW3xOToJ0jYovnLlG2dCS3WQZYqyk91rIKdQwY
         LteHl+B+o2I7mDKIFRCPyYXR7WIUi+03tzCNe9e6+zIBToU4/pa21p1eP3nsd4ibD9px
         YzVTPjbHLxP4LxlfVAz9uGbjY7B2MMmNhGvQqXBz/6t3rQCcmzw2DnZkiNrJtGvLVgWC
         Igic0KPtaSu0kNTdn4SKKLJNLZTcFqXwfaizTInP+DiLu6CpS7+Re5ItM+bUwDS9oChw
         UPL+dcYGu9nM9O0CAP06tL2RUVchYcw00P969go41p8TK7sQ01QNRE3MYWj/i6sketVD
         +Fqw==
X-Forwarded-Encrypted: i=1; AKwUvByuLiAcO0z2qELy8IORflulcMgIYsdld0JVkTw3pSqc98CA0V9wiw+jVSqf7f+hQ9tx/Pzop5s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVmofSvyCcmguNnOOeP+ih9vnBJFuOOdzTI04JjBBpSDkDwCrT
	vyTkkWk5kO0urLnrptTIH7F8zKKPpZD9qfrvSio7KJnU9YGzlsHQsVA2TWy2BhO/w5g=
X-Gm-Gg: AYBFou0/GsMk2pyqcMaNgft/a5XgcYx0LAmSaBbHuSBc8jsvwDC5mBa3RNEtCXzhZFI
	w0arcJJFQs3lA0ndVEzEI4OaLYR76TN/nDU43XyiGIuAZgjCT8XUHSV7lqBAtFAbVJQTdiMSRDG
	1dgeO1mlImtRoXNj48V1TOZ1/kpCbKtHi+g6gyjTGrAPTkELTk2pdeJrUKrmNCrpf5DgoCcF8qA
	DWIP3y2IEd8wfGaBrZZsiOhk9J7LhJSbbiSBp2esi+9wfqBMlteeZka0JBzALPWu+9dxuIs/XEc
	UOzVw9auDA21JFH1jLQ2sTtHJLfMLub3qmvmG4SO6lNPeF703QPAG4QSpzygY0Kb3zZAerLeFp2
	SRVVfbBB1awcG0W1P3/Bg386Pv3dvPj4DkK5bIRfiuV6c10zc4+jhNFUaRa2TU7Le/eGpN7Ayce
	9CDgn2FSP7tuRUXRjJ3Na+ddgokeqPCXj6ruh2BVDbwv5qx0tMDj4GDkWzmz77YwThgGBz/MJO/
	q3EYq5BazpUBwWDip0aUcVeGpWlexHZt4yC7dLh6RNCUxqBG/vuQqxJfq61+cKwge8n2V4x9+m+
	8puqacSyAvu35AarSdUQVgkoud1m
X-Received: by 2002:a53:c30f:0:b0:677:ad01:32b0 with SMTP id 956f58d0204a3-67a7bce93abmr1470801d50.36.1793207847839;
        Wed, 28 Oct 2026 10:17:27 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a0c31f1sm2058926d50.11.2026.10.28.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:17:27 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dgc@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: page_alloc: do not give all non-blocking requests reserve access
Date: Wed, 28 Oct 2026 13:15:53 -0400
Message-ID: <20261028171719.2043421-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028171719.2043421-1-hannes@cmpxchg.org>
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
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

281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
highatomic reserves") accidentally gave all non-blocking allocation
requests access to highatomic reserves, which includes GFP_NOWAIT and
other sites clearing __GFP_DIRECT_RECLAIM.

While this improved atomic request success rate, it's unintentionally
broad and can actually worsen highatomic requests by squandering the
reserves on requests that don't need it.

There are concurrent efforts to clear __GFP_DIRECT_RECLAIM altogether
for costly order __GFP_NORETRY requests, which would then also fall
into this exemption and deplete reserves even faster.

What GFP_ATOMIC has over the others is __GFP_HIGH, which
alloc_flags_slowpath() translates to ALLOC_MIN_RESERVE.

Narrow the exemption to contexts that have both ALLOC_NON_BLOCK |
ALLOC_MIN_RESERVE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
Fixes: 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 4 +++-
 mm/page_alloc.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8cac5e01066..8ac2e2bf14fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3238,7 +3238,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * reserves as failing now is worse than failing a
 			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+			if (!page &&
+			    ((alloc_flags & ALLOC_OOM) ||
+			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index e238ee91ed24..9c3c2830acb0 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -60,6 +60,9 @@
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flags that mean GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*
-- 
2.56.0

