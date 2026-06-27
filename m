Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993B9463
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782545475; cv=none; b=edMx1KYoUI7x/jvrC3Galdy1NUbgICq+EZ4cYnN3zGORvvvIZ0dyxJAIh4fwO8w4II1ezwIKUp1pgyajFlJ9RTQeBL9E/s421o+sjQY3G+ATNTJXqjDgGwqrEqs9Giu7L24KFY6tx0wbJezkl6nRO+ZCLuaCbZoj807E+ec4ocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782545475; c=relaxed/simple;
	bh=so4ToMrba/4u4JURXcQ5YjcHpRWPbvKB5biE2mDggBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2dVEh9ytUkZJQWjBcDC6e6Q85AhxqDJyw3ja+Wn3TRvOjueVvNvzrFzgK4CsKffM3FdFBOUmiWus2ju0amuSA5FMUS4aRWTqux42l9JiA5heRmAqI5M5IHIoJxl3RSUavVwK5fs4cUIMN6Ll8jTU2zztlma4yMlQubPyHcRVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dhelsaAg; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dhelsaAg"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92b5180680eso73801485a.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782545473; x=1783150273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WE84pD+Jyu5g3XDhg98oT1h9UPEuFUTiMELgYk7rrE=;
        b=dhelsaAgEJKYSohTL2KeugiacwZ3n8SrgMq+Pi+a0TnDBZuv1GSWz7nSh6VQPp169D
         9aTOOSgsvcWuFPVbikpjobO2UHH84ukYVGmpW4jhB/LRyoZGBTTjpQAjS8nw5kRObt8V
         Mcf8iuZPSnZz74TyIVhzSUxeDjCmMck0alQj2jkXhM2W+6cIJmTrp8mRheEA+xEJQFJw
         7LN7p44wmNItGd0O0uwNvqVMPx3X5pEmOI6YpSTZ/+OO6BB4Mk5ypTmRqHNFodE+gURA
         ZQD+E76+5K0qJr7GqAokOyX0K4e8YyRd1xvtsb2W8bxh4pDtL3t91D9Oe4t890HLvW1d
         0D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782545473; x=1783150273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WE84pD+Jyu5g3XDhg98oT1h9UPEuFUTiMELgYk7rrE=;
        b=BBwXtPXvpxWm1JZQe4ZVLcvMzgKZSRrHIT/fCLiIvHmOmpJuhGpJ2yYwiqGBVGJ9MX
         bcI7KLaHyereHh6XZJAsO7osXi9mSYa4iPAm6j5JEv8gfdrqOB6mbGsVD+bThjJk6bGH
         thHsJn7aix+QM95QygL//sWVmmk+h7GCmSYlcLWN9x29BdLyliDYFmCeSp7MM74hjtlG
         pF3+bpHO4zDYtesahLGhnfNID0Qbe5TW7IUzOCEXrpLsQdKrb+hbwV3wG9uPGQp3oz+2
         SQ8sy3sq7Ha0GsZBIFqBj1IJZIqxfB/DZoGmbcI3/gkeO7NB3iK79uiHsdZ+/c/32+oh
         u7Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/FIS1Sbd7M9jMTuOF0fS6bsz9TkBJsYIfBtY8J/I1ZwxZpssTilESL0gtukLrZRs2IZN2UyBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7AZMMJHOOTxih48zJGE9E+1NvczZjDcEdxDxM00euSe7UwlY
	ZBjOmeTQXM7AWYQ9Wg8ej8AjpMSPlUJcN9Z5qU8WwCCbuGdhl+YkX3ihiGW3qBRbpi0=
X-Gm-Gg: AfdE7cnGm/Svt6Situ56xTPijeAJJkolS4VrxNYHWQKLStJqmrSD2mH1f5JMhNYFZIT
	AAK0f+vIOqisLD24kBWuavQzvzLOeCAMlciOUE97mXWIqKl3/hJPRsxqZfH9tUUeRaVBaCsRQtF
	hbUifawl7Au6jxrfowEvNvuKX76a1kNijkR9F2+R/J97jJ7YEsIdsjWoq8HBOi9oOl/MAUYyRKm
	CaA1lwa8MaeaubJZho/BJfbfjpgD2FtH5VLBeXCXvZlPE/eLynpiWaV2DYGs8eR9e/kMNq8ud6p
	WHi0lhgN/b4uGXkhTSxU8ChZ53EVcTMVJJDVZWfTi8pZgMkBvPLYE5W0Q0TuE+aZ80s2O99DCso
	LHyv4T0RjNWQBNbeQQ37k7K+THUOzEpj76LfK0nyXUzSgmoKzm//l8JsS95Y7SrAIDDZ6gLqTBg
	bUQH/3AOxuHusAOOf3qq1uTk+pkTm1AWO50Aaekco7UI03Ec0pg/BABU/S/sOKJoP5slfr3DFrZ
	A==
X-Received: by 2002:a05:620a:2911:b0:915:f360:e97b with SMTP id af79cd13be357-9293a6b0834mr1579336085a.6.1782545472672;
        Sat, 27 Jun 2026 00:31:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92b2affb45bsm296627885a.12.2026.06.27.00.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 00:31:12 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes offline
Date: Sat, 27 Jun 2026 03:31:07 -0400
Message-ID: <20260627073107.523499-1-gourry@gourry.net>
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
try_offline_node() marks a node offline - per-cpu deltas are stranded.

A subsequent online zeroes the per-cpu area but not pgdat->vm_stat[],
orphaning the +N permanently. All NR_VM_NODE_STAT_ITEMS are affected.

Flush the deltas before the node leaves the online set.  A remote
fold races the periodic per-cpu fold, so do it as per-cpu work.

Discovered when a node/compact call hung for a nearly empty node, as
the math to determine throttling broke. Reproduced by repeated memory
hotplug/unplug cycles on a node under pressure. NR_ISOLATED_ANON
ratchets up and never returns to zero.

Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/vmstat.h |  2 ++
 mm/memory_hotplug.c    |  5 ++++-
 mm/vmstat.c            | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..ea1017427811 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -293,6 +293,7 @@ extern void __dec_node_state(struct pglist_data *, enum node_stat_item);
 
 void quiet_vmstat(void);
 void cpu_vm_stats_fold(int cpu);
+void sync_vm_stats(void);
 void refresh_zone_stat_thresholds(void);
 
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
@@ -397,6 +398,7 @@ static inline void __dec_node_page_state(struct page *page,
 
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
+static inline void sync_vm_stats(void) { }
 static inline void quiet_vmstat(void) { }
 static inline void vmstat_flush_workqueue(void) { }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7d60a7dd1e7b..10f676566f56 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2338,8 +2338,11 @@ void try_offline_node(int nid)
 
 	/*
 	 * all memory/cpu of this node are removed, we can offline this
-	 * node now.
+	 * node now.  Fold any pending per-cpu vmstat diffs into the global
+	 * counters first: once the node leaves the online set the periodic
+	 * fold skips it, orphaning the residual on a later online.
 	 */
+	sync_vm_stats();
 	node_set_offline(nid);
 	unregister_node(nid);
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..ad77343212d3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -941,6 +941,16 @@ void cpu_vm_stats_fold(int cpu)
 	fold_diff(global_zone_diff, global_node_diff);
 }
 
+static void vmstat_fold_work(struct work_struct *w)
+{
+	refresh_cpu_vm_stats(false);
+}
+
+void sync_vm_stats(void)
+{
+	schedule_on_each_cpu(vmstat_fold_work);
+}
+
 /*
  * this is only called if !populated_zone(zone), which implies no other users of
  * pset->vm_stat_diff[] exist.
-- 
2.53.0-Meta

