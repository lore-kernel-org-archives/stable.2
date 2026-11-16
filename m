Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828118;
	b=ROGOkxXt48NZ67vyrk1xkURW/PEk4gbTeRQsnjjyHCRfsQUI+AJl1utYtwzrPxuXcptU
	 e3qJh5SPoV3DKzVCNvRR+ZldQQP1zUNFpW4dKUy4VSe2L2sPlitOxpfaFLkI+Sb4x/tiF
	 zkE+7brEh6N5aeTbGwSvvTHaqF3POcu5oGoqBonVDujDBdOoW9a9+PnVcGB1mdaF4LQPd
	 XDpyMu3KdwuAfYAQ2a9KyvJP6HSvc5Klp4lW3wvXL1kXpKV8eL6oWbdt14XWzqyd3HMoP
	 6yAxzBUpDQq+UJSQomhrKgrHy4S3QBxQKIAPZfeyyEGTmWqAdnklCJ7c5OsNtfR3bJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828118;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=noCYfjyXVIMbbLN6Ti74onkf+XgPewQsAqDuvy/OF9Q=;
	b=kVIeYffXMawhaOV3e/h1UysQZJ0l1ujt0rcC9qWV/M5vvUPEH5MLhEJ2oGXIR+BjJqiD
	 9LLf97Qq5QAHWuypMMMfaXiokIS8eT+241+Uz/2CSgegQj37moLfBXk1rhT2ERutw48ap
	 yR3zjf5b4lsdZq3Ix5IweFL18MSDYP7TAHZQw7NHn41g+LoT+J0GpknNv26J9Prs7rB1K
	 yXoBFluVqylUxkbpYSq6IlPcGItvPog7WLPkl1f4cZ5nCdEfaQVuAEcu8bpZ9k6pvK9Hb
	 CqAGYSGwmE2Ia4lF56Vg5o27RSkQK4avK2mxmyXf/1xLrfGXR4nzSJK7RNXjE3+hG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=aKQ03xDm;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEED606A882
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AEED606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=aKQ03xDm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794828118; x=1826364118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=noCYfjyXVIMbbLN6Ti74onkf+XgPewQsAqDuvy/OF9Q=;
  b=aKQ03xDmGb7rg3lBXHJ+glLItX49oOJeFgnYDgwt/RijZ6UpcLj9K48A
   ZgdM92AFItCs0JK83roXjMbHIL7gJ/0ZW3tjWQoMpA0mDrnFTbYq0pTak
   S+kseDzlKE+ji3KbVe5091Ux0YzLyL2fPILfia6FHBLCVlMsdm4QVUbNI
   jGMouSw30Ppf8uAGTcb+zKfCYK5lwtEFQ+RaAq2lG83R10Yk4XQ9vzQQs
   6Z+JrCLbfzXNTqeADYPgBOz3c26Q059ItqIaa/SIOU/n7f0v/r1I8PexA
   fdZ2QisSDb749dVufhBV1bPZYm0Ud4XaLcGfbfoE+Ayv5S2qd+cuTMSmz
   g==;
X-CSE-ConnectionGUID: HyzXHEqkS16Q+NoYWQHUFQ==
X-CSE-MsgGUID: D4zTA3UQQyWh80f/zai0fg==
X-IronPort-AV: E=Sophos;i="6.27,216,1787011200"; 
   d="scan'208";a="34068360"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:21:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.250:2525] with esmtp (Farcaster)
 id f60cd348-5baf-4a64-9388-a28c25dbb758; Mon, 16 Nov 2026 11:21:54 +0000 (UTC)
X-Farcaster-Flow-ID: f60cd348-5baf-4a64-9388-a28c25dbb758
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 11:21:54 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 16 Nov 2026
 11:21:53 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Sasha Levin <sashal@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.12.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Mon, 16 Nov 2026 11:21:40 +0000
Message-ID: <20261116112142.3813013-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261113110611.2915381-1-dipiets@amazon.it>
References: <20261113110611.2915381-1-dipiets@amazon.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Backport of 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
compaction for costly __GFP_NORETRY allocations") to 6.12.y. It fixes a
regression from 5d8edfb900d5 ("iomap: Copy larger chunks from userspace",
v6.6), which slows buffered writes under memory fragmentation.
Andrew and Vlastimil agreed it should go to stable [1].

The series applies on top of Sasha's backport of 6ee3d87b9408 ("mm:
page_alloc: do not give all non-blocking requests reserve access") [2].
Patch 1 is the other prerequisite, fe21f930d1e6, only moved from
mm/page_alloc.h to mm/internal.h. Patch 2 is adjusted for this tree, see
its changelog. Acks from Vlastimil and Johannes on these adjustments
would be appreciated.

Patch 2 keeps the mainline behaviour, including the THP defrag=always
case raised in the Sashiko review of v1 [3].

Built, booted and tested with pgbench simple-update (PostgreSQL 18.6,
1024 clients, 96 threads, 1200s) on m8g.24xlarge (96 vCPU arm64),
12x io2 RAID0 XFS, mean of 3 runs:

  v6.12.117              87,565 TPS
  v6.12.117 + series    144,458 TPS  (+65.0%)

Changes in v2:
- Dropped 6ee3d87b9408, now queued from Sasha's backport [2].
- Added my Signed-off-by to both patches.

v1: https://lore.kernel.org/all/20261113110611.2915381-1-dipiets@amazon.it/

[1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/
[2] https://lore.kernel.org/all/20261112171856.3309378-1-sashal@kernel.org/
[3] https://lore.kernel.org/all/sashiko-outbox-214389@kernel.org/

Johannes Weiner (1):
  mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES

Salvatore Dipietro (1):
  mm/page_alloc: avoid direct reclaim and compaction for costly
    __GFP_NORETRY allocations

 mm/internal.h   | 11 +++++------
 mm/page_alloc.c | 12 +++++++++++-
 2 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.50.1




AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico



