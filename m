Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919785;
	b=iYz+KWq8NipkOsO1gjEqcy5jDOMNUD05WLp/BtF1oouaBKUZlKb+1UtfNOLAM4r2PucQ
	 jBy4blLlhFNqSzYjyvnDO1Q9hYChc2YkEoCIDMN1zWSdB0dnEJBA3g9mVFg2QIK5sEmY5
	 HXTULvPXxkXtBAueMkEzCqTz11JfE5yY2UcDWmLJ9RySZsR5WKOOr/K5rFwslSHPK9dL6
	 cS2EX7PpsT/FSABwii5gb/hhd0gggrmCcacYZuQfi2NOM0U0/fMqY1fs2G1MM7rMNepGT
	 Drr91F9bCvJIqjuHTEn+3a74z2tKcDSTF9+fSDZQ3fskcWgphC87XMkXzMj9qCrodRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7NkXbGqH8tfkmfDZNQTbsEwEgUav04FZtmrAz3OgWBc=;
	b=ybu32VN9yHslxyCESeQBWA6444v4+yyVcJ6RFOvpNa33KbugDxV+UjMNg6AM8rBbSUzB
	 y2Rmb+yzGvj6yZj9fUtmOa5S1OU6aLAlN3A2Lg7NiCgcl4/rgqAOX0Fej1+2yqVCoZ46R
	 Un9V+CYXFGWn+5pIC6JlxFypdf1TxrMxrTy47N9F9XQ1nWhZBQ/K4xmuU+actPkRiBMGZ
	 H8SBlwaf0J7QAposgeJeu9yxPmaOuzr6g7oVl49Y/o9VrsEGKBf/Gq2fGnidEaNjh/+kq
	 1RWmfPyf0b1Gsff6+vgQOvpdrJwJWTS0SErez6us7yLrBU+jPE7FqtBJk9BP0Bb6wCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iSjOb68b;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9848606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9848606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iSjOb68b
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3accd1ff4c3so38724141fa.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919783; x=1795524583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NkXbGqH8tfkmfDZNQTbsEwEgUav04FZtmrAz3OgWBc=;
        b=iSjOb68bXTtcJSoUb3k0ekp2ph0sDPgxfGjnHmBJruuVFwKYxzA7IXgi3MKkfvim9G
         lOPj/I6X5rcZ7f1thPBY63GUOr1p/y2t+jkDgyDOeqOHvDzP1O1HklwkKa6JivBDGPmy
         RuVnnVGHGbkT96uazlaV/Jl2906j5KkE+fr3k+w6HV0nXeTMdNcVhlmLRIfeGqJmTTzx
         HwheUOtv1xcOitLX1S8TuNK8Mh8g610FRpnN68cNsItiRJpE9dFwWhwoSWsHYdA75i3M
         gf5IoIpiAh24/gsOSzIkXYvmCGq1xdRzmiMLCSIpGMybyHjOf5L92V3UP8Iwn9LKGZwE
         BR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919783; x=1795524583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NkXbGqH8tfkmfDZNQTbsEwEgUav04FZtmrAz3OgWBc=;
        b=FIqU13vcF9Y/9kLbdrQwjlsouBzRwtCpeEuW2co0MwUoDughFCaNQBwykk4h7MFW7W
         zfGKivbLqhjva4LwVKX8cLdwxajZYzxL6uHaSjHdN5f+YUItPh43jMITBdB4zxGnpaT4
         Sua28r18mLJslGJvUPGLKwAq2FsPx6hwyEVzli9JummoxCsdqTWA8hq6kdZe92pEAg/x
         TTpHkPCR8y7vJfAcCBDKAn0npgidJzc7A3AQzgs7Z5pSX8Vw+uC+MXDKrBwR86zt3RvD
         gSKxm9kE+pIMTYY3zAmyblFEe0Vnxxe9QYHdqz/vkENAUV0jYClLgNxWfixh6BHtC2f7
         TDXQ==
X-Gm-Message-State: APuU4Z8/HPG75nenE5dIT1fhkX91Wy4Rg7PGyfBtaa8oaKHLAF8B5/tG
	lRgzRKh/N674DFuS8kI9+RXYSVqvU0i+W/rjroYLKck7NTnyH000JRr2EK8j5cPG
