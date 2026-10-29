Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240934;
	b=BZDZRUcArKfjXDSOmAAzi0m7r/O3zFTTKa0mbEpyKt2rnyC3OJpgrkCKPn1bVXzSno1V
	 EtiZAsPk5x3D/SHypkTfDjhgNFMx0shi0EBaKSmc9d6U1/rLIccsGDI4rBWXvcwYl59Aq
	 H+SmdzvhzM1BcAuWAeLqkT8oIdsA7sj/hG2UyEOI6JTcVv6oAmhF0ZObWlzbjWs40XGA5
	 iicUzKsOr9lVvqO//dRno8g69UsRg5Wah4XORE+veKjEGn3bYM1vX5+K8eDq8FG3iPvFK
	 5gncSxhnP4oVz3hH/NAz6li5rRpflbZn6LCphZE+T86UmsnvJkBlK3lW+I4Z6bYsILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240934;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=SEhhGsnVr1dyJancNN/85/bOvozExKeXHdbMvEDEscE=;
	b=o6dninaw2CAkUJYePqqlyfjSD9v/TmEFwFC3wRLAfB7jSgGmyD7EIG1EUpkvLhT0poc8
	 kdsXTYNpjTT4p4+pKPrxQpoRLvviZEBU9tpzhB9MZgxY40aSY/K1EsM2UemngiBtwS5hV
	 GMJlnUD/ewkH24pXWIkzapsoJPySxwBQUZL283n0JW3Ng2MaHhCfg4+YfaKP/3vBT/YWA
	 DwSurHC7RTy/p5WcROdtuUVzwtr/kAJBVzAN36IUxyIPliM69BdMBZ5gENbWmVwHbP1TZ
	 uD1eHYgwLdOUmWSSgSz569YHR4+XkXO/QGAk60NwJ2KmjmaY/bRA0EVoMFipVUFTfeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HFNHnoLQ;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BB606A326
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 509BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HFNHnoLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793240934; x=1824776934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SEhhGsnVr1dyJancNN/85/bOvozExKeXHdbMvEDEscE=;
  b=HFNHnoLQo72lQ0jPMLP2bIZw0lN4DMsai22YEoU2/X1CWz/vO65HEN8C
   18jbQPcGzdpIhlwuVaaXqIQ1gXT9mCoUF7MXCCkas8mwgRAHzAvGP4JM1
   d1ZEywHjQgNb8Ix7Y2+F3fjnIFOccSZRBlOw7rIWGwHP9Y2/AMTYiLnlX
   bjNm1Op4+wVih9xkQ0+ZWEndjKmypVxR68UO1F9gfutT54vc/gY8XOrpH
   BUUdXIIK2rGY2+MI9SKKPwnYnol346BKGORt1gCCblFmWPBgJi4zM5mEA
   2XkpI4SBU/Goc+sh2WFgncOiupVSXoi/ZhdbosRKiXXO5LNg4Zwh822Z/
   g==;
X-CSE-ConnectionGUID: o4iZ4nSeR4SZJOL6AIImDw==
X-CSE-MsgGUID: ixgpa6/DTda2Y0Kk9ZhXkA==
X-IronPort-AV: E=Sophos;i="6.27,183,1787011200"; 
   d="scan'208";a="32520491"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:28:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:5606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id f53eed77-4e18-4961-bcef-1469191e7bb6; Thu, 29 Oct 2026 02:28:53 +0000 (UTC)
X-Farcaster-Flow-ID: f53eed77-4e18-4961-bcef-1469191e7bb6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:28:53 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:28:53 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Fuad Tabba <fuad.tabba@linux.dev>, Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.1.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 02:26:10 +0000
Message-ID: <20261029022610.2637061-1-mkbund@amazon.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 3a8c562892b96f35bba1e00d5e455a15963bbb92 ]

fix_host_ownership() walks only the linear-map alias of each memblock
region, and the per-CPU hyp stack, mapped in the private VA range for
its guard page, has none.

Walk each stack's VA range with the same walker.

Fixes: 1a919b17ef012 ("KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack")
Reported-by: Hiroyuki Katsura <hk590@cam.ac.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20260908110713.1540304-2-fuad.tabba@linux.dev
Signed-off-by: Oliver Upton <oupton@kernel.org>
[ 38f9e4b905a0 ("arm64: kvm: Introduce nvhe stack size constants") is
  not backported because it converts nvhe stack code in eight files to
  NVHE_STACK_SIZE, and the hyp stack here is one page, so PAGE_SIZE
  replaces it. ]
Assisted-by: LLM
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index e8d4ea2fcfa09..89dbe4cb8394b 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -255,6 +255,16 @@ static int finalize_host_mappings(void)
 			return ret;
 	}
 
+	/* The stacks sit in the private VA range, not the linear map. */
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr(&kvm_init_params, i);
+		u64 start = params->stack_hyp_va - PAGE_SIZE;
+
+		ret = kvm_pgtable_walk(&pkvm_pgtable, start, PAGE_SIZE, &walker);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 

base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
-- 
2.50.1

