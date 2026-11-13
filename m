Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562714;
	b=aXoDrqRT9xGU2cC237yM8Wklz4uAJkfokUOYHVuSbOYBfdfjTRV/ZdJskOlWRKovVoRe
	 Lq1MbueWmhsCNfV6kGMB2skGV/oYGMJjkemy8SkrQtMw/y9/CIRtzZm7nWb10RFxxWe/H
	 +L3lngc1L5Ixc+4MfIuaEEQtyqzf78AgqtUCUel13xgRE+396JAOkj2zvnQYfz8M3A3VR
	 PWP8k6hHhNZbgLHB10/0LeikJEIqWATrHBkZBQeimCpXU0xrhQPFDC6voS3O5UetATcbh
	 BqLl6hF2KK+cS3pQiGRbjIOtr4w/ryVFXBrze0oNiUm/HAoZTmk5mAL2rXCRnuzXolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562714;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=8Pc1VZfIDVGJzZNtwuo8QG46Hbc/13m3DgBGkiUdd+o=;
	b=ngNnkuWzP+fVmJA9dZVzJ0Qrp19C/0WtELAvUfR2GngU59w9hTtCxaM2O+hUC3fu/vDG
	 MYucPeXAF9bIoAx+qtOxKIstrp+m/FF3B+p2nbA71ZucWnbMUAOBloh6nacfbzHiD9NFy
	 dpvEvgGnjVrnumhxPHEqUopJYv6+4pPnsTo0N2dsMy4HIoTtlVPesCznZW+65yuHyiuNU
	 P0UrcaDTW7bhdBItOCRN4zi8sHksoqf44QIeBA/iL4OuqOH+SKOVlCfPh3ZtxESM2v0U8
	 lReck9Ra8H8oRha7w+OT+M3zoG+KfSkBWUsRxZH9+jXEkODG/GuSHzVX/PpUi3SQEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UpCRHb2K;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3227606A33D;
	Fri, 13 Nov 2026 09:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3227606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UpCRHb2K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Pc1VZfIDVGJzZNtwuo8QG46Hbc/13m3DgBGkiUdd+o=; b=UpCRHb2KbmBJPwtI+DbP0LaL8d
	sOk0q8WFr88S3iAMSHj2p/NnbWVzQGiNdZN3nNdO1zLyJsTHzDT2AYpDsszvlBsPXovwNFHmP0hr1
	SY9lV829yFxFIN3zvj63ln8CFFNj2wJUNMYIHBmKmY/JsW4XoVGlDKbDaDwxxN5mWJ+s4cUXlOuR/
	42UfaRA1qiSu2ICNxybe2yLc35tfTycNpZWbHnjQ/jcxlqy6tYUcS/Bi6fkLYSwXtlLGPpV1jMI8t
	xnhOZeXq4yQ0FVHQXpu6b4xvxJ6oAklL5bw8J+RqC+cFo9eyWVg+5AE204arB4mOGXs0IEiF0Nobe
	Yc0NfHCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRnjp-00Eeb5-2V;
	Fri, 13 Nov 2026 09:38:30 +0000
Date: Fri, 13 Nov 2026 01:38:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
Message-ID: <avbagwxWrmFrjrtV@gmail.com>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
X-Debian-User: leitao

