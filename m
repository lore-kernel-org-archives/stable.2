Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016177;
	b=n8DMIZ8C1PtqocHNllXlTnG4SGEN7ZLmVchPk6LYmAwzyy0nR5eA9u8Nihkyk6U+WBhV
	 PrxJfTTKewsmXSfYgBBGnAc1DqU8d71n1hmmJb+jDj7+vhkDRQu4BMZ0gCNHv0PCZHlue
	 4pUDyp21U4mhEHhIOB2rHVXjvTbLFFZ+OOCEKUxXHsjtlQjd2tDnFmPy/DgktuT30wZgH
	 vCTehCFrdfTpOseoJ+Dz3E9iNIzFvGRHGqQEEvUqw67L3whq0862br8P1yQnENx0bjun+
	 zh3t6GZY5TQUBJrbkBEYL3Ar9YB1i6aJImZsFfulf8fV59UkjHxSwJVG+fn7bfYriBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RFJJleyh4O8FR2L0iIk2GYhVD/sdkcXc7KlKPVTmZgw=;
	b=URry6TGZP36G64hoIuPrIQT+Ct0iY0Cod1TMEt9GoGXHuWkk+E/bpCqCYzkPUVOA/wQV
	 h7iNgGSfpWzo8UpKJApKwEAgO+r5a3hTykk7nWiKJ269pKHnC47oV35F1Fen5gQriHjL0
	 AZ9vyI663gG+MobB2ynRI1/8bbvOXUKcAeH5mtSsgUIJ01haZU93dNR9C53eG7Cg4PYZC
	 A1z8ZhyqOnvGikyspGBUvbSaNR8L0CJjK6qSVW1SCJx9CF4wP5+Bj++x4odkHCGd6ElYd
	 CqDWLiMwaxwqzU0saPGSzl69Vs9a796Dg48mFdL+geDwHPPMxR4rpD5AVpLJgD4UU0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K4rJlASm;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE160A2604
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47CE160A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K4rJlASm
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2090409a91.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016176; x=1793620976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFJJleyh4O8FR2L0iIk2GYhVD/sdkcXc7KlKPVTmZgw=;
        b=K4rJlASmdIPv97DMDWcrB0zJXkoTNtE9QO7B1Z3zl7VbKMDzMDyWZ1myWlENx1HWFX
         bQvYnQDesVorMvowUBanQwTmhNbS/JkknAE5OY5CehAktnSYyk5P8pOJgiwt8HcWwmed
         5vN/U7/Ai/QpxJ0Js0V9VtCIiGUG7hsyCyBoSSjCYYqrhbAh0az82USZwtYuz4QWHnyK
         aRImYgnbVwZlAClW7z4LJZREsB8h2GnuGvg9+2qqZ9dhn+as4raWRVUyvpTCV2ZvVBDK
         qUdUr+urP/xdQayVLGiAMAOnlGgR+tVsF47U6DCykZRDOyvn6Hf4byPa/DuObRHstU9m
         SHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016177; x=1793620977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFJJleyh4O8FR2L0iIk2GYhVD/sdkcXc7KlKPVTmZgw=;
        b=O3Ztw6XZtThYJfu+7LyVs81sdVWroQGpDQqqKHmAreSGQEJc17w1aPOf5bNjQgpYgQ
         6fl5y09KNWvjKnzreybPe7H+P2ZjS+dvmFY7wON+Xf8q9dxDkrO+IWNzHTMvgKdrB8/X
         SK8A31SbaSevggQoDUsBSZUZ1bsWf2ylHEGHUK10zAYpF9v4dzn2t57Qh744+1XZ8oLd
         xXaw6BGzZeO7ZrJzwd+EN4QhvF10rrpPbiBLUJRXx48BVpb57jxkX9AOH6P4NOuWjN08
         PUdeZNg6M1ZVD5jk8Xk5hN8J/f+hJ9i/TYQH3iHIVGtSJ52/wQmcBHesOhZRGWeKMZ7Q
         vKcg==
X-Forwarded-Encrypted: i=1; AKwUvBwRGNi7gFNpVJTWZysbs39uW3fZXK/GyqYUFpDHWfGPFDkdA2JhSLDIPAO54t8o/b9TtvkVkhQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfY0VA1GwUMu6PXsWvBM17P6Ln7f3Gy/bRbHLOGMu9zV3Coge5
	3i7CxmMbdJLJ/1OcDVSxlUub2QbRrjqSsnTWlxVPnVOv3bQ87A4hbkTO
