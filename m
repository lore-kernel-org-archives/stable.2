Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452910;
	b=MrqqqupkFkh6/Oa0+/xdiwcndhovbdPJeOWj1Lc7y6JuGjbPduLVQAH1js3YVR/VJei5
	 2br6Jnuy72zHGeTlGoMpvZHcEUxd87ceL+IvcfMAExvPHuaNKk3fCYeSOInGGcrea4QAh
	 UUtguKseesLbI8Gp+WlzQ8wmxEuMG1dVpnT2KesL0BJ2T4b8lYbLuesNM47ClM3GtJ9Ue
	 sAlDNiI92z2lFJLho4vcNuz5vIkcGCHLBWrpffec7Dm/L5DgTIqBe7QmO8IRqnOW24sUj
	 RQnOlcpCO6Jd8QXrFNOmZOMPLkNVVXRGnUHXML/ec4JZjDwao1Az/SxvpV4SFbDd0IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452910;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=PhhMp9/TOiCG7JAer/L+AFYkRo3zi5cH4WX46oYsUeo=;
	b=Y7U3B+KzbzsYzzcWY583R5xVtoJ5CJXYQmhLn4Z3/rMRBGv6dt0NQy2sQHP2yHuoKivl
	 GT9z0K8hn3/Itqv7itVVdqCMYfXn2KBzuh75AmI5xiBbVbvWBwVQ1VBWt2YSwVi8uQWwb
	 WEZIRwoVBnKDQXVNc51P/mTbQVYfcZXccnUkZstAalfmTOFPoPbiEWECC1ad80LXIaLWI
	 RDgJJk9xbsrSMsEGXbn/0sFA5EbE4T5e0MD9vo0cwIhCZZCRbUjYgs3bASYaEnqLtIiiS
	 jxe4eIeheWkvY3hR5dG1uLL0aQRpJUyaTsAimJ7LUrm1zpPXqO0G2jgNXS+C1HXSX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkBgRzIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9F606A31A;
	Sat, 31 Oct 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkBgRzIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618321F00919;
	Sat, 31 Oct 2026 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793452909;
	bh=PhhMp9/TOiCG7JAer/L+AFYkRo3zi5cH4WX46oYsUeo=;
	h=From:Date:Subject:To:Cc;
	b=ZkBgRzIEkHeFIEu1mBrLS8uCcW/eiV77hYpKgOQEqGa8JuxCDDpwtONKzFMKLIZWQ
	 ZDcGHuzAN18w/ICIqeC2OI28lVlMy4TtywZSnMdjOhQjCSlDV2bVbLYGQqL/46AX5R
	 VWvaOxyloIrL5IlyNls7EHZpGbrkAGiEEFWNPaS62hShlFfYl6JRVKGFwkqHOSLtWK
	 f+cIjTk02/1X1LxYbiWzezfDLyZuBPbm58lsWZawqPEd9a+DGXu0OlXbHPcBp2J4VT
	 dgmi+KrBHw9uBoO8Q5mZtbT4K66WJceGDICYAHeM2Y3Otx7VA0evWg5rSpfLHeNClw
	 IFqLnhGEk65FQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 31 Oct 2026 15:21:46 +0200
Subject: [PATCH] LoongArch: restore KFENCE pages through DMW on resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LMWmILqU29inEBdIAxCmamGpOmd
 xd0+X7e+xsIMqHAuduA8U1CJVcYDh34ZHNERUtl0L0+Db2eVKAPirqXkqNln1RYzDSOwZh5mKF
 WT8afUqPL9c/ycjf0a7tphrOCyrHNPrWpMEXKx4eVFRn2/Qv0tSeakwAAAA==
X-Change-ID: 20261027-fixes-loongarch-fd3755f33919
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.1-dev

With KFENCE enabled, resume from hibernation triggers KFENCE reports while
swsusp_asm_resume() copies the image pages, for example:

  BUG: KFENCE: use-after-free write in swsusp_asm_resume+0x20/0x94

  Use-after-free write at 0x00000000a57ee925 (in kfence-#254):
   swsusp_asm_resume+0x20/0x94
   hibernation_restore+0x128/0x1a0
   load_image_and_restore+0x6c/0xc8
   software_resume+0x240/0x260
   do_one_initcall+0x68/0x200
   kernel_init_freeable+0x26c/0x304
   kernel_init+0x20/0x134
   ret_from_kernel_thread+0x24/0x1d0
   ret_from_kernel_thread_asm+0xc/0x98

During resume from hibernation, the image pages that occupy physical pages
used by the restore kernel are first loaded into free pages and then, as
the very last step, swsusp_asm_resume() copies them to their final location
pointed to by pbe->orig_address, which the hibernation core sets to
page_address() of the page in the restore kernel.

The early KFENCE pool is allocated from memblock and normally occupies the
same physical pages in the restore kernel and in the image kernel, so these
pages are usually copied by swsusp_asm_resume().

The KFENCE pool is remapped into the KFENCE area above vm_map_base and
set_page_address() adjusts page->virtual so that page_address() returns
the page-table mapped alias rather than the DMW address of the pool pages.

Hence, pbe->orig_address of KFENCE pages points to that alias and
swsusp_asm_resume() writes them through the page tables. But:

* the copy loop overwrites the kernel page tables, so a TLB refill for the
  KFENCE alias may use a partially restored page table
* the KFENCE pool pages that are protected in the restore kernel fault in
  the middle of the copy

Convert pbe->orig_address to DMW addresses before starting the copy.

Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Reproduced with hibernation in QEMU, the KFENCE reports are gone with
this patch.
---
 arch/loongarch/power/hibernate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
index 817270410ef98..ff571ab4e8df9 100644
--- a/arch/loongarch/power/hibernate.c
+++ b/arch/loongarch/power/hibernate.c
@@ -59,6 +59,18 @@ extern int swsusp_asm_resume(void);
 
 int swsusp_arch_resume(void)
 {
+	struct pbe *pbe;
+
+	/*
+	 * page_address() of KFENCE pages is mapped by page tables that are
+	 * overwritten during restore and may be protected by KFENCE, copy
+	 * through DMW instead.
+	 */
+	if (IS_ENABLED(CONFIG_KFENCE)) {
+		for (pbe = restore_pblist; pbe; pbe = pbe->next)
+			pbe->orig_address = __va(virt_to_phys(pbe->orig_address));
+	}
+
 	/* Avoid TLB mismatch during and after kernel resume */
 	local_flush_tlb_all();
 	return swsusp_asm_resume();

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261027-fixes-loongarch-fd3755f33919

--
Sincerely yours,
Mike.

