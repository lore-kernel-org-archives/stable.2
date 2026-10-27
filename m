Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112026;
	b=bi/pYcrYFcSPDL2PmdexkznLtGpNw4mQLcWGZ4DE1pwbH/fIw0T6ZoNA4jlv89K83QUl
	 fsp/ENEqSW/buaJPwFtIt06akHDjtqHymzSOJWEcKkKebyeUhdc9J490r61eDQ1EBdCPH
	 1LVBdUIArBNVVXJU6byaLYrqFg9XiMmAHJ43L43pr7+lXyBDnpnqnRE2z0iFsf0qto1Av
	 x0Le0yQYydDpb9dIJiWktTxJcFJGt9KV2Z1Ot7AOZsaiOL+0xzIczO6FMjT5wx3gOFl/s
	 18Nh3GxsaT4n74BRXc1YFE3OfTRvW3TlNzi+uNQagHScU/21hFuYkajJ4ActVGRK5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T1E/r4jGzpmWVwuykcjDGwY++XCWizWnAfM22Qf0RY4=;
	b=cI3A9L0XWHkK0WYyPp3snEyGCLftUmCWuOITjtiNuKcDF+YWMt6+P0l0xPILPvaJp9df
	 nZVrp+ypLBjq0Fg2i9aJpy0QbihdxS2gce7jl2wH1q+2NkGCIeS+yOIEboTfgjteJONsU
	 WUP3g78v+h4dVwsflAnEIUNKhEBRFEG2GX6fTDfa2dT/cFql7/DmzzP2Xsf3tNiF2CvWB
	 svwxRFmSK0ZmRjPFPW1PPebGv9zbEBDIJEn9j8ZR8KqGrIFyx+HNkxIlbvcVCJOormpA5
	 fiTgpdDnTZ3jThsY9z10hqzjtN8czSMChn1TOQlHLs05Si8fP7pfzp4qKcOeGAZmd9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hkV/NtVt";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9D606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkV/NtVt
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a1947498bso673844eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112025; x=1793716825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1E/r4jGzpmWVwuykcjDGwY++XCWizWnAfM22Qf0RY4=;
        b=hkV/NtVt+9hXtT9TZ9RxA6SHUJvK+GPTgc7A8PHd3EKBSKD3xBsljRYWpxqzEYgQCY
         bL4seHN3+U1JnaHXaX3LX2BNV8JPAXAzLWzUWSui5RMzk9bXwZoDtvDxC0FoVcVXsCuE
         ASPqN4tjjGCxsD1kDzfEVaj+mHUzAQCadoyg3ydo8f0zRLD7+Xd8EJKYvhNjF8r+zjSD
         NGtaTbWD1DtZcWTAO7ma3n/NxUfx8uFoLjuUsw3xZ6JqaaO1elRU8hP9zjxOok7z4Gds
         gwfmurKxf6SwF9qTedwOh0cEu7yTSI1J9+syn8RS88M7plXs4SsoCbQgRLplbaNxb8ya
         uoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112025; x=1793716825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1E/r4jGzpmWVwuykcjDGwY++XCWizWnAfM22Qf0RY4=;
        b=PO33IcvQuMwqfPH1b1ZzQ4ZboqO7k9vb2tlIVmg9IqhkD14A7m8NFO9nhBvP9uUElf
         SM3DtlAcWD24FaTmuabZ9zIWWCh3fl/Ci/2gS04GjwRDxRHDhxnCvEF7cCarcK+PDc5G
         xR+oXV5MoVCzbYp0C9mWB4exoR0S0SIKsvHgidnMu2cTYYFL1vgLUHv/2oDGk5TaIENv
         5aktJ6mcVooCVxoXaMjYeumVGSpTk1Zth7szS/dhCVr92LVkxEOgm07x4P9LnAH6IY5U
         B7jRbX0QmAi33M+czVONI2CkFCeN38ITpN0LeTUsUWpGwjVevwxkd1yfXe3f7g1SMnCD
         XMGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsBUFCKfgMVS5FoSLPXZff0gOplS5WB3Qx9Ey3xdEyqUp5sRHx5xax29yS4srmX2iwhAshe+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqXO7icapAI7sz6PL0PhC/yk6gISjsugj56aGOwFpygmeUCGjB
	sEkeFJhhTj5SdvvftrT308DgdK6UjoK7if/9a8QXYYyKaKAY2XU/YMaq
