Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240423;
	b=0IUwEAhnuDbDluDjm/+dUcjfWlgGcWN97+3rwW8s5W3XH1V9pVcHjRgnc+cc5WBO2Nkm
	 vzdL3bOyVBYILhoMr7Ss7yGUKhGReFMio5/KVJLUGBfqR06uayIM3flICDp4mOHKeu1Ni
	 iiHeLcsqYPqckPW9WKfBs+6ImqZXWT0IFmAatf9ThFZeDctfxREk2v3Afn1hCkcj0+3k4
	 0WBdMUvm9TFgA76OdSO1RHHSoDC4xArMTs86au8oIMHcjVn/8BCXUE2BhnOOWU/guXXOt
	 Tdo577VlsGDEI1xj0xXbdU98qFYjMs1ix4tKJa8/u0Uh69THFpGdqgOA6XbgueZ28vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240423;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=xGhyFxjRHb1TptDTOCDC99GQjSqfpaVZAZkMO4GnZtE=;
	b=svHImpo0ynA6pW294p3yzNXhtIxCwpI31K9Zv/c0KzbFDYs74gwnFaBVyHbIY+Ayr2eN
	 XG84JcfgKKJMUTtKdMhG0lb1WGL3G8Y0Dir+fERij/JBXkEv8ka6fWDU6RUkpJRmOjoLJ
	 PGtXhnRopY3nRilGUsNXhHTOOx7dlVn/3bC9npa/giPvUq8FHeEScL2n9iuhbKbT7d0tS
	 r9x/aHTaWkNLm4mhsmPILDU2oW0/Uubl+9Xr5Q8F2OxfhXrQ+GyRMHa6dwBwdMucRdm9O
	 GYgT46nWo78PuZrXE8NvJ7CgdCVMgA7YyZB84iesA5wvpGLp5fbC+owi6qCfTeT5unw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jTt2x6XG;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3C606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC3C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jTt2x6XG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793240423; x=1824776423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xGhyFxjRHb1TptDTOCDC99GQjSqfpaVZAZkMO4GnZtE=;
  b=jTt2x6XGh1XW5PxYKVxONmf5bMDgIb6vumQhsrXVrBwSG+jFvtZUDmpt
   TPx06humPiMzd7BdseXJa4/hiDmxGTxfUt+53Kw6GCeIYTB0TYxKZVwMQ
   eEmoTCkOlr9cRXyWl2UNEifHfGk2W7a8wITyLfsqz1Cso9l0tWt9c8wIr
   5ZID7WX76hkpXSfakqW5laiZEhcvHqw2k8n6/hkloM/CWGWIcu5u1K+Va
   DvxbRAKVsOFeN7WezhRRNi0uMIJLHFhaPOQdx7etaBVR8iHWMR+uNMO2m
   vSzorUFdT1YylbMOA9gCTex6smeA5+7Mqg5tB+xESIGa27k8AbW6KlyUv
   g==;
X-CSE-ConnectionGUID: OEUXt15fTw2jPLRPgENR2A==
X-CSE-MsgGUID: urJ+1TOITHKrq4ewX5trdg==
X-IronPort-AV: E=Sophos;i="6.27,183,1787011200"; 
   d="scan'208";a="32321792"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:20:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:29923]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.21:2525] with esmtp (Farcaster)
 id 888d6ea5-f3dc-409d-9bac-2cd38575d6d5; Thu, 29 Oct 2026 02:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 888d6ea5-f3dc-409d-9bac-2cd38575d6d5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:20:22 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:20:22 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Fuad Tabba <fuad.tabba@linux.dev>, Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 02:19:18 +0000
Message-ID: <20261029021918.2596937-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 08770d7cba4b0..2763bf8dd105f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -264,6 +264,16 @@ static int fix_host_ownership(void)
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
 

base-commit: 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
-- 
2.50.1

