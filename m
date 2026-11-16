Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827915;
	b=tkrsob4VuRRz6XziNIquo9tozC6zZWtcTXua30eUN0Juado+LiS08CmHEm5iAkD5vY0H
	 d35RNXAEP8arFUKD8Y/BJaBJMmUffBiOuXXTL8Z8jHgqrLN0OlrQFtcbGvWdBGRu0ZRIU
	 y8d9WuaPOtVn86msA5Is4Qo17/JlhMWaLOxzmSyQqFrfD/sspjiAl+WwhbZOjMQ+2fmF3
	 /P+B3rXneNc1t3Se++tdWtietdfVYeYCuAPUBy6lqEFxQ6YBziocw7lM6D/qnCEgezUUy
	 kY7C8vxtjt/vn/SrVnlha1PpvjF45XdcfT1vZF2jNuXs/cAlL+GOGcb1SrivaDE034A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827915;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ki1kgkg1irbVoGfnzm0B8lNmq46n7VG09X3WPUY+KUQ=;
	b=t1SJSP1Elz0AEOS2FBrY5qRVBXqHMoEMAFOk8ObbcXqRmfzo+bJ/B4uG3azxEAl7VLwP
	 xRkjMjjvONQqL+UjmsckWOK1pBlahkddn0NBenF37Cr1GfhXlALquNxeFf8Bo1vSVlcOG
	 e/3/ty9UzPPJ0T02SOCiPd33NUaz+cmhjx/wHQDJnDTrmT2q/uKopmHtMvOBhCk5Ji0xn
	 Ccbf1tpVzYyKgWeGWJsvL1hCCTPM5x7pNPXpquiQ7io1ORRwhWhT/exXP1RoGENi0GkDw
	 YMVWm/qFE+h248f5r2mLWJKjMC3iKiJ52jaaaaAS80D7xwgpE55Kouvv7BB/UwUiTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=DHSMDHeq;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BB606FDBD
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 373BB606FDBD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=DHSMDHeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794827915; x=1826363915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ki1kgkg1irbVoGfnzm0B8lNmq46n7VG09X3WPUY+KUQ=;
  b=DHSMDHeqH+O2XO0Kjx31SIYv5BUd2gieNHBnvVjqDPM64UUhVAsYBr4Z
   4OyCfzdHfyE826XeJMujZH7mWbF4IMJ153zlFGNVqWZoltpNPwemoH1h+
   12RMNnWN8VNzWrXIISdttDTpS4E+Xh4WeBHEgAk5u2g7rIAixibH1+oer
   GZlnYAUZPbKcpuvfAZrO8yfZ2n3V6UvRr5TNc1WhHhQFH5EjSA9haa2Qg
   iQBMMjtj6ODRwURvHgHL1ibqfbj6wertRY64bR8WftmsBvUdkxGvnKPQE
   hk8Ci87vWUNB/r/C/wZ2z3X4lMjw+BrFgQeiI//hs/ZFepfsVex/PWph3
   A==;
X-CSE-ConnectionGUID: HP9IQvENTwidbkcxcFr8Fw==
X-CSE-MsgGUID: 7r4RpmX3Ti+98YxCDaVCCA==
X-IronPort-AV: E=Sophos;i="6.27,216,1787011200"; 
   d="scan'208";a="34139142"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:18:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:12795]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id 6a985c6f-36f3-4358-8b0c-8e13929dfc3e; Mon, 16 Nov 2026 11:18:31 +0000 (UTC)
X-Farcaster-Flow-ID: 6a985c6f-36f3-4358-8b0c-8e13929dfc3e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 11:18:31 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 16 Nov 2026
 11:18:30 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Sasha Levin <sashal@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.18.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Mon, 16 Nov 2026 11:17:32 +0000
Message-ID: <20261116111734.3798483-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261113110259.2901456-1-dipiets@amazon.it>
References: <20261113110259.2901456-1-dipiets@amazon.it>
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
compaction for costly __GFP_NORETRY allocations") to 6.18.y. It fixes a
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

  v6.18.63               87,278 TPS
  v6.18.63 + series     154,670 TPS  (+77.2%)

Changes in v2:
- Dropped 6ee3d87b9408, now queued from Sasha's backport [2].
- Added my Signed-off-by to both patches.

v1: https://lore.kernel.org/all/20261113110259.2901456-1-dipiets@amazon.it/

[1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/
[2] https://lore.kernel.org/all/20261112171543.3069410-1-sashal@kernel.org/
[3] https://lore.kernel.org/all/sashiko-outbox-214380@kernel.org/

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



