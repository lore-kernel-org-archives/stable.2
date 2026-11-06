Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002700;
	b=YB/cnp0yY17ATXUwBWg+n9p8QkHL2F/phkguLuz/F3u1awyVVywldyNoekVz4kxuH8Fh
	 Zeds7SjlkLgRUzIymAijDujWIGmiyx3voFknZ9VVE/MUC62g2iiEyr3r86t8KsmMFs8Ww
	 nYpN+1rpide8tZdRoGOHaqtDxAw9oVDgfBmZ6S8x/WJkoIPV8tyioJL/3Sc7gcxvE4PRg
	 DnDacKhUHuREHCFreFQPYNqQ3AdcmZHyV31ATVgzhlZO8THtwW/PCznVEcHA04DpuRG9N
	 L5s2ctu7Q9PSTWbHBHE3LjLXh5frby+kRs2ef5xJo9SK2IJAQp+bLj+9002LyKZUDgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002700;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=oLrmRPO4L41NIijXQyCjQuY95kcRuW8UwPMF6YfqEyc=;
	b=YeNy+5vMwOnwQr4tTJt1uycUO1PDJHgZ+T6i2/IbwX6q20vT3YJ5MeC4GsVxNbDJSbZL
	 VNOzdAH8w2byCpARg1+1nYiXbkhu+TOKmYlTNbougjf/2uOg9Zng0VNaSEmkcscZNGyhd
	 3o61Lx2hRPlRcaNLZDMFINCnN4joz8F8xg+T8jWySDLcquSJa1ll3HPD6KcplatsZtOWV
	 B9pSvbm0p+cOrdfE9tqvj7yCn0ugP0FFoLlyU4VCpQ1PMeUfwJvbrbiBuUMbn6c8nCvpM
	 sxNUaL2IVKUYR2v+e0grNlnkd49AxbWU1T/NjqYKmih4SUBUGeJ5DflNcsg0mZYAabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="T9Pk2e/Q";
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFE606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37EFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T9Pk2e/Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002700; x=1825538700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLrmRPO4L41NIijXQyCjQuY95kcRuW8UwPMF6YfqEyc=;
  b=T9Pk2e/QT78Ire4Wz8BAAT6HOqkYc42E6gLCSUxl46jIhEua/XKkudSW
   tLEEFFRk0WsFLozfpWgDZb7AeeNOJAhPHGlhkOP7Q8cLnNNwuc2BvZmbc
   yN6JO3JJs/aTgY2Zer/KUJgg4EKtOjAFdyB0Zcqs8IpZPk7knL+twz90M
   U0ra5eLhrGnNIqZwfZq6IvM0CI5E58FBLbiAvV9ZqB6pc3Bj9E9YTucC5
   d4ouvSvuIdfPqhJuUFF+WvNN9MBd7u5ybGfODOGnzzOZsNj365PmP83ty
   kscBYu3zndkHuOOTBkJ9eeSLC+ou1WFGr76+Oi369MhBlQHBDAgp+v4Nx
   A==;
X-CSE-ConnectionGUID: T3CdrGdWTJWJ6GjmeSEA7A==
X-CSE-MsgGUID: lyuyMoCpT4KQU6TPQ5A6Fw==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33352098"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:04:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:28602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.48:2525] with esmtp (Farcaster)
 id 6ca3e216-2074-4d18-a158-eea63cf6ce41; Fri, 6 Nov 2026 22:04:59 +0000 (UTC)
X-Farcaster-Flow-ID: 6ca3e216-2074-4d18-a158-eea63cf6ce41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:04:59 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:04:59 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, "Mark
 Bundschuh" <mkbund@amazon.com>
Subject: [PATCH v2 5.15 0/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:04:42 +0000
Message-ID: <20261106220445.2859944-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105070206.3094675-1-mkbund@amazon.com>
References: <20261105070206.3094675-1-mkbund@amazon.com>
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

Full backport of 04f13d241b8b ("mm: replace free hugepage folios after
migration") with its fix 113ed54ad276.

Tested in a VM on 5.15.224: memory offline of a block with mapped huge
pages no longer livelocks, and cma_alloc() over mapped huge pages now
succeeds (it failed on 5.15.224 and with v1).

v1: https://lore.kernel.org/all/20261105070206.3094675-1-mkbund@amazon.com/

Ge Yang (1):
  mm/hugetlb: fix kernel NULL pointer dereference when replacing free
    hugetlb folios

yangge (1):
  mm: replace free hugepage folios after migration

 include/linux/hugetlb.h |  7 ++++++
 mm/hugetlb.c            | 49 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 12 +++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.50.1

