Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177016;
	b=kZliZmgAU2jdsMSRRgTXl0x/Whc/51W9TyATCa7/dlqQzTf6K6ScDlLvDNV7cU8D40u1
	 pObxbAqobHSSWWTULy7EGHUtLkQS9XLlVD7egKKDTGN57msv7OiRCPkuLDkOnstFt5KYi
	 dYIA7SO96MPYgwDu/fF6jespzJsp6dOEwTebo6roeNgvt1VZxmQ/UjywfR0oTU6L/YJPm
	 ZHk2EGU5kE01s3J6uac5ResHI8Jwby6pOFlEnkZbXxA/wZulIpoR5zMkV2DwfRQ7BKDjE
	 jGfqBUtWoZfp9zRDX4jP4HtpgbCIj5wZ2oOul071h8zPg/qGskxerL0dMhvpAzZaE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177016;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=spoiYnWR0WKKRs7Mhq5Q09v/YFoqQN68ueFyWXGucg0=;
	b=mUgy6lRkjzcAqKUd3HUn8wMt+bwM8p3SJpiRSgotAVipaZnQvbIfR4GOMkdFrkth3vf5
	 mmrm15CqlxGwrcJ1lRaT57PryrPUSEFCua2+GDn/Tt3gmbW9fdTprvCcyTe+cmTbux2c3
	 o8ksAZYc7qBzZ3LDkK3YLa7GTrrOM7Sn7jqNXJRUTGp8tOpgJUlG4yaBVeBVDG9tSZPX5
	 e6Dp2fCSvJBI1smfLB74aTTRlquzd0aT6eYNlBHBExN4HAyMEpAmVIipSTCL2ds9rgH5B
	 g1LFePiRcoqWycQ2PbvJPtngu8mSe/mL4wIIAFOD75aD8NRLGqthqZqM4FUrp+CdqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="BDi/9kXJ";
	arc=none smtp.remote-ip=91.218.175.96
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41771606A334
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41771606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BDi/9kXJ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q/N+GDt8QiK0EADOOx91mUK2qbf8ppdyYXeJryKLBCU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795177014; v=1; x=1795781814;
 b=BDi/9kXJf4YgRBbAHxD3RyugCbjKW0PCal1+Gv5IYm/c2FgLLV7VbqY+f1zHlScILQiVZSw0
 +03BU6gv7xmavzbyWPCdEZAWETU5MqSdYzR9jIvXi+rqN4ZAYCafaPdGc7Qhrshm5ue6emni7g4
 DpdU8ocr/xq9tuP+clLQGljk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18135977f985d146;
	Fri, 20 Nov 2026 12:16:54 +0000
X-Mizu-Trace-ID: 18135977f985d146
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] arm64: mm: Don't defer the barriers when installing a fixmap entry
Date: Fri, 20 Nov 2026 12:16:38 +0000
Message-ID: <20261120121638.194154-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120121638.194154-1-fuad.tabba@linux.dev>
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
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

In lazy MMU mode, __set_pte(), which __set_fixmap() uses, only queues
its DSB and ISB, but a caller can dereference the slot as soon as
__set_fixmap() returns. On a CPU with BBML3, runtime changes to the
linear map are made in lazy MMU mode. With 4K pages and 39-bit VAs, for
example, such a change can update a top-level entry, which
set_swapper_pgd() writes through FIX_PGD. That store can fault, and the
kernel then warns about a spurious translation fault. When kgdb stops a
CPU in lazy MMU mode, its breakpoint writes through FIX_TEXT_POKE0 can
fault the same way, and fail.

Emit the barriers directly in __set_fixmap().

Fixes: 5fdd05efa1cd3 ("arm64/mm: Batch barriers when updating kernel mappings")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/mm/fixmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index f66a0016dd02d..951004ad700c3 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
 	ptep = fixmap_pte(addr);
 
 	if (pgprot_val(flags)) {
-		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
+		/* The slot must be usable on return, even in lazy MMU mode. */
+		__set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
+		emit_pte_barriers();
 	} else {
 		__pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
-- 
2.47.3