X-Gm-Gg: AYBFou27rZy65v79qIqt5jt//J5lUs/bJEX0AcAhWfWGFdIfe1NCD/I22r4OO2D4rov
	Ay60GwYq/HBfK30dLhymu82fIrAKBvkSpOFPJy2iRfp+vbO0eZ8zQuhZ8kmU06MAcEwWbGrdELy
	iawVYqmXE8rW92U+WWNI8vg+iE5Pd2Hl4tNZYTFx5cDniqQjLltxEfgxa28wxRwI99zLblU0v1B
	VRWvncMDV9f3xtIwDBlysBVR3KNkavGviRTuDqFn+8ksWmo/A/u82B3FHHnTEg/9AueKUYfmpEF
	SwRazca2x5kL5D2IHiP+wyCtAJnYC7KacoRFQ94MKR4oEbsrSfbuQVVl/P4KWtcdkjtCvryFnKW
	gYv8y1lgwowWvi4i4vK4GW/9tClF75cCmqwPDxotJpiysYE6CRqsMiM1XOXtQb8/tspnYLYgBZ0
	xert6Uj7f97dpIRX9TRqCCBGWgKPjBu1a0UqZaAxyUaxbtpbRXh7PYksUjLFAIQ4pEoRZb5a844
	FWAj31IMq0lpmnnbNAQLwlX7Re4IvUl7RoWcU098fTLXBta8tVDCtVfyl+qv7qswRRgp5PX
X-Received: by 2002:a17:90b:164a:b0:3a4:ba6b:cc24 with SMTP id 98e67ed59e1d1-3adeb137823mr4733512a91.58.1793016176366;
        Mon, 26 Oct 2026 05:02:56 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba47266sm4750299a91.1.2026.10.26.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:02:55 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	penguin-kernel@I-love.SAKURA.ne.jp,
	tj@kernel.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] mm: memcontrol: don't miss processes whose leader has exited in OOM scans
Date: Mon, 26 Oct 2026 20:02:48 +0800
Message-ID: <20261026120248.2188024-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

mem_cgroup_scan_tasks() walks with CSS_TASK_ITER_PROCS, so it sees only
thread group leaders, plus a dying leader that still has live threads.
Moving a process whose leader has exited, by writing its PID to
cgroup.procs, moves the live threads but leaves the leader behind, as
cgroup_migrate_add_task() skips exiting tasks.

The destination's OOM killer then cannot see the process.  If it is
alone there, every attempt ends with "Out of memory and no killable
processes..." and the charge is retried indefinitely, and
memory.oom.group kills nothing; otherwise another process is killed in
its place.  The source's OOM killer still finds the leader, reaches the
moved threads' mm through find_lock_task_mm(), and kills a process that
has left the memcg.

Walk all tasks and take one per thread group: the leader, or the first
live thread once the leader is exiting.  Skip exiting threads, which may
belong to a group that has moved out.

Tested in a VM with memory.max=64M: in each case above the process using
the memory is now killed, and a process whose exited leader was not
moved, or whose leader is alive, is killed as before, with and without
memory.oom.group.

Fixes: f168a9a54ec3 ("mm: memcontrol: use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 mm/memcontrol.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d00748c8a5b..8823c549b6af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1427,6 +1427,36 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 						dead_memcg);
 }
 
+/*
+ * Take one task per thread group: the leader, or the first live thread once
+ * the leader is exiting, since migrating the group leaves an exiting leader
+ * behind.  Exiting threads are skipped, as one left behind may belong to a
+ * group that has moved out.
+ */
+static bool mem_cgroup_scan_skip(struct task_struct *task)
+{
+	struct task_struct *leader = task->group_leader;
+	struct task_struct *t;
+	bool skip = true;
+
+	if (READ_ONCE(task->flags) & PF_EXITING)
+		return true;
+	if (task == leader)
+		return false;
+	if (!(READ_ONCE(leader->flags) & PF_EXITING))
+		return true;
+
+	rcu_read_lock();
+	for_each_thread(leader, t) {
+		if (!(READ_ONCE(t->flags) & PF_EXITING)) {
+			skip = t != task;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return skip;
+}
+
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
@@ -1452,9 +1482,10 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct css_task_iter it;
 		struct task_struct *task;
 
-		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
+		css_task_iter_start(&iter->css, 0, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			ret = fn(task, arg);
+			if (!mem_cgroup_scan_skip(task))
+				ret = fn(task, arg);
 			/* Avoid potential softlockup warning */
 			cond_resched();
 		}

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.43.0

