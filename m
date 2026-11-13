Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568059;
	b=BXMeDwXSSZvBE87DI92jHjizYXy6JZUyQ9vG7xGLnuUql2Gca+FJsolWKX/wZxigi/Hz
	 5y1ehubZJTioTldG2kL+QrR7r53ZIoqEwHIcrh0y65uJifMVdziWxwi0kPTttFT7totsH
	 Qek0CxkCP0xHTl0oWMiPsx/itDDy5C7gb4pOvI48FpCmbvJyL0Vby82zHZj7kX7k60oWn
	 LFeR15Pl8K9XGThviQC2Uw/AGFoJm6FD89NmkMWcxPHbpim1WunMKxgIw6nzpAILTDmpA
	 Mwz450+CUiMQ0/snyJSIM//aUA+o4kOWXo83yWXOK6LeuzG77teO8s1q7nwufCTHqXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568059;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gj3HoWNEdcXUIqwe/gBb5WQmn/6jT4sWX+r8pFb7IGI=;
	b=eaq6aybob0IVAWW58CMzjrrl9IGCkj5DfS//qS9Jf0GcBCdf2OBOfpNHLKBV4abxpUMx
	 FdC8HiiOFryCCunJWELkd6ReyQiH7jRwlD8IQS/d0bRFaF0FdZkzyMJDoJFHqf2xaXGak
	 +dSOgy/mHbUOJIQXq7Ki9ApYG4fnb4kGxXgAfukMuRrYrOPHPmIiPYoWoSgu5R7EdXuts
	 XuEFV6BKLBQFFH0y6JqIurQ2tdckcq6lWyvUifekrCTbO7hraZGSsB68Ff6G9sgfid155
	 hB5D5qQmsmBrvQguc6qdiXpIC3NwP6lzrIE6cswoDiXcl8UOF4a/OD5gdBAkCIWATxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=nuFISJuB;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C63606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C63606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=nuFISJuB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794568058; x=1826104058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gj3HoWNEdcXUIqwe/gBb5WQmn/6jT4sWX+r8pFb7IGI=;
  b=nuFISJuBy/k5IDDRvCJHewSSczFzcLBvk4APWZPksT/gY1eIq/1e5Z66
   jT8N7N/WxkcgJx6ZqR+dJ9T2Zx+4/my0fTx8R/ObGVgquU5dDX645I1Ck
   TqhExxhJbhJnvvmsqA288+fNtzXbzzoNLhSM/UnrUEGqcI06UM2ejetdO
   DSh0nRI3c7Xml29zncPztt05uCTqN3+sl57iB0NQ9wSJ78YM3/eengzPX
   VQQagpvRSUdDEyryLqqL+NWTEVbhL/hBbziQN8yDC9kJKwMCGTBr87oss
   rV3ugoC0ysTwPpS3EwPKq9PE2HDuM4mlco+RbMjsSwLwH05p1FABfAxH+
   Q==;
X-CSE-ConnectionGUID: vlBfzprRSBCgq4e4/EhTgg==
X-CSE-MsgGUID: s9Q2zoMMSbyugKE3CccnBw==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33792832"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:07:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:2974]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id e3bd98ca-d8e2-4122-a144-737d8c8b7749; Fri, 13 Nov 2026 11:07:36 +0000 (UTC)
X-Farcaster-Flow-ID: e3bd98ca-d8e2-4122-a144-737d8c8b7749
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:07:36 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:07:34 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.6.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 11:07:21 +0000
Message-ID: <20261113110724.2920455-1-dipiets@amazon.it>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Backport of 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
compaction for costly __GFP_NORETRY allocations") to 6.6.y. It fixes a
regression from 5d8edfb900d5 ("iomap: Copy larger chunks from userspace",
v6.6), which slows buffered writes under memory fragmentation.
Andrew and Vlastimil agreed it should go to stable [1].

Patches 1-2 are its prerequisites from the same mainline merge (Cc:
stable), only moved from mm/page_alloc.h to mm/internal.h. Patch 3 is
adjusted for this tree, see its changelog. Acks from Vlastimil and
Johannes on these adjustments would be appreciated.

Built, booted and tested with pgbench simple-update (PostgreSQL 18.6,
1024 clients, 96 threads, 1200s) on m8g.24xlarge (96 vCPU arm64),
12x io2 RAID0 XFS, mean of 3 runs:

  v6.6.162               93,808 TPS
  v6.6.162 + series     159,670 TPS  (+70.2%)

[1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/

Johannes Weiner (2):
  mm: page_alloc: do not give all non-blocking requests reserve access
  mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES

Salvatore Dipietro (1):
  mm/page_alloc: avoid direct reclaim and compaction for costly
    __GFP_NORETRY allocations

 mm/internal.h   | 14 ++++++++------
 mm/page_alloc.c | 16 ++++++++++++++--
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.50.1




AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico



