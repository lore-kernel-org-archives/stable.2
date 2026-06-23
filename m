Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE72DCC1C;
	Tue, 23 Jun 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228913; cv=none; b=Nzf3QARzgzsA4LM9mHgCdsJke00vlWlWKPvM31rU4k85iOw7qVHDfF+8wuojWlFYIx7YoA6rktaoMKIpfykTKRHcWcaRX0t8/2LKMMGN8W0ZraWQUw5ylIIfhqgrBDUGlBn3Mo16sS8n7M5k9AvvrrhZFHBf4scNwWaOlJkPS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228913; c=relaxed/simple;
	bh=SjLtyaL91bTnbCOPCH0D5LX6mWYJPA5V9F2HIyYhNSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZMG966eeMc7eULsLp+F0IQBdwg4aJXV+gSmNsJl5P++DIuI36ttZ/Nhy009q0OLkPGLKfFkat/pOOUVluf+RzZctQT5ez0jpOjHgBxw7MscxUUVoJefQnie6/fRXOrMn++cOhxVm8+qxR3wgK5yX0tPLdRgEPChiSV7YURIA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=hz41nq6C; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="hz41nq6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228910;
	bh=Uip+6pol1RtIR3cScKDKsDw9xFYuq25oTXx0BH2GssA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz41nq6CvwLTOGNnMSJCTGOF3q+HqVCmmrgQGYcS1yyjzcT7BLHxATDm+i9u5wVLG
	 yK5apygC/Vv9txFnngu5IsEqfBJwdQVUX3BlD3LTc3muOdcOkXCGHaCDs8Ce6OdNMU
	 WEQZ9vfv5pOKPlnyiM/axIZUv5Arz89jYAIqzX40=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jt2RpBz10xv;
	Tue, 23 Jun 2026 15:35:10 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Js113Hz10xZ;
	Tue, 23 Jun 2026 15:35:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 3/4] powerpc/watchdog: avoid sys_info fallback for all_bt
Date: Tue, 23 Jun 2026 15:35:00 +0000
Message-ID: <c78a3377b26023cff23d176c029d03d79645b3e6.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The powerpc watchdog prints all CPU backtraces itself. When the watchdog
mask contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
sys_info(0) falls back to kernel_sys_info.

Use sys_info_without_all_bt() so an explicit all_bt mask does not request
the global default.

Fixes: e561383a39ed ("powerpc/watchdog: add support for hardlockup_sys_info sysctl")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- Use the shared sys_info_without_all_bt() helper.
- Keep the powerpc watchdog change in its own patch.

 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..813f9d48a6be 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -201,6 +201,7 @@ static bool set_cpu_stuck(int cpu)
 static void watchdog_smp_panic(int cpu)
 {
 	static cpumask_t wd_smp_cpus_ipi; // protected by reporting
+	unsigned long si_mask;
 	unsigned long flags;
 	u64 tb, last_reset;
 	int c;
@@ -236,8 +237,9 @@ static void watchdog_smp_panic(int cpu)
 	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld (%lldms ago)\n",
 		 cpu, tb, last_reset, tb_to_ns(tb - last_reset) / 1000000);
 
+	si_mask = READ_ONCE(hardlockup_si_mask);
 	if (sysctl_hardlockup_all_cpu_backtrace ||
-	    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
+	    (si_mask & SYS_INFO_ALL_BT)) {
 		trigger_allbutcpu_cpu_backtrace(cpu);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	} else {
@@ -251,7 +253,7 @@ static void watchdog_smp_panic(int cpu)
 		}
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info_without_all_bt(si_mask);
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
 
@@ -371,6 +373,7 @@ static void watchdog_timer_interrupt(int cpu)
 
 DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 {
+	unsigned long si_mask;
 	unsigned long flags;
 	int cpu = raw_smp_processor_id();
 	u64 tb;
@@ -418,11 +421,12 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
+		si_mask = READ_ONCE(hardlockup_si_mask);
 		if (sysctl_hardlockup_all_cpu_backtrace ||
-		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
+		    (si_mask & SYS_INFO_ALL_BT))
 			trigger_allbutcpu_cpu_backtrace(cpu);
 
-		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info_without_all_bt(si_mask);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-- 
2.53.0
