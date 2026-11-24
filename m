Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507582;
	b=Ppa/rZUmk1hfJ0bdbeZBbDemrQs0gC8YW6V5LQ5cjeNbXDAv/6u6Tv2Rob4CtnWUeJDR
	 X/HLN3iM1fcKU6p4vC6DSZGqhtX3qgsuRRCDppqhl+1uMrnr5YJZ7o7pfoeNhq8uMNgL8
	 B23HjSnWE+YnUbe+sxCyqWQR0KPb0O5+SLIyKJgC2uZbMMFpeWqmr+wbXq4yFTiXfGR1u
	 dK+YdvzSCXcphXLimfS457cO3ueHBaA8G7kSGaKwto8vmHZh8oQMlaGOt4qtJizbiJHH6
	 cYvU7B9ImBwF7VQ4rT4k5bNjHTY74pySp7/k2Wpu0E7bEv1LzrID6ARPAzydN1LC1Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507582;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KEf9xsv+Xy0b4bEOzIOgKFEp/lzfcwuiaMzbGAMUi40=;
	b=2WJ7bPYrV7bQ0WM0WJWlIaFvWmfvGVDHx96QUxuNxEzWLqvPzRERQO/Rq9FoTFkY7zF+
	 +HL6UElP0DTN+YCrJPFvFm+k0npJg3Dt/HnzTaNowLDDPfki8KwrBPA3SBI9rbfS1gsDR
	 7jggeiJQzB4bvlGY7q1B1oJEWhpWH7wsjVIOBP+Grm2PTdRpiCLbGqTx8hxEvD1rmNVQA
	 LkDR1kTdgOtBJ9fwkd6WR2INDa5Ahd6WGaK0n3kVp11PR/hXsJnwfQ08Ye0e++glEzSIL
	 AkDhUxhqzlacioGZbkSKkAcYkPTkO/iu9gFcbCiMbzRchThRQyH76YgXnSN8XFtPRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f0VgwLuR;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0C606A321;
	Tue, 24 Nov 2026 08:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f0VgwLuR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795507571; bh=KEf9xsv+Xy0b4bEOzIOgKFEp/lzfcwuiaMzbGAMUi40=;
	h=From:To:Cc:Subject:Date;
	b=f0VgwLuREjP91QgVwycyRmdY6t7wDq24Ayj3sqzvMzw6f8uW9kJUWpAb2LUT7LUMv
	 07mCdReM087o1kskTX58PTJuY92d6NRraTMEmQnV4tq7Tq/7Pw6U60TjYLqZIh1xHg
	 LvaNeVQDw2v5nJEcdOyfeSDtqyR3wO29s/g0rhQI=
Received: from DESKTOP-6LNKCJL.localdomain ([114.245.37.219])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 17894CED; Tue, 24 Nov 2026 16:05:56 +0800
X-QQ-mid: xmsmtpt1795507556tkbp9b8x1
Message-ID: <tencent_9D774595101D7C0F5A46CBCE69817B8A6E06@qq.com>
X-QQ-XMAILINFO: NWEwCzsFJJ7Kuv0IbmjuX6r/80AqKeLaq8kNUZXU8vUuph4VpGYY2jaqG64iWi
	 CdJLf6lblftyp+H3puR2kfj88fF2ZwRDFm6o44H5tZeEx21hcagCnAHmlf8qY2DnioEuFwn/fy0n
	 1F0vl+kW/eP9eHMMdOR32E9R9m4DtdoKUhmhd2CMPOZzBo6grM3YGtfSpsoIpaz5ns6j5PrjoM5b
	 dskr/EgLBzSzzxck1OoAlmCNvD9ohcKC1Q43eqBr+zBt0uK3uIybEcRhXfcYzUFZF3fnJPQL8mgn
	 X9MY6GL6kymJV5/iqz+u4cazbRqTbjTpFUjqkN2l9+icI+wxLAAB6DWb4Usk1JnV4bmYnQ+zHLeZ
	 60xGORfpt/fjn4RKrUYeJhLN+SE8AxZ3DDJuo2qFd+5pwTn0tlN/7r+g8R9WAchv8lXeCcnK6EhV
	 oh3WWxLJMIk30RWFp2hVrfzep/TiBLCRgiAuzYwBPBGAYiyEzl8NPxUWWkQEQgm8+GuEho2iVFJB
	 V12/ElIBTQlwBILuEZMIxEgKsOp0Z/zv6vkxqFtw836iq+6oAbEY+NCAjMWGjuDAEjRFpJJyKbMC
	 iE0fIN8361bIQEzol30+tGdwe/z96AYmUT4ibQOZzcJSiaXJrPmQNC6or8iBbfcLlx9p7wgUDMZK
	 jwNwK0CinpPfhFrx7zzTnrCWxkWxLo0Q4agkT5fryyJZJnRc+htzlEeEU2gLezvarL6yDcQcWY2n
	 /rsA3FQyDQ1y29sbHMtEa76hr1o1fF+UtrZjgPoFmB2cJCxoI/PTfdUPCCtKifUB3whLu5mPaxED
	 HHDThL1+hr5Mp5o071jVZoYCZP3fey+PdP7n0o/JJZzvQp+Xnnhv8ESrd3YKrw8182ugIXyOMSiB
	 O9bXHHyrkOBdf0XIe9TEm9S5QD091MdYxCd2uy/n+ZLeEijXDVVDpj3PNPqiPWIUPyK49CvPW+AB
	 pwxjalAIPtFG0mTo4Wd0Q/Aj0xE9li40W7VTscIjX6brpAFlTw0dBXXqTDDwQboUjR6+roxaFoxO
	 h8BdUvdG0sg+I9fDZhPkUV3ufIiNDoREOqa18tMjQIpajXE9TX
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jingyi Sun <1045704958@qq.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	Jingyi Sun <1045704958@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: mm: make pud_leaf() only care about the leaf bits
Date: Tue, 24 Nov 2026 16:05:50 +0800
X-OQ-MSGID: <20261124080550.616-1-1045704958@qq.com>
X-Mailer: git-send-email 2.43.0
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

