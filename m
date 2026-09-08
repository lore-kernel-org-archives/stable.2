Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2653CA73
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870038; cv=none; b=TykY7JwQm6Rc96NitKnla55N4m42C2Eqs3G9kn0Ec1UvIUbx0Szlf20gUQHApVLiKsy688XtUh4Amv/ds/3fTb4r36fLkqg8nSqGssmUAAm9IVEGzWbgNT52QoAR/F+KqsH90RA3nAZwgw1lPsHcGCRKLOoe4Ga9sTVxWtGdnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870038; c=relaxed/simple;
	bh=Z6AVLp7LBBLGGlvrTOurTMYzKesTEMQCu0Xpe9tUmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl0oHmsdRH16RuWO5Uiy3zckye0ZvSvkIj7Cb6hwMEmQgMJltcUPLivZzMo0HA/8lJU8wk2Aq/MOimHVBKivKJRmqJb4qzSzbFq/Ac/lrdMkfnPzrfqQKGpPGKq+0jG9D5gyhwV2Pgz5NwHWOavqVjVI8N2YaNmkpSvfGjU4SwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daq3yaT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daq3yaT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3E71F00ACF;
	Tue,  8 Sep 2026 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870033;
	bh=O1jJAX+zWPeHN2hVW5nyn/KhLYhsiRkKcphdKuLhqfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daq3yaT1Gb2cRla8JcOyzhe/HExS3OcKrFx5s0kayf0Y/H4+8JqRqzzpv+rwLCyJY
	 APAKa2pnGaLL+9H0zFJ3uwqospdtDMEkXUuu0ppJt3ma3RA8M2taC4ntCIzOyEIt+n
	 dR8g92Gkd16ZGRADV8zpNQNUYlso84QlinfbxnF2iu9+940qX989jTw46UUZ942ROp
	 frlOq7VDpfV2OAYlJ59jQXDeWP+htKCiHjDnlnvwEQ1uuZJ/Pctk27l3Om86xySn0c
	 DZaoH/yCIu32hGAirmdFAy4t42ifwZQ3ciik7XJppxRyU/smfr6J7ljTcT6wyI8H8A
	 5tLc2Z0zX/d1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Uladzislau Rezki <uladzislau.rezki@sony.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alex Belits <abelits@marvell.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
Date: Tue,  8 Sep 2026 08:20:25 -0400
Message-ID: <20260908122026.2052281-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122026.2052281-1-sashal@kernel.org>
References: <2026090325-ardently-jaybird-f824@gregkh>
 <20260908122026.2052281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 2a0aafce963dab996b843f6cdb49237b0ae4a118 ]

context_tracking_cpu_set() is called in order to tell a CPU to track
user/kernel transitions. Since context tracking is going to expand in
to also track transitions from/to idle/IRQ/NMIs, the scope
of this function name becomes too broad and needs to be made more
specific. Also shorten the prefix to align with the new namespace.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Stable-dep-of: 7e8ee82e69fd ("ARM: 9477/1: Disable broken eBPF JIT on the Risc PC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/context_tracking.h | 2 +-
 kernel/context_tracking.c        | 4 ++--
 kernel/time/tick-sched.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index c96f194eff136..2464c12d4b804 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -11,7 +11,7 @@
 
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern void context_tracking_cpu_set(int cpu);
+extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __context_tracking_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 58e42213bf12f..762eb23ac2244 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -228,7 +228,7 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init context_tracking_cpu_set(int cpu)
+void __init ct_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
@@ -258,6 +258,6 @@ void __init context_tracking_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ae1b207c64479..da31133180c7e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -591,7 +591,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.53.0

