Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309875;
	b=W+VKP/jYWW1oQ7u+LddBzigh1xLkbiffWWz329yx0xhVxWjBVVNH/uyKAdq9BKe/5YnI
	 32kfI8UrFTNZ0lEDYj2Bbm/8FyMT3EG/AjIRPsn6e5815cc7MWuXXuIWbp8stiCge2hQm
	 1js0/bM6xFKPeDPyNbv0t8IkMA3HULVAIeUBrjHilD1A98TZDv15YwmmoT1/Qfy1P5d/I
	 YSguZLy3LRFF8Fy72QTNFVP7ZT4p/GFd397rc5w9/dL2w12ccDru5sU3vkgaxY/fhTX4W
	 bY3BJbtFbtuJvA2IaFy/5Bbuof+wO0b6Yr640FD/1FizoM4lKddhyOrruX6SlU1J+rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309875;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6ZVwT9JPvcRTq2+d66tI0z/MQ/l0urBNTSlvpkLaL2M=;
	b=hktNhNb9L1DFZFI2XFQSf36DtgVWFOnWZEH1AnNZ+eXOGroReCMtZFuu4WyZ0UzNrjUU
	 LyIFRfRXg5XlhoIqhFUor/yVRHwTWuyCYVY0/CDKpkS2sglqJoMiuvaUBE1S6H9aUB7/x
	 uadOtEEb9MrBNISHUg4lP+AFuvA3wBI3QLz3xX4/AfPIPfRfVnE0kiWR1Qb72hS2Hu8bv
	 ajuAcxvDfV+Io0gpzBV5kYb4s9NlFkKJd8xh7zBiMORGBjD2SnKJrII8qUfcPlT2H14fF
	 W36t6nYfTnyip7/A/qfcFv05pdG0KlfTXLmgXifpxxOm51nYFtj4yQHRdwz2oSkamAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d42QnZwE;
	arc=none smtp.remote-ip=95.215.58.71
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B19606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B19606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d42QnZwE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jkqaTN7aNaAhIxRpBgAN2fcj9pQU8jMWqyvdyAyPO+g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309872; v=1; x=1794914672;
 b=d42QnZwE/WUex9hyCFK+onRk/zm7eIFT8JL5ZzEBQjF6wv/5LUNkcW1452q7+jBGpM/61zy8
 2qFjJD3ycPtGdP2Xu80odf+Qi8AJqkOVIRJjw1M7QfoacnfSGPaHXvRiIZR7lhUddg/s8e1KheQ
 ZcmADtPZGwdbi19tOnzD2V9Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 272fed88d5b8e528;
	Tue, 10 Nov 2026 11:24:32 +0000
X-Mizu-Trace-ID: 272fed88d5b8e528
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin mapping fails
Date: Tue, 10 Nov 2026 19:25:38 +0800
Message-Id: <20261110112546.261415-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261110112546.261415-1-hao.ge@linux.dev>
References: <20261110112546.261415-1-hao.ge@linux.dev>
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
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/shadow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 0c88d89bf0d6..2166086d3dc3 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 					    o_pages, page_shift);
 	kmsan_leave_runtime();
 	if (mapped) {
+		/* Undo the shadow mapping set up above. */
+		kmsan_enter_runtime();
+		__vunmap_range_noflush(shadow_start, shadow_end);
+		kmsan_leave_runtime();
 		err = mapped;
 		goto ret;
 	}
-- 
2.25.1

