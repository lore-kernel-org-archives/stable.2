Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246351;
	b=vtMH/A9N4Cs03zUS3Qxr3hjXA6gEJUHOg2FhvhURLUNc/acSYKTXMTsen57HP7aG5NJa
	 HNhxOUAo7qVmkjN5r4DhCH2hBVxmbWYlz0beTgYcCwr7dIzI2LPIe/ZRkv+A8FtezEMGm
	 3wNhiqr6rPAdl93F3pG8ZwrOmPGNFrtylIrUqLd5gxsboaoEfY1W3NAgh9QnIwiMFUILm
	 u/xGa3dZjJxAkcGJ8iiiJlRNCIGs90LKkRpIA9MqY+a8NtdcAG0Bxb1OY71mxu4Ur7XQd
	 rbCz+BVMV0TMZ8z7J10zlbbFOKWXJgcrdG2ijOXaXmQ90Dq6/8MehOxsYUcuC8r6b0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vZXEIX5bRG+X47GzywXngypFAMMr6NGpMI+nKBGpwCc=;
	b=yJlLABEsWWG+4YFouf4WCFTNQrdzu236kOAVoEo6muuVYFoHl7Ov3k5xtp2DaU6CeWug
	 rPYv3asFnXie5lnfcBHXTjKOPiAJqgoODWYPmgRGCg3C4FUgj3kseWmR/RZ1SVUJqyYJX
	 ClaLDS7Ck/dJabUmNg3nSkwZPSpx1R0Mz1z5w5YaiFvZ/FWiIfBo57fMpqv1OF7guqnE2
	 cuICYd4WaceXVVKHOw/CM5Ys8CpSzvCLKLeW33R8dJv2GrNP8XcFhpILWBNf6YP8TF6IG
	 3toN+nrxn+W9iUq1KrZxe/45IdhRXCtNmmM0M45DLYx40Mfr5Ar8Uhsubv39jyWWw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qI5s+qRP;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63187606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63187606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qI5s+qRP
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9e53d011eso13617135ad.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795246350; x=1795851150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZXEIX5bRG+X47GzywXngypFAMMr6NGpMI+nKBGpwCc=;
        b=qI5s+qRPc8lOrId2pgvo/2iBSN/HidJP3kKtKe5Ref0DOKJB8y9o6Sl6ruSIUVdTxu
         luFddQp1/bbZokmYJs5Y4+QmshC+0KoM4JuTA/6kZ+qDbBUm5jLZlgeEJ71FuwES4Nre
         bCnX1om5e4PhAUnuMy8IzexWQej5EpbWDk2rjFiMVnRsoKqQghq7LIPSG3QAW5t6SILv
         cPTTgx8pC1Opcp2W4FJQbsFgdYRaB4I6nv8FwC1NPsKsy7SDwIiVTVISZRFpRzNJqBRl
         fCfFi8vA55yD8RrU4uEeMRWOANIWukzcbubMKu9nKBFhAavfQH8i18W5yICVfo/PZwcV
         91Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795246350; x=1795851150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZXEIX5bRG+X47GzywXngypFAMMr6NGpMI+nKBGpwCc=;
        b=nX39a9vWk4bp+W2A4lcIO8XeyQJ376QdOQsAy6//HY73I1VHw+iIP37EiUimIfx0ty
         xClzNeGYCaWd2pVKDoQmv3W4rvNwKH5q4c9yCl4JsugiS5ezTRJbh3+KjJesXAD+wMnH
         0XfgrwxApUCgMNFBiRmRfrFeLdPAjLR0Q2nF7kBbsn338zk3Vky59+P8WyJkEDl/HuYN
         kc0EydBT245CKWGcW6CmOyJj1ye9zYMrxZpAGa2nVITXrgDABxyum0nHqx6Ir6wRL3Hs
         BK5VnOmZ1crr8narZfYkno4k0eZmxw1ZZHG+pF4UubLWTReYVieRWb219PXxqYo0D62g
         V8Yg==
X-Forwarded-Encrypted: i=1; AL+hErERH5wBDAhUk2mo8rMG14S1iMVgV1qsEb4ASws4V4ebzXb87DNjtjHaOd9X+jBgP8dA4xnxKFo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jLYxlF3CiLs2LpwDNyTDqYw4FZutijFouVb3A6M2j+QM2bZms
	pEat8jbQIzfMUeKmJUbSDPhw0+MU7woU+YqJeviWvi964NMx7eD/5VsL
X-Gm-Gg: AZFdTZewyP+pdtnNvxqCYcvfvL7OPp4G8gRcM08cSE09nT7ZoZh5vnNv879v20tesmY
	1bpMP5a3QoSDGueL4iN4BdqcuchKZd9rbJ0fV+5FmVVP6Ci4oxBasnXcYRoiIljbrjteJzE0qvB
	ZUw2AhnwTdB3xMqFgP1QNt4jBawFA/40a0EzmjKVxmTFqunQymVgygKLjSN6dANQhv+tFmNypMC
	vrM70U1fpmiKnrsFd+pGysj/Oa7S/7aC0eBP7Ceuh0Q81akpF8KKtDufvWgdtkOhqgqWRIOYn+p
	B4F3Z5H6rmNdzvmNGaHAnXMSJgohre+QEGzdh38Ri/oI4iFP5VX2rn53utk+bK1/NRA1ARV+7P/
	XUs2wnGTht787nbBAWhbuYTwk29bJOLua59qxC6GM0Gv5+RJ+i1fMK8pst/j+xP07Qj4K2O+yrY
	gHPhSXg1hufOpX6VX06TvhVDPzTSwIa2ylKHQvr701RkfeoJjVwFACT0BraUtYeM/Nz46szsMOj
	Z5/wVt+q3jzD6gOOKIDKA4wU4vYWf3om+ZP5YGNgA9Uk5b/5WOKKD9Dr2hw8oKiJkJCtbd1PjHz
	w1x3wSXoBimtD0SQf9C0eRdq51db0K4hQABe2irTvj9dkQ==
