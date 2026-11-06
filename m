Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002906;
	b=4IntQEVFIKOc4gyJuwrLlBixkJplD+4qxU6EMwgnIVY/FvxsaV7XIlNCzaids3TJshPw
	 mcsPNgV/s/IkdLzT1uVFhIEgnp0cl6sihfXSdVPKSJ0J132Ls5rjpSfgNuofkQ7dOd5RE
	 RbWH40uio8pgPkHsk27j6xSipZpFBtXFFAsh/n2bT4xXkcR8eCEaeyhhqJG6LpFrSqkvS
	 VUOo4S/kZkDYHEvDbIZSsjts44y1BxUyw2wFeVo0rXhsyhzZHi5bDO4SrReAAChQK15eg
	 hs18/RAnkUAYdOSFy/Qe4SqUxw0kylMOkG34yDxudj/4lXCeusIilwE8+vQpSW9sPjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002906;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=uz+vtInGrcQ5ufcAYF0ugn5aIK5xFh98eI17KrlnB4o=;
	b=iBkTXOpYd48++RsyJKsZs0lo8sZQ4b7+zRkj7KWouB0nxWHnx+WvOJCVgwfK7x0uhYLU
	 LmCz7A4XdCk8xdG7ITKkxQkYbxiKaC7NwBb0OzONqf9pQjdRA+uSiOVFPw1ZLhGzzd7aT
	 wzZwCxOEvwxmBJpDD3T8aywyUmZ2bvSErKSNJcn3QjtuqnXHlUUhm+vpFbJ1LBntMI1lZ
	 MyGCR2y7ixuIpvasIHQ5+Bfz8ZQQJn3+FiAmQcui4rFEW/L6lJTEaJSJXhQDCuEN/b9+E
	 sk47SaNOfBUFDvtfR0x2o+OXFb5xaJmYQnR9ZRJ4xAnSeOOe3EKBX0PT1DORIpPHUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=h9Bo3etS;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5D606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DE5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=h9Bo3etS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002905; x=1825538905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uz+vtInGrcQ5ufcAYF0ugn5aIK5xFh98eI17KrlnB4o=;
  b=h9Bo3etSpXFWCPeo1VFmkt9kjcWFOXbMQk4ewXvdZEX8c3wLsTRUZwZu
   Y2j416uey3zwOmSfseIL/r7OLANugNAlXHO/e9fJ/ByisBW0DLAAzE793
   aU4q60NRIcu6P/U4caJD1teGKZRc2xdGRBQlP32BGLuuIEohB4HNfvNki
   D/brzR/g+3KXAwrIMUoJRFSwN4995cYl+/9TubQLlK5r2M285SKs989ya
   FrNgpWPzShF3Cpijq7oK471pRdSMRcmrKy/haVXgDZHOLs0UNQcaiLcZZ
   DxugLYVxjAg63se4d4z7j8fTgiP4wfKlBagjiw19TzPPqXPfme6ZOyCRm
   w==;
X-CSE-ConnectionGUID: mgKKp0rlTbmXL8v49ddTjg==
X-CSE-MsgGUID: vLPUzXlXSPOn7xMQgPPTPw==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="32868760"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:08:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:30014]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.149:2525] with esmtp (Farcaster)
 id 40c12b3d-c734-4c92-b6f5-08dfb3f685a5; Fri, 6 Nov 2026 22:08:24 +0000 (UTC)
X-Farcaster-Flow-ID: 40c12b3d-c734-4c92-b6f5-08dfb3f685a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:24 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:24 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, "Mark
 Bundschuh" <mkbund@amazon.com>
Subject: [PATCH v2 6.6 0/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:08:10 +0000
Message-ID: <20261106220812.2874571-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105070431.3100950-1-mkbund@amazon.com>
References: <20261105070431.3100950-1-mkbund@amazon.com>
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

Tested in a VM on 6.6.161: memory offline of a block with mapped huge
pages no longer livelocks, and cma_alloc() over mapped huge pages now
succeeds (it failed on 6.6.161 and with v1).

v1: https://lore.kernel.org/all/20261105070431.3100950-1-mkbund@amazon.com/

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

