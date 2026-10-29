Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305150;
	b=LhiSrOERKBihURIs24hix/JOJBxsPeFEGEi854R6A7C3kRXKgqN0G5eTGje/5TZitEkf
	 iXuazrEHIJDHo5ouzdnYFYvoRvFXbMR6dn2SBwE/rb8FrP7DQFXg8cM98UY+MkKGanofO
	 ry7svD1kSVxBstGd0nc0L3Pbh9/W0sysqPH866JahW0u43gmWYDa3iRI63Zdk0bEBy9df
	 xljRaNdkVZVDAskHCHeISUc7rBMeZRESFRHG6QsCkkqk1ZP0rwqNhlYWDlJ0n5ddcXW6j
	 88tCpljZaUHq6w7CjbDj1a3RwspobkRO6attLr8sCu3tOJVq+lrH8dfLkItyRpH3Exw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DgH2xCOp/6/mNmEP4Z/0nXSnHkQBtLx+MyyZJMoK6oE=;
	b=m7z+Zoo96q1y0Jgz4DtO5yFeFI3qeaGJQWwzFaL/kpq6nT3gAe8vINMzL24b5KeregSg
	 sEdO+zfbrFcqXMVjrLaXiqy0I0nEUVlaKj/nkxRBSXqY29+PzqDbs/aa7jvX9LIXXK0Ve
	 bZX/n1FUEMt3SaEiP7gObxZXQEg9+0sjPDbas0MxGuSMKOiY6b1EVodLs4pGE1V0CZb8P
	 kIgJ7UO2UFsKtH6yc8gac9rNRe7fI5ZCjMY+8fKJcIKk+Sq8Iqg/xft0/H6k4UETtd25+
	 BTCYXCbtl4qHqvVIw9zYD2ypRKmL3q7lWMV+qVlmC9lIdlOy7pzGxuV8yUWibmeNreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n16LifQm;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EA606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n16LifQm
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so2224763a91.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793305148; x=1793909948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgH2xCOp/6/mNmEP4Z/0nXSnHkQBtLx+MyyZJMoK6oE=;
        b=n16LifQmuoNDtwFF4AQxmFuVlC73wKUZAnY13CNT0cdrOgFDn1qOPK78rJ4jvNz6F1
         iaYI12oPJRMdbOdScY1ZviBzD0Mrx6k1KJeKjNu5a9koknHMEqluR+un3VNlPv7Yzwx1
         dAorpZBXT6LWv3q75uH7yOxC/j7zX3PvLw0eYGO8dRwNbrJglq5Y5ovYy/JtscSE5Fey
         /OpxoKu0TLitSeLr7RRJBxKCeRzsOkc6zio5rRvYb4tsEleBUPB1qjXYrPangBSA+XaK
         f+13CuwqMLNEA6Tmi3jlmKqlAxqQEo0SMOKRH0p5ZnhRSjUSKPG7+ydQ3Jd1mexZj7eV
         KbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305148; x=1793909948;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgH2xCOp/6/mNmEP4Z/0nXSnHkQBtLx+MyyZJMoK6oE=;
        b=N2gZ/Bn4hJbhdvizf1Sdoakba3PpQVGWIdjDaKhKQ/Cn2qZZcomx0zcTrMhoeRCwhh
         8Xu06KF3X+e6lJoLuPF+/sDiSXavMZXbEbotfcadSRjVoHawVm30ou6yAc6e8Q0V+Qgk
         kt+LPu7GVyF0bP2EDVnDTaJRsES52Oc4hcOA4O8AyUJnjU8fH5PksGXnYL1NSUVvTyuE
         tMJ8P3BNY8t0GDR5vUGqG5okU7eAvOTRBvVmBAQ7NDa4SOve5szw3WgTy7UNqJRdHwxl
         X+YhEY52YDndZ3RzR8orjVMMeV8kjr6AIVtHV7JyAKCL0dvYNY8GUrFrdrSMlWjyiIlT
         myZw==
