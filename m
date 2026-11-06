Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002849;
	b=tsOkzRxSg9G5ZM7tkvhXu3YDYvnlVW7V+wAWqWMK61s+lXKUHJp68EWJZjoFZI3kC+c8
	 gYufZvKzFnuBup5yyGEhFvuMaN4Bhr8vCNklJZI2Mq9FyXio8sKhj0UiOkCjWOVlmOdGG
	 p+i9cI6V8kXXd08U01q15UHD26jqNmx36ZQxbma5cEePJO1/U86xooIXFPp50NlRQz5/S
	 IRhMd9MkvYAptnLDC+sQOkuDJIxAAgl0ujrnxMnqv9M1uhfTq6NcZdoqCiye9agVT6iQX
	 ci6j30Ms5RGmjvwEqIK7Cjbf+VG63HDVXcXkmTZornnb+t8pJgVj72PFUq5AY3Jdkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002849;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=mN7K5Prc5wWoa2lY0PF8BjYfBWGH+sxODSpxNzbIWhI=;
	b=DXpG98WuoHonPK2whW+h413i1lPpM8NXYLPOFlo6R09F5nsgTy/BUF4GSwz1PEPq5i+N
	 8+lQlyyDOVj/YiNFFM2kOx0diJIKXtGk7my6dYAtjDjMEQ4iYfoq2w40tItMuPIfAmb2U
	 nRswDllr18u4bzPXfHb6IMB00V9vvzGhf3DESsN8aZCZSyO9VvIyWrbJQ0C4i4wg3yji7
	 q12FO6kNOmlU/XkzUzu52Fk/pylWUxpwrVlJsCxdxghWqSFUKDXW3E3ouucbV3adm48wz
	 UkH2JS/Z5YulM1d+UfMy2/0c9FKhh0H5gg48Zi7c4HbMpOlF6W7uz7iKFInW6TYhMtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=aIS0LFzz;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7795606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7795606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=aIS0LFzz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002848; x=1825538848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mN7K5Prc5wWoa2lY0PF8BjYfBWGH+sxODSpxNzbIWhI=;
  b=aIS0LFzzxFdMrZyvJ/om+4JQFYyZQit48unqzeVGu/OcZ1OYI1/dMSwQ
   aGj2nQcxI6mISJvSehKE1wl8EKxDZZw0nS4vbjCddmSClor3XjsVfB6Sx
   91z6e3TdZlNHKOkp3pv9ihUM5kfo+BljO89zREV7AMtqZVRL+72IckriY
   ECUvN4CWOBZ+svBlMJU+oeczC15GN26LBjfRFRJpqcSrtlKYqforTF79N
   TKpHBtVp2ay/G0LtluITr0AXaeqFpCofGb5sFdA+1JU6tuFmmL+C3JQeB
   ZF83aDRlcJVS960c+Q3R5W39PzUXyGx6yyWPEDltiIixRrgeGaMAo5tz7
   w==;
X-CSE-ConnectionGUID: usc/bu4uT7erD7RmTOQhhQ==
X-CSE-MsgGUID: 4zRfsaKcQN2Iyt11fIdwKA==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33359475"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:07:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:16837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 8848600a-6d00-4643-8068-229fe4efb9ea; Fri, 6 Nov 2026 22:07:28 +0000 (UTC)
X-Farcaster-Flow-ID: 8848600a-6d00-4643-8068-229fe4efb9ea
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:27 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:27 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, "Mark
 Bundschuh" <mkbund@amazon.com>
Subject: [PATCH v2 6.1 0/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:07:13 +0000
Message-ID: <20261106220715.2869940-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105070346.3099207-1-mkbund@amazon.com>
References: <20261105070346.3099207-1-mkbund@amazon.com>
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

Tested in a VM on 6.1.191: memory offline of a block with mapped huge
pages no longer livelocks, and cma_alloc() over mapped huge pages now
succeeds (it failed on 6.1.191 and with v1).

v1: https://lore.kernel.org/all/20261105070346.3099207-1-mkbund@amazon.com/

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

