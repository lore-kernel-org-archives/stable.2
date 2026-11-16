Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815990;
	b=ofvLKS5Q3utssyXzNplNuCt1khBLg8ITDR8o6AfQ3CNvkzXr03ToZKsZ84heJ1D7qulN
	 AXsCH4hNoX/cpNAe7H34Qh2X+ZCO+8ELV5TBZqUepgY9rDjvtSrtB+VeMXILN1oBx20NI
	 UW4r0PVm8rVY/6X2ifunfaxIQvc2aziC72MeJVw6rPXkXT9zJZpwoBya4zE08O6Y0y9M0
	 VfBuC3jgpvoBovOVEg5EQfLvCJNLYS5a5VMpTbOtSTyztdhH1Y+40ZeEDfce3EhmPoLDs
	 ZPhhXp5huE0pZV5XXdLZHBK2xMoAm+Y2w6LgePGq2fQpZaHhmgoiahYAl5A608QynnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
	b=YFH+JN4Bybx0OfEm+u7Uknm35iT9u96oQD1E+utdnsc/y/PeiuA/LjkoPZhepzhW8z1N
	 5304ZR+7cASk7rVgAoWQnj9Bdim80wIe4hlw4yUxA5uupEXBCsOdUZaKIaTqQwjkBWgBG
	 8liFfVhBsv4+ZPbJYTnI7CcqIcB3TPD+w23EpMO3+2jEz0EGx0A88UJ/IjPd2zpltrcba
	 dOSAKDwypETnRnUdzgZFwodIiK83l+uX+18Nth7qGlJHLB6C8pHaUq9xUN2jtKAGx7XHU
	 N8/YMt9cyN6+FJcxzgQhg4i1OU8BJcXIP6RD2768I6wt6f2/1qx6S1km5aRvk2EFGtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O1BXF7ki;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD8606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41FD8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O1BXF7ki
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so3296511f8f.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815987; x=1795420787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
        b=O1BXF7kitU2oRSc1LTo+wW4pDoWUGl2PNfV6Mrx6Mvp0/wij7mnUpERFldGZUqkIKs
         XZw/mtfFkj/UusVH9UrBTKcJVRdKx157srIuj7SKjCzseY8A/sgQ6OmnwahspQTTMdTb
         ByYOOEcfk1PuecIY/16A6lAoNoMzQHrf6zdncTXX7aDRK9LszvHpzh7ZPEH0Mx6sQJmq
         xrh7MXGpzyM4o4TzkERIrB1zJfr9k2i/s6K+UbTefEt1DHDqv/Xkm9Buwd9MUFTJidcV
         xXqa8U5JudzPl6G50YjbGyGAURqJrnYr87IThG271yWvR/pRqmIPWQef8YP9COtt8oSx
         doJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815987; x=1795420787;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
        b=IsCrocAzHY8utoqvq104C/Vs7kIVUtzJV5IALyQtNPyzGemk3YvXXua85qYrpG7J/S
         YjJM0gsMJnA0MwWdRQNDKtV7wUdo794cH3FC7aAsfV8GSOxyznVzykk5uoAWFq5v6WdS
         4sEtpg+U2VsyFhqxBllivs7+vg6MvMkasb200ICG5nbIBcPvmUbWgMVX3HjHHtZhYqWd
         ChHqJUnaK95O3UtoRsbxkpQOUKeG2vsj0TdmKlOlODWyP1OSrT2mGjdMPajz8qisNOGU
         5+vvjGuJCvwsbOaPkzyd+7mjlIUIVq3vZtYnVlSQsEYlC6ppEuxJHELyh2keACOHTUgt
         NXqA==
X-Forwarded-Encrypted: i=1; AL+hErHIO4rwXDeDhOAyArl/AQoBmBzGCdXsAFw4JyyiL6gV3rfDRQ9QLihBwhrkx/kx4s4urZqL2eo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YISfC+VvF7BHuAemjRWd6oquAUlxRdXcsFv2z/Oy6N//7lJNC
	s5gau+dopMaNEJTpza1nDbZTGNkunADlIa6sIsZS6ECMDlU3IbbKcwmk1NpJSybKVes/
X-Gm-Gg: AYBFou0n3uv1hYKJhxBr1WaoijaoRR8YToSRMi7cLoMmETSQ5GJPgVGkefvwW+pDRF6
	gAwdrZdNSxXv2vztK4couApwfzWZnsBWf5OQoHtMxfTWpxF37Hl/oM4vFevs/WPU3j2P/99g/WT
	2ZG8pph+/bZmTLudkHNndvHOi5HXlcxznHM3bhdK3UNhegHrnyga1yI5GZyWH125aW5et3iCz3q
	ZGOd0ZAimYrXi0ziEVKimhWy+mA3c+QZqgvTJIRPobUKcwMNq+JYlhXf4JPYQwpkCb0IwX5ky6v
	0FC0oTWC3hzu9PvgSruFArzro7kPVfrJPwo+ho0i9mjMI8YCWwHG2gYlhHoSvtar1rtoa8uKvOp
	Rrtcnko5rITMzCdxMpE4jFOFRf+xQAaKiDR95xmzfhHx5e4ksghn95nABC+9LrAI6I93eEeNE0r
	TEUTyOeOU9VnBPKjY48R1P7JSCqGsuJXmFPeib20/xPyncY5Ko7HR0WpYiMBBUneYbdJ/F2G9he
	K8KjOqlDeTMrdltacN7jVebmD4DcbyYf/pPuHQh9Gme1pqWemFndhxR0mFHb+M5ij6Y2rEx8qoZ
	jcr8YrVOSjiai7S1TO1Acep9X19RO4FG6F70LP7qFR9AI/UgWnRd19leSnYvkSvBhqqP51BrVqU
	q3ePucVPH
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr20349731f8f.12.1794815987554;
        Sun, 15 Nov 2026 23:59:47 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm15766858f8f.50.2026.11.15.23.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:59:47 -0800 (PST)
Message-ID: <832e0f9ce4e81ee31a6bcde01591a56aac36e976.camel@amutable.com>
Subject: Re: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:59:45 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel, and that
> memory
> may well have uncorrectable errors. That is after all what the first
> kernel often died of. Every architecture that maps a page of the old
> kernel and copies it out does so with copy_to_iter(), and a machine
> check in that copy takes the capture kernel down.
>=20
> On x86 a machine check in the kernel is only recovered from if the
> instruction that took it has a machine check safe exception table
> entry
> or copies from userspace (cf. error_context()). The copy of an old
> page
> is neither. Its source is kernel memory, whether it goes to the
> buffer
> of a read() or, since commit 4a22fd20379c ("vmcore: convert
> __read_vmcore to use an iov_iter"), into a kernel page for splice(),
> sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
> into a poisoned page panics the capture kernel, and so do vmcore's
> own
> reads of the ELF headers and notes. Breno sees the result on a fleet:
> the first kernel dies of a machine check and the capture kernel
> produces
> no usable vmcore at all (cf. [1]).
>=20
> On book3s64 a machine check in the kernel is recovered from if the
> instruction that took it has an exception table entry (cf.
> mce_common_process_ue()). The user copy has them, so a read() comes
> up
> short there and read_from_oldmem() returns -EFAULT. The copies into
> kernel pages have none and panic the same way. Other powerpc
> platforms
> don't recover from a machine check in such a copy at all.
>=20
> Copy with _copy_mc_to_iter() instead. x86_64 and PPC64 select
> ARCH_HAS_COPY_MC, and on x86_64 and book3s64 the machine check safe
> copy
> turns the machine check into a short copy, which read_from_oldmem()
> turns into -EFAULT like any other short copy. On x86 that holds for
> the
> fragile and the enhanced fast string variant, a CPU with neither gets
> the plain copy it has today. Everywhere else _copy_mc_to_iter() is
> _copy_to_iter(). Put the call into a helper, copy_oldmem_to_iter(),
> so
> that the copy of a page of the old kernel lives in one place and an
> architecture that gains a machine check safe copy later gets this for
> free. The helper does the same check_copy_size() as copy_to_iter(),
> so
> hardened usercopy keeps checking the copy.
>=20
> With a v7.4-rc1 capture kernel reading /proc/vmcore and a machine
> check
> injected into the copy of an old page the capture kernel is gone. A
> machine check panic prints no trace of its own, this one comes from
> panic_sys_info=3Dall_bt:
>=20
> [=C2=A0=C2=A0=C2=A0 0.580568] mce: [Hardware Error]: CPU 0: Machine Check=
 Exception:
> 7 Bank 1: bd80000000000134
> [=C2=A0=C2=A0=C2=A0 0.580574] mce: [Hardware Error]: RIP 10:<ffffffff8190=
9b11>
> {_copy_to_iter+0x81/0x850}
> [=C2=A0=C2=A0=C2=A0 0.580584] mce: [Hardware Error]: TSC 202f2117f ADDR 1=
0000000
> MISC 8c
> [=C2=A0=C2=A0=C2=A0 0.580587] mce: [Hardware Error]: PROCESSOR 2:aa0f02 T=
IME
> 1794493617 SOCKET 0 APIC 0 microcode aa0021c
> [=C2=A0=C2=A0=C2=A0 0.580589] mce: [Hardware Error]: Machine check: Uncor=
rected
> unrecoverable error in kernel context
> [=C2=A0=C2=A0=C2=A0 0.580591] Kernel panic - not syncing: Fatal local mac=
hine check
> [=C2=A0=C2=A0=C2=A0 0.582587] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted=
 7.4.0-rc1-
> g6628e7d4c6b2 #1 PREEMPT(lazy)
> [=C2=A0=C2=A0=C2=A0 0.583101] Call Trace:
> [=C2=A0=C2=A0=C2=A0 0.583198]=C2=A0 <#MC>
> [=C2=A0=C2=A0=C2=A0 0.583279]=C2=A0 dump_stack_lvl+0x4d/0x70
> [=C2=A0=C2=A0=C2=A0 0.583419]=C2=A0 nmi_cpu_backtrace.cold+0x18/0x6e
> [=C2=A0=C2=A0=C2=A0 0.583584]=C2=A0 ? __pfx_nmi_raise_cpu_backtrace+0x10/=
0x10
> [=C2=A0=C2=A0=C2=A0 0.583772]=C2=A0 nmi_trigger_cpumask_backtrace+0xba/0x=
f0
> [=C2=A0=C2=A0=C2=A0 0.583955]=C2=A0 sys_info+0x83/0xb0
> [=C2=A0=C2=A0=C2=A0 0.584075]=C2=A0 vpanic+0x1b4/0x303
> [=C2=A0=C2=A0=C2=A0 0.584197]=C2=A0 panic+0x66/0x70
> [=C2=A0=C2=A0=C2=A0 0.584488]=C2=A0 mce_panic+0x19e/0x290
> [=C2=A0=C2=A0=C2=A0 0.584799]=C2=A0 do_machine_check+0x627/0x9a0
> [=C2=A0=C2=A0=C2=A0 0.584953]=C2=A0 ? _copy_to_iter+0x81/0x850
> [=C2=A0=C2=A0=C2=A0 0.585099]=C2=A0 exc_machine_check+0x68/0xb0
> [=C2=A0=C2=A0=C2=A0 0.585246]=C2=A0 asm_exc_machine_check+0x1e/0x40
> [=C2=A0=C2=A0=C2=A0 0.587747]=C2=A0 </#MC>
> [=C2=A0=C2=A0=C2=A0 0.587831]=C2=A0 <TASK>
> [=C2=A0=C2=A0=C2=A0 0.588092]=C2=A0 ? iomem_map_sanity_check+0x98/0xb0
> [=C2=A0=C2=A0=C2=A0 0.588430]=C2=A0 ? __ioremap_caller.isra.0+0x1a9/0x300
> [=C2=A0=C2=A0=C2=A0 0.588604]=C2=A0 ? __copy_oldmem_page+0x3d/0xb0
> [=C2=A0=C2=A0=C2=A0 0.588928]=C2=A0 __copy_oldmem_page+0x5e/0xb0
> [=C2=A0=C2=A0=C2=A0 0.589079]=C2=A0 read_from_oldmem.part.0+0xe3/0x140
> [=C2=A0=C2=A0=C2=A0 0.589247]=C2=A0 read_vmcore+0x137/0x280
> [=C2=A0=C2=A0=C2=A0 0.589381]=C2=A0 proc_reg_read_iter+0x49/0x90
> [=C2=A0=C2=A0=C2=A0 0.589533]=C2=A0 vfs_read+0x348/0x490
> [=C2=A0=C2=A0=C2=A0 0.589666]=C2=A0 ksys_read+0x76/0x100
> [=C2=A0=C2=A0=C2=A0 0.589792]=C2=A0 do_syscall_64+0xde/0x4b0
> [=C2=A0=C2=A0=C2=A0 0.590103]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0=
x7f
>=20
> With this patch the same injection ends the read() with -EFAULT, the
> capture kernel logs the machine check and keeps running.
>=20
> [1]: https://lore.kernel.org/all/avRXzzCSzT9Qj2FC@gmail.com/
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Breno Leitao <leitao@debian.org>
> Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an
> iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c |=C2=A0 4 ++--
> =C2=A0arch/x86/kernel/crash_dump_64.c=C2=A0 |=C2=A0 2 +-
> =C2=A0include/linux/crash_dump.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22=
 ++++++++++++++++++++++
> =C2=A03 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 1543917bd3e1d..f784fc5cb0030 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -83,12 +83,12 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0
> =C2=A0	if (memblock_is_region_memory(paddr, csize)) {
> =C2=A0		vaddr =3D __va(paddr);
> -		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +		csize =3D copy_oldmem_to_iter(vaddr + offset, csize,
> iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> =C2=A0		if (!vaddr)
> =C2=A0			return -ENOMEM;
> -		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +		csize =3D copy_oldmem_to_iter(vaddr + offset, csize,
> iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}
> =C2=A0
> diff --git a/arch/x86/kernel/crash_dump_64.c
> b/arch/x86/kernel/crash_dump_64.c
> index 32d710f7eb84c..e10dada855b70 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -29,7 +29,7 @@ static ssize_t __copy_oldmem_page(struct iov_iter
> *iter, unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap((void __iomem *)vaddr);
> =C2=A0	return csize;
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 8315270e27b7a..12aeaa40c1c94 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/proc_fs.h>
> =C2=A0#include <linux/elf.h>
> =C2=A0#include <linux/pgtable.h>
> +#include <linux/uio.h>
> =C2=A0#include <uapi/linux/vmcore.h>
> =C2=A0
> =C2=A0/* For IS_ENABLED(CONFIG_CRASH_DUMP) */
> @@ -33,6 +34,27 @@ ssize_t copy_oldmem_page(struct iov_iter *i,
> unsigned long pfn, size_t csize,
> =C2=A0ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned
> long pfn,
> =C2=A0				=C2=A0=C2=A0 size_t csize, unsigned long
> offset);
> =C2=A0
> +/**
> + * copy_oldmem_to_iter - copy from the crashed kernel's memory
> + * @src: where in the mapped page of the crashed kernel to copy from
> + * @count: how many bytes to copy
> + * @iter: where to copy them
> + *
> + * The memory of the crashed kernel may well have uncorrectable
> errors.
> + * Where the architecture has a machine check safe copy a machine
> check
> + * in the copy ends it short, like a fault would, instead of taking
> the
> + * capture kernel down. Everywhere else this is copy_to_iter().
> + *
> + * Return: the number of bytes copied, like copy_to_iter().
> + */
> +static inline size_t copy_oldmem_to_iter(const void *src, size_t
> count,
> +					 struct iov_iter *iter)
> +{
> +	if (check_copy_size(src, count, true))
> +		return _copy_mc_to_iter(src, count, iter);
> +	return 0;
> +}
> +
> =C2=A0void vmcore_cleanup(void);
> =C2=A0
> =C2=A0/* Architecture code defines this if there are other possible ELF
