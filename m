Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046123;
	b=5J9sw+gt+uyxiqL70N0DLyhWctD+701d3dWZpQHd8UtMFcoxIR3LYWz/1bjCL/kfnbbY
	 j6idgJpACAeYe5xicNpYFIzxRjZHIDfuqEFti452lgv2IO4hgLL/HV/bmxPJcdcMPJRRb
	 sp3NnVX9Fcu6+LSHf6YrFvy9k1g5Y1/DhPq/xVNe4sMlsz7+KltXDPdlKCLja77lAWSco
	 6hzH6aHkfQfcLcaF6HqF+R1QYPSjRhfKyDMoHu9BpnIO7cOS8P3H/1/qJ18ZHXOBM/WoM
	 xCdf4acgqMFRLiv4tiKwOHcK3qdy5Cruso9/j+GEoKrIgGjkJOCMiFapAB4LwWGHZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QjUbHaOAtt6V9hzXDK9pMoadry6Qjw/rUpcikRVatMk=;
	b=O4Xdc85/+01Klwxm81yJubVOz+GeHxBf3AfjJTeRnkoRGc93B3k8s9Fx9Phbh/6Qfzbo
	 kHGbzudyObJ/m1Zl9i1YiEngdms5SEKhzp9Zofa6OvoQMmYFgOxM/mIPc0ypnK3rBUXHu
	 PpSTLmhS+Z94GMt8KJuWYG2t2h6mn9XCJVjNH6qGsd4V5/cp/A9giJHDrSxDPfPgZWs6+
	 1vrhxuZJh1p4el2c2nS1BFCfWPAcSuORTIjbD7lSDhFjgmpRUPcKgH4j6wnG8iB7iKjMx
	 zhQsZRadw89UbsrilR3m98SNqibSed13c01Zyo1xJe8uVg4wm/oVHLb1x/FS/6npcow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZVmciXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZVmciXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1971F0089F;
	Sat,  7 Nov 2026 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046123;
	bh=QjUbHaOAtt6V9hzXDK9pMoadry6Qjw/rUpcikRVatMk=;
	h=From:To:Cc:Subject:Date;
	b=DZVmciXgYfb0vd4gnZ3Ib57zmow4D27yrACIAXDbi+OjFNuspjWENLTCMEy4gXGcD
	 svMqwesb4dV3HPyGwADM9tsHU50FU3XiAVh4bQW/VhFXqFGjmbvphM8sBfhziSfNFn
	 ELe4vkGZwyo1vkrVowl4MdbBgeyEh/WN3OL5K94qldZwBBNraop7LeWBI5sCdkNM1E
	 Gxe3eq66+2FZ5LTDsY7oYMLVGAZLAaUGkUG+H7WTv4Qtgopts0PSgiRTtHpKWrJQJF
	 Uhu/nHoMrbKAtq6hYFNLNxDv7B2r2DSltJvPYbELxmoEkX6OCPyHtcCaCwT/iluRh0
	 G9smByT3+ataw==
From: Sasha Levin <sashal@kernel.org>
To: riel@surriel.com,
	mhocko@suse.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:41 -0500
Message-ID: <20261107050841-failed-6.18-d2f28a1a652e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d2f28a1a652e0a43f6f63de9b4e4d8d5f2716803
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050841-failed-6.18-d2f28a1a652e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d2f28a1a652e0a43f6f63de9b4e4d8d5f2716803 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Fri, 28 Aug 2026 13:50:36 -0400
Subject: [PATCH] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on
 isolated cpus

When drain_all_stock() sets FLUSHING_CACHED_CHARGE before checking
isolation, schedule_drain_work() can drop the work in a separate RCU
critical section, and housekeeping_update()'s synchronize_rcu() can race
that second check, leaving the flag set.

drain_local_stock() only clears the bit for work that ran, so the flag
remains set and the stock is never drained again.

Have schedule_drain_work() return whether the work was queued, and clear
FLUSHING_CACHED_CHARGE in drain_all_stock() when the remote CPU is
isolated, so future drains can retry.

Link: https://lore.kernel.org/20260828135036.7d44361f@fangorn
Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/memcontrol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1709ac96bbdec..c6b85e3a5a0b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2306,7 +2306,7 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
-static void schedule_drain_work(int cpu, struct work_struct *work)
+static bool schedule_drain_work(int cpu, struct work_struct *work)
 {
 	/*
 	 * Protect housekeeping cpumask read and work enqueue together
@@ -2315,8 +2315,11 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 	 * pending work on newly isolated CPUs.
 	 */
 	guard(rcu)();
-	if (!cpu_is_isolated(cpu))
-		queue_work_on(cpu, memcg_wq, work);
+	if (cpu_is_isolated(cpu))
+		return false;
+
+	queue_work_on(cpu, memcg_wq, work);
+	return true;
 }
 
 /*
@@ -2348,8 +2351,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &memcg_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
-			else
-				schedule_drain_work(cpu, &memcg_st->work);
+			else if (!schedule_drain_work(cpu, &memcg_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &memcg_st->flags);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2358,8 +2362,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &obj_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
-			else
-				schedule_drain_work(cpu, &obj_st->work);
+			else if (!schedule_drain_work(cpu, &obj_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &obj_st->flags);
 		}
 	}
 	migrate_enable();
-- 
2.53.0




