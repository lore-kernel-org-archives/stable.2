Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499231;
	b=bFDZVnnxM1yfeCnkQAJTolKmM73C7RlL6R24oJpP0fFM8/pEaQtKmOE940Lj8SGQ00y2
	 WQRoNyU6UqzFrjo3TyLTolqvrNDw3tyyS+pkHVcMTLo15yXmMhb7bnf039Jq5JrAxA7T0
	 XfJ569D4oTSNJ6TfRWMzCW25iVOAknHg9gkFHj87bf3m7ZDo3Y0JVJ8xPmGJ8otz4dRk3
	 VrDdM1PeXle/BhJFGEtWgOfPjsyh/Ss62SNajIuiTdrLAdT+fc3ED/Q+3M8Dhbw9kRED0
	 JwV5Cv+C+DsgMZuIfW1DRSBymCWkt+4QJzfZZwxFuNDw52Fi8u8KpzpbZDKlDa3kmHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
	b=L3GlnfS9kbrWGXHMLjpUH+fJv277WHEb7tmf0NptCdAayTO3EiEOFd83Dnr45Tk/fTOH
	 FtIpRMc6TYs93BDg6DyLUZAq5KZqmxMDxy2Eu6s+1KXCKbmgXYI9bJWlEr4lby3wuAD9L
	 aq209shpj+Rq6GoiArz6w6qx8sPAtd6D7UijI7GD+aDM6rX1bDSGBzCXLsMr1DlxQgIL7
	 NOCk05XdjtuVl+vRPOtU/lz3Z5BJu+WQDMmNm54qCHUKHBxaQ5KUOPoP8486EXXupUYfF
	 QBlsKm8Jgkm/eVYqfpimshAFQ7DlQJvagnnc5h9Cr68OYpl1g2gjEteKOSiwTZoGH/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Lbg2F140;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86B606A33E
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF86B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Lbg2F140
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2b8cf037so169430385a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499230; x=1794104030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
        b=Lbg2F1403q6XpzKwEZAwWFPs42aQyaQYLUByjOB/Ad/EZMXWJ4DhvwRBk8t2MDtp2a
         sg2AnSSfb8cEu9XhQQbNCjBSD9SMY52O5UIrF24IaazQhoDtWU3jSBoBFNftM+MFOlrW
         gvjncfZUmafwmwTflLcOApw9/QBEVYIlMJgsNFwBfcevvLVe1ifR1uhagKmNZYUUoJLb
         SzW0VVjO+3GMQzBqLPc1bLloL3vVSJuPD3mN+fmABkq6X+0NfdYROZIaRb5PMDy0PNEt
         e8xtBlGaYE6Xs0EGAO7ZYEYcqVWpZJUxExAUnHV8u6zBU81IJYN/SYTpEG6cOI+JnwBX
         JtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499230; x=1794104030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4rxIRaCxnrdC1SqVr2USnkLP2QgDb4JUWWHxADVHGo=;
        b=kCIsNwFS5O7YBgJXpzE445ECZkGB9YeH5og08bWFd7q3h3ADbtKb5K64N+XaWGKPB4
         WGC9ic8iKG3VN0zcq4F092ILnlajzrqjdprGDMHf54euHJTWJ3DB4wy7iLZ538N9FKDW
         lKprDI0/6HkTVp/Qs35veKxyYS/MTR2UeB7wAsSkfXHt16JXttX73If+99IuVFiijjS4
         uRMYtxWH4piFsx3g6iTZozl7dPzgDCaIso411XNOOAdJtqblXd+5bFho5AHFm0D7VwPh
         M+TYvKg8s1epNDmGJOsdiZM3HfLY2Q7vqvgFQw/rNrW/MWn1g1JBH6dzeEOq0HS+9ndX
         p7hw==
X-Forwarded-Encrypted: i=1; AKwUvByNtGUekHLv6fqnoJN+afvbmkyLkmaKcpmrCiccLRTkQzqG/H2O+NTcQkhlYgeZJls6Me+sDJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp4HwW5uc5xOBkXPHUipJhQx+cKvSh8wB55MYnWUYbieMfsbh6
	6tHul6W3uhFwm0jjsUl4pOL2497jSx+XRKzndLPK6TSncBNcDO8fah8otAMhU+2YhkE=
