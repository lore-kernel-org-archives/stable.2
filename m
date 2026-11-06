Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002928;
	b=BrnTy1p8+YRmGqsXecfPBU6fwc6c+BQf+N4jYXYiwQV35Gqumx+XvJ3MitIH5uXLZ1ID
	 y1CjDI4LQw1eeVJgf6ShJADKSTceaz5g0zYmZ/gMjxqQSWtw6o1aTDzWwDAQUofAelcMq
	 RaoSyoKk3xxWEyrpahkxhgEgSw6UyLrogMiEpl0X0SbvHw8y6xg0pTS55cmdLvquVcWfk
	 V/ujwcq2MaBv9B2UillcpJsiSykV8XkuEAiMB8Kj/bCDpfu6emfUb1UjdjvgnEFnynS6P
	 T8mRmpWBLdwOlr25UUeFjpnknEjp8zElxqwN6fbXKiUUSb+s4pQEI4Qrgs/Cwi1n/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=muzx4GYyxmP6TkX6aslSzN0rCHQo8+v8e9kqEllWsZY=;
	b=W3JN6qXPna6zt00QovCAI0kWPJvOVBPF64EZUe+mPS+DDzcY+KvyNZEbqJ2ciSaIT4ES
	 Va9i16zAKKUDqnmm6vsLO2JPx8H3XooO/RbLfF0rk7oOpgHX/B9vxb6Cev/E2kDcwVxBP
	 ZcprrxD+GSlnfePRFF3QD/j/8Fts3KDFAL/d9Z4bjxgX0xWQe7zZh8cbT5/u1714eO9jk
	 CgWq+DiKFqnJsARTZlhJejVMVmtr9Sh5SBpYJwFsqwr7+Ls+CrqQCB6iAPSbhCvpDKUEM
	 DpRs7vAjWqogu3m+nnRt6B3OMP3hjwvMV+CXA8Ll+AtoLTBSxA+LPT6vkwh6j2iy8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="NJHZK/ye";
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7A606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NJHZK/ye
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002927; x=1825538927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muzx4GYyxmP6TkX6aslSzN0rCHQo8+v8e9kqEllWsZY=;
  b=NJHZK/yezxT52/uZaWC0S4hbsuT1rQH6PhXtrPYGFHEh8D7CzDGUphOT
   IfZzQZ/xlKejxmSFTGuDoyA6XJPLeVWkR+fb1xuSt5zOtOJKjh0BDHpYs
   nHMyHY5fYogXSaYtYITF6jMk9g5zWhOJlfXF2egCwvG4yvGaqAN7CcDnN
   Xi08B2YUyLQtBy6Ls2W5XiFBHFNcXJGR9A3MkXz1TrqWNBhtPo/Kf5stt
   kqnDkTQe/2jpteNfmGkiIYPCsAAgqwf6isKCg60Kh2OHh44C95l6zANKb
   cPfbjGM6DkYvwn47g5vtSoEVPDFZb/RI8TUeyGysYoj1CHWTSyBe7GoC0
   g==;
X-CSE-ConnectionGUID: OxSyhlhaRsCTCzTLCCHFUg==
X-CSE-MsgGUID: Jqe4UQgCR4CU+k85J01HRw==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33227437"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:08:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:23494]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 28f3d51a-68ed-45fa-9a7e-5a3d96734e58; Fri, 6 Nov 2026 22:08:47 +0000 (UTC)
X-Farcaster-Flow-ID: 28f3d51a-68ed-45fa-9a7e-5a3d96734e58
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:46 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:46 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, "Mark
 Bundschuh" <mkbund@amazon.com>
Subject: [PATCH v2 6.12 0/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:08:33 +0000
Message-ID: <20261106220835.2878368-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105070442.3101877-1-mkbund@amazon.com>
References: <20261105070442.3101877-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Full backport of 04f13d241b8b ("mm: replace free hugepage folios after
migration") with its fix 113ed54ad276.

Tested in a VM on 6.12.115: memory offline of a block with mapped huge
pages no longer livelocks, and cma_alloc() over mapped huge pages now
succeeds (it failed on 6.12.115 and with v1).

v1: https://lore.kernel.org/all/20261105070442.3101877-1-mkbund@amazon.com/

Ge Yang (1):
  mm/hugetlb: fix kernel NULL pointer dereference when replacing free
    hugetlb folios

yangge (1):
  mm: replace free hugepage folios after migration

 include/linux/hugetlb.h |  7 ++++++
 mm/hugetlb.c            | 50 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 12 +++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.50.1

