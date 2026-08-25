Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312443955F5;
	Tue, 25 Aug 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672350; cv=none; b=tMnYOzl6QK55aWVu+0PLV48WC14tEeCrmUDtNzy0hNFzDhujv7n7U8oLQKHag/pexxmgPkIR5I+P7MxfjThnWaYiEgGTLaq8C6cqjnGi5skHW4XYhP0da+yJ+YSonJhyEDpDBek1msZl0bW1BuWG9w+eJxgaxFusvtCl5DSJUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672350; c=relaxed/simple;
	bh=ssF6QipYXD+t9B9Wm2VXopKj8KPXzYeeOFWRgGoQrUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW9YOd811xE0MkMebjJegN0R7JiY463VJHK7ifyLK+aNQgehX0KSmFuvwqDjR9bcFZ+KP2Wv6fDcZEnIwVWLs2fXgVC4elujm4v9lQTjTVml0A0NZwY+qXIY9yFPVlOepwEXxVgIccgmrSElE0GiGU0lr+kmEKt6p1eRcoIFh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJnmsb9p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJnmsb9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787672348; x=1819208348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ssF6QipYXD+t9B9Wm2VXopKj8KPXzYeeOFWRgGoQrUY=;
  b=lJnmsb9pOcopRTCpn9OAK6hKaEUUe3p32d84nlindZ+Q/X8WCzrDVehG
   b3n8QNrnhoYecApLOQWK9NBRdGxTvTFJ+7/tlOS4264OQOf7j6qdKiYFX
   qJlell/27juT6OHp3qwAriqXyU3MH05Zgp4TArErq/Ef0aowA+siqIqnt
   GbdHskg7WW83hihSSZ598Hz8w9XdVAUdTup64PMy8wQb0hefzsGYn8xqQ
   bD2+dJP23rs9TgrO3mPQcprday6paVP2AWtRKfVDKZ/M/JZ3wJm1bddEh
   LJfkJonFuX3bB4TIywTA5L1BlqGSzqc7VfZcyROXrUeyoSezf41+fqsUJ
   w==;
