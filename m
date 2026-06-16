Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A953CF943;
	Tue, 16 Jun 2026 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638784; cv=none; b=Ip0VrYDqzavoFb+9VPlp3ER4b7w1iwJFLgin8koQWApaKTTcnpioEOtQvYYX2rDtX/qXhgRcZ5Bw9g9VyjvFIWwgkTryTX6nk3CkevBL1YqpA+fuUtJYq7tpjnAyo0Pof/UMRmHrBBcHu48l2KIIutRRWL8364rGySLfWa+idcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638784; c=relaxed/simple;
	bh=Q2ikB1r2NxRfwBGkiSdGMjOKzSogcZ7DUPodQQOXy1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGvn7Zw0BwBDGdfW5BDJH/mkqKRZivr8DVbU1wNLMqrgNwkXbHeZmNoQr0K3jzPSoG8DAN/IjIzA3FmX4dWRITgXPKL1yiyGgeyIuDgqSx3fVtt7afyX4E4XFPcwwcwV/PGZVykUEwaHrEBQ3gb88MLfHpwkEvv5WsMGtp547aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nz5ysZFx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nz5ysZFx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=25EV8+cd30BCeMpggJSyntHwUrkjR4MOGFomUCaILko=; b=Nz5ysZFx7oRrJ8mgZA+/6ui/Xw
	P0hAPmCKcZBs3kcp7O8LwIRtRku80y56umzhAP3vJKjDZyF0/cm6mxFu31WWvIIWM9R5Bmuf3xHW3
	YjkIUsXMGTVpPOVbfRMyTjjj46B8V3kjCg547TNn5LhLweXVYWUnjRyf1YJCaRDb+g3P1K78MdYXL
	tS1u3xY4t7SKKFcooshoO5NElFv0TzwBm9MrXLVqu0buXPkZpILXsGf7nDaDUt5xdvbyi30+oU8Bi
	0YpMh/GvW/gBWdXWV4utHK6gxa1mvQv4TWwo6Y2UUzF3p0cTdMoxYffKxTnd17LbhZ95Ah0Zw1wjc
	AhCftxQA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZZdC-0000000GFwq-0yxY;
	Tue, 16 Jun 2026 19:39:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
Date: Tue, 16 Jun 2026 12:39:29 -0700
Message-ID: <20260616193929.2394119-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
the kernel-doc to indicate that it is optional. This avoids kernel-doc
warnings:

WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'

Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org

 include/linux/slab.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260615.orig/include/linux/slab.h
+++ linux-next-20260615/include/linux/slab.h
@@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
@@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * kmalloc_objs - Allocate an array of the given type
  * @VAR_OR_TYPE: Variable or type to allocate an array of.
  * @COUNT: How many elements in the array.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
@@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
  * @FAM: The name of the flexible array member of the structure.
  * @COUNT: How many flexible array member elements are desired.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
  * failure. If @FAM has been annotated with __counted_by(), the allocation
