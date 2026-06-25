Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B156355F2A;
	Thu, 25 Jun 2026 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355292; cv=none; b=EWEfaxumMkx9lZ2zv7I1hRInWE/EM3Zg//CfF/gXRuR8UylENoUeUXTvBUjNpWDdMJvcfD2qs9ODILZcoyriUwtq2/7UuPWzVONo/zaK9SaNBvaFRA2KIldzePBdECo0iLXwkobJMWyQPJ99x2L45WL/w1+h0+zwk4qeabXmBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355292; c=relaxed/simple;
	bh=HmM/nvptwnuvFXCkHu8CqOdZVHrb04Hz8BG2nwCFCFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGkRBJJEsXtSrtowQcseocw7lTUcW1vm7XVap7qGViMhNxL3WbWRdDQ8nqhvSHuG4HsrFz4Bofy5JMKF0vQhNQsBILyMymtuak5CK2Z5WQOPRNPyw4G3ieB1L8l8LvGJM8qi5whHw0JvC6CNBd+uIap+VzBDGnF021FtYjR+u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.135.67])
	by gateway (Coremail) with SMTP id _____8BxNehXlTxqeasXAA--.55118S3;
	Thu, 25 Jun 2026 10:41:27 +0800 (CST)
Received: from localhost.localdomain.org (unknown [10.180.135.67])
	by front1 (Coremail) with SMTP id qMiowJAxHMJPlTxqtEuyAA--.10446S2;
	Thu, 25 Jun 2026 10:41:20 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Helge Deller <deller@gmx.de>,
	WangYuli <wangyuli@aosc.io>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Alistair Popple <apopple@nvidia.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix missing dirty page tracking with HW PTW for both pte and pmd
Date: Thu, 25 Jun 2026 10:40:43 +0800
Message-Id: <20260625024043.2960754-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMJPlTxqtEuyAA--.10446S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAgEJB2o7cbAYigAAsP
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWDZF18Gw47GF13ZrWUGFX_yoW5Cr45pF
	Z7GFyvvF48KF1fGayDurW3Jryqkws7JF4UGFs8Cw1DW3s8W34DXr1Ikrn5XFWrAa9Yvay8
	Zr4rtrykWFW7ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

When hardware page table walk (PTW) is enabled on LoongArch, the CPU
may set _PAGE_DIRTY directly in the page table entry during a write
TLB miss, without going through the software TLB store handler. The
software TLB store handler (tlbex.S:254) sets both _PAGE_DIRTY and
_PAGE_MODIFIED together:

    ori t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)

But hardware PTW only sets _PAGE_DIRTY, the software-only bit
_PAGE_MODIFIED is left unchanged. This creates a window where a PTE
has _PAGE_DIRTY set (hardware knows the page is dirty) but
_PAGE_MODIFIED clear (software is unaware).

When fork() triggers copy-on-write, __copy_present_ptes() calls
pte_wrprotect(), which unconditionally clears both _PAGE_WRITE and
_PAGE_DIRTY:

    pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_DIRTY);

Since _PAGE_MODIFIED was never set, the dirtiness information is
completely lost. Subsequently, when memory pressure triggers page
reclaim, page_mkclean() / try_to_unmap() sees the page as clean
(pte_dirty() returns false) and the page may be freed without
writeback, causing data corruption.

Fix this by propagating _PAGE_DIRTY to _PAGE_MODIFIED in both
pte_wrprotect() and pmd_wrprotect() before clearing writability bits:

    if (pte_val(pte) & _PAGE_DIRTY)
        pte_val(pte) |= _PAGE_MODIFIED;

The pmd_wrprotect() fix handles the CONFIG_TRANSPARENT_HUGEPAGE case,
where pmd entries need the same treatment.

This ensures the software dirty tracking bit (checked by pte_dirty(),
which reads _PAGE_DIRTY | _PAGE_MODIFIED) is preserved across fork
COW write-protection.

The issue was found by LTP madvise09 test case, which exercises
page reclaim after madvise(MADV_FREE)/write/fork on private anonymous
mappings.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Cc: stable@vger.kernel.org
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Co-developed-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 arch/loongarch/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 2a0b63ae421f..223528c04d73 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -429,6 +429,8 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+	if (pte_val(pte) & _PAGE_DIRTY)
+		pte_val(pte) |= _PAGE_MODIFIED;
 	pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_DIRTY);
 	return pte;
 }
@@ -535,6 +537,8 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
+	if (pmd_val(pmd) & _PAGE_DIRTY)
+		pmd_val(pmd) |= _PAGE_MODIFIED;
 	pmd_val(pmd) &= ~(_PAGE_WRITE | _PAGE_DIRTY);
 	return pmd;
 }
-- 
2.33.0

