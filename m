Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430115;
	b=ApSmbnV7pJE5y1G6MPvTLJQ5NZMFOfXuH8AnWRkCSy2TOFbaxInE4nyzeJdq+H3Ri/4y
	 EkLayKamj5C4W9sYEENJ3fKBwjYvmyp6tdr7cph1Pdk6LkML8Ayl9TvLWQWdFySuur9To
	 XGYxdHNDYQv0kCNuusfe1xnYHoWe6A8AkbE5ZFudlIWBmOaIUVB0F2YCrl3zypq+8xU/r
	 212LW6prBtVCXvAyZoNp1PGr9xOYKKTYEX/IolKLAlUnybf6WOd0q2V8c7bR4VkeqAea+
	 PHRm5qmqPDc/gMZxNiGxpx0TDU6/bfijXovSpfvuBG55xhOEK3FSs8zr1Jsx/Vo9ccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430115;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cIh+Iax7BM1D9H5+u/MnfHAua0Cwb6nfRtbILLfMpJ4=;
	b=Xzjz9zxbgSj2WdSghOHf+FolXzJ1jKaeTK4q/yKtWG0F0/C/YZE16/dQKfa148cs8wKd
	 zPdOapAXyAmTn4LOO3AWB0ikRIzilUkELXNPcdaSYWRrM29R7afF5PEQkCepGdNeM2+aS
	 sBJZsD39RH4UNgCax4SmAAqpVILy1KNS/kB6MObMB4vaybObVWyMw3l5pds/XrdysNaJT
	 aHlMfFHJonU7OhpwrUJ553xqWZi6Qgm1bgekiS0VhiuUh+MUchyFtqFmwOenRpTd5co9p
	 ijIerI6bIJ1vfPrc/3yFiN9l3pvmSpEc3WcDkmT5j5gq2fr+kOibDwlBNs7+AcJ2VKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CGvoZVyW;
	arc=none smtp.remote-ip=95.215.58.82
Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61436606A688
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61436606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CGvoZVyW
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=80DSeNgLr4gsI8o+Z1IuJ6m5ooSb7Rnaj6ZFYHuYkyA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795430110; v=1; x=1796034910;
 b=CGvoZVyWhBT92ElzgOOfOuph4j0qKjTklFTmoj6JdgCWVzddqYEYil7ZGEr6zHuvsBoFv3M0
 XnyIUpczwZ0tuc13rl2fKUv+EV6SZx5uxBOuXfZmDSYoldisug/xgUWyPxKEMWg7FwS3+nPQ9to
 nzofNZeZgt1ZJHf8hvGyNN44=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f6937f6a9f32d691;
	Mon, 23 Nov 2026 10:35:08 +0000
X-Mizu-Trace-ID: f6937f6a9f32d691
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: Fix THP block mapping when the PMD level is folded
Date: Mon, 23 Nov 2026 10:35:04 +0000
Message-ID: <20261123103505.1006067-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123103505.1006067-1-fuad.tabba@linux.dev>
References: <20261123103505.1006067-1-fuad.tabba@linux.dev>
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

When a THP backs guest memory, transparent_hugepage_adjust() rounds the
faulting gfn and pfn down to the THP's first page, and KVM maps the
whole THP with a PMD_SIZE block. However, the rounding uses a mask of
PTRS_PER_PMD - 1, and PTRS_PER_PMD is 1 when the PMD level is folded
(64K pages with a 42-bit VA, or 16K pages with a 36-bit VA). KVM then
maps PMD_SIZE worth of pages starting at the faulting page, and the
guest gets the host memory that follows the THP. With pKVM, the
hypervisor rejects the unaligned block, so the guest doesn't get that
memory.

Before the conversion to the generic page-table API, the unrounded pfn
went into a block descriptor, where the address bits below the block
size aren't part of the output address, so only the THP was mapped.

Round to PMD_SIZE >> PAGE_SHIFT pages instead.

Fixes: 6f745f1bb5bf2 ("KVM: arm64: Convert user_mem_abort() to generic page-table API")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1db10d8d6db73..bab44021654a0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1573,9 +1573,9 @@ transparent_hugepage_adjust(const struct kvm_s2_fault_desc *s2fd, kvm_pfn_t *pfn
 		if (sz < PMD_SIZE)
 			return PAGE_SIZE;
 
-		gfn &= ~(PTRS_PER_PMD - 1);
+		gfn = ALIGN_DOWN(gfn, PMD_SIZE >> PAGE_SHIFT);
 		*gfnp = gfn;
-		pfn &= ~(PTRS_PER_PMD - 1);
+		pfn = ALIGN_DOWN(pfn, PMD_SIZE >> PAGE_SHIFT);
 		*pfnp = pfn;
 
 		return PMD_SIZE;
-- 
2.47.3

