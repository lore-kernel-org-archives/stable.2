Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269430;
	b=BRUeRKhYD8TR0IV72rYJ0KbtAxLsgE8+rT0JmMcSIw//yORsFeemeK9V/2spLLoaD9K8
	 T+p1zqAECMV4QSOa5qSU3sxAnglsoq/r71bM9e0kbxrStNBGUy2PluaqnZ0uGfgG53R9q
	 QFBauFlFhvHKPV2xRMwjHDuxypEpsgXQZuMEZWwEV4Ce4ZljqtZ19hv7EdBkVKYce8DOb
	 DkaXk+hlB7eZQxVONGYNqWE28e4ttOXfLDXbXlNq/sKOZVPGWgtAkXg2b4abXPtllhLBA
	 /+h/8px1rv4xhBp8ODTtBiw94h8bAD1ZjHE9rSZe2B0eQa4srqQBrqHJAHUBor3aFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269430;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=flXfGAwrsvRQqFxg7i12i2Q6DRiEHi6QOFeUIBzYO3M=;
	b=0Xb0ktuH9bVX4yTZ6cyjJzBy4oIbZQGn2UrA787cdWTNdyeQkzXKC1tnPuGyfuCa9P9w
	 adecXo5hOgAtOTUILHj45pua/dwtsR2axbM9dkWoamsS6w+YofsNcJCZ2BETA8oaewrWJ
	 G/d0uEV/TJcKqX/eV1pO8RmlLBk3BeMtYehB/Dupwt1k0IAp7y6YL5fVl0Ra/bCtMRY8n
	 C0K7vy9mb1Op+6LYzb1QdYu0msBOTL27bbi3Tkv9B3NrI4gOLN0AtfIWHwtHskGsZnUsF
	 iar1RhZpnBca0+5VtMR0xtxW/XMANOkfauFW0YvRyG0MSDHkQ4i/YscABntr7zXdxVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ReKS5fet;
	arc=none smtp.remote-ip=91.218.175.213
Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A0606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758A0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ReKS5fet
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JF/D8RER3j1zmKFcbk1qIJYXnZVEOJHJqLvg+3gZSQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795269427; v=1; x=1795874227;
 b=ReKS5fetrF7VrpZXa+2nv29Hrb17KanBq4Ec4d+ycLH+4MWEToPZOyemVYhxSYUejH9FU7a0
 X+/mXMGPcPlqUCzJPOBsrqGrsCW+ypQ084nOCn3A6kIPRkE199AHgsJyhX6sfKl4hmQwE5l/wFv
 odyMepZKXGfWNgXVBTkaSERI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81f4219e2e02748c;
	Sat, 21 Nov 2026 13:57:07 +0000
X-Mizu-Trace-ID: 81f4219e2e02748c
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
Subject: [PATCH 6.1.y v2 1/3] mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
Date: Sat, 21 Nov 2026 21:56:51 +0800
Message-ID: <20261121135653.3466-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261121135653.3466-1-lance.yang@linux.dev>
References: <20261111105034.51632-1-lance.yang@linux.dev>
 <20261121135653.3466-1-lance.yang@linux.dev>
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
index 22b991218f40..b35485868d5b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -442,26 +442,27 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
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

