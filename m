Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568001;
	b=TpPdSgM4arzrHJbOyF74FGQp++fzJIQ4082KLDePOe1AtchFkmH6ZBFOro4xKGLlb7Fp
	 IknA0/iKJPhIsuYduSlF3MW4GYuNeXtdMsi1dv8OczhYeve3cfKkjpcgxFhertkhW+HCG
	 DMiiGGz/zHt03PSsFM8BGJyPsx8d59CLVS+1xlGwbGepRSoRCj7Q1lctft1mLAvCbc0oB
	 nWBG69Br4MKNDY9Y/5rAmgRLdBbvH1B12vuJZVu0PBVrD9m2dwACBUpbd7dxraTa8b5fN
	 Uf9xSv5LgA0ftQ9IkbBlAWLVradtE3VtwUQ/I4+Btnc2HNOIguMJblZhEHs4AfIbwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568001;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jq29Nsw/eEx5Hh7qSvslNVdmTpbWIfGqW3t7KRPkB9A=;
	b=TGp9n/LkIU5tRO6jCDj9XzqCZ7LXIABw+a3b9HJHc9pw1GWHRp1EPFedTcKMzjWKni/v
	 H6r8Fx4tjVp21WOf46C35i35T7qCIjY4H1sgzR/DOHgM9jlCItrWMgFifh6FdUyjn631c
	 vDPD95uhcGdCSBvE3xYqbYqRDBwun54gLThETIm57QBVex6kIznmGqsd7BoF+Zw+2YHyJ
	 Q31SwluFzZrXG7yfQywmEEgp+u6pRFRiqcwLtH7hkJtvvMep0gEpLXtb7tuaAS5tsbX3e
	 QRJYjN902OLl016tCIT1OYG2O/8GdKXC/T2JQGd++WLWadC1k7ZugVs9hQRycJFKxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=q+ZTin7H;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12631606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12631606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=q+ZTin7H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794568001; x=1826104001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jq29Nsw/eEx5Hh7qSvslNVdmTpbWIfGqW3t7KRPkB9A=;
  b=q+ZTin7HFPIV3kFDvPPKfosSMoT5lh24I1F/CuXq72UWH5XkUQJ3es9d
   YP+bNWS0oYxEOF1SITw8fBuuIQ+j9t1U7UVm0lDVBXm8URMtWko3funV3
   3iPnlasgo/kxeahnCOqKjh8cIy8MtDY7L5sta2f2W6o9ZsbdKPQz0CaqR
   WoGls8tl7WPM1Ybyhvpe2ijT2J/SL7PApJwGf+MyyY3QzPli3miqr+dQU
   CpxYDYbaj8WDRmEWzqs+hERdKiH99iy3cwvykP/C12mgOKFJMx0s6KYL5
   gnKYpmvAyMta13jFpVZOsWAUxJ/8Ef6R8Xf4m5wsdkt9DuU4/CEcikzBs
   Q==;
X-CSE-ConnectionGUID: D1YbGy0gR7685tDEwbAB7Q==
X-CSE-MsgGUID: UlK8vAVhSFmtBXcCyirhEg==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33654426"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:06:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:4219]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 16f7b55b-9c7b-409b-9075-6902078ff420; Fri, 13 Nov 2026 11:06:38 +0000 (UTC)
X-Farcaster-Flow-ID: 16f7b55b-9c7b-409b-9075-6902078ff420
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:06:37 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:06:36 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.12.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 11:06:08 +0000
Message-ID: <20261113110611.2915381-1-dipiets@amazon.it>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Backport of 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
compaction for costly __GFP_NORETRY allocations") to 6.12.y. It fixes a
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

  v6.12.117              87,565 TPS
  v6.12.117 + series    144,458 TPS  (+65.0%)

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