X-Gm-Gg: AYBFou3USehvKSFQhFBX7p56gNAJX76B5Bi54ZL+PdZhCcTqfBXemEWe5jlZKteK+S4
	87s3ceXTY/dNIeAgTT9aYNnVwdDEmZUv+Qgp0LH3RhhMg3/A2TkyuNRtX1lfRvN4NHDCeq0BG4w
	hCEUU5X9hjk0iay7fFyU+e53778CXxuPjs4avA+ZBTVfRbBkJ9hVN+4kzXmLdsr5YzIdh/oe0iT
	HzLEFG8BB2QOgP/HbApbXJwMZpDpzGNW5rxFKPbssrWXEc7KiN9D3ps1XJ+xd8voGptxSTfdXPc
	VtOzosQw5fsbA8vZILB7U0sVfiq1YK2yqZ/TiJzrJmFJ0ZTnJpLEnPgfVNhDedkn8LBZvtgevF+
	/ufhBQ3m+ZjIVA9F262EhkxVg4XwBoiOvB5NlS24y69+pYR9VoWHy5dHqREAxzJMNHQeXVFpI87
	60Twj/+chKPm6nuNBy9nXU27/JZ5FG2WFtq0wdDEqGXsX7FNo3wdbZ5TV2t3cVqs5n2/PsBhUj2
	7yjO6u2fQRiPpLUUCA2PkTWTNHNgMmNW8lYfxH0IUexljjG01yKheejXcCpCGW+uq7vEkjJ7ZLt
	AEzEXsABkchD/m9bVR2+vhW0cQ==
X-Received: by 2002:a05:651c:41cf:b0:3ac:4ce6:8b7e with SMTP id 38308e7fff4ca-3ae2b53102bmr35843721fa.26.1794919782406;
        Tue, 17 Nov 2026 04:49:42 -0800 (PST)
Received: from dschervov-lin.yandex.net ([2a02:6bf:8080:516::1:37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7ae92dsm41051351fa.23.2026.11.17.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:49:41 -0800 (PST)
From: Dmitrii Chervov <fary.ru@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com,
	mhocko@suse.com,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y] mm: fix OOM killer inaccuracy on large many-core systems
Date: Tue, 17 Nov 2026 15:49:38 +0300
Message-ID: <20261117124938.72111-1-fary.ru@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit 5898aa8f9a0b42fe1f65c7364010ab15ec5c38bf ]

Use the precise, albeit slower, precise RSS counter sums for the OOM
killer task selection and console dumps.  The approximated value is too
imprecise on large many-core systems.

The following rss tracking issues were noted by Sweet Tea Dorminy [1],
which lead to picking wrong tasks as OOM kill target:

  Recently, several internal services had an RSS usage regression as part of a
  kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
  read RSS statistics in a backup watchdog process to monitor and decide if
  they'd overrun their memory budget. Now, however, a representative service
  with five threads, expected to use about a hundred MB of memory, on a 250-cpu
  machine had memory usage tens of megabytes different from the expected amount
  -- this constituted a significant percentage of inaccuracy, causing the
  watchdog to act.

  This was a result of commit f1a7941243c1 ("mm: convert mm's rss stats
  into percpu_counter") [1].  Previously, the memory error was bounded by
  64*nr_threads pages, a very livable megabyte. Now, however, as a result of
  scheduler decisions moving the threads around the CPUs, the memory error could
  be as large as a gigabyte.

  This is a really tremendous inaccuracy for any few-threaded program on a
  large machine and impedes monitoring significantly. These stat counters are
  also used to make OOM killing decisions, so this additional inaccuracy could
  make a big difference in OOM situations -- either resulting in the wrong
  process being killed, or in less memory being returned from an OOM-kill than
  expected.

Here is a (possibly incomplete) list of the prior approaches that were
used or proposed, along with their downside:

1) Per-thread rss tracking: large error on many-thread processes.

2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
   increased system time in make test workloads [1]. Moreover, the
   inaccuracy increases with O(n^2) with the number of CPUs.

3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
   error is high with systems that have lots of NUMA nodes (32 times
   the number of NUMA nodes).