X-Gm-Gg: AYBFou3u+UBjsilnxEMo6MnfzibaR+QgVXI5BE76kaHjJsuwsmTMojV3gqk8z/PrBH4
	OxfY6JvItXRYirQWlbD7IiwqCSkV4YMvmk6t8rVP/w7rR7GBmGtVpbmNwRG7tMq2C/Rg2G/9q6J
	p9wwCw9b5W7pJu3sR6Dz0Fak7CjWlPk8K8oRZsNLKj0imND2aZcQo1HdFSUPKi3Xgw4c7Ft6I3P
	/rIYMBphxQALDpp33oAqGlWXjZPJl7bOOfsvZJidZUDWFB2FUjuKEjQr5mY26kRFv1f6hERexbu
	y0UNHl2QrUBvhKETFxcRhecIutVYpcloBf+SxjskiEHkoorxNFjBfyo1Ccmk3HxooMa0fuqDv/I
	bFMmoVtivTtZManW0tgTwBrgXbnqsWkF0y/CpTexyHPN+H91qrs6ncDyOY0eOu/o6BQKxMgq6s8
	vWB6v+hfw2srTreLhDhpkYlXFEqTud7d/etrlYMQHKq59vBAXU2vRSYFX14wKJbsnqFnkPJhvUl
	qNMcD7ac7/AvjeZxkqMbxi/dORTLmx0YRtLjB/1np6q81AoSv3vF7aPta+/asQaWn1w1CiZ+BCZ
	2Z7bjFiKK8rJMyf6kzasbP2Sf2NARN2tJdm/f1YUGlCIIh+3s7qNiGovVv5WVWA38aeiE5NxA7q
	dWzpa1aQFWw==
X-Received: by 2002:a05:620a:29d4:b0:943:f4a1:7bb9 with SMTP id af79cd13be357-944216efcc7mr1061645285a.18.1793499229856;
        Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty zone
Date: Sat, 31 Oct 2026 22:13:30 -0400
Message-ID: <20261101021340.2251928-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

From: Josef Bacik <josef@toxicpanda.com>

When the last memory of a zone goes offline, zone_pcp_reset() frees
zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for those
who found the zone populated and still use the two pointers. They take
neither the memory hotplug lock nor any other lock which offline_pages()
holds, and some of them can sleep:

  CPU0 vmstat_update()                CPU1 offline_pages()
  refresh_cpu_vm_stats()
    for_each_populated_zone(zone)
      pcp = zone->per_cpu_pageset
      cond_resched()
                                      adjust_present_page_count()
                                      zone_pcp_reset(zone)
                                        free_percpu(zone->per_cpu_pageset)
      decay_pcp_high(zone, pcp)
      __this_cpu_write(pcp->expire, 0)

The same goes for drain_all_pages(NULL), which takes pcp->lock, for
zone_pcp_update(), show_free_areas() and the readers and writers of the
zonestats. If the per-cpu memory has got a new owner in the meantime, it
is corrupted.

The pagesets are only freed because setup_zone_pageset() would otherwise
leak them when the zone gets memory again. Keep them instead and let
setup_zone_pageset() and zone_pcp_init() use them again, like it is done
with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
have been calculated for a zone without memory by the
init_per_zone_wmark_min() of offline_pages(), which is what
setup_zone_pageset() would come up with as well.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f1048168c90c..1850a41f24f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* The zone has been populated before, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
 
 __meminit void zone_pcp_init(struct zone *zone)
 {
+	/* A node which is added again, see zone_pcp_reset(). */
+	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
+		return;
+
 	/*
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
@@ -7680,6 +7688,12 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * The zone has become empty. Its pagesets and zonestats are not freed: nothing
+ * keeps somebody who found the zone populated, such as refresh_cpu_vm_stats()
+ * or drain_all_pages(), from still using them. They are used again when the
+ * zone gets memory again.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7690,12 +7704,6 @@ void zone_pcp_reset(struct zone *zone)
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
2.56.0

