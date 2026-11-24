Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513288;
	b=f71km6oBa7jsT3dASPROamadzEK6E/wBla5R6RjwrXSY/LfLmqAaREjaai9BJSxeV9BJ
	 J7FH1zJKku0l5jeUSKn6pYqu6C3fG5wkneBnFo7zMMBKe5rpM2l43AasEoAlCbOTKk94v
	 pVKhvgZMk0Q2Qx2TtVakQtAGq0ZxdIqobNvvhKeoG7KOhf1XR67Fxr7nIn72tJnd1N6xK
	 e9OmV68PVENeu9x2sqoD1TrvUyh5Ux2GVn7fxqzWlzoOtUWFQkq9Hls38BZxDbD7LnC2w
	 NxBInP0NgE0NVIQieKfVItt9uplqGPa5m3wEzvsCg5xSGMDqASyg1km7SMOwbD0H42A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513288;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=9RUqJuZjjF4EFmIXY+oekF6v4fxHg7gQYiw1+M/5kjk=;
	b=YaXrTMwhyrwdWr6JxjNFORmgiKmrwQdRkMjOj7mxNnI+2yBZayprE3QhozxZi0AvOHfQ
	 Tm05Wgzz+05RnHQzee58jF/qdJ6NwPOJ7RkszX88l02jqbquSQ2aiIw8DBhzMLlI6L+rW
	 sQ4AG/CAo90yYJjU1Tsi4dlXbWulF98BJVy9Ac5aZrgyNHK73Q38n+yZh+WMXunwvbyzp
	 r3Q9sdbk5rd+Aet8KUQ3CoKFmXcvoylB829nzGRI18ZFEiU7/IB/iIuYepKZRv2Te6kmX
	 sE+bcqE9qyyX9HKEHdz97CCaSqx7fggsRKvqCCKyABu5X89ik4IMavs7Ht9LnpX35Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EJLDe3U8;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02560A2627;
	Tue, 24 Nov 2026 09:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F02560A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EJLDe3U8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795513286; x=1827049286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9RUqJuZjjF4EFmIXY+oekF6v4fxHg7gQYiw1+M/5kjk=;
  b=EJLDe3U8xGVUZJ4UHdNQYlSyMMNqhhrNVmse5q+JyFHp2qHSO7u3Luu0
   /5LDGlr6K1Aj0XcWC23uRFfIM/9yoPvqzbnv2E6rXYUBsw+9Odu5/0OwT
   qXGPoG8OIqIROWa7Og/jzIrbacUwJrZS7yAS5TPqbGJ3uO2WDLv/OCxuk
   y1xiCG4v3jaEL1tX2/fP65Ix3ujnJ9M1rGUNXPN9x51T/yZH+b39mAv1a
   eBpE7hTV9/vyTC1nvKSHaf1qG69eaF1kV39bsAp2dGKreuCgEpqWKdqVq
   TUC0vIoqSm1ymf2t2AkybF0dylw4o8p95/4JLjbus+onwezwepafOg4Wm
   A==;
X-CSE-ConnectionGUID: QdMdIDfITy6SQLr3B1ZFmw==
X-CSE-MsgGUID: P5vxPcEZRd2nUC4+xhtyoA==
X-IronPort-AV: E=Sophos;i="6.27,230,1787011200"; 
   d="scan'208";a="34971951"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:41:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:2261]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.12:2525] with esmtp (Farcaster)
 id 12c28dd8-953b-4045-aff1-3d5406bd0857; Tue, 24 Nov 2026 09:41:22 +0000 (UTC)
X-Farcaster-Flow-ID: 12c28dd8-953b-4045-aff1-3d5406bd0857
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Tue, 24 Nov 2026 09:41:22 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Tue, 24 Nov 2026
 09:41:18 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Fernand Sieber <sieberf@amazon.com>, Karl Mehltretter
	<kmehltretter@gmail.com>, <stable@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Daniel
 Bristot de Oliveira" <bristot@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Josh Don <joshdon@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Fahad Mubeen <fmubeen@amazon.de>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Misha Karataiev <karataev@amazon.com>,
	Hendrik Borghorst <hborghor@amazon.de>, Ibrahim Elshahed <lshahed@amazon.de>
