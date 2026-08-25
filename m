Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5A312814
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672148; cv=none; b=Mk7Rf3IunNs/pL7Y8kmKQV/xntRHv5P99+pssthcPbaWVrhxX3+PY0RUw06SrmfDMyxY96nGXjQSuDgEgYLAZCnfmzsZ9xhiN7ELGmv6IjEft53m6z0+4+Me30mvChr50ZkMBAIlOKJ6Db5OedS2zgMb82NmU2K9mCmK4CR3nRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672148; c=relaxed/simple;
	bh=fCMSN1LH0i1GJohUvBBUgR5iHM0b3q8estCwhrnu1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGq+GWus8/Cq/lMYeLJHHnPpD98vyvluBLkTEAkYu1p8jBgTUMdwc9Lm6l2dQExLpEcqDsxQnpvrWMZ/wubLD22oxMFm4D5nxBVCajFc2vT+0Np0GUYzv0W7gNX0F3+Gxq4vrhudAqK3tCSR/v5wphyPj0181QZWfKQp4/elcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHB6O7ok; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHB6O7ok"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486672f03cso5107550b3a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672145; x=1788276945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IofUFaiDO4oKXBS+xII4EWxwjkrsS/FkpmbRWDywqnM=;
        b=fHB6O7okP8mi3rHVTsk2pNR1MaMN48267h7XGZF2JuXeZcQN1vf7Fq+lXQpxmPTubv
         r5i+p89vcPfZhv5VeVXO0G2lLQw8vA5NMVqhNLM04Kr8jmYcOndBajOj8ePGjxYdXBF0
         fRv2ZZrf4d45IYKach11G/+uIyPBS9tq3wsi8feg5DX8T65iinR3NTL64BhHZwFw+xYR
         /36YL8H8BuwbUffFUWeljNq6a0wSrD1Tb5s3TaNi4N6Kpy5Cjiprep1WuXg/Q06x9nPE
         DSgnqjnBH3PjQdUOz6PGFNfwh266uxmlyun1NkTh4HQG3zKcEfbP40dZzqfBzJOlHkPd
         Rx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672145; x=1788276945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IofUFaiDO4oKXBS+xII4EWxwjkrsS/FkpmbRWDywqnM=;
        b=i4wz9dAWzotWFZXy9IrvGxaPUTEhFuzQkoAdC4OOVBPzSde7Zw6NXQbGnCRFq2Cnsx
         M2NCLAdK1EUx55SfOe3/PkKHX9sEgnUcbgsMxO3AB1ZnSookY2B2NkSdsPCAnnbrmQ2s
         tOeUSdkdICTXlewdw7FLC8tGX4Lv96w1FPuxN4MB29DQDAhIuMapToY9FIsRB2Z6pFmX
         PQ2yNs/GOFmsGw9y1bIPaN2Mnf0CAsCznpy0vBXsTXQSJr3Pxni/+r8JBGhrCa11wfTk
         gemT+PB+kbBFF9Rzri69CX52raHwf9ADjugxDGDixASCJnufGduxqvlTGE6nh6iTMVSx
         wNKA==
X-Forwarded-Encrypted: i=1; AHgh+RpeBRpofvUrDzEp1Er8aLftYVOnUrtFAc1y0bhMivzoFAnRQaZaztZUdZT509CQezrh0OzY6kE=@vger.kernel.org
X-Gm-Message-State: AFuF++l+2N8DTNd4ORl0cn1FjTCFy8AXyakBVFVuMsabeZFIZLWm+/fs
	1SIgDVAUXBNEU44LSREk4qs3FyALKot9l1wfoW6v6GoxM//ULyHc7HFK
X-Gm-Gg: AR+sD12SxopCXm7TGa5INDd/UpfnyX55wfEOc+P6w41llwACgpcLtyi1bXVA7Azpc3h
	JtzA/DuHnJLx8LhhiIxHsU3HRQzhHeVGwGYQfOp9kRS7Z/FHMTqoils8wBmIkS6Og8tgQkRXYBi
	8fpBWaSHyK7XFWpCEO2NZ5LsCzIKz/+PdD6jlJnU0SXgwecpXMBvLvDwRCMDx6HSSbSBiotDNHS
	vhNsUcbx/Pohc7JYPl3zx1Rplo51A0256KZjbbjK2i4IS6Im2aywP4sfTzBXR1Ya4Ym7kkEPlmT
	daeytl+0CGOsB/ETOE14DF4hDt+ieCoy0QoqPoRvImp6L4/Jf6XqsCH5gR9ajYLw8lnLSgnW3Z0
	XPphX2kW3IfI8fkMAAB5tduMcQXgxkwxfNjm9Bqm7YTLVGHDBHJkTjBAxsAfnGSzZbmAKozieyk
	pbYPY/pHFMeGqeK1+dwraaMjX42QuYZQlCDEJ79yxChoGUznlNGs1OCU7Z7zXDfTdq7XqAt3x3w
	w==
