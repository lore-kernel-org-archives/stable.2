Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD783E8359;
	Thu, 25 Jun 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401177; cv=none; b=qIJd8TptJ8+rjr8hEU2E/9aMnvBzr68Cr7lTUwvR87OF22+X3NliT2bMpHY0jlu/UnGz8E5fGKV2gab/Lv8sYWjX+L6ib6wg8HaPgda6/UgnYXLKTxTXFTQNZuOgd1+8G7a0z4srvvaO1MOtElKX0QtAMaZRth+H1i47Vi9HSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401177; c=relaxed/simple;
	bh=jz9fuyTjh0t4eITwjbrSmc2fIOCXvm4ybS3sl93mCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uq1kIpvqcukOWde8kCoZX5zsZkUudw3K5OpxuUj/tXQSHDLZ+DgjUIpzmdHWwqdSpDi0fmA24UibycV8FQKGCog+6ycpnBBldcgpg6wjrbJrYWHq0v5rK+2VIcnj3odkvo7stn7NAzBgUAEZuLsBSb40XM4mMFpdj+2aAaDsJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=EY3F45Dk; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="EY3F45Dk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401174;
	bh=OwmcRXwC4OrIlUB8eo98mnX8ajr2JCkygJ17pPQ9kS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EY3F45DktU7nciOcOua2/yhVRN8c1JtIYotcO4vXyLs16oaE9G1kWAA55kUvwHVMQ
	 s0KnYu+bM8qRYYho1J2UNAM1tIlvdvbtM/JcAPPQg1laAAu9mWDQfcgWxpzSUnpA7I
	 hvHFdIdoY+QRfgA45cXENGtrLknFfINIl9rUwOUc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1f3H79z10v5;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1d5blBz10tb;
	Thu, 25 Jun 2026 15:26:13 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 3/4] powerpc/watchdog: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:57 +0000
Message-ID: <20260625152558.7450-4-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
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

Use sys_info_with_filter() so an explicit all_bt mask does not request
the global default.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..d3a9c6da962d 100644
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
+	sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
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
+		sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-- 
2.53.0