Subject: [PATCH 2/2] selftests/sched: Let the FIFO task block in cs_dl_server_test
Date: Tue, 24 Nov 2026 11:40:31 +0200
Message-ID: <0bea929ef61909f5eb5038d111027e1d5e710fee.1795510960.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795510960.git.sieberf@amazon.com>
References: <20261124080737.1988-1-kmehltretter@gmail.com> <cover.1795510960.git.sieberf@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The FIFO child of cs_dl_server_test never blocks, so forced idle on its
sibling only ends through the fair server's pick. The test therefore
missed forced idle charged to the fair server when the cookied task
blocks and the sibling's core-wide pick ends forced idle.

Run the test a second time with the FIFO child spinning 800us and
sleeping 10us, and hold that pass to the same floor of half the fair
server's reservation.

Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Closes: https://lore.kernel.org/all/20261124080737.1988-1-kmehltretter@gmail.com/
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 .../selftests/sched/cs_dl_server_test.c       | 107 +++++++++++-------
 1 file changed, 68 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_dl_server_test.c b/tools/testing/selftests/sched/cs_dl_server_test.c
index 38aa005080f1f..c085f7059e054 100644
--- a/tools/testing/selftests/sched/cs_dl_server_test.c
+++ b/tools/testing/selftests/sched/cs_dl_server_test.c
@@ -14,6 +14,10 @@
  * whenever the FIFO task runs, and checks that the CFS task still gets a
  * sensible fraction of the fair server's reservation.
  *
+ * A second pass lets the FIFO task sleep briefly between spins, so forced idle
+ * mostly ends through the core-wide pick made when the FIFO task blocks rather
+ * than through the fair server.
+ *
  * Copyright (c) 2026 Amazon.com, Inc. or its affiliates.
  */
 #define _GNU_SOURCE
@@ -21,6 +25,7 @@
 #include <limits.h>
 #include <sched.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -48,6 +53,8 @@ enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
 
 #define RUN_TIME	5	/* measurement window, in seconds */
 #define FIFO_PRIO	50
+#define FIFO_SPIN_US	800	/* blocking pass: spin this long ... */
+#define FIFO_SLEEP_US	10	/* ... then sleep this long */
 
 /*
  * The reservation is only approached, not reached: every slice the fair server
@@ -208,6 +215,20 @@ static double monotonic_now(void)
 	return ts.tv_sec + ts.tv_nsec / 1000000000.0;
 }
 
+/* Spin for FIFO_SPIN_US, then sleep for FIFO_SLEEP_US, until killed. */
+static void spin_sleep_forever(void)
+{
+	struct timespec nap = { .tv_nsec = FIFO_SLEEP_US * 1000 };
+	double until;
+
+	while (1) {
+		until = monotonic_now() + FIFO_SPIN_US / 1000000.0;
+		while (monotonic_now() < until)
+			;
+		nanosleep(&nap, NULL);
+	}
+}
+
 /*
  * Diagnostic only: how long the FIFO task's CPU was forced idle. Needs
  * CONFIG_SCHEDSTATS and schedstats enabled, so it must not gate the result.
@@ -233,7 +254,7 @@ static void print_forced_idle(pid_t pid)
 }
 
 /* Cookied SCHED_FIFO spinner. Only this task gets a cookie. */
-static void fifo_child(int cpu, int ready_fd)
+static void fifo_child(int cpu, int ready_fd, bool blocks)
 {
 	struct sched_param param = { .sched_priority = FIFO_PRIO };
 
@@ -252,6 +273,8 @@ static void fifo_child(int cpu, int ready_fd)
 		signal_status(ready_fd, CHILD_ERROR);
 	}
 	signal_status(ready_fd, CHILD_READY);
+	if (blocks)
+		spin_sleep_forever();
 	spin_forever();
 }
 
@@ -287,45 +310,18 @@ static void kill_child(pid_t *pid)
 	*pid = -1;
 }
 