X-CSE-ConnectionGUID: qwQIlGX4Tq+YtAo+U21Vyw==
X-CSE-MsgGUID: a15x3cmdSp61OlCvRybL/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88198085"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88198085"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:39:07 -0700
X-CSE-ConnectionGUID: hmKXf7nmTbuzYSpAClWiRQ==
X-CSE-MsgGUID: 0JgGNjPJTjKb/+Uiqe79mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="290848117"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:39:06 -0700
Message-ID: <3dea64d2-7a81-4ab4-8d25-c673c58b3169@intel.com>
Date: Tue, 25 Aug 2026 08:39:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/mce: Avoid alias page retirement for corrected
 errors
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org
References: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 6:49 AM, Shaikh Kamaluddin wrote:
> cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> (ELC) region for any MCE with a usable address in the region. This
> includes corrected errors, needlessly reducing usable memory.
> 
> Skip ELC alias retirement when mce_is_correctable() identifies the
> reported error as corrected. Uncorrected errors with a usable address
> in the ELC region continue to retire the aliased page as before.
> 
> mce_usable_address() already implements the per-vendor checks that
> determine whether the reported address is usable, so no separate
> memory-error classification is needed.
> 
> On AMD, a corrected legacy bank 4 DRAM ECC error (XEC 8) reports a
> usable address and retired the aliased page before this change.
> Tested under QEMU with Intel Skylake-Server and AMD EPYC-Milan models.
> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> Changelog:
> 
> v2 -> v3:
>  - Drop the mce_is_memory_error() gate added in v2. On AMD it rejects
>    every non-UMC bank type, so poison-consumption records reported from
>    Load/Store or Data Fabric banks never reached mce_usable_address(),
>    which would have accepted them via MCA_STATUS[Poison]. (Sashiko)
>  - mce_usable_address() already implements the complete per-vendor
>    address-usability logic, so no separate memory-error classification
>    is needed.
>  - Add AMD test coverage (QEMU/TCG, EPYC-Milan) alongside the existing
>    Intel results.
> 
> Link to v2: https://lore.kernel.org/linux-cxl/20260812151759.14390-1-shaikhkamal2012@gmail.com/
> 
> v1 -> v2:
>   - Reworked commit message per review feedback
>   - Dropped redundant comment from the code
> 
> Link to v1: https://lore.kernel.org/linux-cxl/20260810183013.47085-1-shaikhkamal2012@gmail.com/ 
> 
> Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> extended-linear address_mode bit, so ELC was forced locally for testing
> via a one-line debug hack in cxl_region_probe() (not part of this patch):
> 
> 	if (!p->cache_size && p->res)
> 		p->cache_size = resource_size(p->res) / 2;
> 
> Steps:
> 1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
>     otherwise leak the host's real vendor ID, and AMD/SMCA takes a
>     different mce_usable_address() path, covered in the section below):
> 
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> 2. modprobe mce-inject
> $ cxl list -M
> $ cxl list -D
> $ cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> $ dmesg | grep "DEBUG: forced cache_size"
> $ modprobe device_dax
> $ modprobe kmem
> $ ls /sys/bus/dax/devices/
> $ daxctl reconfigure-device dax0.0 --mode=system-ram
> $ lsmem
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> 
> Memory block size:       128M
> Total online memory:     4.5G
> Total offline memory:      0B
> 
> 3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.
> 
>    # modprobe mce-inject
> 
>     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
>       bit 63  VAL     - record valid
>       bit 61  UC      - uncorrected (0 = corrected error under test)
>       bit 60  EN      - error reporting enabled
>       bit 59  MISCV   - MCi_MISC valid
>       bit 58  ADDRV   - MCi_ADDR valid
>       bits[15:0] MCACOD - retained from the v2 test setup so the Intel
>                           and AMD runs differ only in CPU model; not
>                           consulted by this path.
> 
>     python3 -c "
>     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
>     MCACOD_MEM = 1<<7                
>     ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
>     uc = ce | UC
>     print(f'CE status = {hex(ce)}')
>     print(f'UC status = {hex(uc)}')"
>     # CE status = 0x9c00000000000080
>     # UC status = 0xbc00000000000080
> 
>     MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):
> 
>     python3 -c "print(hex(2 << 6))"
>     # misc = 0x80
> 
> 4.  # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9C00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190010000 contains=1
> cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> ---------------------------------------
> 
> CE without this patch:
>   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>   HardwareCorrupted: 4 kB
> ------------------------------------- 
> 
> CE with this patch:
>   (no "Offlining aliased SPA" message logged)
>   HardwareCorrupted: 0 kB
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9C00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> clocksource: Watchdog remote CPU 11 read timed out
> 
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> --------------------------------------
> 
> For UC, same steps only status bit information will change :
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0xbc00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> # dmesg | grep cxl_mce_debug
> #  grep HardwareCorrupted /proc/meminfo
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190010000 contains=1
> cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> 
> Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
>     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>     HardwareCorrupted: 4 kB
> -----------------------------------------------------------------------
> 
> AMD Platform Testing:
> ---------------------
> 
> Note the vendor difference: on Intel, MISCV with MCi_MISC[8:6]=2 makes
> any ADDRV record usable, so a plain CE is address-usable. On AMD an
> address is usable only via poison, legacy bank-4 DRAM ECC, or PADDRV --
> hence the differing usable= values for the same status word below.
> 
> 
> vendor_id	: AuthenticAMD
> model name	: AMD EPYC-Milan Processor
> 
> -------------------------------------
> Mainline Kernel Without this patch:
> -------------------------------------
> 
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> # cxl list -M
> # cxl list -D
> # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> # dmesg | grep "DEBUG: forced cache_size"
> # modprobe device_dax
> # modprobe kmem
> # daxctl reconfigure-device dax0.0 --mode=system-ram
> 
> # lsmem
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> 
> Memory block size:       128M
> Total online memory:     4.5G
> Total offline memory:      0B
> Load Injector
> # modprobe mce-inject
> --------------------------------------------------------------------------------
> 
> case1:
> 
> label              status           addr         bank   note
> 
> [LEGACY_B4_CE]  0x9c00000000080000  0x190070000   4     "case 3: bank4 XEC8 corrected+usable "[Before Patch]
> ---------------------------------------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00000000080000 > status
> # echo 0x80 > misc
> # echo 0x190070000 > addr
> # echo 4 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190070000 contains=1
> cxl_mce_debug: spa_alias=0x1a0070000 pfn=0x1a0070 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0070000
> Memory failure: 0x1a0070: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> mce: [Hardware Error]: TSC cbdf882d20 ADDR 190070000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479138 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> --------------------------------------------------------------------------------------------
> 
> case2:
> label        status              addr         bank   note
> 
> [POISON]  0x9c00080000000080    0x190040000    9     "case 2: poison only (UC=0) - divergence to note"[Before Patch]
> -----------------------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190040000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190040000 contains=1
> cxl_mce_debug: spa_alias=0x1a0040000 pfn=0x1a0040 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0040000
> Memory failure: 0x1a0040: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> mce: [Hardware Error]: TSC 17153949200 ADDR 190040000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479277 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     8 kB (cumulative added previous 4kb + 4kb this test)
> -----------------------------------------------
> 
> AMD Platform Testing with applied patch:
> ------------------------------------------
> 
> # cxl list -D
> # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> # dmesg | grep "DEBUG: forced cache_size"
> # modprobe device_dax
> # modprobe kmem
> # daxctl reconfigure-device dax0.0 --mode=system-ram
> # lsmem
> # modprobe mce-inject
> ----------------------------------------------------
> 
> case1:
> label              status           addr         bank   note
> 
> [ CE]          0x9c00000000000080    0x190010000   9     "case 1: corrected, no usable addr"
> ----------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC 8e59f2f3bc0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454918 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------------------------------------
> 
> case2:
> label              status           addr         bank   note
> [ UC ]        0xbc00000000000080    0x190020000   9      "case 1: uncorrected, no poison -> unusable"
> -------------------------------------------------------------------------------------------------
> 
> cd /sys/kernel/debug/mce-inject
> echo sw > flags
> echo 0xbc00000000000080 > status
> echo 0x80 > misc
> echo 0x190020000 > addr
> echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> mce: [Hardware Error]: TSC 134d6de13240 ADDR 190020000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787460569 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------------------------------
> 
> case3:
> label              status           addr         bank   note
> 
> [ POISON ]   0x9c00080000000080    0x190040000   9      "case 2: poison only (UC=0) - divergence to note"
> ------------------------------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190040000 > addr
> # echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> mce: [Hardware Error]: TSC 14e29da617c0 ADDR 190040000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787463321 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> ------------------------------------------
> 
> case4:
> label              status           addr         bank   note
> 
> [ DEFERRED ]  0x9c00100000000080    0x190020000   9     "case 1: deferred, no poison -> unusable"
> ------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00100000000080 > status
> # echo 0x80 > misc
> #echo 0x190020000 > addr
> #echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00100000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00100000000080
> mce: [Hardware Error]: TSC 9a2d801ff40 ADDR 190020000 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787456818 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -----------------------------------------------
> 
> case5:
> label              status            addr         bank    note
> 
> [ DEF_POISON ]  0x9c00180000000080    0x190060000   9      "case 2: deferred+poison - MUST be handled"
> --------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00180000000080 > status
> # echo 0x80 > misc
> # echo 0x190060000 > addr
> # echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00180000000080 addr=0x190060000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190060000 contains=1
> cxl_mce_debug: spa_alias=0x1a0060000 pfn=0x1a0060 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0060000
> Memory failure: 0x1a0060: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00180000000080
> mce: [Hardware Error]: TSC a60fd45ae60 ADDR 190060000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457072 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> -----------------------------------
> 
> case6:
> label              status           addr         bank   note
> 
> [UC_POISON]  0xbc00080000000080    0x190050000   9       "case 2: poison consumption - MUST be handled"
> --------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0xbc00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190050000 > addr
> # echo 9 > bank
> 
> Resul:
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00080000000080 addr=0x190050000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190050000 contains=1
> cxl_mce_debug: spa_alias=0x1a0050000 pfn=0x1a0050 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0050000
> Memory failure: 0x1a0050: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00080000000080
> mce: [Hardware Error]: TSC f03abeed540 ADDR 190050000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457328 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> -------------------------------------------------------------------------------------
> 
> case7:
> label              status                   addr         bank    note
> 
> [B4_NONMEM_POISON]   0x9c00080000000080    0x190080000   4       "case 3 override: bank4 non-mem, poison ignored"
> -------------------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00080000000080  > status
> # echo 0x80 > misc
> # echo 0x190080000 > addr
> # echo 4 > bank
> 
> Result:
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190080000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00080000000080
> mce: [Hardware Error]: TSC 21c66cecf80 ADDR 190080000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454082 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> --------------------------------------------------------------------------------------------
> 
> case8:
> label              status               addr         bank     note
> 
> [LEGACY_B4_CE]   0x9c00000000080000    0x190070000   4        "case 3: bank4 XEC8 corrected+usable - THE FIX"
> -------------------------------------------------------------------------------------------------------------------
> 
> echo sw > flags
> echo 0x9c00000000080000 > status
> echo 0x80 > misc
> echo 0x190070000 > addr
> echo 4 > bank
> 
> result:
> -------
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> mce: [Hardware Error]: TSC 3610305ed80 ADDR 190070000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454482 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------
> 
> Note: an AMD record with MCI_STATUS_POISON set but UC and Deferred
> clear is filtered by this patch where it previously was not. Per AMD64
> APM 24593 Rev 3.45, when UC is clear the error class is determined
> solely by the Deferred bit, and Poison qualifies an uncorrected error
> rather than establishing one. Real poison is therefore always reported
> with Deferred set (not yet consumed) or UC set (consumed via #MC), and
> both of those cases still retire the alias. Poison with UC and Deferred
> both clear is not a valid encoding and appears only under software
> injection.
> 
>  drivers/cxl/core/mce.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b221..3ac6802e750d 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>  	u64 spa, spa_alias;
>  	unsigned long pfn;
>  
> -	if (!mce || !mce_usable_address(mce))
> +	if (!mce)
> +		return NOTIFY_DONE;
> +
> +	if (mce_is_correctable(mce))
> +		return NOTIFY_DONE;
> +
> +	if (!mce_usable_address(mce))
>  		return NOTIFY_DONE;
>  
>  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

