Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9C453A49
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465237; cv=none; b=Lq5r9CmZi/CJ2G5bQljjIIoRrVPhZd2c9rh8vibpRgqES9AJFGxf6gn3OcQ30s2CcTzd437mE7Ej9ht7HesWg5URiX9HXGOil2rAsyATxF5x7Y9Qr1R4jFiVOyk30If3eqkMIecwj4aunCZLQs5j7JMAVG4fjwK4hY8jaqr1nIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465237; c=relaxed/simple;
	bh=gdhgj696Ii25cJJLKG5o8JqobHX6eU3cCyv0hJr0QKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j53GLU+YW+1p7DlePm0rOHfUsLkWC+YvyFTwgozkzqfoMPOb70rggLeWusMXwKxREObwK6XLmgNkOLI66jXduGPi+e0XSIKcVku7QLZTVdupdOUaNdvhQrZfpWji0aF4lcZNjQ2af9kPaZk1ld10olzFv35AsKTHH0xtt2D0bdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2DoTsON; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2DoTsON"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so1563805ad.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465236; x=1787070036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JhsBT4JbHu8Y1LpjWeHwh/rrcED1LfRchkAqH5o+sQ=;
        b=L2DoTsONAnaQ0DaBAF8zxk+acShxn+RcIn67a/qKd3NQQlVPjy5MbIvu7YCPeag3Ie
         AquqreQEiBzdhRHOGdY5Mw8zVbUX7x0btfHoiVyYJBxtZqTbB2qlafODGLIojlBiaaxl
         4SINX2q5QB+Qy7keXxi5MWjjUh0plYp47dTbdUL7aGdVXgO7B0DZakuUI9nVebmtYyTQ
         gKu6/spUUg7hb8ZUDEPkScRqI/ypFLqWYEDkiGZXRNopNhQ7IUpE9bThM6zbIB3pCJzs
         PFvDfWoUrUQ58vtVGSf+NYFQvgwYR3hwPmwBUP6KuN3Bl1RPDit+m/dYKt0SrYiyKlDZ
         dCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465236; x=1787070036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JhsBT4JbHu8Y1LpjWeHwh/rrcED1LfRchkAqH5o+sQ=;
        b=XOIzuw1+pfx6qqyjx+BeoDH4I7TpgtUcLzDXCBk4XH8kDXBKYJCA6wPcOuiumF6XAd
         q8aLGKpqOUQddkSfucuW/7L4TYGsKGLukWCAzuAfAEeIjwZ19jFJA1MRaEmLfy7Cow5u
         FGwMJyY2BSaC4+5O1N9mUIsQfRSAuC6HsbcwL68PftLYLM0NKX7fen7lPhcOXQL4nkQg
         mZRE1aBpCt5vW8NKOrX8HdxVZvZXfnsd8ZI7MVjM+udwiXhkx4cCPAHr8Jp7RJNt5Qwf
         +IjVk5mDAF330DIVCJiq4mXbE+kewxs2W/CZxO+rF4iIe9EP7xHs5fqLeqknTIfBcEfw
         MQRw==
X-Forwarded-Encrypted: i=1; AHgh+RpIUfzB2oXFyac1ytMYq0hyrT8P+E0y6XjzM3zj0tkt6DVIVzUbPyBA9n/khm+5HznLKvk65lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9zeZKWC+hy3LT7euf70luha2E/1kThbQYD5zaQSFYKLVFwl0
	e7uOb62Uyv8aRKyZWjz97kyCej+8SLpXxcopFllCsjs1n/HhYO1jDhps
X-Gm-Gg: AR+sD12Jgxitf3IgTrua8BJ+Vs8eo+GY9gqX1u+5kHXQ3V0tsVHyeN8lVjJtzx/EcPx
	my59IWgs3cq81Vr5GwceDwmDkWi55dB2kxaXZkFAdyNh/SVb4THoYzGN7X8QwBcYh7lPxfUQxGD
	i5prkKxpm6NlckLqcnlTBkEJDXsI3JnAwcs184FjHZ4DLYL1pqX6xMTrlVzMin+ixvsSlKfz1VL
	YZPbVJW5jvoB82nnqB7Uji0nlw2ykhXaEDoU1o/sJcmB2/IWcAP88VTdIWVCQBf8XP/eBadXcBB
	GMXFuozLKwmBtafiYZS6aEOeujZNqyyLzXuc0mH6FaprzvsdWeaxqmFnyK2FSphkF9RnoMuMslc
	73bUWe2X6bd4QE4hh2p4K0xrdDjQuO5m+aeqsoETSbUps+6otBTHqfz7EN+HGrdz10zsdDvHqoD
	fRKVlH12M1jnRo3FXy/iWK+j+1DDqT0Y2NHvfDMCFO7h+cq4/7uUD8SO7c0CCnHMOYt025IfrcK
	wxRe2+Dc04=
X-Received: by 2002:a17:903:1ac3:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d317776218mr62738265ad.1.1786465235483;
        Tue, 11 Aug 2026 09:20:35 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f30027sm10547465ad.25.2026.08.11.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:20:35 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/pagewalk: fix stale walk->action escaping walk_pmd_range()
Date: Wed, 12 Aug 2026 01:18:57 +0900
Message-ID: <20260811161949.3879321-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811161949.3879321-1-imv4bel@gmail.com>
References: <20260811161949.3879321-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ->pmd_entry() sets walk->action = ACTION_AGAIN, the pmd_none()
check is retried. The PMD entry may be cleared at the point of retry.

In this case, if walk->ops->install_pte is not specified, the code
continues to the next PMD entry in the range without resetting
walk->action to ACTION_SUBTREE.

This leaves walk->action erroneously set to ACTION_AGAIN, which is
incorrect.

This was incorrect but not problematic up until commit 3b89863c3fa4
("mm/pagewalk: fix race between concurrent split and refault")
which updated walk_pud_range() to check for walk->action ==
ACTION_AGAIN upon walk_pmd_range()'s return, causing the PUD walk
to be retried.

In this case this results in duplicate walk callbacks being
invoked, which is erroneous and will break any caller that is not
idempotent with respect to this (and waste time for those which
are).

A specific example of this breaking things is mincore which walks
an internal cursor data structure a byte at a time on assumption
that page table entry callbacks are called only once for each
entry.

Fix the problem by resetting walk->action to ACTION_SUBTREE prior
to the none check.

The pattern also exists in walk_pud_range() so fix it there too.

This issue was found through AI-based fuzzing.

Fixes: 3b89863c3fa4 ("mm/pagewalk: fix race between concurrent split and refault")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 mm/pagewalk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5d87c632a25507..d3bfece3193366 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -126,6 +126,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd = pmd_offset(pud, addr);
 	do {
 again:
+		walk->action = ACTION_SUBTREE;
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
 			if (has_install)
@@ -138,8 +139,6 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				continue;
 		}
 
-		walk->action = ACTION_SUBTREE;
-
 		/*
 		 * This implies that each ->pmd_entry() handler
 		 * needs to know about pmd_trans_huge() pmds
@@ -196,6 +195,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud = pud_offset(p4d, addr);
 	do {
  again:
+		walk->action = ACTION_SUBTREE;
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
 			if (has_install)
@@ -208,8 +208,6 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 				continue;
 		}
 
-		walk->action = ACTION_SUBTREE;
-
 		if (ops->pud_entry)
 			err = ops->pud_entry(pud, addr, next, walk);
 		if (err)
-- 
2.43.0

