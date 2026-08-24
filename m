Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921753AC0C6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551194; cv=none; b=I3vWEf9w00OI2e98ff14BlqLPIML0/WVWKe5azNlqv7nyGwQ//pZ9wTlTodoWgcd2VrPkloIm8brlvBzFT53Q1d38gPeIuEZb6wvtk6vbeRPI2uOZvqenPoVGZlAjEDHooaOGKe3wSoEesYfoQlxNXmLvo6ctYeDAvIgUxIt94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551194; c=relaxed/simple;
	bh=0/l7Ij1goIn19vkom/RrNzrbmiss9Sj7LMK4n3dx48I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gEqNivAPTBv6vNC9lgypAqo/3+ujnVDwXRIntN7Em3EfDGDOIY2pASuRTXOnpdeeZK9dg0rzYRUx2qgPE++jf8qdfP2gIkQ3BmSTrvhaGjdif6k4+5/ZmSIetten2m66Pu7xQ7a5B40IRgysjImmB19aN1IKUQYiP13FMVP0BLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwjABb/I; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwjABb/I"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso5342651a12.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787551191; x=1788155991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w11pet1aD+xRnvhlpr87q+i2HekPQtfMLvtIw3f/i60=;
        b=YwjABb/IEglOhD7WqzSQxY6fmhe619aRuDwAwwiul0vjXil9yr7IyoYS27dBLOJcR6
         ig4A0cLK19ssZkV21SfxZE8JtUEaN56w0xHOWS8chRV0vEjdv8Xaz043G5q8f8iMesUp
         4FjmS1L/T9XV49tRU5lt93UURRRvHqYbJY8rgbk1apRhun7zlvzi6x2vhBpEdw3pGcwT
         noPHPpb2bVSYFowoDxUV6DsyYi3TgAx1GodlXBzARJaWtcJrMhZTkMgfPoUr/YlF1qBY
         UEu7COA51DBefpXf+lqs4TWA8uJdDzBTcaFRMaFfpyfuJadooBIz36KhfAccHiGTnNKe
         n2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787551191; x=1788155991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w11pet1aD+xRnvhlpr87q+i2HekPQtfMLvtIw3f/i60=;
        b=pY38uFXTY7jYLl0C/UksYPBESq1EWwYibEYPXqgjKrs7DfV2m0Q5uAXgQcy4T/AGiM
         280ZyDyzAKVN3nebwv7kMASYhSFF8wB3qdhwayvBc21u9FgJAXswqxpTbbSXVa5+JbP0
         HlGRzXqwOuS+7bdNUtfE3pnP7G/zo19Nw71QE6Ph3DJBqWiDn2AoiYHETb0qZv2GhlNe
         ZrUE+uvVW1F+smgF4S+YF57Cfn0QWOfFqGpKU2Ymgm5k/yCqzeUQwUoD//d+wS3mF9hH
         U3ihcm0DrYDb/nnTJ2yofxRs3+5IWsLDJVScLlW+QIx5kl2mPf49kv6c0vJzkH0OyaYq
         cRWw==
X-Forwarded-Encrypted: i=1; AHgh+RqikIewoYCv0WZr+cKDKDjXheXhJBlzhowUBO/68CTNb4wLqbOqTuU5tfMTXfusCGW5EOog7HA=@vger.kernel.org
X-Gm-Message-State: AFuF++nLV4oJwJWY7/U9m0kHhwC1BklSWimTlF9NZm76DQNIKAbz2IeN
	aS8fYK26B3lKLS2xejKddujsOZJjY1x7gENozQM6UZGzaxKR05FdUe7n
X-Gm-Gg: AR+sD127YB0fD6D0JQQtFePL1ng71YhoMzjzAMlzaUAZHM/TjtM6qn52xDR2RlXVe51
	hm16XPsCocelccHyG/MTaVPLi5sI0vzG9Awv7lU0F6KEi4JZbcczdN43vJuvCTFbQBR8b/8ikxS
	6mDdDAmdUYO8mx3xh07e28Zc4r9UvqnktOdp10V+/M47jdHe0KwJJ4oJf88RBfFBMpUPUtIRMdA
	iwbC1cO1VmfRfor/RztC2xlxljBlWjLjP/1NXCLffrwTRxohy2p12ORIKbe8ty9YX8SJlYa+FIQ
	zdFAptufPfE6pgSUu5zBrHpLb55XM7YP9xJ8oOJGxjM2uHwmFd0eIYmakg3jdyY1iYYeYl9yss/
	PlgkXzSbthzdSYOedD1E9zBrhCq2hKqyT81aMXeqWHlNfEorTmUhAjJUM4V8r5dthlA5M2WJ5Mi
	TeAID8BvrH7fK4tQNnpWX8ETIhcHRly3JJ/sYq3KAN3dWzBWTTkSourZaVv7DApxpoKyZcYUdtH
	tLhRA+HoyfxXe+xgWwCho4cR39f6YcBN6bmy5zI4na3n58/MSI7yOra2tbgyG+v4CfTvV+rm3/T
	pkoAGlLU+lz9KJMKISzrsiiBWPZyII/mmb9uZITyWH1CkIuI5NFsMhl/MegCE6HUtfQT
X-Received: by 2002:a05:6402:4546:b0:69e:2d56:690a with SMTP id 4fb4d7f45d1cf-6a42f133bb5mr22706126a12.8.1787551190634;
        Sun, 23 Aug 2026 22:59:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b297-8e01-ed33-c55f-13fa-4725.310.pool.telefonica.de. [2a02:3100:b297:8e01:ed33:c55f:13fa:4725])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm7951950a12.29.2026.08.23.22.59.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 22:59:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ARM: mm: LPAE: Change THP helpers to comply with generic MM semantics
