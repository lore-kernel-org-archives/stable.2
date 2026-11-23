Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426542;
	b=MxDBhnK8A7/owsKxyfFcT0RqyNcbi1wZkU+CfhVLmfyYcZW0Uv5MuxqPtIog7L1c1EpC
	 5CwJG/N3sTL2bkEx96tzzKkBVd6taLl72y9cYPmiLFm8YaLCmYso7V6BBVpJUgMFrFD9k
	 zd5IlC2pl9AwZEqu+/xmxEDg8sY0DHw+RA0OK5mqoS+unQ356XAoLJFb92fx49HQLAVGq
	 jWvS+epckPu9DJPCakHALEvei3dyvvz/Ra6LdDST/lS8qWJPGoQpKlYTwpbtkqFqpjdIw
	 691qQqtEQZRPMr3q5VA5V/n4Jrn1LPN2lVUpzKVARM6BYybONoYtLSF8wcoPsnX+SXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426542;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cSVyW0UVgqGJUNJlaP4TsMEvhElwJxyJXx8yTc90AO4=;
	b=pLYfCWNBrdyzySxNxvRyyxGPu7Gl2r57aGO4WbT5YHHbQOqG82AtxOyrOqE8AtFk6M8p
	 jkaYQVWEUqZTu1CfLsLDlhJvdqHaQlA0d+rdYrxO4sTYw+G+3eTQjzxRw3Dlk+T28gCru
	 HGddd54y7zyEhBiF95U7DhiMbRxQHs0GRpKlyUz6THsL9dvPC4pYHrn/g7d7PqxKUQw7/
	 ziPCIOGS+B3kSo6Wqug3lTM72ybs5XAKD9dSFhV3URubQkH9D4l3v3HnmCg/3jtB8OuKK
	 2CyNiTGgBJVSoZNHz/ksaTCMQVJuqRQqMol4hIX5LffkkRdjU4QJ9RWrzTo+4909cYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tGRZcgZl;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7F606A31F;
	Mon, 23 Nov 2026 09:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA7F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tGRZcgZl
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795426537; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cSVyW0UVgqGJUNJlaP4TsMEvhElwJxyJXx8yTc90AO4=;
	b=tGRZcgZliZN8w4tF/7RDSunbGVlZ1ITAVyAYXg/zapVkNKQ25bcHDztEBCCby+hfcooT+T6i/1eaXvnRYbK7jXWZO7aR6tiPnzEzIS9fM835+EEewuO7Z+BdS0JJT/w66qc5g2lxbeniKCyhLBY9d5ZnDHjYZyAQtKAEKIVvlnU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XFGOaDQ_1795426534;
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0XFGOaDQ_1795426534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 17:35:37 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	ying.huang@linux.alibaba.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	robh@kernel.org,
	gregkh@linuxfoundation.org,
	ptg-linux-kernel@linux.alibaba.com,
	yadong.qi@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Mon, 23 Nov 2026 17:35:05 +0800
Message-Id: <20261123093505.974-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
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

__set_fixmap() installs a new PTE with __set_pte() but never invalidates
the TLB; only the clear path calls flush_tlb_kernel_range(). The
dsb(ishst)/isb that __set_pte() emits makes the new PTE visible to the
table walker but does not invalidate stale TLB entries. Overwriting a
still-valid slot therefore leaves the old translation cached and
violates break-before-make: accesses may keep hitting the old output
address, and changing the attributes of a cached entry can trigger TLB
conflict aborts or CONSTRAINED UNPREDICTABLE behaviour.

Two in-tree callers overwrite a valid FIX_EARLYCON_MEM_BASE slot:

 - earlycon: earlycon_map() maps the UART before match->setup() runs.
   If setup fails, con->write is unset, or the DT reg-io-width is
   unsupported, the slot stays valid but no console is registered. The
   console_is_registered() guard only blocks successful registrations,
   so a later attempt (e.g. a failed DT earlycon followed by earlycon=
   on the command line) remaps the slot to a different UART.

 - samsung_tty: apple_s5l_early_console_setup() overrides the
   just-installed entry from PROT_DEVICE_nGnRE (FIXMAP_PAGE_IO) to
   PROT_DEVICE_nGnRnE on the normal successful boot path.

Both are valid-to-valid changes (different output address or memory
type), which arm64 requires to be break-before-make.

Fix this in __set_fixmap() by invalidating any existing valid mapping
up front: clear the old PTE and flush the TLB, then install the new PTE
only when setting. The old translation is gone before the new one is
created, so the two can never coexist in the TLB. A first-time mapping
(old entry invalid) skips the invalidation and pays no extra cost, and
clearing a slot is handled by the same step.

This belongs in the callee, as on x86: __set_fixmap() there calls
set_pte_vaddr(), which flushes the TLB unconditionally after writing the
PTE. x86 can flush after the write because it has no break-before-make
requirement; arm64 must invalidate and flush before installing the new
valid entry to avoid TLB conflict aborts.

Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
Cc: stable@vger.kernel.org
Reported-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
---
 arch/arm64/mm/fixmap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index f66a0016dd02..5593d7e0d523 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
 
 	ptep = fixmap_pte(addr);
 
-	if (pgprot_val(flags)) {
-		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
-	} else {
+	/*
+	 * Break-before-make: when the slot still holds a valid mapping
+	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
+	 * old entry and flush the TLB entries caching it before a new
+	 * mapping is installed, so old and new translations never coexist.
+	 */
+	if (pte_valid(__ptep_get(ptep))) {
 		__pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 	}
+
+	if (pgprot_val(flags))
+		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 }
 
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
-- 
2.43.0

