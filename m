Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813230;
	b=aZLJGx7u58IqCe3M2OA4mFxiy8s5ZtujRMebgY8HW6WjN/fQMHDCJBEJM5XFunVHhefp
	 CxmJYTBkA9GKOO6BA7XYbOCAWOlcWyarJm8kCQflo3QcU2NEpxmfy9CsYP3JaOx55/ice
	 XIbUJG4uzqUIA1x5bmB4mTzGMoO5KT7Zf4io1VoZcgmM4ghRiMDBFO+7qAogmXuFWezqS
	 dPB7B4uXRQhiM2W1uNHwIhZ7oD05XSwSRfnCjcupHvxd2YiOMvHgCgGC14rH/t6r0c1vR
	 uNpDwJuEKSc+jeC/7uI7ks9Ivky3PkzCSdcRmqfSRULkZ36EOlYr+sdg8qCHJM+owVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813230;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9qeNI2RHXZCXvhzDDakVQtkHGPRaeLXMhl6FMpu6bHw=;
	b=XBayS2nZEQNpmfTimYk7JWR1Fa5PGXbFf7rA8hWAPxdEcS/AXkeYCeala47ltN/eAYbG
	 9PF0/CfFSwu3BsVTtYyS4O1rjQUN1hQqv4g9zc3Lfv7MTRpUWans5Lg2+p6ZYzoRA+NxW
	 u2dPaO1fs/Z7wuWyIWXyauyDRNdmWQ+2mh3tTqnGUwHXKdjzb+qrcXDht9CsdZ7iiHZne
	 3xpxpNK2GHttrSZpaBpABADzLiEhxC0XFMCByXfuk2vhkLyBwj+w3GrxYbvGnifxdeEf7
	 MvrYTBZd73mMAFTfsNNWGxlXAjvmgO2CPqwNdJPY1iS7G/H1ggi6Ij25rQJlb48Ak+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nU15+g6Q;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58759606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58759606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nU15+g6Q
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HYLuc3Z03vn3hRM0Gt/LGf7o33deLempu7jZPgTKBzU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813227; v=1; x=1795418027;
 b=nU15+g6Q9HTaGT+miFGfGHMPjGWb7cORDoEa5n5P3MH0yxa9DNG/JyTDSj9BR65gUJ5vob7O
 y5UDPO64mHapryatDOO8bqIaNQvgqYeBr9zvdXwzMcZC6pyCcPzgR39tSCVJ2YJeAsD21ULMd4H
 3y0HAq6MGcSIbAR7cZdqQGI8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0051f0c538c6aaeb;
	Mon, 16 Nov 2026 07:13:47 +0000
X-Mizu-Trace-ID: 0051f0c538c6aaeb
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the origin mapping fails
Date: Mon, 16 Nov 2026 15:13:16 +0800
Message-Id: <20261116071325.263682-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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

kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
the origin pages. If the second mapping fails, the first one is left
mapped, and the callers do not roll it back. The next vmap of the
same metadata range hits the stale PTEs again and fails with a
WARN_ON() and -EBUSY in vmap_pages_pte_range().

Undo the shadow mapping on that error path, the same way
kmsan_ioremap_page_range() cleans up after a partial failure.
__vunmap_range_noflush() only clears the PTEs; nothing has touched
the shadow mapping, so no TLB flush is needed.

Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
Cc: stable@vger.kernel.org
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/shadow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 0c88d89bf0d6..212449db34a1 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 					    o_pages, page_shift);
 	kmsan_leave_runtime();
 	if (mapped) {
+		/* Undo the shadow mapping set up above. */
+		kmsan_enter_runtime();
+		__vunmap_range_noflush(shadow_start, shadow_end,
+				       gfpflags_allow_blocking(gfp_mask));
+		kmsan_leave_runtime();
 		err = mapped;
 		goto ret;
 	}
-- 
2.25.1