Date: Mon, 24 Aug 2026 07:59:38 +0200
Message-Id: <20260824055938.27594-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmd_mkinvalid() clears L_PMD_SECT_VALID from a huge PMD. A PROT_NONE
huge mapping also lacks that bit. On LPAE, pmd_present() therefore
reports both entries as non-present even though they still describe a
huge page.

Generic THP teardown then takes the non-present path and decodes the PMD
as a softleaf entry. zap_huge_pmd() cannot find the folio and leaves the
huge page and its deposited page table behind. An unprivileged process
can leak 2 MiB on each mprotect(PROT_NONE) and munmap cycle.

Reserve an LPAE software bit for an invalidated-but-still-present
section, and make pmd_present() recognize it and L_PMD_SECT_NONE. An
invalidated PMD no longer contains PMD_TYPE_SECT, so make pmd_leaf() use
the resulting present state rather than the bare type bits.

Bit 56 is the only unused bit in LPAE's four-bit software field: the PMD
definitions already use bits 55, 57, and 58 for dirty, PROT_NONE, and
read-only state.

Since pmd_present() no longer indicates hardware accessibility, provide
pmd_access_permitted(), which checks the valid and user bits and the
read-only bit for writes. This keeps GUP-fast from accessing PROT_NONE
and invalidated huge PMDs. Do not retain the transition-only bit in
pmd_modify().

This mirrors arm64 commit b65399f6111b ("arm64/mm: Change THP helpers
to comply with generic MM semantics").

Fixes: 624531886987 ("ARM: 8578/1: mm: ensure pmd_present only checks the valid bit")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing: In an unpatched 1 GiB QEMU guest, 400 cycles reduced MemFree
from 981 MiB to 160 MiB. AnonHugePages remained at 819200 kB after exit,
and drop_caches recovered nothing. MADV_HUGEPAGE was unnecessary with
THP set to always.

The patch passed the 64-cycle reproducer and both CONFIG_GUP_TEST
fast-GUP checks on QEMU and Pi 400. It also passed DEBUG_VM_PGTABLE and
a four-vCPU CONFIG_PREEMPT=y test with 20,000 protection changes.

Full zImage builds passed for LPAE with and without THP and for non-LPAE.
LPAE+THP also built at v7.2-12555-g4352b8aee980.

 arch/arm/include/asm/pgtable-3level.h | 30 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 7b71a3d41..b2ca7408b 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -81,6 +81,7 @@
 
 #define L_PMD_SECT_VALID	(_AT(pmdval_t, 1) << 0)
 #define L_PMD_SECT_DIRTY	(_AT(pmdval_t, 1) << 55)
+#define L_PMD_SECT_PRESENT_INVALID	(_AT(pmdval_t, 1) << 56)
 #define L_PMD_SECT_NONE		(_AT(pmdval_t, 1) << 57)
 #define L_PMD_SECT_RDONLY	(_AT(pteval_t, 1) << 58)
 
@@ -116,9 +117,7 @@
 #define pud_present(pud)	(pud_val(pud))
 #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 						 PMD_TYPE_TABLE)
-#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
-						 PMD_TYPE_SECT)
-#define pmd_leaf(pmd)		pmd_sect(pmd)
+#define pmd_leaf(pmd)		(pmd_present(pmd) && !pmd_table(pmd))
 
 #define pud_clear(pudp)			\
 	do {				\
@@ -177,7 +176,9 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 						: !!(pmd_val(pmd) & (val)))
 #define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
 
-#define pmd_present(pmd)	(pmd_isset((pmd), L_PMD_SECT_VALID))
+#define pmd_present(pmd)	(pmd_isset((pmd), L_PMD_SECT_VALID |	\
+					   L_PMD_SECT_NONE |		\
+					   L_PMD_SECT_PRESENT_INVALID))
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
 #define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
 static inline pte_t pte_mkspecial(pte_t pte)
@@ -189,6 +190,19 @@ static inline pte_t pte_mkspecial(pte_t pte)
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
 
+static inline bool pmd_access_permitted(pmd_t pmd, bool write)
+{
+	pmdval_t mask = L_PMD_SECT_VALID | PMD_SECT_USER;
+	pmdval_t needed = mask;
+
+	if (write)
+		mask |= L_PMD_SECT_RDONLY;
+
+	return (pmd_val(pmd) & mask) == needed;
+}
+
+#define pmd_access_permitted pmd_access_permitted
+
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -213,16 +227,18 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 /* No hardware dirty/accessed bits -- generic_pmdp_establish() fits */
 #define pmdp_establish generic_pmdp_establish
 
-/* represent a notpresent pmd by faulting entry, this is used by pmdp_invalidate */
+/* Create a faulting but software-present PMD for pmdp_invalidate(). */
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
-	return __pmd(pmd_val(pmd) & ~L_PMD_SECT_VALID);
+	return __pmd((pmd_val(pmd) & ~L_PMD_SECT_VALID) |
+		     L_PMD_SECT_PRESENT_INVALID);
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | L_PMD_SECT_RDONLY |
-				L_PMD_SECT_VALID | L_PMD_SECT_NONE;
+				L_PMD_SECT_VALID | L_PMD_SECT_NONE |
+				L_PMD_SECT_PRESENT_INVALID;
 	pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
 	return pmd;
 }
-- 
2.39.5 (Apple Git-154)