commit 82241a83cd15 ("mm: fix the inaccurate memory statistics issue for
users") introduced get_mm_counter_sum() for precise proc memory status
queries for some proc files.

The simple fix proposed here is to do the precise per-cpu counters sum
every time a counter value needs to be read.  This applies to the OOM
killer task selection, oom task console dumps (printk).

This change increases the latency introduced when the OOM killer executes
in favor of doing a more precise OOM target task selection.  Effectively,
the OOM killer iterates on all tasks, for all relevant page types, for
which the precise sum iterates on all possible CPUs.

As a reference, here is the execution time of the OOM killer before/after
the change:

AMD EPYC 9654 96-Core (2 sockets)
Within a KVM, configured with 256 logical cpus.

                                  |  before  |  after   |
----------------------------------|----------|----------|
nr_processes=40                   |  0.3 ms  |   0.5 ms |
nr_processes=10000                |  3.0 ms  |  80.0 ms |

Link: https://lkml.kernel.org/r/20260114143642.47333-1-mathieu.desnoyers@efficios.com
Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Backported without changes ]
Signed-off-by: Dmitrii Chervov <fary.ru@gmail.com>
---
My greeting to you LTS maintainers! This is my second kernel patch.
Servers in datacenters and cloud environments often have many CPUs
and run processes with similar memory footprints. On these systems,
errors in approximate RSS accounting can affect OOM victim selection.
Using precise RSS sums helps the OOM killer select victims based
on their actual memory usage.

 include/linux/mm.h |  7 +++++++
 mm/oom_kill.c      | 22 +++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f05962963e28..baa09a36c4a5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2701,6 +2701,13 @@ static inline unsigned long get_mm_rss(struct mm_struct *mm)
 		get_mm_counter(mm, MM_SHMEMPAGES);
 }
 
+static inline unsigned long get_mm_rss_sum(struct mm_struct *mm)
+{
+	return get_mm_counter_sum(mm, MM_FILEPAGES) +
+		get_mm_counter_sum(mm, MM_ANONPAGES) +
+		get_mm_counter_sum(mm, MM_SHMEMPAGES);
+}
+
 static inline unsigned long get_mm_hiwater_rss(struct mm_struct *mm)
 {
 	return max(mm->hiwater_rss, get_mm_rss(mm));
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8aa712afd8ae..53ab72f747fd 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -229,7 +229,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
+	points = get_mm_rss_sum(p->mm) + get_mm_counter_sum(p->mm, MM_SWAPENTS) +
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
@@ -403,10 +403,10 @@ static int dump_task(struct task_struct *p, void *arg)
 
 	pr_info("[%7d] %5d %5d %8lu %8lu %8lu %8lu %9lu %8ld %8lu         %5hd %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
-		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
-		get_mm_counter(task->mm, MM_ANONPAGES), get_mm_counter(task->mm, MM_FILEPAGES),
-		get_mm_counter(task->mm, MM_SHMEMPAGES), mm_pgtables_bytes(task->mm),
-		get_mm_counter(task->mm, MM_SWAPENTS),
+		task->tgid, task->mm->total_vm, get_mm_rss_sum(task->mm),
+		get_mm_counter_sum(task->mm, MM_ANONPAGES), get_mm_counter_sum(task->mm, MM_FILEPAGES),
+		get_mm_counter_sum(task->mm, MM_SHMEMPAGES), mm_pgtables_bytes(task->mm),
+		get_mm_counter_sum(task->mm, MM_SWAPENTS),
 		task->signal->oom_score_adj, task->comm);
 	task_unlock(task);
 
@@ -598,9 +598,9 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
-			K(get_mm_counter(mm, MM_ANONPAGES)),
-			K(get_mm_counter(mm, MM_FILEPAGES)),
-			K(get_mm_counter(mm, MM_SHMEMPAGES)));
+			K(get_mm_counter_sum(mm, MM_ANONPAGES)),
+			K(get_mm_counter_sum(mm, MM_FILEPAGES)),
+			K(get_mm_counter_sum(mm, MM_SHMEMPAGES)));
 out_finish:
 	trace_finish_task_reaping(tsk->pid);
 out_unlock:
@@ -954,9 +954,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
 		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
-		K(get_mm_counter(mm, MM_ANONPAGES)),
-		K(get_mm_counter(mm, MM_FILEPAGES)),
-		K(get_mm_counter(mm, MM_SHMEMPAGES)),
+		K(get_mm_counter_sum(mm, MM_ANONPAGES)),
+		K(get_mm_counter_sum(mm, MM_FILEPAGES)),
+		K(get_mm_counter_sum(mm, MM_SHMEMPAGES)),
 		from_kuid(&init_user_ns, task_uid(victim)),
 		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
 	task_unlock(victim);
-- 
2.43.0