X-Received: by 2002:a17:902:dacc:b0:2ef:d54b:fb64 with SMTP id d9443c01a7336-2f03f16ca9amr57805835ad.47.1795246349410;
        Fri, 20 Nov 2026 23:32:29 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ddf40sm23423465ad.37.2026.11.20.23.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:32:28 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	tj@kernel.org,
	mkoutny@suse.com,
	chris@chrisdown.name,
	cui.tao@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v3] mm: memcontrol: don't miss processes whose leader has exited in OOM scans
Date: Sat, 21 Nov 2026 15:32:22 +0800
Message-ID: <20261121073222.834282-1-zhanxusheng1024@gmail.com>
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

Walk all tasks and let one task of each thread group in the memcg stand
for it: the first one that is not exiting, the first one that has not
exited yet once the whole group is exiting, or the leader once every
thread has exited, so that an OOM victim stays visible until it is gone,
as the leader does today.  Exiting threads left behind do not count
while the group has live threads elsewhere.

Tested in a VM with memory.max=64M: in each case above the process using
the memory is now killed, and a process whose exited leader was not
moved, or whose leader is alive, is killed as before, with and without
memory.oom.group.

Fixes: f168a9a54ec3 ("mm: memcontrol: use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v3:
 - Rebase on "mm: memcontrol: don't lose track of exiting OOM victims"
   in mm-hotfixes-unstable and keep CSS_TASK_ITER_WITH_DEAD
 - Let the leader stand for the group once every thread has exited, so
   such a victim stays visible as it does with that patch alone

Moving the exited leader along with its threads came up on v1, and
there has been no answer from the cgroup side.  cgroup.kill had the
same case: da13e0e72a73 ("cgroup: fix cgroup.kill for exited thread
group leader") walks all threads instead of the leaders, and
5f4a3f743acc ("cgroup: don't kill migrated processes through their
exiting threads") then had to keep an exiting thread left behind from
standing for a process that has moved out.  This patch does the same
for the memcg scan; the second case is what the live_elsewhere check
covers.

Retested on mm-hotfixes-unstable 2ba4d2c9ae3c: the cases in the
changelog behave as described, and with the reproducer from the review
of Chris's patch, memory.max=400M, 10 runs, oom_kill is 1 in every run
with and without this patch.

v2: https://lore.kernel.org/all/20261027144016.2582880-1-zhanxusheng1024@gmail.com/
v1: https://lore.kernel.org/all/20261026120248.2188024-1-zhanxusheng1024@gmail.com/

 mm/memcontrol.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index afbb638e7e1c..3355341666db 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1426,6 +1426,44 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 						dead_memcg);
 }
 
+/*
+ * Let one task of each thread group in @memcg stand for the group: the
+ * first one that is not exiting, or, once the whole group is exiting, the
+ * first one that has not exited yet, so that an OOM victim stays visible.
+ * The leader is not enough: a group whose leader has exited can be moved
+ * without it.  Exiting threads left behind in @memcg do not count while the
+ * group has live threads elsewhere.
+ */
+static bool mem_cgroup_scan_skip(struct mem_cgroup *memcg,
+				 struct task_struct *task)
+{
+	struct task_struct *t, *dying = NULL;
+	bool live_elsewhere = false;
+
+	guard(rcu)();
+	__for_each_thread(task->signal, t) {
+		bool here;
+
+		if (READ_ONCE(t->exit_state))
+			continue;
+		here = mem_cgroup_from_task(t) == memcg;
+		if (!(READ_ONCE(t->flags) & PF_EXITING)) {
+			if (here)
+				return t != task;
+			live_elsewhere = true;
+		} else if (here && !dying) {
+			dying = t;
+		}
+	}
+	/*
+	 * Once every thread has exited, the leader stands for the group until
+	 * it is gone, as with CSS_TASK_ITER_PROCS.
+	 */
+	if (!dying)
+		return live_elsewhere || !thread_group_leader(task);
+	return live_elsewhere || dying != task;
+}
+
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
@@ -1456,10 +1494,10 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		 * torn down. Keep it visible so oom_evaluate_task() can
 		 * back off while there's still memory to free.
 		 */
-		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS |
-				    CSS_TASK_ITER_WITH_DEAD, &it);
+		css_task_iter_start(&iter->css, CSS_TASK_ITER_WITH_DEAD, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			ret = fn(task, arg);
+			if (!mem_cgroup_scan_skip(iter, task))
+				ret = fn(task, arg);
 			/* Avoid potential softlockup warning */
 			cond_resched();
 		}

base-commit: 2ba4d2c9ae3cfdad96ee925c92b14d7acd886954
-- 
2.43.0

