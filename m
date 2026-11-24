Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513254;
	b=pJq/x863ZQPvQl4mvA5Y+SCi0y642FQvM056kImRXn8agJDiYRKStjkWTuJTscuPKpGC
	 TFaiOye01NuPEN3Mhd05aG6YqulHivw0EqFKuGoceMP1hGpK+As6aMOrj3xiDWNoTQFZZ
	 3C0w1Fn6xktoF/WJXwnQbCyCotcHEpal60UcVHoWS2tFsOQCtlT/p2Q9ne6KnllfPD0qM
	 pZnG6j8TJdvjTgYghN2fJZA0ozM2CWSMm+XlfHIVviXxqgDjCzeV/wU8sCuAoHVdfwPIe
	 XAWXiHDX2lv8/Vw+qV+12ci/HIny6o8VCmsWQq2gzuUnhOpFx2It9N4CUuDUssSr/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513254;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=pg4wKud4L8UOLXPr18RTSGGcJ3ulNhPiZJ6lfMaTp2I=;
	b=2k2tG+Jfzn2XRQmoiUZU2zywgenZHWyKrMOLX/985MGqKV77u9F/B81AhncTwAe40CLq
	 mYBbnnwl1GAUQCjXTNuJpQUyx+yWKQpHUsqhtsSSbW4OnmsC/+CP9z4wwSU+eZAQ5fWMC
	 2k4zDO+L6pPHcFQ+IvGlyoNiHQiIM9B2SQH4q0Lyeu/kq5b6K5mS+jrT7aXjnU7Nq7ynx
	 Tcjsv7vUzRJDO2vv/7/bQ3824WTIAmTlLrsl4wVsmAjsiRnyiQV4QeV+jEPlUIm2wdtR3
	 dN6JMOpn9zU2UBQhuw/3VNcOSP5dt4lC4sKIGwSGsi5u5yXTF8w1qZuPdYrIfLchLyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=FsofyJeL;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF03606A696;
	Tue, 24 Nov 2026 09:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF03606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=FsofyJeL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795513245; x=1827049245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pg4wKud4L8UOLXPr18RTSGGcJ3ulNhPiZJ6lfMaTp2I=;
  b=FsofyJeLokLV7SUwtFHcJZ/P/C5J5e7sgMMB60prpLc2AF5Ri44twuSA
   q9uMoVkoPYzVgkedGYL9TobON6nlb6o3bJ0qn3ql73D31rlcvZWzDaD7w
   u2qEQcI9zWzPmBy0l7QZN2ICoZ3VAd1Vm+7cA231oDyCSlJ5MDY8U58WK
   4TA4BR03fTL+qQ9s8JjMh85k9qpdjbgBw9hmuhf81VpAze+4p/4mYhPt0
   w+5nr9f8ZRqOJAVs0mF275ow2nA35vKJrB2jGUgJlfFBQrz9uVplX4mBc
   ifwmaIHg9fzPUdVg5rVfI/AsvqWF4NnCb8cvehVK0l4OFF2alOvvN5Q2u
   A==;
X-CSE-ConnectionGUID: 6smcwInPTXWN+yE5oSizlQ==
X-CSE-MsgGUID: 1bp778p8QPynfTfVwFg/fg==
X-IronPort-AV: E=Sophos;i="6.27,230,1787011200"; 
   d="scan'208";a="34904524"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:40:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:16519]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.222:2525] with esmtp (Farcaster)
 id b501f3e6-7645-48f8-8dc0-d5acdb178088; Tue, 24 Nov 2026 09:40:42 +0000 (UTC)
X-Farcaster-Flow-ID: b501f3e6-7645-48f8-8dc0-d5acdb178088
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Tue, 24 Nov 2026 09:40:41 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Tue, 24 Nov 2026
 09:40:38 +0000
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
Subject: [PATCH 0/2] sched/deadline: Fix forced idle charged when a sibling ends it
Date: Tue, 24 Nov 2026 11:40:29 +0200
Message-ID: <cover.1795510960.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124080737.1988-1-kmehltretter@gmail.com>
References: <20261124080737.1988-1-kmehltretter@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Karl reported that "sched/deadline: Don't charge core-sched forced idle
to the DL servers" (f4626e1c3c14, in sched/urgent) still charges forced
idle to the DL servers when the sibling's cookied task blocks: the core
pick clears core_forceidle_count before the idle CPU charges the time.
With his 800 us spin / 10 us sleep FIFO pattern the CFS task gets
0.8-1.8% instead of its 5% reservation.

Patch 1 makes the core-wide pick charge each idle sibling's idle time
under the forced-idle state from before the pick, so that no charged
span crosses a change of that state. It adds no new state. Patch 2 adds
Karl's pattern to cs_dl_server_test.

Tested on sched/core. QEMU, 2 cores x 2 threads, 8 runs each:
tip/sched/core fails Karl's pattern 8/8; with these patches both tests
pass 8/8 (5.0% and 5.6-5.8%). Both patches apply to sched/urgent, where
the existing selftest already needs 87a825f3c680 ("sched/core: Rank DL
server picks as deadline in the core-wide pick"), as in my earlier mail.

This series was prepared with the help of an AI coding assistant. I have
reviewed and tested all of it.

Fernand Sieber (2):
  sched/deadline: Keep forced idle uncharged when a sibling ends it
  selftests/sched: Let the FIFO task block in cs_dl_server_test

 kernel/sched/core.c                           |   8 ++
 kernel/sched/idle.c                           |  25 +++-
 kernel/sched/sched.h                          |   1 +
 .../selftests/sched/cs_dl_server_test.c       | 107 +++++++++++-------
 4 files changed, 96 insertions(+), 45 deletions(-)




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07

