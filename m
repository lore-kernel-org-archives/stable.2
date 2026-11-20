Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196888;
	b=OvzLjmgHZvrtc2jJe42QCALYx+8J6XJz2vDS5+tCVzk+B8u6LH1oWLMSmT/OnDt+m5B8
	 Ca55nPw9iJLCaCX63PYkEYRJ88xg3wqGEJsSlWfb4QytnrGvjlGsVHUCRPIQd5QBiGC9w
	 CLe/2oNrujIM6b84STyqnSTbUkifogxLbN9yDAYzIIR6NSM5otwhwE0nVOY58322VxaKc
	 R7lvztd4mys9viqtPqoUxn6YVoIKCopoZNGKkoZUXGKt0lpz+0WWDTdrxmKp5p2zZ6FS1
	 i+2uD4+uPiH78ng6DR98eAoNhXgAG6qQeazcCuhUilGhXFCweEdb7S1QoP3JfPQWD4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=BRbB4TeEbeDPYP10r5R78d5DnXhIf+696YAbQVI6b1I=;
	b=xxFihnUuK1x82pTEtrw8n41DKoaFPjdwQcUqUsMyZ8d5ybfIkHk3GkESAkxYmUEykaWO
	 aqjGldlnP7G5NhM6ROWvi0co9CirtLnQk3r04JyBaNs4ShpsS3qdAYzcWFEeKZH2R1lv2
	 Mv7dccRRORP5RhWUjs3jo9LrdncMG7Qjk9OSDkxj6PdRbsGwcgDxWtTfKfJifIkfeJQGn
	 9yTu0dOE2FdPCLKNyYNDDkHxzf6SXHF8PAKx6bLc+fEZMwxMi0fYa37kxaFqhh8bqJdkB
	 zMxWpIAhrdrxglfZs51TPtcm7oi4SRZC8DS0For6GYTlzlrju1aiJvDGg2GoD3KG72A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BKMdN6qE;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0E60A2606
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC0E60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BKMdN6qE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795196883; x=1826732883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BRbB4TeEbeDPYP10r5R78d5DnXhIf+696YAbQVI6b1I=;
  b=BKMdN6qEwTpDyAX6CREB1KRZCjUZDmDXcqYWERZO6uhWhtfFa2/UjbKG
   3KxEjf+uwnensduOh3yetEFYrYTh7pwI+uSaB2/CrslRj4czQdlNo0gYm
   1jyPUialfgySfhtPuoVk7CUO+gTY6Spu9n2QoD7WhFEtcY0kDmDRu/wyI
   WQ6YSq1iyBwd1RCPkOHvbnpncwYrJDa1JE4nR9F6LWxi47n/8BC8S8Fj1
   7EOG3CqHDYHd/vZnT33tHC+tIAWxjgvS80tynP2YAvzxU09Nrow0WXZwi
   8EwCHPGn6pLXi52sGtZVMQeiww7tEIJONC/zlK4oqeaSBtEx4VTo80zr0
   A==;
X-CSE-ConnectionGUID: Q3ofdov8TCKC2HnaxqewtQ==
X-CSE-MsgGUID: 5Jiw2TxURRiOZZBwsk6NYg==
X-IronPort-AV: E=Sophos;i="6.27,223,1787011200"; 
   d="scan'208";a="34540198"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:48:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:28745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.177:2525] with esmtp (Farcaster)
 id 767f9935-a099-439d-9b67-2386925f1139; Fri, 20 Nov 2026 17:48:00 +0000 (UTC)
X-Farcaster-Flow-ID: 767f9935-a099-439d-9b67-2386925f1139
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 20 Nov 2026 17:47:59 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 20 Nov 2026
 17:47:58 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
	<linux-mm@kvack.org>
Subject: [PATCH 7.3.y 0/2] mm/execmem: keep the ROX cache huge-page only
Date: Fri, 20 Nov 2026 17:47:43 +0000
Message-ID: <20261120174745.3785179-1-gyokhan@amazon.de>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

Please consider these two mainline commits for 7.3.y:

  d80773cedde2 ("mm/execmem: handle potential allocation errors in the maple tree")
  569db54d8b7a ("mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE")

They complete the series whose first patch, 52d95a55a011 ("mm/execmem:
free ROX cache chunks only when they span an entire vm area"), is
already in 7.3.4 as 8c60564f03e0. The same two commits are posted
separately for 6.18.y, and this version keeps 7.3.y covered for that
request.

On x86 systems with 384 CPUs, udev coldplug runs several hundred
concurrent init_module() calls for the same modules (kvm, kvm_intel,
irqbypass, x86_pkg_temp_thermal). On a ROX cache miss,
execmem_cache_populate_alloc() reserves a 2 MiB area before it takes
the cache mutex, so these reservations briefly exhaust the module
address range. Each failed attempt prints "execmem: unable to allocate
memory", although the exact-size retry succeeds and every module loads.
The exact-size areas then stay in the cache and are never freed.

With 569db54d8b7a, the cache refill only accepts a huge-page backed,
PMD-sized area and fails quietly otherwise. The allocation then falls
back to an exact-size ROX area outside the cache. d80773cedde2 is a
prerequisite.

7.3.y does not have 4c4b2ed5b783 ("mm/execmem: use
VM_FLUSH_RESET_PERMS for ROX cache allocations"), so both patches keep
the existing execmem_set_direct_map_valid() handling for cache chunks.
The uncached fallback is freed with plain vfree(), so it uses
VM_FLUSH_RESET_PERMS like the non-ROX path. Each patch documents the
change in a [ 7.3: ] note. Mike, if you would rather have 4c4b2ed5b783
backported as well, I can send that version instead.

569db54d8b7a is above the usual 100-line limit. A large part of it
moves the ROX setup into a helper that the cache refill and the
fallback share.

Both patches apply cleanly to v7.3.5, and mm/execmem.o and
mm/vmalloc.o build with W=1 on x86_64. The code changes are the same
as in the 6.18.y version, which was tested on c8i.metal-96xl: 20 and
29 warnings without the patches, none with them, and no failed module
loads in either case. I have not run the 7.3.y version on hardware.

Gyokhan

Mike Rapoport (Microsoft) (2):
  mm/execmem: handle potential allocation errors in the maple tree
  mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE

 include/linux/vmalloc.h |   1 +
 mm/execmem.c            | 109 +++++++++++++++++++++++++---------------
 mm/vmalloc.c            |  15 +++++-
 3 files changed, 84 insertions(+), 41 deletions(-)


base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
-- 
2.50.1

