Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCE86341;
	Thu, 25 Jun 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378765; cv=none; b=T2saQEbOdh6RwpczFyq7gD5rWCdMauVOt2QE3Ja3hqR0RXqUTs8PzwuCiCLbnSggSNuyUuHwgygf+KhSrOIBSIqS3wouDfvsSHu0m9A7oTzw17j87hopsIKOm7NAkkKgSHKp83oNg5VEgsEWo5B6H6LUUrzAT2dTz6XStEwJ86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378765; c=relaxed/simple;
	bh=phD44Soa9TdRo10MhwYe6q+yPEAM2IZei9j+HAfyAS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baIu/RLhRoQg0R1wF8rbIT3EzWHlSZmW4UDus+h4XFgGma/3FpKRW3DGACy05Ybaq+4ZkIo7NowMPcor+uPSbzGmeo88yd+m6s7mOoLGqIoSMmoMx5pZ34hsmXN2uGfC76W395AWowbYprG/hGh/QZz5cdxjEkI/XtZ3GnA8NwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4A4BA298580;
	Thu, 25 Jun 2026 11:06:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8JKdjviwgb2F; Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 87EE4298599;
	Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m6VPW3jCY1jW; Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 106E3298580;
	Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: upstream+x86@sigma-star.at,
	rppt@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@kernel.org,
	Richard Weinberger <richard@nod.at>,
	stable@vger.kernel.org
Subject: [PATCH] x86/Kconfig: enable ROX also when STRICT_KERNEL_RWX is present
Date: Thu, 25 Jun 2026 11:06:27 +0200
Message-ID: <20260625090627.1501095-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Running a kernel with CONFIG_MODULES=3Dn causes the W+X page dectection
to trigger:
x86/mm: Found insecure W+X mapping at address 0xffffffffc033a000

The W+X pages come from __its_alloc() with type being EXECMEM_MODULE_TEXT=
.
Without ARCH_HAS_EXECMEM_ROX pgprot is PAGE_KERNEL instead of
PAGE_KERNEL_ROX.

Cc: stable@vger.kernel.org
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Fixes: 47410d839fcda ("x86/Kconfig: only enable ROX cache in execmem when=
 STRICT_MODULE_RWX is set")
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0b5f30d769ffb..330ccbf6726ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,7 +85,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_MODULE_RWX || STRICT_=
KERNEL_RWX)
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
--=20
2.51.0

