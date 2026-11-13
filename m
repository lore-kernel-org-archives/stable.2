Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567802;
	b=WUN/rMrL7wQepadWIe/vJuknglniM+iA9+afsMmA4BW0MycspdHupw14QTxiybAVKBzS
	 BY2DW9fG3ZaPOyVCxV2/12j/9NkyubyhFz84hnPtiA7SOow0K2uu4pM5yuzbpEwA1B613
	 FiPnFLQ50dCIbJQBRuVLN2OxCRuctHtHmYIi4FDDWOCcp91+R/qkTvFI8kXis8W4C1h7l
	 7bi50Qhso6lmUkbNQCkrxJy0u5jW0HIKMjwrowBL/SXL9VH+1KpoeN5+oJd5sndf9d3rG
	 IoNf7YJyys22THfgqcJhxqYGas9TWtsP/KQS00pe+pgPk932waqiOi17Cnb3NKPZDFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=rxpebwgxAi2rpMQVYH2/YieUDfApwWMHIlSz9atE37k=;
	b=OooQTlXiJp/C83X3XKMbdrWtZ3UWGaGxqzKOwYuDp7tYYckPWG8Aw9vRes+cWJs82WcS
	 R+xmZhwSOPVIGwkNZP57EjmcxsG46oWfvBqr3UWd+HKpcEcIaaxxW9Fz5dUkvE8kTCNXU
	 J/NXt0ps41Jd1dYVAvXXc2guv3ZyAKOg4ftnF7Ip98H0hgvd9yYaZvADjgi0KXdKdGt8L
	 YUXKz7C91IJ7P48+uZs8a5o+8WpAbn8o79rg0bBfSHzReSTd1OA5XMJUrrGLCvYVwelOD
	 JxQRKkWqq8+2JpMSBPwVtjmSBzwsYtKt8B4pFv/OqMMAupvbLvKx1XWaVPlv5tRC05Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=XLygVFfL;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0793606A333
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0793606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=XLygVFfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794567797; x=1826103797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rxpebwgxAi2rpMQVYH2/YieUDfApwWMHIlSz9atE37k=;
  b=XLygVFfLpe4y9KKzCnXUGqGoe1Igvqhdp1igX/pwgQBSUDfgvb030DHD
   dTe0OxV41ugNWA6GrljuAekuH+bPynaqo9lmSfmgTWfJ7vzGpBW6onAs7
   jmeL4twgnWMhNG1nTWMLmblzaltS0zwQRmD3mXEaYnIdsr0cGitNfdDtK
   n7RutUBptQdPa/q0ukuPUaOFTg03HVWuW0ZwDvYVwCSnr2gmFKrkBdH5r
   f/GcRmZaY91HH2se6Ni4iVmfxjRiTUy778YKMm6JA3lKDIhz+lFdkVGdt
   dGZlSpL1ysqtYf8jpQrHdtgAPGmXAGHook0mldLfyhTiaQVpQ5Ul68Qqo
   w==;
X-CSE-ConnectionGUID: iydCxRSzSXewt4ZzwzSvgg==
X-CSE-MsgGUID: pE9VtNAcSJypVESQgYT0GQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33389046"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:03:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:10011]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 961ba48b-c7a4-4592-bbd0-a0083439ac97; Fri, 13 Nov 2026 11:03:15 +0000 (UTC)
X-Farcaster-Flow-ID: 961ba48b-c7a4-4592-bbd0-a0083439ac97
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:03:14 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:03:13 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.18.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 11:02:56 +0000
Message-ID: <20261113110259.2901456-1-dipiets@amazon.it>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Backport of 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
compaction for costly __GFP_NORETRY allocations") to 6.18.y. It fixes a
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

  v6.18.63               87,278 TPS
  v6.18.63 + series     154,670 TPS  (+77.2%)

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



