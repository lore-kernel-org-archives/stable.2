Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794167;
	b=RYhMeVwFgyqQWA8QDj8G39ekXejPkI80rQMnyNzU2S6w65O2er2v8enQA4AYzX2BK87L
	 i4Y2G9FnaGV4xV/rWz3KD8C/85n/fdphdVL2w9v7l8yHwstw/ugYML2/3yCBIxsl8mx13
	 fTykdFG3WEvEskz+WUgNLUFbVmJSIHJdrl44x/i/1DkNG/P/b4aurT0YDofWyt7h6Sa5h
	 98w+hA5eYcQMc15Vpv3vG0YjLIDoCPqzlvW6mz4tWqYwWQAfmvVvCjXRrZpJLTI5RX6A6
	 Fpdq5BWDrcM2iz0E5VEurgKP0Ou6qYUY9UCCjcL3See2fAv0V9GDsrbBxFFeBz+ue2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794167;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=ecZdHBCCTAPsfnJCfwhM/cgtRShTHrDKKf57XOoxtbY=;
	b=gZO0v0E2KS2yn+oKfokfe0bZyhhCFC7eWoZkPPwU1CdX8huZ33VD7ReGBYbSVWtjjFNK
	 ux9EV7Erhmufjc1Zoz4KRu36I/VqjWMHI+S2NGVME5BMROwYoYJLlIiLIQg5S/Z1BDX02
	 3Oab7MDstj8Ii46mr3zQgtQPIYLHcrPlOZ202l1eehvrGWMjw4HEvOzVvJeNPtNxoZ4w1
	 Rs+mccidO4y0W5E70p6pvvpTFXD3eFCos3UC8f0VnQt1qlvNm0OFjryyROdL1+uHyC8iy
	 gTRMLBExTHkZE/Ors3MjuZtsqEM/WN816tBjTI4PedNjZ2LkvHheEBegXoRlhh+N/FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Ruw3WlOL;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b="k0/uIzxQ";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC6606A31C;
	Fri, 27 Nov 2026 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Ruw3WlOL;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=k0/uIzxQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2054D1FE20;
	Fri, 27 Nov 2026 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795794165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ecZdHBCCTAPsfnJCfwhM/cgtRShTHrDKKf57XOoxtbY=;
	b=Ruw3WlOLeTi4R9iaT882GnTIBzAajzwk25GoPa3nGOlB5QKultAD7DvKGgYUSyFIDRiLCY
	iuunlhV3WJJasAVjGvMMavpkp797nxEm+kXP85mDwSwz5cq+ACNz8uhWjDE0DUcXf+uDdT
	ij2M8gaZ4AvpsGVH5IPuJ+uPOZvf9zU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795794164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ecZdHBCCTAPsfnJCfwhM/cgtRShTHrDKKf57XOoxtbY=;
	b=k0/uIzxQe8NrlxUye48KCMH8JhPUsN8HG+/7+ZDeD3b0CgGJVWlnPEUie9CKanDgpIzI3w
	LbSYn0jniesNcQNGVYCijEE90AMsIXYe0qcNb5+r0Yg9VcTQkOBKhFRb0oK2TI57GSsst8
	4Fda9sZdEdBY+VXXwFN3sy2BayBDQAI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05ECA134E8;
	Fri, 27 Nov 2026 15:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jFUGMvKkCWtvIQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 27 Nov 2026 15:42:42 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: mhocko@suse.com,
	kas@kernel.org,
	naveen@kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/devmem: Drop /dev/mem access for confidential guests
Date: Fri, 27 Nov 2026 17:42:12 +0200
Message-ID: <20261127154211.21360-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.56.0
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
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,arndb.de:email,arm.com:email,intel.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

From: Dan Williams <dan.j.williams@intel.com>

Nikolay reports that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in a "crash" / terminated VM
(unhandled SEPT violation). See report [1] for details.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
unencrypted mapping where the kernel had established an encrypted
mapping previously. The CPU enforces mapping consistency with a fault
upon detecting a mismatch. A similar situation arises with devmem access
to "unaccepted" confidential memory. In summary, it is fraught to allow
uncoordinated userspace mapping of confidential memory.

While there is an existing mitigation to simulate and redirect access to
the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
area, and returns a zeroed buffer.  However, it turns out the kernel
fails to enforce the same via mmap(2), and a direct mapping is
established. This is a hole, and unfortunately userspace has learned to
exploit it [2].

This means the kernel either needs: a mechanism to ensure consistent
plus accepted "encrypted" mappings of this /dev/mem mmap() hole, close
the hole by mapping the zero page in the mmap(2) path, block only BIOS
data access and let typical STRICT_DEVMEM protect the rest, or disable
/dev/mem altogether.

The simplest option for now is to disallow access to /dev/mem via devmem_is_allowed.
Require confidential guest userspace to jettison legacy dependencies on
/dev/mem similar to how other legacy mechanisms are jettisoned for
confidential operation. Recall that modern methods for BIOS data access are
available like /sys/firmware/dmi/tables.

Now, this begs the question what to do with PCI sysfs which allows
userspace mappings of confidential MMIO with similar mapping consistency
and acceptance expectations? Here, the existing mitigation of
IO_STRICT_DEVMEM is likely sufficient. The kernel is expected to use
request_mem_region() when toggling the state of MMIO. With
IO_STRICT_DEVMEM that enforces kernel-exclusive access until
release_mem_region(), i.e. mapping conflicts are prevented.

Cc: x86@kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

V2:
 * Move the check to x86's devmem_is_allowed implementation to avoid touching
 generic code

 * Very slightly reword the 1st sentence of the 5th paragraph to not mention "lockdown",

 arch/x86/Kconfig   |  4 ++++
 arch/x86/mm/init.c | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3159852fd6b3..1490e0019c71 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -901,6 +901,8 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	depends on EFI_STUB
 	depends on PARAVIRT
+	select STRICT_DEVMEM
+	select IO_STRICT_DEVMEM
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
@@ -1490,6 +1492,8 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	depends on EFI_STUB
+	select STRICT_DEVMEM
+	select IO_STRICT_DEVMEM
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 079f8c7e9e3c..8768508f3c6d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
 #include <linux/execmem.h>
+#include <linux/cc_platform.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
@@ -866,6 +867,15 @@ void __init poking_init(void)
  */
 int devmem_is_allowed(unsigned long pagenr)
 {
+	/*
+	 * Enforce encrypted mapping consistency and avoid unaccepted
+	 * memory conflicts, "lockdown" /dev/mem for confidential
+	 * guests.
+	 */
+	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return 0;
+
 	if (region_intersects(PFN_PHYS(pagenr), PAGE_SIZE,
 				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
 			!= REGION_DISJOINT) {
--
2.56.0

