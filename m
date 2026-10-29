Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240604;
	b=aLvQWCUmP7AC4OaVE5mS0W+PfhhEKTh8LgZ26qhg/e44mOE73qlDbXLqEa956CATX+H4
	 TMLtXST0LE4AiASiQx7rlA532BwT8Zhscni3wXfTBAg3vxTeWKEhn9VJQeBjytJdCvuBZ
	 yUR5NpP0faSMxmlFtIPfFvLWqkAMN9ZjcZOefH8fF7rYFl2StMc/z7rb+TL/lqZywkgMX
	 BfyWzhMKJJYNPTu/i2XGwYoPv3bjnAM1WOxAUhjfuHHNiW7xIc1yDIGI4FkgBhmGiVWgY
	 zRyVx0kX6u2fRurs+96o3z8bnnho4lz6CWzmJqBGopjgXGb3yEwBpCuTcEGpkrJYmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240604;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2R1E4QnB2GatWY7BjfUtcohiF9+UhXdTKQHu6g406sg=;
	b=gLBl4RYp2uzTQ6OxCyk32As/M/UzTzJfLX4lz+3jWAu7pJ8D1mIJMtlJjwXiWa2cO9WF
	 dAlJh3aGqlRQzAq4alqJQnIcTUnrAB5C6f6+qu5lO5bo3pu3mZoJSgrEPWfA/gb9ccm/j
	 KokMFI4ulszIi1RGdMg63M6aLPyvWjnf+73aN3uSsdPCWL7cH/F19Ay93B3qoRZJot3MK
	 e011qiyx8sq3Wa2q45bmaIdroN+SZpBKTO23IDtUdsLhXrO0ic3b+W9lUy1H4Fq69h6s3
	 CV+zMpgJJCCCfYC8YkyeFexmyZ8ISao459mzYAtUiJRHVh4Wl7MDLXZYMUhIiaWUh4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qu1YakM8;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC9606A330
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DC9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qu1YakM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793240603; x=1824776603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2R1E4QnB2GatWY7BjfUtcohiF9+UhXdTKQHu6g406sg=;
  b=qu1YakM8ix9PEZyel5fXKnHUBG9lCyhIka+2P4LSSmMo+V3YvuJaHxVU
   wRpiCB1rFKJ21RQ50/oCrO1YMP0zaS0Qg3zhNSMb2boraHRT/qmyAH7Tl
   WxsVeUZGINvdIQ+BxlCFFO8S5L0U3H4dQH6KiFxkxJwyq+CqTbjiHk1kE
   SN2/5+xK4ueehuIlj3BSF8M5ZkvZM3d3cbt+DmGsSiyQraEOGdQ3h8rUG
   wOoXKvMlHJ7s+Ylu/vWRewnU8UxnUO10nHNKDpDxfV7OYY6WLwBa/1hmS
   e/dAK4/9iN+5LVIcRvtkJpravSWiGz5dcK02RkoAI9b4UAGbSOAyPxVqZ
   g==;
X-CSE-ConnectionGUID: LHdE7UNBTpa+oRray3to8Q==
X-CSE-MsgGUID: LfACMYeZRyej9c7PHCiKsw==
X-IronPort-AV: E=Sophos;i="6.27,183,1787011200"; 
   d="scan'208";a="32433768"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:23:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:24966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 63b80ac6-080d-4077-a816-532bf624e260; Thu, 29 Oct 2026 02:23:23 +0000 (UTC)
X-Farcaster-Flow-ID: 63b80ac6-080d-4077-a816-532bf624e260
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:23:22 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:23:22 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Fuad Tabba <fuad.tabba@linux.dev>, Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH v2 6.12.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 02:23:08 +0000
Message-ID: <20261029022308.2620922-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029021918.2596937-1-mkbund@amazon.com>
References: <20261029021918.2596937-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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
v2: add my missing Signed-off-by
v1: https://lore.kernel.org/stable/20261029021918.2596937-1-mkbund@amazon.com/

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

