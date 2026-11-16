Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828172;
	b=w47kW8R4nD2DBRo43yr8svzyyvITPZgoKhDwL22NSpmXFh7kTS9wh57VffSfVLRmZc7P
	 QOijFivoQ5OEdonMPRo4s8HvilerVJSW6jEC6q9hYKYv4Y0tQIm+AsFRJxNL8gm3f67uD
	 pxV+pl0Y7ZmHvy0ybiSG5ci627kdrkN3iep+BJ1WNSaZu7Vb1ZXn83F/m5BLvpP5sHMQk
	 sJwO1PE6OKzbhs4eeQ6hmViGN61aSgkAhZNyxxYQFijZB/R2rOaSlPnFP3ML+2GKmIaho
	 Evg1Fes2d2nzUWD1tCCSNdTafWo3edYItuen5NwyeNwQr2JsaWRusyWWPpw5c6Lb5ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828172;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=aW10dZOCDVLhX+LRThn+G5BuApVtmzcnsTbZKWxJ2B4=;
	b=mQrCZJB+8DZvx2yf72VvenDrs2/Ive/Edq4Jhab0V8P3M1+Y7rRAsbZbfX/yVUhkssQv
	 IdWoHAf4HkpKgDtcxSM543siXqZE173B4Pa8uVmoGst/uAnlKqLLcVk9Q67Sd+BNF3JlM
	 LtKSJi5MsaVYLW1ciwx4L9SlG1j7ivwGL/kkZtmuo1yMTX5b/gT+NK3A51STVpP9LHloj
	 L8VUvxjInW6S062GI8xjz2AXZhfvR1U7fyQus3GPV/NcgSMLA6mCQTF5GcA0NQPdhDS74
	 xhnXgj8wWdWHoc7UhVmkTR+l9mJm7D78/ahf9OeNVFaweHS25Drr0cfyg0Nl2RiCbdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=ZYio56aF;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93F606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B93F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=ZYio56aF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794828172; x=1826364172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aW10dZOCDVLhX+LRThn+G5BuApVtmzcnsTbZKWxJ2B4=;
  b=ZYio56aFnVcygt9fx4QiFo6xvYe/Z+3hz1TAgkCik3Jvd7s9XLC5Enru
   f66P8jBdQj9M8LZPsc7boggMYLzUZpdKIccHmkpiayavY1xNcWPbX+GVW
   X6PrBoGJZlKcnN54kP9qvsSYqznJp+Lg6KyRzgjBcor6OPCgVjHXPSdGH
   KRpe0Fo8pQLq4zCQayhP4uOwZleCFfoBNH0sF1rY7/fN2W8r8FvPnEFqE
   Je8LKWX3xFBYgm8a57NrHfCXJRhI4Z/n0lLGdyF1aOLgTn4bsyVlRNGjX
   J6RpPXvAEABEwGZUmeBheviRePa9JL0OKEOvS6kO9aBi4/eBJPNmbRaMS
   g==;
X-CSE-ConnectionGUID: 6RlaTJZTQKGfwWQ3fjh9jg==
X-CSE-MsgGUID: iT66582lSwWykIVIEx0EVg==
X-IronPort-AV: E=Sophos;i="6.27,216,1787011200"; 
   d="scan'208";a="34289709"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:22:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26291]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id dc406a10-dcca-481a-a992-1204c6fe75e8; Mon, 16 Nov 2026 11:22:49 +0000 (UTC)
X-Farcaster-Flow-ID: dc406a10-dcca-481a-a992-1204c6fe75e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 11:22:49 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 16 Nov 2026
 11:22:48 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Sasha Levin <sashal@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.6.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Mon, 16 Nov 2026 11:22:27 +0000
Message-ID: <20261116112229.3815501-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261113110724.2920455-1-dipiets@amazon.it>
References: <20261113110724.2920455-1-dipiets@amazon.it>
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

  v6.6.162               93,808 TPS
  v6.6.162 + series     159,670 TPS  (+70.2%)

Changes in v2:
- Dropped 6ee3d87b9408, now queued from Sasha's backport [2].
- Added my Signed-off-by to both patches.

v1: https://lore.kernel.org/all/20261113110724.2920455-1-dipiets@amazon.it/

[1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/
[2] https://lore.kernel.org/all/20261113005511.435938-1-sashal@kernel.org/
[3] https://lore.kernel.org/all/sashiko-outbox-214392@kernel.org/

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