X-Received: by 2002:a05:6a00:4387:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-8520ba55ce3mr52650742b3a.13.1787672144683;
        Tue, 25 Aug 2026 08:35:44 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d345ecesm16431b3a.59.2026.08.25.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:35:35 -0700 (PDT)
Date: Tue, 25 Aug 2026 21:05:33 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, tony.luck@intel.com,
	bp@alien8.de, linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3] cxl/mce: Avoid alias page retirement for corrected
 errors
Message-ID: <ao22Razi0oL3_3Vq@acer-nitro-anv15-41>
References: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
 <aoy6VWVLWcaqHiWQ@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoy6VWVLWcaqHiWQ@aschofie-mobl2.lan>

On Mon, Aug 24, 2026 at 02:40:37PM -0700, Alison Schofield wrote:
> On Mon, Aug 24, 2026 at 07:19:57PM +0530, Shaikh Kamaluddin wrote:
> > cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> > (ELC) region for any MCE with a usable address in the region. This
> > includes corrected errors, needlessly reducing usable memory.
> > 
> > Skip ELC alias retirement when mce_is_correctable() identifies the
> > reported error as corrected. Uncorrected errors with a usable address
> > in the ELC region continue to retire the aliased page as before.
> > 
> > mce_usable_address() already implements the per-vendor checks that
> > determine whether the reported address is usable, so no separate
> > memory-error classification is needed.
> > 
> > On AMD, a corrected legacy bank 4 DRAM ECC error (XEC 8) reports a
> > usable address and retired the aliased page before this change.
> > Tested under QEMU with Intel Skylake-Server and AMD EPYC-Milan models.
> > 
> > Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> To be complete, I'm not retesting since v2, so not offering my
> testing tag here. I have confidence in your thorough testing!
> 
> -- Alison
> 

Hi Alison,

Thank you for reviewing the patch.

I completely understand regarding the testing tag. Your earlier testing
and feedback were very helpful, and I appreciate your confidence in my
additional testing across both the Intel and AMD paths.

Thanks again for your time and support.

Regards,
Kamal