X-Gm-Gg: AYBFou3swG2NcyQGVGJUyM9n0XFqfPnXOv0KsGvOmsBwq2BtUNRBqtpBRtc2iB4aZ1B
	Tsa7IBNhDS3Xvk3xsSdeQhiZLjOwYraeQMAGIkn8T6jhL99LniJ69qyaeGSAfsbQLpo3UcE8v5E
	mz+/z+k/0MmxjRFZoC4U0Yh59LZAWAhocSqGXOZrP5qJ0fgr6RbBadZowaz0ooS/e7MaY8Rywh+
	EnmE9ymaVlhmlb2ES42AeKaV+j9WwDdDi+DNRObFvinttM5zA/ijiuFtXAxU/bDOr7o1fIxurUq
	Qg2dz1zQBz8wdfPVOXJvjT9Q/0Aqjw7V0Nyxy8Smyx2lIAOUzianUTwD/gRFEzo2FY8dDTmebnv
	edYssQPCDKhedvYG3R655KRPvNR4JJME+ZvgNhveIZZrl+0l8QJ7JO69LWBORAciuaj2nghvpn9
	dFwWSA7uT6w7uAMf/xboW/QR+HsEeKDthDXAXubCvhLXGcrkwgrlaCUcbpVbLUf5WyW9zyu/tnu
	yqfJJaGFJZN1WoSIBIiNChqd1ESID+u4cctr6YryUfvBtjqViir9miG61JCYmfJ+balrD22T7mz
	LNQeCUNYl46+sE5EhA==
X-Received: by 2002:a05:7300:2301:b0:347:8d01:164f with SMTP id 5a478bee46e88-369e84b15ccmr22877138eec.19.1793112023769;
        Tue, 27 Oct 2026 07:40:23 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm34727318eec.20.2026.10.27.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:40:23 -0700 (PDT)
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
	cui.tao@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: memcontrol: don't miss processes whose leader has exited in OOM scans
Date: Tue, 27 Oct 2026 22:40:16 +0800
Message-ID: <20261027144016.2582880-1-zhanxusheng1024@gmail.com>
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
for it: the first one that is not exiting, or the first one that has not
exited yet once the whole group is exiting, so that an OOM victim stays
visible until it is gone, as the leader does today.  Exiting threads left
behind do not count while the group has live threads elsewhere.

Tested in a VM with memory.max=64M: in each case above the process using
the memory is now killed, and a process whose exited leader was not
moved, or whose leader is alive, is killed as before, with and without
memory.oom.group.

Fixes: f168a9a54ec3 ("mm: memcontrol: use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - Do the whole check under RCU and walk the group through task->signal;
   v1 read task->group_leader, which a reference on a thread does not pin
 - Keep exiting threads visible while the whole group is exiting, so a
   concurrent scan still finds an OOM victim and aborts
 - Pick the representative among the tasks in the scanned memcg

Tao's Reviewed-by and Tested-by are not carried over, as the check
changed.

The walk visits every thread again, as it did before f168a9a54ec3, but
the check stops at the first thread of a group whose first thread is
live and in the scanned memcg, which is the usual case.  A group can
still be visited twice, or not at all, if the task standing for it
finishes exiting during the scan.

v1: https://lore.kernel.org/all/20261026120248.2188024-1-zhanxusheng1024@gmail.com/

 mm/memcontrol.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d00748c8a5b..cdb8ca4d4625 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1427,6 +1427,38 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
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
+	return live_elsewhere || dying != task;
+}
+
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
@@ -1452,9 +1484,10 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct css_task_iter it;
 		struct task_struct *task;
 
-		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
+		css_task_iter_start(&iter->css, 0, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			ret = fn(task, arg);
+			if (!mem_cgroup_scan_skip(iter, task))
+				ret = fn(task, arg);
 			/* Avoid potential softlockup warning */
 			cond_resched();
 		}

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