On Thu, Nov 12, 2026 at 05:37:09PM +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel, and that memory
> may well have uncorrectable errors. That is after all what the first
> kernel often died of. Every architecture that maps a page of the old
> kernel and copies it out does so with copy_to_iter(), and a machine
> check in that copy takes the capture kernel down.
> 
> On x86 a machine check in the kernel is only recovered from if the
> instruction that took it has a machine check safe exception table entry
> or copies from userspace (cf. error_context()). The copy of an old page
> is neither. Its source is kernel memory, whether it goes to the buffer
> of a read() or, since commit 4a22fd20379c ("vmcore: convert
> __read_vmcore to use an iov_iter"), into a kernel page for splice(),
> sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
> into a poisoned page panics the capture kernel, and so do vmcore's own
> reads of the ELF headers and notes. Breno sees the result on a fleet:
> the first kernel dies of a machine check and the capture kernel produces
> no usable vmcore at all (cf. [1]).
> 
> On book3s64 a machine check in the kernel is recovered from if the
> instruction that took it has an exception table entry (cf.
> mce_common_process_ue()). The user copy has them, so a read() comes up
> short there and read_from_oldmem() returns -EFAULT. The copies into
> kernel pages have none and panic the same way. Other powerpc platforms
> don't recover from a machine check in such a copy at all.
> 
> Copy with _copy_mc_to_iter() instead. x86_64 and PPC64 select
> ARCH_HAS_COPY_MC, and on x86_64 and book3s64 the machine check safe copy
> turns the machine check into a short copy, which read_from_oldmem()
> turns into -EFAULT like any other short copy. On x86 that holds for the
> fragile and the enhanced fast string variant, a CPU with neither gets
> the plain copy it has today. Everywhere else _copy_mc_to_iter() is
> _copy_to_iter(). Put the call into a helper, copy_oldmem_to_iter(), so
> that the copy of a page of the old kernel lives in one place and an
> architecture that gains a machine check safe copy later gets this for
> free. The helper does the same check_copy_size() as copy_to_iter(), so
> hardened usercopy keeps checking the copy.
> 
> With a v7.4-rc1 capture kernel reading /proc/vmcore and a machine check
> injected into the copy of an old page the capture kernel is gone. A
> machine check panic prints no trace of its own, this one comes from
> panic_sys_info=all_bt:
> 
> [    0.580568] mce: [Hardware Error]: CPU 0: Machine Check Exception: 7 Bank 1: bd80000000000134
> [    0.580574] mce: [Hardware Error]: RIP 10:<ffffffff81909b11> {_copy_to_iter+0x81/0x850}
> [    0.580584] mce: [Hardware Error]: TSC 202f2117f ADDR 10000000 MISC 8c
> [    0.580587] mce: [Hardware Error]: PROCESSOR 2:aa0f02 TIME 1794493617 SOCKET 0 APIC 0 microcode aa0021c
> [    0.580589] mce: [Hardware Error]: Machine check: Uncorrected unrecoverable error in kernel context
> [    0.580591] Kernel panic - not syncing: Fatal local machine check
> [    0.582587] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.4.0-rc1-g6628e7d4c6b2 #1 PREEMPT(lazy)
> [    0.583101] Call Trace:
> [    0.583198]  <#MC>
> [    0.583279]  dump_stack_lvl+0x4d/0x70
> [    0.583419]  nmi_cpu_backtrace.cold+0x18/0x6e
> [    0.583584]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
> [    0.583772]  nmi_trigger_cpumask_backtrace+0xba/0xf0
> [    0.583955]  sys_info+0x83/0xb0
> [    0.584075]  vpanic+0x1b4/0x303
> [    0.584197]  panic+0x66/0x70
> [    0.584488]  mce_panic+0x19e/0x290
> [    0.584799]  do_machine_check+0x627/0x9a0
> [    0.584953]  ? _copy_to_iter+0x81/0x850
> [    0.585099]  exc_machine_check+0x68/0xb0
> [    0.585246]  asm_exc_machine_check+0x1e/0x40
> [    0.587747]  </#MC>
> [    0.587831]  <TASK>
> [    0.588092]  ? iomem_map_sanity_check+0x98/0xb0
> [    0.588430]  ? __ioremap_caller.isra.0+0x1a9/0x300
> [    0.588604]  ? __copy_oldmem_page+0x3d/0xb0
> [    0.588928]  __copy_oldmem_page+0x5e/0xb0
> [    0.589079]  read_from_oldmem.part.0+0xe3/0x140
> [    0.589247]  read_vmcore+0x137/0x280
> [    0.589381]  proc_reg_read_iter+0x49/0x90
> [    0.589533]  vfs_read+0x348/0x490
> [    0.589666]  ksys_read+0x76/0x100
> [    0.589792]  do_syscall_64+0xde/0x4b0
> [    0.590103]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> With this patch the same injection ends the read() with -EFAULT, the
> capture kernel logs the machine check and keeps running.
> 
> [1]: https://lore.kernel.org/all/avRXzzCSzT9Qj2FC@gmail.com/
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Breno Leitao <leitao@debian.org>
> Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