> 
> > ---
> > Changelog:
> > 
> > v2 -> v3:
> >  - Drop the mce_is_memory_error() gate added in v2. On AMD it rejects
> >    every non-UMC bank type, so poison-consumption records reported from
> >    Load/Store or Data Fabric banks never reached mce_usable_address(),
> >    which would have accepted them via MCA_STATUS[Poison]. (Sashiko)
> >  - mce_usable_address() already implements the complete per-vendor
> >    address-usability logic, so no separate memory-error classification
> >    is needed.
> >  - Add AMD test coverage (QEMU/TCG, EPYC-Milan) alongside the existing
> >    Intel results.
> > 
> > Link to v2: https://lore.kernel.org/linux-cxl/20260812151759.14390-1-shaikhkamal2012@gmail.com/
> > 
> > v1 -> v2:
> >   - Reworked commit message per review feedback
> >   - Dropped redundant comment from the code
> > 
> > Link to v1: https://lore.kernel.org/linux-cxl/20260810183013.47085-1-shaikhkamal2012@gmail.com/ 
> > 
> > Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> > extended-linear address_mode bit, so ELC was forced locally for testing
> > via a one-line debug hack in cxl_region_probe() (not part of this patch):
> > 
> > 	if (!p->cache_size && p->res)
> > 		p->cache_size = resource_size(p->res) / 2;
> > 
> > Steps:
> > 1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
> >     otherwise leak the host's real vendor ID, and AMD/SMCA takes a
> >     different mce_usable_address() path, covered in the section below):
> > 
> > vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> > 
> > 2. modprobe mce-inject
> > $ cxl list -M
> > $ cxl list -D
> > $ cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > $ dmesg | grep "DEBUG: forced cache_size"
> > $ modprobe device_dax
> > $ modprobe kmem
> > $ ls /sys/bus/dax/devices/
> > $ daxctl reconfigure-device dax0.0 --mode=system-ram
> > $ lsmem
> > RANGE                                  SIZE  STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> > 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> > 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> > 
> > Memory block size:       128M
> > Total online memory:     4.5G
> > Total offline memory:      0B
> > 
> > 3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.
> > 
> >    # modprobe mce-inject
> > 
> >     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
> >       bit 63  VAL     - record valid
> >       bit 61  UC      - uncorrected (0 = corrected error under test)
> >       bit 60  EN      - error reporting enabled
> >       bit 59  MISCV   - MCi_MISC valid
> >       bit 58  ADDRV   - MCi_ADDR valid
> >       bits[15:0] MCACOD - retained from the v2 test setup so the Intel
> >                           and AMD runs differ only in CPU model; not
> >                           consulted by this path.
> > 
> >     python3 -c "
> >     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
> >     MCACOD_MEM = 1<<7                
> >     ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
> >     uc = ce | UC
> >     print(f'CE status = {hex(ce)}')
> >     print(f'UC status = {hex(uc)}')"
> >     # CE status = 0x9c00000000000080
> >     # UC status = 0xbc00000000000080
> > 
> >     MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):
> > 
> >     python3 -c "print(hex(2 << 6))"
> >     # misc = 0x80
> > 
> > 4.  # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9C00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190010000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > ---------------------------------------
> > 
> > CE without this patch:
> >   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >   HardwareCorrupted: 4 kB
> > ------------------------------------- 
> > 
> > CE with this patch:
> >   (no "Offlining aliased SPA" message logged)
> >   HardwareCorrupted: 0 kB
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9C00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> > clocksource: Watchdog remote CPU 11 read timed out
> > 
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > --------------------------------------
> > 
> > For UC, same steps only status bit information will change :
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0xbc00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > # dmesg | grep cxl_mce_debug
> > #  grep HardwareCorrupted /proc/meminfo
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190010000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> > 
> > Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
> >     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >     HardwareCorrupted: 4 kB
> > -----------------------------------------------------------------------
> > 
> > AMD Platform Testing:
> > ---------------------
> > 
> > Note the vendor difference: on Intel, MISCV with MCi_MISC[8:6]=2 makes
> > any ADDRV record usable, so a plain CE is address-usable. On AMD an
> > address is usable only via poison, legacy bank-4 DRAM ECC, or PADDRV --
> > hence the differing usable= values for the same status word below.
> > 
> > 
> > vendor_id	: AuthenticAMD
> > model name	: AMD EPYC-Milan Processor
> > 
> > -------------------------------------
> > Mainline Kernel Without this patch:
> > -------------------------------------
> > 
> > vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> > 
> > # cxl list -M
> > # cxl list -D
> > # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > # dmesg | grep "DEBUG: forced cache_size"
> > # modprobe device_dax
> > # modprobe kmem
> > # daxctl reconfigure-device dax0.0 --mode=system-ram
> > 
> > # lsmem
> > RANGE                                  SIZE  STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> > 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> > 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> > 
> > Memory block size:       128M
> > Total online memory:     4.5G
> > Total offline memory:      0B
> > Load Injector
> > # modprobe mce-inject
> > --------------------------------------------------------------------------------
> > 
> > case1:
> > 
> > label              status           addr         bank   note
> > 
> > [LEGACY_B4_CE]  0x9c00000000080000  0x190070000   4     "case 3: bank4 XEC8 corrected+usable "[Before Patch]
> > ---------------------------------------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00000000080000 > status
> > # echo 0x80 > misc
> > # echo 0x190070000 > addr
> > # echo 4 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190070000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0070000 pfn=0x1a0070 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0070000
> > Memory failure: 0x1a0070: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> > mce: [Hardware Error]: TSC cbdf882d20 ADDR 190070000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479138 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > --------------------------------------------------------------------------------------------
> > 
> > case2:
> > label        status              addr         bank   note
> > 
> > [POISON]  0x9c00080000000080    0x190040000    9     "case 2: poison only (UC=0) - divergence to note"[Before Patch]
> > -----------------------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190040000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190040000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0040000 pfn=0x1a0040 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0040000
> > Memory failure: 0x1a0040: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> > mce: [Hardware Error]: TSC 17153949200 ADDR 190040000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479277 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     8 kB (cumulative added previous 4kb + 4kb this test)
> > -----------------------------------------------
> > 
> > AMD Platform Testing with applied patch:
> > ------------------------------------------
> > 
> > # cxl list -D
> > # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > # dmesg | grep "DEBUG: forced cache_size"
> > # modprobe device_dax
> > # modprobe kmem
> > # daxctl reconfigure-device dax0.0 --mode=system-ram
> > # lsmem
> > # modprobe mce-inject
> > ----------------------------------------------------
> > 
> > case1:
> > label              status           addr         bank   note
> > 
> > [ CE]          0x9c00000000000080    0x190010000   9     "case 1: corrected, no usable addr"
> > ----------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC 8e59f2f3bc0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454918 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------------------------------------
> > 
> > case2:
> > label              status           addr         bank   note
> > [ UC ]        0xbc00000000000080    0x190020000   9      "case 1: uncorrected, no poison -> unusable"
> > -------------------------------------------------------------------------------------------------
> > 
> > cd /sys/kernel/debug/mce-inject
> > echo sw > flags
> > echo 0xbc00000000000080 > status
> > echo 0x80 > misc
> > echo 0x190020000 > addr
> > echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > mce: [Hardware Error]: TSC 134d6de13240 ADDR 190020000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787460569 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------------------------------
> > 
> > case3:
> > label              status           addr         bank   note
> > 
> > [ POISON ]   0x9c00080000000080    0x190040000   9      "case 2: poison only (UC=0) - divergence to note"
> > ------------------------------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190040000 > addr
> > # echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> > mce: [Hardware Error]: TSC 14e29da617c0 ADDR 190040000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787463321 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > ------------------------------------------
> > 
> > case4:
> > label              status           addr         bank   note
> > 
> > [ DEFERRED ]  0x9c00100000000080    0x190020000   9     "case 1: deferred, no poison -> unusable"
> > ------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00100000000080 > status
> > # echo 0x80 > misc
> > #echo 0x190020000 > addr
> > #echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00100000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00100000000080
> > mce: [Hardware Error]: TSC 9a2d801ff40 ADDR 190020000 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787456818 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -----------------------------------------------
> > 
> > case5:
> > label              status            addr         bank    note
> > 
> > [ DEF_POISON ]  0x9c00180000000080    0x190060000   9      "case 2: deferred+poison - MUST be handled"
> > --------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00180000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190060000 > addr
> > # echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00180000000080 addr=0x190060000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190060000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0060000 pfn=0x1a0060 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0060000
> > Memory failure: 0x1a0060: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00180000000080
> > mce: [Hardware Error]: TSC a60fd45ae60 ADDR 190060000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457072 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > -----------------------------------
> > 
> > case6:
> > label              status           addr         bank   note
> > 
> > [UC_POISON]  0xbc00080000000080    0x190050000   9       "case 2: poison consumption - MUST be handled"
> > --------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0xbc00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190050000 > addr
> > # echo 9 > bank
> > 
> > Resul:
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00080000000080 addr=0x190050000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190050000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0050000 pfn=0x1a0050 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0050000
> > Memory failure: 0x1a0050: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00080000000080
> > mce: [Hardware Error]: TSC f03abeed540 ADDR 190050000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457328 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > -------------------------------------------------------------------------------------
> > 
> > case7:
> > label              status                   addr         bank    note
> > 
> > [B4_NONMEM_POISON]   0x9c00080000000080    0x190080000   4       "case 3 override: bank4 non-mem, poison ignored"
> > -------------------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00080000000080  > status
> > # echo 0x80 > misc
> > # echo 0x190080000 > addr
> > # echo 4 > bank
> > 
> > Result:
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190080000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00080000000080
> > mce: [Hardware Error]: TSC 21c66cecf80 ADDR 190080000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454082 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > --------------------------------------------------------------------------------------------
> > 
> > case8:
> > label              status               addr         bank     note
> > 
> > [LEGACY_B4_CE]   0x9c00000000080000    0x190070000   4        "case 3: bank4 XEC8 corrected+usable - THE FIX"
> > -------------------------------------------------------------------------------------------------------------------
> > 
> > echo sw > flags
> > echo 0x9c00000000080000 > status
> > echo 0x80 > misc
> > echo 0x190070000 > addr
> > echo 4 > bank
> > 
> > result:
> > -------
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> > mce: [Hardware Error]: TSC 3610305ed80 ADDR 190070000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454482 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------
> > 
> > Note: an AMD record with MCI_STATUS_POISON set but UC and Deferred
> > clear is filtered by this patch where it previously was not. Per AMD64
> > APM 24593 Rev 3.45, when UC is clear the error class is determined
> > solely by the Deferred bit, and Poison qualifies an uncorrected error
> > rather than establishing one. Real poison is therefore always reported
> > with Deferred set (not yet consumed) or UC set (consumed via #MC), and
> > both of those cases still retire the alias. Poison with UC and Deferred
> > both clear is not a valid encoding and appears only under software
> > injection.
> > 
> >  drivers/cxl/core/mce.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> > index 65fed913b221..3ac6802e750d 100644
> > --- a/drivers/cxl/core/mce.c
> > +++ b/drivers/cxl/core/mce.c
> > @@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> >  	u64 spa, spa_alias;
> >  	unsigned long pfn;
> >  
> > -	if (!mce || !mce_usable_address(mce))
> > +	if (!mce)
> > +		return NOTIFY_DONE;
> > +
> > +	if (mce_is_correctable(mce))
> > +		return NOTIFY_DONE;
> > +
> > +	if (!mce_usable_address(mce))
> >  		return NOTIFY_DONE;
> >  
> >  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > -- 
> > 2.43.0
> > 
