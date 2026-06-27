Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF91343895
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591773; cv=none; b=Vh6opWodIaS9Lh9vx8xIWui1i4y0P+APP/IptAO0o90c/eJgh4tDdlK+stuji55s/aiMql5wv1S/OY7FKxFQbMmLXYdgmObuYgTwdc1kDcFfBNIsroQ5U5PkJFasyrBWgRYo0y24PT1uYFNcifRfFNR17ev0NklQ+4k/UefGg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591773; c=relaxed/simple;
	bh=1Dx/SN13LaO4YOQJBrAbaMZKNnc5ymRZr+kDWIebbVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRlBuL2dE7Yt+4FAnMMKT/1QNfluLL+yZ1bJdQzclOEeY/FWmiICrisBZyEMzzvz+EPqdW44Lf7D1GYLTRnCvCneGaxT005cd3TwNQIy9KIr2hPKP/3dR4/YIQV4d2QObd83vUov3q7xwwsOaGYAMptTmSR/fa9MsLxfgOU4avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hOuPGOhO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hOuPGOhO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92213351918so281401685a.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782591771; x=1783196571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwSxUHfK3Ujh5X+1LGpk4GjnutPBz0h9+pc9vXkph2E=;
        b=hOuPGOhOBfrVKC6vlTM0WwPDLDOVWtYmkAYw6unoy475wmw5DvfBR8oJhmRh/fCE5A
         Vw0EWwAI6tg8ImbLhncfFbkjfk2ZZUzU/cR1k80hHfp+IdmA6w8a2ArLFkPEjeIpNarh
         tj6WyOwpSgZ1aDEjffA5oelhufouyyFl0zfQEUzGA7NKpn0Bm+SbqQipGqmVuRMg0xjG
         KjyqH5pjJSW1JugGAWEgW+u5yzQORSf0rq0b0v2q5MxJ9ppWmw15xoaW0N8xP4SsP/DF
         zRjf3Sd3cIlwnMpjT5UXFT0T6TX4Mj9+L3C4Pz2dZnF8cbYUtvvroUG6bo3+HuKRSqay
         KlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782591771; x=1783196571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwSxUHfK3Ujh5X+1LGpk4GjnutPBz0h9+pc9vXkph2E=;
        b=FWnZnBR0T55priXMXQ1uh13wA/k1nLm+t+FM+FNa7N33CK8ZOmRAm8d3NZJ9JKcpsa
         h/K5xRDb/p+TC3bAbiYQXkErANNmYdC8/tftFQN+IEqoKRm/+vx4nMWGtqGF7+Mb9TLN
         bgWxuP7IE8jxUI+V0svdtlGdbCbTid4kg+TBTmyvlJ/HUFXR/LO9K9Sy9CODYEZpZ4Y9
         YEgp5Jq4qeFTOLOCA5ZUic2EcsixX6sbEteIKQ0Av/sLaj1EE8rrup3e+hLxUulJeS7c
         aanudT94CrxXfH+5rNXbvEJFaKL44awhcTnRaNgMtDOB419zkmKswKTnD3cpkVb4pUXY
         6Ubw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZXnjAFi4zxo+IfuURTplSGQ2xDe1WxwgnJDrv3t9iRs2FD/6lW5ey2g1pxbAN5EnRszqc/Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLQcV8DOwlXw0Ojuh17rDxUH3BrSVCvz0nQGBS8cnOvTqoJQF
	0YM/meVqWFP+V88thdsPMIyhu/71KE5s1ppoaYZo2BEyVn7t6Xb4mdw6DRMH1O3ru80=
X-Gm-Gg: AfdE7cnZuaPltY95mYyG9MH0drpq/trLQWFCgyWNv/e7EvrOwJSUUrgGdzs3p0bKuFN
	ov31pZi98PagqdVNtgJvaR/7YSUslwqO5z+kHEo1/LBDUUxHTWvom9xUJdOkEHacoOspFuSlUpL
	Zns33xbkqeSuo5DOsmjMhFLrchAdlMRD6xqpzTtj3U0zXKXtNnwqrE/f7YS8Z55d3Kn/WPaPFET
	bO6Yo+RVQtagBt1M0skbnmdzQn8oAZ35E2Tl852lk8pyYGDaEHbAmAazLq1gf5OyqUGB4Kad6TE
	kP5AgOUvDX8hU5ecHhzQJd4VGEwYudpZL0xT1XfP6MB9GoGIPEsJCDKnIi88SzUJzF1wUw/VYwS
	wTqja0/qHWucr+/VScffUptdsNqpoD8MNoY7YjLPYXJCHr6S0/s0a/LmAQB+pgbgE6rwOPQSxgB
	bBKx+j8gByv8qc8GBtd3kMqWgfzGlklx7DwnizaDGDSzq+jbr2n+i4nowLQQr+ZYsR6y4SN9RFX
	g==
X-Received: by 2002:a05:620a:2892:b0:915:9fba:878b with SMTP id af79cd13be357-9293a0dc1fdmr1634247985a.9.1782591770824;
        Sat, 27 Jun 2026 13:22:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bf55sm1540125485a.46.2026.06.27.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:22:50 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a node comes online
Date: Sat, 27 Jun 2026 16:22:43 -0400
Message-ID: <20260627202243.758289-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.
A balanced counter can sit split as global=+N / per-cpu=-N.

The folds reconciling the split only walk online nodes, so when
try_offline_node() marks a node offline the per-cpu deltas are stranded.

A subsequent online resets the per-cpu area but not pgdat->vm_stat[],
orphaning the +N permanently.  All NR_VM_NODE_STAT_ITEMS are affected.

The existing code zeroes the per-cpu counters and causes a permanent
skew. Fold the stranded deltas instead, before the node rejoins the
online set. The node is not online yet and the hotplug lock is held,
so the remote access to per-cpu values is safe.

Discovered when node compaction hung for a nearly empty node, as the
math to determine throttling broke.  Reproduced by repeated memory
hotplug/unplug cycles on a node under pressure: NR_ISOLATED_ANON
ratchets up and never returns to zero.

Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mm_init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f5301d4de91a..c119f6f1497d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1536,7 +1536,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
-	int cpu;
+	int cpu, i;
 
 	pgdat_init_internals(pgdat);
 
@@ -1554,10 +1554,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	pgdat->node_start_pfn = 0;
 	pgdat->node_present_pages = 0;
 
-	for_each_online_cpu(cpu) {
-		struct per_cpu_nodestat *p;
+	/*
+	 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+	 * offline nodes) - reconcile this at online. Foreign access to counters
+	 * is safe: the node is not online yet and we hold the hotplug lock.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
 
-		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			if (p->vm_node_stat_diff[i])
+				node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 		memset(p, 0, sizeof(*p));
 	}
 
-- 
2.53.0-Meta

