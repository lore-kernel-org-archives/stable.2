Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430637;
	b=dj94GIq+6zQvl8wFFE9NHyCRDaKLGp5957mMvvrQc0ZbXIKXJEcgLb8w/9wL7MlrtsEZ
	 IzMJbF5y1t/89d1JWryL8G4Jm9F6cIDJeScZ2UdQp9znm3a67iontmIWClSgefs1sCRPX
	 LT7ZCATzVq22iQqWX0+Da5/OFgUDStrqY/iZJ/XrPcDj7CFo5JiuzNPDNaBp3GaC2GkqL
	 u+jq6STbV49TMxetB7RS/GvTRNEL59mA7iDROrg4UwkTrHQnjBOtAAQwgeR7La0DO3/Z+
	 J2uBkQH+Xp46ONVVELG0dL43heOVdszwtLWUuvQbV/NvDchcHuQd9PhYQ8+sl7xjE1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hr7mK0JGcf/BTvqE/DMHAbCOD5CXN72ZoZsomAZGCDQ=;
	b=brGEdODszuJw6o7L4Be3KFk7DE1+tZ7dhkoejhl1Dio9SeoeXyzXk2VzLEV5Yb1ZRQby
	 1XRX5TnSVZiO/D39olRqTf8ZOlTU1zchH6t2EbvyQgEO6KgTNjefbAGeqxUaNm2CA/vEn
	 CNGsdF4RoasdtKiKFOJ7bV8yRKk5HNB8I+apBvLGQeAyTGRbJ3GmC+RzJ6TvnfPik8Hmm
	 hCFZJQyQ3bTlkbIH+/Xtbbfq4cnAB8Ukv82cuChkMu3DARu0y/ovrh0GY7vFD2eqOlbWu
	 3cEPw5rbGG9B0+scJ8xRINZBV1V9w8wl4ZdtF6UZvJgwSi8Fwu83Ki6NvqRZHziQklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CLxc+yKE;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782D60A2614
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4782D60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CLxc+yKE
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f36c18b75so117214485a.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792430636; x=1793035436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hr7mK0JGcf/BTvqE/DMHAbCOD5CXN72ZoZsomAZGCDQ=;
        b=CLxc+yKE135AENhgrrycENbP8CNsEdDhb8Z5bxnyCuA02RPuWUWc7NM9oDB42k7lFO
         P+WDJfe8WXhZ8FPwxvcRBEH/37Km1pIddOHmyC4Zla/k+IgZuM8kFF4ZS4sGYZ7dhpi3
         vxgrqT9U2BohPuCeWkRlMouJgaJjP8OEq2SvQRwqziTJURnmL2X29MDltSow89gpsPyQ
         ygVvxjGdhkRndWfiMnvEYci4rrDP9t+a/3IHOj608e5d9u/jtTxTAb2dVyqV12/IAI7U
         iVgwLiCZHrvbwdqvsqUpYGkp92FDR8RVtB9vuAaSPXcF8e5oGSjo1LBFPtEqNaSZImeq
         HwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430636; x=1793035436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hr7mK0JGcf/BTvqE/DMHAbCOD5CXN72ZoZsomAZGCDQ=;
        b=kLTBOx89/CcXg9/aqYRxBB1KfVaH05oGlJGFwFAPaipm7FmiPuM+6aUlcDv8UFKhi1
         1LXJjtQqOeNN2VZcV9yXakjhogvdzCgeQOb3j1mxwWmTEXJrwW6abHJ2/myTpAN4aqVr
         lctsJLCF+8vkSozgxBpv4iNLmvD8x3wGqB3pyM9xHTZdpmGj8ODIY6JcCMGhRsXwKs3O
         Usou6D+nzdQsWgI29hhWJ6QW46rpYS336jbgHSjeG36Z5V2tIAf20/+CkmKK24s0bNqM
         rh71qtiGectYH8/PRGqX0i5bGHjbjR/B+kCQ6JPDB7LCKfxnQuMgTwUJ63eoxlIbaKH8
         xvDw==
X-Forwarded-Encrypted: i=1; AKwUvBztkS3Z9eZcqAaOoNOO3z16TRW8sP/xVSNYSwykuQ90/71REWxBHZV0xOlZ3mUqKP33VZqGDrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYILE1t1wPnXR1SL3wL6NzUGtsjyw8F4tOu+XMoho8Mig3vtLs4Z
	hVIoN2ET90Z4u7OfCwX12S9ljuCj2FpTVrIVAL9zDfAeQUw6bWx1P7/eu5N5x0AIpbA=