X-Forwarded-Encrypted: i=1; AKwUvBzsr2hEPEd25ichq2zX6zV0qMhxrXDkCp2KQw0XG1Aq/yo6eIF/JqRQIbccgFZ6DKf6MiqLaEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAuOoiX6BJUFD8QgGwtCxleRBOnhGsdE6MGgXsWPSe314xJSud
	09UoM3ULTn3OLlBo7wOLvKwZQpWLJCXcTwq7s4pby4NxCWSsbbv6GRsvVbDmYxh84dEsyVVsfpW
	dqVztmPp1Cx7Tcjiu3w==
X-Received: from pjig2.prod.google.com ([2002:a17:90a:5782:b0:3a8:7374:19e9])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr68937a91.49.1793305148283;
 Thu, 29 Oct 2026 13:19:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 13:18:58 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261029201858.2932905-1-tjmercier@google.com>
Subject: [PATCH v3] mm: memcontrol: fix NULL pointer deref and UAF from
 high_work_func() on dying memcg
From: "T.J. Mercier" <tjmercier@google.com>
To: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev
Cc: zhengqi.arch@bytedance.com, jp.kobryn@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

When memory.high is exceeded in non-task context, try_charge_memcg()
schedules memcg->high_work without taking a reference on the memcg, and
high_work_func() invokes reclaim_high() without pinning the memcg.

