Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476542;
	b=w/ugbwR89QFKyTRGt0GaQo82zBGEAT2aOZv/r2ZLUhATu1kjdN/5j5eBsuuXvCfdc/6y
	 nX0r1rWZaPCn+hZyVTq8ywh+EZAfttHy/aWNzb3b/4x/RIERoZpw4DGtRDGAsVB+palD/
	 sVMww1tuqa6tg3KFQDpjqLLPuxb/Ir5h3AvsSL3wFj4JO7MZSbzEYXexysd/e2lyNBzmX
	 kAgJlcEs5rAo2kJjA5pV4JAdM6YAwZl3JtjjZfLovoCEawgjM83N9ZRhWve3dIjohJhR8
	 XDsCgJuLkZWng37+cGJ47VBipSjcVHMFcFRXaSy/082FGinsOd2cnkIu0coxVbWESxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476542;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=5FhPhptoiDnbvGobJSg/2oYz4NalMfRC1p+IyPS8BeI=;
	b=b6Xt6lZRT50FOI2t5eMWv39ZgXJ2YhnX3God0QFm/hNkrSjb3Y5mUSJKGGeTQFwvh0DC
	 M33e/U72gboYzYJd2rJ1AWLCZs465OuZvzjcfCRpAGJiCJtbI2tY0N4tdvwWOMZSf/Bl5
	 efx68X4aXVPf7aj8zljyn0h3uWFtM830WaP2p6Rsy3/3Cg+m3qMAHo/ZQeLekwXcZPb8q
	 QW3d4x+QzPtoWbfAl7KX6XAJ2WjjiPcfaNrnkUR7agx1zuipE7HVJUuDEKw6cKbZHG7b/
	 W5LYP4R9gROrVY9tk0TPrHY9kTXfzfcLFnoObXyTBdCMUiTO3otiDPpfQPT5TzRxMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=H69RsqA+;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A63606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A63606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=H69RsqA+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794476541; x=1826012541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5FhPhptoiDnbvGobJSg/2oYz4NalMfRC1p+IyPS8BeI=;
  b=H69RsqA+fMA9k1/FcsxuDLv1iVlo5sgfd/pixvjcF+DIJaFF1QEj99Ya
   SVwHNtTQrath26L5XwRbYo6vho8DO7uK7ZzFSnb1Om2jOBt2kUu13kbZA
   I9/vMkp4oeG0Lpzq60i9tcLpwljheWkqr7Fv7098R5lGYZH0gX/IWe/lu
   YBMsXWOITwiDCnBG4bTJl5BqqjE9gq58mVk9U6D5HgRmH4NrtjNbPWjFX
   swJKwtbS+dcAjpVWqpCUs2tbqv5WCRXHurxZZ6XVh9tDWWCAW1S9SFonO
   9duaQzbftpRmI50kFZdxuijQ1/Jo/ScLBdWddxQjNBPANEFIqtifiRiEo
   w==;
X-CSE-ConnectionGUID: pG+pAsDBRd2ZShkzIRXO2g==
X-CSE-MsgGUID: FQuDohEITmWX7HRwKQviZg==
X-IronPort-AV: E=Sophos;i="6.27,209,1787011200"; 
   d="scan'208";a="33702422"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 09:42:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:3788]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 191c253e-7415-4cf6-b337-d056f3a4794f; Thu, 12 Nov 2026 09:42:18 +0000 (UTC)
X-Farcaster-Flow-ID: 191c253e-7415-4cf6-b337-d056f3a4794f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 09:42:18 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 12 Nov 2026
 09:42:16 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	<linux-mm@kvack.org>
Subject: [STABLE 7.3.y] 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
Date: Thu, 12 Nov 2026 09:42:05 +0000
Message-ID: <20261112094205.994560-1-dipiets@amazon.it>
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


Hi,

Please apply to 7.3.y:

  0e05a469c294 ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")

It fixes a regression from 5d8edfb900d5 ("iomap: Copy larger chunks
from userspace"), in since v6.6: PostgreSQL pgbench on XFS runs at
0.38x throughput. Andrew and Vlastimil agreed to restore its
Cc: stable [1], but it was merged without the tag.

It depends on 6ee3d87b9408 and fe21f930d1e6, already queued for 7.3.

I'll send backports for 6.18.y, 6.12.y and 6.6.y separately.

[1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/

Thanks,
Salvatore



AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico



