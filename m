Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574086;
	b=YrqU8XQgyJfUXP7is6Becqf/YpnkUsiFv6lHPNWHTKquQ/y8oQJiQt0BPqNU8xV1ydmj
	 BKvtjftkfld3u1oyPeWqE36qIZ0ePu3tUN5z+vImf76jMZYfXeFTCttSvaaEEgd0usYPT
	 8BhQsDvfmPmcIN8LzGFTyo0yDgiL5QoEf9bPT5rYYG6r/nz3Uf+giDrLJi08tyvIClsxL
	 rg5zvH/UarDWJNvZaIlCyksJ28lGJv1L7sPDDtZWrWYsBpZKW8Qrh7NB9pkBk03s5ZNVZ
	 plQcdgqQ0I3RptKeEvoXPj+g+fRMBzjbQKjiPFlZdDWkIYGT+d3YNOLcUanec8q2xxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=Ge+krrdF0op052g8NCIoQS8dB+SJ9vnrVFcigLDs0Mo=;
	b=rBw1q+0/Oz0A0w2FL5q8daP0GpUhHiKiJV09/HHQjxJDrp3txX9ii/VUaNSGTAWb2fc+
	 /I0IIE6kHzMPvbLY+RpsAVqp3vZ7CgnSbrUK4H6KyyA84J6qIEsTvzHuVWABYctm5N2us
	 fWuLSkHYVzkzfk8BANp/OmYEm7M6CWp/ocuoDFg+qgauG5EicIRlbRx5Of23aqsfr/OHU
	 YoA6GSJsc1p9RCH3DV90IH2iJ7Lxmxhd8y/8WBsO3tAYrd1Mv61xRHAAAlyzWPqTaFlMv
	 8Q1xQg4TQKxxrJNBlhNcFxM3N6DPiOIID18W5ujfbz+8jIiRqnID5A3l1RVKvww+JyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbx8FrxI;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A9606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988A9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbx8FrxI
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so1327126f8f.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574082; x=1795178882; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ge+krrdF0op052g8NCIoQS8dB+SJ9vnrVFcigLDs0Mo=;
        b=sbx8FrxIGHGXZZMw4lBjLqMf2ZWtBg9Tc+al98v2rXnozp19484J9ha1oMhOCelsZA
         yZiAy68x8uafCLlUpY80fhkRwCsSYug4sBwInkd+qWDTNHKa8rh0hySvkjAQRX5GsqHU
         CW7/aXI2JUhtwxIJgCKsAz5w/ptPN7B+iRfe9YSw1TwpxGjpUN3EEe1fAgHSJ91lVsm2
         f6PApm+Id+x80A77DsDxBJeGISYN3VhsAQJKGuGigcBZS6rU+muNETcH2FKlwU8e83RD
         agYY3IFXle1NyRorOwazRvHfHijPZSN9mZrMJhM7eeEVT4WmE7TAsa09l6/DEEUJq6+b
         hGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574082; x=1795178882;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ge+krrdF0op052g8NCIoQS8dB+SJ9vnrVFcigLDs0Mo=;
        b=F4cYdvZBofl9EpZOL73CHVeKIoPzvM2clF82GkVeacyepKSqdsmx0uy3newHeDXlH5
         gu4y1AVMwUIF3WGMznnxgrqP8xtduP23g+7ZLbYv0PGAi7hkKJ2Iwd2rShpQNGjxDYKs
         qi8DsH4k7wjuCmMdXFbyxka7vWomLo4vLDBlwyMoWYxt5UhaMrQMXY0q749PTn3tFCOh
         l8jdxaZXEQpbrNBEqbd2r3nQbGjOf1M3FX2EbY/7umncF6QNnMXMNLbEAfhYZKlViss/
         Eg6RdNtDs4lKpkitQ9xFLY1fWbmU6OfICmG1rvuLYp9WJsMfyt9vAsbmycUu4h/lTVwe
         BhIQ==
X-Forwarded-Encrypted: i=1; AL+hErEy+EgYEc7P+v8r3bMJG8Sa9+wBajHLnLGF1TsWQrUc5ZRP88jphJKPCjn37iPDBnRWOt1H+jA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3RNSwkZ/fXhbdkk6pamKRWVVIoEOUY2b7F55pzRHjcDRi8f/w
	puMyx/FDDztHz0neq1zMF02+QWpnNXmsoMvCEElnKP265Dl1HPp8cvTT
X-Gm-Gg: AYBFou0HIJU+p1974dRhQ4LZl0NNKtYMqKO0wkEzoZ6Km77luP7vCe8UA8P1aOwUNri
	GkmhH57gNvnHlX6rZATiQ+qVhbpdyElxGFFo6fpdJlVAyPY2Azp3aY699nwV1CVHUrtEEQcFUr2
	O5CkkC5JONl+DdmYAAz6Zd/bboT+vpvJ1b77xA4wYL/xgoYU9dkxUNTzzgqF1vQIps6oeiKZbZj
	7ZWcHkOEtYzIT/nooWBH8rNK1nu0HMsbV+WCWPSQyYBmCNdAbcrVXWOUcWFLJYqu8jlegDcZcCQ
	B60W5K/J7Mxk+JZvbTCGEzU78VLaHT+IEyD+K5XEFXkRalNZdOjj3OG3wqzGv7PUcN6q7Xwxm8j
	asSkn/pF52+3z6ft1UaAeA3qUCX/mwReGUmG6B4xExeyMxfKe2wq6zQPaTpGd7xfkp0Mpm1I82x
	qWjJIlRVH/7pIUOMhiM9m4fVr8pNykmL6cyeuMiHPAuNq3pv4Z0kLw0hJE9CL4sH/Qga70evUBK
	gbOywzhnVpJvjOM4e2pFRECsCSrM8qTENMow3fc4Kxwria6gf6PH84Y83sA1RS+fBGpPNEarbCq
	mB5+IpUQOStIc60jPMjvepjsM95l4j+D2HXf5RjNo/RXHSJ8Rl6HnNSGRZqBWLNm
X-Received: by 2002:a05:6000:480e:b0:493:f3f2:2255 with SMTP id ffacd0b85a97d-49c70542714mr4910825f8f.25.1794574081520;
        Fri, 13 Nov 2026 04:48:01 -0800 (PST)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm5283171f8f.28.2026.11.13.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:47:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E549CDC01BF; Fri, 13 Nov 2026 13:47:58 +0100 (CET)
Date: Fri, 13 Nov 2026 13:47:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION 6.12.117] CPA detected W^X violation: 0000000000000121
 -> 0000000000000123 range: 0xffffffffc0477000 - 0xffffffffc0477fff PFN
 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665
 __change_page_attr_set_clr+0xf62/0xfb0
Message-ID: <avcG_ggetL8ArwAx@eldamar.lan>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wCGO9XF51TdiqsoM"
Content-Disposition: inline

--wCGO9XF51TdiqsoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

While updating from 6.12.116 to 6.12.117 on one system the following
warning is seen:

[    0.991048] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.992476] Run /init as init process
[    0.993426]   with arguments:
[    0.993428]     /init
[    0.993428]   with environment:
[    0.993429]     HOME=/
[    0.993429]     TERM=linux
[    1.091378] ------------[ cut here ]------------
[    1.092538] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 - 0x
ffffffffc0477fff PFN 109c1f
[    1.093994] WARNING: CPU: 5 PID: 222 at arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
[    1.095730] Modules linked in:
[    1.097101] CPU: 5 UID: 0 PID: 222 Comm: (udev-worker) Not tainted 6.12.117+deb13-amd64 #1  Debian 6.12.117-1
[    1.098671] Hardware name: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ETA2W (1.78 ) 07/23/2026
[    1.100096] RIP: 0010:__change_page_attr_set_clr+0xf62/0xfb0
[    1.101357] Code: 09 ea e9 19 fa ff ff 48 8b 4c 24 10 49 89 d9 4c 89 d6 48 89 54 24 08 48 c7 c7 38 43 95 a6 c6 05 d1 fd d7 01 01 e8 9e 76 01 00 <0f> 0b 48 8b 54 24 08 e9 22 fc ff ff 80 3d ba fd d7 01 00 0f 85 15
[    1.102928] RSP: 0018:ffffd02d40557648 EFLAGS: 00010286
[    1.104241] RAX: 0000000000000000 RBX: 0000000000109c1f RCX: 0000000000000003
[    1.105561] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
[    1.107204] RBP: 0000000109c1f121 R08: 0000000000000000 R09: ffffd02d405574c8
[    1.108503] R10: ffffffffa70b43a8 R11: 0000000000000003 R12: 0000000000000001
[    1.109816] R13: 0000000109c1f121 R14: 0000000000000001 R15: ffffffffc0477000
[    1.111556] FS:  00007fcf08a6b980(0000) GS:ffff88c4bf680000(0000) knlGS:0000000000000000
[    1.112888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.114279] CR2: 000055cf7979a138 CR3: 000000014061e006 CR4: 0000000000f70ef0
[    1.115600] PKRU: 55555554
[    1.116935] Call Trace:
[    1.118345]  <TASK>
[    1.119677]  ? __purge_vmap_area_lazy+0x13c/0x320
[    1.120979]  ? _vm_unmap_aliases+0x217/0x260
[    1.122392]  change_page_attr_set_clr+0x104/0x1a0
[    1.123702]  set_memory_rw+0x28/0x40
[    1.125019]  apply_retpolines+0x19c/0x4c0
[    1.126404]  module_finalize+0x209/0x3e0
[    1.127690]  ? add_kallsyms+0x293/0x310
[    1.128985]  load_module+0x17f1/0x1e90
[    1.130318]  ? init_module_from_file+0x89/0xe0
[    1.131586]  init_module_from_file+0x89/0xe0
[    1.132873]  idempotent_init_module+0x11e/0x310
[    1.134175]  __x64_sys_finit_module+0x5e/0xb0
[    1.135433]  do_syscall_64+0x87/0x1b0
[    1.136706]  ? vfs_read+0x24d/0x370
[    1.137967]  ? __x64_sys_pread64+0x98/0xd0
[    1.139652]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
[    1.140905]  ? syscall_exit_to_user_mode+0x37/0x1b0
[    1.142172]  ? do_syscall_64+0x93/0x1b0
[    1.143402]  ? __count_memcg_events+0x53/0xf0
[    1.144644]  ? count_memcg_events.constprop.0+0x1a/0x30
[    1.145859]  ? handle_mm_fault+0x1bb/0x2c0
[    1.147452]  ? do_user_addr_fault+0x367/0x650
[    1.148626]  ? clear_bhb_loop+0x70/0xc0
[    1.149809]  ? clear_bhb_loop+0x70/0xc0
[    1.151303]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.152445] RIP: 0033:0x7fcf095cf4f9
[    1.153586] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 68 0d 00 f7 d8 64 89 01 48
[    1.155067] RSP: 002b:00007fffd10634a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    1.156238] RAX: ffffffffffffffda RBX: 000055cf79783110 RCX: 00007fcf095cf4f9
[    1.157419] RDX: 0000000000000004 RSI: 00007fcf07cf944d RDI: 0000000000000010
[    1.158766] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055cf79763ba0
[    1.159927] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcf07cf944d
[    1.161090] R13: 0000000000020000 R14: 000055cf79784bc0 R15: 0000000000000000
[    1.162318]  </TASK>
[    1.163460] ---[ end trace 0000000000000000 ]---

I'm attaching for comparison as well the log from 6.12.116 which does
not show any CPA detected W^X violation message, while the 6.12.117
shows it twice, with one WARNING.

Regards,
Salvatore

--wCGO9XF51TdiqsoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.12.116-1.log

[    0.000000] Linux version 6.12.116+deb13-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT_DYNAMIC Debian 6.12.116-1 (2026-11-07)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.12.116+deb13-amd64 root=/dev/mapper/arabella--vg-root ro
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008f36efff] usable
[    0.000000] BIOS-e820: [mem 0x000000008f36f000-0x000000009432efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009432f000-0x0000000094f2efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000094f2f000-0x0000000094ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000094fff000-0x0000000094ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000095000000-0x0000000098ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000099400000-0x00000000995fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000099e00000-0x00000000a07fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000085f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by Lenovo
[    0.000000] efi: ACPI=0x94ffe000 ACPI 2.0=0x94ffe014 TPMFinalLog=0x94d8f000 SMBIOS=0x910bb000 SMBIOS 3.0=0x910ae000 MEMATTR=0x8afb0018 ESRT=0x8afb6018 MOKvar=0x8f81a000 INITRD=0x6dbec898 RNG=0x94ffd018 TPMEventLog=0x94fec018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem95: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] Kernel is locked down from EFI Secure Boot; see man kernel_lockdown.7
[    0.000000] secureboot: Secure boot enabled
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ETA2W (1.78 ) 07/23/2026
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000011] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000017] last_pfn = 0x85f800 max_arch_pfn = 0x400000000
[    0.000021] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000023] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000484] last_pfn = 0x95000 max_arch_pfn = 0x400000000
[    0.012068] esrt: Reserving ESRT space from 0x000000008afb6018 to 0x000000008afb6280.
[    0.012076] e820: update [mem 0x8afb6000-0x8afb6fff] usable ==> reserved
[    0.012102] Using GB pages for direct mapping
[    0.012369] RAMDISK: [mem 0x67534000-0x69a65fff]
[    0.012418] ACPI: Early table checksum verification disabled
[    0.012421] ACPI: RSDP 0x0000000094FFE014 000024 (v02 LENOVO)
[    0.012425] ACPI: XSDT 0x0000000094FFC188 000114 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012432] ACPI: FACP 0x00000000910A0000 000114 (v06 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012437] ACPI: DSDT 0x0000000091065000 035147 (v02 LENOVO ICL      00000002      01000013)
[    0.012441] ACPI: FACS 0x0000000094D6E000 000040
[    0.012444] ACPI: SSDT 0x000000009114A000 00255D (v02 LENOVO CpuSsdt  00003000 INTL 20191018)
[    0.012447] ACPI: SSDT 0x0000000091149000 00059B (v02 LENOVO CtdpB    00001000 INTL 20191018)
[    0.012450] ACPI: SSDT 0x00000000910D0000 003F6F (v02 LENOVO DptfTabl 00001000 INTL 20191018)
[    0.012453] ACPI: SSDT 0x00000000910BD000 00060E (v02 LENOVO Tpm2Tabl 00001000 INTL 20191018)
[    0.012456] ACPI: TPM2 0x00000000910BC000 00004C (v04 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012459] ACPI: ECDT 0x00000000910A1000 000053 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012462] ACPI: HPET 0x000000009109F000 000038 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012465] ACPI: APIC 0x000000009109E000 00012C (v04 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012467] ACPI: SSDT 0x000000009109D000 0000F2 (v02 LENOVO PID1Ssdt 00000010 INTL 20191018)
[    0.012470] ACPI: SSDT 0x000000009109B000 0014F8 (v02 LENOVO ProjSsdt 00000010 INTL 20191018)
[    0.012473] ACPI: SSDT 0x0000000091062000 002926 (v02 LENOVO TglU_Rvp 00001000 INTL 20191018)
[    0.012476] ACPI: NHLT 0x0000000091060000 001B80 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012479] ACPI: SSDT 0x000000009105C000 002CD7 (v02 LENOVO SaSsdt   00003000 INTL 20191018)
[    0.012482] ACPI: SSDT 0x0000000091058000 003573 (v02 LENOVO IgfxSsdt 00003000 INTL 20191018)
[    0.012485] ACPI: SSDT 0x000000009104C000 00B6A1 (v02 LENOVO TcssSsdt 00001000 INTL 20191018)
[    0.012487] ACPI: LPIT 0x000000009104A000 0000CC (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012490] ACPI: WSMT 0x0000000091049000 000028 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012493] ACPI: SSDT 0x0000000091048000 00012A (v02 LENOVO TbtTypeC 00000000 INTL 20191018)
[    0.012496] ACPI: DBGP 0x0000000091047000 000034 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012499] ACPI: DBG2 0x0000000091046000 000054 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012502] ACPI: MSDM 0x0000000091045000 000055 (v03 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012505] ACPI: SSDT 0x000000009102E000 000B9C (v02 LENOVO UsbCTabl 00001000 INTL 20191018)
[    0.012507] ACPI: BATB 0x000000009102D000 00004A (v02 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012510] ACPI: MCFG 0x000000008F82A000 00003C (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012513] ACPI: SSDT 0x000000008F829000 000144 (v02 LENOVO ADebTabl 00001000 INTL 20191018)
[    0.012516] ACPI: BGRT 0x000000009102F000 000038 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012519] ACPI: PTDT 0x000000008F828000 000986 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012522] ACPI: UEFI 0x00000000944C2000 00008A (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012525] ACPI: FPDT 0x000000008F827000 000034 (v01 LENOVO TP-N32   00001780 PTEC 00001780)
[    0.012527] ACPI: Reserving FACP table memory at [mem 0x910a0000-0x910a0113]
[    0.012528] ACPI: Reserving DSDT table memory at [mem 0x91065000-0x9109a146]
[    0.012529] ACPI: Reserving FACS table memory at [mem 0x94d6e000-0x94d6e03f]
[    0.012530] ACPI: Reserving SSDT table memory at [mem 0x9114a000-0x9114c55c]
[    0.012531] ACPI: Reserving SSDT table memory at [mem 0x91149000-0x9114959a]
[    0.012531] ACPI: Reserving SSDT table memory at [mem 0x910d0000-0x910d3f6e]
[    0.012532] ACPI: Reserving SSDT table memory at [mem 0x910bd000-0x910bd60d]
[    0.012533] ACPI: Reserving TPM2 table memory at [mem 0x910bc000-0x910bc04b]
[    0.012533] ACPI: Reserving ECDT table memory at [mem 0x910a1000-0x910a1052]
[    0.012534] ACPI: Reserving HPET table memory at [mem 0x9109f000-0x9109f037]
[    0.012535] ACPI: Reserving APIC table memory at [mem 0x9109e000-0x9109e12b]
[    0.012535] ACPI: Reserving SSDT table memory at [mem 0x9109d000-0x9109d0f1]
[    0.012536] ACPI: Reserving SSDT table memory at [mem 0x9109b000-0x9109c4f7]
[    0.012537] ACPI: Reserving SSDT table memory at [mem 0x91062000-0x91064925]
[    0.012537] ACPI: Reserving NHLT table memory at [mem 0x91060000-0x91061b7f]
[    0.012538] ACPI: Reserving SSDT table memory at [mem 0x9105c000-0x9105ecd6]
[    0.012539] ACPI: Reserving SSDT table memory at [mem 0x91058000-0x9105b572]
[    0.012539] ACPI: Reserving SSDT table memory at [mem 0x9104c000-0x910576a0]
[    0.012540] ACPI: Reserving LPIT table memory at [mem 0x9104a000-0x9104a0cb]
[    0.012541] ACPI: Reserving WSMT table memory at [mem 0x91049000-0x91049027]
[    0.012542] ACPI: Reserving SSDT table memory at [mem 0x91048000-0x91048129]
[    0.012542] ACPI: Reserving DBGP table memory at [mem 0x91047000-0x91047033]
[    0.012543] ACPI: Reserving DBG2 table memory at [mem 0x91046000-0x91046053]
[    0.012544] ACPI: Reserving MSDM table memory at [mem 0x91045000-0x91045054]
[    0.012544] ACPI: Reserving SSDT table memory at [mem 0x9102e000-0x9102eb9b]
[    0.012545] ACPI: Reserving BATB table memory at [mem 0x9102d000-0x9102d049]
[    0.012546] ACPI: Reserving MCFG table memory at [mem 0x8f82a000-0x8f82a03b]
[    0.012549] ACPI: Reserving SSDT table memory at [mem 0x8f829000-0x8f829143]
[    0.012550] ACPI: Reserving BGRT table memory at [mem 0x9102f000-0x9102f037]
[    0.012551] ACPI: Reserving PTDT table memory at [mem 0x8f828000-0x8f828985]
[    0.012552] ACPI: Reserving UEFI table memory at [mem 0x944c2000-0x944c2089]
[    0.012552] ACPI: Reserving FPDT table memory at [mem 0x8f827000-0x8f827033]
[    0.013044] No NUMA configuration found
[    0.013045] Faking a node at [mem 0x0000000000000000-0x000000085f7fffff]
[    0.013054] NODE_DATA(0) allocated [mem 0x85f7d5680-0x85f7fffff]
[    0.013281] Zone ranges:
[    0.013282]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013283]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013285]   Normal   [mem 0x0000000100000000-0x000000085f7fffff]
[    0.013286]   Device   empty
[    0.013287] Movable zone start for each node
[    0.013288] Early memory node ranges
[    0.013289]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.013290]   node   0: [mem 0x0000000000100000-0x000000008f36efff]
[    0.013291]   node   0: [mem 0x0000000094fff000-0x0000000094ffffff]
[    0.013292]   node   0: [mem 0x0000000100000000-0x000000085f7fffff]
[    0.013295] Initmem setup node 0 [mem 0x0000000000001000-0x000000085f7fffff]
[    0.013302] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013330] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.016804] On node 0, zone DMA32: 23696 pages in unavailable ranges
[    0.017149] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.017163] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.017223] Reserving Intel graphics memory at [mem 0x9c800000-0xa07fffff]
[    0.018034] ACPI: PM-Timer IO Port: 0x1808
[    0.018044] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.018045] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.018046] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.018047] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.018047] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.018048] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.018048] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.018049] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.018050] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.018050] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.018051] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.018052] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.018052] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.018053] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.018054] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.018054] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.018173] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.018176] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.018178] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.018182] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.018184] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.018193] e820: update [mem 0x8a7ed000-0x8a87dfff] usable ==> reserved
[    0.018202] TSC deadline timer available
[    0.018206] CPU topo: Max. logical packages:   1
[    0.018207] CPU topo: Max. logical dies:       1
[    0.018208] CPU topo: Max. dies per package:   1
[    0.018212] CPU topo: Max. threads per core:   2
[    0.018213] CPU topo: Num. cores per package:     4
[    0.018213] CPU topo: Num. threads per package:   8
[    0.018214] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.018226] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.018228] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.018229] PM: hibernation: Registered nosave memory: [mem 0x8a7ed000-0x8a87dfff]
[    0.018231] PM: hibernation: Registered nosave memory: [mem 0x8afb6000-0x8afb6fff]
[    0.018232] PM: hibernation: Registered nosave memory: [mem 0x8f36f000-0x94ffefff]
[    0.018233] PM: hibernation: Registered nosave memory: [mem 0x95000000-0xffffffff]
[    0.018235] [mem 0xa0800000-0xfed1ffff] available for PCI devices
[    0.018236] Booting paravirtualized kernel on bare hardware
[    0.018238] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.024524] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.025090] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.025096] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.025098] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
[    0.025114] Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.116+deb13-amd64 root=/dev/mapper/arabella--vg-root ro
[    0.027921] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.029203] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.029322] Fallback order for Node 0: 0 
[    0.029326] Built 1 zonelists, mobility grouping on.  Total pages: 8317710
[    0.029327] Policy zone: Normal
[    0.029333] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.029338] software IO TLB: area num 8.
[    0.049558] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.057858] ftrace: allocating 45285 entries in 180 pages
[    0.057860] ftrace: allocated 180 pages with 4 groups
[    0.058646] Dynamic Preempt: voluntary
[    0.058707] rcu: Preemptible hierarchical RCU implementation.
[    0.058707] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.058709] 	Trampoline variant of Tasks RCU enabled.
[    0.058709] 	Rude variant of Tasks RCU enabled.
[    0.058710] 	Tracing variant of Tasks RCU enabled.
[    0.058710] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.058711] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.058719] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.058721] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.058723] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.063635] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.064132] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.064641] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.064711] Console: colour dummy device 80x25
[    0.064714] printk: legacy console [tty0] enabled
[    0.065031] ACPI: Core revision 20240827
[    0.065325] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.065487] APIC: Switch to symmetric I/O mode setup
[    0.070376] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.085070] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.085078] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    0.085106] x86/cpu: VMX (outside TXT) disabled by BIOS
[    0.085116] CPU0: Thermal monitoring enabled (TM1)
[    0.085120] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.085276] CET detected: Indirect Branch Tracking enabled
[    0.085280] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.085282] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.085287] process: using mwait in idle threads
[    0.085291] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.085295] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
[    0.085298] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.085300] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.085306] Spectre V2 : Enabling IBPB for BPF
[    0.085308] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.085312] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.085317] GDS: Mitigation: Microcode
[    0.085319] active return thunk: its_return_thunk
[    0.085324] ITS: Mitigation: Aligned branch/return thunks
[    0.085334] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.085337] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.085340] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.085342] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.085344] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.085346] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.085349] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.085352] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.085355] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.085358] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.085360] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.085362] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.085365] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.085367] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.085370] x86/fpu: Enabled xstate features 0xae7, context size is 2456 bytes, using 'compacted' format.
[    0.089076] Freeing SMP alternatives memory: 40K
[    0.089076] pid_max: default: 32768 minimum: 301
[    0.089076] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.089076] landlock: Up and running.
[    0.089076] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.089076] AppArmor: AppArmor initialized
[    0.089076] TOMOYO Linux initialized
[    0.089076] LSM support for eBPF active
[    0.089076] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.089076] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.089076] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[    0.089076] Performance Events: PEBS fmt4+-baseline, Icelake events, AnyThread deprecated, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.089076] ... version:                5
[    0.089076] ... bit width:              48
[    0.089076] ... generic registers:      8
[    0.089076] ... value mask:             0000ffffffffffff
[    0.089076] ... max period:             00007fffffffffff
[    0.089076] ... fixed-purpose events:   4
[    0.089076] ... event mask:             0001000f000000ff
[    0.089076] signal: max sigframe size: 3632
[    0.089076] Estimated ratio of average max frequency by base frequency (times 1024): 1499
[    0.089076] rcu: Hierarchical SRCU implementation.
[    0.089076] rcu: 	Max phase no-delay instances is 1000.
[    0.089076] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.089076] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.089076] smp: Bringing up secondary CPUs ...
[    0.089076] smpboot: x86: Booting SMP configuration:
[    0.089076] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.093149] smp: Brought up 1 node, 8 CPUs
[    0.093149] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[    0.121097] node 0 deferred pages initialised in 24ms
[    0.121915] Memory: 32419156K/33270840K available (16384K kernel code, 2499K rwdata, 11832K rodata, 4176K init, 4888K bss, 841580K reserved, 0K cma-reserved)
[    0.122604] devtmpfs: initialized
[    0.122604] x86/mm: Memory block size: 128MB
[    0.126734] ACPI: PM: Registering ACPI NVS region [mem 0x9432f000-0x94f2efff] (12582912 bytes)
[    0.126734] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.126734] pinctrl core: initialized pinctrl subsystem
[    0.126734] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.126734] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.126734] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.126962] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.126974] audit: initializing netlink subsys (disabled)
[    0.126985] audit: type=2000 audit(1794514018.040:1): state=initialized audit_enabled=0 res=1
[    0.126985] thermal_sys: Registered thermal governor 'fair_share'
[    0.126985] thermal_sys: Registered thermal governor 'bang_bang'
[    0.126985] thermal_sys: Registered thermal governor 'step_wise'
[    0.126985] thermal_sys: Registered thermal governor 'user_space'
[    0.126985] thermal_sys: Registered thermal governor 'power_allocator'
[    0.126985] cpuidle: using governor ladder
[    0.126985] cpuidle: using governor menu
[    0.131768] efi: Freeing EFI boot services memory: 117060K
[    0.131774] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.131776] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.132315] PCI: ECAM [mem 0xc0000000-0xc79fffff] (base 0xc0000000) for domain 0000 [bus 00-79]
[    0.132333] PCI: Using configuration type 1 for base access
[    0.132415] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.132415] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.132415] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.132415] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.132415] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.132415] ACPI: Added _OSI(Module Device)
[    0.132415] ACPI: Added _OSI(Processor Device)
[    0.132415] ACPI: Added _OSI(Processor Aggregator Device)
[    0.201854] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.210654] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.211642] ACPI: EC: EC started
[    0.211645] ACPI: EC: interrupt blocked
[    0.212225] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.212227] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.229392] ACPI: Dynamic OEM Table Load:
[    0.229401] ACPI: SSDT 0xFFFF8F579AF5A000 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[    0.230034] ACPI: Dynamic OEM Table Load:
[    0.230040] ACPI: SSDT 0xFFFF8F579AF85000 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[    0.230643] ACPI: Dynamic OEM Table Load:
[    0.230647] ACPI: SSDT 0xFFFF8F579AF95A00 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[    0.231195] ACPI: Dynamic OEM Table Load:
[    0.231200] ACPI: SSDT 0xFFFF8F579AF5F000 00028B (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[    0.231871] ACPI: Dynamic OEM Table Load:
[    0.231876] ACPI: SSDT 0xFFFF8F579AF63000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[    0.232520] ACPI: Dynamic OEM Table Load:
[    0.232525] ACPI: SSDT 0xFFFF8F579AF83000 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[    0.233076] ACPI: Dynamic OEM Table Load:
[    0.233076] ACPI: SSDT 0xFFFF8F579AF87800 0004D4 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[    0.233076] ACPI: Dynamic OEM Table Load:
[    0.233076] ACPI: SSDT 0xFFFF8F579AF80800 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[    0.233493] ACPI: Interpreter enabled
[    0.233538] ACPI: PM: (supports S0 S4 S5)
[    0.233539] ACPI: Using IOAPIC for interrupt routing
[    0.233572] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.233574] PCI: Ignoring E820 reservations for host bridge windows
[    0.233901] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.234719] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.236273] ACPI: \_SB_.PC00.LPCB.EC__.PUBS: New power resource
[    0.239520] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.BTPR: New power resource
[    0.240407] ACPI: \_SB_.PC00.RP01.PXP_: New power resource
[    0.240599] ACPI: \_SB_.PC00.RP01.PXSX.MRST: New power resource
[    0.240612] ACPI: \_SB_.PC00.RP01.PXSX.DRST: New power resource
[    0.241321] ACPI: \_SB_.PC00.RP05.PXP_: New power resource
[    0.245024] ACPI: \_SB_.PC00.SAT0.VOL0.V0PR: New power resource
[    0.245099] ACPI: \_SB_.PC00.SAT0.VOL1.V1PR: New power resource
[    0.245149] ACPI: \_SB_.PC00.SAT0.VOL2.V2PR: New power resource
[    0.247062] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.247230] ACPI: \_SB_.PC00.TBT0: New power resource
[    0.247254] ACPI: \_SB_.PC00.TBT1: New power resource
[    0.247276] ACPI: \_SB_.PC00.D3C_: New power resource
[    0.470609] ACPI: \PIN_: New power resource
[    0.470623] ACPI: \PINP: New power resource
[    0.470921] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-79])
[    0.470927] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.474824] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.482253] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    0.482255] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.485828] PCI host bridge to bus 0000:00
[    0.485831] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.485834] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.485835] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.485837] pci_bus 0000:00: root bus resource [mem 0xa0800000-0xbfffffff window]
[    0.485839] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.485841] pci_bus 0000:00: root bus resource [bus 00-79]
[    0.597757] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000 conventional PCI endpoint
[    0.598056] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.598065] pci 0000:00:02.0: BAR 0 [mem 0x603c000000-0x603cffffff 64bit]
[    0.598071] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.598075] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    0.598089] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.598093] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.598117] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.598119] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.598123] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.598125] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.598257] pci 0000:00:04.0: [8086:9a03] type 00 class 0x118000 conventional PCI endpoint
[    0.598274] pci 0000:00:04.0: BAR 0 [mem 0x603d180000-0x603d19ffff 64bit]
[    0.598538] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400 PCIe Root Port
[    0.598554] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.598558] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.598608] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.598632] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.599058] pci 0000:00:07.0: [8086:9a25] type 01 class 0x060400 PCIe Root Port
[    0.599079] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.599084] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.599092] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.599115] pci 0000:00:07.0: Overriding RP PIO Log Size to 4
[    0.599170] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.599616] pci 0000:00:07.2: [8086:9a27] type 01 class 0x060400 PCIe Root Port
[    0.599637] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.599642] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.599650] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.599673] pci 0000:00:07.2: Overriding RP PIO Log Size to 4
[    0.599727] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.600230] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000 conventional PCI endpoint
[    0.600238] pci 0000:00:08.0: BAR 0 [mem 0x603d1da000-0x603d1dafff 64bit]
[    0.600333] pci 0000:00:0a.0: [8086:9a0d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.600341] pci 0000:00:0a.0: BAR 0 [mem 0x603d1c0000-0x603d1c7fff 64bit]
[    0.600361] pci 0000:00:0a.0: enabling Extended Tags
[    0.600475] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330 conventional PCI endpoint
[    0.600488] pci 0000:00:0d.0: BAR 0 [mem 0x603d1b0000-0x603d1bffff 64bit]
[    0.600541] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.600776] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340 conventional PCI endpoint
[    0.600787] pci 0000:00:0d.2: BAR 0 [mem 0x603d140000-0x603d17ffff 64bit]
[    0.600795] pci 0000:00:0d.2: BAR 2 [mem 0x603d1d9000-0x603d1d9fff 64bit]
[    0.600829] pci 0000:00:0d.2: supports D1 D2
[    0.600830] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.600897] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340 conventional PCI endpoint
[    0.600909] pci 0000:00:0d.3: BAR 0 [mem 0x603d100000-0x603d13ffff 64bit]
[    0.600917] pci 0000:00:0d.3: BAR 2 [mem 0x603d1d8000-0x603d1d8fff 64bit]
[    0.600950] pci 0000:00:0d.3: supports D1 D2
[    0.600951] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.601220] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330 conventional PCI endpoint
[    0.601261] pci 0000:00:14.0: BAR 0 [mem 0x603d1a0000-0x603d1affff 64bit]
[    0.601368] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.601647] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000 conventional PCI endpoint
[    0.601682] pci 0000:00:14.2: BAR 0 [mem 0x603d1d0000-0x603d1d3fff 64bit]
[    0.601698] pci 0000:00:14.2: BAR 2 [mem 0x603d1d7000-0x603d1d7fff 64bit]
[    0.602248] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.602636] pci 0000:00:14.3: BAR 0 [mem 0x603d1cc000-0x603d1cffff 64bit]
[    0.604650] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.606545] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000 conventional PCI endpoint
[    0.607442] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.611327] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000 conventional PCI endpoint
[    0.611361] pci 0000:00:16.0: BAR 0 [mem 0x603d1d5000-0x603d1d5fff 64bit]
[    0.611460] pci 0000:00:16.0: PME# supported from D3hot
[    0.611917] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100 conventional PCI endpoint
[    0.612295] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380 conventional PCI endpoint
[    0.612374] pci 0000:00:1f.3: BAR 0 [mem 0x603d1c8000-0x603d1cbfff 64bit]
[    0.612471] pci 0000:00:1f.3: BAR 4 [mem 0x603d000000-0x603d0fffff 64bit]
[    0.612620] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.612900] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500 conventional PCI endpoint
[    0.612957] pci 0000:00:1f.4: BAR 0 [mem 0x603d1d4000-0x603d1d40ff 64bit]
[    0.612985] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.613250] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000 conventional PCI endpoint
[    0.613276] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.613454] pci 0000:04:00.0: [1344:5407] type 00 class 0x010802 PCIe Endpoint
[    0.613466] pci 0000:04:00.0: BAR 0 [mem 0xbc200000-0xbc203fff 64bit]
[    0.613492] pci 0000:04:00.0: enabling Extended Tags
[    0.613648] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.613680] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.613715] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.619609] ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM functions (mask: 0x79)
[    0.627404] Low-power S0 idle used by default for system suspend
[    0.628021] ACPI: EC: interrupt unblocked
[    0.628023] ACPI: EC: event unblocked
[    0.628068] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.628070] ACPI: EC: GPE=0x6e
[    0.628071] ACPI: \_SB_.PC00.LPCB.EC__: Boot ECDT EC initialization complete
[    0.628073] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.629126] iommu: Default domain type: Translated
[    0.629126] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.629126] pps_core: LinuxPPS API ver. 1 registered
[    0.629126] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.629126] PTP clock support registered
[    0.629126] EDAC MC: Ver: 3.0.0
[    0.629348] efivars: Registered efivars operations
[    0.629348] NetLabel: Initializing
[    0.629348] NetLabel:  domain hash size = 128
[    0.629348] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.629348] NetLabel:  unlabeled traffic allowed by default
[    0.629348] PCI: Using ACPI for IRQ routing
[    0.654634] PCI: pci_cache_line_size set to 64 bytes
[    0.654809] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.654940] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.654941] e820: reserve RAM buffer [mem 0x8a7ed000-0x8bffffff]
[    0.654942] e820: reserve RAM buffer [mem 0x8afb6000-0x8bffffff]
[    0.654943] e820: reserve RAM buffer [mem 0x8f36f000-0x8fffffff]
[    0.654943] e820: reserve RAM buffer [mem 0x95000000-0x97ffffff]
[    0.654944] e820: reserve RAM buffer [mem 0x85f800000-0x85fffffff]
[    0.654960] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.654960] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.654960] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    0.654960] vgaarb: loaded
[    0.654960] clocksource: Switched to clocksource tsc-early
[    0.654960] VFS: Disk quotas dquot_6.6.0
[    0.654960] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.654960] AppArmor: AppArmor Filesystem Enabled
[    0.654960] pnp: PnP ACPI init
[    0.655291] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.655294] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.655348] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.655371] system 00:03: [io  0x1800-0x189f] could not be reserved
[    0.655373] system 00:03: [io  0x0800-0x087f] has been reserved
[    0.655375] system 00:03: [io  0x0880-0x08ff] has been reserved
[    0.655376] system 00:03: [io  0x0900-0x097f] has been reserved
[    0.655378] system 00:03: [io  0x0980-0x09ff] has been reserved
[    0.655380] system 00:03: [io  0x0a00-0x0a7f] has been reserved
[    0.655381] system 00:03: [io  0x0a80-0x0aff] has been reserved
[    0.655383] system 00:03: [io  0x0b00-0x0b7f] has been reserved
[    0.655384] system 00:03: [io  0x0b80-0x0bff] has been reserved
[    0.655386] system 00:03: [io  0x15e0-0x15ef] has been reserved
[    0.655387] system 00:03: [io  0x1600-0x167f] could not be reserved
[    0.655389] system 00:03: [io  0x1640-0x165f] could not be reserved
[    0.655391] system 00:03: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.655393] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.655395] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.655397] system 00:03: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.655399] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.655401] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.655861] pnp 00:04: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.655877] system 00:04: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.655879] system 00:04: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.655881] system 00:04: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.655882] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.655885] system 00:04: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.655886] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.655888] system 00:04: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.656227] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.656229] system 00:05: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.656231] system 00:05: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    0.656233] system 00:05: [mem 0xfe050000-0xfe0affff] has been reserved
[    0.656235] system 00:05: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    0.656236] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.656238] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.656240] system 00:05: [mem 0xfd000000-0xfd68ffff] has been reserved
[    0.656242] system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    0.656244] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.656458] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.656764] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.656766] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.656769] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.656771] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.656773] pnp 00:08: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656776] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656778] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656780] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656783] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656785] pnp 00:08: disabling [mem 0x000e0000-0x000e3fff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656787] pnp 00:08: disabling [mem 0x000e8000-0x000ebfff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656790] pnp 00:08: disabling [mem 0x000f0000-0x000fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656792] pnp 00:08: disabling [mem 0x00100000-0xa07fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.656794] pnp 00:08: disabling [mem 0x00000000-0x0009ffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656797] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656799] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656801] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656804] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656806] pnp 00:08: disabling [mem 0x000e0000-0x000e3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656808] pnp 00:08: disabling [mem 0x000e8000-0x000ebfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656811] pnp 00:08: disabling [mem 0x000f0000-0x000fffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656813] pnp 00:08: disabling [mem 0x00100000-0xa07fffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.656826] system 00:08: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.656828] system 00:08: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.657024] pnp: PnP ACPI: found 9 devices
[    0.662206] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.662243] NET: Registered PF_INET protocol family
[    0.662412] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.671475] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.671502] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.671630] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.671908] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.672053] TCP: Hash tables configured (established 262144 bind 65536)
[    0.672212] MPTCP token hash table entries: 32768 (order: 8, 786432 bytes, linear)
[    0.672297] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.672355] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.672410] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.672415] NET: Registered PF_XDP protocol family
[    0.672421] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.672430] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    0.672435] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    0.672447] pci 0000:00:07.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.672449] pci 0000:00:07.2: bridge window [io  0x5000-0x5fff]: assigned
[    0.672451] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    0.672879] pci 0000:00:1f.5: BAR 0 [mem 0xa0800000-0xa0800fff]: assigned
[    0.672893] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.672897] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.672901] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.672903] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    0.672907] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.672910] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.672914] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.672917] pci 0000:00:07.2:   bridge window [io  0x5000-0x5fff]
[    0.672920] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.672923] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.672928] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.672930] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.672931] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.672933] pci_bus 0000:00: resource 7 [mem 0xa0800000-0xbfffffff window]
[    0.672934] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.672936] pci_bus 0000:04: resource 1 [mem 0xbc200000-0xbc2fffff]
[    0.672938] pci_bus 0000:20: resource 0 [io  0x4000-0x4fff]
[    0.672940] pci_bus 0000:20: resource 1 [mem 0xb0000000-0xbc1fffff]
[    0.672941] pci_bus 0000:20: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.672943] pci_bus 0000:50: resource 0 [io  0x5000-0x5fff]
[    0.672944] pci_bus 0000:50: resource 1 [mem 0xa2000000-0xae1fffff]
[    0.672946] pci_bus 0000:50: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.675044] PCI: CLS 0 bytes, default 64
[    0.675153] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.675154] software IO TLB: mapped [mem 0x0000000085cb8000-0x0000000089cb8000] (64MB)
[    0.675173] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.675215] clocksource: Switched to clocksource tsc
[    0.675237] Trying to unpack rootfs image as initramfs...
[    0.675241] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.675475] Initialise system trusted keyrings
[    0.675498] Key type blacklist registered
[    0.675530] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.675534] zbud: loaded
[    0.675582] fuse: init (API version 7.41)
[    0.675671] integrity: Platform Keyring initialized
[    0.675674] integrity: Machine keyring initialized
[    0.684674] Key type asymmetric registered
[    0.684679] Asymmetric key parser 'x509' registered
[    0.783220] Freeing initrd memory: 38088K
[    0.785901] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.785951] io scheduler mq-deadline registered
[    0.794486] ledtrig-cpu: registered to indicate activity on CPUs
[    0.794720] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.794862] pcieport 0000:00:07.0: PME: Signaling with IRQ 121
[    0.794876] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.795126] pcieport 0000:00:07.2: PME: Signaling with IRQ 122
[    0.795138] pcieport 0000:00:07.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.795246] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.795358] Monitor-Mwait will be used to enter C-1 state
[    0.795363] Monitor-Mwait will be used to enter C-2 state
[    0.795366] Monitor-Mwait will be used to enter C-3 state
[    0.812490] thermal LNXTHERM:00: registered as thermal_zone0
[    0.812494] ACPI: thermal: Thermal Zone [THM0] (44 C)
[    0.812651] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.813459] hpet_acpi_add: no address or irqs in _CRS
[    0.813483] Linux agpgart interface v0.103
[    0.818171] tpm_tis IFX0785:00: 2.0 TPM (device-id 0x1B, rev-id 22)
[    0.838469] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.838812] i8042: Warning: Keylock active
[    0.840481] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.840485] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.840566] mousedev: PS/2 mouse device common for all mice
[    0.840655] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.842967] rtc_cmos rtc_cmos: registered as rtc0
[    0.843459] rtc_cmos rtc_cmos: setting system clock to 2026-11-12T20:06:59 UTC (1794514019)
[    0.843495] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    0.844012] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.844076] intel_pstate: Intel P-state driver initializing
[    0.844629] intel_pstate: HWP enabled
[    0.844796] efifb: probing for efifb
[    0.844802] efifb: framebuffer at 0x4000000000, using 9000k, total 9000k
[    0.844805] efifb: mode is 1920x1200x32, linelength=7680, pages=1
[    0.844807] efifb: scrolling: redraw
[    0.844808] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.846979] Console: switching to colour frame buffer device 240x75
[    0.849077] fb0: EFI VGA frame buffer device
[    0.849199] NET: Registered PF_INET6 protocol family
[    0.852246] Segment Routing with IPv6
[    0.852257] In-situ OAM (IOAM) with IPv6
[    0.852275] mip6: Mobile IPv6
[    0.852280] NET: Registered PF_PACKET protocol family
[    0.852301] mpls_gso: MPLS GSO support
[    0.852906] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.853224] microcode: Current revision: 0x000000be
[    0.853885] resctrl: L2 allocation detected
[    0.853901] IPI shorthand broadcast: enabled
[    0.854799] sched_clock: Marking stable (833446359, 20435436)->(918646644, -64764849)
[    0.854980] registered taskstats version 1
[    0.855043] Loading compiled-in X.509 certificates
[    0.870439] Loaded X.509 cert 'Build time autogenerated kernel key: 0a04fbb1322a405cf04cc828049b2bf54895c9d9'
[    0.871722] Demotion targets for Node 0: null
[    0.871869] Key type .fscrypt registered
[    0.871876] Key type fscrypt-provisioning registered
[    0.892238] Key type encrypted registered
[    0.892251] AppArmor: AppArmor sha256 policy hashing enabled
[    0.893233] integrity: Loading X.509 certificate: UEFI:db
[    0.893263] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    0.893283] integrity: Loading X.509 certificate: UEFI:db
[    0.893305] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
[    0.893321] integrity: Loading X.509 certificate: UEFI:db
[    0.893346] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.893363] integrity: Loading X.509 certificate: UEFI:db
[    0.893388] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.893406] integrity: Loading X.509 certificate: UEFI:db
[    0.893429] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.893449] integrity: Loading X.509 certificate: UEFI:db
[    0.893472] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.893490] integrity: Loading X.509 certificate: UEFI:db
[    0.893512] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    0.895909] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
[    0.918388] integrity: Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    0.918418] ima: Allocated hash algorithm: sha256
[    0.966032] evm: Initialising EVM extended attributes:
[    0.966055] evm: security.selinux
[    0.966065] evm: security.SMACK64 (disabled)
[    0.966075] evm: security.SMACK64EXEC (disabled)
[    0.966086] evm: security.SMACK64TRANSMUTE (disabled)
[    0.966097] evm: security.SMACK64MMAP (disabled)
[    0.966099] audit: type=1807 audit(1794514019.620:2): action=measure func=KEXEC_KERNEL_CHECK res=1
[    0.966108] evm: security.apparmor
[    0.966109] evm: security.ima
[    0.966111] evm: security.capability
[    0.966134] audit: type=1807 audit(1794514019.620:3): action=measure func=MODULE_CHECK res=1
[    0.966143] evm: HMAC attrs: 0x1
[    0.968824] RAS: Correctable Errors collector initialized.
[    0.978822] Lockdown: swapper/0: hibernation is restricted; see man kernel_lockdown.7
[    0.980417] clk: Disabling unused clocks
[    0.982205] PM: genpd: Disabling unused power domains
[    0.991658] Freeing unused decrypted memory: 2028K
[    0.993119] Freeing unused kernel image (initmem) memory: 4176K
[    0.994052] Write protecting the kernel read-only data: 28672k
[    0.995200] Freeing unused kernel image (rodata/data gap) memory: 456K
[    1.002160] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.003103] Run /init as init process
[    1.004035]   with arguments:
[    1.004036]     /init
[    1.004036]   with environment:
[    1.004037]     HOME=/
[    1.004037]     TERM=linux
[    1.126351] cryptd: max_cpu_qlen set to 1000
[    1.159140] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    1.174445] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    1.176179] nvme nvme0: pci function 0000:04:00.0
[    1.204263] ACPI: bus type drm_connector registered
[    1.231497] nvme nvme0: 8/0/0 default/read/poll queues
[    1.237095]  nvme0n1: p1 p2 p3
[    1.266803] AES CTR mode by8 optimization enabled
[    1.436330] psmouse serio1: trackpoint: Elan TrackPoint firmware: 0x92, buttons: 3/3
[    1.450152] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/serio1/input/input2
[    1.680269] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    1.681305] i915 0000:00:02.0: [drm] Found TIGERLAKE/UY (device ID 9a49) display version 12.00 stepping C0
[    1.682716] Console: switching to colour dummy device 80x25
[    1.682733] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.682771] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.683143] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=mem
[    1.683767] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_12.bin (v2.12)
[    1.700804] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    1.700949] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[    1.718456] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[    1.720802] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.721065] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    1.729367] fbcon: i915drmfb (fb0) is primary device
[    1.767828] Console: switching to colour frame buffer device 240x75
[    1.786127] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.427167] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    2.427190] device-mapper: uevent: version 1.0.3
[    2.427262] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    7.078606] Lockdown: resume: hibernation is restricted; see man kernel_lockdown.7
[    7.218524] EXT4-fs (dm-1): mounted filesystem 0fb5bb25-d0f6-48a2-9840-a6cdefe4c6ce ro with ordered data mode. Quota mode: none.
[    7.269046] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[    7.313285] systemd[1]: Inserted module 'autofs4'
[    7.446299] systemd[1]: systemd 257.13-1~deb13u1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    7.448152] systemd[1]: Detected architecture x86-64.
[    7.450102] systemd[1]: Hostname set to <arabella>.
[    7.450916] Lockdown: systemd: /dev/mem,kmem,port is restricted; see man kernel_lockdown.7
[    7.678975] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.780896] systemd[1]: Queued start job for default target graphical.target.
[    7.817679] systemd[1]: Created slice machine.slice - Virtual Machine and Container Slice.
[    7.820674] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[    7.823691] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    7.828240] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[    7.831810] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[    7.835936] systemd[1]: Created slice user.slice - User and Session Slice.
[    7.839466] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    7.841182] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[    7.844023] systemd[1]: Expecting device dev-disk-by\x2duuid-16D4\x2dF1FA.device - /dev/disk/by-uuid/16D4-F1FA...
[    7.846523] systemd[1]: Expecting device dev-disk-by\x2duuid-77b93a3f\x2d987a\x2d4ed2\x2d9bd4\x2d68516dfad6dd.device - /dev/disk/by-uuid/77b93a3f-987a-4ed2-9bd4-68516dfad6dd...
[    7.849147] systemd[1]: Expecting device dev-disk-by\x2duuid-9e2dc7e8\x2d7b9e\x2d49cd\x2db100\x2d9bcdd698307d.device - /dev/disk/by-uuid/9e2dc7e8-7b9e-49cd-b100-9bcdd698307d...
[    7.852094] systemd[1]: Expecting device dev-mapper-arabella\x2d\x2dvg\x2dswap_1.device - /dev/mapper/arabella--vg-swap_1...
[    7.855127] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[    7.858234] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[    7.861397] systemd[1]: Reached target slices.target - Slice Units.
[    7.864474] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[    7.867137] systemd[1]: Reached target virt-guest-shutdown.target - libvirt guests shutdown target.
[    7.870422] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[    7.873793] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[    7.914623] systemd[1]: Listening on rpcbind.socket - RPCbind Server Activation Socket.
[    7.916015] systemd[1]: Listening on syslog.socket - Syslog Socket.
[    7.919827] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[    7.921993] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[    7.924538] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    7.927492] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[    7.930463] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    7.930477] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    7.930540] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    7.935624] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    7.939475] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    7.942348] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    7.944732] systemd[1]: run-lock.mount: Directory /run/lock to mount over is not empty, mounting anyway.
[    7.945350] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
[    7.952990] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    7.955613] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    7.958208] systemd[1]: auth-rpcgss-module.service - Kernel Module supporting RPCSEC_GSS skipped, unmet condition check ConditionPathExists=/etc/krb5.keytab
[    7.959083] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[    7.962958] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    7.966192] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.969207] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    7.972054] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[    7.976713] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[    7.979452] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    7.982524] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[    7.985405] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[    7.987523] systemd[1]: systemd-fsck-root.service - File System Check on Root Device skipped, unmet condition check ConditionPathExists=!/run/initramfs/fsck-root
[    7.987569] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    7.988680] systemd[1]: Starting systemd-journald.service - Journal Service...
[    7.994173] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    7.994904] pstore: Using crash dump compression: deflate
[    7.997779] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    8.002952] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[    8.027184] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    8.030742] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[    8.047888] pstore: Registered efi_pstore as persistent store backend
[    8.049134] systemd-journald[835]: Collecting audit messages is disabled.
[    8.055218] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    8.055551] loop: module loaded
[    8.059776] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[    8.061495] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[    8.064480] systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
[    8.067645] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[    8.070550] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[    8.072535] lp: driver loaded but no devices found
[    8.074336] systemd[1]: Started systemd-journald.service - Journal Service.
[    8.083700] ppdev: user-space parallel port driver
[    8.089760] EXT4-fs (dm-1): re-mounted 0fb5bb25-d0f6-48a2-9840-a6cdefe4c6ce r/w.
[    8.102446] i2c_dev: i2c /dev entries driver
[    8.133791] systemd-journald[835]: Received client request to flush runtime journal.
[    8.270547] Adding 999420k swap on /dev/mapper/arabella--vg-swap_1.  Priority:-2 extents:1 across:999420k SS
[    8.322088] Consider using thermal netlink events interface
[    8.327079] ACPI: AC: AC Adapter [AC] (off-line)
[    8.360343] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input4
[    8.360418] ACPI: button: Sleep Button [SLPB]
[    8.360463] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input5
[    8.360576] input: Intel HID events as /devices/platform/INTC1051:00/input/input6
[    8.360761] ACPI: button: Lid Switch [LID]
[    8.366749] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input7
[    8.366930] ACPI: button: Power Button [PWRB]
[    8.374439] EDAC igen6: v2.5.1
[    8.374906] hid: raw HID events driver (C) Jiri Kosina
[    8.419363] ACPI: bus type thunderbolt registered
[    8.420897] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    8.422927] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.423420] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    8.424841] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.437999] ACPI: battery: Slot [BAT0] (battery present)
[    8.483806] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.485116] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
[    8.486339] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
[    8.487569] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.488844] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.634745] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.636735] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.638624] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.640484] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.642350] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.642378] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.646478] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.709756] intel_pmc_core INT33A1:00:  initialized
[    8.726943] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    8.745074] ACPI: bus type USB registered
[    8.745103] usbcore: registered new interface driver usbfs
[    8.745111] usbcore: registered new interface driver hub
[    8.745122] usbcore: registered new device driver usb
[    8.760518] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    8.760910] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    8.778784] resource: resource sanity check: requesting [mem 0x00000000fedc0000-0x00000000fedcdfff], which spans more than pnp 00:04 [mem 0xfedc0000-0xfedc7fff]
[    8.778788] caller uncore_get_box_mmio_addr+0xe7/0x150 [intel_uncore] mapping multiple BARs
[    8.788117] Intel(R) Wireless WiFi driver for Linux
[    8.788245] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    8.791216] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000302 wfpm id 0x80000000
[    8.791275] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=0x351, rfid=0x10a100
[    8.791278] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[    8.800376] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
[    8.800812] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.800881] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.800933] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.800936] iwlwifi 0000:00:14.3: loaded firmware version 77.2753b721.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[    8.806730] Non-volatile memory driver v1.3
[    8.878082] iTCO_vendor_support: vendor-support=0
[    8.890622] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    8.891805] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    8.894640] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    8.895699] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    8.896786] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    8.896790] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.896842] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    8.896844] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.896846] usb usb1: Product: xHCI Host Controller
[    8.896847] usb usb1: Manufacturer: Linux 6.12.116+deb13-amd64 xhci-hcd
[    8.896848] usb usb1: SerialNumber: 0000:00:0d.0
[    8.897185] hub 1-0:1.0: USB hub found
[    8.908413] hub 1-0:1.0: 1 port detected
[    8.913923] input: ELAN0672:00 04F3:3187 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input9
[    8.913997] input: ELAN0672:00 04F3:3187 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input11
[    8.914052] hid-generic 0018:04F3:3187.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0672:00 04F3:3187] on i2c-ELAN0672:00
[    8.919732] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    8.919736] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.919737] usb usb2: Product: xHCI Host Controller
[    8.919739] usb usb2: Manufacturer: Linux 6.12.116+deb13-amd64 xhci-hcd
[    8.919740] usb usb2: SerialNumber: 0000:00:0d.0
[    8.920422] hub 2-0:1.0: USB hub found
[    8.931229] hub 2-0:1.0: 4 ports detected
[    8.935914] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    8.935916] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.935916] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.935917] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.935917] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    8.942549] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    8.942550] thinkpad_acpi: http://ibm-acpi.sf.net/
[    8.942551] thinkpad_acpi: ThinkPad BIOS N32ETA2W (1.78 ), EC N32HT57W
[    8.942552] thinkpad_acpi: Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS1FU00
[    8.948255] intel_rapl_msr: PL4 support detected.
[    8.951897] thinkpad_acpi: radio switch found; radios are enabled
[    8.953385] intel_rapl_common: Found RAPL domain package
[    8.954027] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    8.954033] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    8.954607] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    8.955222] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    8.955909] intel_rapl_common: Found RAPL domain core
[    8.956048] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    8.956051] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    8.956053] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.956112] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    8.956114] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.956116] usb usb3: Product: xHCI Host Controller
[    8.956117] usb usb3: Manufacturer: Linux 6.12.116+deb13-amd64 xhci-hcd
[    8.956118] usb usb3: SerialNumber: 0000:00:14.0
[    8.956372] hub 3-0:1.0: USB hub found
[    8.956414] hub 3-0:1.0: 12 ports detected
[    8.957324] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    8.980847] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    8.981693] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    8.981696] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.981696] usb usb4: Product: xHCI Host Controller
[    8.981697] usb usb4: Manufacturer: Linux 6.12.116+deb13-amd64 xhci-hcd
[    8.981698] usb usb4: SerialNumber: 0000:00:14.0
[    8.981721] intel_rapl_common: Found RAPL domain uncore
[    8.981724] intel_rapl_common: Found RAPL domain psys
[    8.982277] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.982910] hub 4-0:1.0: USB hub found
[    8.982947] hub 4-0:1.0: 4 ports detected
[    8.997979] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    9.053127] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    9.081384] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext4 subsystem
[    9.081881] EXT4-fs (nvme0n1p2): mounted filesystem 77b93a3f-987a-4ed2-9bd4-68516dfad6dd r/w without journal. Quota mode: none.
[    9.082947] intel_rapl_common: Found RAPL domain package
[    9.111284] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    9.142090] input: ELAN0672:00 04F3:3187 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input13
[    9.144067] input: ELAN0672:00 04F3:3187 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input15
[    9.146045] hid-multitouch 0018:04F3:3187.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0672:00 04F3:3187] on i2c-ELAN0672:00
[    9.162393] thinkpad_acpi: secondary fan control detected & enabled
[    9.181035] thinkpad_acpi: battery 1 registered (start 0, stop 100, behaviours: 0x7)
[    9.181046] ACPI: battery: new extension: ThinkPad Battery Extension
[    9.202034] audit: type=1400 audit(1794514027.856:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=1095 comm="apparmor_parser"
[    9.203129] audit: type=1400 audit(1794514027.856:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1100 comm="apparmor_parser"
[    9.203131] audit: type=1400 audit(1794514027.856:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1101 comm="apparmor_parser"
[    9.203132] audit: type=1400 audit(1794514027.856:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1096 comm="apparmor_parser"
[    9.203133] audit: type=1400 audit(1794514027.856:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1099 comm="apparmor_parser"
[    9.203228] audit: type=1400 audit(1794514027.856:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1097 comm="apparmor_parser"
[    9.212999] audit: type=1400 audit(1794514027.856:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1094 comm="apparmor_parser"
[    9.215200] audit: type=1400 audit(1794514027.860:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1105 comm="apparmor_parser"
[    9.215202] audit: type=1400 audit(1794514027.860:12): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=1107 comm="apparmor_parser"
[    9.215203] audit: type=1400 audit(1794514027.864:13): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1104 comm="apparmor_parser"
[    9.223616] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input12
[    9.232481] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    9.236193] iwlwifi 0000:00:14.3: Detected RF HR B5, rfid=0x10a100
[    9.303769] iwlwifi 0000:00:14.3: base HW address: 4c:77:cb:65:98:07
[    9.317390] typec port0: bound usb3-port5 (ops connector_ops [usbcore])
[    9.317409] typec port0: bound usb2-port2 (ops connector_ops [usbcore])
[    9.342524] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[    9.382578] usb 3-3: New USB device found, idVendor=06cb, idProduct=00fc, bcdDevice= 0.00
[    9.382583] usb 3-3: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    9.382585] usb 3-3: SerialNumber: d1150138a1b3
[    9.475280] nvme nvme0: using unchecked data buffer
[    9.516450] usb 3-4: new high-speed USB device number 3 using xhci_hcd
[    9.525148] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
[    9.525265] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    9.533238] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[    9.574414] block nvme0n1: No UUID available providing old NGUID
[    9.609997] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 5
[    9.610980] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
[    9.611896] sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4
[    9.612890] sof-audio-pci-intel-tgl 0000:00:1f.3: BT link detected in NHLT tables: 0x4
[    9.614066] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT tables: 4
[    9.618159] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware paths/files for ipc type 0:
[    9.618162] sof-audio-pci-intel-tgl 0000:00:1f.3:  Firmware file:     intel/sof/sof-tgl.ri
[    9.618163] sof-audio-pci-intel-tgl 0000:00:1f.3:  Topology file:     intel/sof-tplg/sof-hda-generic-4ch.tplg
[    9.618609] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    9.618613] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    9.618617] sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man header type 3 size 0x30
[    9.646589] NET: Registered PF_QIPCRTR protocol family
[    9.671068] usb 3-4: New USB device found, idVendor=174f, idProduct=2454, bcdDevice=10.29
[    9.671971] usb 3-4: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[    9.672989] usb 3-4: Product: Integrated Camera
[    9.673942] usb 3-4: Manufacturer: Sonix Technology Co., Ltd.
[    9.728320] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    9.729679] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    9.767787] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:1
[    9.769405] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent card not yet available, widget card binding deferred
[    9.796480] usb 3-10: new full-speed USB device number 4 using xhci_hcd
[    9.798874] snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC287: line_outs=2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    9.799860] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    9.800905] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    9.800906] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=0x0
[    9.800907] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[    9.800908] snd_hda_codec_realtek ehdaudio0D0:      Mic=0x19
[    9.852639] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
[    9.878394] input: sof-hda-dsp Mic as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input16
[    9.879447] input: sof-hda-dsp Headphone as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input17
[    9.880498] input: sof-hda-dsp HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input18
[    9.882928] input: sof-hda-dsp HDMI/DP,pcm=4 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input19
[    9.883010] input: sof-hda-dsp HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input20
[    9.933601] typec port1: bound usb3-port6 (ops connector_ops [usbcore])
[    9.934379] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[    9.934870] typec port1: bound usb2-port3 (ops connector_ops [usbcore])
[    9.936346] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    9.962165] mc: Linux media interface: v0.10
[   10.002540] videodev: Linux video capture interface: v2.00
[   10.043944] Bluetooth: Core ver 2.22
[   10.046950] NET: Registered PF_BLUETOOTH protocol family
[   10.048968] Bluetooth: HCI device and connection manager initialized
[   10.048972] Bluetooth: HCI socket layer initialized
[   10.052890] Bluetooth: L2CAP socket layer initialized
[   10.054735] Bluetooth: SCO socket layer initialized
[   10.055552] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0
[   10.095050] usb 3-4: Found UVC 1.00 device Integrated Camera (174f:2454)
[   10.110021] usb 3-4: Found UVC 1.00 device Integrated Camera (174f:2454)
[   10.119771] usbcore: registered new interface driver uvcvideo
[   10.131195] usbcore: registered new interface driver btusb
[   10.132123] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[   10.134140] Bluetooth: hci0: Device revision is 2
[   10.134142] Bluetooth: hci0: Secure boot is enabled
[   10.134143] Bluetooth: hci0: OTP lock is enabled
[   10.134144] Bluetooth: hci0: API lock is enabled
[   10.134144] Bluetooth: hci0: Debug lock is disabled
[   10.134145] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.135187] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[   10.142501] Bluetooth: hci0: Boot Address: 0x24800
[   10.142503] Bluetooth: hci0: Firmware Version: 132-3.24
[   10.171082] RPC: Registered named UNIX socket transport module.
[   10.172091] RPC: Registered udp transport module.
[   10.173088] RPC: Registered tcp transport module.
[   10.173976] RPC: Registered tcp-with-tls transport module.
[   10.173977] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.208882] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.209881] Bluetooth: BNEP filters: protocol multicast
[   10.210738] Bluetooth: BNEP socket layer initialized
[   12.219861] Bluetooth: hci0: Waiting for firmware download to complete
[   12.220761] Bluetooth: hci0: Firmware loaded in 2029624 usecs
[   12.221695] Bluetooth: hci0: Waiting for device to boot
[   12.236262] Bluetooth: hci0: Device booted in 14275 usecs
[   12.242705] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
[   12.244124] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.245272] Bluetooth: hci0: Firmware revision 0.4 build 132 week 3 2024
[   12.249293] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
[   12.314546] Bluetooth: MGMT ver 1.23
[   12.333315] NET: Registered PF_ALG protocol family
[   12.400807] Bluetooth: RFCOMM TTY layer initialized
[   12.401707] Bluetooth: RFCOMM socket layer initialized
[   12.402584] Bluetooth: RFCOMM ver 1.11

--wCGO9XF51TdiqsoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.12.117-1.log

[    0.000000] Linux version 6.12.117+deb13-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT_DYNAMIC Debian 6.12.117-1 (2026-11-12)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.12.117+deb13-amd64 root=/dev/mapper/arabella--vg-root ro
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008f36efff] usable
[    0.000000] BIOS-e820: [mem 0x000000008f36f000-0x000000009432efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009432f000-0x0000000094f2efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000094f2f000-0x0000000094ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000094fff000-0x0000000094ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000095000000-0x0000000098ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000099400000-0x00000000995fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000099e00000-0x00000000a07fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000085f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by Lenovo
[    0.000000] efi: ACPI=0x94ffe000 ACPI 2.0=0x94ffe014 TPMFinalLog=0x94d8f000 SMBIOS=0x910bb000 SMBIOS 3.0=0x910ae000 MEMATTR=0x8afb0018 ESRT=0x8afb6018 MOKvar=0x8f81a000 INITRD=0x6bcb6f98 RNG=0x94ffd018 TPMEventLog=0x94fed018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem95: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] Kernel is locked down from EFI Secure Boot; see man kernel_lockdown.7
[    0.000000] secureboot: Secure boot enabled
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ETA2W (1.78 ) 07/23/2026
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000011] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000019] last_pfn = 0x85f800 max_arch_pfn = 0x400000000
[    0.000023] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000025] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000486] last_pfn = 0x95000 max_arch_pfn = 0x400000000
[    0.012067] esrt: Reserving ESRT space from 0x000000008afb6018 to 0x000000008afb6280.
[    0.012075] e820: update [mem 0x8afb6000-0x8afb6fff] usable ==> reserved
[    0.012103] Using GB pages for direct mapping
[    0.012430] RAMDISK: [mem 0x67532000-0x69a63fff]
[    0.012487] ACPI: Early table checksum verification disabled
[    0.012490] ACPI: RSDP 0x0000000094FFE014 000024 (v02 LENOVO)
[    0.012494] ACPI: XSDT 0x0000000094FFC188 000114 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012501] ACPI: FACP 0x00000000910A0000 000114 (v06 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012506] ACPI: DSDT 0x0000000091065000 035147 (v02 LENOVO ICL      00000002      01000013)
[    0.012509] ACPI: FACS 0x0000000094D6E000 000040
[    0.012512] ACPI: SSDT 0x000000009114A000 00255D (v02 LENOVO CpuSsdt  00003000 INTL 20191018)
[    0.012516] ACPI: SSDT 0x0000000091149000 00059B (v02 LENOVO CtdpB    00001000 INTL 20191018)
[    0.012519] ACPI: SSDT 0x00000000910D0000 003F6F (v02 LENOVO DptfTabl 00001000 INTL 20191018)
[    0.012522] ACPI: SSDT 0x00000000910BD000 00060E (v02 LENOVO Tpm2Tabl 00001000 INTL 20191018)
[    0.012524] ACPI: TPM2 0x00000000910BC000 00004C (v04 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012527] ACPI: ECDT 0x00000000910A1000 000053 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012530] ACPI: HPET 0x000000009109F000 000038 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012533] ACPI: APIC 0x000000009109E000 00012C (v04 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012536] ACPI: SSDT 0x000000009109D000 0000F2 (v02 LENOVO PID1Ssdt 00000010 INTL 20191018)
[    0.012539] ACPI: SSDT 0x000000009109B000 0014F8 (v02 LENOVO ProjSsdt 00000010 INTL 20191018)
[    0.012542] ACPI: SSDT 0x0000000091062000 002926 (v02 LENOVO TglU_Rvp 00001000 INTL 20191018)
[    0.012544] ACPI: NHLT 0x0000000091060000 001B80 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012547] ACPI: SSDT 0x000000009105C000 002CD7 (v02 LENOVO SaSsdt   00003000 INTL 20191018)
[    0.012550] ACPI: SSDT 0x0000000091058000 003573 (v02 LENOVO IgfxSsdt 00003000 INTL 20191018)
[    0.012553] ACPI: SSDT 0x000000009104C000 00B6A1 (v02 LENOVO TcssSsdt 00001000 INTL 20191018)
[    0.012556] ACPI: LPIT 0x000000009104A000 0000CC (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012559] ACPI: WSMT 0x0000000091049000 000028 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012562] ACPI: SSDT 0x0000000091048000 00012A (v02 LENOVO TbtTypeC 00000000 INTL 20191018)
[    0.012565] ACPI: DBGP 0x0000000091047000 000034 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012568] ACPI: DBG2 0x0000000091046000 000054 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012570] ACPI: MSDM 0x0000000091045000 000055 (v03 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012573] ACPI: SSDT 0x000000009102E000 000B9C (v02 LENOVO UsbCTabl 00001000 INTL 20191018)
[    0.012576] ACPI: BATB 0x000000009102D000 00004A (v02 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012579] ACPI: MCFG 0x000000008F82A000 00003C (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012582] ACPI: SSDT 0x000000008F829000 000144 (v02 LENOVO ADebTabl 00001000 INTL 20191018)
[    0.012585] ACPI: BGRT 0x000000009102F000 000038 (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012588] ACPI: PTDT 0x000000008F828000 000986 (v00 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012591] ACPI: UEFI 0x00000000944C2000 00008A (v01 LENOVO TP-N32   00001780 PTEC 00000002)
[    0.012593] ACPI: FPDT 0x000000008F827000 000034 (v01 LENOVO TP-N32   00001780 PTEC 00001780)
[    0.012595] ACPI: Reserving FACP table memory at [mem 0x910a0000-0x910a0113]
[    0.012597] ACPI: Reserving DSDT table memory at [mem 0x91065000-0x9109a146]
[    0.012598] ACPI: Reserving FACS table memory at [mem 0x94d6e000-0x94d6e03f]
[    0.012598] ACPI: Reserving SSDT table memory at [mem 0x9114a000-0x9114c55c]
[    0.012599] ACPI: Reserving SSDT table memory at [mem 0x91149000-0x9114959a]
[    0.012600] ACPI: Reserving SSDT table memory at [mem 0x910d0000-0x910d3f6e]
[    0.012601] ACPI: Reserving SSDT table memory at [mem 0x910bd000-0x910bd60d]
[    0.012601] ACPI: Reserving TPM2 table memory at [mem 0x910bc000-0x910bc04b]
[    0.012602] ACPI: Reserving ECDT table memory at [mem 0x910a1000-0x910a1052]
[    0.012603] ACPI: Reserving HPET table memory at [mem 0x9109f000-0x9109f037]
[    0.012603] ACPI: Reserving APIC table memory at [mem 0x9109e000-0x9109e12b]
[    0.012604] ACPI: Reserving SSDT table memory at [mem 0x9109d000-0x9109d0f1]
[    0.012605] ACPI: Reserving SSDT table memory at [mem 0x9109b000-0x9109c4f7]
[    0.012605] ACPI: Reserving SSDT table memory at [mem 0x91062000-0x91064925]
[    0.012606] ACPI: Reserving NHLT table memory at [mem 0x91060000-0x91061b7f]
[    0.012607] ACPI: Reserving SSDT table memory at [mem 0x9105c000-0x9105ecd6]
[    0.012608] ACPI: Reserving SSDT table memory at [mem 0x91058000-0x9105b572]
[    0.012608] ACPI: Reserving SSDT table memory at [mem 0x9104c000-0x910576a0]
[    0.012609] ACPI: Reserving LPIT table memory at [mem 0x9104a000-0x9104a0cb]
[    0.012610] ACPI: Reserving WSMT table memory at [mem 0x91049000-0x91049027]
[    0.012610] ACPI: Reserving SSDT table memory at [mem 0x91048000-0x91048129]
[    0.012611] ACPI: Reserving DBGP table memory at [mem 0x91047000-0x91047033]
[    0.012612] ACPI: Reserving DBG2 table memory at [mem 0x91046000-0x91046053]
[    0.012612] ACPI: Reserving MSDM table memory at [mem 0x91045000-0x91045054]
[    0.012613] ACPI: Reserving SSDT table memory at [mem 0x9102e000-0x9102eb9b]
[    0.012614] ACPI: Reserving BATB table memory at [mem 0x9102d000-0x9102d049]
[    0.012614] ACPI: Reserving MCFG table memory at [mem 0x8f82a000-0x8f82a03b]
[    0.012615] ACPI: Reserving SSDT table memory at [mem 0x8f829000-0x8f829143]
[    0.012616] ACPI: Reserving BGRT table memory at [mem 0x9102f000-0x9102f037]
[    0.012617] ACPI: Reserving PTDT table memory at [mem 0x8f828000-0x8f828985]
[    0.012617] ACPI: Reserving UEFI table memory at [mem 0x944c2000-0x944c2089]
[    0.012618] ACPI: Reserving FPDT table memory at [mem 0x8f827000-0x8f827033]
[    0.013108] No NUMA configuration found
[    0.013109] Faking a node at [mem 0x0000000000000000-0x000000085f7fffff]
[    0.013118] NODE_DATA(0) allocated [mem 0x85f7d5680-0x85f7fffff]
[    0.013337] Zone ranges:
[    0.013338]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013340]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013341]   Normal   [mem 0x0000000100000000-0x000000085f7fffff]
[    0.013342]   Device   empty
[    0.013343] Movable zone start for each node
[    0.013345] Early memory node ranges
[    0.013345]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.013347]   node   0: [mem 0x0000000000100000-0x000000008f36efff]
[    0.013348]   node   0: [mem 0x0000000094fff000-0x0000000094ffffff]
[    0.013349]   node   0: [mem 0x0000000100000000-0x000000085f7fffff]
[    0.013352] Initmem setup node 0 [mem 0x0000000000001000-0x000000085f7fffff]
[    0.013358] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013387] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.016848] On node 0, zone DMA32: 23696 pages in unavailable ranges
[    0.017196] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.017210] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.017269] Reserving Intel graphics memory at [mem 0x9c800000-0xa07fffff]
[    0.018094] ACPI: PM-Timer IO Port: 0x1808
[    0.018103] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.018104] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.018105] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.018106] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.018106] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.018107] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.018108] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.018108] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.018109] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.018110] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.018110] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.018111] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.018112] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.018112] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.018113] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.018114] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.018232] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.018235] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.018237] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.018241] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.018243] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.018252] e820: update [mem 0x8a7ed000-0x8a87dfff] usable ==> reserved
[    0.018263] TSC deadline timer available
[    0.018267] CPU topo: Max. logical packages:   1
[    0.018268] CPU topo: Max. logical dies:       1
[    0.018269] CPU topo: Max. dies per package:   1
[    0.018272] CPU topo: Max. threads per core:   2
[    0.018273] CPU topo: Num. cores per package:     4
[    0.018274] CPU topo: Num. threads per package:   8
[    0.018274] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.018287] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.018288] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.018290] PM: hibernation: Registered nosave memory: [mem 0x8a7ed000-0x8a87dfff]
[    0.018291] PM: hibernation: Registered nosave memory: [mem 0x8afb6000-0x8afb6fff]
[    0.018293] PM: hibernation: Registered nosave memory: [mem 0x8f36f000-0x94ffefff]
[    0.018294] PM: hibernation: Registered nosave memory: [mem 0x95000000-0xffffffff]
[    0.018295] [mem 0xa0800000-0xfed1ffff] available for PCI devices
[    0.018297] Booting paravirtualized kernel on bare hardware
[    0.018299] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.024543] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.025113] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.025118] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.025121] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
[    0.025137] Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.117+deb13-amd64 root=/dev/mapper/arabella--vg-root ro
[    0.027917] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.029218] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.029339] Fallback order for Node 0: 0 
[    0.029342] Built 1 zonelists, mobility grouping on.  Total pages: 8317710
[    0.029343] Policy zone: Normal
[    0.029350] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.029354] software IO TLB: area num 8.
[    0.049477] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.057638] ftrace: allocating 45297 entries in 180 pages
[    0.057640] ftrace: allocated 180 pages with 4 groups
[    0.058428] Dynamic Preempt: voluntary
[    0.058487] rcu: Preemptible hierarchical RCU implementation.
[    0.058488] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.058489] 	Trampoline variant of Tasks RCU enabled.
[    0.058490] 	Rude variant of Tasks RCU enabled.
[    0.058490] 	Tracing variant of Tasks RCU enabled.
[    0.058491] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.058492] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.058500] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.058502] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.058503] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.063395] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.063881] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.064404] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.064474] Console: colour dummy device 80x25
[    0.064477] printk: legacy console [tty0] enabled
[    0.064790] ACPI: Core revision 20240827
[    0.065084] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.065246] APIC: Switch to symmetric I/O mode setup
[    0.070117] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.090435] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.090444] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    0.090473] x86/cpu: VMX (outside TXT) disabled by BIOS
[    0.090483] CPU0: Thermal monitoring enabled (TM1)
[    0.090486] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.090643] CET detected: Indirect Branch Tracking enabled
[    0.090646] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.090649] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.090654] process: using mwait in idle threads
[    0.090658] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.090662] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
[    0.090665] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.090667] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.090672] Spectre V2 : Enabling IBPB for BPF
[    0.090675] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.090679] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.090684] GDS: Mitigation: Microcode
[    0.090686] active return thunk: its_return_thunk
[    0.090691] ITS: Mitigation: Aligned branch/return thunks
[    0.090700] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.090704] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.090706] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.090708] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.090711] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.090713] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.090715] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.090718] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.090721] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.090724] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.090726] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.090729] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.090731] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.090734] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.090736] x86/fpu: Enabled xstate features 0xae7, context size is 2456 bytes, using 'compacted' format.
[    0.090771] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0258000 - 0xffffffffc0258fff PFN 100217
[    0.094441] Freeing SMP alternatives memory: 40K
[    0.094441] pid_max: default: 32768 minimum: 301
[    0.094441] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.094441] landlock: Up and running.
[    0.094441] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.094441] AppArmor: AppArmor initialized
[    0.094441] TOMOYO Linux initialized
[    0.094441] LSM support for eBPF active
[    0.094441] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.094441] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.094441] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[    0.094441] Performance Events: PEBS fmt4+-baseline, Icelake events, AnyThread deprecated, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.094441] ... version:                5
[    0.094441] ... bit width:              48
[    0.094441] ... generic registers:      8
[    0.094441] ... value mask:             0000ffffffffffff
[    0.094441] ... max period:             00007fffffffffff
[    0.094441] ... fixed-purpose events:   4
[    0.094441] ... event mask:             0001000f000000ff
[    0.094441] signal: max sigframe size: 3632
[    0.094441] Estimated ratio of average max frequency by base frequency (times 1024): 1499
[    0.094441] rcu: Hierarchical SRCU implementation.
[    0.094441] rcu: 	Max phase no-delay instances is 1000.
[    0.094441] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.094441] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.094441] smp: Bringing up secondary CPUs ...
[    0.094441] smpboot: x86: Booting SMP configuration:
[    0.094441] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.098488] smp: Brought up 1 node, 8 CPUs
[    0.098488] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[    0.130478] node 0 deferred pages initialised in 28ms
[    0.131105] Memory: 32419156K/33270840K available (16384K kernel code, 2499K rwdata, 11832K rodata, 4180K init, 4880K bss, 841580K reserved, 0K cma-reserved)
[    0.131201] devtmpfs: initialized
[    0.131201] x86/mm: Memory block size: 128MB
[    0.134685] ACPI: PM: Registering ACPI NVS region [mem 0x9432f000-0x94f2efff] (12582912 bytes)
[    0.134685] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.134685] pinctrl core: initialized pinctrl subsystem
[    0.135223] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.135667] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.136004] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.136342] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.136354] audit: initializing netlink subsys (disabled)
[    0.136365] audit: type=2000 audit(1794514170.044:1): state=initialized audit_enabled=0 res=1
[    0.136365] thermal_sys: Registered thermal governor 'fair_share'
[    0.136365] thermal_sys: Registered thermal governor 'bang_bang'
[    0.136365] thermal_sys: Registered thermal governor 'step_wise'
[    0.136365] thermal_sys: Registered thermal governor 'user_space'
[    0.136365] thermal_sys: Registered thermal governor 'power_allocator'
[    0.136365] cpuidle: using governor ladder
[    0.136365] cpuidle: using governor menu
[    0.139710] efi: Freeing EFI boot services memory: 117060K
[    0.139716] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.139719] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.140259] PCI: ECAM [mem 0xc0000000-0xc79fffff] (base 0xc0000000) for domain 0000 [bus 00-79]
[    0.140277] PCI: Using configuration type 1 for base access
[    0.140358] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.140358] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.140358] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.140358] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.140358] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.140358] ACPI: Added _OSI(Module Device)
[    0.140358] ACPI: Added _OSI(Processor Device)
[    0.140358] ACPI: Added _OSI(Processor Aggregator Device)
[    0.206441] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.216988] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.218002] ACPI: EC: EC started
[    0.218004] ACPI: EC: interrupt blocked
[    0.218588] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.218590] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.234790] ACPI: Dynamic OEM Table Load:
[    0.234799] ACPI: SSDT 0xFFFF88BD80E90000 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[    0.235440] ACPI: Dynamic OEM Table Load:
[    0.235446] ACPI: SSDT 0xFFFF88BD80E8C000 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[    0.236050] ACPI: Dynamic OEM Table Load:
[    0.236055] ACPI: SSDT 0xFFFF88BD81C79000 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[    0.236604] ACPI: Dynamic OEM Table Load:
[    0.236609] ACPI: SSDT 0xFFFF88BD80E92C00 00028B (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[    0.237277] ACPI: Dynamic OEM Table Load:
[    0.237282] ACPI: SSDT 0xFFFF88BD80E99000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[    0.237922] ACPI: Dynamic OEM Table Load:
[    0.237927] ACPI: SSDT 0xFFFF88BD80E89000 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[    0.238441] ACPI: Dynamic OEM Table Load:
[    0.238441] ACPI: SSDT 0xFFFF88BD80E8B000 0004D4 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[    0.238441] ACPI: Dynamic OEM Table Load:
[    0.238441] ACPI: SSDT 0xFFFF88BD80E8C800 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[    0.238590] ACPI: Interpreter enabled
[    0.238633] ACPI: PM: (supports S0 S4 S5)
[    0.238634] ACPI: Using IOAPIC for interrupt routing
[    0.238668] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238670] PCI: Ignoring E820 reservations for host bridge windows
[    0.238997] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.239800] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.241335] ACPI: \_SB_.PC00.LPCB.EC__.PUBS: New power resource
[    0.244528] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.BTPR: New power resource
[    0.245400] ACPI: \_SB_.PC00.RP01.PXP_: New power resource
[    0.245589] ACPI: \_SB_.PC00.RP01.PXSX.MRST: New power resource
[    0.245600] ACPI: \_SB_.PC00.RP01.PXSX.DRST: New power resource
[    0.246281] ACPI: \_SB_.PC00.RP05.PXP_: New power resource
[    0.249867] ACPI: \_SB_.PC00.SAT0.VOL0.V0PR: New power resource
[    0.249930] ACPI: \_SB_.PC00.SAT0.VOL1.V1PR: New power resource
[    0.249988] ACPI: \_SB_.PC00.SAT0.VOL2.V2PR: New power resource
[    0.251859] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.252022] ACPI: \_SB_.PC00.TBT0: New power resource
[    0.252050] ACPI: \_SB_.PC00.TBT1: New power resource
[    0.252071] ACPI: \_SB_.PC00.D3C_: New power resource
[    0.479876] ACPI: \PIN_: New power resource
[    0.479889] ACPI: \PINP: New power resource
[    0.480184] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-79])
[    0.480189] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.484044] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.491525] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    0.491527] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.495003] PCI host bridge to bus 0000:00
[    0.495006] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.495009] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.495010] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.495012] pci_bus 0000:00: root bus resource [mem 0xa0800000-0xbfffffff window]
[    0.495014] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.495016] pci_bus 0000:00: root bus resource [bus 00-79]
[    0.607121] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000 conventional PCI endpoint
[    0.607421] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.607429] pci 0000:00:02.0: BAR 0 [mem 0x603c000000-0x603cffffff 64bit]
[    0.607435] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.607439] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    0.607453] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.607456] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.607480] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.607482] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.607487] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.607488] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.607623] pci 0000:00:04.0: [8086:9a03] type 00 class 0x118000 conventional PCI endpoint
[    0.607639] pci 0000:00:04.0: BAR 0 [mem 0x603d180000-0x603d19ffff 64bit]
[    0.607899] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400 PCIe Root Port
[    0.607915] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.607920] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.607970] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.607995] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.608414] pci 0000:00:07.0: [8086:9a25] type 01 class 0x060400 PCIe Root Port
[    0.608435] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.608440] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.608448] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.608471] pci 0000:00:07.0: Overriding RP PIO Log Size to 4
[    0.608526] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.608963] pci 0000:00:07.2: [8086:9a27] type 01 class 0x060400 PCIe Root Port
[    0.608984] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.608989] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.608997] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.609020] pci 0000:00:07.2: Overriding RP PIO Log Size to 4
[    0.609073] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.609570] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000 conventional PCI endpoint
[    0.609578] pci 0000:00:08.0: BAR 0 [mem 0x603d1da000-0x603d1dafff 64bit]
[    0.609676] pci 0000:00:0a.0: [8086:9a0d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.609684] pci 0000:00:0a.0: BAR 0 [mem 0x603d1c0000-0x603d1c7fff 64bit]
[    0.609703] pci 0000:00:0a.0: enabling Extended Tags
[    0.609826] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330 conventional PCI endpoint
[    0.609839] pci 0000:00:0d.0: BAR 0 [mem 0x603d1b0000-0x603d1bffff 64bit]
[    0.609892] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.610122] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340 conventional PCI endpoint
[    0.610133] pci 0000:00:0d.2: BAR 0 [mem 0x603d140000-0x603d17ffff 64bit]
[    0.610141] pci 0000:00:0d.2: BAR 2 [mem 0x603d1d9000-0x603d1d9fff 64bit]
[    0.610175] pci 0000:00:0d.2: supports D1 D2
[    0.610176] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.610242] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340 conventional PCI endpoint
[    0.610253] pci 0000:00:0d.3: BAR 0 [mem 0x603d100000-0x603d13ffff 64bit]
[    0.610261] pci 0000:00:0d.3: BAR 2 [mem 0x603d1d8000-0x603d1d8fff 64bit]
[    0.610295] pci 0000:00:0d.3: supports D1 D2
[    0.610296] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.610578] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330 conventional PCI endpoint
[    0.610620] pci 0000:00:14.0: BAR 0 [mem 0x603d1a0000-0x603d1affff 64bit]
[    0.610726] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.610998] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000 conventional PCI endpoint
[    0.611033] pci 0000:00:14.2: BAR 0 [mem 0x603d1d0000-0x603d1d3fff 64bit]
[    0.611049] pci 0000:00:14.2: BAR 2 [mem 0x603d1d7000-0x603d1d7fff 64bit]
[    0.611594] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.611987] pci 0000:00:14.3: BAR 0 [mem 0x603d1cc000-0x603d1cffff 64bit]
[    0.613985] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.615912] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000 conventional PCI endpoint
[    0.616809] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.620637] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000 conventional PCI endpoint
[    0.620666] pci 0000:00:16.0: BAR 0 [mem 0x603d1d5000-0x603d1d5fff 64bit]
[    0.620764] pci 0000:00:16.0: PME# supported from D3hot
[    0.621218] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100 conventional PCI endpoint
[    0.621601] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380 conventional PCI endpoint
[    0.621671] pci 0000:00:1f.3: BAR 0 [mem 0x603d1c8000-0x603d1cbfff 64bit]
[    0.621771] pci 0000:00:1f.3: BAR 4 [mem 0x603d000000-0x603d0fffff 64bit]
[    0.621932] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.622204] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500 conventional PCI endpoint
[    0.622260] pci 0000:00:1f.4: BAR 0 [mem 0x603d1d4000-0x603d1d40ff 64bit]
[    0.622289] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.622531] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000 conventional PCI endpoint
[    0.622556] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.622734] pci 0000:04:00.0: [1344:5407] type 00 class 0x010802 PCIe Endpoint
[    0.622746] pci 0000:04:00.0: BAR 0 [mem 0xbc200000-0xbc203fff 64bit]
[    0.622772] pci 0000:04:00.0: enabling Extended Tags
[    0.622922] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.622955] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.622989] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.628838] ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM functions (mask: 0x79)
[    0.636348] Low-power S0 idle used by default for system suspend
[    0.636962] ACPI: EC: interrupt unblocked
[    0.636964] ACPI: EC: event unblocked
[    0.637008] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.637010] ACPI: EC: GPE=0x6e
[    0.637011] ACPI: \_SB_.PC00.LPCB.EC__: Boot ECDT EC initialization complete
[    0.637013] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.637084] iommu: Default domain type: Translated
[    0.637084] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.637084] pps_core: LinuxPPS API ver. 1 registered
[    0.637084] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.637084] PTP clock support registered
[    0.637084] EDAC MC: Ver: 3.0.0
[    0.637084] efivars: Registered efivars operations
[    0.637084] NetLabel: Initializing
[    0.637084] NetLabel:  domain hash size = 128
[    0.637084] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.637084] NetLabel:  unlabeled traffic allowed by default
[    0.637084] PCI: Using ACPI for IRQ routing
[    0.659141] PCI: pci_cache_line_size set to 64 bytes
[    0.659312] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.659444] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.659445] e820: reserve RAM buffer [mem 0x8a7ed000-0x8bffffff]
[    0.659446] e820: reserve RAM buffer [mem 0x8afb6000-0x8bffffff]
[    0.659447] e820: reserve RAM buffer [mem 0x8f36f000-0x8fffffff]
[    0.659447] e820: reserve RAM buffer [mem 0x95000000-0x97ffffff]
[    0.659448] e820: reserve RAM buffer [mem 0x85f800000-0x85fffffff]
[    0.659463] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.659463] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.659463] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    0.659463] vgaarb: loaded
[    0.659463] clocksource: Switched to clocksource tsc-early
[    0.659463] VFS: Disk quotas dquot_6.6.0
[    0.659463] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.659463] AppArmor: AppArmor Filesystem Enabled
[    0.659463] pnp: PnP ACPI init
[    0.660061] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.660063] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.660117] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.660140] system 00:03: [io  0x1800-0x189f] could not be reserved
[    0.660142] system 00:03: [io  0x0800-0x087f] has been reserved
[    0.660144] system 00:03: [io  0x0880-0x08ff] has been reserved
[    0.660145] system 00:03: [io  0x0900-0x097f] has been reserved
[    0.660147] system 00:03: [io  0x0980-0x09ff] has been reserved
[    0.660149] system 00:03: [io  0x0a00-0x0a7f] has been reserved
[    0.660150] system 00:03: [io  0x0a80-0x0aff] has been reserved
[    0.660152] system 00:03: [io  0x0b00-0x0b7f] has been reserved
[    0.660153] system 00:03: [io  0x0b80-0x0bff] has been reserved
[    0.660155] system 00:03: [io  0x15e0-0x15ef] has been reserved
[    0.660156] system 00:03: [io  0x1600-0x167f] could not be reserved
[    0.660158] system 00:03: [io  0x1640-0x165f] could not be reserved
[    0.660160] system 00:03: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.660162] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.660164] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.660165] system 00:03: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.660167] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.660169] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.660609] pnp 00:04: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.660624] system 00:04: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.660626] system 00:04: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.660628] system 00:04: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.660629] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.660631] system 00:04: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.660633] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.660635] system 00:04: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.660964] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.660966] system 00:05: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.660968] system 00:05: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    0.660970] system 00:05: [mem 0xfe050000-0xfe0affff] has been reserved
[    0.660972] system 00:05: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    0.660973] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.660975] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.660978] system 00:05: [mem 0xfd000000-0xfd68ffff] has been reserved
[    0.660980] system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    0.660982] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.661187] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.661487] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.661490] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.661492] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.661494] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.661497] pnp 00:08: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661499] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661502] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661504] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661506] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661508] pnp 00:08: disabling [mem 0x000e0000-0x000e3fff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661511] pnp 00:08: disabling [mem 0x000e8000-0x000ebfff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661513] pnp 00:08: disabling [mem 0x000f0000-0x000fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661515] pnp 00:08: disabling [mem 0x00100000-0xa07fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.661517] pnp 00:08: disabling [mem 0x00000000-0x0009ffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661520] pnp 00:08: disabling [mem 0x000c0000-0x000c3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661522] pnp 00:08: disabling [mem 0x000c8000-0x000cbfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661525] pnp 00:08: disabling [mem 0x000d0000-0x000d3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661527] pnp 00:08: disabling [mem 0x000d8000-0x000dbfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661529] pnp 00:08: disabling [mem 0x000e0000-0x000e3fff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661532] pnp 00:08: disabling [mem 0x000e8000-0x000ebfff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661534] pnp 00:08: disabling [mem 0x000f0000-0x000fffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661536] pnp 00:08: disabling [mem 0x00100000-0xa07fffff disabled] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.661549] system 00:08: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.661551] system 00:08: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.661741] pnp: PnP ACPI: found 9 devices
[    0.666896] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.666934] NET: Registered PF_INET protocol family
[    0.667103] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.675832] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.675859] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.676011] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.676332] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.676483] TCP: Hash tables configured (established 262144 bind 65536)
[    0.676687] MPTCP token hash table entries: 32768 (order: 8, 786432 bytes, linear)
[    0.676780] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.676839] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.676888] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.676895] NET: Registered PF_XDP protocol family
[    0.676900] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.676908] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    0.676912] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    0.676916] pci 0000:00:07.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.676918] pci 0000:00:07.2: bridge window [io  0x5000-0x5fff]: assigned
[    0.676920] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    0.677350] pci 0000:00:1f.5: BAR 0 [mem 0xa0800000-0xa0800fff]: assigned
[    0.677380] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.677383] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.677388] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.677390] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    0.677394] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.677397] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.677402] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.677404] pci 0000:00:07.2:   bridge window [io  0x5000-0x5fff]
[    0.677408] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.677411] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.677416] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.677418] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.677419] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.677421] pci_bus 0000:00: resource 7 [mem 0xa0800000-0xbfffffff window]
[    0.677422] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.677424] pci_bus 0000:04: resource 1 [mem 0xbc200000-0xbc2fffff]
[    0.677426] pci_bus 0000:20: resource 0 [io  0x4000-0x4fff]
[    0.677428] pci_bus 0000:20: resource 1 [mem 0xb0000000-0xbc1fffff]
[    0.677429] pci_bus 0000:20: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.677431] pci_bus 0000:50: resource 0 [io  0x5000-0x5fff]
[    0.677432] pci_bus 0000:50: resource 1 [mem 0xa2000000-0xae1fffff]
[    0.677434] pci_bus 0000:50: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.677984] PCI: CLS 0 bytes, default 64
[    0.678113] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.678114] software IO TLB: mapped [mem 0x0000000085cb8000-0x0000000089cb8000] (64MB)
[    0.678132] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.678159] clocksource: Switched to clocksource tsc
[    0.678165] Trying to unpack rootfs image as initramfs...
[    0.678180] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.678404] Initialise system trusted keyrings
[    0.678425] Key type blacklist registered
[    0.678469] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.678473] zbud: loaded
[    0.678520] fuse: init (API version 7.41)
[    0.678589] integrity: Platform Keyring initialized
[    0.678592] integrity: Machine keyring initialized
[    0.687857] Key type asymmetric registered
[    0.687863] Asymmetric key parser 'x509' registered
[    0.785565] Freeing initrd memory: 38088K
[    0.788548] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.788573] io scheduler mq-deadline registered
[    0.797063] ledtrig-cpu: registered to indicate activity on CPUs
[    0.797271] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.797412] pcieport 0000:00:07.0: PME: Signaling with IRQ 121
[    0.797426] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.797662] pcieport 0000:00:07.2: PME: Signaling with IRQ 122
[    0.797675] pcieport 0000:00:07.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.797785] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.797900] Monitor-Mwait will be used to enter C-1 state
[    0.797905] Monitor-Mwait will be used to enter C-2 state
[    0.797909] Monitor-Mwait will be used to enter C-3 state
[    0.816597] thermal LNXTHERM:00: registered as thermal_zone0
[    0.816600] ACPI: thermal: Thermal Zone [THM0] (45 C)
[    0.816818] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.817503] hpet_acpi_add: no address or irqs in _CRS
[    0.817534] Linux agpgart interface v0.103
[    0.822027] tpm_tis IFX0785:00: 2.0 TPM (device-id 0x1B, rev-id 22)
[    0.841608] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.841993] i8042: Warning: Keylock active
[    0.843774] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.843778] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.843927] mousedev: PS/2 mouse device common for all mice
[    0.844018] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.846661] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.846725] rtc_cmos rtc_cmos: registered as rtc0
[    0.847240] rtc_cmos rtc_cmos: setting system clock to 2026-11-12T20:09:31 UTC (1794514171)
[    0.847285] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    0.847690] intel_pstate: Intel P-state driver initializing
[    0.848113] intel_pstate: HWP enabled
[    0.848287] efifb: probing for efifb
[    0.848296] efifb: framebuffer at 0x4000000000, using 9000k, total 9000k
[    0.848298] efifb: mode is 1920x1200x32, linelength=7680, pages=1
[    0.848300] efifb: scrolling: redraw
[    0.848302] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.848366] Console: switching to colour frame buffer device 240x75
[    0.851138] fb0: EFI VGA frame buffer device
[    0.851274] NET: Registered PF_INET6 protocol family
[    0.854627] Segment Routing with IPv6
[    0.854641] In-situ OAM (IOAM) with IPv6
[    0.854659] mip6: Mobile IPv6
[    0.854665] NET: Registered PF_PACKET protocol family
[    0.854756] mpls_gso: MPLS GSO support
[    0.855482] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.855593] microcode: Current revision: 0x000000be
[    0.855914] resctrl: L2 allocation detected
[    0.855929] IPI shorthand broadcast: enabled
[    0.856827] sched_clock: Marking stable (829873351, 26037657)->(920495334, -64584326)
[    0.857015] registered taskstats version 1
[    0.857075] Loading compiled-in X.509 certificates
[    0.869664] Loaded X.509 cert 'Build time autogenerated kernel key: 4789b66b7495bab1b6e248519cf1798f5b57e64d'
[    0.870785] Demotion targets for Node 0: null
[    0.871001] Key type .fscrypt registered
[    0.871008] Key type fscrypt-provisioning registered
[    0.884010] Key type encrypted registered
[    0.884022] AppArmor: AppArmor sha256 policy hashing enabled
[    0.884932] integrity: Loading X.509 certificate: UEFI:db
[    0.884954] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    0.884974] integrity: Loading X.509 certificate: UEFI:db
[    0.884991] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
[    0.885006] integrity: Loading X.509 certificate: UEFI:db
[    0.885028] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.885044] integrity: Loading X.509 certificate: UEFI:db
[    0.885064] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.885079] integrity: Loading X.509 certificate: UEFI:db
[    0.885098] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.885116] integrity: Loading X.509 certificate: UEFI:db
[    0.885135] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.885150] integrity: Loading X.509 certificate: UEFI:db
[    0.885170] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    0.887175] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
[    0.898047] integrity: Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    0.898082] ima: Allocated hash algorithm: sha256
[    0.946303] evm: Initialising EVM extended attributes:
[    0.946309] audit: type=1807 audit(1794514171.596:2): action=measure func=KEXEC_KERNEL_CHECK res=1
[    0.946326] evm: security.selinux
[    0.946328] evm: security.SMACK64 (disabled)
[    0.946352] audit: type=1807 audit(1794514171.596:3): action=measure func=MODULE_CHECK res=1
[    0.946362] evm: security.SMACK64EXEC (disabled)
[    0.946402] evm: security.SMACK64TRANSMUTE (disabled)
[    0.946413] evm: security.SMACK64MMAP (disabled)
[    0.946424] evm: security.apparmor
[    0.946436] evm: security.ima
[    0.946444] evm: security.capability
[    0.946454] evm: HMAC attrs: 0x1
[    0.949373] RAS: Correctable Errors collector initialized.
[    0.954499] Lockdown: swapper/0: hibernation is restricted; see man kernel_lockdown.7
[    0.955938] clk: Disabling unused clocks
[    0.957294] PM: genpd: Disabling unused power domains
[    0.972571] Freeing unused decrypted memory: 2028K
[    0.974488] Freeing unused kernel image (initmem) memory: 4180K
[    0.975829] Write protecting the kernel read-only data: 28672k
[    0.977464] Freeing unused kernel image (rodata/data gap) memory: 456K
[    0.991048] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.992476] Run /init as init process
[    0.993426]   with arguments:
[    0.993428]     /init
[    0.993428]   with environment:
[    0.993429]     HOME=/
[    0.993429]     TERM=linux
[    1.091378] ------------[ cut here ]------------
[    1.092538] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 - 0xffffffffc0477fff PFN 109c1f
[    1.093994] WARNING: CPU: 5 PID: 222 at arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
[    1.095730] Modules linked in:
[    1.097101] CPU: 5 UID: 0 PID: 222 Comm: (udev-worker) Not tainted 6.12.117+deb13-amd64 #1  Debian 6.12.117-1
[    1.098671] Hardware name: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ETA2W (1.78 ) 07/23/2026
[    1.100096] RIP: 0010:__change_page_attr_set_clr+0xf62/0xfb0
[    1.101357] Code: 09 ea e9 19 fa ff ff 48 8b 4c 24 10 49 89 d9 4c 89 d6 48 89 54 24 08 48 c7 c7 38 43 95 a6 c6 05 d1 fd d7 01 01 e8 9e 76 01 00 <0f> 0b 48 8b 54 24 08 e9 22 fc ff ff 80 3d ba fd d7 01 00 0f 85 15
[    1.102928] RSP: 0018:ffffd02d40557648 EFLAGS: 00010286
[    1.104241] RAX: 0000000000000000 RBX: 0000000000109c1f RCX: 0000000000000003
[    1.105561] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
[    1.107204] RBP: 0000000109c1f121 R08: 0000000000000000 R09: ffffd02d405574c8
[    1.108503] R10: ffffffffa70b43a8 R11: 0000000000000003 R12: 0000000000000001
[    1.109816] R13: 0000000109c1f121 R14: 0000000000000001 R15: ffffffffc0477000
[    1.111556] FS:  00007fcf08a6b980(0000) GS:ffff88c4bf680000(0000) knlGS:0000000000000000
[    1.112888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.114279] CR2: 000055cf7979a138 CR3: 000000014061e006 CR4: 0000000000f70ef0
[    1.115600] PKRU: 55555554
[    1.116935] Call Trace:
[    1.118345]  <TASK>
[    1.119677]  ? __purge_vmap_area_lazy+0x13c/0x320
[    1.120979]  ? _vm_unmap_aliases+0x217/0x260
[    1.122392]  change_page_attr_set_clr+0x104/0x1a0
[    1.123702]  set_memory_rw+0x28/0x40
[    1.125019]  apply_retpolines+0x19c/0x4c0
[    1.126404]  module_finalize+0x209/0x3e0
[    1.127690]  ? add_kallsyms+0x293/0x310
[    1.128985]  load_module+0x17f1/0x1e90
[    1.130318]  ? init_module_from_file+0x89/0xe0
[    1.131586]  init_module_from_file+0x89/0xe0
[    1.132873]  idempotent_init_module+0x11e/0x310
[    1.134175]  __x64_sys_finit_module+0x5e/0xb0
[    1.135433]  do_syscall_64+0x87/0x1b0
[    1.136706]  ? vfs_read+0x24d/0x370
[    1.137967]  ? __x64_sys_pread64+0x98/0xd0
[    1.139652]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
[    1.140905]  ? syscall_exit_to_user_mode+0x37/0x1b0
[    1.142172]  ? do_syscall_64+0x93/0x1b0
[    1.143402]  ? __count_memcg_events+0x53/0xf0
[    1.144644]  ? count_memcg_events.constprop.0+0x1a/0x30
[    1.145859]  ? handle_mm_fault+0x1bb/0x2c0
[    1.147452]  ? do_user_addr_fault+0x367/0x650
[    1.148626]  ? clear_bhb_loop+0x70/0xc0
[    1.149809]  ? clear_bhb_loop+0x70/0xc0
[    1.151303]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.152445] RIP: 0033:0x7fcf095cf4f9
[    1.153586] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 68 0d 00 f7 d8 64 89 01 48
[    1.155067] RSP: 002b:00007fffd10634a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    1.156238] RAX: ffffffffffffffda RBX: 000055cf79783110 RCX: 00007fcf095cf4f9
[    1.157419] RDX: 0000000000000004 RSI: 00007fcf07cf944d RDI: 0000000000000010
[    1.158766] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055cf79763ba0
[    1.159927] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcf07cf944d
[    1.161090] R13: 0000000000020000 R14: 000055cf79784bc0 R15: 0000000000000000
[    1.162318]  </TASK>
[    1.163460] ---[ end trace 0000000000000000 ]---
[    1.165584] cryptd: max_cpu_qlen set to 1000
[    1.206983] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    1.217701] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    1.218809] nvme nvme0: pci function 0000:04:00.0
[    1.246023] ACPI: bus type drm_connector registered
[    1.273161] nvme nvme0: 8/0/0 default/read/poll queues
[    1.277998]  nvme0n1: p1 p2 p3
[    1.297556] AES CTR mode by8 optimization enabled
[    1.470234] psmouse serio1: trackpoint: Elan TrackPoint firmware: 0x92, buttons: 3/3
[    1.484408] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/serio1/input/input2
[    1.740431] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    1.741515] i915 0000:00:02.0: [drm] Found TIGERLAKE/UY (device ID 9a49) display version 12.00 stepping C0
[    1.743154] Console: switching to colour dummy device 80x25
[    1.743182] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.743224] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.743660] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=mem
[    1.744289] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_12.bin (v2.12)
[    1.761388] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    1.761509] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[    1.777905] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[    1.780477] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.780600] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    1.798474] fbcon: i915drmfb (fb0) is primary device
[    1.827041] Console: switching to colour frame buffer device 240x75
[    1.846441] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.361839] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    2.361872] device-mapper: uevent: version 1.0.3
[    2.361944] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    7.054620] Lockdown: resume: hibernation is restricted; see man kernel_lockdown.7
[    7.197884] EXT4-fs (dm-1): mounted filesystem 0fb5bb25-d0f6-48a2-9840-a6cdefe4c6ce ro with ordered data mode. Quota mode: none.
[    7.231623] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[    7.273251] systemd[1]: Inserted module 'autofs4'
[    7.402383] systemd[1]: systemd 257.13-1~deb13u1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    7.404272] systemd[1]: Detected architecture x86-64.
[    7.405856] systemd[1]: Hostname set to <arabella>.
[    7.406767] Lockdown: systemd: /dev/mem,kmem,port is restricted; see man kernel_lockdown.7
[    7.561974] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.656348] systemd[1]: Queued start job for default target graphical.target.
[    7.699616] systemd[1]: Created slice machine.slice - Virtual Machine and Container Slice.
[    7.702975] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[    7.707380] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    7.712403] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[    7.717190] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[    7.720882] systemd[1]: Created slice user.slice - User and Session Slice.
[    7.723658] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    7.726770] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[    7.729470] systemd[1]: Expecting device dev-disk-by\x2duuid-16D4\x2dF1FA.device - /dev/disk/by-uuid/16D4-F1FA...
[    7.732354] systemd[1]: Expecting device dev-disk-by\x2duuid-77b93a3f\x2d987a\x2d4ed2\x2d9bd4\x2d68516dfad6dd.device - /dev/disk/by-uuid/77b93a3f-987a-4ed2-9bd4-68516dfad6dd...
[    7.733704] systemd[1]: Expecting device dev-disk-by\x2duuid-9e2dc7e8\x2d7b9e\x2d49cd\x2db100\x2d9bcdd698307d.device - /dev/disk/by-uuid/9e2dc7e8-7b9e-49cd-b100-9bcdd698307d...
[    7.736667] systemd[1]: Expecting device dev-mapper-arabella\x2d\x2dvg\x2dswap_1.device - /dev/mapper/arabella--vg-swap_1...
[    7.738093] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[    7.739646] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[    7.741140] systemd[1]: Reached target slices.target - Slice Units.
[    7.744282] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[    7.746991] systemd[1]: Reached target virt-guest-shutdown.target - libvirt guests shutdown target.
[    7.748469] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[    7.751605] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[    7.780184] systemd[1]: Listening on rpcbind.socket - RPCbind Server Activation Socket.
[    7.782643] systemd[1]: Listening on syslog.socket - Syslog Socket.
[    7.786582] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[    7.788393] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[    7.791660] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    7.794817] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[    7.797844] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    7.797856] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    7.797920] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    7.803643] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    7.807663] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    7.810170] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    7.812592] systemd[1]: run-lock.mount: Directory /run/lock to mount over is not empty, mounting anyway.
[    7.813107] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
[    7.818753] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    7.821783] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    7.824315] systemd[1]: auth-rpcgss-module.service - Kernel Module supporting RPCSEC_GSS skipped, unmet condition check ConditionPathExists=/etc/krb5.keytab
[    7.825087] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[    7.829091] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    7.832173] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.837279] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    7.840764] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[    7.844261] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[    7.847415] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    7.849824] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[    7.853906] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[    7.856032] systemd[1]: systemd-fsck-root.service - File System Check on Root Device skipped, unmet condition check ConditionPathExists=!/run/initramfs/fsck-root
[    7.856064] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    7.856991] systemd[1]: Starting systemd-journald.service - Journal Service...
[    7.862880] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    7.864282] pstore: Using crash dump compression: deflate
[    7.884735] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    7.889528] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[    7.910987] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    7.911017] systemd-journald[839]: Collecting audit messages is disabled.
[    7.914887] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[    7.915770] loop: module loaded
[    7.918306] pstore: Registered efi_pstore as persistent store backend
[    7.925020] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    7.928375] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[    7.929973] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[    7.932915] systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
[    7.935718] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[    7.937697] lp: driver loaded but no devices found
[    7.940227] systemd[1]: Started systemd-journald.service - Journal Service.
[    7.943628] EXT4-fs (dm-1): re-mounted 0fb5bb25-d0f6-48a2-9840-a6cdefe4c6ce r/w.
[    7.949550] ppdev: user-space parallel port driver
[    7.971053] i2c_dev: i2c /dev entries driver
[    7.984751] systemd-journald[839]: Received client request to flush runtime journal.
[    8.131182] Adding 999420k swap on /dev/mapper/arabella--vg-swap_1.  Priority:-2 extents:1 across:999420k SS
[    8.190699] hid: raw HID events driver (C) Jiri Kosina
[    8.215562] input: Intel HID events as /devices/platform/INTC1051:00/input/input4
[    8.215596] Consider using thermal netlink events interface
[    8.217152] ACPI: AC: AC Adapter [AC] (off-line)
[    8.221386] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input5
[    8.221487] ACPI: button: Sleep Button [SLPB]
[    8.221524] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input6
[    8.222656] ACPI: button: Lid Switch [LID]
[    8.223735] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input7
[    8.223803] ACPI: button: Power Button [PWRB]
[    8.235352] EDAC igen6: v2.5.1
[    8.242666] ACPI: battery: Slot [BAT0] (battery present)
[    8.275243] ACPI: bus type thunderbolt registered
[    8.275180] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    8.315243] ACPI: bus type USB registered
[    8.317456] usbcore: registered new interface driver usbfs
[    8.319755] usbcore: registered new interface driver hub
[    8.322042] usbcore: registered new device driver usb
[    8.339763] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    8.348884] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    8.350630] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.352359] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.372931] resource: resource sanity check: requesting [mem 0x00000000fedc0000-0x00000000fedcdfff], which spans more than pnp 00:04 [mem 0xfedc0000-0xfedc7fff]
[    8.372935] caller uncore_get_box_mmio_addr+0xe7/0x150 [intel_uncore] mapping multiple BARs
[    8.373199] intel_pmc_core INT33A1:00:  initialized
[    8.454257] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.455943] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
[    8.457343] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
[    8.458881] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.459029] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.466067] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    8.467325] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    8.556208] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.557375] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.558718] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.559840] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.559854] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.559867] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.559880] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    8.658290] Non-volatile memory driver v1.3
[    8.663339] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    8.664460] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    8.666443] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    8.667177] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    8.667180] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    8.667182] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.667215] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    8.667217] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.667218] usb usb1: Product: xHCI Host Controller
[    8.667219] usb usb1: Manufacturer: Linux 6.12.117+deb13-amd64 xhci-hcd
[    8.667220] usb usb1: SerialNumber: 0000:00:0d.0
[    8.667479] hub 1-0:1.0: USB hub found
[    8.667492] hub 1-0:1.0: 1 port detected
[    8.669030] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    8.680290] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.680291] usb usb2: Product: xHCI Host Controller
[    8.680292] usb usb2: Manufacturer: Linux 6.12.117+deb13-amd64 xhci-hcd
[    8.680292] usb usb2: SerialNumber: 0000:00:0d.0
[    8.680523] hub 2-0:1.0: USB hub found
[    8.685900] hub 2-0:1.0: 4 ports detected
[    8.687629] input: ELAN0672:00 04F3:3187 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input9
[    8.687715] input: ELAN0672:00 04F3:3187 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input11
[    8.687805] hid-generic 0018:04F3:3187.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0672:00 04F3:3187] on i2c-ELAN0672:00
[    8.701277] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    8.701284] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    8.702403] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    8.707037] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    8.707040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    8.707042] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.707089] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    8.707091] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.707092] usb usb3: Product: xHCI Host Controller
[    8.707094] usb usb3: Manufacturer: Linux 6.12.117+deb13-amd64 xhci-hcd
[    8.707095] usb usb3: SerialNumber: 0000:00:14.0
[    8.707249] hub 3-0:1.0: USB hub found
[    8.707291] hub 3-0:1.0: 12 ports detected
[    8.721600] iTCO_vendor_support: vendor-support=0
[    8.724223] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    8.724225] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.724226] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.724226] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.724227] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    8.733557] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    8.733560] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.733561] usb usb4: Product: xHCI Host Controller
[    8.733562] usb usb4: Manufacturer: Linux 6.12.117+deb13-amd64 xhci-hcd
[    8.733562] usb usb4: SerialNumber: 0000:00:14.0
[    8.733636] hub 4-0:1.0: USB hub found
[    8.733668] hub 4-0:1.0: 4 ports detected
[    8.737548] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    8.747247] thinkpad_acpi: http://ibm-acpi.sf.net/
[    8.747248] thinkpad_acpi: ThinkPad BIOS N32ETA2W (1.78 ), EC N32HT57W
[    8.747249] thinkpad_acpi: Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS1FU00
[    8.752413] intel_rapl_msr: PL4 support detected.
[    8.752445] intel_rapl_common: Found RAPL domain package
[    8.752447] intel_rapl_common: Found RAPL domain core
[    8.752448] intel_rapl_common: Found RAPL domain uncore
[    8.752450] intel_rapl_common: Found RAPL domain psys
[    8.752888] Intel(R) Wireless WiFi driver for Linux
[    8.753193] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    8.755978] thinkpad_acpi: radio switch found; radios are enabled
[    8.762403] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000302 wfpm id 0x80000000
[    8.762706] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    8.764445] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=0x351, rfid=0x10a100
[    8.765504] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    8.767190] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[    8.772106] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    8.773921] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.778354] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
[    8.778851] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.778924] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.778962] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[    8.778964] iwlwifi 0000:00:14.3: loaded firmware version 77.2753b721.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[    8.803836] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    8.824901] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    8.849424] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    8.855857] input: ELAN0672:00 04F3:3187 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input13
[    8.855938] input: ELAN0672:00 04F3:3187 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-15/i2c-ELAN0672:00/0018:04F3:3187.0001/input/input15
[    8.856002] hid-multitouch 0018:04F3:3187.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0672:00 04F3:3187] on i2c-ELAN0672:00
[    8.901477] intel_rapl_common: Found RAPL domain package
[    8.944747] thinkpad_acpi: secondary fan control detected & enabled
[    8.956498] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext4 subsystem
[    8.960141] EXT4-fs (nvme0n1p2): mounted filesystem 77b93a3f-987a-4ed2-9bd4-68516dfad6dd r/w without journal. Quota mode: none.
[    8.962525] thinkpad_acpi: battery 1 registered (start 0, stop 100, behaviours: 0x7)
[    8.962534] ACPI: battery: new extension: ThinkPad Battery Extension
[    8.978051] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    9.006505] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input12
[    9.092188] iwlwifi 0000:00:14.3: Detected RF HR B5, rfid=0x10a100
[    9.096361] audit: type=1400 audit(1794514179.744:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=1101 comm="apparmor_parser"
[    9.098975] audit: type=1400 audit(1794514179.744:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1105 comm="apparmor_parser"
[    9.100779] audit: type=1400 audit(1794514179.744:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1106 comm="apparmor_parser"
[    9.100782] audit: type=1400 audit(1794514179.744:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1102 comm="apparmor_parser"
[    9.100784] audit: type=1400 audit(1794514179.744:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1100 comm="apparmor_parser"
[    9.100785] audit: type=1400 audit(1794514179.744:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1103 comm="apparmor_parser"
[    9.100787] audit: type=1400 audit(1794514179.748:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1108 comm="apparmor_parser"
[    9.100790] audit: type=1400 audit(1794514179.748:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1107 comm="apparmor_parser"
[    9.101269] audit: type=1400 audit(1794514179.748:12): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=1111 comm="apparmor_parser"
[    9.113203] audit: type=1400 audit(1794514179.748:13): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1109 comm="apparmor_parser"
[    9.123395] usb 3-3: New USB device found, idVendor=06cb, idProduct=00fc, bcdDevice= 0.00
[    9.123400] usb 3-3: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    9.123402] usb 3-3: SerialNumber: d1150138a1b3
[    9.134207] typec port0: bound usb3-port5 (ops connector_ops [usbcore])
[    9.134237] typec port0: bound usb2-port2 (ops connector_ops [usbcore])
[    9.161359] iwlwifi 0000:00:14.3: base HW address: 4c:77:cb:65:98:07
[    9.221514] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[    9.249163] usb 3-4: new high-speed USB device number 3 using xhci_hcd
[    9.250155] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
[    9.252023] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    9.259351] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[    9.321077] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 5
[    9.321080] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
[    9.321082] sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4
[    9.321083] sof-audio-pci-intel-tgl 0000:00:1f.3: BT link detected in NHLT tables: 0x4
[    9.321084] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT tables: 4
[    9.328454] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware paths/files for ipc type 0:
[    9.328458] sof-audio-pci-intel-tgl 0000:00:1f.3:  Firmware file:     intel/sof/sof-tgl.ri
[    9.328460] sof-audio-pci-intel-tgl 0000:00:1f.3:  Topology file:     intel/sof-tplg/sof-hda-generic-4ch.tplg
[    9.328906] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    9.328908] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    9.328911] sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man header type 3 size 0x30
[    9.402805] usb 3-4: New USB device found, idVendor=174f, idProduct=2454, bcdDevice=10.29
[    9.404183] usb 3-4: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[    9.405699] usb 3-4: Product: Integrated Camera
[    9.407288] usb 3-4: Manufacturer: Sonix Technology Co., Ltd.
[    9.411128] nvme nvme0: using unchecked data buffer
[    9.439484] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    9.440714] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    9.493028] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:1
[    9.493217] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent card not yet available, widget card binding deferred
[    9.502985] block nvme0n1: No UUID available providing old NGUID
[    9.529240] snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC287: line_outs=2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    9.530274] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    9.531258] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    9.532225] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=0x0
[    9.533818] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[    9.533819] snd_hda_codec_realtek ehdaudio0D0:      Mic=0x19
[    9.558123] usb 3-10: new full-speed USB device number 4 using xhci_hcd
[    9.578629] NET: Registered PF_QIPCRTR protocol family
[    9.587938] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
[    9.617625] input: sof-hda-dsp Mic as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input16
[    9.617943] input: sof-hda-dsp Headphone as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input17
[    9.621646] input: sof-hda-dsp HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input18
[    9.621677] input: sof-hda-dsp HDMI/DP,pcm=4 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input19
[    9.621747] input: sof-hda-dsp HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input20
[    9.699946] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[    9.700831] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    9.725454] mc: Linux media interface: v0.10
[    9.761005] videodev: Linux video capture interface: v2.00
[    9.776400] Bluetooth: Core ver 2.22
[    9.777528] NET: Registered PF_BLUETOOTH protocol family
[    9.778610] Bluetooth: HCI device and connection manager initialized
[    9.780384] Bluetooth: HCI socket layer initialized
[    9.781369] Bluetooth: L2CAP socket layer initialized
[    9.781373] Bluetooth: SCO socket layer initialized
[    9.827148] usb 3-4: Found UVC 1.00 device Integrated Camera (174f:2454)
[    9.840110] usb 3-4: Found UVC 1.00 device Integrated Camera (174f:2454)
[    9.848856] usbcore: registered new interface driver btusb
[    9.849512] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[    9.851204] usbcore: registered new interface driver uvcvideo
[    9.854981] typec port1: bound usb3-port6 (ops connector_ops [usbcore])
[    9.855026] typec port1: bound usb2-port3 (ops connector_ops [usbcore])
[    9.857169] Bluetooth: hci0: Device revision is 2
[    9.857172] Bluetooth: hci0: Secure boot is enabled
[    9.857174] Bluetooth: hci0: OTP lock is enabled
[    9.857175] Bluetooth: hci0: API lock is enabled
[    9.857176] Bluetooth: hci0: Debug lock is disabled
[    9.857177] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    9.860979] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    9.875947] Bluetooth: hci0: Boot Address: 0x24800
[    9.875951] Bluetooth: hci0: Firmware Version: 132-3.24
[    9.877150] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0
[    9.939232] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.940436] Bluetooth: BNEP filters: protocol multicast
[    9.941288] Bluetooth: BNEP socket layer initialized
[   10.040264] RPC: Registered named UNIX socket transport module.
[   10.042504] RPC: Registered udp transport module.
[   10.043360] RPC: Registered tcp transport module.
[   10.044221] RPC: Registered tcp-with-tls transport module.
[   10.045603] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.190283] Bluetooth: hci0: Waiting for firmware download to complete
[   12.191109] Bluetooth: hci0: Firmware loaded in 2260998 usecs
[   12.192006] Bluetooth: hci0: Waiting for device to boot
[   12.206738] Bluetooth: hci0: Device booted in 14438 usecs
[   12.208533] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
[   12.211718] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.212755] Bluetooth: hci0: Firmware revision 0.4 build 132 week 3 2024
[   12.216670] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
[   12.281931] Bluetooth: MGMT ver 1.23
[   12.301181] NET: Registered PF_ALG protocol family
[   12.376215] Bluetooth: RFCOMM TTY layer initialized
[   12.377212] Bluetooth: RFCOMM socket layer initialized
[   12.378140] Bluetooth: RFCOMM ver 1.11

--wCGO9XF51TdiqsoM--
