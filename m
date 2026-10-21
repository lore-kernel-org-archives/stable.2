Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550400;
	b=r+KPVY0XVCDsYA1jfEOkgrgQB16Hxp/6eae+iZS/19hvvQVGJH3T427z4eOXcxO60JHE
	 ff1t/htRPX90d/UB1PKnlwlypBOzggKltRK+OL5bLJnD2A2E42PVBKk1CCvow2u35W2C/
	 mQKONd7vj79i9YtODI/AzVlrG6kXn2GLIG5tBV5zMtNmqNEeIrV66rLyVbVtHFicQXyos
	 8q7UajlJ73JupWUU79PXVLJ4NA+S9UuhvWxNdZlgS0i0EKGTs+7eNUoNpdY2myI2BPDc4
	 RvwniRbTpTmUe4nqfXVsQKPNZ8MX7lM7Y2UEzPm1ZKsYyIJ7vQ0jx0iKVXHyAzIn9Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
	b=5SuHpT60xRc9iIWAl6WLLLwQezwAuc5cJCSo5yrBdO9PXW9ZvJISJxfxX36UYBlExcaX
	 BSKZqYX9uhonbukSEzgjhkJGDbsCt6GKuYlHZLqxDYG28SsbVmvHIIbTL2dADrvBlFSAu
	 57sqWuXSqMNeF34CKmd6I/2UpTi0S/jdbNDTbsJelpWabnpv7GmxKI/MHfNWqrAWISXEO
	 9SdjTEK+PpTZAcd82YZhaVc1DfwSEs1Wr1zBq2ub1tuapU1FmVG/U7YhiQEzcsqUjPYJZ
	 XfLXTeCzausSyeFMirFGUORNc3NYBN2PSGK441+ZWTlm3d6tuQd+s02EcA1dIq6TR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sdrXFa1x;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAC60A262A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBAC60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sdrXFa1x
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e64d52949so25157785a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550399; x=1793155199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=sdrXFa1xLhvIReq0kw4CbXCZJcV4vwN9Cdl2Lfxt5cMVxYojNvyfava1FDldns2RkZ
         ezXEEqGOT+9F/nekjNoyU8Wz+hF3DEhVETvlRSsioDWxSsMaOMnjH2dyz1IM59kg3xxz
         s7KcqE1tEin89Dnr86ypQ1UOW42bzFF856AYOahJZWvg2kG/xiNcmWJF0I8kFZAiLuVK
         CxfeFSf6jO1LAuZRq1HtTDW1/4ncDhTlsemBl+P63gDuV7YR3Mflg+PCZL+InLftYvIW
         u/ELWKZnlcmjIfgviPbQyn9TP1UEVrcbRh2AP5F1tMafZJNXA+nMW5UVUBuLIVSVUxC3
         DmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550399; x=1793155199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=k0DKqY7GQYJ5r3ospx7WoytDS0X0N6JEjYYEYpeMw44BMe+5141q7OE8FFOIeG61M7
         GLl0EWk9CaKSy33JASJIjfFByKoyBWLTuwQkfJ9fu+mWvx0V/wxWG7+pMfdp0/0X2+su
         eONV06EGc6F74Qi72hBIJXe9MFQTxiSIAuC1+aaq5ujKoYr0hpITk5RiWDEddjC0atl+
         /0ozmi1BqT5+zYPQMm2QjgoCqlb2NJXXkmePb+5cIC3nrYtV/2I4Rvp7MYxFdpv1g2JS
         UGi1T1W7pSNNgmsQIRwcmjDWFeAvvlXfZ6i/yxBsBMyPmz6K7JmiNJ8YxTbIYqCafMg/
         6wrw==
X-Forwarded-Encrypted: i=1; AKwUvBzdLlwXAj70A2SUgkD8sAxPNDCWokpEX4TQaPYW9gSqRcdKviOeTHULFkQHW/c3cTZoSDSkYvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqa5Axt9V0i9CjztcDNMddVW5FheO4OrPVrCA4RDLthg/+/zsE
	nmitAi7DDwZjvu7Zc7FRLrGo3NRmnDEjEguKIyNlrhzEGAlJgUO9lL+OiFAL0Cz4dNo=
X-Gm-Gg: AYBFou3TXvqTr1a6Yrmcp+RuXyR/1nyHY1RejZhGH6yRW94hhCPgMkXoty3/5nmTYS4
	1qqgoq/C+CcnRx59nsMPIpFtHKHRlSxsHJqiGLLuX6DLYSUrxN7LIa97LwGuWF29vcsPs/TKv8z
	0xqX7aNrDKgpescSSKKXuOr5Xu+RMDS/XYNaaQN75Tzh6mON6yzhHm5416cNj+4M3FFeupiHwtV
	IKJ0IV0R1ptnZxeviVGvq6mm+pedld5P+TCn304RI2dpfFWhcxJNjLQ+BaGJFonWvR4jRQRcrfa
	tjMYb6Mhp83GJexxV1kyCMK9d6h0x63FmH0UQ61aoX/n5GroZMJtusHiHhDLqO9X2HS3lXIVHis
	FrtywBIcOm5mdBq+6Jl/Mv8phTN0/OAJn2DYLpVDHSnL2jn96coZxB6Hrkj8pyP4Zu2/dlPPOHO
	ghdZGfoAtV8QYj+0h6AbavDeJFX0iEF0VgCKdeVr99kDdx5Ite1iC7oN8V0i5Uvyc4it91yU0v0
	rrbBrnVPKIUPQb3yZTCJcWXtK3P5UgnXrkrfEzxAS/cjD2CgPxaC6kMOEUolmPPJAlAvBpK71ir
	cSkMTN9HMTdqLUKNH6iWVJt9WIEMXfOgn8dFX6qHww==
X-Received: by 2002:a05:620a:3187:b0:93f:1823:308f with SMTP id af79cd13be357-93f57fe8708mr199104685a.81.1792550398715;
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 8/8] mm/page_alloc: keep a zone's pagesets when it goes empty
Date: Tue, 20 Oct 2026 22:39:40 -0400
Message-ID: <20261021023940.1940971-9-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
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
across the offline, it used the freed pageset in 6 of 6 runs, and
rewrote a new allocation at the freed address in 1 of them.

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
index 96ae09c8099be..dfca77764f1fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6369,6 +6369,12 @@ void __meminit setup_zone_pageset(struct zone *zone)
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
@@ -6465,9 +6471,12 @@ __meminit void zone_pcp_init(struct zone *zone)
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
@@ -7749,6 +7758,10 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * Keep the pagesets of an emptied zone: refresh_cpu_vm_stats() can hold
+ * one across cond_resched(), and nothing waits for it to let go.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7759,12 +7772,6 @@ void zone_pcp_reset(struct zone *zone)
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

