Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA23264E0;
	Thu, 25 Jun 2026 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394387; cv=none; b=IWXUKmQluHzW07siNPhMwPZ2737ixhZnZIpauaaoFD7Tt5j5TpbwltNjZr/52YirgXzNN2GL4shwvUbXl3OdZuZc5/LxuuLZ3xMZrRxCV62fjILIK/aQMpIpKmdRsyHMGdUaM3gBjbws/2tchCFwNj0ZlldPH2E2ZMC7f0tbrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394387; c=relaxed/simple;
	bh=rg7vFX5qDBFSkwgpGj4yB5kmMBYQnCCsRqKYTNCpZsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpGxKN6vuxWZKiWLehV/Q3IseVIO4vOmIRbdh6WartrQHj0rJ+iApyPj9jZhN75yNElnTfj0EveMPolAa2zEB+EKqlaDAIGZpeWshSjhrRsrfAjTaAzMKIWc5Cou8Xp2iOTBNAe3+NoiE0W65iACtFfhULFmFKsqudMx/Y9CnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=YJPxT/uv; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="YJPxT/uv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782394386; x=1813930386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+uxmeJYzcAM7HYrFQBJrWvH9UT6aWx1tXAC5iB+vPg=;
  b=YJPxT/uv8h0HYc9R7+W3v5N5i+vCY0xb3eaidrhsJ9icKCQ2q1nkJVMO
   kpKfTTlfD38fT+OCng9NzIFggSpRl6UP2VuAwJkIGSTLiOrz9X0+8TI8X
   GGF3LknwSt9WBQaekSpZ7ksdhSl14t0VeG9tWnsV15GpPs2Ho3xfdmKTM
   oRtPDqkDN8ACL/DAY2lqCYO+EUSvFZ0USjDkCc54O56zFNuJfyb0AxvrX
   aaiC5fTpGHrtRn3gLWdPSqVmCv7Glyw/hvtqfidiikZmwvRb5TaeRYCkt
   3kf3CsoaBcSj90gV1duuVaEhXc/8Re1eiUFAlKCpfVCBibQ8C/N1GOE1M
   g==;
X-CSE-ConnectionGUID: AFBQJxPEQZaUTjJiImDqqQ==
X-CSE-MsgGUID: WO9oziArSI2AVkr4+/RRHQ==
X-IronPort-AV: E=Sophos;i="6.24,224,1774310400"; 
   d="scan'208";a="22510404"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 13:33:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13213]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id d472238d-0318-4d1d-8b40-cdee67326c6d; Thu, 25 Jun 2026 13:33:03 +0000 (UTC)
X-Farcaster-Flow-ID: d472238d-0318-4d1d-8b40-cdee67326c6d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 13:33:03 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 25 Jun 2026
 13:33:00 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Simon Liebold <simonlie@amazon.de>, Ian Rogers
	<irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>
Subject: [PATCH 6.1.y 1/2] perf bench: Avoid NDEBUG warning
Date: Thu, 25 Jun 2026 13:32:21 +0000
Message-ID: <20260625133222.3412820-2-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625133222.3412820-1-simonlie@amazon.de>
References: <20260625133222.3412820-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit d1babea9c38282b58a6f822ab95027cba3165a42 ]

With NDEBUG set the asserts are compiled out. This yields
"unused-but-set-variable" variables. Move these variables behind
NDEBUG to avoid the warning.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230330183827.1412303-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 tools/perf/bench/find-bit-bench.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 22b5cfe970237..80f051f9c20fd 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -61,7 +61,6 @@ static int do_for_each_set_bit(unsigned int num_bits)
 	double time_average, time_stddev;
 	unsigned int bit, i, j;
 	unsigned int set_bits, skip;
-	unsigned int old;
 
 	init_stats(&fb_time_stats);
 	init_stats(&tb_time_stats);
@@ -73,7 +72,10 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			set_bit(i, to_test);
 
 		for (i = 0; i < outer_iterations; i++) {
-			old = accumulator;
+#ifndef NDEBUG
+			unsigned int old = accumulator;
+#endif
+
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for_each_set_bit(bit, to_test, num_bits)
@@ -85,7 +87,9 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
 			update_stats(&fb_time_stats, runtime_us);
 
+#ifndef NDEBUG
 			old = accumulator;
+#endif
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for (bit = 0; bit < num_bits; bit++) {
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