With obj_cgroup reparenting, introduced in commit bf4f059954dc ("mm:
memcg/slab: obj_cgroup API"), objects charged to a child memcg are
reparented to its parent in mem_cgroup_css_offline() instead of holding
a reference on the child until uncharged. Subsequent uncharges of those
objects go to the parent, which can leave the child's memory use
permanently above its high limit, so any later charge on the offlined
memcg in non-task context schedules high_work. This was later widened
from kernel memory to LRU folios when commit f1cf8d2f36dc ("mm:
memcontrol: eliminate the problem of dying memory cgroup for LRU
folios") converted LRU folios to use obj_cgroup reparenting.

cancel_work_sync(&memcg->high_work) only runs at the end of teardown in
mem_cgroup_css_free(), so high_work_func() can start or still be running
reclaim_high() after mem_cgroup_css_released() or shrink_many() has
called lru_gen_release_memcg() and unhashed lruvec->lrugen.list. If
reclaim tries to rotate the memcg, lru_gen_rotate_memcg() dereferences a
NULL pprev pointer. This issue is specific to MGLRU and was introduced
with the memcg LRU in commit e4dde56cd208 ("mm: multi-gen LRU: per-node
lru_gen_folio lists").

With either traditional LRU or MGLRU, css_free_rwork_fn() calls
css_rstat_exit() which frees per-CPU rstat data before calling
mem_cgroup_css_free(). If reclaim_high() is still running, rstat updates
via mod_lruvec_state() -> __css_rstat_updated() cause a use-after-free
on the per-CPU rstat data. This was introduced when commit 5da3bfa029d6
("cgroup: use separate rstat trees for each subsystem") moved
css_rstat_exit() ahead of ss->css_free().

Fix both problems by acquiring a reference with css_tryget_online() in
high_work_func() before calling reclaim_high(), and by resetting
memory.high and swap.high to PAGE_COUNTER_MAX in
mem_cgroup_css_offline() so that charges via references on an offlined
memcg do not trigger high_work on the dead child and skip checking live
ancestors in try_charge_memcg().

Acquiring the reference in high_work_func() rather than before
scheduling high_work is safe because mem_cgroup_css_free() calls
irq_work_sync() and cancel_work_sync() which cancels pending work and
waits for an already running high_work_func() to complete before
mem_cgroup_free() frees the memcg. css_tryget_online() uses
percpu_ref_tryget_live() and is safe to call after percpu_ref_exit()
before the cgroup is freed unlike css_tryget().

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Tainted: G    B   W           7.3.0-rc5-g2bba28e98578 #284 PREEMPT(full)
Tainted: [B]=BAD_PAGE, [W]=WARN  <-- Taint from lru_gen_rotate_memcg() VM_WARN_ON_ONCE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Workqueue: events high_work_func
RIP: 0010:lru_gen_rotate_memcg+0x1a3/0xe90
Call Trace:
 <TASK>
 ? read_ctrl_pos+0x22f/0x3f0
 shrink_lruvec+0x16cb/0x1b80
 ? ret_from_fork_asm+0x1a/0x30
 ? lapic_next_event+0x15/0x20
 ? clockevents_program_event+0x2bb/0x6f0
 ? lapic_next_event+0x15/0x20
 ? __pfx_shrink_lruvec+0x10/0x10
 ? __pfx_clockevents_program_event+0x10/0x10
 ? _raw_spin_lock+0x84/0xe0
 ? __pfx__raw_spin_lock+0x10/0x10
 ? kasan_save_stack+0x30/0x50
 ? psi_group_change+0x381/0x740
 ? __pfx_sched_clock_cpu+0x10/0x10
 ? save_fpregs_to_fpstate+0xc4/0x2c0
 ? finish_task_switch.isra.0+0x1de/0xac0
 ? __schedule+0xf62/0x42c0
 ? __pfx___schedule+0x10/0x10
 ? __pfx___irq_work_queue_local+0x10/0x10
 ? shrink_node+0x626/0x31e0
 shrink_node+0x626/0x31e0
 ? ring_buffer_unlock_commit+0x11d/0x5c0
 ? kswapd_clear_hopeless+0xa0/0x150
 ? __pfx_shrink_node+0x10/0x10
 ? 0xffffffffc0000095
 do_try_to_free_pages+0x255/0x13b0
 ? ring_buffer_unlock_commit+0x11d/0x5c0
 ? reclaim_high+0x10a/0x1b0
 try_to_free_mem_cgroup_pages+0x1f9/0x5a0
 ? __pfx_try_to_free_mem_cgroup_pages+0x10/0x10
 ? irqentry_exit+0xc6/0x670
 reclaim_high+0x10a/0x1b0
 ? __pfx_reclaim_high+0x10/0x10
 ? process_one_work+0x5ff/0x1030
 ? __pfx_high_work_func+0x10/0x10
 process_one_work+0x6e2/0x1030
 ? __pfx___schedule+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 worker_thread+0x422/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2cd/0x3a0
 ? recalc_sigpending+0x15c/0x200
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x368/0x590
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x588/0xf50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Fixes: 5da3bfa029d6 ("cgroup: use separate rstat trees for each subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
Changes since V2 (https://lore.kernel.org/all/20261028183537.605854-1-tjmercier@google.com/)
- Add RBs / Acks
- Explain why css_tryget_online() is safe in the commit message.
  (Shakeel Butt)
- Update the commit message and subject to explain the cgroup UAF this
  patch also fixes. Add Fixes: 5da3bfa029d6 ("cgroup: use separate rstat
  trees for each subsystem")
  (Michal Hocko, Johannes Weiner)

Changes since V1 (https://lore.kernel.org/all/20261023222313.3979455-1-tjmercier@google.com/)
- Switch to Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
  from Fixes: f1cf8d2f36dc ("mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios")
  per Muchun Song.
- Reorder and update commit message content to describe reparenting
  separately from the commits that exposed and then widened the problem.
- Trim the backtrace a bit.

 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a05d9a8baa1b..84f4a8fd4d16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2457,7 +2457,10 @@ static void high_work_func(struct work_struct *work)
 	struct mem_cgroup *memcg;
 
 	memcg = container_of(work, struct mem_cgroup, high_work);
+	if (!css_tryget_online(&memcg->css))
+		return;
 	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
+	css_put(&memcg->css);
 }
 
 static void high_irq_work_func(struct irq_work *work)
@@ -4463,6 +4466,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
+	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 
 	zswap_memcg_offline_cleanup(memcg);
 

base-commit: 2bba28e98578de622ef307d00875aa8f8bca3d10
-- 
2.56.0.385.gac671c819a-goog

