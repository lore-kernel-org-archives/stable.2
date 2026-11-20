Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196973;
	b=r6WKrEEra/IJKCstQK3Afee9qFRkk7X+KeqsneF8K6pr5AoZG5QOjZhTXKmqX8rATE8d
	 zASEH/pxB59tbOFgkr30dO9mDWKeO5mrRuRI3cbTetObQDOlvoCUkHKr3lzR2XWaqvd2+
	 FIxYftPa60venG68Fcp9pgyftod2Tg3/y54c++DDmjommTipfhjA0wLnNDqx9WNS4O/Lk
	 emQPLT2xP21mmX2N3AWNaw0OK5IICSsvpp4MuVOabuJlObLawyNIC0apbklA7nlIc8qTR
	 WjuGNPMZi6vwUW3JLjLzm2kofxqnM8rkr/rCsD7xtGbBEVGCuI5jx0wljBmiPWEXDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196973;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=6R4bkEbuO1sKsBxVNTjwrRYQXlyXlhs6GOh+EH27R7A=;
	b=wT3f87nGuPNP9z3IWVrcZMeSCvBCkQWsv4kgbnMSKzmu/L18hBMHWCwMId//OL8JIueN
	 e9i9SfyEDAa2eRb78EYPIpEhrtGAZsfYHFxmBpVGs+ZZSnNOqZakccG5JFT2HN2wwKzrS
	 /9qfQHcgtZRVAk/wIeKlwquKsSQ1kE5OLJN44nsxL8vLRphT6B1aQn2OOD71MWHh8kxi2
	 1K5KUBctZYJjJj8gPjXL+ZUacGNSk8nJgrL4zYGuyQIwiBHhrW25N++K+cC3gADPC1f20
	 DEqMJ7/sBZgqBzPqNwjNrkgBtpckizrmQwJHzEqzUshfZOM6n9463uD7i//JprNKXSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=tX1Fz2jz;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA22606A33A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA22606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=tX1Fz2jz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795196972; x=1826732972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6R4bkEbuO1sKsBxVNTjwrRYQXlyXlhs6GOh+EH27R7A=;
  b=tX1Fz2jzqBz/myYu+XGBiMD6MauFKxyGsXS2r4QKsrDEZmIMG0vkQydn
   gul0MXszmctOumDDsmrSXedGBuvwz3MGarSh2gjsS8l7nNDQygeBjUetY
   et6XL13hX+7Hx90vGHdoBoN9zKfzwzZ5a/ruFZFtAbrKMjTkCRUrLNyP/
   aLwy88C9bA7udXY/Xgqa7mXLG/jvrXOjGCLtiS8GDUQlFPTyvObtrLSrM
   ckKtRZ7jZEX4YE3SWv/w4B9S3Oe8T/O++S/GReYXG8ZtOfhqf/2VCfnuP
   M5V+G3pzQgPJVRsjV/w8yVLUB5wpqkCWR9QgisslHR0AAIzuQf7NrV/b3
   Q==;
X-CSE-ConnectionGUID: czFhMcfzTxe08cWvEc2TGQ==
X-CSE-MsgGUID: nPKQctD3Qeaak16icO4TvQ==
X-IronPort-AV: E=Sophos;i="6.27,223,1787011200"; 
   d="scan'208";a="34665825"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:49:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17503]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.204:2525] with esmtp (Farcaster)
 id cc4b8551-c795-4eb1-bcdd-34b19247f660; Fri, 20 Nov 2026 17:49:31 +0000 (UTC)
X-Farcaster-Flow-ID: cc4b8551-c795-4eb1-bcdd-34b19247f660
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 20 Nov 2026 17:49:31 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 20 Nov 2026
 17:49:30 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.18.y 0/2] mm/execmem: keep the ROX cache huge-page only
Date: Fri, 20 Nov 2026 17:49:17 +0000
Message-ID: <20261120174919.3789837-1-gyokhan@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

Please consider these two mainline commits for 6.18.y:

  d80773cedde2 ("mm/execmem: handle potential allocation errors in the maple tree")
  569db54d8b7a ("mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE")

They complete the series whose first patch, 52d95a55a011 ("mm/execmem:
free ROX cache chunks only when they span an entire vm area"), is
already in 6.18.63 as e4dcde9709a2. The same two commits are posted
separately for 7.3.y.

On x86 systems with 384 CPUs, udev coldplug runs several hundred
concurrent init_module() calls for the same modules (kvm, kvm_intel,
irqbypass, x86_pkg_temp_thermal). On a ROX cache miss,
execmem_cache_populate_alloc() reserves a 2 MiB area before it takes
the cache mutex, so these reservations briefly exhaust the module
address range. Each failed attempt prints "execmem: unable to allocate
memory", although the exact-size retry succeeds and every module loads.
The exact-size areas then stay in the cache and are never freed. On
AWS *.metal-96xl instances this shows up on about 1% of boots.

With 569db54d8b7a, the cache refill only accepts a huge-page backed,
PMD-sized area and fails quietly otherwise. The allocation then falls
back to an exact-size ROX area outside the cache. d80773cedde2 is a
prerequisite.

6.18.y does not have 4c4b2ed5b783 ("mm/execmem: use
VM_FLUSH_RESET_PERMS for ROX cache allocations"), so both patches keep
the existing execmem_set_direct_map_valid() handling for cache chunks.
The uncached fallback is freed with plain vfree(), so it uses
VM_FLUSH_RESET_PERMS like the non-ROX path. Each patch documents the
change in a [ 6.18: ] note. Mike, if you would rather have 4c4b2ed5b783
backported as well, I can send that version instead.

569db54d8b7a is above the usual 100-line limit. A large part of it
moves the ROX setup into a helper that the cache refill and the
fallback share.

Testing was done on c8i.metal-96xl with an Amazon Linux 6.18.62
kernel, without and with all three patches (e4dcde9709a2 plus these
two). Both kernels also carried a test-only patch that keeps the
execmem helpers traceable. Each run did 20 udev coldplug cycles of the
modules above, with two runs per kernel:

                                     without      with
  "unable to allocate memory"         20, 29      0, 0
  execmem_alloc() returned NULL        0, 0       0, 0
  module load -ENOMEM                  0, 0       0, 0
  uncached fallbacks / allocations     n/a        709 / 88288, 346 / 87832
  median coldplug cycle (ms)        5496, 5777    5845, 5986

Both patches apply cleanly to v6.18.64, and mm/execmem.o and
mm/vmalloc.o build with W=1 on x86_64.

Gyokhan

Mike Rapoport (Microsoft) (2):
  mm/execmem: handle potential allocation errors in the maple tree
  mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE

 include/linux/vmalloc.h |   1 +
 mm/execmem.c            | 109 +++++++++++++++++++++++++---------------
 mm/vmalloc.c            |  15 +++++-
 3 files changed, 84 insertions(+), 41 deletions(-)


base-commit: fd7cfd39c88596fec816639ad83cbf3e9d316372
-- 
2.50.1

