Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037331;
	b=W3X1zlJL6JnPEJQW9lR1WZhCXL/xeumdD5QUSJNBBBbhZMmYSJGwGL+eLVt12f3X3ZCw
	 9GMIaLEKhWBPhjxnGm/wYupr3w1O5GaYySr1zmiMTpzBs6JCWtbZv63uz1OKaYTr4w4sY
	 +bGDjNGj7jiLNDrYM8BbxKnHWX78wy4FPsyJPseaByr01TJzeaC6t7A7lkv2mDhMgWOBH
	 7PHdV+AoFm+5xQEdj9bgOKepoU87wjTU/CmqcpWsMBcZ4ZGLq0ymBco9QizTUnC9VdiW4
	 IbHCBHdAhBHqOGdgOyagAgorOEKw3wlz4ctwbxs2dJxeOnZ943hTTGfhZuJsScZb1kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wFYUOJj2+7G2v/k9lLyOgh0sZkoos/zK1jWHhTk0qZ4=;
	b=Mr+8emNatHtsKYGdC/ELBWHOQSm4pl0a7qxKXDFayBQX+YrsNbUzXrVv8PgLp6Ve9X8r
	 Dj7B9jHHbC12uKC8qTb93jiyOgqvPfmevjwwe90E5y4+HxxbOV+wwO/jDAJprd6fC0qYL
	 TOGzH/7RGsMg7GW0ZkeqVy3PTk1MxQCO+qF2nCj0NxosqBHHr4tHqIVaCxlUJ/6DUtDQD
	 45v7k92OcCoWU9cL8JVS7mXXtmRX5KdYmVlGKJX/JXyjQO6HZGxNxWXidm0SQXWO94X87
	 qKr4gPLLdz06MwXUU2k++bp4Pk2goaCpx4zoYWUDvHlI8qHVosIhQ//mE7p2cjrm8Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i0+5sRpk;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE060A2603
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78BE060A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i0+5sRpk
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38131260a5dso3948873eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795037330; x=1795642130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFYUOJj2+7G2v/k9lLyOgh0sZkoos/zK1jWHhTk0qZ4=;
        b=i0+5sRpkohQP+5U7vrew4LDud8Dd2jcenAJMqpPRkaPjg7EI4socU7IdcqcoMCFlux
         KeoOGznqTqeDv1AWJX/5yRNzpQBlKpHfATY21bSjCPumofg6Zv3i/U5jYfyEAwqI9EH2
         6xyLsT2mOHHn6NYsrRAxcmEYKXLZ+cfZAEEo8xOw6gs1fNuRyVgTwf6kckFg3hgx6M4f
         95913Vb4GBf1DW1w96HP+7W7v6YnwyRvCXM0Ltwr9TDkmdS15bQcaklFfOExOM7yfGmj
         eYpPiVe7lHct0MuX/O3KdxRWHMoiO0m4a1Lo8EJPtKuTB1BBfe2LrNk25OCMsmMpbAnO
         M7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037330; x=1795642130;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFYUOJj2+7G2v/k9lLyOgh0sZkoos/zK1jWHhTk0qZ4=;
        b=g5jBPtSAWl+v1dRo2x2/TKLEo5qWtG0Frz0qhpm44tnG4nWMroaVHwAxLv9uQcdq+S
         BK+hYNnHemPTuXUnutHTZwHDAQtWfzUnTZ3M9c75RWj7VX7CO29s+HVegmCOdIoNJSKk
         n76dGDrKTDPDWuDTLKbBFmImLqLQfLoRHY4F281jZlYDWZggq3141X4GwNiNIXerbOAH
         8S9ZB/2+2VMETnw/XdTnD0NBAfirmhd7+/g1M4ZobiHwqYYiZh6ROUh+d0hGrMGKzdxO
         8iVSlrnDxWbB68qJkAOqygD7T+YTTHPPa8rummHRGyqWmRiwQDV76PAxfx7Z+itgMEfI
         gjJw==
