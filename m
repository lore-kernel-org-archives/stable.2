Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC442D5932
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075552; cv=none; b=AOCK2F4B0Z7/hSNvfOponxf/Qc4G6K8sXk+MSqsLjQ8B9J3QWadZhOBSMKWEL96nYGTgDOqSnFugravC7VPY7exxkuFzbM1N9E7ClcWZ3yy+pe/Keqn9ij3Wc3DHMCWThAdI79QEjsY1WaVirsGqweAOGUhGuY3ehSby+gxHJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075552; c=relaxed/simple;
	bh=6IO/flmMg+yIG4kX9B1eWs1LzYGyN7v2mHbD0zCImig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuUQtfneq/B79pysHOvUzsD5jJTwVmZpANNJI8ivP13hPYeipEOGKt5QUyzJrHeDslWHa/qZ8Roo3lJ+dP7txDrlSK9T8paMGlTH18qNjKWjvM3c+VzcRRtTVX8PZedq1RoNzrjVE7GXiySEh3odaSNryS15OhSRi7oUqOOthfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=H8h4KCz+; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="H8h4KCz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075551; x=1823611551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cKx/t/+TAF4YjXU23LNleHFcUmfPDixkfS6sn57a3s0=;
  b=H8h4KCz+++dodxhM2V0ZEMNWR+aCC4El10pxihp+JBkQFLJiBiaVLRae
   KFWA/UFccaOG07XP6O3Rsnfjfsyb5BHhU8AXpHS/Y47goNc5R7CPPLyAk
   +fcuZ5Jm1UCptA0XqQhMbTEGCBPQqKPPQalXkSD25S3FxDxJHtaWyw9Vt
   uMUXhmFEZWVPYah02CUnqaZo2/u4/bEU9elJY61RbhioYneh6vExawigJ
   gBg3kbkJiyQKDRBckyeg8WWDp3YIoEtyobjPYp1AzmleCclDvX8M+twR8
   aQ0O0ZwyrB18RlvAWkJuXNoHm/pyLml1oGovVwcR3IUsRyagSsyQOWLRq
   Q==;
X-CSE-ConnectionGUID: Q2rGLVgxSuutHEjcu3mgnA==
X-CSE-MsgGUID: neHvo1RPTZ6dKD9HRCQEIw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31336690"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1486]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525] with esmtp (Farcaster)
 id d05f5ffc-4038-4a23-9a53-19cce5f690fb; Thu, 15 Oct 2026 14:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: d05f5ffc-4038-4a23-9a53-19cce5f690fb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:46 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:44 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page() in __kho_abort()
Date: Thu, 15 Oct 2026 14:45:29 +0000
Message-ID: <20261015144529.76911-3-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015144529.76911-1-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit fa759cd75bce ("kho: allocate metadata directly from the buddy
allocator") switched the allocation of preserved memory bitmaps to
get_zeroed_page(), but __kho_abort() still releases them with kfree().
kfree() on a buddy page that is not a large kmalloc allocation hits the
WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
so every aborted finalization leaks all bitmap pages.

Free the bitmaps with free_page() instead.

This is a stable-only patch. Upstream fixed it as a side effect of
commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
removes the tracking teardown from __kho_abort() altogether. That change
builds on commit 36f8f7ef7fd2 ("kho: add interfaces to unpreserve
folios, page ranges, and vmalloc") and commit 70f9133096c8 ("kho: drop
notifiers"). In 6.18.y, KHO users still preserve memory from the
KEXEC_KHO_FINALIZE notifier and have no interface to unpreserve it, so
the teardown on abort is the only way their preservations get dropped.
Backporting that commit would make preservations outlive every abort,
so keep the teardown and fix only the mismatched free.

Fixes: fa759cd75bce ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 9fe5d14f1ec54..9691f6bc2fba7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1054,7 +1054,7 @@ static int __kho_abort(void)
 		unsigned long phys;
 
 		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
+			free_page((unsigned long)bits);
 
 		xa_destroy(&physxa->phys_bits);
 		kfree(physxa);
-- 
2.47.3