Since commit c3cc2a4a3a23 ("riscv: Add support for PUD THP"), riscv can
map huge PUDs, e.g. 1G pfnmaps of VFIO BARs. mprotect(PROT_NONE) on such
a mapping goes through change_huge_pud(), which writes back
pud_modify(pud, PAGE_NONE). PAGE_NONE does not have _PAGE_PRESENT, and
pud_leaf() requires pud_present(), so afterwards pud_leaf() and
pud_trans_huge() return false for an entry that still maps 1G.

Core mm then treats the leaf entry as a pointer to a PMD table:

- munmap(): zap_pud_range() skips zap_huge_pud(), and
  pud_none_or_clear_bad() reports "bad pud 00000001000001e2." and clears
  the entry.

- mprotect() back to PROT_READ|PROT_WRITE: change_pud_range() calls
  change_pmd_range(), which uses the physical address of the 1G mapping
  as a PMD table. For a BAR that address is not in the linear map, so
  the kernel takes a paging fault at 0xff60000380000000 (the linear map
  alias of the BAR) and oopses:

    epc : change_protection+0x498/0xf74
     ra : change_protection+0x2e4/0xf74
    [<ffffffff80263f4e>] change_protection+0x498/0xf74
    [<ffffffff80264c18>] mprotect_fixup+0x1ee/0x32c
    [<ffffffff80264f96>] __riscv_sys_mprotect+0x240/0x344

pmd_present() already treats _PAGE_PROT_NONE as present, so PMD-sized
mappings are fine. x86 had the same problem with PUDs and fixed it in
commit 144bb0aee33a ("mm/x86: make pud_leaf() only care about PSE bit"):
PROT_NONE entries must still be reported as leaves. Do the same for
riscv and only check _PAGE_LEAF in pud_leaf(). pud_present() is left
alone, so pud_access_permitted() and GUP-fast still reject PROT_NONE
PUDs.

Reproduced in QEMU (riscv64 virt, Sv57) on v7.3-rc2 and on mainline as
of 2026-11-19 (v7.4-rc3+), with an ivshmem-plain device (2G BAR) bound
to vfio-pci in no-IOMMU mode. The reproducer mmaps the first 1G of BAR2
at a 1G-aligned address and touches it; vfio-pci dynamic debug shows
vfio_pci_mmap_huge_fault() with order 18 returning VM_FAULT_NOPAGE.
Then:

- mprotect(PROT_NONE) + munmap(): "bad pud" in 3/3 runs, 0/3 with this
  patch;
- mprotect(PROT_NONE) + mprotect(PROT_READ|PROT_WRITE) + access: oops in
  3/3 runs, 0/3 with this patch (the data is read back and written
  normally);
- mprotect(PROT_READ) + munmap(): no "bad pud" (control).

x86_64 with the same reproducer shows neither problem.

The issue was found with a research static analyzer for
cross-architecture inconsistencies and confirmed with the QEMU
reproducer described above.

Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
Cc: stable@vger.kernel.org
Signed-off-by: Jingyi Sun <1045704958@qq.com>
---
Notes:

- The tested mainline kernels (2026-11-19) had DEBUG_VM,
  DEBUG_VM_PGTABLE and PAGE_TABLE_CHECK(_ENFORCED) enabled. With this
  patch the debug_vm_pgtable self-test and page_table_check stay quiet.

- With this patch, the PROT_NONE -> PROT_READ|PROT_WRITE case reaches
  change_huge_pud() -> pudp_invalidate() on a PROT_NONE PUD, and
  VM_WARN_ON_ONCE(!pud_present(*pudp)) fires once:

    WARNING: arch/riscv/mm/pgtable.c:160 at pudp_invalidate+0x42/0x64

  x86_64 (same mainline, DEBUG_VM) shows the same warning with the same
  reproducer:

    WARNING: arch/x86/mm/pgtable.c:527 at pudp_invalidate+0xb6/0x100

  so this looks like a separate issue: pmdp_invalidate() has the same
  check, but pmd_present() is true for PROT_NONE on both architectures,
  while pud_present() is not. I left it alone here; I am not sure
  whether the check or pud_present() should change.

- The reproducer (a static /init for QEMU) is available on request.

 arch/riscv/include/asm/pgtable-64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index eb7708e35cf9..1f45ebce8a75 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -226,7 +226,7 @@ static inline int pud_bad(pud_t pud)
 #define pud_leaf	pud_leaf
 static inline bool pud_leaf(pud_t pud)
 {
-	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
+	return pud_val(pud) & _PAGE_LEAF;
 }
 
 static inline int pud_user(pud_t pud)

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.43.0

