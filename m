Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394258;
	b=5Voq6MvLGkVR/5jDD/f8vBnu/5lONAvKuBM8MWyATVxAF+qQ4gKpHvEv5NXQCuqMFga5
	 8xv3ZAXYkhNzAD4TCdrmE6TxNSLzzp9vrYEKR+EfhZN36nBJPtAJuE55P/0HbG3of2L3Q
	 Lw7p/d7ZKWqIK9XL69NnJHaBxmp05V8nA+j5ieFmsbYQ8xu0kwf51ljwRK6PAevZhVBNj
	 SyaqNu7a8ECn5eiQtr4CsO6Y4t0746BOt7fraIYVMbiGkSOlUHcqGKr/cRj/Vw6EAMP43
	 M2+USStUINytSCV2PNjT0X1O4GcPRyPz7bOkJE2eNl48+cXCaqXWVYtmIqG7WSpgbPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394258;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PEYuOa/9767xWX+f2DNrCoeLZWRrq8m8846MW6tQS3M=;
	b=1A5o2GRJo0kdT6jQ6YTXKIpXljUX2sJuJ4hy8AwK18bzgG89XnW5Unp07QRyPosp6Vad
	 BmvGf3iUp++Rs5Qo1IANH7JqiBZQQuV+EefAoTvZqY0RaZS8iRyxTnubRzlKbQhg4c7aV
	 CGJDWJCnea09yVgvEw1wvinbHwiaO0lyQWHGapdDVuW5xaZPWBafGDwhRt57Fpfwl4hZi
	 PmqCKDSsMjhHt1ACq+W1JcNUtcNyA3eQ5t5EyERk7+IS3c6h9kTPmYMr97w5VWb4Xw8B5
	 mR6i9wmSdteTWo8np49nZAO+RPXc4t7HfKnW1Pj1ViJb+38GFidFTqCXhQYGuEXLIGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j8UABcwo;
	arc=none smtp.remote-ip=91.218.175.17
Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j8UABcwo
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D1hu3VQU+f5wvH+ClC4RWgl8z8l6F/fNjdDCG5BLA50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794394255; v=1; x=1794999055;
 b=j8UABcwoX4oMu9kJQHFphoZluXFf54kpLm7Yt8i3XWiGjQ4VT3iTb9yp2NrIxyAbtemJp5JS
 5wnRacue7jXLe3YrHk4aNnCwV6huSmFmI18jiuocC7Ufd8nZjXw55XkNt3swFOsa4FwMhvDD8tH
 ht3JOe7ak3HKgSfKQ0gJYSIM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0d447f2c1092519e;
	Wed, 11 Nov 2026 10:50:55 +0000
X-Mizu-Trace-ID: 0d447f2c1092519e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 6.1.y 1/3] mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
Date: Wed, 11 Nov 2026 18:50:32 +0800
Message-ID: <20261111105034.51632-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261111105034.51632-1-lance.yang@linux.dev>
References: <20261109201707-failed-6.1-990d6c2194a9@kernel.org>
 <20261111105034.51632-1-lance.yang@linux.dev>
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

From: David Hildenbrand <david@redhat.com>

Now that GUP no longer requires VM_FAULT_WRITE, break_ksm() is the sole
remaining user of VM_FAULT_WRITE.  As we also want to stop triggering a
fake write fault and instead use FAULT_FLAG_UNSHARE -- similar to
GUP-triggered unsharing when taking a R/O pin on a shared anonymous page
(including KSM pages), let's stop relying on VM_FAULT_WRITE.

Let's rework break_ksm() to not rely on the return value of
handle_mm_fault() anymore to figure out whether COW-breaking was
successful.  Simply perform another follow_page() lookup to verify the
result.

While this makes break_ksm() slightly less efficient, we can simplify
handle_mm_fault() a little and easily switch to FAULT_FLAG_UNSHARE without
introducing similar KSM-specific behavior for FAULT_FLAG_UNSHARE.

In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
a performance degradation of ~4% -- 5% (old: ~5250 MiB/s, new: ~5010
MiB/s).

I don't think that we particularly care about that performance drop when
unmerging.  If it ever turns out to be an actual performance issue, we can
think about a better alternative for FAULT_FLAG_UNSHARE -- let's just keep
it simple for now.

Link: https://lkml.kernel.org/r/20221021101141.84170-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

(cherry picked from commit 58f595c6659198e1ad0ed431a408ddd79b21e579)
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/ksm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 616a8f7c5c60..9a050fa88b85 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -441,26 +441,27 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 	vm_fault_t ret = 0;
 
 	do {
+		bool ksm_page = false;
+
 		cond_resched();
 		page = follow_page(vma, addr,
 				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
 		if (IS_ERR_OR_NULL(page))
 			break;
 		if (PageKsm(page))
-			ret = handle_mm_fault(vma, addr,
-					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
-					      NULL);
-		else
-			ret = VM_FAULT_WRITE;
+			ksm_page = true;
 		put_page(page);
-	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
+
+		if (!ksm_page)
+			return 0;
+		ret = handle_mm_fault(vma, addr,
+				      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+				      NULL);
+	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
-	 * We must loop because handle_mm_fault() may back out if there's
-	 * any difficulty e.g. if pte accessed bit gets updated concurrently.
-	 *
-	 * VM_FAULT_WRITE is what we have been hoping for: it indicates that
-	 * COW has been broken, even if the vma does not permit VM_WRITE;
-	 * but note that a concurrent fault might break PageKsm for us.
+	 * We must loop until we no longer find a KSM page because
+	 * handle_mm_fault() may back out if there's any difficulty e.g. if
+	 * pte accessed bit gets updated concurrently.
 	 *
 	 * VM_FAULT_SIGBUS could occur if we race with truncation of the
 	 * backing file, which also invalidates anonymous pages: that's
-- 
2.49.0