X-Gm-Gg: AYBFou2KvqlBCF5sHzWkE4xyWTXor1BKhU4Hve/J/ZLSLuNzFIAhFvDfMcNYiqnokCi
	tDaQHMA2C/xIfUicO5iPXvFnlFqAC8oFJBtQXrOwUFPcBSlZjo93grMeeRnsuGi+VlgN7kbUk/Z
	fvOTHOJhjKdWVbNYH4bstdh5RwTuGLic0AwNMbD9QKjl5No1cupVl7+FW22pKOFjiWCVxolzXKc
	aaJD2Bx1DyJupcWTZ9KAEimNjF2w66bDzX7twi6fGxaMduKKe2lchjf0wmwBEja5EzXmDwFvDi3
	Lq3wRvCUFZZH9lLA7hEr+NqgIXLx1odL3y8FBJZL8/2Jh57Teok+zemllLTfmApEk6IbWy8k0oI
	E+uOqsLxsmQ8xA13TdLEWPK3mdm08PupET9rTIInKGsfacvv5qGC/YSpPbr1jwXz3HsWuliCefK
	VfyadRGrT1SxREMmrEKnI5zuoAC5cSyq78d70YyARywmyGe/UQBKPrN1NolXo277/8R/JjlfAcp
	y6OG0jkkNN7kA4cCCTWbtXODYpqNGi0kywzFYhM0XlFHftUGNNePGcSauWH
X-Received: by 2002:a05:620a:1d0d:b0:93f:3bb5:545c with SMTP id af79cd13be357-93f3bb558c1mr691193385a.18.1792430636279;
        Mon, 19 Oct 2026 10:23:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4adb28c2sm14615385a.0.2026.10.19.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:23:55 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	jiang.liu@huawei.com,
	Bessel.Wang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] mm/page_alloc: keep a zone's pagesets when it goes empty
Date: Mon, 19 Oct 2026 13:23:44 -0400
Message-ID: <20261019172346.3344005-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019172346.3344005-1-gourry@gourry.net>
References: <20261019172346.3344005-1-gourry@gourry.net>
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

When offlining empties a zone, zone_pcp_reset() frees its pagesets while
the vmstat worker can still hold one across cond_resched():

  CPU 0                             CPU 1
  refresh_cpu_vm_stats()
    pcp = zone->per_cpu_pageset
    cond_resched()
                                    offline_pages()
                                      zone_pcp_reset()
                                        free_percpu(zone->per_cpu_pageset)
    decay_pcp_high(zone, this_cpu_ptr(pcp))

decay_pcp_high() then reads, and can write, memory the percpu allocator
may already have handed out again. With kprobes holding the worker
across the offline, it rewrote a new allocation at the freed address in
2 of 3 runs.

Keep the pagesets for the life of the zone, as pgdat->per_cpu_nodestats
already is, and only fold the stats in zone_pcp_reset().

Commit 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes
empty") freed them because onlining the zone again allocated a new set
and leaked the old one. setup_zone_pageset() now reuses the existing
set, and zone_pcp_init() keeps it when the node is re-added, so nothing
is allocated twice. The pageset address stayed the same across repeated
offline/online cycles and across removing and re-adding the node.

The pagesets take 320 bytes per possible CPU: 30KiB per zone with 96
CPUs, 160KiB with 512 and 2.5MiB with 8192. A populated zone already
holds this memory, we just no longer give it back on offline.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 75a440ebcead6..417c427b196d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6356,6 +6356,12 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* Reuse the pagesets zone_pcp_reset() kept. */
+	if (zone->per_cpu_pageset != &boot_pageset) {
+		zone_set_pageset_high_and_batch(zone, 0);
+		return;
+	}
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6452,9 +6458,12 @@ __meminit void zone_pcp_init(struct zone *zone)
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
 	 * offset of a (static) per cpu variable into the per cpu area.
+	 * A re-added node keeps the pagesets zone_pcp_reset() kept.
 	 */
-	zone->per_cpu_pageset = &boot_pageset;
-	zone->per_cpu_zonestats = &boot_zonestats;
+	if (!zone->per_cpu_pageset || zone->per_cpu_pageset == &boot_pageset) {
+		zone->per_cpu_pageset = &boot_pageset;
+		zone->per_cpu_zonestats = &boot_zonestats;
+	}
 	zone->pageset_high_min = BOOT_PAGESET_HIGH;
 	zone->pageset_high_max = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
@@ -7728,6 +7737,10 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * Keep the pagesets of an emptied zone: refresh_cpu_vm_stats() can hold
+ * one across cond_resched(), and nothing waits for it to let go.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7738,12 +7751,6 @@ void zone_pcp_reset(struct zone *zone)
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->per_cpu_pageset);
-		zone->per_cpu_pageset = &boot_pageset;
-		if (zone->per_cpu_zonestats != &boot_zonestats) {
-			free_percpu(zone->per_cpu_zonestats);
-			zone->per_cpu_zonestats = &boot_zonestats;
-		}
 	}
 }
 
-- 
2.53.0-Meta