X-Forwarded-Encrypted: i=1; AL+hErGCOkJquUmirPqxufNIQhtapM6kDPFoX4kOGWz5l7LnufQuAwQB/i+9jhZVRwDW+Mb6Zu1LZzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EeE5GBx8/9QAA1OBjKEhxpouvXUxoxXGRnuDunawXxGsETwfK
	nI7M4EdFBsAuZhrvMqvYXWLFPKpLo2itAMwg4rtaTUVoaNId69DkSwRN/RgvpM+UTHc++e1q4ja
	gZn8GAJSgl2I6f+hjwui7sQ==
X-Received: from dlcio6.prod.google.com ([2002:a05:7023:c006:b0:196:8199:c26c])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7f02:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b543c38731mr3242553c88.1.1795037330212;
 Wed, 18 Nov 2026 13:28:50 -0800 (PST)
Date: Wed, 18 Nov 2026 13:28:19 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118212819.403059-1-nilayvaish@google.com>
Subject: [PATCH] mm/page_owner: fix double decrement of stack count on unpoison
From: Nilay Vaish <nilayvaish@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Nilay Vaish <nilayvaish@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

page_owner counts, for each allocation stack, how many pages allocated
from that stack are still in use. The count is incremented when a page
is allocated and decremented in __reset_page_owner() when it is freed.

A page that is hwpoisoned while in use and later unpoisoned passes
through free_pages_prepare() twice:

  1. On poisoning, the last reference is dropped. free_pages_prepare()
     calls reset_page_owner() but, because the page is PageHWPoison(),
     keeps it off the free lists.

  2. On unpoisoning, unpoison_memory() drops the poison reference and
     free_pages_prepare() calls reset_page_owner() again, this time
     really freeing the page.

__reset_page_owner() decrements the stack count both times, although
the page was allocated only once. The first call clears
PAGE_EXT_OWNER_ALLOCATED, but the second call never checks it.

If this drives the count to zero while the stack is still in use,
stackdepot treats the record as freed and warns on every later
allocation or free that uses the same stack:

  dec_stack_record_count: refcount went to 0 for 92274844 handle
  WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x5c/0x70
  Call Trace:
   __set_page_owner+0x110/0x290
   get_page_from_freelist+0x1225/0x1440
   __alloc_frozen_pages_noprof+0x1fc/0x1b00
   __folio_alloc_noprof+0x12/0xa0
   alloc_migration_target+0x81/0x1e0
   migrate_pages_batch+0x1f2/0x14c0
   migrate_pages+0x9c3/0xca0
   soft_offline_page+0x189/0x570

A single soft offline followed by an unpoison is enough to trigger it,
because the migration-target stack that the offlined page is accounted
to usually has very few pages.

Fix it by decrementing the stack count only if PAGE_EXT_OWNER_ALLOCATED
was still set, i.e. only the first time the page is freed.

To reproduce, boot with page_owner=on and CONFIG_HWPOISON_INJECT, soft
offline anonymous pages with madvise(MADV_SOFT_OFFLINE), and unpoison
each old PFN through debugfs hwpoison/unpoison-pfn. Without this patch
the first cycle prints the message above and 2200 cycles produce 6597
warnings. With it, the same run is clean and all stack counts return
to their initial values.

Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
Cc: stable@vger.kernel.org
Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---
 mm/page_owner.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 02bb304b53cf..0793a460d615 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -320,11 +320,13 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
+	bool allocated;
 
 	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
 
+	allocated = test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 	page_owner = get_page_owner(page_ext);
 	alloc_handle = page_owner->handle;
 	page_ext_put(page_ext);
@@ -339,7 +341,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	__update_page_owner_free_handle(page, handle, order, current->pid,
 					current->tgid, free_ts_nsec);
 
-	if (alloc_handle != early_handle)
+	if (allocated && alloc_handle != early_handle) {
 		/*
 		 * early_handle is being set as a handle for all those
 		 * early allocated pages. See init_pages_in_zone().
@@ -348,6 +350,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		 * their refcount either.
 		 */
 		dec_stack_record_count(alloc_handle, 1 << order);
+	}
 }
 
 noinline void __set_page_owner(struct page *page, unsigned short order,
-- 
2.56.1.708.g77570a6a1d-goog

