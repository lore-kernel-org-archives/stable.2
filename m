Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589043;
	b=AE7OpC66FQobCsSYOTk3qAePu73SOketHlObJItFw4l/VJXlS/NEzzpRZsbpjIFInk8Z
	 vzRnC6q9nfJtjAdaSd9kft/qH9yG/r5msdq40rl5v4k3GsvNg++GLn776CuLth0iGt0GC
	 vtbqm0SPxlFIJ4PIUCVnoP3qsVAeXrq3Txg60n8Wd6A6bD73AQaD9rMsUwYH136QU0dNz
	 j7ZUn7MyqwaVOYhBteZH7tC7acpISMjCwrKVAPrBWdUHBctvhogXj2ggX60n1gB4puW5d
	 DyBOd9fDr+JDeVDlSPz2BXzMQgQlABefRb1Orwzv+iRnJQgbjxY80yRID80IfJ2X3EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589043;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NANNzTYSJub7EmcO8Yd3F4cFaZ67vaqTLlXt8SDnfn0=;
	b=g0fZ08Nn+xG4BgUyRPNQiOkdYaa0fTH7x+AxWa3nE4o/qO3D22kwUOcSlJY7x8uQr/l8
	 ppSUHtB1HdXlzY3J26dVz5mk8MSaYJbodRVVi6jcO66V9W7CIl1OHD5wOvYcl1qFgys7V
	 IxwVjCX4823Mh2sGCK1FBAuTrLZ86G0CC+AobLiPlE2fWCJKW0d9QXRxgyemQ9KQHuV2f
	 vjfNJaztsyEGOQyQj7ksSriOnfB0560WJVfsfRtRc9aYNAhFJZkVXznG80y1AjUOlmdow
	 gH3XXVIn4J1IyllTK7rUF7hp+tRfsrAmkLqrVlUGWqCh6r3mHC2/+wRp8Jg3Ds8U5UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=McGaUro5;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA78606A32E;
	Fri, 13 Nov 2026 16:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA78606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=McGaUro5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794589039; x=1826125039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NANNzTYSJub7EmcO8Yd3F4cFaZ67vaqTLlXt8SDnfn0=;
  b=McGaUro5p8TaSjwmug4SJZKMXJMF/+aAJA0/P72to2djoKJdfXgEUMwl
   pTwmLnSPwKTDqblRYOt+zwf1XLjyvt6crM6vPsuEJsibELmCoAEWOxWeD
   p4LrkoA06rpOWgw9PawlwPcxBcF/DTH1kSUcXDJ5KSREanwMUK6T6eWGP
   xeLRKTvZPaMt41YGkIJ2iCdeB3GX9Uo47CVqRbPKM+QQdQyGU6NdI53yZ
   rt0/w3O3IPgTNXI0Wi8QFp/cX3dCTQp/lLCalQ2hdTcw6KWPGADt9uYTh
   7j++UqJIOzJi/2qCFBVTZ/AP20/E6E8Cx2pDveKiCAScWYxCo4fdhR5e+
   A==;
X-CSE-ConnectionGUID: agluIRMzSRu80M3KVHsWhw==
X-CSE-MsgGUID: vEntpmf+Te6zm3mwlRfuiA==
X-IronPort-AV: E=Sophos;i="6.27,212,1787011200"; 
   d="scan'208";a="33877856"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 16:57:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:7113]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id 7da23d48-7075-4480-8ba3-3d5427a0698f; Fri, 13 Nov 2026 16:57:16 +0000 (UTC)
X-Farcaster-Flow-ID: 7da23d48-7075-4480-8ba3-3d5427a0698f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 16:40:45 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 16:40:43 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: Shuah Khan <shuah@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gyokhan Kochmarla <gyokhan@amazon.de>,
	<stable@vger.kernel.org>
Subject: [PATCH] selftests: cpufreq: Disable the runner timeout
Date: Fri, 13 Nov 2026 16:39:51 +0000
Message-ID: <20261113163951.1510082-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

cpufreq_basic_tests() reads and writes every policy file, offlines and
onlines every non-boot CPU five times, and then shuffles all
frequencies and governors of every policy. The amount of work scales
with the number of CPUs, but the test runs under the default 45 second
kselftest timeout.

On large systems the hotplug loop alone does not fit. On a 256 CPU x86
machine each offline/online pair takes about 0.5 seconds, so the
reboot_cpus 5 step needs more than 10 minutes. Even with the timeout
raised to 180 seconds it is killed in the second of the five loops,
and the frequency and governor tests never run:

  not ok 1 selftests: cpufreq: main.sh # TIMEOUT 180 seconds

A larger fixed value would only move the problem to the next bigger
machine. The basic test has a fixed number of iterations and does not
wait on external events, so disable the timeout with timeout=0, as
ftrace, timers and net/forwarding already do.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: stable@vger.kernel.org
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 tools/testing/selftests/cpufreq/settings | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/settings

diff --git a/tools/testing/selftests/cpufreq/settings b/tools/testing/selftests/cpufreq/settings
new file mode 100644
index 000000000000..d3e07370a7e4
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/settings
@@ -0,0 +1,5 @@
+# The basic test hotplugs every non-boot CPU five times and then walks
+# all frequencies and governors of every policy, so its runtime grows
+# with the number of CPUs. No fixed timeout fits every machine, and the
+# test always terminates on its own, so disable the runner timeout.
+timeout=0

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.50.1