-int main(void)
+/*
+ * Run the FIFO and CFS spinners for RUN_TIME and check the CFS task's share.
+ * With @blocks the FIFO task sleeps between spins.
+ */
+static void test_forced_idle(int sib0, int sib1, double want, bool blocks)
 {
-	double fifo_runtime, cfs_start, cfs_end, t_start, t_end, share, want;
-	unsigned long long runtime, period;
+	double fifo_runtime, cfs_start, cfs_end, t_start, t_end, share;
 	pid_t fifo_pid = -1, cfs_pid = -1;
 	int fifo_ready[2], cfs_ready[2];
-	unsigned long long cookie;
-	int sib0, sib1;
+	const char *pass = blocks ? " (FIFO task sleeps)" : "";
 	char status;
 
-	ksft_print_header();
-	ksft_set_plan(1);
-
-	if (read_sibling_pair(&sib0, &sib1)) {
-		ksft_test_result_skip("CPU0 has no SMT sibling\n");
-		ksft_finished();
-	}
-	ksft_print_msg("SMT siblings: CPU%d (FIFO) and CPU%d (CFS)\n", sib0, sib1);
-
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, 0, PIDTYPE_PID,
-		  (unsigned long)&cookie)) {
-		ksft_test_result_skip("core scheduling unavailable: %s\n",
-				      strerror(errno));
-		ksft_finished();
-	}
-
-	if (read_fair_server(sib1, &runtime, &period)) {
-		ksft_test_result_skip("cannot read " FAIR_SERVER "/cpu%d, debugfs not mounted?\n",
-				      sib1);
-		ksft_finished();
-	}
-	if (!runtime || !period) {
-		ksft_test_result_skip("fair server on CPU%d is disabled (%llu/%llu)\n",
-				      sib1, runtime, period);
-		ksft_finished();
-	}
-	ksft_print_msg("CPU%d fair server reservation: %llu/%llu ns = %.3f%%\n",
-		       sib1, runtime, period, 100.0 * runtime / period);
-
 	if (pipe(fifo_ready) || pipe(cfs_ready))
 		ksft_exit_fail_perror("pipe");
 
@@ -334,7 +330,7 @@ int main(void)
 		close(fifo_ready[0]);
 		close(cfs_ready[0]);
 		close(cfs_ready[1]);
-		fifo_child(sib0, fifo_ready[1]);
+		fifo_child(sib0, fifo_ready[1], blocks);
 	} else if (fifo_pid < 0) {
 		ksft_exit_fail_perror("fork FIFO child");
 	}
@@ -348,7 +344,7 @@ int main(void)
 		close(cfs_ready[1]);
 		if (status == CHILD_EPERM) {
 			ksft_test_result_skip("need privileges for SCHED_FIFO\n");
-			ksft_finished();
+			return;
 		}
 		ksft_exit_fail_msg("FIFO child setup failed\n");
 	}
@@ -388,7 +384,6 @@ int main(void)
 		ksft_exit_fail_msg("cannot read CLOCK_MONOTONIC\n");
 
 	share = (cfs_end - cfs_start) / (t_end - t_start);
-	want = MIN_SHARE_OF_RESERVATION * runtime / period;
 
 	ksft_print_msg("FIFO task ran %.3fs, CFS task ran %.3fs over %.3fs\n",
 		       fifo_runtime, cfs_end - cfs_start, t_end - t_start);
@@ -396,7 +391,41 @@ int main(void)
 		       sib1, share * 100, want * 100);
 
 	ksft_test_result(share >= want,
-			 "CFS task gets the fair server reservation while forced idle\n");
+			 "CFS task gets the fair server reservation while forced idle%s\n",
+			 pass);
+}
+
+int main(void)
+{
+	unsigned long long runtime, period;
+	unsigned long long cookie;
+	int sib0, sib1;
+	double want;
+
+	ksft_print_header();
+
+	if (read_sibling_pair(&sib0, &sib1))
+		ksft_exit_skip("CPU0 has no SMT sibling\n");
+	ksft_print_msg("SMT siblings: CPU%d (FIFO) and CPU%d (CFS)\n", sib0, sib1);
+
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, 0, PIDTYPE_PID,
+		  (unsigned long)&cookie))
+		ksft_exit_skip("core scheduling unavailable: %s\n",
+			       strerror(errno));
+
+	if (read_fair_server(sib1, &runtime, &period))
+		ksft_exit_skip("cannot read " FAIR_SERVER "/cpu%d, debugfs not mounted?\n",
+			       sib1);
+	if (!runtime || !period)
+		ksft_exit_skip("fair server on CPU%d is disabled (%llu/%llu)\n",
+			       sib1, runtime, period);
+	ksft_print_msg("CPU%d fair server reservation: %llu/%llu ns = %.3f%%\n",
+		       sib1, runtime, period, 100.0 * runtime / period);
+
+	ksft_set_plan(2);
+	want = MIN_SHARE_OF_RESERVATION * runtime / period;
+	test_forced_idle(sib0, sib1, want, false);
+	test_forced_idle(sib0, sib1, want, true);
 
 	ksft_finished();
 }
-- 
2.47.3




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07

