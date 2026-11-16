Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827154;
	b=2+5MqTE3DTA//QDlSaRxX+chmbAR2R9CXJ6COEXKUrWQEs1mWleCMphItGX/mHrceqLH
	 XsGI+ra85NJP2mfknkf1b9Ft/JJUYvWy82buPx3GIAv02iOUtvLuDT5INhUX0k6yqEj09
	 2y2nCM+D8lb2TIvULvZguP5d6JnArb3kGtbOFx5rO/BRyHvNpziXX+tj95MxXAvO+Reuj
	 2oHvkMuGKzbj2bbMiHWsoMLnIn2mSa9EjoSIhH+yTKmhqsNAh1xCLhfF5U7pTNHGnkZpv
	 eODJdN1q0YkotF2VWfk/+SP0WLb+D1A4uRg0yFRlvmzk/KQNhscwBZMW0Ue15k/7pkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827154;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ac3f7pvozHRMKcmrspffsdFebWreOCTqfsZg8CNjtpQ=;
	b=zJbu7W4UfYTY+xnRBWvVICEjpyFDpTinir3DJoKEtqh4Byit7q1GfWmz+k0zl54aOEfJ
	 bhumiZH6h9g2/eR+Hffuuuj3iki3zfTwtLHkr4eM2OfccdW2wvi3YZwxhwb7obEEAzW5H
	 fRXfgGQYEx1gD8iq42BkUwALqb0xcqEa44REy1w+isneETU8TE+IJGKW10hs0KUnArEuj
	 roO22wHrVP29jnmqubzBaz1QYzlTwP4SWvGsyMbHhzKezNhbp1a7quvFXH0tVrKuXQkT1
	 2kWdrByScKFVF4BodnBb2TeF/NYvY9Il6QSzTj3FiaC0k/ORTBysc+6TrkoBovWzXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s7eg7tKp;
	arc=none smtp.remote-ip=91.218.175.162
Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB293606A8B4
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB293606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s7eg7tKp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m5wyWpf9Hx87dvxO36yhwoD+oIhUOyMmO/fTyfd0zBc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794827150; v=1; x=1795431950;
 b=s7eg7tKp8SgVGREdI8d9hMMs261snyawQh9XWPSsGFIfBNIe+oyueARCZ4H5JOi/ssjyfL6U
 I6WfcTh0ENqkM9OQWau+pXN5UuEJiF4z+JXdtwbzSn9w4Yz3ozz6YieHeWdX3R+3MLpcRGYkcvY
 cYR8NLiXdQDDz/4aOHy1gbK4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 099d0d4b73867140;
	Mon, 16 Nov 2026 11:05:49 +0000
X-Mizu-Trace-ID: 099d0d4b73867140
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers/virt: pkvm: Zero and clean memory before sharing it with the host
Date: Mon, 16 Nov 2026 11:05:49 +0000
Message-ID: <20261116110549.1863653-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
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

From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>

On pKVM, set_memory_decrypted() shares pages with the host in place and
without cache maintenance. The atomic pool, dma-direct and dynamic
SWIOTLB pools zero their memory only after sharing it, so unless the
page allocator has zeroed it, the host can read whatever the guest last
left in it. Zeroing first isn't enough on its own, as the zeroes may not
have been written back to memory, and a host that maps the pages
Non-cacheable then reads the old contents.

Zero the range and clean it to the PoC before sharing it, so that no
caller can hand the host stale data.

Fixes: ebc59b120c588 ("drivers/virt: pkvm: Hook up mem_encrypt API using pKVM hypercalls")
Fixes: e62decaf98e7c ("arm64/coco: Add pKVM as a CC platform")
Link: https://lore.kernel.org/r/20261116091137.94252-3-aneesh.kumar@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
[fuad: take the pKVM hunk of v10 patch 2 as a standalone fix, add the clean to the PoC]
Co-developed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    This is the pKVM hunk of patch 2 of Aneesh's v10 [1] plus a clean to
    the PoC, taken on its own because it fixes a bug that has exposed
    guest memory to the host since v6.12.
    
    Based on Linux 7.4-rc3 (aebb727447640).
    
    [1] https://lore.kernel.org/r/20261116091137.94252-3-aneesh.kumar@kernel.org

 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
index 26fe9c3f22e36..81d1cd24a2eff 100644
--- a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
+++ b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
@@ -9,10 +9,12 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/array_size.h>
+#include <linux/cacheflush.h>
 #include <linux/io.h>
 #include <linux/mem_encrypt.h>
 #include <linux/mm.h>
 #include <linux/pgtable.h>
+#include <linux/string.h>
 
 #include <asm/hypervisor.h>
 
@@ -61,6 +63,15 @@ static int pkvm_set_memory_encrypted(unsigned long addr, int numpages)
 
 static int pkvm_set_memory_decrypted(unsigned long addr, int numpages)
 {
+	size_t size = numpages * PAGE_SIZE;
+
+	/*
+	 * The host can read the pages as soon as they are shared, possibly
+	 * through a Non-cacheable mapping. No caller relies on their contents.
+	 */
+	memset((void *)addr, 0, size);
+	dcache_clean_poc(addr, addr + size);
+
 	return __set_memory_range(ARM_SMCCC_VENDOR_HYP_KVM_MEM_SHARE_FUNC_ID,
 				  addr, numpages);
 }

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.47.3

